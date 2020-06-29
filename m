Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDFDC433DF
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 15:53:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FB5254DE
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 15:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="iEpzTJ4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FB5254DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8202E887C3;
	Mon, 29 Jun 2020 15:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s89Rj8FLSWYQ; Mon, 29 Jun 2020 15:53:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 91126887BD;
	Mon, 29 Jun 2020 15:53:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77F3CC08A0;
	Mon, 29 Jun 2020 15:53:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A41C0C016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 15:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 92E668928B
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 15:53:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YruV9gW+Hh7o for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 15:53:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 60D5F8928F
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 15:53:53 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1593446033; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=3y5SAJ1ea6Nee5AeGdTjHyw0ywc1ZU3bRXWZUomu8RA=;
 b=iEpzTJ4NVNHxRYwK2F6XfE9ChMGdLbH72Xb0MFDPWhBkAKvQ69SUErE/4OQVmNyzdx9vo6Nm
 C6WlVcssYR1XEF8n3KwcxAfO74zcEowJrRyDSxmwOxU5OaGHXF4yV/a0haDfd3DzyBSQNaIf
 91AnH2KnTpTxQwLbQSHjZoUnQs0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n17.prod.us-east-1.postgun.com with SMTP id
 5efa0e900206ad41d1bf2db5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Jun 2020 15:53:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 345ADC433A0; Mon, 29 Jun 2020 15:53:51 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BEECC433C6;
 Mon, 29 Jun 2020 15:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BEECC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jordan Crouse <jcrouse@codeaurora.org>,
 Rob Clark <robdclark@gmail.com>
Subject: [PATCHv3 4/7] iommu: arm-smmu-impl: Remove unwanted extra blank lines
Date: Mon, 29 Jun 2020 21:22:47 +0530
Message-Id: <eac492008010eec45c992cafeb5d191cf8b2fbd4.1593344119.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593344119.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1593344119.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Cc: freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 linux-arm-msm@vger.kernel.org, Sharat Masetty <smasetty@codeaurora.org>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@codeaurora.org>, iommu@lists.linux-foundation.org,
 Matthias Kaehlcke <mka@chromium.org>,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 Daniel Vetter <daniel@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 Emil Velikov <emil.velikov@collabora.com>
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
 drivers/iommu/arm-smmu-impl.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index 309675cf6699..8fbab9c38b61 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -9,10 +9,9 @@
 
 #include "arm-smmu.h"
 
-
 static int arm_smmu_gr0_ns(int offset)
 {
-	switch(offset) {
+	switch (offset) {
 	case ARM_SMMU_GR0_sCR0:
 	case ARM_SMMU_GR0_sACR:
 	case ARM_SMMU_GR0_sGFSR:
@@ -47,7 +46,6 @@ static const struct arm_smmu_impl calxeda_impl = {
 	.write_reg = arm_smmu_write_ns,
 };
 
-
 struct cavium_smmu {
 	struct arm_smmu_device smmu;
 	u32 id_base;
@@ -103,7 +101,6 @@ static struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smm
 	return &cs->smmu;
 }
 
-
 #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
 
 #define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)
@@ -148,7 +145,6 @@ static const struct arm_smmu_impl arm_mmu500_impl = {
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
