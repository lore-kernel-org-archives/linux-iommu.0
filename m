Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F29C63777
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 07:01:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C8220B1F
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 07:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="a+fhLW44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C8220B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4EE3186D39;
	Wed, 25 Nov 2020 07:01:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0c-GPQSDlVOu; Wed, 25 Nov 2020 07:01:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B0D8D86D3A;
	Wed, 25 Nov 2020 07:01:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98FAFC163C;
	Wed, 25 Nov 2020 07:01:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BAD4C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 07:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 27F1486932
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 07:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id epLY0Xnzopse for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 07:01:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m42-4.mailgun.net (m42-4.mailgun.net [69.72.42.4])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DC3D78651D
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 07:01:12 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1606287674; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=E0M7IR1/9IKvJQWHqgPEopgPwdd/eTMOD6NthgVOyIg=;
 b=a+fhLW443G6t6El7+a38Say6yEPp02fz0NXFwLI8qgjVAXX8ofw7we6xTFXOwNOY5E8dWP/n
 UE4L150Px97wugxNveRb9l/wEMD6gc/ktpHOYes5JHVeFpC1boU8CI5cyUp3XejHk3ieZzeP
 DoPWl/uf4nTt2eRXT9AWPLRnSZM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5fbe0120ba50d14f88d929b5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Nov 2020 07:00:48
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id C4D80C43465; Wed, 25 Nov 2020 07:00:47 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E4948C433C6;
 Wed, 25 Nov 2020 07:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4948C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Jordan Crouse <jcrouse@codeaurora.org>,
 Rob Clark <robdclark@gmail.com>
Subject: [PATCHv10 3/9] iommu/arm-smmu: Add support for pagetable config
 domain attribute
Date: Wed, 25 Nov 2020 12:30:12 +0530
Message-Id: <2ab52ced2f853115c32461259a075a2877feffa6.1606287059.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1606287059.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1606287059.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Kristian H Kristensen <hoegsberg@google.com>,
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

Add support for domain attribute DOMAIN_ATTR_IO_PGTABLE_CFG
to get/set pagetable configuration data which initially will
be used to set quirks and later can be extended to include
other pagetable configuration data.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 20 ++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 0f28a8614da3..4b9b10fe50ed 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -789,6 +789,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu_domain->non_strict)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
 
+	if (smmu_domain->pgtbl_cfg.quirks)
+		pgtbl_cfg.quirks |= smmu_domain->pgtbl_cfg.quirks;
+
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops) {
 		ret = -ENOMEM;
@@ -1511,6 +1514,12 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 		case DOMAIN_ATTR_NESTING:
 			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 			return 0;
+		case DOMAIN_ATTR_IO_PGTABLE_CFG: {
+			struct io_pgtable_domain_attr *pgtbl_cfg = data;
+			*pgtbl_cfg = smmu_domain->pgtbl_cfg;
+
+			return 0;
+		}
 		default:
 			return -ENODEV;
 		}
@@ -1551,6 +1560,17 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 			else
 				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 			break;
+		case DOMAIN_ATTR_IO_PGTABLE_CFG: {
+			struct io_pgtable_domain_attr *pgtbl_cfg = data;
+
+			if (smmu_domain->smmu) {
+				ret = -EPERM;
+				goto out_unlock;
+			}
+
+			smmu_domain->pgtbl_cfg = *pgtbl_cfg;
+			break;
+		}
 		default:
 			ret = -ENODEV;
 		}
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 04288b6fc619..bb5a419f240f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -364,6 +364,7 @@ enum arm_smmu_domain_stage {
 struct arm_smmu_domain {
 	struct arm_smmu_device		*smmu;
 	struct io_pgtable_ops		*pgtbl_ops;
+	struct io_pgtable_domain_attr	pgtbl_cfg;
 	const struct iommu_flush_ops	*flush_ops;
 	struct arm_smmu_cfg		cfg;
 	enum arm_smmu_domain_stage	stage;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
