Return-Path: <SRS0=TgA1=WD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED25EC32751
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 22:22:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28FB21873
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 22:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NjTfJTY9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YCBPHDtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28FB21873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9DFB0D8E;
	Wed,  7 Aug 2019 22:22:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C591ECB2
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 22:22:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 84C29829
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 22:22:02 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 57A0360E40; Wed,  7 Aug 2019 22:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1565216522;
	bh=V2MOW7b4CUVhygGGVaa1wzt2YduOq9ESSFH7yL59gh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NjTfJTY9c5BbuHUA5nasQxkZSBsJkkIVbNB7cBM29YKSwJ/9BXXNmmm+6ihuyuMYX
	w4c55TIMzw+c/uIDbuUL+c5rhV/Hz60vO2IKaJLIdsNYyRlSjLYBlIWMtMTh6a2mG2
	xZpFy9CxFnvtHzyx/BKojI3LJKxltjYrPVvAmywc=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jcrouse@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id D67C46090F;
	Wed,  7 Aug 2019 22:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1565216508;
	bh=V2MOW7b4CUVhygGGVaa1wzt2YduOq9ESSFH7yL59gh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCBPHDtUPurdyKZZfpBRRfq/JJw9kwWNNS2y/AGWUNciNkNOSznkrzR2oOGovZ5N0
	ReynarRaHNZmERQJcmNSSypbBOAIv5Gt3CjPg1cjyNkCP2f1goXjghA4j+VyOHrCdX
	djOwH/NDrReRX7RKsXlGL58MJyDoTAApdxp57ado=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D67C46090F
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org
Subject: [PATCH v3 2/2] iommu/arm-smmu: Add support for Adreno GPU pagetable
	formats
Date: Wed,  7 Aug 2019 16:21:40 -0600
Message-Id: <1565216500-28506-3-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565216500-28506-1-git-send-email-jcrouse@codeaurora.org>
References: <1565216500-28506-1-git-send-email-jcrouse@codeaurora.org>
Cc: Will Deacon <will@kernel.org>, jean-philippe.brucker@arm.com,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Add support for an Adreno GPU variant of the arm-smmu device to enable
a special pagetable format that enables TTBR1 and leaves TTBR0 free
to be switched by the GPU hardware.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index aa06498..129ac83 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -124,6 +124,7 @@ enum arm_smmu_implementation {
 	ARM_MMU500,
 	CAVIUM_SMMUV2,
 	QCOM_SMMUV2,
+	ADRENO_SMMUV2,
 };
 
 struct arm_smmu_s2cr {
@@ -832,7 +833,10 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		ias = smmu->va_size;
 		oas = smmu->ipa_size;
 		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64) {
-			fmt = ARM_64_LPAE_S1;
+			if (smmu->model == ADRENO_SMMUV2)
+				fmt = ARM_ADRENO_GPU_LPAE;
+			else
+				fmt = ARM_64_LPAE_S1;
 		} else if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_L) {
 			fmt = ARM_32_LPAE_S1;
 			ias = min(ias, 32UL);
@@ -2030,6 +2034,7 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
 ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
 ARM_SMMU_MATCH_DATA(qcom_smmuv2, ARM_SMMU_V2, QCOM_SMMUV2);
+ARM_SMMU_MATCH_DATA(adreno_smmuv2, ARM_SMMU_V2, ADRENO_SMMUV2);
 
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
@@ -2039,6 +2044,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
 	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
+	{ .compatible = "qcom,adreno-smmu-v2", .data = &adreno_smmuv2 },
 	{ },
 };
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
