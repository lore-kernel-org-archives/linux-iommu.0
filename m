Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E88257B
	for <iommu@lists.linux.dev>; Tue,  4 Oct 2022 10:01:52 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id i83-20020a1c3b56000000b003bd44dc526fso474671wma.3
        for <iommu@lists.linux.dev>; Tue, 04 Oct 2022 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=bxB5WSuQ2mEH8Qc1QikFTsPZWlISB5RdBRCjOaAR+/w=;
        b=AbBJNNAAsm5TTaD/gojyalnaCESx4zoikoQrhqmtnVfNDsxELwEdLhcvB9zHgc04qx
         r7r/RA4vrxRHgQ9eXBWQ7f2XRdAbPxDHQRg0hLAA9czaQz8TV99P4P1CtxAbG7eN5X47
         uBo9DTtQTbKntanjnfuPSZUB7TQj2WJDekaPWApKE3LJu0wMwEVIwYUEmH1MBK3Ir5dQ
         Atx5qlX9wwa2SqZHrHC2tmGxR3H3zwm/uOA2yc9VnS34IkD9j24rlPLpxpBBuY2AfNxj
         9VGJ9LJJ7N9s+ILaGd1sVM/T5zb0tLMBzoWiVbauZJbm7R2Z5MW14aXcD8YyZBH8w45J
         vSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bxB5WSuQ2mEH8Qc1QikFTsPZWlISB5RdBRCjOaAR+/w=;
        b=qw/85fwomkB2FkIlXSVEwsXLMxep+ISK9hi/TwPIY1ZTSKrYKtkfeG2bg08WWGciuA
         0c4J2UPUPn2CCniSsq+p3MnAyZvQedeSY/uGGcXekKEiTOTfvZ8cSLQT7pBHDgvxGHqY
         TMmkR1t6xoqXATxxorqw0lhQMQXALNRcaV1R0V+UU7LmEPNXt0TEsAHiWr/nKy8SHLM8
         gFK557WDIQsBInuyV8s860qhAkrn0CimnHm0xI67AyMvCnvFWm98MlF783NWiqt8lTYj
         vQKkvXvNDp94olK9TdxSUuGllCGcEFqNblzS1llZnhLrjcjFemuus5iZCMveqK50Q0Ox
         5Z8Q==
X-Gm-Message-State: ACrzQf2ma/DXQ6L4VZT9lFanHp6ZafGyJOGAFjLpx3myBT13dw2daZYu
	KEHZICSQKtVSo898f1ZavJJXAA==
X-Google-Smtp-Source: AMsMyM7FXhVaOtElOfs/bcIBaENiZMZfL0fuWjqGyKj46wl4bgXEx5VkyKvvDKCpEVvlM1D7yi2aUQ==
X-Received: by 2002:a05:600c:424c:b0:3b4:6359:b301 with SMTP id r12-20020a05600c424c00b003b46359b301mr9399059wmm.125.1664877710425;
        Tue, 04 Oct 2022 03:01:50 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d3-20020a5d6dc3000000b0022e3cba367fsm5473645wrz.100.2022.10.04.03.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 03:01:50 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 04 Oct 2022 12:01:39 +0200
Subject: [PATCH v2 1/3] dt-bindings: iommu: mediatek: add binding documentation for
 MT8365 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221001-iommu-support-v2-1-dbfef2eeebc9@baylibre.com>
