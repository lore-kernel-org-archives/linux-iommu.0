From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv7 05/12] iommu/core: add ops->{bound,unbind}_driver()
Date: Thu, 12 Dec 2013 09:57:06 +0200
Message-ID: <1386835033-4701-6-git-send-email-hdoyu@nvidia.com>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1386835033-4701-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

ops->{bound,unbind}_driver() functions are called at
BUS_NOTIFY_{BOUND,UNBIND}_DRIVER respectively.

This is necessary to control the device population order. IOMMU master
devices depend on an IOMMU device instanciation. IOMMU master devices
can be registered to an IOMMU only after it's successfully
populated. This IOMMU registration is done via
ops->bound_driver(). Currently this population can be deferred if
depending IOMMU device hasn't yet been populated in driver core. This
cannot be done via ops->add_device() since after add_device() device's
population/instanciation can be still deferred via probe().

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
v6:
New for v6.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/iommu.c | 13 +++++++++++--
 include/linux/iommu.h |  4 ++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e5555fc..5469d36 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -540,14 +540,23 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 	 * ADD/DEL call into iommu driver ops if provided, which may
 	 * result in ADD/DEL notifiers to group->notifier
 	 */
-	if (action == BUS_NOTIFY_ADD_DEVICE) {
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
 		if (ops->add_device)
 			return ops->add_device(dev);
-	} else if (action == BUS_NOTIFY_DEL_DEVICE) {
+	case BUS_NOTIFY_DEL_DEVICE:
 		if (ops->remove_device && dev->iommu_group) {
 			ops->remove_device(dev);
 			return 0;
 		}
+	case BUS_NOTIFY_BOUND_DRIVER:
+		if (ops->bound_driver)
+			ops->bound_driver(dev);
+		break;
+	case BUS_NOTIFY_UNBIND_DRIVER:
+		if (ops->unbind_driver)
+			ops->unbind_driver(dev);
+		break;
 	}
 
 	/*
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a444c79..a0e92be 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -96,6 +96,8 @@ enum iommu_attr {
  * @domain_has_cap: domain capabilities query
  * @add_device: add device to iommu grouping
  * @remove_device: remove device from iommu grouping
+ * @bound_driver: called at BUS_NOTIFY_BOUND_DRIVER
+ * @unbind_driver: called at BUS_NOTIFY_UNBIND_DRIVER
  * @domain_get_attr: Query domain attributes
  * @domain_set_attr: Change domain attributes
  * @pgsize_bitmap: bitmap of supported page sizes
@@ -114,6 +116,8 @@ struct iommu_ops {
 			      unsigned long cap);
 	int (*add_device)(struct device *dev);
 	void (*remove_device)(struct device *dev);
+	int (*bound_driver)(struct device *dev);
+	void (*unbind_driver)(struct device *dev);
 	int (*device_group)(struct device *dev, unsigned int *groupid);
 	int (*domain_get_attr)(struct iommu_domain *domain,
 			       enum iommu_attr attr, void *data);
-- 
1.8.1.5
