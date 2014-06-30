From: Olav Haugan <ohaugan@codeaurora.org>
Subject: [RFC/PATCH 7/7] iommu-api: Add domain attribute to enable coherent HTW
Date: Mon, 30 Jun 2014 09:51:56 -0700
Message-ID: <1404147116-4598-8-git-send-email-ohaugan@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, will.deacon@arm.com, thierry.reding@gmail.com, joro@8bytes.org, vgandhi@codeaurora.org, Olav Haugan <ohaugan@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Add a new iommu domain attribute that can be used to enable cache
coherent hardware table walks (HTW) by the SMMU. HTW might be supported
by the SMMU HW but depending on the use case and the usage of the SMMU
in the SoC it might not be always beneficial to always turn on coherent HTW for
all domains/iommu's.

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
---
 drivers/iommu/msm_iommu-v1.c | 16 ++++++++++++++++
 include/linux/iommu.h        |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/iommu/msm_iommu-v1.c b/drivers/iommu/msm_iommu-v1.c
index 2c574ef..e163ffc 100644
--- a/drivers/iommu/msm_iommu-v1.c
+++ b/drivers/iommu/msm_iommu-v1.c
@@ -1456,8 +1456,16 @@ static int msm_domain_get_attr(struct iommu_domain *domain,
 			       enum iommu_attr attr, void *data)
 {
 	s32 ret = 0;
+	struct msm_iommu_priv *priv = domain->priv;
 
 	switch (attr) {
+	case DOMAIN_ATTR_COHERENT_HTW:
+	{
+		s32 *int_ptr = (s32 *) data;
+
+		*int_ptr = priv->pt.redirect;
+		break;
+	}
 	default:
 		pr_err("Unsupported attribute type\n");
 		ret = -EINVAL;
@@ -1471,8 +1479,16 @@ static int msm_domain_set_attr(struct iommu_domain *domain,
 			       enum iommu_attr attr, void *data)
 {
 	s32 ret = 0;
+	struct msm_iommu_priv *priv = domain->priv;
 
 	switch (attr) {
+	case DOMAIN_ATTR_COHERENT_HTW:
+	{
+		s32 *int_ptr = (s32 *) data;
+
+		priv->pt.redirect = *int_ptr;
+		break;
+	}
 	default:
 		pr_err("Unsupported attribute type\n");
 		ret = -EINVAL;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 63dca6d..6d9596d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -81,6 +81,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMU_STASH,
 	DOMAIN_ATTR_FSL_PAMU_ENABLE,
 	DOMAIN_ATTR_FSL_PAMUV1,
+	DOMAIN_ATTR_COHERENT_HTW,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
