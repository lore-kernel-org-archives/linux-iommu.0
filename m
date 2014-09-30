From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] driver core: Add BUS_NOTIFY_REMOVED_DEVICE event
Date: Tue, 30 Sep 2014 13:02:02 +0200
Message-ID: <1412074923-6342-2-git-send-email-joro@8bytes.org>
References: <1412074923-6342-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1412074923-6342-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This event closes an important gap in the bus notifiers.
There is already the BUS_NOTIFY_DEL_DEVICE event, but that
is sent when the device is still bound to its device driver.

This is too early for the IOMMU code to destroy any mappings
for the device, as they might still be in use by the driver.

The new BUS_NOTIFY_REMOVED_DEVICE event introduced with this
patch closes this gap as it is sent when the device is
already unbound from its device driver and almost completly
removed from the driver core.

With this event the IOMMU code can safely destroy any
mappings and other data structures when a device is removed.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/base/core.c    |  3 +++
 include/linux/device.h | 11 ++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 20da3ad..7b270a2 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1211,6 +1211,9 @@ void device_del(struct device *dev)
 	 */
 	if (platform_notify_remove)
 		platform_notify_remove(dev);
+	if (dev->bus)
+		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
+					     BUS_NOTIFY_REMOVED_DEVICE, dev);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	cleanup_device_parent(dev);
 	kobject_del(&dev->kobj);
diff --git a/include/linux/device.h b/include/linux/device.h
index 43d183a..d0d5c5d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -181,13 +181,14 @@ extern int bus_unregister_notifier(struct bus_type *bus,
  * with the device lock held in the core, so be careful.
  */
 #define BUS_NOTIFY_ADD_DEVICE		0x00000001 /* device added */
-#define BUS_NOTIFY_DEL_DEVICE		0x00000002 /* device removed */
-#define BUS_NOTIFY_BIND_DRIVER		0x00000003 /* driver about to be
+#define BUS_NOTIFY_DEL_DEVICE		0x00000002 /* device to be removed */
+#define BUS_NOTIFY_REMOVED_DEVICE	0x00000003 /* device removed */
+#define BUS_NOTIFY_BIND_DRIVER		0x00000004 /* driver about to be
 						      bound */
-#define BUS_NOTIFY_BOUND_DRIVER		0x00000004 /* driver bound to device */
-#define BUS_NOTIFY_UNBIND_DRIVER	0x00000005 /* driver about to be
+#define BUS_NOTIFY_BOUND_DRIVER		0x00000005 /* driver bound to device */
+#define BUS_NOTIFY_UNBIND_DRIVER	0x00000006 /* driver about to be
 						      unbound */
-#define BUS_NOTIFY_UNBOUND_DRIVER	0x00000006 /* driver is unbound
+#define BUS_NOTIFY_UNBOUND_DRIVER	0x00000007 /* driver is unbound
 						      from the device */
 
 extern struct kset *bus_get_kset(struct bus_type *bus);
-- 
1.9.1
