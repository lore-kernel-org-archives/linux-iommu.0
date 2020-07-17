Return-Path: <SRS0=Ppoz=A4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33960C433E5
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04782207CB
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hR7K/50Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04782207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E2FDC88090;
	Fri, 17 Jul 2020 00:16:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17zsJqVIjrHu; Fri, 17 Jul 2020 00:16:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1D3588805C;
	Fri, 17 Jul 2020 00:16:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01746C07FF;
	Fri, 17 Jul 2020 00:16:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10CE2C0733
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 00:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E3605203EF
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 00:16:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OoDcqcydeWxV for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jul 2020 00:16:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by silver.osuosl.org (Postfix) with ESMTPS id B7B8A203E4
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 00:16:23 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id d4so5775282pgk.4
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 17:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gz5Zo50XaaYCZ/NxMlikYXYKHZLd81NtOvGkTA8cH8o=;
 b=hR7K/50YBRAiYbzC5YEsIbA8rrB/9x+7sISP+RCiE+PEZ4V1DcU4bLgQSvldNsZ0c8
 DlWjm7LoKVY9Rz8e9IgppsSankyzITQqSY5b/cGexfVASMUQP3opQJ1PjW8bqK6geipV
 zSVYGSqXW0FVUmM3/qy2HG22nBoC6cvLoqstJ0bhcsawn5tbuBgigq9soHAc1TbbbrXI
 ygJEnHbepx4gjwD2rGloW4NabRJXyVxcmxqAPB5n1cfQloJRJi4jmiqmPJbLGPeOQVO1
 zKZqZBmmmRchgEeyycJ7FTZbWWgOm7MNjc4uGjYm6V4G7tYor5UqiYvFokYU6C0EjdDM
 C8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gz5Zo50XaaYCZ/NxMlikYXYKHZLd81NtOvGkTA8cH8o=;
 b=ijY5y8hWROqLv1+BhhqkPXDFUYlAt6XzV7xsSt/Leefpqjx1/BdohvS7vgXHVr//35
 ggjgFMMQSANtgVYZ5DZe8aAMaQqep2KVZiElVicCyRf7AVvK7uQ+ZNPV+MW8S7gIkjF7
 9VIRj1nrK6YWvYr2aWcvSoLBspHJazYYwOVFR5ud15sLTHdF2phLOdDBQaSVohFc9SrI
 p/+JXHxGs0JeWdApmc+BjRGPd03Mttj3KTAvDZjlZCNV01SpsCOsKMhkspSuDDS2BctW
 FZ9wRRsv2hUWHRbq7DEVbyMKRdMvTvHi0n5SCStS7iz8p6GqFPbMYV0bbgtusStw0sZM
 YcgA==
X-Gm-Message-State: AOAM531OPXxpKPY8HWwN2viQl6ozoJxivzOghJsguRneyWiijp3bael4
 vZwMLzULmi8MHZ9oQZlCgTizmg==
X-Google-Smtp-Source: ABdhPJy2pM1sb1dp82VBoREb9XieM3FFWojiWZR5vj1MXdZyzILDiZXH1IyjW0siveAEKiPXPp07Lw==
X-Received: by 2002:a63:e00c:: with SMTP id e12mr6451848pgh.413.1594944983134; 
 Thu, 16 Jul 2020 17:16:23 -0700 (PDT)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id r7sm6211950pgu.51.2020.07.16.17.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 17:16:22 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 1/5] iommu/arm-smmu: Make all valid stream mappings BYPASS
Date: Thu, 16 Jul 2020 17:16:15 -0700
Message-Id: <20200717001619.325317-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717001619.325317-1-bjorn.andersson@linaro.org>
References: <20200717001619.325317-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Marek <jonathan@marek.ca>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, John Stultz <john.stultz@linaro.org>,
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

Turn all stream mappings marked as valid into BYPASS. This allows the
platform specific implementation to configure stream mappings to match
the boot loader's configuration for e.g. display to continue to function
through the reset of the SMMU.

Tested-by: John Stultz <john.stultz@linaro.org>
Tested-by: Vinod Koul <vkoul@kernel.org>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Mark arm_smmu_setup_identity() static
- Picked up tested-by tags

 drivers/iommu/arm-smmu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 243bc4cb2705..fb85e716ae9a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1924,6 +1924,22 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static int arm_smmu_setup_identity(struct arm_smmu_device *smmu)
+{
+	int i;
+
+	for (i = 0; i < smmu->num_mapping_groups; i++) {
+		if (smmu->smrs[i].valid) {
+			smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
+			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
+			smmu->s2crs[i].cbndx = 0xff;
+			smmu->s2crs[i].count++;
+		}
+	}
+
+	return 0;
+}
+
 struct arm_smmu_match_data {
 	enum arm_smmu_arch_version version;
 	enum arm_smmu_implementation model;
@@ -2181,6 +2197,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = arm_smmu_setup_identity(smmu);
+	if (err)
+		return err;
+
 	if (smmu->version == ARM_SMMU_V2) {
 		if (smmu->num_context_banks > smmu->num_context_irqs) {
 			dev_err(dev,
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
