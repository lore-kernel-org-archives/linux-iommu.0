From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 11/13] iommu/smmuv3: Implement tlb_invalidate
Date: Thu, 23 Aug 2018 14:17:34 +0200
Message-ID: <1535026656-8450-12-git-send-email-eric.auger@redhat.com>
References: <1535026656-8450-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1535026656-8450-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, yi.l.liu"@linux.intel.com, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: marc.zyngier-5wv7dgnIgG8@public.gmane.org, peter.maydell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, christoffer.dall-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Implement IOMMU_INV_TYPE_TLB invalidations. When
nr_pages is null we interpret this as a context
invalidation.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---

The user API needs to be refined to discriminate context
invalidations from NH_VA invalidations. Also the leaf attribute
is not yet properly handled.
---
 drivers/iommu/arm-smmu-v3.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 26afafa..e4c7ae8 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2101,6 +2101,39 @@ static void arm_smmu_unbind_guest_stage(struct iommu_domain *domain,
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 }
 
+static int arm_smmu_tlb_invalidate(struct iommu_domain *domain,
+				   struct device *dev,
+				   struct iommu_tlb_invalidate_info *inv_info)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	size_t granule = 1 << (inv_info->size + 12);
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
+		return -EINVAL;
+
+	if (!smmu)
+		return -EINVAL;
+
+	if (inv_info->hdr.type != IOMMU_INV_TYPE_TLB)
+		return -EINVAL;
+
+	/*
+	 * TODO: On context invalidation, the userspace sets nr_pages to 0.
+	 * Refine the API to add a dedicated flags and also properly handle
+	 * the leaf parameter.
+	 */
+	if (!inv_info->nr_pages) {
+		arm_smmu_tlb_inv_context(smmu_domain);
+	} else {
+		arm_smmu_tlb_inv_range_nosync(inv_info->addr,
+					      inv_info->nr_pages * granule,
+					      granule, false, smmu_domain);
+		__arm_smmu_tlb_sync(smmu);
+	}
+	return 0;
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -2122,6 +2155,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.put_resv_regions	= arm_smmu_put_resv_regions,
 	.bind_guest_stage	= arm_smmu_bind_guest_stage,
 	.unbind_guest_stage	= arm_smmu_unbind_guest_stage,
+	.tlb_invalidate		= arm_smmu_tlb_invalidate,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
-- 
2.5.5
