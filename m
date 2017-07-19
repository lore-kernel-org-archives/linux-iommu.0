From: Anup Patel <anup.patel@broadcom.com>
Subject: [PATCH 1/5] iommu: Add capability IOMMU_CAP_BYPASS
Date: Wed, 19 Jul 2017 15:03:54 +0530
Message-ID: <1500456838-18405-2-git-send-email-anup.patel@broadcom.com>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Anup Patel <anup.patel@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

Some of the IOMMUs (such as ARM SMMU) are capable of bypassing
transactions for which no IOMMU domain is configured.

This patch adds IOMMU_CAP_BYPASS which can be used by IOMMU
drivers to advertise transation bypass capability of an IOMMU.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 include/linux/iommu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2cb54ad..6bbb4cc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -101,6 +101,10 @@ enum iommu_cap {
 					   transactions */
 	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
 	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
+	IOMMU_CAP_BYPASS,		/*
+					 * IOMMU can bypass transactions for
+					 * which domain is not configured
+					 */
 };
 
 /*
-- 
2.7.4
