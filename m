From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 06/26] iommu/vt-d: Simplify domain_context_mapping_one
Date: Wed,  5 Aug 2015 17:18:37 +0200
Message-ID: <1438787937-7340-7-git-send-email-joro@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Get rid of the special cases for VM domains vs. non-VM
domains and simplify the code further to just handle the
hardware passthrough vs. page-table case.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 60 ++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1a934f8..fdb51ec 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1940,52 +1940,44 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 		return 0;
 	}
 
-	context_clear_entry(context);
-
-	id = domain->id;
 	pgd = domain->pgd;
 
-	if (domain_type_is_vm_or_si(domain)) {
-		if (domain_type_is_vm(domain)) {
-			id = __iommu_attach_domain(domain, iommu);
-			if (id < 0) {
-				spin_unlock_irqrestore(&iommu->lock, flags);
-				pr_err("%s: No free domain ids\n", iommu->name);
-				return -EFAULT;
-			}
-		}
-
-		/* Skip top levels of page tables for
-		 * iommu which has less agaw than default.
-		 * Unnecessary for PT mode.
-		 */
-		if (translation != CONTEXT_TT_PASS_THROUGH) {
-			for (agaw = domain->agaw; agaw != iommu->agaw; agaw--) {
-				pgd = phys_to_virt(dma_pte_addr(pgd));
-				if (!dma_pte_present(pgd)) {
-					spin_unlock_irqrestore(&iommu->lock, flags);
-					return -ENOMEM;
-				}
-			}
-		}
+	id = __iommu_attach_domain(domain, iommu);
+	if (id < 0) {
+		spin_unlock_irqrestore(&iommu->lock, flags);
+		pr_err("%s: No free domain ids\n", iommu->name);
+		return -EFAULT;
 	}
 
+	context_clear_entry(context);
 	context_set_domain_id(context, id);
 
+	/*
+	 * Skip top levels of page tables for iommu which has less agaw
+	 * than default.  Unnecessary for PT mode.
+	 */
 	if (translation != CONTEXT_TT_PASS_THROUGH) {
+		for (agaw = domain->agaw; agaw != iommu->agaw; agaw--) {
+			pgd = phys_to_virt(dma_pte_addr(pgd));
+			if (!dma_pte_present(pgd)) {
+				spin_unlock_irqrestore(&iommu->lock, flags);
+				return -ENOMEM;
+			}
+		}
+
 		info = iommu_support_dev_iotlb(domain, iommu, bus, devfn);
 		translation = info ? CONTEXT_TT_DEV_IOTLB :
 				     CONTEXT_TT_MULTI_LEVEL;
-	}
-	/*
-	 * In pass through mode, AW must be programmed to indicate the largest
-	 * AGAW value supported by hardware. And ASR is ignored by hardware.
-	 */
-	if (unlikely(translation == CONTEXT_TT_PASS_THROUGH))
-		context_set_address_width(context, iommu->msagaw);
-	else {
+
 		context_set_address_root(context, virt_to_phys(pgd));
 		context_set_address_width(context, iommu->agaw);
+	} else {
+		/*
+		 * In pass through mode, AW must be programmed to
+		 * indicate the largest AGAW value supported by
+		 * hardware. And ASR is ignored by hardware.
+		 */
+		context_set_address_width(context, iommu->msagaw);
 	}
 
 	context_set_translation_type(context, translation);
-- 
1.9.1
