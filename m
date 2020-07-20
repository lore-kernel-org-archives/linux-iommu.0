Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BDCC433F1
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 15:41:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4629022CE3
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 15:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="snxS1gIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4629022CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 06D4E86246;
	Mon, 20 Jul 2020 15:41:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M5HBhn5fzD6m; Mon, 20 Jul 2020 15:41:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9211B8630A;
	Mon, 20 Jul 2020 15:41:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71A59C089F;
	Mon, 20 Jul 2020 15:41:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F184C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 15:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7EC96875F9
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 15:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HehJ581PgzxB for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 15:41:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8291687592
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 15:41:19 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1595259680; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ojYn9xI5Ymeb5LxnRNnEThN5GJTa6H+dqaberOWG00k=;
 b=snxS1gIu3tf1OwjX9+PQXSB1p/eNlw1nZk4pwU1dHibEV/KeaTAbH+oWVkyfY2PlBwoXynUn
 sk1zc77VWaI4QfVDBOlt/xQQHIVtF+zSAdLd94Q/DMskFj7ixi4LRJL8YB5feWxQlm+U2CyR
 JievLClI+rYBuVCtJgN2Bo+dWMs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-west-2.postgun.com with SMTP id
 5f15bb1dcf983e60a8344239 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 15:41:17
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 8B4EEC43391; Mon, 20 Jul 2020 15:41:15 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id DE811C4344A;
 Mon, 20 Jul 2020 15:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE811C4344A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v10 06/13] iommu/arm-smmu-qcom: Get and set the pagetable
 config for split pagetables
Date: Mon, 20 Jul 2020 09:40:40 -0600
Message-Id: <20200720154047.3611092-7-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720154047.3611092-1-jcrouse@codeaurora.org>
References: <20200720154047.3611092-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

The Adreno GPU has the capability to manage its own pagetables and switch
them dynamically from the hardware. To do this the GPU uses TTBR1 for
"global" GPU memory and creates local pagetables for each context and
switches them dynamically with the GPU.

Use DOMAIN_ATTR_PGTABLE_CFG to get the current configuration for the
TTBR1 pagetable from the smmu driver so the leaf driver can create
compatible pagetables for use with TTBR0.

Because TTBR0 is disabled by default when TTBR1 is enabled the GPU
driver can pass the configuration of one of the newly created pagetables
back through DOMAIN_ATTR_PGTABLE_CFG as a trigger to enable translation on
TTBR0.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu-qcom.c | 47 +++++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu.c      | 32 ++++++++++++++++++------
 drivers/iommu/arm-smmu.h      | 10 ++++++++
 3 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
index b9a5c5369e86..9a0c64ca9cb6 100644
--- a/drivers/iommu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm-smmu-qcom.c
@@ -34,6 +34,52 @@ static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
 	return false;
 }
 
