Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B2AC433E0
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 05:08:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95943206E2
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 05:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOLHWt2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95943206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4A52323235;
	Thu,  9 Jul 2020 05:08:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r85CtqNH8uve; Thu,  9 Jul 2020 05:08:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F09F721517;
	Thu,  9 Jul 2020 05:08:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC065C0865;
	Thu,  9 Jul 2020 05:08:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44279C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3C5AD21517
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:08:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DTYycMw-FM4G for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 05:08:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by silver.osuosl.org (Postfix) with ESMTPS id CDA202047F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:08:23 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id k4so936533oik.2
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jul 2020 22:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T+6WxJ1O6k89NNQZzhHWgQkm03zUeIAl0iKHL4vPlUk=;
 b=AOLHWt2GPk9pGPq6HPxBOiLg8IkaE8fySTF+79CaOlFbY/Ii9OChxP90kbGu1Kpp4g
 1geiQB3FJADTo1pUFgW3Sxa65geoU2CT5za4/L0HfEdsLOAuiS/hjjGJAhLd5WpirmZf
 FtqNIv1CQKnyDdPXdmuFBCNC6yhLvo2cYc6qSM5QnmTXkmdX5EeDxnIrVvTmG4ZIadtN
 9Wc0sp5jXMyQsZ3p/wY2QYy7Ht2049b7nCZwdk1eGIpkU//mzH2EjylQGA8lOiKrtshJ
 LlRfr/5BOfigasYH241F2AoEDk2ymoYdc1UD+9rYiSk5J9TrKnHdKxLfuGL8+sE3Lbxw
 Lrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T+6WxJ1O6k89NNQZzhHWgQkm03zUeIAl0iKHL4vPlUk=;
 b=kLu5vVJORCZVomMHCEAYo1vIUo0F1cqJKAojQlQFOSQksuQhVLn0IYsyAN0g5YsZku
 7sPWvfRUoZL9gYl0oTaNlcdXqXty9Jj3oZv3g+0dqbHu1/Bym1q8VSXUpohLzsiqI0Vj
 vpz12qiXgFJoeQDrQZbCfvZeswul3Yuz2yaRI7AR1Pg3VeHejzelPi/amHDt6d7PCsEc
 Rq944z9XmjCgtDMAgrbsBxxqyz7IjdMNzW02gLRdMGlC74DUAF7AFAQjCFN0NEDTewi0
 qbsPE5wLZmwnhyfy8jvDLcYLCeDJAoc0QyP85OneH9O2CwkwiAoZxSaWY7lostwose+N
 wQGw==
X-Gm-Message-State: AOAM531Okym9vAQtVUNbg+kKDbAeBiMvQK1B2dl78pt7A2OjBe6qb37k
 4yoxDxJ4QDhyVwGSeKMvJN763MXqceg=
X-Google-Smtp-Source: ABdhPJxF4d+sWu8w2NwzlZP7r/VFELTU9n5hnbo5rdODjHR0wnwyVgaX97f2R3IqlZFh0Lej268MjA==
X-Received: by 2002:a17:90b:4d08:: with SMTP id
 mw8mr12970883pjb.119.1594270901682; 
 Wed, 08 Jul 2020 22:01:41 -0700 (PDT)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id h15sm999974pjc.14.2020.07.08.22.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 22:01:41 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 1/5] iommu/arm-smmu: Make all valid stream mappings BYPASS
Date: Wed,  8 Jul 2020 22:01:41 -0700
Message-Id: <20200709050145.3520931-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
References: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Marek <jonathan@marek.ca>, linux-kernel@vger.kernel.org,
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

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/iommu/arm-smmu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 243bc4cb2705..2e27cf9815ab 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1924,6 +1924,22 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+int arm_smmu_setup_identity(struct arm_smmu_device *smmu)
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