References: <20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com>
In-Reply-To: <20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com>
To: Rob Herring <robh+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Alexandre Mergnat <amergnat@baylibre.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Fabien Parent <fparent@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Amjad Ouled-Ameur <aouledameur@baylibre.com>, devicetree@vger.kernel.org,
 iommu@lists.linux.dev
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6140; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=XDDgL/nAc/yVfhySRg5fQSvB2yy2X96A0sg/pLmBfiI=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjPASLyCQhh1p5oK89+7HM/pTAZNpLHJaNLzqnTLyh
 dWFyDBKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCYzwEiwAKCRArRkmdfjHURbbQD/
 sEYgF/OcVD0T6MVcho0PMKaPJP+jRHhjAf5V58c0Xj8x11F19pfUsLBNF+Eelo6nrSTKLMfC9lwycO
 ptrDCa1dndDR5yjBMma/JrrWUMosbE+imYC4q5VRicdJhbZYJ9OXlO+osTcO31OmSHhIc/5RTcnHav
 t3GjQDPr4Q/FAeXj7KottyXrRF9aMGUrWZyujgR3LyzTNa9sxSOpxXs48yVStPR/EKiCwq2zZc5ZfF
 eEZoIr2YMUUgXk97zFanU/s4Cr9hyxi5FLkG2AS38PWRCjAXWnzb6BTDNKA3xytFYN8Je15T+OavfQ
 fQvnoFy1ibQEOQewJo8jARMxvr25Yjw5Ebmdm2mrQkmlawk+PTciMpQpKXur7SWzfLeM2ps8zNpUWX
 6CBrLqTXuWNS3HoYFVXzPs6dZl9x9g4Pd6WP9/Z5zv2kNNAnIqbaId++CDtzLNyJWSiglFoEPsmKLY
 RqfjNKm/EVlmivzNKSQDbXofkri276dKTKIFwO8F1WJ7j44PXy2alzMnSf0GxRPAhNw7Crd7KlN2S7
 wL0NIQE/7qe1gyxNhP7xgqE38g7vxVJPJ4QhKTeWYi+FsG4+z5DT9F8nxbrSTFQ6gy0m2jB9Xn2Miq
 JCDrt+4yb+GHA/Z3hwA1OlbZqyZg1bJXzjvr7JK/iKR1wZ0qEcxo5puLFDfA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

From: Fabien Parent <fparent@baylibre.com>

Add IOMMU binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |  2 +
 include/dt-bindings/memory/mt8365-larb-port.h      | 90 ++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index fee0241b5098..4b8cf3ce6963 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -81,6 +81,7 @@ properties:
           - mediatek,mt8195-iommu-vdo        # generation two
           - mediatek,mt8195-iommu-vpp        # generation two
           - mediatek,mt8195-iommu-infra      # generation two
+          - mediatek,mt8365-m4u  # generation two
 
       - description: mt7623 generation one
         items:
@@ -130,6 +131,7 @@ properties:
       dt-binding/memory/mt8186-memory-port.h for mt8186,
       dt-binding/memory/mt8192-larb-port.h for mt8192.
       dt-binding/memory/mt8195-memory-port.h for mt8195.
+      dt-binding/memory/mt8365-larb-port.h for mt8365.
 
   power-domains:
     maxItems: 1
