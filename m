Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F763E
	for <iommu@lists.linux.dev>; Fri, 14 Oct 2022 08:45:37 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id l32so2678906wms.2
        for <iommu@lists.linux.dev>; Fri, 14 Oct 2022 01:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vYpiynuBL8tVx/fuIyN5pN5O/L7gpGwgZ6XiNd5Ka4=;
        b=ATcoSn4Z6sQZdKFeLqRKYSHN0u0vNhgyy0zhjbQp53nDzo2nleJ9ZJJc8nSHIgxgtN
         rWLuDj+BUUtThpcvO+qBnalmXyfY+ahKvHUzV/MAM/VxtETcW1yj2/py13EJFKb/kN1a
         SH18364ToIhgJx1t5XhbNRujcCw+6ye5x0Bg67ZN419De3SqvemhSsbhOhd6K8oMEpqX
         gXP79rjn0pKa9M0pgfmGccDN6Ulc0rWuvwBYkxvqIhqe+6GeIEu8Huoa87JWunuuK+zj
         WY7LzOUWz4S33zxGos4A6bWzuOzrpUFy2hqukWvAx5fWs+YHSaaUJTxnzvJDhYv6w9tp
         jQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vYpiynuBL8tVx/fuIyN5pN5O/L7gpGwgZ6XiNd5Ka4=;
        b=xBinyh9k3F3u6cg3JPbfNvZu4KynTyiE6T+IGVItT82mbTQymH9ZXAmsQkSQdVBbF6
         BlJsDPOc8J8wy6ar+w/m+MlDLHv+PTbLBiaMgyyZsv6paB1yEVzOaH9tX7ZhPHgd96ce
         r26htOj/v4+v0ZihNJagSMoa0g1XS/yjf4N4zXnUVHbmOqyTvULfsDKbEy6LpReBmT+n
         queSDJhK20J8AQnKy9c2Qip6pd5fA0SqwUJ4MLB5V/kpOf46WJ8V3k41syzSafeS3X5I
         3Whwd9Y/m+j24dOtH9u2G1VhSBbpoWAs2bk1K2oROnZImzNrJP0MTbLLQ02L+c+75K5b
         jvXQ==
X-Gm-Message-State: ACrzQf0kGayecHFXzOBg7vJc+daYuLx0Kw1Zgqr7FLENgkS8rs5ywGRK
	uAvQnYO3aRe3+b3/a3zQjHdNhg==
X-Google-Smtp-Source: AMsMyM59l8p7BDuPWIkS1zsAITNqaGhNOX+VDgAFG83ipX4KhNFhTz0Z1Fwg9ujQvpmIsLp7ehqBfA==
X-Received: by 2002:a05:600c:3b99:b0:3c6:8b8e:a624 with SMTP id n25-20020a05600c3b9900b003c68b8ea624mr2679874wms.113.1665737135401;
        Fri, 14 Oct 2022 01:45:35 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id m6-20020a1c2606000000b003c452678025sm6684633wmm.4.2022.10.14.01.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:45:34 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Fri, 14 Oct 2022 10:45:30 +0200
