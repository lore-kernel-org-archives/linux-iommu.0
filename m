Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A5A28CF72
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296018; cv=none; b=R2cKg3anuB2k2M2pHWc4miGM4qqhewE4vCTWNb2AQ/Z8t1jkrIYssXZLSQ/t5O+sAStqpl+QZb0i6nRqXxrPW8YOyDLanHGEFe7uP0X8PWas277igQ/cW2mLk86vmrDX1TRwPMHZpxc6Fl+K23+MpHl0pQvwUYW+KtsQzVKWkGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296018; c=relaxed/simple;
	bh=ctAClBe4yNGXbeekdfpWt8u5IX3moevD/pTzgxPO4iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLQBJbdSnXshdl52NxiC/VzBcRRrG16jrJVvPFiCKpECbNFznhldsFXPmm/SkJ5hywcrLXnbiixf1MHHnStcjZmaj0b1SZ9OStGcV6i54AlmKvB4icSvlvtJR94AfsBAgj1nS5eOAum4Xs9u8Dtj5QjMFSQOy6yz95vrg3gK/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VYp4tA5P; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VYp4tA5P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744296014;
	bh=ctAClBe4yNGXbeekdfpWt8u5IX3moevD/pTzgxPO4iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VYp4tA5PnvVZMHsChwt4C1rfOqI789kKaIjL6x+VU0CuZJsEG+7BF5lzAZMqPL1QX
	 PcMluq3ynQClrCPxlPeDMK7TEQAg+GWsjlfduyExW4GEhFI8rsP6/Ro1NVxe0R/Q2U
	 BA+QCzzIfA9ergzrXENA4SRhpuYln1PnRWEbYkMRKomBrwNXh84VSCp97yGIWNXTzB
	 PHfAjQy5kQRA9TQnEurNCX0EbaaISvbgaVMC7Hl7BD8PGvtK9x03fg9opIJFZhIXRe
	 FXYqyJ8m8dhMgsyurNVJvPTpFT2ramH44nXE2gjj1jvdXWwI6wMJtVq1cMa3LETsWS
	 7R3SxbUus7DAA==
