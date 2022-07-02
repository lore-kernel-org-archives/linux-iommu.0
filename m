Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A03C43334
	for <iommu@archiver.kernel.org>; Sat,  2 Jul 2022 21:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5E93C4063E;
	Sat,  2 Jul 2022 21:37:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E93C4063E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Me94KsgF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZDMXc-PIUy54; Sat,  2 Jul 2022 21:37:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D792D405F8;
	Sat,  2 Jul 2022 21:37:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D792D405F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B07AEC0032;
	Sat,  2 Jul 2022 21:37:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D59BDC002D
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D2ED960AB1
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:37:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2ED960AB1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Me94KsgF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bc1Mhs4PBj44 for <iommu@lists.linux-foundation.org>;
 Sat,  2 Jul 2022 21:37:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A15360A6C
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A15360A6C
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:37:29 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id n8so7044154eda.0
 for <iommu@lists.linux-foundation.org>; Sat, 02 Jul 2022 14:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KxNfqvGh9Dkg/Ylz1u5K33HiEHJDlDTxa5n3A3ldybk=;
 b=Me94KsgF2l25/VtjClrzXOurY47uvCOFfBo96GNvQ0dqyBJGRWw0HvuryG16InIHsg
 42ueHTmWL+quG64V1G7HkyB5jmP+xIMed8FLl7P0xqZQgaOn4opESi/YnArBL8Yv3B+I
 oO/Tf4+yWiRBPYAvjIDHFuTtSPEORWhHF67IltYBGUiqSUfXEdnUmvk22x1prSXi6pnj
 Etc0PbRfKOZgZ9Iex/as0SOwJuP7HTIPwaYmwgHWudeNdflB8n+BMO3V+6xqHrU3gGLP
 3UgWOFoCQ1iMyu2FWwqsYThO7W6BWAbl0FkEwOWAMqyOHVpcZi0VNPQINV7VLbc42jf9
 Q50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KxNfqvGh9Dkg/Ylz1u5K33HiEHJDlDTxa5n3A3ldybk=;
 b=puvSrXzCIfMe0QU2l8j2ZKyFld9l6+dSoitpfMIZCnuDL2mTV/+f1gHDtVWx7Rm/mt
 I/18v5uV6Xu+oEwOO3kwZ3UP1J3ayJB7gu/ay4vM1ryUoMnjDPPPzn7ANuV6aRTg+Gyw
 NLnOIujepzK7W8tRzylw1tbTigrqK7Ha0iRANCm7w09Ysk1lAUNvBYHbItEreSJqfulQ
 KcEfFiJudQKhrtzNVAhsWS2uSBlHS1mjCvjdF+zdn1pnnZ5eSMHaIuq2KI8AnE0tgNlD
 0SyG1KI8jixDx76adHb/0QobVfFmlmJHjLoR9c0BN5Y5TPt1jIyNbCH9gO4hTPonzkMU
 07vQ==
X-Gm-Message-State: AJIora+Wt2501iysziCSiVpwD7WMbf9daZP9UOFYkUUfjgr1PUmSrKeV
 UG2mCrSuw5vkU4ld6Hof7aVGkw==
X-Google-Smtp-Source: AGRyM1tDG6oe9EA4EzWZYsEDwSxNJe8GVmy2A/vhPa0sP6AZ1JAP27WJ8w7/4ZBkoKA+0ySR6z8AtA==
X-Received: by 2002:a05:6402:1774:b0:435:7fea:8c02 with SMTP id
 da20-20020a056402177400b004357fea8c02mr27855122edb.213.1656797847559; 
 Sat, 02 Jul 2022 14:37:27 -0700 (PDT)
Received: from localhost ([31.134.121.151]) by smtp.gmail.com with ESMTPSA id
 s8-20020a508dc8000000b00435c10b5daesm17297032edh.34.2022.07.02.14.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Jul 2022 14:37:27 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] iommu/exynos: Check if SysMMU v7 has VM registers
Date: Sun,  3 Jul 2022 00:37:22 +0300
Message-Id: <20220702213724.3949-3-semen.protsenko@linaro.org>
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

SysMMU v7 can have Virtual Machine registers, which implement multiple
translation domains. The driver should know if it's true or not, as VM
registers shouldn't be accessed if not present. Read corresponding
capabilities register to obtain that info, and store it in driver data.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 42 ++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 28f8c8d93aa3..df6ddbebbe2b 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -135,6 +135,9 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define CFG_SYSSEL	(1 << 22) /* System MMU 3.2 only */
 #define CFG_FLPDCACHE	(1 << 20) /* System MMU 3.2+ only */
 
+#define CAPA0_CAPA1_EXIST		BIT(11)
+#define CAPA1_VCR_ENABLED		BIT(14)
+
 /* common registers */
 #define REG_MMU_CTRL		0x000
 #define REG_MMU_CFG		0x004
@@ -171,6 +174,10 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define REG_V5_FAULT_AR_VA	0x070
 #define REG_V5_FAULT_AW_VA	0x080
 
+/* v7.x registers */
+#define REG_V7_CAPA0		0x870
+#define REG_V7_CAPA1		0x874
+
 #define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
 
 static struct device *dma_dev;
@@ -274,6 +281,9 @@ struct sysmmu_drvdata {
 	unsigned int version;		/* our version */
 
 	struct iommu_device iommu;	/* IOMMU core handle */
+
+	/* v7 fields */
+	bool has_vcr;			/* virtual machine control register */
 };
 
 static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
@@ -364,11 +374,7 @@ static void __sysmmu_disable_clocks(struct sysmmu_drvdata *data)
 
 static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 {
-	u32 ver;
-
-	__sysmmu_enable_clocks(data);
-
-	ver = readl(data->sfrbase + REG_MMU_VERSION);
+	const u32 ver = readl(data->sfrbase + REG_MMU_VERSION);
 
 	/* controllers on some SoCs don't report proper version */
 	if (ver == 0x80000001u)
@@ -378,6 +384,29 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 
 	dev_dbg(data->sysmmu, "hardware version: %d.%d\n",
 		MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
+}
+
+static bool __sysmmu_has_capa1(struct sysmmu_drvdata *data)
+{
+	const u32 capa0 = readl(data->sfrbase + REG_V7_CAPA0);
+
+	return capa0 & CAPA0_CAPA1_EXIST;
+}
+
+static void __sysmmu_get_vcr(struct sysmmu_drvdata *data)
+{
+	const u32 capa1 = readl(data->sfrbase + REG_V7_CAPA1);
+
+	data->has_vcr = capa1 & CAPA1_VCR_ENABLED;
+}
+
+static void sysmmu_get_hw_info(struct sysmmu_drvdata *data)
+{
+	__sysmmu_enable_clocks(data);
+
+	__sysmmu_get_version(data);
+	if (MMU_MAJ_VER(data->version) >= 7 && __sysmmu_has_capa1(data))
+		__sysmmu_get_vcr(data);
 
 	__sysmmu_disable_clocks(data);
 }
@@ -623,6 +652,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	data->sysmmu = dev;
 	spin_lock_init(&data->lock);
 
+	sysmmu_get_hw_info(data);
+
 	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
 				     dev_name(data->sysmmu));
 	if (ret)
@@ -634,7 +665,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	__sysmmu_get_version(data);
 	if (PG_ENT_SHIFT < 0) {
 		if (MMU_MAJ_VER(data->version) < 5) {
 			PG_ENT_SHIFT = SYSMMU_PG_ENT_SHIFT;
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
