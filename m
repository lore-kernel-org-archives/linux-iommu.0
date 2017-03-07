From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 5/7] iommu/arm-smmu: add support for TTBR0 attribute
Date: Tue,  7 Mar 2017 09:39:53 -0700
Message-ID: <1488904795-870-6-git-send-email-jcrouse@codeaurora.org>
References: <1488904795-870-1-git-send-email-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1488904795-870-1-git-send-email-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jeremy Gebben <jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Jeremy Gebben <jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Add support to return the value of the TTBR0 register in response
to a request via DOMAIN_ATTR_TTBR0.

Signed-off-by: Jeremy Gebben <jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2e3879f..e051750 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1544,6 +1544,19 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 		*((int *)data) = !!(smmu_domain->attributes
 					& (1 << DOMAIN_ATTR_ENABLE_TTBR1));
 		return 0;
+	case DOMAIN_ATTR_TTBR0: {
+		u64 val;
+		/* not valid until we are attached */
+		if (smmu_domain->smmu == NULL)
+			return -ENODEV;
+
+		val = smmu_domain->pgtbl_cfg.arm_lpae_s1_cfg.ttbr[0];
+		if (smmu_domain->cfg.cbar != CBAR_TYPE_S2_TRANS)
+			val |= (u64)ARM_SMMU_CB_ASID(smmu_domain->smmu,
+				&smmu_domain->cfg) << TTBRn_ASID_SHIFT;
+		*((u64 *)data) = val;
+		return 0;
+	}
 	default:
 		return -ENODEV;
 	}
-- 
1.9.1
