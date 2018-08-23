From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 13/13] iommu/smmuv3: Implement bind_guest_msi
Date: Thu, 23 Aug 2018 14:17:36 +0200
Message-ID: <1535026656-8450-14-git-send-email-eric.auger@redhat.com>
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

The bind_guest_msi() callback checks the domain
is NESTED and redirect to the dma-iommu implementation.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e4c7ae8..ccd55d3 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2025,6 +2025,21 @@ static void arm_smmu_put_resv_regions(struct device *dev,
 		kfree(entry);
 }
 
+static int arm_smmu_bind_guest_msi(struct iommu_domain *domain,
+				   struct iommu_guest_msi_binding *binding)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	if (!smmu)
+		return -EINVAL;
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
+		return -EINVAL;
+
+	return iommu_dma_bind_doorbell(domain, binding);
+}
+
 static int arm_smmu_bind_guest_stage(struct iommu_domain *domain,
 				     struct device *dev,
 				     struct iommu_guest_stage_config *cfg)
@@ -2153,6 +2168,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= arm_smmu_put_resv_regions,
+	.bind_guest_msi		= arm_smmu_bind_guest_msi,
 	.bind_guest_stage	= arm_smmu_bind_guest_stage,
 	.unbind_guest_stage	= arm_smmu_unbind_guest_stage,
 	.tlb_invalidate		= arm_smmu_tlb_invalidate,
-- 
2.5.5
