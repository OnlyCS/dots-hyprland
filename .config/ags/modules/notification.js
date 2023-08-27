const { Widget } = ags;
const { Notifications } = ags.Service;

export const ModuleNotification = props => Widget.Box({
    ...props,
    className: 'notification',
    children: [
        Widget.Label({
            className: 'txt-norm icon-material', label: 'notifications',
            connections: [[Notifications, icon => icon.visible = Notifications.popups.size > 0]],
        }),
        Widget.Label({
            connections: [[Notifications, label => {
                // notifications is a map, to get the last elememnt lets make an array
                label.label = Array.from(Notifications.popups)?.pop()?.[1].summary || '';
            }]],
        }),
    ],
});