Received: from IcarusMOD.eternityproject.eu (fi-19-199-243.service.infuturo.it [151.19.199.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2ECA317E0C8D;
	Thu, 10 Apr 2025 16:40:13 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: yong.wu@mediatek.com
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 1/2] dt-bindings: iommu: mediatek: Add binding for MT6893 MM IOMMU
Date: Thu, 10 Apr 2025 16:40:07 +0200
Message-ID: <20250410144008.475888-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410144008.475888-1-angelogioacchino.delregno@collabora.com>
References: <20250410144008.475888-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for the MediaTek Dimensity 1200 (MT6893) SoC's
MultiMedia (MM) IOMMU.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/iommu/mediatek,iommu.yaml        |   4 +
 .../memory/mediatek,mt6893-memory-port.h      | 288 ++++++++++++++++++
 2 files changed, 292 insertions(+)
 create mode 100644 include/dt-bindings/memory/mediatek,mt6893-memory-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index ea6b0f5f24de..75750c64157c 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -74,6 +74,7 @@ properties:
           - mediatek,mt2712-m4u  # generation two
           - mediatek,mt6779-m4u  # generation two
           - mediatek,mt6795-m4u  # generation two
+          - mediatek,mt6893-iommu-mm         # generation two
           - mediatek,mt8167-m4u  # generation two
           - mediatek,mt8173-m4u  # generation two
           - mediatek,mt8183-m4u  # generation two
@@ -131,6 +132,7 @@ properties:
       dt-binding/memory/mt2712-larb-port.h for mt2712,
       dt-binding/memory/mt6779-larb-port.h for mt6779,
       dt-binding/memory/mt6795-larb-port.h for mt6795,
+      dt-binding/memory/mediatek,mt6893-memory-port.h for mt6893,
       dt-binding/memory/mt8167-larb-port.h for mt8167,
       dt-binding/memory/mt8173-larb-port.h for mt8173,
       dt-binding/memory/mt8183-larb-port.h for mt8183,
@@ -157,6 +159,7 @@ allOf:
               - mediatek,mt2701-m4u
               - mediatek,mt2712-m4u
               - mediatek,mt6795-m4u
+              - mediatek,mt6893-iommu-mm
               - mediatek,mt8173-m4u
               - mediatek,mt8186-iommu-mm
               - mediatek,mt8188-iommu-vdo
@@ -173,6 +176,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - mediatek,mt6893-iommu-mm
             - mediatek,mt8186-iommu-mm
             - mediatek,mt8188-iommu-vdo
             - mediatek,mt8188-iommu-vpp
diff --git a/include/dt-bindings/memory/mediatek,mt6893-memory-port.h b/include/dt-bindings/memory/mediatek,mt6893-memory-port.h
new file mode 100644
index 000000000000..acb89609ccc6
--- /dev/null
+++ b/include/dt-bindings/memory/mediatek,mt6893-memory-port.h
@@ -0,0 +1,288 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Copyright (c) 2025 Collabora Ltd
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+#ifndef _DT_BINDINGS_MEMORY_MT6893_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT6893_LARB_PORT_H_
+
+#include <dt-bindings/memory/mtk-memory-port.h>
+
+/*
+ * MM IOMMU supports 16GB dma address.
+ *
+ * The address will preassign like this:
+ *
+ * modules    dma-address-region	larbs-ports
+ * disp         0 ~ 4G                  larb0/2
+ * vcodec      4G ~ 8G                  larb4/5/7
+ * cam/mdp     8G ~ 12G                 larb9/11/13/14/16/17/18/19/20
+ * CCU0    0x4000_0000 ~ 0x43ff_ffff    larb13: port 9/10
+ * CCU1    0x4400_0000 ~ 0x47ff_ffff    larb14: port 4/5
+ *
+ * larb3/6/8/10/12/15 are null.
+ */
+
+/* larb0 */
+#define M4U_PORT_L0_DISP_POSTMASK0		MTK_M4U_DOM_ID(0, 0)
+#define M4U_PORT_L0_MDP_RDMA4			MTK_M4U_DOM_ID(0, 1)
+#define M4U_PORT_L0_OVL_RDMA0_HDR		MTK_M4U_DOM_ID(0, 2)
+#define M4U_PORT_L0_OVL_2L_RDMA1_HDR		MTK_M4U_DOM_ID(0, 3)
+#define M4U_PORT_L0_OVL_2L_RDMA3_HDR		MTK_M4U_DOM_ID(0, 4)
+#define M4U_PORT_L0_OVL_RDMA0			MTK_M4U_DOM_ID(0, 5)
+#define M4U_PORT_L0_OVL_2L_RDMA1		MTK_M4U_DOM_ID(0, 6)
+#define M4U_PORT_L0_OVL_2L_RDMA3		MTK_M4U_DOM_ID(0, 7)
+#define M4U_PORT_L0_OVL_RDMA1_SYSRAM		MTK_M4U_DOM_ID(0, 8)
+#define M4U_PORT_L0_OVL_2L_RDMA0_SYSRAM		MTK_M4U_DOM_ID(0, 9)
+#define M4U_PORT_L0_OVL_2L_RDMA2_SYSRAM		MTK_M4U_DOM_ID(0, 10)
+#define M4U_PORT_L0_DISP_WDMA0			MTK_M4U_DOM_ID(0, 11)
+#define M4U_PORT_L0_DISP_RDMA0			MTK_M4U_DOM_ID(0, 12)
+#define M4U_PORT_L0_DISP_UFBC_WDMA0		MTK_M4U_DOM_ID(0, 13)
+#define M4U_PORT_L0_DISP_FAKE0			MTK_M4U_DOM_ID(0, 14)
+
+/* larb1 */
+#define M4U_PORT_L1_DISP_POSTMASK1		MTK_M4U_DOM_ID(1, 0)
+#define M4U_PORT_L1_MDP_RDMA5			MTK_M4U_DOM_ID(1, 1)
+#define M4U_PORT_L1_OVL_RDMA1_HDR		MTK_M4U_DOM_ID(1, 2)
+#define M4U_PORT_L1_OVL_2L_RDMA0_HDR		MTK_M4U_DOM_ID(1, 3)
+#define M4U_PORT_L1_OVL_2L_RDMA2_HDR		MTK_M4U_DOM_ID(1, 4)
+#define M4U_PORT_L1_OVL_RDMA1			MTK_M4U_DOM_ID(1, 5)
+#define M4U_PORT_L1_OVL_2L_RDMA0		MTK_M4U_DOM_ID(1, 6)
+#define M4U_PORT_L1_OVL_2L_RDMA2		MTK_M4U_DOM_ID(1, 7)
+#define M4U_PORT_L1_OVL_RDMA0_SYSRAM		MTK_M4U_DOM_ID(1, 8)
+#define M4U_PORT_L1_OVL_2L_RDMA1_SYSRAM		MTK_M4U_DOM_ID(1, 9)
+#define M4U_PORT_L1_OVL_2L_RDMA3_SYSRAM		MTK_M4U_DOM_ID(1, 10)
+#define M4U_PORT_L1_DISP_WDMA1			MTK_M4U_DOM_ID(1, 11)
+#define M4U_PORT_L1_DISP_RDMA1			MTK_M4U_DOM_ID(1, 12)
+#define M4U_PORT_L1_DISP_UFBC_WDMA1		MTK_M4U_DOM_ID(1, 13)
+#define M4U_PORT_L1_DISP_FAKE1			MTK_M4U_DOM_ID(1, 14)
+
+/* larb2 */
+#define M4U_PORT_L2_MDP_RDMA0			MTK_M4U_DOM_ID(2, 0)
+#define M4U_PORT_L2_MDP_RDMA2			MTK_M4U_DOM_ID(2, 1)
+#define M4U_PORT_L2_MDP_WROT0			MTK_M4U_DOM_ID(2, 2)
+#define M4U_PORT_L2_MDP_WROT2			MTK_M4U_DOM_ID(2, 3)
+#define M4U_PORT_L2_MDP_FILMGRAIN0		MTK_M4U_DOM_ID(2, 4)
+#define M4U_PORT_L2_MDP_FAKE0			MTK_M4U_DOM_ID(2, 5)
+
+/* larb3: null */
+
+/* larb4 */
+#define M4U_PORT_L4_VDEC_MC_EXT_MDP		MTK_M4U_DOM_ID(4, 0)
+#define M4U_PORT_L4_VDEC_UFO_EXT_MDP		MTK_M4U_DOM_ID(4, 1)
+#define M4U_PORT_L4_VDEC_PP_EXT_MDP		MTK_M4U_DOM_ID(4, 2)
+#define M4U_PORT_L4_VDEC_PRED_RD_EXT_MDP	MTK_M4U_DOM_ID(4, 3)
+#define M4U_PORT_L4_VDEC_PRED_WR_EXT_MDP	MTK_M4U_DOM_ID(4, 4)
+#define M4U_PORT_L4_VDEC_PPWRAP_EXT_MDP		MTK_M4U_DOM_ID(4, 5)
+#define M4U_PORT_L4_VDEC_TILE_EXT_MDP		MTK_M4U_DOM_ID(4, 6)
+#define M4U_PORT_L4_VDEC_VLD_EXT_MDP		MTK_M4U_DOM_ID(4, 7)
+#define M4U_PORT_L4_VDEC_VLD2_EXT_MDP		MTK_M4U_DOM_ID(4, 8)
+#define M4U_PORT_L4_VDEC_AVC_MV_EXT_MDP		MTK_M4U_DOM_ID(4, 9)
+#define M4U_PORT_L4_VDEC_RG_CTRL_DMA_EXT_MDP	MTK_M4U_DOM_ID(4, 10)
+
+/* larb5 */
+#define M4U_PORT_L5_VDEC_LAT0_VLD_EXT_DISP	MTK_M4U_DOM_ID(5, 0)
+#define M4U_PORT_L5_VDEC_LAT0_VLD2_EXT_DISP	MTK_M4U_DOM_ID(5, 1)
+#define M4U_PORT_L5_VDEC_LAT0_AVC_MV_EXT_DISP	MTK_M4U_DOM_ID(5, 2)
+#define M4U_PORT_L5_VDEC_LAT0_PRED_RD_EXT_DISP	MTK_M4U_DOM_ID(5, 3)
+#define M4U_PORT_L5_VDEC_LAT0_TILE_EXT_DISP	MTK_M4U_DOM_ID(5, 4)
+#define M4U_PORT_L5_VDEC_LAT0_WDMA_EXT_DISP	MTK_M4U_DOM_ID(5, 5)
+#define M4U_PORT_L5_VDEC_LAT0_RG_CTRL_DMA_EXT_DISP MTK_M4U_DOM_ID(5, 6)
+#define M4U_PORT_L5_VDEC_UFO_ENC_EXT_DISP	MTK_M4U_DOM_ID(5, 7)
+
+/* larb6: null */
+
+/* larb7 */
+#define M4U_PORT_L7_VENC_RCPU_DISP		MTK_M4U_DOM_ID(7, 0)
+#define M4U_PORT_L7_VENC_REC_DISP		MTK_M4U_DOM_ID(7, 1)
+#define M4U_PORT_L7_VENC_BSDMA_DISP		MTK_M4U_DOM_ID(7, 2)
+#define M4U_PORT_L7_VENC_SV_COMV_DISP		MTK_M4U_DOM_ID(7, 3)
+#define M4U_PORT_L7_VENC_RD_COMV_DISP		MTK_M4U_DOM_ID(7, 4)
+#define M4U_PORT_L7_VENC_NBM_RDMA_DISP		MTK_M4U_DOM_ID(7, 5)
+#define M4U_PORT_L7_VENC_NBM_RDMA_LITE_DISP	MTK_M4U_DOM_ID(7, 6)
+#define M4U_PORT_L7_JPGENC_Y_RDMA_DISP		MTK_M4U_DOM_ID(7, 7)
+#define M4U_PORT_L7_JPGENC_C_RDMA_DISP		MTK_M4U_DOM_ID(7, 8)
+#define M4U_PORT_L7_JPGENC_Q_TABLE_DISP		MTK_M4U_DOM_ID(7, 9)
+#define M4U_PORT_L7_JPGENC_BSDMA_DISP		MTK_M4U_DOM_ID(7, 10)
+#define M4U_PORT_L7_JPGENC_WDMA0_DISP		MTK_M4U_DOM_ID(7, 11)
+#define M4U_PORT_L7_JPGENC_BSDMA0_DISP		MTK_M4U_DOM_ID(7, 12)
+#define M4U_PORT_L7_VENC_NBM_WDMA_DISP		MTK_M4U_DOM_ID(7, 13)
+#define M4U_PORT_L7_VENC_NBM_WDMA_LITE_DISP	MTK_M4U_DOM_ID(7, 14)
+#define M4U_PORT_L7_VENC_CUR_LUMA_DISP		MTK_M4U_DOM_ID(7, 15)
+#define M4U_PORT_L7_VENC_CUR_CHROMA_DISP	MTK_M4U_DOM_ID(7, 16)
+#define M4U_PORT_L7_VENC_REF_LUMA_DISP		MTK_M4U_DOM_ID(7, 17)
+#define M4U_PORT_L7_VENC_REF_CHROMA_DISP	MTK_M4U_DOM_ID(7, 18)
+#define M4U_PORT_L7_VENC_SUB_R_LUMA_DISP	MTK_M4U_DOM_ID(7, 19)
+#define M4U_PORT_L7_VENC_SUB_W_LUMA_DISP	MTK_M4U_DOM_ID(7, 20)
+#define M4U_PORT_L7_VENC_FCS_NBM_RDMA_DISP	MTK_M4U_DOM_ID(7, 21)
+#define M4U_PORT_L7_VENC_FCS_NBM_WDMA_DISP	MTK_M4U_DOM_ID(7, 22)
+#define M4U_PORT_L7_JPGENC_WDMA1_DISP		MTK_M4U_DOM_ID(7, 23)
+#define M4U_PORT_L7_JPGENC_BSDMA1_DISP		MTK_M4U_DOM_ID(7, 24)
+#define M4U_PORT_L7_JPGENC_HUFF_OFFSET1_DISP	MTK_M4U_DOM_ID(7, 25)
+#define M4U_PORT_L7_JPGENC_HUFF_OFFSET0_DISP	MTK_M4U_DOM_ID(7, 26)
+
+/* larb8: null */
+
+/* larb9 */
+#define M4U_PORT_L9_IMG_IMGI_D1_MDP		MTK_M4U_DOM_ID(9, 0)
+#define M4U_PORT_L9_IMG_IMGBI_D1_MDP		MTK_M4U_DOM_ID(9, 1)
+#define M4U_PORT_L9_IMG_DMGI_D1_MDP		MTK_M4U_DOM_ID(9, 2)
+#define M4U_PORT_L9_IMG_DEPI_D1_MDP		MTK_M4U_DOM_ID(9, 3)
+#define M4U_PORT_L9_IMG_ICE_D1_MDP		MTK_M4U_DOM_ID(9, 4)
+#define M4U_PORT_L9_IMG_SMTI_D1_MDP		MTK_M4U_DOM_ID(9, 5)
+#define M4U_PORT_L9_IMG_SMTO_D2_MDP		MTK_M4U_DOM_ID(9, 6)
+#define M4U_PORT_L9_IMG_SMTO_D1_MDP		MTK_M4U_DOM_ID(9, 7)
+#define M4U_PORT_L9_IMG_CRZO_D1_MDP		MTK_M4U_DOM_ID(9, 8)
+#define M4U_PORT_L9_IMG_IMG3O_D1_MDP		MTK_M4U_DOM_ID(9, 9)
+#define M4U_PORT_L9_IMG_VIPI_D1_MDP		MTK_M4U_DOM_ID(9, 10)
+#define M4U_PORT_L9_IMG_SMTI_D5_MDP		MTK_M4U_DOM_ID(9, 11)
+#define M4U_PORT_L9_IMG_TIMGO_D1_MDP		MTK_M4U_DOM_ID(9, 12)
+#define M4U_PORT_L9_IMG_UFBC_W0_MDP		MTK_M4U_DOM_ID(9, 13)
+#define M4U_PORT_L9_IMG_UFBC_R0_MDP		MTK_M4U_DOM_ID(9, 14)
+#define M4U_PORT_L9_IMG_WPE_RDMA1_MDP		MTK_M4U_DOM_ID(9, 15)
+#define M4U_PORT_L9_IMG_WPE_RDMA0_MDP		MTK_M4U_DOM_ID(9, 16)
+#define M4U_PORT_L9_IMG_WPE_WDMA_MDP		MTK_M4U_DOM_ID(9, 17)
+#define M4U_PORT_L9_IMG_MFB_RDMA0_MDP		MTK_M4U_DOM_ID(9, 18)
+#define M4U_PORT_L9_IMG_MFB_RDMA1_MDP		MTK_M4U_DOM_ID(9, 19)
+#define M4U_PORT_L9_IMG_MFB_RDMA2_MDP		MTK_M4U_DOM_ID(9, 20)
+#define M4U_PORT_L9_IMG_MFB_RDMA3_MDP		MTK_M4U_DOM_ID(9, 21)
+#define M4U_PORT_L9_IMG_MFB_RDMA4_MDP		MTK_M4U_DOM_ID(9, 22)
+#define M4U_PORT_L9_IMG_MFB_RDMA5_MDP		MTK_M4U_DOM_ID(9, 23)
+#define M4U_PORT_L9_IMG_MFB_WDMA0_MDP		MTK_M4U_DOM_ID(9, 24)
+#define M4U_PORT_L9_IMG_MFB_WDMA1_MDP		MTK_M4U_DOM_ID(9, 25)
+#define M4U_PORT_L9_IMG_RESERVE6_MDP		MTK_M4U_DOM_ID(9, 26)
+#define M4U_PORT_L9_IMG_RESERVE7_MDP		MTK_M4U_DOM_ID(9, 27)
+#define M4U_PORT_L9_IMG_RESERVE8_MDP		MTK_M4U_DOM_ID(9, 28)
+
+/* larb10: null */
+
+/* larb11 */
+#define M4U_PORT_L11_IMG_IMGI_D1_DISP		MTK_M4U_DOM_ID(11, 0)
+#define M4U_PORT_L11_IMG_IMGBI_D1_DISP		MTK_M4U_DOM_ID(11, 1)
+#define M4U_PORT_L11_IMG_DMGI_D1_DISP		MTK_M4U_DOM_ID(11, 2)
+#define M4U_PORT_L11_IMG_DEPI_D1_DISP		MTK_M4U_DOM_ID(11, 3)
+#define M4U_PORT_L11_IMG_ICE_D1_DISP		MTK_M4U_DOM_ID(11, 4)
+#define M4U_PORT_L11_IMG_SMTI_D1_DISP		MTK_M4U_DOM_ID(11, 5)
+#define M4U_PORT_L11_IMG_SMTO_D2_DISP		MTK_M4U_DOM_ID(11, 6)
+#define M4U_PORT_L11_IMG_SMTO_D1_DISP		MTK_M4U_DOM_ID(11, 7)
+#define M4U_PORT_L11_IMG_CRZO_D1_DISP		MTK_M4U_DOM_ID(11, 8)
+#define M4U_PORT_L11_IMG_IMG3O_D1_DISP		MTK_M4U_DOM_ID(11, 9)
+#define M4U_PORT_L11_IMG_VIPI_D1_DISP		MTK_M4U_DOM_ID(11, 10)
+#define M4U_PORT_L11_IMG_SMTI_D5_DISP		MTK_M4U_DOM_ID(11, 11)
+#define M4U_PORT_L11_IMG_TIMGO_D1_DISP		MTK_M4U_DOM_ID(11, 12)
+#define M4U_PORT_L11_IMG_UFBC_W0_DISP		MTK_M4U_DOM_ID(11, 13)
+#define M4U_PORT_L11_IMG_UFBC_R0_DISP		MTK_M4U_DOM_ID(11, 14)
+#define M4U_PORT_L11_IMG_WPE_RDMA1_DISP		MTK_M4U_DOM_ID(11, 15)
+#define M4U_PORT_L11_IMG_WPE_RDMA0_DISP		MTK_M4U_DOM_ID(11, 16)
+#define M4U_PORT_L11_IMG_WPE_WDMA_DISP		MTK_M4U_DOM_ID(11, 17)
+#define M4U_PORT_L11_IMG_MFB_RDMA0_DISP		MTK_M4U_DOM_ID(11, 18)
+#define M4U_PORT_L11_IMG_MFB_RDMA1_DISP		MTK_M4U_DOM_ID(11, 19)
+#define M4U_PORT_L11_IMG_MFB_RDMA2_DISP		MTK_M4U_DOM_ID(11, 20)
+#define M4U_PORT_L11_IMG_MFB_RDMA3_DISP		MTK_M4U_DOM_ID(11, 21)
+#define M4U_PORT_L11_IMG_MFB_RDMA4_DISP		MTK_M4U_DOM_ID(11, 22)
+#define M4U_PORT_L11_IMG_MFB_RDMA5_DISP		MTK_M4U_DOM_ID(11, 23)
+#define M4U_PORT_L11_IMG_MFB_WDMA0_DISP		MTK_M4U_DOM_ID(11, 24)
+#define M4U_PORT_L11_IMG_MFB_WDMA1_DISP		MTK_M4U_DOM_ID(11, 25)
+#define M4U_PORT_L11_IMG_RESERVE6_DISP		MTK_M4U_DOM_ID(11, 26)
+#define M4U_PORT_L11_IMG_RESERVE7_DISP		MTK_M4U_DOM_ID(11, 27)
+#define M4U_PORT_L11_IMG_RESERVE8_DISP		MTK_M4U_DOM_ID(11, 28)
+
+/* larb12: null */
+
+/* larb13 */
+#define M4U_PORT_L13_CAM_MRAWI_MDP		MTK_M4U_DOM_ID(13, 0)
+#define M4U_PORT_L13_CAM_MRAWO0_MDP		MTK_M4U_DOM_ID(13, 1)
+#define M4U_PORT_L13_CAM_MRAWO1_MDP		MTK_M4U_DOM_ID(13, 2)
+#define M4U_PORT_L13_CAM_CAMSV1_MDP		MTK_M4U_DOM_ID(13, 3)
+#define M4U_PORT_L13_CAM_CAMSV2_MDP		MTK_M4U_DOM_ID(13, 4)
+#define M4U_PORT_L13_CAM_CAMSV3_MDP		MTK_M4U_DOM_ID(13, 5)
+#define M4U_PORT_L13_CAM_CAMSV4_MDP		MTK_M4U_DOM_ID(13, 6)
+#define M4U_PORT_L13_CAM_CAMSV5_MDP		MTK_M4U_DOM_ID(13, 7)
+#define M4U_PORT_L13_CAM_CAMSV6_MDP		MTK_M4U_DOM_ID(13, 8)
+#define M4U_PORT_L13_CAM_CCUI_MDP		MTK_M4U_DOM_ID(13, 9)
+#define M4U_PORT_L13_CAM_CCUO_MDP		MTK_M4U_DOM_ID(13, 10)
+#define M4U_PORT_L13_CAM_FAKE_MDP		MTK_M4U_DOM_ID(13, 11)
+
+/* larb14 */
+#define M4U_PORT_L14_CAM_MRAWI_DISP		MTK_M4U_DOM_ID(14, 0)
+#define M4U_PORT_L14_CAM_MRAWO0_DISP		MTK_M4U_DOM_ID(14, 1)
+#define M4U_PORT_L14_CAM_MRAWO1_DISP		MTK_M4U_DOM_ID(14, 2)
+#define M4U_PORT_L14_CAM_CAMSV0_DISP		MTK_M4U_DOM_ID(14, 3)
+#define M4U_PORT_L14_CAM_CCUI_DISP		MTK_M4U_DOM_ID(14, 4)
+#define M4U_PORT_L14_CAM_CCUO_DISP		MTK_M4U_DOM_ID(14, 5)
+
+/* larb15: null */
+
+/* larb16 */
+#define M4U_PORT_L16_CAM_IMGO_R1_A_MDP		MTK_M4U_DOM_ID(16, 0)
+#define M4U_PORT_L16_CAM_RRZO_R1_A_MDP		MTK_M4U_DOM_ID(16, 1)
+#define M4U_PORT_L16_CAM_CQI_R1_A_MDP		MTK_M4U_DOM_ID(16, 2)
+#define M4U_PORT_L16_CAM_BPCI_R1_A_MDP		MTK_M4U_DOM_ID(16, 3)
+#define M4U_PORT_L16_CAM_YUVO_R1_A_MDP		MTK_M4U_DOM_ID(16, 4)
+#define M4U_PORT_L16_CAM_UFDI_R2_A_MDP		MTK_M4U_DOM_ID(16, 5)
+#define M4U_PORT_L16_CAM_RAWI_R2_A_MDP		MTK_M4U_DOM_ID(16, 6)
+#define M4U_PORT_L16_CAM_RAWI_R3_A_MDP		MTK_M4U_DOM_ID(16, 7)
+#define M4U_PORT_L16_CAM_AAO_R1_A_MDP		MTK_M4U_DOM_ID(16, 8)
+#define M4U_PORT_L16_CAM_AFO_R1_A_MDP		MTK_M4U_DOM_ID(16, 9)
+#define M4U_PORT_L16_CAM_FLKO_R1_A_MDP		MTK_M4U_DOM_ID(16, 10)
+#define M4U_PORT_L16_CAM_LCESO_R1_A_MDP		MTK_M4U_DOM_ID(16, 11)
+#define M4U_PORT_L16_CAM_CRZO_R1_A_MDP		MTK_M4U_DOM_ID(16, 12)
+#define M4U_PORT_L16_CAM_LTMSO_R1_A_MDP		MTK_M4U_DOM_ID(16, 13)
+#define M4U_PORT_L16_CAM_RSSO_R1_A_MDP		MTK_M4U_DOM_ID(16, 14)
+#define M4U_PORT_L16_CAM_AAHO_R1_A_MDP		MTK_M4U_DOM_ID(16, 15)
+#define M4U_PORT_L16_CAM_LSCI_R1_A_MDP		MTK_M4U_DOM_ID(16, 16)
+
+/* larb17 */
+#define M4U_PORT_L17_CAM_IMGO_R1_B_DISP		MTK_M4U_DOM_ID(17, 0)
+#define M4U_PORT_L17_CAM_RRZO_R1_B_DISP		MTK_M4U_DOM_ID(17, 1)
+#define M4U_PORT_L17_CAM_CQI_R1_B_DISP		MTK_M4U_DOM_ID(17, 2)
+#define M4U_PORT_L17_CAM_BPCI_R1_B_DISP		MTK_M4U_DOM_ID(17, 3)
+#define M4U_PORT_L17_CAM_YUVO_R1_B_DISP		MTK_M4U_DOM_ID(17, 4)
+#define M4U_PORT_L17_CAM_UFDI_R2_B_DISP		MTK_M4U_DOM_ID(17, 5)
+#define M4U_PORT_L17_CAM_RAWI_R2_B_DISP		MTK_M4U_DOM_ID(17, 6)
+#define M4U_PORT_L17_CAM_RAWI_R3_B_DISP		MTK_M4U_DOM_ID(17, 7)
+#define M4U_PORT_L17_CAM_AAO_R1_B_DISP		MTK_M4U_DOM_ID(17, 8)
+#define M4U_PORT_L17_CAM_AFO_R1_B_DISP		MTK_M4U_DOM_ID(17, 9)
+#define M4U_PORT_L17_CAM_FLKO_R1_B_DISP		MTK_M4U_DOM_ID(17, 10)
+#define M4U_PORT_L17_CAM_LCESO_R1_B_DISP	MTK_M4U_DOM_ID(17, 11)
+#define M4U_PORT_L17_CAM_CRZO_R1_B_DISP		MTK_M4U_DOM_ID(17, 12)
+#define M4U_PORT_L17_CAM_LTMSO_R1_B_DISP	MTK_M4U_DOM_ID(17, 13)
+#define M4U_PORT_L17_CAM_RSSO_R1_B_DISP		MTK_M4U_DOM_ID(17, 14)
+#define M4U_PORT_L17_CAM_AAHO_R1_B_DISP		MTK_M4U_DOM_ID(17, 15)
+#define M4U_PORT_L17_CAM_LSCI_R1_B_DISP		MTK_M4U_DOM_ID(17, 16)
+
+/* larb18 */
+#define M4U_PORT_L18_CAM_IMGO_R1_C_MDP		MTK_M4U_DOM_ID(18, 0)
+#define M4U_PORT_L18_CAM_RRZO_R1_C_MDP		MTK_M4U_DOM_ID(18, 1)
+#define M4U_PORT_L18_CAM_CQI_R1_C_MDP		MTK_M4U_DOM_ID(18, 2)
+#define M4U_PORT_L18_CAM_BPCI_R1_C_MDP		MTK_M4U_DOM_ID(18, 3)
+#define M4U_PORT_L18_CAM_YUVO_R1_C_MDP		MTK_M4U_DOM_ID(18, 4)
+#define M4U_PORT_L18_CAM_UFDI_R2_C_MDP		MTK_M4U_DOM_ID(18, 5)
+#define M4U_PORT_L18_CAM_RAWI_R2_C_MDP		MTK_M4U_DOM_ID(18, 6)
+#define M4U_PORT_L18_CAM_RAWI_R3_C_MDP		MTK_M4U_DOM_ID(18, 7)
+#define M4U_PORT_L18_CAM_AAO_R1_C_MDP		MTK_M4U_DOM_ID(18, 8)
+#define M4U_PORT_L18_CAM_AFO_R1_C_MDP		MTK_M4U_DOM_ID(18, 9)
+#define M4U_PORT_L18_CAM_FLKO_R1_C_MDP		MTK_M4U_DOM_ID(18, 10)
+#define M4U_PORT_L18_CAM_LCESO_R1_C_MDP		MTK_M4U_DOM_ID(18, 11)
+#define M4U_PORT_L18_CAM_CRZO_R1_C_MDP		MTK_M4U_DOM_ID(18, 12)
+#define M4U_PORT_L18_CAM_LTMSO_R1_C_MDP		MTK_M4U_DOM_ID(18, 13)
+#define M4U_PORT_L18_CAM_RSSO_R1_C_MDP		MTK_M4U_DOM_ID(18, 14)
+#define M4U_PORT_L18_CAM_AAHO_R1_C_MDP		MTK_M4U_DOM_ID(18, 15)
+#define M4U_PORT_L18_CAM_LSCI_R1_C_MDP		MTK_M4U_DOM_ID(18, 16)
+
+/* larb19 */
+#define M4U_PORT_L19_IPE_DVS_RDMA_DISP		MTK_M4U_DOM_ID(19, 0)
+#define M4U_PORT_L19_IPE_DVS_WDMA_DISP		MTK_M4U_DOM_ID(19, 1)
+#define M4U_PORT_L19_IPE_DVP_RDMA_DISP		MTK_M4U_DOM_ID(19, 2)
+#define M4U_PORT_L19_IPE_DVP_WDMA_DISP		MTK_M4U_DOM_ID(19, 3)
+
+/* larb20 */
+#define M4U_PORT_L20_IPE_FDVT_RDA_DISP		MTK_M4U_DOM_ID(20, 0)
+#define M4U_PORT_L20_IPE_FDVT_RDB_DISP		MTK_M4U_DOM_ID(20, 1)
+#define M4U_PORT_L20_IPE_FDVT_WRA_DISP		MTK_M4U_DOM_ID(20, 2)
+#define M4U_PORT_L20_IPE_FDVT_WRB_DISP		MTK_M4U_DOM_ID(20, 3)
+#define M4U_PORT_L20_IPE_RSC_RDMA0_DISP		MTK_M4U_DOM_ID(20, 4)
+#define M4U_PORT_L20_IPE_RSC_WDMA_DISP		MTK_M4U_DOM_ID(20, 5)
+
+#endif
-- 
2.49.0

