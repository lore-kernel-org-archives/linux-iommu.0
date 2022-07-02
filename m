Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5BCC433EF
	for <iommu@archiver.kernel.org>; Sat,  2 Jul 2022 21:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44C3481768;
	Sat,  2 Jul 2022 21:37:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44C3481768
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BqX0hBiy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9eTaC51fdWaj; Sat,  2 Jul 2022 21:37:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2306281516;
	Sat,  2 Jul 2022 21:37:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2306281516
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2F2AC0081;
	Sat,  2 Jul 2022 21:37:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40383C002D
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:37:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1576540614
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:37:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1576540614
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=BqX0hBiy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NtzGV31nLbTh for <iommu@lists.linux-foundation.org>;
 Sat,  2 Jul 2022 21:37:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1A19405F8
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1A19405F8
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:37:30 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id ay16so10046958ejb.6
 for <iommu@lists.linux-foundation.org>; Sat, 02 Jul 2022 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fjkLlnpo3rJV91gWG5Ub4TjaCmhb4e/5Gjwv7rGBuNk=;
 b=BqX0hBiyoAeYzJvTN5zLo10CPIik6CQ1uuNpCfO3oq+RooTR3lviNeDHJH/TUUuJKS
 wUSkXeozyQgNLTM/cvKl2jPJTrzSH0myVq5M75OZivSySF+gkQJ24NlIDVVgrMbqLVGX
 wkH/4iI0lA4+uHrtf1nuF5wtDyjpFzVf22KES+ZXA7mX/AmqqcIl6kcFyx2NZ2gOLDlt
 p9mSagqMQh+9sF09gikAhlQeJfk12Cqxl0F9W852boCwBSMqhYRwIUoyGMhDm7HXBKL7
 g2SABFfGTM0PskN5Bd0582SNluuYumuv8oc6R2l95M6DBu0m7EL/q/aAicGaXR/wWln5
 Y6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fjkLlnpo3rJV91gWG5Ub4TjaCmhb4e/5Gjwv7rGBuNk=;
 b=Y5daXVxKMGbor39e57r4YHDFKwQC2FULCcK+scaviMOQNOvp3AevyApyKMqyRelm1m
 7NqLknOQvdizkJlfFAqcuDBx8VDnKoLd1jJJAEZZU0u7bbc4n0ja47LbifUgHGcPIafK
 XBE8yZHeP8qBRNRJITzZSH6UZsMwattlYzP50K+CYcRXsfsehieT3cY53KwSepnIl63+
 ZVE9hWtanKNn9r4We2vu65hpf61iK77yWy/SRgEIfxzWu1O8lnqbPiJA5BnfkUndQeax
 prZnEwXcHmir0P1liLQnL+yRwv74eliuLnnWgDg31EhBMPx5hLutpjtKByWL2c4Zj1BA
 Y8ow==
X-Gm-Message-State: AJIora8e5pGZSZvU8X98HbQIhjWQ60Rflf0oNbnD7dFgn02pIIFXhOmH
 iiFjMvdqMzRaZKuBeUu3KwdX3g==
X-Google-Smtp-Source: AGRyM1tIDyoc701JH7tqf6GG8NYNGAr1P57wdNbZb5l5imY87uRjSo8YlTS/OW6VjdvCTXTf8Tu4AA==
X-Received: by 2002:a17:906:8a53:b0:72a:8a2d:db61 with SMTP id
 gx19-20020a1709068a5300b0072a8a2ddb61mr10421953ejc.674.1656797848790; 
 Sat, 02 Jul 2022 14:37:28 -0700 (PDT)
Received: from localhost ([31.134.121.151]) by smtp.gmail.com with ESMTPSA id
 lo17-20020a170906fa1100b0072696b3a327sm9436558ejb.187.2022.07.02.14.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Jul 2022 14:37:28 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] iommu/exynos: Use lookup based approach to access v7
 registers
Date: Sun,  3 Jul 2022 00:37:23 +0300
Message-Id: <20220702213724.3949-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220702213724.3949-1-semen.protsenko@linaro.org>
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 linux-samsung-soc@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Cho KyongHo <pullip.cho@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SysMMU v7 might have different register layouts (VM capable or non-VM
capable). Check which layout is implemented in current SysMMU module and
prepare the corresponding register table for futher usage. This way is
faster and more elegant than checking corresponding condition (if it's
VM or non-VM SysMMU) each time before accessing v7 registers. For now
the register table contains only most basic registers needed to add the
SysMMU v7 support.

This patch is based on downstream work of next authors:
  - Janghyuck Kim <janghyuck.kim@samsung.com>
  - Daniel Mentz <danielmentz@google.com>

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index df6ddbebbe2b..47017e8945c5 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -180,6 +180,47 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 
 #define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
 
+#define MMU_REG(data, idx)		\
+	((data)->sfrbase + (data)->regs[idx].off)
+#define MMU_VM_REG(data, idx, vmid)	\
+	(MMU_REG(data, idx) + (vmid) * (data)->regs[idx].mult)
+
+enum {
+	REG_SET_NON_VM,
+	REG_SET_VM,
+	MAX_REG_SET
+};
+
+enum {
+	IDX_CTRL_VM,
+	IDX_CFG_VM,
+	IDX_FLPT_BASE,
+	IDX_ALL_INV,
+	MAX_REG_IDX
+};
+
+struct sysmmu_vm_reg {
+	unsigned int off;	/* register offset */
+	unsigned int mult;	/* VM index offset multiplier */
+};
+
+static const struct sysmmu_vm_reg sysmmu_regs[MAX_REG_SET][MAX_REG_IDX] = {
+	/* Default register set (non-VM) */
+	{
+		/*
+		 * SysMMUs without VM support do not have CTRL_VM and CFG_VM
+		 * registers. Setting the offsets to 1 will trigger an unaligned
+		 * access exception.
+		 */
+		{0x1}, {0x1}, {0x000c}, {0x0010},
+	},
+	/* VM capable register set */
+	{
+		{0x8000, 0x1000}, {0x8004, 0x1000}, {0x800c, 0x1000},
+		{0x8010, 0x1000},
+	},
+};
+
 static struct device *dma_dev;
 static struct kmem_cache *lv2table_kmem_cache;
 static sysmmu_pte_t *zero_lv2_table;
@@ -284,6 +325,7 @@ struct sysmmu_drvdata {
 
 	/* v7 fields */
 	bool has_vcr;			/* virtual machine control register */
+	const struct sysmmu_vm_reg *regs; /* register set */
 };
 
 static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
@@ -407,6 +449,10 @@ static void sysmmu_get_hw_info(struct sysmmu_drvdata *data)
 	__sysmmu_get_version(data);
 	if (MMU_MAJ_VER(data->version) >= 7 && __sysmmu_has_capa1(data))
 		__sysmmu_get_vcr(data);
+	if (data->has_vcr)
+		data->regs = sysmmu_regs[REG_SET_VM];
+	else
+		data->regs = sysmmu_regs[REG_SET_NON_VM];
 
 	__sysmmu_disable_clocks(data);
 }
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
