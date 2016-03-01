From: Eric Auger <eric.auger@linaro.org>
Subject: [RFC v5 02/17] iommu/arm-smmu: advertise DOMAIN_ATTR_MSI_MAPPING
 attribute
Date: Tue,  1 Mar 2016 18:27:42 +0000
Message-ID: <1456856877-4817-3-git-send-email-eric.auger@linaro.org>
References: <1456856877-4817-1-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <1456856877-4817-1-git-send-email-eric.auger@linaro.org>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: eric.auger@st.com, eric.auger@linaro.org, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
Cc: patches@linaro.org, Manish.Jaggi@caviumnetworks.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On ARM, MSI write transactions from device upstream to the smmu
are conveyed through the iommu. Therefore target physical addresses
must be mapped and DOMAIN_ATTR_MSI_MAPPING is set to advertise
this requirement on arm-smmu and arm-smmu-v3.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Bharat Bhushan <Bharat.Bhushan@freescale.com>

---

v4 -> v5:
- don't handle fsl_pamu_domain anymore
- handle arm-smmu-v3
---
 drivers/iommu/arm-smmu-v3.c | 2 ++
 drivers/iommu/arm-smmu.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 2087534..1d7b506 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1895,6 +1895,8 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 	case DOMAIN_ATTR_NESTING:
 		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 		return 0;
+	case DOMAIN_ATTR_MSI_MAPPING:
+		return 0;
 	default:
 		return -ENODEV;
 	}
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 59ee4b8..c8b7e71 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1409,6 +1409,8 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 	case DOMAIN_ATTR_NESTING:
 		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 		return 0;
+	case DOMAIN_ATTR_MSI_MAPPING:
+		return 0;
 	default:
 		return -ENODEV;
 	}
-- 
1.9.1