diff --git a/include/dt-bindings/memory/mt8365-larb-port.h b/include/dt-bindings/memory/mt8365-larb-port.h
new file mode 100644
index 000000000000..56d5a5dd519e
--- /dev/null
+++ b/include/dt-bindings/memory/mt8365-larb-port.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Yong Wu <yong.wu@mediatek.com>
+ */
+#ifndef _DT_BINDINGS_MEMORY_MT8365_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT8365_LARB_PORT_H_
+
+#include <dt-bindings/memory/mtk-memory-port.h>
+
+#define M4U_LARB0_ID			0
+#define M4U_LARB1_ID			1
+#define M4U_LARB2_ID			2
+#define M4U_LARB3_ID			3
+
+/* larb0 */
+#define M4U_PORT_DISP_OVL0		MTK_M4U_ID(M4U_LARB0_ID, 0)
+#define M4U_PORT_DISP_OVL0_2L		MTK_M4U_ID(M4U_LARB0_ID, 1)
+#define M4U_PORT_DISP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 2)
+#define M4U_PORT_DISP_WDMA0		MTK_M4U_ID(M4U_LARB0_ID, 3)
+#define M4U_PORT_DISP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 4)
+#define M4U_PORT_MDP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 5)
+#define M4U_PORT_MDP_WROT1		MTK_M4U_ID(M4U_LARB0_ID, 6)
+#define M4U_PORT_MDP_WROT0		MTK_M4U_ID(M4U_LARB0_ID, 7)
+#define M4U_PORT_MDP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 8)
+#define M4U_PORT_DISP_FAKE0		MTK_M4U_ID(M4U_LARB0_ID, 9)
+#define M4U_PORT_APU_READ		MTK_M4U_ID(M4U_LARB0_ID, 10)
+#define M4U_PORT_APU_WRITE		MTK_M4U_ID(M4U_LARB0_ID, 11)
+
+/* larb1 */
+#define M4U_PORT_VENC_RCPU		MTK_M4U_ID(M4U_LARB1_ID, 0)
+#define M4U_PORT_VENC_REC		MTK_M4U_ID(M4U_LARB1_ID, 1)
+#define M4U_PORT_VENC_BSDMA		MTK_M4U_ID(M4U_LARB1_ID, 2)
+#define M4U_PORT_VENC_SV_COMV		MTK_M4U_ID(M4U_LARB1_ID, 3)
+#define M4U_PORT_VENC_RD_COMV		MTK_M4U_ID(M4U_LARB1_ID, 4)
+#define M4U_PORT_VENC_NBM_RDMA		MTK_M4U_ID(M4U_LARB1_ID, 5)
+#define M4U_PORT_VENC_NBM_RDMA_LITE	MTK_M4U_ID(M4U_LARB1_ID, 6)
+#define M4U_PORT_JPGENC_Y_RDMA		MTK_M4U_ID(M4U_LARB1_ID, 7)
+#define M4U_PORT_JPGENC_C_RDMA		MTK_M4U_ID(M4U_LARB1_ID, 8)
+#define M4U_PORT_JPGENC_Q_TABLE		MTK_M4U_ID(M4U_LARB1_ID, 9)
+#define M4U_PORT_JPGENC_BSDMA		MTK_M4U_ID(M4U_LARB1_ID, 10)
+#define M4U_PORT_JPGDEC_WDMA		MTK_M4U_ID(M4U_LARB1_ID, 11)
+#define M4U_PORT_JPGDEC_BSDMA		MTK_M4U_ID(M4U_LARB1_ID, 12)
+#define M4U_PORT_VENC_NBM_WDMA		MTK_M4U_ID(M4U_LARB1_ID, 13)
+#define M4U_PORT_VENC_NBM_WDMA_LITE	MTK_M4U_ID(M4U_LARB1_ID, 14)
+#define M4U_PORT_VENC_CUR_LUMA		MTK_M4U_ID(M4U_LARB1_ID, 15)
+#define M4U_PORT_VENC_CUR_CHROMA	MTK_M4U_ID(M4U_LARB1_ID, 16)
+#define M4U_PORT_VENC_REF_LUMA		MTK_M4U_ID(M4U_LARB1_ID, 17)
+#define M4U_PORT_VENC_REF_CHROMA	MTK_M4U_ID(M4U_LARB1_ID, 18)
+
+/* larb2 */
+#define M4U_PORT_CAM_IMGO		MTK_M4U_ID(M4U_LARB2_ID, 0)
+#define M4U_PORT_CAM_RRZO		MTK_M4U_ID(M4U_LARB2_ID, 1)
+#define M4U_PORT_CAM_AAO		MTK_M4U_ID(M4U_LARB2_ID, 2)
+#define M4U_PORT_CAM_LCS		MTK_M4U_ID(M4U_LARB2_ID, 3)
+#define M4U_PORT_CAM_ESFKO		MTK_M4U_ID(M4U_LARB2_ID, 4)
+#define M4U_PORT_CAM_CAM_SV0		MTK_M4U_ID(M4U_LARB2_ID, 5)
+#define M4U_PORT_CAM_CAM_SV1		MTK_M4U_ID(M4U_LARB2_ID, 6)
+#define M4U_PORT_CAM_LSCI		MTK_M4U_ID(M4U_LARB2_ID, 7)
+#define M4U_PORT_CAM_LSCI_D		MTK_M4U_ID(M4U_LARB2_ID, 8)
+#define M4U_PORT_CAM_AFO		MTK_M4U_ID(M4U_LARB2_ID, 9)
+#define M4U_PORT_CAM_SPARE		MTK_M4U_ID(M4U_LARB2_ID, 10)
+#define M4U_PORT_CAM_BPCI		MTK_M4U_ID(M4U_LARB2_ID, 11)
+#define M4U_PORT_CAM_BPCI_D		MTK_M4U_ID(M4U_LARB2_ID, 12)
+#define M4U_PORT_CAM_UFDI		MTK_M4U_ID(M4U_LARB2_ID, 13)
+#define M4U_PORT_CAM_IMGI		MTK_M4U_ID(M4U_LARB2_ID, 14)
+#define M4U_PORT_CAM_IMG2O		MTK_M4U_ID(M4U_LARB2_ID, 15)
+#define M4U_PORT_CAM_IMG3O		MTK_M4U_ID(M4U_LARB2_ID, 16)
+#define M4U_PORT_CAM_WPE0_I		MTK_M4U_ID(M4U_LARB2_ID, 17)
+#define M4U_PORT_CAM_WPE1_I		MTK_M4U_ID(M4U_LARB2_ID, 18)
+#define M4U_PORT_CAM_WPE_O		MTK_M4U_ID(M4U_LARB2_ID, 19)
+#define M4U_PORT_CAM_FD0_I		MTK_M4U_ID(M4U_LARB2_ID, 20)
+#define M4U_PORT_CAM_FD1_I		MTK_M4U_ID(M4U_LARB2_ID, 21)
+#define M4U_PORT_CAM_FD0_O		MTK_M4U_ID(M4U_LARB2_ID, 22)
+#define M4U_PORT_CAM_FD1_O		MTK_M4U_ID(M4U_LARB2_ID, 23)
+
+/* larb3 */
+#define M4U_PORT_HW_VDEC_MC_EXT		MTK_M4U_ID(M4U_LARB3_ID, 0)
+#define M4U_PORT_HW_VDEC_UFO_EXT	MTK_M4U_ID(M4U_LARB3_ID, 1)
+#define M4U_PORT_HW_VDEC_PP_EXT		MTK_M4U_ID(M4U_LARB3_ID, 2)
+#define M4U_PORT_HW_VDEC_PRED_RD_EXT	MTK_M4U_ID(M4U_LARB3_ID, 3)
+#define M4U_PORT_HW_VDEC_PRED_WR_EXT	MTK_M4U_ID(M4U_LARB3_ID, 4)
+#define M4U_PORT_HW_VDEC_PPWRAP_EXT	MTK_M4U_ID(M4U_LARB3_ID, 5)
+#define M4U_PORT_HW_VDEC_TILE_EXT	MTK_M4U_ID(M4U_LARB3_ID, 6)
+#define M4U_PORT_HW_VDEC_VLD_EXT	MTK_M4U_ID(M4U_LARB3_ID, 7)
+#define M4U_PORT_HW_VDEC_VLD2_EXT	MTK_M4U_ID(M4U_LARB3_ID, 8)
+#define M4U_PORT_HW_VDEC_AVC_MV_EXT	MTK_M4U_ID(M4U_LARB3_ID, 9)
+#define M4U_PORT_HW_VDEC_RG_CTRL_DMA_EXT MTK_M4U_ID(M4U_LARB3_ID, 10)
+
+#endif

-- 
b4 0.10.1
