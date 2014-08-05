From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 04/29] drivers: base: add notifier for failed driver bind
Date: Tue, 05 Aug 2014 12:47:32 +0200
Message-ID: <1407235677-26324-5-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Figa <tomasz.figa@gmail.com>, linaro-mm-sig@lists.linaro.org, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Olof Johansson <olof@lixom.net>, Cho KyongHo <pullip.cho@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds support for getting a notify for failed device driver
bind, so all the items done in BUS_NOTIFY_BIND_DRIVER event can be
cleaned if the driver fails to bind.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/base/dd.c      | 10 +++++++---
 include/linux/device.h |  4 +++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index e4ffbcf..541a41f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -237,10 +237,14 @@ static int driver_sysfs_add(struct device *dev)
 	return ret;
 }
 
-static void driver_sysfs_remove(struct device *dev)
+static void driver_sysfs_remove(struct device *dev, int failed)
 {
 	struct device_driver *drv = dev->driver;
 
+	if (failed && dev->bus)
+		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
+					     BUS_NOTIFY_DRVBIND_FAILED, dev);
+
 	if (drv) {
 		sysfs_remove_link(&drv->p->kobj, kobject_name(&dev->kobj));
 		sysfs_remove_link(&dev->kobj, "driver");
@@ -316,7 +320,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 
 probe_failed:
 	devres_release_all(dev);
-	driver_sysfs_remove(dev);
+	driver_sysfs_remove(dev, true);
 	dev->driver = NULL;
 	dev_set_drvdata(dev, NULL);
 
@@ -509,7 +513,7 @@ static void __device_release_driver(struct device *dev)
 	if (drv) {
 		pm_runtime_get_sync(dev);
 
-		driver_sysfs_remove(dev);
+		driver_sysfs_remove(dev, false);
 
 		if (dev->bus)
 			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
diff --git a/include/linux/device.h b/include/linux/device.h
index b387710..92daded 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -176,7 +176,7 @@ extern int bus_register_notifier(struct bus_type *bus,
 extern int bus_unregister_notifier(struct bus_type *bus,
 				   struct notifier_block *nb);
 
-/* All 4 notifers below get called with the target struct device *
+/* All 7 notifers below get called with the target struct device *
  * as an argument. Note that those functions are likely to be called
  * with the device lock held in the core, so be careful.
  */
@@ -189,6 +189,8 @@ extern int bus_unregister_notifier(struct bus_type *bus,
 						      unbound */
 #define BUS_NOTIFY_UNBOUND_DRIVER	0x00000006 /* driver is unbound
 						      from the device */
+#define BUS_NOTIFY_DRVBIND_FAILED	0x00000007 /* driver failed to bind
+						      to device */
 
 extern struct kset *bus_get_kset(struct bus_type *bus);
 extern struct klist *bus_get_device_klist(struct bus_type *bus);
-- 
1.9.2
