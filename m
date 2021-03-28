Return-Path: <SRS0=8IIh=I2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CD4C433C1
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 23:34:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A594E61948
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 23:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A594E61948
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5921D400C8;
	Sun, 28 Mar 2021 23:34:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dSNulc8rm5e1; Sun, 28 Mar 2021 23:34:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 431A0400C9;
	Sun, 28 Mar 2021 23:34:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12EFBC000C;
	Sun, 28 Mar 2021 23:34:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20397C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 059386067E
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:34:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NkYTg7ibVKyc for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:34:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3A116066E
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:34:38 +0000 (UTC)
Received: by mail-qk1-x72d.google.com with SMTP id c3so10897467qkc.5
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=utR9Ua8PasQv/qM4orgEKume/FeHhlE56ieKCoQZzf8=;
 b=CU9ivXrg2DYVFljOnN+YtABR/taupBmETagCLavCliciPvfDyHuUYSjjvWw16wAhhu
 moIalC15lKpeeZnufYNzBLqNbWxLxz23itVfLCbBmV5udE5DJLnFBEqg6DjsCr9gdoDy
 HOdGG6K6St9bO4t+lQ7y78rZ2Gt0g5HZDaU328m6CjlUlHKt4qIvqvxqnAfsK/3J5uQX
 f/46tGH08UyZQhNMjsGXxZVEGQNQ2bqKz2K8vX32meCyWqb/SZiyZOHhQGr/0RnCTtPL
 OL74/lTsHLTSkA4h8eEXIh8r/NNK8SYL+8M7ufmn0TebTNV9P+5ujdz9C3/T0wsyKOZ0
 rs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=utR9Ua8PasQv/qM4orgEKume/FeHhlE56ieKCoQZzf8=;
 b=OzgJGAen5RxMqnlT0hcl7/r7d0m47j0r1guRNY16iwz8UotwY6bWDSnH75b+ftDh2a
 EFWBNPQGXcke6pCh188jZNi9wPknMKcYO2tGAkNYEtgPE5mkJZSeq0jr8X9n1ImisHZU
 NbgtxKLBiPGc/d+DFlG5A7/2CYI7Pu4m9CtKR+2/Nx13bXfT9PqfN+F0JTIradwrGcv/
 wAcv4wxShFCZVOGbvWSuF8s9G705mxtcAes5PG91d9ZEMK7+nYldb1uyUccZ8dpLtygh
 HflBum8WsKTps9d9uAdoYc1aJrOjhRBlLumFrzlpxUXQCDXG6e4f5C1Myu28EUab57YZ
 nsSQ==
X-Gm-Message-State: AOAM5318oNqYZTQtc+m3xTa8RKoE/XQnAyfdTyhqxCtT5cNyo5EThrk8
 Xyb0Sf5N76+Wgh6Py8dsfeQ=
X-Google-Smtp-Source: ABdhPJz4mD3jUksqqD9/XrLKQu8py5npXtytv1j0f1hmNJ31dgMwOw2zHiMSuKpP3/WpcAhNZELOcg==
X-Received: by 2002:a05:620a:15b4:: with SMTP id
 f20mr15849272qkk.175.1616974477751; 
 Sun, 28 Mar 2021 16:34:37 -0700 (PDT)
Received: from localhost.localdomain ([2a00:1370:814d:b259:a10:76ff:fe69:21b6])
 by smtp.gmail.com with ESMTPSA id g2sm10117905qtu.0.2021.03.28.16.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:34:37 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v1 2/2] iommu/tegra-smmu: Revert workaround that was needed
 for Nyan Big Chromebook
Date: Mon, 29 Mar 2021 02:32:56 +0300
Message-Id: <20210328233256.20494-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210328233256.20494-1-digetx@gmail.com>
References: <20210328233256.20494-1-digetx@gmail.com>
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

The previous commit fixes problem where display client was attaching too
early to IOMMU during kernel boot in a multi-platform kernel configuration
which enables CONFIG_ARM_DMA_USE_IOMMU=y. The workaround that helped to
defer the IOMMU attachment for Nyan Big Chromebook isn't needed anymore,
revert it.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 71 +-------------------------------------
 1 file changed, 1 insertion(+), 70 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index af1e4b5adb27..572a4544ae88 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -869,69 +869,10 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 	return SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova);
 }
 
-static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
-{
-	struct platform_device *pdev;
-	struct tegra_mc *mc;
-
-	pdev = of_find_device_by_node(np);
-	if (!pdev)
-		return NULL;
-
-	mc = platform_get_drvdata(pdev);
-	if (!mc)
-		return NULL;
-
-	return mc->smmu;
-}
-
-static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
-				struct of_phandle_args *args)
-{
-	const struct iommu_ops *ops = smmu->iommu.ops;
-	int err;
-
-	err = iommu_fwspec_init(dev, &dev->of_node->fwnode, ops);
-	if (err < 0) {
-		dev_err(dev, "failed to initialize fwspec: %d\n", err);
-		return err;
-	}
-
-	err = ops->of_xlate(dev, args);
-	if (err < 0) {
-		dev_err(dev, "failed to parse SW group ID: %d\n", err);
-		iommu_fwspec_free(dev);
-		return err;
-	}
-
-	return 0;
-}
-
 static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 {
-	struct device_node *np = dev->of_node;
-	struct tegra_smmu *smmu = NULL;
-	struct of_phandle_args args;
-	unsigned int index = 0;
-	int err;
-
-	while (of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
-					  &args) == 0) {
-		smmu = tegra_smmu_find(args.np);
-		if (smmu) {
-			err = tegra_smmu_configure(smmu, dev, &args);
-
-			if (err < 0) {
-				of_node_put(args.np);
-				return ERR_PTR(err);
-			}
-		}
-
-		of_node_put(args.np);
-		index++;
-	}
+	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
 
-	smmu = dev_iommu_priv_get(dev);
 	if (!smmu)
 		return ERR_PTR(-ENODEV);
 
@@ -1158,16 +1099,6 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	if (!smmu)
 		return ERR_PTR(-ENOMEM);
 
-	/*
-	 * This is a bit of a hack. Ideally we'd want to simply return this
-	 * value. However the IOMMU registration process will attempt to add
-	 * all devices to the IOMMU when bus_set_iommu() is called. In order
-	 * not to rely on global variables to track the IOMMU instance, we
-	 * set it here so that it can be looked up from the .probe_device()
-	 * callback via the IOMMU device's .drvdata field.
-	 */
-	mc->smmu = smmu;
-
 	size = BITS_TO_LONGS(soc->num_asids) * sizeof(long);
 
 	smmu->asids = devm_kzalloc(dev, size, GFP_KERNEL);
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
