Return-Path: <SRS0=Rrtl=2Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9D0C2D0C0
	for <iommu@archiver.kernel.org>; Thu, 26 Dec 2019 22:41:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320D52080D
	for <iommu@archiver.kernel.org>; Thu, 26 Dec 2019 22:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PovNYG/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320D52080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0FCCC85249;
	Thu, 26 Dec 2019 22:41:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WDtMxq49odSB; Thu, 26 Dec 2019 22:41:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8916685239;
	Thu, 26 Dec 2019 22:41:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D2D7C18DD;
	Thu, 26 Dec 2019 22:41:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F3B0C0881
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 22:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 49B1820404
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 22:41:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HocFiy7JxA9v for <iommu@lists.linux-foundation.org>;
 Thu, 26 Dec 2019 22:41:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 709EB2036C
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 22:41:21 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id 6so13521600pgk.0
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 14:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=atr5dH9+58H0L1dBqDewFnWoCVnAfiU1TJyN0b3SOLw=;
 b=PovNYG/8yvcQkau2yxewsi61ZYVYH+xuJSm+1FfpbcX5Lrd0edTC29t1WUNmEMOldi
 qPeG9Jit/2cej0EQ3S5UwiPB/P81sRwx+kA8476XgyLM5vPpDYODNowEb4qZFqL370i1
 nXB/3af9sVFwcCfMTVDORSGSaNQlKr11e+WY4JkXYXKJP5VvY/aqksZoQw0qmCWg2S0s
 vqwUhMkHrVdcPw4NicoDOQLFcfvb9iF8bkTXnGXxMQHpPYnXN+5TlDya2LAmMPM+fAMa
 HvLK4DsOixPh0d9iJ2c1bstBsXyJ6sHGcqpJ+oJBaA1BiyxgKAFa91LP4IwOrSkettTv
 4fJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=atr5dH9+58H0L1dBqDewFnWoCVnAfiU1TJyN0b3SOLw=;
 b=Ze6IBzoi7GwlsBfJTU2eKYx8jYTzjvr4UvCZHXKoXtsa0O8+DyloTtmRx9iwnSo1Fy
 gB+NTDsjYqfcd7GrzEphA1VTBVRMZxALLh6cJ1K2O+xwr3ygZd0nVj1aZFsyYLthh20m
 F8AO1kyfZX8I+A3oAPO/txtXumLxS0h+gddBFG2d+Dl9FXqR2KVaCOPtef7l5KN33eaJ
 iuYUGQm0TlJET8CZgjoQEMOpJD0nIGtvDuFTU+tKvEAJKFg+/JzfO1CZrEwnedd/L/xg
 +OPAbroftTYJUt2axNac9b5Wvb6EeLY3Mt9L73E144JcSTo/oVAnbZKZ+hE25DwK96g3
 QNng==
X-Gm-Message-State: APjAAAUeattB5Py+Bp9j0dWGlMA8QzwqnEQzNHRqQaE1iF7vJoTwqz29
 /iTW+xR0VH83GrJBMzchlrLc80xWYts=
X-Google-Smtp-Source: APXvYqxjkphDV74NYDySl7S4Q4EqHt9CrR3SMTKiWnb+uEpFNDfkgplzaC9LAXUDcXRpxSglzDL53A==
X-Received: by 2002:a62:3603:: with SMTP id d3mr49051073pfa.37.1577398667182; 
 Thu, 26 Dec 2019 14:17:47 -0800 (PST)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id 2sm11779409pjh.19.2019.12.26.14.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2019 14:17:46 -0800 (PST)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/3] iommu/arm-smmu: Expose s2cr and smr structs to impl
Date: Thu, 26 Dec 2019 14:17:08 -0800
Message-Id: <20191226221709.3844244-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191226221709.3844244-1-bjorn.andersson@linaro.org>
References: <20191226221709.3844244-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: Patrick Daly <pdaly@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Pratik Patel <pratikp@codeaurora.org>, linux-arm-kernel@lists.infradead.org
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

Move the arm_smmu_s2cr and arm_smmu_smr structs to the internal header
file, in order to expose them to the platform specific arm-smmu
implementations.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since RFC:
- New patch

 drivers/iommu/arm-smmu.c | 14 --------------
 drivers/iommu/arm-smmu.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 6ca6a4e072c8..9a9091b9dcc7 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -73,24 +73,10 @@ module_param(disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
 
-struct arm_smmu_s2cr {
-	struct iommu_group		*group;
-	int				count;
-	enum arm_smmu_s2cr_type		type;
-	enum arm_smmu_s2cr_privcfg	privcfg;
-	u8				cbndx;
-};
-
 #define s2cr_init_val (struct arm_smmu_s2cr){				\
 	.type = disable_bypass ? S2CR_TYPE_FAULT : S2CR_TYPE_BYPASS,	\
 }
 
-struct arm_smmu_smr {
-	u16				mask;
-	u16				id;
-	bool				valid;
-};
-
 struct arm_smmu_cb {
 	u64				ttbr[2];
 	u32				tcr[2];
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 62b9f0cec49b..73f94579b926 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -224,6 +224,20 @@ enum arm_smmu_implementation {
 	QCOM_SMMUV2,
 };
 
+struct arm_smmu_s2cr {
+	struct iommu_group		*group;
+	int				count;
+	enum arm_smmu_s2cr_type		type;
+	enum arm_smmu_s2cr_privcfg	privcfg;
+	u8				cbndx;
+};
+
+struct arm_smmu_smr {
+	u16				mask;
+	u16				id;
+	bool				valid;
+};
+
 struct arm_smmu_device {
 	struct device			*dev;
 
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
