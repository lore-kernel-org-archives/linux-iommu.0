Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35547C43461
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 00:27:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A953C206DB
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 00:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgWQy05z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A953C206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2BC4886CDB;
	Wed, 16 Sep 2020 00:27:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mlCdBfYPNNII; Wed, 16 Sep 2020 00:27:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5782486C3E;
	Wed, 16 Sep 2020 00:27:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B060C0859;
	Wed, 16 Sep 2020 00:27:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A5E5C0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 00:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 83D9A868E4
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 00:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GbRfRnkBHU49 for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 00:27:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 53C5A868E1
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 00:27:03 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id o68so2944248pfg.2
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 17:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=urfxkx3OR1ztSEhIX65Ge5+NGsQrAveOSK0sp6kZKXA=;
 b=dgWQy05zNJUnJvdQqHziPnzCh1nOaOEkOIssdUMkSvRCWew96H4adTWK60g/pm4qZQ
 NYiKNAzKZABBY0/LzblOnFVWhWQ2vmDzS4VCTOqJNj8szJmfa4ByQDh8KUsvGXTmb/YY
 UMAsrscS3qmBifIWXzTBrLvGRWSqqS7jdaxn7vcJFriKvPSTt/qAbbTxm9LULoDDX7CG
 ezHNrTiQHjWfecw0wEMmmXoFDz6OK3ZmnEBs56AgWQVmoVrJ+keEMt7BYEDeL4XXD1sN
 HUdw1Z3Md6aehMprn8wdEctTiLn6ci3yK0NSztkSNn4LUD6EJe81JGkRTYKkwM14wual
 jBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=urfxkx3OR1ztSEhIX65Ge5+NGsQrAveOSK0sp6kZKXA=;
 b=C31WXp1dypKV+tkmO3e8sw7Raw6ZxhftNKVtVWq4eiVC1gLdNfcsVT1sgdqMfrlJru
 w6KD4H1DlF6gkimNlRGVXiavzEFevSAlKUaqVeoen6Nm+EUpG/fi3rJLTfaeUggYbJ4C
 9Ccv57hMn4pthNaPTJFlp6C1ZAQvyKnqOu56CNzWC9l5wkvp8RV26ztSkiwRYolfxR9b
 7ve93yFLy/hzEzGMK2G2+ww0sApfOo5t+FFwdl7oJ9R8XJD1gX0Qx6x/9+QtfYOj7Kq1
 uS+LLdGC5CaDI1Ae/vZqL+HVeEDfBnF3LhzzTbc3GuCilaF++flifbHjydNiJtzJvdI8
 ss8g==
X-Gm-Message-State: AOAM532kkgeF73AGFwyWvHppTMIGV5KsrAU/2jRE4rbWlOkazQAj5F2o
 nGYo/waLE/y0/H/YnJAf8hQ=
X-Google-Smtp-Source: ABdhPJxqZUpJ2KjMHLyoOyJyyeAlMxBIRQdOJAjBKieBwezCDHtwFX49SqsG8HhjDN98jhf4PbJ5ag==
X-Received: by 2002:a05:6a00:1507:b029:13e:d13d:a13c with SMTP id
 q7-20020a056a001507b029013ed13da13cmr20277411pfu.36.1600216022778; 
 Tue, 15 Sep 2020 17:27:02 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id s66sm14876761pfc.159.2020.09.15.17.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 17:27:02 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: joro@8bytes.org,
	thierry.reding@gmail.com
Subject: [PATCH] iommu/tegra-smmu: Fix tlb_mask
Date: Tue, 15 Sep 2020 17:23:59 -0700
Message-Id: <20200916002359.10823-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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

The "num_tlb_lines" might not be a power-of-2 value, being 48 on
Tegra210 for example. So the current way of calculating tlb_mask
using the num_tlb_lines is not correct: tlb_mask=0x5f in case of
num_tlb_lines=48, which will trim a setting of 0x30 (48) to 0x10.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 84fdee473873..0becdbfea306 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1120,7 +1120,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 		BIT_MASK(mc->soc->num_address_bits - SMMU_PTE_SHIFT) - 1;
 	dev_dbg(dev, "address bits: %u, PFN mask: %#lx\n",
 		mc->soc->num_address_bits, smmu->pfn_mask);
-	smmu->tlb_mask = (smmu->soc->num_tlb_lines << 1) - 1;
+	smmu->tlb_mask = (1 << fls(smmu->soc->num_tlb_lines)) - 1;
 	dev_dbg(dev, "TLB lines: %u, mask: %#lx\n", smmu->soc->num_tlb_lines,
 		smmu->tlb_mask);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