+/*
+ * Local implementation to configure TTBR0 wil the specified pagetable config.
+ * The GPU driver will call this to enable TTBR0 when per-instance pagetables
+ * are active
+ */
+static int qcom_adreno_smmu_set_pgtable_cfg(struct arm_smmu_domain *smmu_domain,
+		struct io_pgtable_cfg *pgtbl_cfg)
+{
+	struct io_pgtable *pgtable = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct arm_smmu_cb *cb = &smmu_domain->smmu->cbs[cfg->cbndx];
+
+	/* The domain must have split pagetables already enabled */
+	if (cb->tcr[0] & ARM_SMMU_TCR_EPD1)
+		return -EINVAL;
+
+	/* If the pagetable config is NULL, disable TTBR0 */
+	if (!pgtbl_cfg) {
+		/* Do nothing if it is already disabled */
+		if ((cb->tcr[0] & ARM_SMMU_TCR_EPD0))
+			return -EINVAL;
+
+		/* Set TCR to the original configuration */
+		cb->tcr[0] = arm_smmu_lpae_tcr(&pgtable->cfg);
+		cb->ttbr[0] = FIELD_PREP(ARM_SMMU_TTBRn_ASID, cb->cfg->asid);
+	} else {
+		u32 tcr = cb->tcr[0];
+
+		/* FIXME: What sort of validation do we need to do here? */
+
+		/* Don't call this again if TTBR0 is already enabled */
+		if (!(cb->tcr[0] & ARM_SMMU_TCR_EPD0))
+			return -EINVAL;
+
+		tcr |= arm_smmu_lpae_tcr(pgtbl_cfg);
+		tcr &= ~(ARM_SMMU_TCR_EPD0 | ARM_SMMU_TCR_EPD1);
+
+		cb->tcr[0] = tcr;
+		cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
+		cb->ttbr[0] |= FIELD_PREP(ARM_SMMU_TTBRn_ASID, cb->cfg->asid);
+	}
+
+	arm_smmu_write_context_bank(smmu_domain->smmu, cb->cfg->cbndx);
+	return 0;
+}
+
 static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
 		struct device *dev, int start, int count)
 {
@@ -131,6 +177,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.reset = qcom_smmu500_reset,
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
+	.set_pgtable_cfg = qcom_adreno_smmu_set_pgtable_cfg,
 };
 
 static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fff536a44faa..e1036ae54a8d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -86,13 +86,6 @@ struct arm_smmu_smr {
 	bool				valid;
 };
 
-struct arm_smmu_cb {
-	u64				ttbr[2];
-	u32				tcr[2];
-	u32				mair[2];
-	struct arm_smmu_cfg		*cfg;
-};
-
 static bool using_legacy_binding, using_generic_binding;
 
 static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
@@ -558,7 +551,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 	}
 }
 
-static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
+void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 {
 	u32 reg;
 	bool stage1;
@@ -1515,6 +1508,18 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 		case DOMAIN_ATTR_NESTING:
 			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 			return 0;
+		case DOMAIN_ATTR_PGTABLE_CFG: {
+			struct io_pgtable *pgtable;
+			struct io_pgtable_cfg *dest = data;
+
+			if (!smmu_domain->pgtbl_ops)
+				return -ENODEV;
+
+			pgtable = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
+
+			memcpy(dest, &pgtable->cfg, sizeof(*dest));
+			return 0;
+		}
 		default:
 			return -ENODEV;
 		}
@@ -1555,6 +1560,17 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 			else
 				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 			break;
+		case DOMAIN_ATTR_PGTABLE_CFG: {
+			struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+			ret = -EPERM;
+
+			if (smmu)
+				if (smmu->impl && smmu->impl->set_pgtable_cfg)
+					ret = smmu->impl->set_pgtable_cfg(smmu_domain,
+						data);
+			}
+			break;
 		default:
 			ret = -ENODEV;
 		}
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 9f81c1fffe1e..9325fc28d24a 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -328,6 +328,13 @@ struct arm_smmu_cfg {
 };
 #define ARM_SMMU_INVALID_IRPTNDX	0xff
 
+struct arm_smmu_cb {
+	u64				ttbr[2];
+	u32				tcr[2];
+	u32				mair[2];
+	struct arm_smmu_cfg		*cfg;
+};
+
 enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
 	ARM_SMMU_DOMAIN_S2,
@@ -408,6 +415,8 @@ struct arm_smmu_impl {
 	int (*def_domain_type)(struct device *dev);
 	int (*alloc_context_bank)(struct arm_smmu_domain *smmu_domain,
 			struct device *dev, int start, int max);
+	int (*set_pgtable_cfg)(struct arm_smmu_domain *smmu_domain,
+			struct io_pgtable_cfg *cfg);
 };
 
 #define INVALID_SMENDX			-1
@@ -493,6 +502,7 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
 struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu);
 struct arm_smmu_device *qcom_adreno_smmu_impl_init(struct arm_smmu_device *smmu);
 
+void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx);
 int arm_mmu500_reset(struct arm_smmu_device *smmu);
 
 #endif /* _ARM_SMMU_H */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
