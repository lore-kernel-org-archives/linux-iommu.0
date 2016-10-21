From: Rick Song <songwenjun@huawei.com>
Subject: [RFC,v1,1/2] iommu/arm-smmu: support s2 domain attribute
Date: Fri, 21 Oct 2016 12:39:23 +0800
Message-ID: <1477024764-79882-1-git-send-email-songwenjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, kvm@vger.kernel.org, songwenjun@huawei.com
List-Id: iommu@lists.linux-foundation.org

Under some condition, user want to use the
only stage 2 translation ability, so smmu
driver need support setting only s2 domain
attribute.

Signed-off-by: Rick Song <songwenjun@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 12 ++++++++++++
 include/linux/iommu.h       |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 15c01c3..d3b19d2 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1854,6 +1854,18 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	mutex_lock(&smmu_domain->init_mutex);
 
 	switch (attr) {
+	case DOMAIN_ATTR_S2:
+		if (smmu_domain->smmu) {
+			ret = -EPERM;
+			goto out_unlock;
+		}
+
+		if (*(int *)data)
+			smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
+		else
+			smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
+
+		break;
 	case DOMAIN_ATTR_NESTING:
 		if (smmu_domain->smmu) {
 			ret = -EPERM;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 436dc21..0b5a387 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -114,6 +114,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMU_ENABLE,
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
+	DOMAIN_ATTR_S2,		/* only stage 2 translation */
 	DOMAIN_ATTR_MAX,
 };
 
-- 
1.9.1

