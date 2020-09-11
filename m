Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9427BC43461
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 14:28:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38894222B8
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 14:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EDfRBB1G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="A2o8NJAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38894222B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 071CB87865;
	Fri, 11 Sep 2020 14:28:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zHn7DCRqTrmf; Fri, 11 Sep 2020 14:28:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 803E987858;
	Fri, 11 Sep 2020 14:28:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CFA8C0052;
	Fri, 11 Sep 2020 14:28:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE2E7C0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 14:27:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 94DF62E1D3
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 14:27:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VLoNXo9G2v6L for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 14:27:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from a27-186.smtp-out.us-west-2.amazonses.com
 (a27-186.smtp-out.us-west-2.amazonses.com [54.240.27.186])
 by silver.osuosl.org (Postfix) with ESMTPS id F3783228EC
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 14:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=gbvhytky6xpx7itkhb67ktsxbiwpnxix; d=codeaurora.org; t=1599834477;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=EncBtUbW+/8e8AetwH5ax0dwE6Vqltzbyo8iHlfy/3Y=;
 b=EDfRBB1G/XpKwO513bvKOCsfXhrd/3PPzrJp8XLcwjfgO6x1w7MXea/V9GC6rxvE
 vl24nJYBCCnlFgyWzapQbkD9sjzf0j4/+2nuHd5+9OY+WHpN6rJEFkcShUZOHEPzDN0
 TcJdPqZhMpifFwRvGY+6rT2EhRvkh42mYiW9FWis=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599834477;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=EncBtUbW+/8e8AetwH5ax0dwE6Vqltzbyo8iHlfy/3Y=;
 b=A2o8NJAJXF3cQ2/AKr888/StRic5M3IuOLjOKC2KkhPVqeDvvwIUP+ApN6j2DAYO
 7/kl3mWpUwto5hFNlCBqUC/4A+zYagS0XsiDt+Dq0ZUPyqSsZTDMajCtmpRSS+tNn8m
 CTlm1IVQRvPkqJ8rl++4KDEu0i667p0JXh+DCVKU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14C21C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Jordan Crouse <jcrouse@codeaurora.org>,
 Rob Clark <robdclark@gmail.com>
Subject: [PATCHv4 2/6] iommu/arm-smmu: Add domain attribute for system cache
Date: Fri, 11 Sep 2020 14:27:57 +0000
Message-ID: <010101747d90d23d-733d7d59-2761-4094-bdeb-3206f8873424-000000@us-west-2.amazonses.com>
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

Add iommu domain attribute for using system cache aka last level
cache by client drivers like GPU to set right attributes for caching
the hardware pagetables into the system cache.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 17 +++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
 include/linux/iommu.h                 |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 1f06ab219819..d449c895ba16 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -789,6 +789,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu_domain->non_strict)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
 
+	if (smmu_domain->sys_cache)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_SYS_CACHE;
+
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops) {
 		ret = -ENOMEM;
@@ -1513,6 +1516,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
 			*(int *)data = smmu_domain->non_strict;
 			return 0;
+		case DOMAIN_ATTR_SYS_CACHE:
+			*((int *)data) = smmu_domain->sys_cache;
+			return 0;
 		default:
 			return -ENODEV;
 		}
@@ -1544,6 +1550,17 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 			else
 				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 			break;
+		case DOMAIN_ATTR_SYS_CACHE:
+			if (smmu_domain->smmu) {
+				ret = -EPERM;
+				goto out_unlock;
+			}
+
+			if (*((int *)data))
+				smmu_domain->sys_cache = true;
+			else
+				smmu_domain->sys_cache = false;
+			break;
 		default:
 			ret = -ENODEV;
 		}
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index ddf2ca4c923d..93593e164e44 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -373,6 +373,7 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	struct iommu_domain		domain;
+	bool				sys_cache;
 };
 
 struct arm_smmu_master_cfg {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fee209efb756..a580dfe9c68d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -118,6 +118,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+	DOMAIN_ATTR_SYS_CACHE,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
