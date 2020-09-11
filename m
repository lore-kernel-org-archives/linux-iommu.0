Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82534C43461
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 14:28:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15184222B8
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 14:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZF+mMqhI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="bmXjHi+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15184222B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C08528748F;
	Fri, 11 Sep 2020 14:28:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MtIosawuZizm; Fri, 11 Sep 2020 14:28:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4030587483;
	Fri, 11 Sep 2020 14:28:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DC8DC0052;
	Fri, 11 Sep 2020 14:28:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E444DC0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 14:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D07718785F
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 14:28:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bxwrC7VHzcoZ for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 14:28:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from a27-186.smtp-out.us-west-2.amazonses.com
 (a27-186.smtp-out.us-west-2.amazonses.com [54.240.27.186])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2F68087859
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 14:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=gbvhytky6xpx7itkhb67ktsxbiwpnxix; d=codeaurora.org; t=1599834500;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=hwi/OQiGwyQ//NyTOaTL55rONVhtBqdkXJjR5Q1eVS4=;
 b=ZF+mMqhIi/CbOylKGsWhkeTdu6YhIbdaBawFg9iqxrJz+pBmQgEzicwQDzwvFLtF
 1aYGl0OPXD6c/YzVUjeOIyJAN1l562StPn74RWGxhCdxCU7GoKmAtGLEcb4BDgLTYag
 Ak4dW0EcADv7jUBERF+/uO/2Tm0yvoIO8wdOhp/s=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599834500;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=hwi/OQiGwyQ//NyTOaTL55rONVhtBqdkXJjR5Q1eVS4=;
 b=bmXjHi+8fZayOo64b5Vjly+eWg3GQrpBXry3MBQVQiDl0DebniWK2QNVkqffZxGt
 Li87k15BZ2B4b6PWP0CxHR2JNKbwZEYj6CgfC1pKuyPfFYaLVHd4wBuOn22SiIglAi/
 CntEdweCH/OrOuhrgErhqKP0BSGvDdEzPO2DJ70s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34028C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Jordan Crouse <jcrouse@codeaurora.org>,
 Rob Clark <robdclark@gmail.com>
Subject: [PATCHv4 6/6] iommu: arm-smmu-impl: Remove unwanted extra blank lines
Date: Fri, 11 Sep 2020 14:28:20 +0000
Message-ID: <010101747d912da7-f08dbc7e-0d72-44fe-8903-8f175a899860-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1599832685.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1599832685.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
X-SES-Outgoing: 2020.09.11-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Cc: linux-arm-msm@vger.kernel.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
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

There are few places in arm-smmu-impl where there are
extra blank lines, remove them and while at it fix the
checkpatch warning for space required before the open
parenthesis.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index ce78295cfa78..f5b5218cbe5b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -19,7 +19,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 
 static int arm_smmu_gr0_ns(int offset)
 {
-	switch(offset) {
+	switch (offset) {
 	case ARM_SMMU_GR0_sCR0:
 	case ARM_SMMU_GR0_sACR:
 	case ARM_SMMU_GR0_sGFSR:
@@ -54,7 +54,6 @@ static const struct arm_smmu_impl calxeda_impl = {
 	.write_reg = arm_smmu_write_ns,
 };
 
-
 struct cavium_smmu {
 	struct arm_smmu_device smmu;
 	u32 id_base;
@@ -110,7 +109,6 @@ static struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smm
 	return &cs->smmu;
 }
 
-
 #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
 
 #define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)
@@ -197,7 +195,6 @@ static const struct arm_smmu_impl mrvl_mmu500_impl = {
 	.reset = arm_mmu500_reset,
 };
 
-
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 {
 	const struct device_node *np = smmu->dev->of_node;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
