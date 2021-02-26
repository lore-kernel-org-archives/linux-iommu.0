Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09591C433DB
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 09:56:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728D564EE4
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 09:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728D564EE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12A4D840FA;
	Fri, 26 Feb 2021 09:56:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iHoIvM-HWWGU; Fri, 26 Feb 2021 09:56:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4B9A840FD;
	Fri, 26 Feb 2021 09:56:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3549C000B;
	Fri, 26 Feb 2021 09:56:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDCA5C0001
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 09:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id CFAB743310
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 09:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id C-Q9OSTE3jaF for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 09:56:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from z11.mailgun.us (z11.mailgun.us [104.130.96.11])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id B11DC42FB2
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 09:56:11 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1614333374; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=trMRyJGV8+dYg3p+l6QhkEnWvTbbOoxge+SBYlBEB0I=;
 b=B8m57cObMPCYZoo8NNToKJrhEiLX8o1WKgUoF1Hdpa2lCRtBnP7/exH9ku7AuSEiQruodcqO
 hVjRLsXgP963xrx0H6sQNvGtFkRT8RRreW3yXq+XTm76EP+ROyhruvD1PKafdX2O7zYRG8lv
 Q9ZHKKmMnkBBj/jCp5BwV/oIviw=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6038c5b82658fcb873966fb7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Feb 2021 09:56:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 18929C433ED; Fri, 26 Feb 2021 09:56:08 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E97F4C433CA;
 Fri, 26 Feb 2021 09:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E97F4C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Jordan Crouse <jcrouse@codeaurora.org>,
 Rob Clark <robdclark@gmail.com>, Akhil P Oommen <akhilpo@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific impl
 earlier
Date: Fri, 26 Feb 2021 15:25:40 +0530
Message-Id: <c607d71eb0fe507c8b83cc0ea9b393777f22149a.1614332994.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <cover.1614332994.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1614332994.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Adreno(GPU) SMMU and APSS(Application Processor SubSystem) SMMU
both implement "arm,mmu-500" in some QTI SoCs and to run through
adreno smmu specific implementation such as enabling split pagetables
support, we need to match the "qcom,adreno-smmu" compatible first
before apss smmu or else we will be running apps smmu implementation
for adreno smmu and the additional features for adreno smmu is never
set. For ex: we have "qcom,sc7280-smmu-500" compatible for both apps
and adreno smmu implementing "arm,mmu-500", so the adreno smmu
implementation is never reached because the current sequence checks
for apps smmu compatible(qcom,sc7280-smmu-500) first and runs that
specific impl and we never reach adreno smmu specific implementation.

Suggested-by: Akhil P Oommen <akhilpo@codeaurora.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index bea3ee0dabc2..03f048aebb80 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -345,11 +345,17 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
 {
 	const struct device_node *np = smmu->dev->of_node;
 
-	if (of_match_node(qcom_smmu_impl_of_match, np))
-		return qcom_smmu_create(smmu, &qcom_smmu_impl);
-
+	/*
+	 * Do not change this order of implementation, i.e., first adreno
+	 * smmu impl and then apss smmu since we can have both implementing
+	 * arm,mmu-500 in which case we will miss setting adreno smmu specific
+	 * features if the order is changed.
+	 */
 	if (of_device_is_compatible(np, "qcom,adreno-smmu"))
 		return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
 
+	if (of_match_node(qcom_smmu_impl_of_match, np))
+		return qcom_smmu_create(smmu, &qcom_smmu_impl);
+
 	return smmu;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
