From: Varun Sethi <Varun.Sethi@freescale.com>
Subject: [PATCH 1/4 v2] iommu/fsl: Store iommu domain information pointer in archdata.
Date: Mon, 5 Nov 2012 16:49:19 +0530
Message-ID: <1352114361-25192-2-git-send-email-Varun.Sethi@freescale.com>
References: <1352114361-25192-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352114361-25192-1-git-send-email-Varun.Sethi@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joerg.roedel@amd.com, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@freescale.com, scottwood@freescale.com
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org

Add a new field in the device (powerpc) archdata structure for storing iommu domain
information pointer. This pointer is stored when the device is attached to a particular
domain.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 arch/powerpc/include/asm/device.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 77e97dd..6dc79fe 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -28,6 +28,10 @@ struct dev_archdata {
 		void		*iommu_table_base;
 	} dma_data;
 
+	/* IOMMU domain information pointer. This would be set
+	 * when this device is attached to an iommu_domain.
+	 */
+	void			*iommu_domain;
 #ifdef CONFIG_SWIOTLB
 	dma_addr_t		max_direct_dma_addr;
 #endif
-- 
1.7.4.1
