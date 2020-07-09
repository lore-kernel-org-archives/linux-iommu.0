Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F1CC433DF
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 05:10:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09EEF206E2
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 05:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMadG799"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EEF206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EAA4787009;
	Thu,  9 Jul 2020 05:10:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8BK2rNzv9Rk1; Thu,  9 Jul 2020 05:10:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7C335868EF;
	Thu,  9 Jul 2020 05:10:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63DDFC0865;
	Thu,  9 Jul 2020 05:10:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A84F6C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 963BB87009
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:10:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lSbcWiQBfrY1 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 05:10:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DDC71868EF
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:10:00 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id k4so938995oik.2
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jul 2020 22:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=410aRxR/jUVzarYYA7FRja4VMLxxjmJi5LB1naX7CXw=;
 b=pMadG799IDnLhFVn72xi9qEswo6WriD7WzmvA0YSRVBHLDFdlJlXUWOhI85zGWE8FF
 BQpX3w8cQhZAmZfj5SzYtuZ734FjH2WvmZuKI3lZTJVr6CXkYaV7PrTLtqTZkMoa3lmq
 CxOcLRZwzcJUyfNbB93hH9X/KNrEazeClJ1ZzP8aaS/IUKWoyoiYyriWoQwwQ1Gl52ZT
 bJ6Cv247hS8zFF0YMuarBnAPXKnxQCnfyxx77xzqpbRxFJk4VeCGkPl+gaqr/Kl6U0XB
 62aQwYZwvjXo6u+BMOvoipMHZAafGfKkF15TIOrygpjRcjZIZV67V09shv5RSRulIOLZ
 QHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=410aRxR/jUVzarYYA7FRja4VMLxxjmJi5LB1naX7CXw=;
 b=QQfqlmdjp7FP9R2ESHEKjkZejYEWvSliMiz7wzlSS6s+sMzjiVo4hyRp+Mi8lGTXDY
 oNdTP/NESebaCo7s0vYeBpG5hIydqcqLEREQLlFFDbyNM8jqVApJ3+VBuJcLlMq6sDLH
 9JZkgyr+a9NnnI4mlPSZ2vo6NHANzKxaQKw23zxIg21RgTz/f5cGDPp34mGuIZNDgfAh
 nGGchp+WEqC76lKM6NYuEYBQZVMEdr3r/JRP8j5hNFg/MnQPPjkuxZzyOMvjtiudUP+R
 bs16TIfHxhY2VWV6/97INz7+s7ygpf6WSYFUhu9bK4RpT0vIbReJVDCCYABV6yX8khMW
 uvxg==
X-Gm-Message-State: AOAM531VNI8do1iJsHAUrWSl8QKIXVsVgP8dBbzBTzX0GlNNsoyYZ0+x
 h3CNY/o78t54NlYhn4SB1rrF9mBdXX0=
X-Google-Smtp-Source: ABdhPJzn/WLmoGZFSRbIxVw2BwDD4/FnLqo5Y/X/J/6ujt0hVGxCmLwin0PsGP8NMF1YQ2L16L9uEw==
X-Received: by 2002:a17:90b:30c4:: with SMTP id
 hi4mr12329792pjb.166.1594270906127; 
 Wed, 08 Jul 2020 22:01:46 -0700 (PDT)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id h15sm999974pjc.14.2020.07.08.22.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 22:01:45 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 4/5] iommu/arm-smmu-qcom: Consstently initialize stream
 mappings
Date: Wed,  8 Jul 2020 22:01:44 -0700
Message-Id: <20200709050145.3520931-5-bjorn.andersson@linaro.org>
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

Firmware that traps writes to S2CR to translate BYPASS into FAULT also
ignores writes of type FAULT. As such booting with "disable_bypass" set
will result in all S2CR registers left as configured by the bootloader.

This has been seen to result in indeterministic results, as these
mappings might linger and reference context banks that Linux is
reconfiguring.

Use the fact that BYPASS writes result in FAULT type to force all stream
mappings to FAULT.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/iommu/arm-smmu-qcom.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
index e8a36054e912..86b1917459a4 100644
--- a/drivers/iommu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm-smmu-qcom.c
@@ -27,6 +27,7 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 {
 	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
 	u32 reg;
+	int i;
 
 	/*
 	 * With some firmware writes to S2CR of type FAULT are ignored, and
@@ -37,9 +38,24 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 					    FIELD_PREP(ARM_SMMU_S2CR_CBNDX, 0xff) |
 					    FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT));
 	reg = arm_smmu_gr0_read(smmu, last_s2cr);
-	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS)
+	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS) {
 		smmu->qcom_bypass_quirk = true;
 
+		/*
+		 * With firmware ignoring writes of type FAULT, booting the
+		 * Linux kernel with disable_bypass disabled (i.e. "enable
+		 * bypass") the initialization during probe will leave mappings
+		 * in an inconsistent state. Avoid this by configuring all
+		 * S2CRs to BYPASS.
+		 */
+		for (i = 0; i < smmu->num_mapping_groups; i++) {
+			smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
+			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
+			smmu->s2crs[i].cbndx = 0xff;
+			smmu->s2crs[i].count = 0;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