Subject: [PATCH v4 2/3] iommu/mediatek: add support for 6-bit encoded port IDs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221001-iommu-support-v4-2-f1e13438dfd2@baylibre.com>
References: <20221001-iommu-support-v4-0-f1e13438dfd2@baylibre.com>
In-Reply-To: <20221001-iommu-support-v4-0-f1e13438dfd2@baylibre.com>
To: Rob Herring <robh+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-mediatek@lists.infradead.org, Markus Schneider-Pargmann <msp@baylibre.com>,
 Amjad Ouled-Ameur <aouledameur@baylibre.com>, Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
 Alexandre Mergnat <amergnat@baylibre.com>, iommu@lists.linux.dev,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2777; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=yHI2W23j32Eio+qvj5sArGXxqz+yEaFNsPuEi2F1ESI=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjSSGr72jkaVUfd01lHWlH70E3IlRnthih2tTn4S8f
 oPgszB2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY0khqwAKCRArRkmdfjHURZcfD/
 4twP9fhese84RdEddlF784ECS6fOnHpJuYrStpE0X919HpgvHrCs1hKdO/vMDvxXxpNuvmoxwQzRRd
 /DHc7ulpPRkZB9Qj7f3N2O6Cf3OEHLUF7j2+XMbhEJ+tCr2Qr5nby1EXGdam8gM0efQQRBCFx0b/wY
 Pa3usFg0YPDrhhd3MfEYBq3U/C7WgOKtfxIB89WB7asYOzXEJY4PzmT3hUEYn+8X8OzR4k0Te66CG8
 Yi+j/vZepY4WkPWcL3ZYmu1DIbf6yUhitPo9gsuTeOFN9OpBOhzWrDJDQPL++LUZutFu9ZWK3HWjfc
 vtQKNzPPe8tRoMtgFF8s3bcgkuU4xepPuF6o628AsSbq6ffS3CgZ34T40kbsRGXaG3OA3sRIMAHEiz
 JhSY0qz22z45OrDrHnjeq1pfrD8KPqW/Sh1ELyWTd18ZlaHdTblGBP/uEvTdQED673ZJiS1YV/JWzI
 amTnWPPAIPyjY69yPGVthl0XAgtHtvQ0fJKUdo8mCQiwFtkqtCmZHRXUE5BJbvI8aWaZnJNjjSJ8kp
 7lGNUDntkhM1QGbZV+7eOV+K4pts5qbShv2iJfnEqUYYY0M3v8CxZV+Kgtz6cWp2wlh+G0CS5FtiMr
 KhyD1CZsisr9qmOML0uw8LqV4djKDRTsdLnWFYLQXcvKc/yRuZ5aumwLPw0g==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

From: Fabien Parent <fparent@baylibre.com>

Until now the port ID was always encoded as a 5-bit data. On MT8365,
the port ID is encoded as a 6-bit data. This requires to add extra
macro F_MMU_INT_ID_LARB_ID_EXT, and F_MMU_INT_ID_PORT_ID_EXT in order
to support 6-bit encoded port IDs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 5a4e00e4bbbc..50195a900611 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -108,8 +108,12 @@
 #define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
 #define F_MMU_INT_ID_COMM_ID_EXT(a)		(((a) >> 10) & 0x7)
 #define F_MMU_INT_ID_SUB_COMM_ID_EXT(a)		(((a) >> 7) & 0x7)
+/* Macro for 5 bits length port ID field (default) */
 #define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
 #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
+/* Macro for 6 bits length port ID field */
+#define F_MMU_INT_ID_LARB_ID_EXT(a)		(((a) >> 8) & 0x7)
+#define F_MMU_INT_ID_PORT_ID_EXT(a)		(((a) >> 2) & 0x3f)
 
 #define MTK_PROTECT_PA_ALIGN			256
 #define MTK_IOMMU_BANK_SZ			0x1000
@@ -139,6 +143,7 @@
 #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
 #define PGTABLE_PA_35_EN		BIT(17)
 #define TF_PORT_TO_ADDR_MT8173		BIT(18)
+#define HAS_INT_ID_PORT_WIDTH_6		BIT(19)
 
 #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
 				((((pdata)->flags) & (mask)) == (_x))
@@ -441,7 +446,11 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	fault_pa |= (u64)pa34_32 << 32;
 
 	if (MTK_IOMMU_IS_TYPE(plat_data, MTK_IOMMU_TYPE_MM)) {
-		fault_port = F_MMU_INT_ID_PORT_ID(regval);
+		if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_INT_ID_PORT_WIDTH_6)) {
+			fault_port = F_MMU_INT_ID_PORT_ID_EXT(regval);
+		} else {
+			fault_port = F_MMU_INT_ID_PORT_ID(regval);
+		}
 		if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_SUB_COMM_2BITS)) {
 			fault_larb = F_MMU_INT_ID_COMM_ID(regval);
 			sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
@@ -449,7 +458,11 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 			fault_larb = F_MMU_INT_ID_COMM_ID_EXT(regval);
 			sub_comm = F_MMU_INT_ID_SUB_COMM_ID_EXT(regval);
 		} else {
-			fault_larb = F_MMU_INT_ID_LARB_ID(regval);
+			if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_INT_ID_PORT_WIDTH_6)) {
+				fault_larb = F_MMU_INT_ID_LARB_ID_EXT(regval);
+			} else {
+				fault_larb = F_MMU_INT_ID_LARB_ID(regval);
+			}
 		}
 		fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
 	}

-- 
b4 0.10.1
