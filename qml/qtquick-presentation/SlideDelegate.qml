/*
 *   Copyright (C) 2013 Daniel Vrátil <dan@progdan.cz>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License along
 *   with this program; if not, write to the Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

import QtQuick 2.0

Item {
    id: root;

    property string sourceFile;

    property Component component;
    property Slide slide;

    onSourceFileChanged: {
        component = Qt.createComponent(sourceFile);
        if (component.status === Component.Error) {
            console.debug("Failed to load " + sourceFile + ": " + component.errorString());
            return;
        } else if (component.status == Component.Loading) {
            component.statusChanged.connect(createItem);
        } else {
            createItem();
        }
    }

    function createItem()
    {
        // Instantiate the component
        var incubator = component.incubateObject(root);
        if (incubator.status != Component.Ready) {
            incubator.onStatusChanged = function(status) {
                if (incubator.status == Component.Ready) {
                    placeSlide(incubator.object);
                }
            }
        } else {
            placeSlide(incubator.object);
        }
    }

    function placeSlide(obj)
    {
        slide = obj;
        slide.anchors.fill = root;
        console.log("Instance of " + sourceFile + " constructed");
    }

    Component.onDestruction: {
        if (sourceFile !== "") {
            console.log("Instance of " + sourceFile + " destroyed");
        }
    }
}
