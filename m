From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] iommu: Improve error handling when setting bus iommu
Date: Wed, 29 Oct 2014 01:22:56 +0100
Message-ID: <1721918.cCnbhQjjFO@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When some part of bus_set_iommu fails it should undo any made changes
and not simply leave everything as is.

This includes unregistering the bus notifier in iommu_bus_init when
add_iommu_group fails and also setting the bus->iommu_ops back to NULL.

Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
 drivers/iommu/iommu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ed8b048..b0e6b94 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -818,7 +818,15 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 		kfree(nb);
 		return err;
 	}
-	return bus_for_each_dev(bus, NULL, &cb, add_iommu_group);
+
+	err = bus_for_each_dev(bus, NULL, &cb, add_iommu_group);
+	if (err) {
+		bus_unregister_notifier(bus, nb);
+		kfree(nb);
+		return err;
+	}
+
+	return 0;
 }
 
 /**
@@ -836,13 +844,19 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
  */
 int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
 {
+	int err;
+
 	if (bus->iommu_ops != NULL)
 		return -EBUSY;
 
 	bus->iommu_ops = ops;
 
 	/* Do IOMMU specific setup for this bus-type */
-	return iommu_bus_init(bus, ops);
+	err = iommu_bus_init(bus, ops);
+	if (err)
+		bus->iommu_ops = NULL;
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(bus_set_iommu);
 
-- 
2.0.1
