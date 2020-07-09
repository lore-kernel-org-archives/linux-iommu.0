Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB0DC433E0
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 05:08:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE85206E2
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 05:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oi9P502f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE85206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7B43687009;
	Thu,  9 Jul 2020 05:08:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YjlLw0FYkKX8; Thu,  9 Jul 2020 05:08:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1936686CE0;
	Thu,  9 Jul 2020 05:08:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 138A8C0865;
	Thu,  9 Jul 2020 05:08:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 094E9C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EAC6F885FA
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:08:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2pZT0wpf7caZ for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 05:08:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4FCFB884E4
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:08:35 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id x83so895944oif.10
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jul 2020 22:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hqoe1VtzzAa4w0lrTNILxm5TZOFtQ6ZqFKD8K8ft5H8=;
 b=oi9P502fvIr5PyRQt5SQntHS3N3rx17AUMRRDrMtGMGII+nqCiGfEZ2jmn+Oitn9pt
 wlCSE90hhoVr6uoZKD+LbMQ5/Y9+xcLTPqnch8CseRIy2aPJnDwDAeis1HABlWtDOBy7
 oKrHCpxZYZ9hLcBNAeQVP+cwUqCU2ANOYryvP9QJm+yNkv9tQahz++BfsI6BXQI+jDxj
 xTnQFcZxteOYJ5U7JqW918NzOFQnWnQDEbicTDOR+IZkCAeVuIuonOeNa+Cy/Fu/mvWd
 YPdVIRstiJ4F39m1b+ee9XpFEzYr38DuHaRZUFKsUNdfwzRteCm8CiBS+tK7rDMK18Kv
 5ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hqoe1VtzzAa4w0lrTNILxm5TZOFtQ6ZqFKD8K8ft5H8=;
 b=eywxYKlr548yP7so8f53Ztlvb2btyZ6kkdndFHbm/Hjp6BGeQ4SXIHjnfzVR598vZR
 dONngLXP0QRpaziKVws2Y/MZDA2dq7z7ZZfT43zhnQbYVZ6odgoB790bdRobu6gLUVui
 p/NBiEuq4X/7oNYIYrwR6i/nS7IB/aoKpmactChtdVyL971j/TmX+IViWMKwn21Zqv/N
 uAEkWmac5HAKuTlWHMm9elfzliBh+JMgZnDkz1d8EXTXFZH5DvzDko5AJa0z2/Wh744g
 z508dFdtlcnEHYFuP8ahFVdg7q5d643AVtEStm5m0XCyXK3i6X45WkZdj2jQG7+YJ6Zc
 C8xQ==
X-Gm-Message-State: AOAM530kzHBPmiE1FLVMfR6WQpQvQDnottso5ewzptq1lBHdytFLE6zx
 TIZo8y5Am8Qu3r4OFT+i7KTLgEW369Y=
X-Google-Smtp-Source: ABdhPJzCupbQIwvneQUBGafAC/eeTzQOM0srORgcQQb7VuqHhdTklwpUGbFFDu+jPwitKVvAVy/5VQ==
X-Received: by 2002:a17:90b:1a86:: with SMTP id
 ng6mr13156196pjb.88.1594270904651; 
 Wed, 08 Jul 2020 22:01:44 -0700 (PDT)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id h15sm999974pjc.14.2020.07.08.22.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 22:01:43 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 3/5] iommu/arm-smmu: Move SMR and S2CR definitions to header
 file
Date: Wed,  8 Jul 2020 22:01:43 -0700
Message-Id: <20200709050145.3520931-4-bjorn.andersson@linaro.org>
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

Expose the SMR and S2CR structs in the header file, to allow platform
specific implementations to populate/initialize the smrs and s2cr
arrays.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/iommu/arm-smmu.c | 14 --------------
 drivers/iommu/arm-smmu.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f33eda3117fa..e2d6c0aaf1ea 100644
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
