Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35C5C4727C
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 00:35:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A442074F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 00:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYP6dVXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A442074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B4E1A8700A;
	Wed, 30 Sep 2020 00:35:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 26oHYQA0UuFc; Wed, 30 Sep 2020 00:35:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2ACA686FCF;
	Wed, 30 Sep 2020 00:35:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F139C0889;
	Wed, 30 Sep 2020 00:35:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04F0AC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E186785FFC
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:35:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WMzha9Y0W4-W for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 00:35:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E8E0D85FCB
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:35:45 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id b124so6518679pfg.13
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ieGK1piaFJ3x1ASrTXBWUe7WNEu41fomUmQ319XUfAE=;
 b=cYP6dVXNanrhoQbRMFkC7pgWEOb7q+vMr9eSN4XWX6HagPZa0wvlfWLzA8lupcwtLQ
 V/yoEtJFQc0kTloP6A1xP8yBzOJdcVKK5Z9m4dsv5KXqnUz88bQN5iXBda31HpDCb5HL
 wHI8YKMrgRI+SMHJFDhtfdsSH6KQ/PcmSNUJnwQFi0gCZJ7unpT7SdfqRCMSYy3nUQqj
 tP4U4MvpUTgaXpW09OzOLhTP59DyETshquEFbu2mNAEjrIKRPMq0ff0vAikVdtUdXSh1
 296EggXRHUSldGpN2NfQAB+1ERoYKZDVa5sqkJzLEBZmPaLAodaft02H+ICGMdPMx71M
 zXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ieGK1piaFJ3x1ASrTXBWUe7WNEu41fomUmQ319XUfAE=;
 b=WB6nYSrT7MPQx6ADBz2Oox6puBJZ43/lHZM6qUcHpOKCZxfokT6qlkPLGZR2w6l+FU
 TqgTeXFxtHj2r306lWjWHzpV0Gla9fc/nqux2cyrIlpeWlwbRRMC8a35Gq34BHAYXLsh
 sZNDPYavjZStrL2v7AtDj2gSUL1HqxC3ZPmGY+unYo+ze4l+GLtyeSU+UkBHx5L5vaP6
 0nkfxscvBVSRk/7mppZ+4Pkxujm0Ewo8pOTD1l22aSmoxaI83jLM1ucBrh71BcXcHMjm
 M14H5tVewFCRFWK8HE6ZOmdpL2e4PBtSkWITAu9Xr/QczbKYwt1/5gwSsbEAlcZFmNwf
 C+wg==
X-Gm-Message-State: AOAM532t+c4I1dgLX80Svx3QtQDUY0xYzwPTnMyePDrAap3iweDFxE/N
 Ow5KVyCbXgXO9UekCMhjl84=
X-Google-Smtp-Source: ABdhPJz3X5UmoZnmvzXt9ned7FDpg71Qagha65Tza0ya481tSpAeKXhOV1ieT6Vvsli7UvTn1d84xA==
X-Received: by 2002:a17:902:8643:b029:d1:920c:c1db with SMTP id
 y3-20020a1709028643b02900d1920cc1dbmr134821plt.42.1601426145485; 
 Tue, 29 Sep 2020 17:35:45 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id x185sm6904738pfc.188.2020.09.29.17.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 17:35:45 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com, joro@8bytes.org, krzk@kernel.org,
 digetx@gmail.com
Subject: [PATCH v2 1/3] memory: tegra: Add helper function
 tegra_get_memory_controller
Date: Tue, 29 Sep 2020 17:30:11 -0700
Message-Id: <20200930003013.31289-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930003013.31289-1-nicoleotsuka@gmail.com>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This can be used by both tegra-smmu and tegra20-devfreq drivers.

Suggested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Changelog
v1->v2
 * N/A

 drivers/memory/tegra/mc.c | 23 +++++++++++++++++++++++
 include/soc/tegra/mc.h    |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index ec8403557ed4..09352ad66dcc 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -42,6 +42,29 @@ static const struct of_device_id tegra_mc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
 
+struct tegra_mc *tegra_get_memory_controller(void)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+	struct tegra_mc *mc;
+
+	np = of_find_matching_node_and_match(NULL, tegra_mc_of_match, NULL);
+	if (!np)
+		return ERR_PTR(-ENOENT);
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
+
+	mc = platform_get_drvdata(pdev);
+	if (!mc)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return mc;
+}
+EXPORT_SYMBOL_GPL(tegra_get_memory_controller);
+
 static int tegra_mc_block_dma_common(struct tegra_mc *mc,
 				     const struct tegra_mc_reset *rst)
 {
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 1238e35653d1..c72718fd589f 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -183,5 +183,6 @@ struct tegra_mc {
 
 int tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
 unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
+struct tegra_mc *tegra_get_memory_controller(void);
 
 #endif /* __SOC_TEGRA_MC_H__ */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
