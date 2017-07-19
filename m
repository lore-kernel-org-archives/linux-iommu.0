From: Anup Patel <anup.patel@broadcom.com>
Subject: [PATCH 2/5] iommu/arm-smmu: add IOMMU_CAP_BYPASS to the ARM SMMU driver
Date: Wed, 19 Jul 2017 15:03:55 +0530
Message-ID: <1500456838-18405-3-git-send-email-anup.patel@broadcom.com>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Anup Patel <anup.patel@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

The ARM SMMUv1 and SMMUv2 support bypassing transactions for
which domain is not configured. The patch adds corresponding
IOMMU capability to advertise this fact.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/iommu/arm-smmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index bc89b4d..08a9020 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1483,6 +1483,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 		return true;
 	case IOMMU_CAP_NOEXEC:
 		return true;
+	case IOMMU_CAP_BYPASS:
+		return true;
 	default:
 		return false;
 	}
-- 
2.7.4
