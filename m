From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] iommu: Introduce interface for unsetting bus IOMMU
Date: Tue, 19 Jun 2018 11:45:33 -0500
Message-ID: <1529426734-20639-2-git-send-email-suravee.suthikulpanit@amd.com>
References: <1529426734-20639-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1529426734-20639-1-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This interface allows removal of IOMMU from a bus if needed.
For example, when the IOMMU driver fails to initialize, it should
unassociate itself from the bus (i.e. removing IOMMU groups and
unregister bus notifier block).

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/iommu.c  | 22 ++++++++++++++++++++++
 include/linux/device.h |  1 +
 include/linux/iommu.h  |  1 +
 3 files changed, 24 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d2aa2320..56691ab 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1165,6 +1165,7 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 	if (err)
 		goto out_err;
 
+	bus->iommu_nb = nb;
 
 	return 0;
 
@@ -1179,6 +1180,27 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 	return err;
 }
 
+void bus_unset_iommu(struct bus_type *bus, const struct iommu_ops *ops)
+{
+	struct iommu_callback_data cb = {
+		.ops = ops,
+	};
+
+	if (!bus->iommu_ops)
+		return;
+
+	bus_for_each_dev(bus, NULL, &cb, remove_iommu_group);
+
+	if (bus->iommu_nb) {
+		bus_unregister_notifier(bus, bus->iommu_nb);
+		kfree(bus->iommu_nb);
+		bus->iommu_nb = NULL;
+	}
+
+	bus->iommu_ops = NULL;
+}
+EXPORT_SYMBOL_GPL(bus_unset_iommu);
+
 /**
  * bus_set_iommu - set iommu-callbacks for the bus
  * @bus: bus.
diff --git a/include/linux/device.h b/include/linux/device.h
index 4779569..cac7baf 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -133,6 +133,7 @@ struct bus_type {
 	const struct dev_pm_ops *pm;
 
 	const struct iommu_ops *iommu_ops;
+	struct notifier_block *iommu_nb;
 
 	struct subsys_private *p;
 	struct lock_class_key lock_key;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee..65f998e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -287,6 +287,7 @@ static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
 #define IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER	6 /* Post Driver unbind */
 
 extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
+extern void bus_unset_iommu(struct bus_type *bus, const struct iommu_ops *ops);
 extern bool iommu_present(struct bus_type *bus);
 extern bool iommu_capable(struct bus_type *bus, enum iommu_cap cap);
 extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
-- 
2.7.4
