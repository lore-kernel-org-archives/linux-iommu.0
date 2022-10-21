Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E917FC
	for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 13:42:25 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id a10so4407825wrm.12
        for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 06:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqOMgMO4fRXqFN7+sEeqPMZsELyoKuJNhCumBVCnYwM=;
        b=jkMMUDA7tBEY5BW0P0DFVUEwi6Puu9sr20YsRRvngDbDWG6XO0+EF4jDSFaVLYS884
         7NmGpyiVqo8qk78KIIPplhZeOFJbhj16d7045h4T6Skm7g7rAo0mduZRgEUk6o9SvkIN
         J8iL+J+LmNv0Ir9mh5F7XDMAgcmZZa1rk4P6H1rAPxtheeit+T14J4FcT/hSVF5XFGUq
         uUnfKx0FvBY1x05ozXe3dw5GAfCwQmo4QAza7uRwy4idcU8GiY9s7hyecU+IMmzMzKxo
         +IBjA83ROO/EUNGmOvhhn6nQW7BXDk+rU/fXD/WVsRqhRdnnU2wZTiuLlp3wug6NzGSz
         QUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqOMgMO4fRXqFN7+sEeqPMZsELyoKuJNhCumBVCnYwM=;
        b=e7/i2zsZupu+HbRYhgKPLwPnDkRi9PljeJiVVK/vkssMIM38gC4XYxf6YSRJmZn/wg
         m73gxps3GFsG1/n+O6vH0TP5Vwsi1q4zDa+9qUpnvYgJ1zUaKScBmmCu9XTFyp8/Y7a+
         tn3flODY2wQSERF/Y0WbmU2gYceOznN07RGJuB4rxrnzBvUSRro5/KV20XMgNWLyuSGX
         0wxUtf5Zc3kjQNyhReTyyNB2wsK5sGvq+QvnhOrDe40o2I4EQp8/cmDT1BNnrnAqKKcH
         DfC03HlVp863tMItRAbeEqw4LYvhmvPPFkNxbCpte0U5pD1JAW3D9qPHMK0OaALS3ZrK
         1FFg==
X-Gm-Message-State: ACrzQf1OeRUS9rCyRs4joRvM6p25k+DecTq4OC5R3ybmYwDgFlZGB3Wm
	RdLv3a3j2REGeS7j4DxRjxVmZA==
X-Google-Smtp-Source: AMsMyM4eaa8ZRO33JVjSblX1N1v4yUy0W9L7PUTzNauH4jzDxTJkMtsAMF/4xE0hOVvB79QUzihkEw==
X-Received: by 2002:a5d:4647:0:b0:22e:3608:aff5 with SMTP id j7-20020a5d4647000000b0022e3608aff5mr12047260wrs.162.1666359743231;
        Fri, 21 Oct 2022 06:42:23 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id h5-20020adfe985000000b002322bff5b3bsm22966355wrm.54.2022.10.21.06.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:42:22 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Fri, 21 Oct 2022 15:42:18 +0200
Subject: [PATCH v5 3/3] iommu/mediatek: add support for MT8365 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221001-iommu-support-v5-3-92cdbb83bbb8@baylibre.com>
References: <20221001-iommu-support-v5-0-92cdbb83bbb8@baylibre.com>
In-Reply-To: <20221001-iommu-support-v5-0-92cdbb83bbb8@baylibre.com>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Alexandre Mergnat <amergnat@baylibre.com>, linux-kernel@vger.kernel.org,
 Amjad Ouled-Ameur <aouledameur@baylibre.com>, devicetree@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, Markus Schneider-Pargmann <msp@baylibre.com>, linux-mediatek@lists.infradead.org,
 iommu@lists.linux.dev, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=hsmOOJ/Od8mVlqkmioVr/SU8CCmVi1MpCgod71DtGtE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjUqG7M6Sue3UP1B/Wgzp2kgC06YW9ljbQL87P5Z0h
 Fw6/qgqJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY1KhuwAKCRArRkmdfjHURaJMD/
 0dxN1PmOTdSgFQdXab9NdfC3fprdPuhHnEdb5g7cDcxTqsh3PRhpBbcUQHSHMJif78ulPLy41zns5s
 wdLFb3ddGfDt8cD+z9QJ+siKPnBiAwaTp9VHISy7vu1ZiKSSP9MUmbuMeMs9bLzdLNijZIFl8mSyCC
 43TuVoa3B5k9S7XiYdCjefjVo8JIlnkhhnSSrBh9W6+LxiBv3iWqyq1d0hAQsVrfEBicznfVVDO9Xp
 7xIfBnF/VC3liMMAqEedkcXQE9QiT0FSr5yvkXFZ2xkWT56lndyjGBAiKJhTimPl/gpiVNwc7GamrL
 Xrex38uM0IGAYJjksxKLxGadxcw0020xBXwJx4mdBRWuQo1p4i8gBdLvnKjrawO4WRgoc6lrLlXtHO
 3I7hwK0ZWlsJl4j7oUqpKdLHCpRuVKkYAoYzPGndgVuMprg+FnN8umVbcEqhXLfD5XS2xSQHejm3Kf
 fuq44UlubFKex1JtXrMagNrBGkF0P/UVI8yf+lf9Yd725CCoN86YBLaBE+6NRDPNoCA3f40ALqYaEi
 cCxTlv4gxL2FHV4d0ADGqflFidce/9UXMXFVFTvaxDQOD7hYTU+VofvHb7kQi3vJLdQaU0nATmVUYo
 0UOVDqEb0cYdrVWT/56WZoUyeglDSO2T132CH2hKIgziIxXWLLew5HPq7fVQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

From: Fabien Parent <fparent@baylibre.com>

Add IOMMU support for MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Tested-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 563e3c54a0e2..aff7a9190749 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -170,6 +170,7 @@ enum mtk_iommu_plat {
 	M4U_MT8186,
 	M4U_MT8192,
 	M4U_MT8195,
+	M4U_MT8365,
 };
 
 struct mtk_iommu_iova_region {
@@ -1525,6 +1526,17 @@ static const struct mtk_iommu_plat_data mt8195_data_vpp = {
 			   {4, MTK_INVALID_LARBID, MTK_INVALID_LARBID, MTK_INVALID_LARBID, 6}},
 };
 
+static const struct mtk_iommu_plat_data mt8365_data = {
+	.m4u_plat	= M4U_MT8365,
+	.flags		= RESET_AXI | INT_ID_PORT_WIDTH_6,
+	.inv_sel_reg	= REG_MMU_INV_SEL_GEN1,
+	.banks_num	= 1,
+	.banks_enable	= {true},
+	.iova_region	= single_domain,
+	.iova_region_nr	= ARRAY_SIZE(single_domain),
+	.larbid_remap	= {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
+};
+
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
@@ -1537,6 +1549,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
 	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
 	{ .compatible = "mediatek,mt8195-iommu-vpp",   .data = &mt8195_data_vpp},
+	{ .compatible = "mediatek,mt8365-m4u", .data = &mt8365_data},
 	{}
 };
 

-- 
b4 0.10.1
