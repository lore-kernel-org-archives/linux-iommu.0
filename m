From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 04/22] iommu: Clean up after a failed bus initialization
Date: Thu, 28 May 2015 18:41:27 +0200
Message-ID: <1432831305-11126-5-git-send-email-joro@8bytes.org>
References: <1432831305-11126-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432831305-11126-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Make sure we call the ->remove_device call-back on all
devices already initialized with ->add_device when the bus
initialization fails.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9c9336a..f0e0a23 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -753,6 +753,17 @@ static int add_iommu_group(struct device *dev, void *data)
 	return ops->add_device(dev);
 }
 
+static int remove_iommu_group(struct device *dev, void *data)
+{
+	struct iommu_callback_data *cb = data;
+	const struct iommu_ops *ops = cb->ops;
+
+	if (ops->remove_device && dev->iommu_group)
+		ops->remove_device(dev);
+
+	return 0;
+}
+
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data)
 {
@@ -821,19 +832,25 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 	nb->notifier_call = iommu_bus_notifier;
 
 	err = bus_register_notifier(bus, nb);
-	if (err) {
-		kfree(nb);
-		return err;
-	}
+	if (err)
+		goto out_free;
 
 	err = bus_for_each_dev(bus, NULL, &cb, add_iommu_group);
-	if (err) {
-		bus_unregister_notifier(bus, nb);
-		kfree(nb);
-		return err;
-	}
+	if (err)
+		goto out_err;
+
 
 	return 0;
+
+out_err:
+	/* Clean up */
+	bus_for_each_dev(bus, NULL, &cb, remove_iommu_group);
+	bus_unregister_notifier(bus, nb);
+
+out_free:
+	kfree(nb);
+
+	return err;
 }
 
 /**
-- 
1.9.1
