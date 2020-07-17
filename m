Return-Path: <SRS0=Ppoz=A4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E15CC433EA
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5271120787
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFN+J5la"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5271120787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2E36688092;
	Fri, 17 Jul 2020 00:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h1j7LgbtWu4E; Fri, 17 Jul 2020 00:16:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 868E287FB0;
	Fri, 17 Jul 2020 00:16:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72380C07FF;
	Fri, 17 Jul 2020 00:16:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 940E4C0733
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 00:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 916BF863C5
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 00:16:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uW-dCs5QPLKq for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jul 2020 00:16:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B1CB58639F
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 00:16:26 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id n5so5775607pgf.7
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 17:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uWqUMnqB20Yorh5LQCiLslCOOm0+DCqawJ+UCE1bquU=;
 b=HFN+J5lasdtEzt8WaDQDidUq/66N+NwxdcjPVhWpvCd+d0hZ5zNSLuBzBCKO+fjAOK
 C8nKyAjwFqxuDObJnah2wuyJoJ2ffpvR5fWK8OkvnlSYCccjKz9rrM/TXwPfAQzddKXp
 JegnspuFxDCFrVLUsvFTDz2sEWZMKfmsZDCWl7v+E+v74347FvLqBFFcl354G2qMbekZ
 CZw7OAC26K6gtekJV0WnxnzqtDWPvg3aZFxlc3AFEfFeKAnJnR8VesnoH5Ln6MN1a6LP
 94BkbVX/W5v3NeO0S5E4tZtZFQDXPnct1E0y/1HPGl1JKar2q9ypxL2cnAewiG2S6oco
 2I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uWqUMnqB20Yorh5LQCiLslCOOm0+DCqawJ+UCE1bquU=;
 b=VWpAXxoE/DKU5u+H0gj3TobW9nD7OoiHaHOtMcDA1gS5xoZoaO4pFDwe9R2kVZ+9f3
 XPZ3bESY44OC0pUN/1j1scM0+xuXJlKx672IfVcTfBjW4yPGr6Ss+zA5v82zggu21PCv
 sTE53EPc8MGY7K+89EmDE/e0hDQPPXK4zzoQPTxUZDiY+N4SOgY4xMB/VAPt2b7N4Tzh
 pd9dA4BsfwjPZm7DViKtTBR9en1Yd1RNXV6pG2qq+ghpanPbAVr93UeQvr2vgZV46iB7
 GUb1N3g5pj9wivZzf/n4PoGobRJD+v1Z+CB13cGbncBEmikPqbv8XZJ0dHdSdSMwLyEd
 8myg==
X-Gm-Message-State: AOAM530lyTp2hfIcF6lnGznHXw2D0oLVFZ+d0B9GHR8Cbmnx8IO0LmGf
 K9GUV/+yfknjY7byYxoH0kjwyA==
X-Google-Smtp-Source: ABdhPJzhp8wrF9EsgCUoqrojoUNB4BkSM3/fWxyDMIkhZTNNrxXnc9QP6rLIKqr2mcsWBO8ZpScFnA==
X-Received: by 2002:a63:140f:: with SMTP id u15mr6116836pgl.94.1594944986245; 
 Thu, 16 Jul 2020 17:16:26 -0700 (PDT)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id r7sm6211950pgu.51.2020.07.16.17.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 17:16:25 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 3/5] iommu/arm-smmu: Move SMR and S2CR definitions to
 header file
Date: Thu, 16 Jul 2020 17:16:17 -0700
Message-Id: <20200717001619.325317-4-bjorn.andersson@linaro.org>
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

Expose the SMR and S2CR structs in the header file, to allow platform
specific implementations to populate/initialize the smrs and s2cr
arrays.

Tested-by: John Stultz <john.stultz@linaro.org>
Tested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Picked up tested-by

 drivers/iommu/arm-smmu.c | 14 --------------
 drivers/iommu/arm-smmu.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5d5fe6741ed4..08a650fe02e3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -68,24 +68,10 @@ module_param(disable_bypass, bool, S_IRUGO);
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
index a71d193073e4..bcd160d01c53 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -251,6 +251,21 @@ enum arm_smmu_implementation {
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
+	bool				pinned;
+};
+
 struct arm_smmu_device {
 	struct device			*dev;
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
