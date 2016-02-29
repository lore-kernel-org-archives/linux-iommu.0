From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 05/12] arm64/dma-mapping: Remove default domain workaround
Date: Mon, 29 Feb 2016 13:46:14 +0000
Message-ID: <698ecf1450da8b56a8f297b83815d2fe866ca0e1.1456514380.git.robin.murphy@arm.com>
References: <cover.1456514380.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1456514380.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Thomas.Lendacky-5C7GfCeVMHo@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, stuart.yoder-3arQi8VN3Tc@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With the IOMMU core now taking care of default domains for groups
regardless of bus type, we can gleefully rip out this stop-gap, as
slight recompense for having to expand the other one.

CC: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
CC: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm64/mm/dma-mapping.c | 52 +++++++--------------------------------------
 1 file changed, 8 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 607e709..fd8b942 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -804,57 +804,24 @@ struct iommu_dma_notifier_data {
 static LIST_HEAD(iommu_dma_masters);
 static DEFINE_MUTEX(iommu_dma_notifier_lock);
 
-/*
- * Temporarily "borrow" a domain feature flag to to tell if we had to resort
- * to creating our own domain here, in case we need to clean it up again.
- */
-#define __IOMMU_DOMAIN_FAKE_DEFAULT		(1U << 31)
-
 static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
 			   u64 dma_base, u64 size)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 
 	/*
-	 * Best case: The device is either part of a group which was
-	 * already attached to a domain in a previous call, or it's
-	 * been put in a default DMA domain by the IOMMU core.
+	 * If the IOMMU driver has the DMA domain support that we require,
+	 * then the IOMMU core will have already configured a group for this
+	 * device, and allocated the default domain for that group.
 	 */
-	if (!domain) {
-		/*
-		 * Urgh. The IOMMU core isn't going to do default domains
-		 * for non-PCI devices anyway, until it has some means of
-		 * abstracting the entirely implementation-specific
-		 * sideband data/SoC topology/unicorn dust that may or
-		 * may not differentiate upstream masters.
-		 * So until then, HORRIBLE HACKS!
-		 */
-		domain = ops->domain_alloc(IOMMU_DOMAIN_DMA);
-		if (!domain)
-			goto out_no_domain;
-
-		domain->ops = ops;
-		domain->type = IOMMU_DOMAIN_DMA | __IOMMU_DOMAIN_FAKE_DEFAULT;
-
-		if (iommu_attach_device(domain, dev))
-			goto out_put_domain;
+	if (!domain || iommu_dma_init_domain(domain, dma_base, size)) {
+		pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
+			dev_name(dev));
+		return false;
 	}
 
-	if (iommu_dma_init_domain(domain, dma_base, size))
-		goto out_detach;
-
 	dev->archdata.dma_ops = &iommu_dma_ops;
 	return true;
-
-out_detach:
-	iommu_detach_device(domain, dev);
-out_put_domain:
-	if (domain->type & __IOMMU_DOMAIN_FAKE_DEFAULT)
-		iommu_domain_free(domain);
-out_no_domain:
-	pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
-		dev_name(dev));
-	return false;
 }
 
 static void queue_iommu_attach(struct device *dev, const struct iommu_ops *ops,
@@ -971,11 +938,8 @@ void arch_teardown_dma_ops(struct device *dev)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 
-	if (domain) {
+	if (WARN_ON(domain))
 		iommu_detach_device(domain, dev);
-		if (domain->type & __IOMMU_DOMAIN_FAKE_DEFAULT)
-			iommu_domain_free(domain);
-	}
 
 	dev->archdata.dma_ops = NULL;
 }
-- 
2.7.2.333.g70bd996.dirty
