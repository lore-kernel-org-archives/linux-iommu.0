Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4678BC433E0
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 19:36:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE804207DF
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 19:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="akqyt3kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE804207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 831AB8767B;
	Mon,  3 Aug 2020 19:36:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CsD0j0+2vaDb; Mon,  3 Aug 2020 19:36:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B693D87697;
	Mon,  3 Aug 2020 19:36:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0AB4C0051;
	Mon,  3 Aug 2020 19:36:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A247DC004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 19:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 90A2F853E5
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 19:36:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8kFZW9avQND0 for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 19:36:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3EED0853C3
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 19:36:30 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1596483394; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=3tBI3iqXr6vSTLdel0v7xPA/k9+rhE+hKHRnCgyN4Mw=;
 b=akqyt3khCv3W/axF4yphkUKsFyxIP5P7RtSGHSckv9P8nUZnGvukyl629EETwb7+qsGHszSF
 Y+lmvQ0dM5LnOqkPwhOguo6R/gb1NaEZAIZR8AT67YJ9sZx4DvR1ffzg8dx1oUiWVCB1exRi
 x1gETGehgQBnf88wIKm2eCBYVfI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f286727bcdc2fe471ca3918 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 03 Aug 2020 19:36:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id EA6C6C43449; Mon,  3 Aug 2020 19:36:05 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 14C13C433CB;
 Mon,  3 Aug 2020 19:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14C13C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v11 03/12] iommu/arm-smmu: Prepare for the adreno-smmu
 implementation
Date: Mon,  3 Aug 2020 13:35:38 -0600
Message-Id: <20200803193547.305660-4-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803193547.305660-1-jcrouse@codeaurora.org>
References: <20200803193547.305660-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
 freedreno@lists.freedesktop.org, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>,
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

Do a bit of prep work to add the upcoming adreno-smmu implementation.

Add an hook to allow the implementation to choose which context banks
to allocate. Then, add domain_attr_get / domain_attr_set hooks to allow
for implementation specific domain attributes.

Move some of the common structs to arm-smmu.h in anticipation of them
being used by the implementations and update some of the existing hooks
to pass more information that the implementation will need.

These modifications will be used by the upcoming Adreno SMMU
implementation to identify the GPU device and properly configure it
for pagetable switching.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 83 ++++++++--------------
 drivers/iommu/arm/arm-smmu/arm-smmu.h      | 56 ++++++++++++++-
 3 files changed, 87 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index a9861dcd0884..88f17cc33023 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -69,7 +69,7 @@ static int cavium_cfg_probe(struct arm_smmu_device *smmu)
 }
 
 static int cavium_init_context(struct arm_smmu_domain *smmu_domain,
-		struct io_pgtable_cfg *pgtbl_cfg)
+		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
 {
 	struct cavium_smmu *cs = container_of(smmu_domain->smmu,
 					      struct cavium_smmu, smmu);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 976d43a7f2ff..e0a3e0da885b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -65,41 +65,10 @@ module_param(disable_bypass, bool, S_IRUGO);
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
-struct arm_smmu_cb {
-	u64				ttbr[2];
-	u32				tcr[2];
-	u32				mair[2];
-	struct arm_smmu_cfg		*cfg;
-};
-
-struct arm_smmu_master_cfg {
-	struct arm_smmu_device		*smmu;
-	s16				smendx[];
-};
-#define INVALID_SMENDX			-1
-#define cfg_smendx(cfg, fw, i) \
-	(i >= fw->num_ids ? INVALID_SMENDX : cfg->smendx[i])
-#define for_each_cfg_sme(cfg, fw, i, idx) \
-	for (i = 0; idx = cfg_smendx(cfg, fw, i), i < fw->num_ids; ++i)
-
 static bool using_legacy_binding, using_generic_binding;
 
 static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
@@ -234,19 +203,6 @@ static int arm_smmu_register_legacy_master(struct device *dev,
 }
 #endif /* CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS */
 
-static int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
-{
-	int idx;
-
-	do {
-		idx = find_next_zero_bit(map, end, start);
-		if (idx == end)
-			return -ENOSPC;
-	} while (test_and_set_bit(idx, map));
-
-	return idx;
-}
-
 static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
 {
 	clear_bit(idx, map);
@@ -578,7 +534,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 	}
 }
 
-static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
+void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 {
 	u32 reg;
 	bool stage1;
@@ -665,7 +621,8 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 }
 
 static int arm_smmu_init_domain_context(struct iommu_domain *domain,
-					struct arm_smmu_device *smmu)
+					struct arm_smmu_device *smmu,
+					struct device *dev)
 {
 	int irq, start, ret = 0;
 	unsigned long ias, oas;
@@ -780,10 +737,20 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		ret = -EINVAL;
 		goto out_unlock;
 	}
-	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
+
+	smmu_domain->smmu = smmu;
+
+	if (smmu->impl && smmu->impl->alloc_context_bank)
+		ret = smmu->impl->alloc_context_bank(smmu_domain, dev,
+				start, smmu->num_context_banks);
+	else
+		ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
 				      smmu->num_context_banks);
-	if (ret < 0)
+
+	if (ret < 0) {
+		smmu_domain->smmu = NULL;
 		goto out_unlock;
+	}
 
 	cfg->cbndx = ret;
 	if (smmu->version < ARM_SMMU_V2) {
@@ -798,8 +765,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	else
 		cfg->asid = cfg->cbndx;
 
-	smmu_domain->smmu = smmu;
-
 	pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= smmu->pgsize_bitmap,
 		.ias		= ias,
@@ -810,7 +775,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	};
 
 	if (smmu->impl && smmu->impl->init_context) {
-		ret = smmu->impl->init_context(smmu_domain, &pgtbl_cfg);
+		ret = smmu->impl->init_context(smmu_domain, &pgtbl_cfg, dev);
 		if (ret)
 			goto out_clear_smmu;
 	}
@@ -1194,7 +1159,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return ret;
 
 	/* Ensure that the domain is finalised */
-	ret = arm_smmu_init_domain_context(domain, smmu);
+	ret = arm_smmu_init_domain_context(domain, smmu, dev);
 	if (ret < 0)
 		goto rpm_put;
 
@@ -1534,6 +1499,13 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 			return 0;
 		default:
+			if (smmu_domain->smmu) {
+				const struct arm_smmu_impl *impl = smmu_domain->smmu->impl;
+
+				if (impl && impl->domain_get_attr)
+					return impl->domain_get_attr(smmu_domain, attr, data);
+			}
+
 			return -ENODEV;
 		}
 		break;
@@ -1575,6 +1547,13 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 			break;
 		default:
 			ret = -ENODEV;
+
+			if (smmu_domain->smmu) {
+				const struct arm_smmu_impl *impl = smmu_domain->smmu->impl;
+
+				if (impl && impl->domain_get_attr)
+					ret = impl->domain_set_attr(smmu_domain, attr, data);
+			}
 		}
 		break;
 	case IOMMU_DOMAIN_DMA:
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index f3e456893f28..870f0fd060a5 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -256,6 +256,21 @@ enum arm_smmu_implementation {
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
 
@@ -331,6 +346,13 @@ struct arm_smmu_cfg {
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
@@ -350,6 +372,11 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };
 
+struct arm_smmu_master_cfg {
+	struct arm_smmu_device		*smmu;
+	s16				smendx[];
+};
+
 static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
 {
 	u32 tcr = FIELD_PREP(ARM_SMMU_TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
@@ -400,14 +427,39 @@ struct arm_smmu_impl {
 	int (*cfg_probe)(struct arm_smmu_device *smmu);
 	int (*reset)(struct arm_smmu_device *smmu);
 	int (*init_context)(struct arm_smmu_domain *smmu_domain,
-			struct io_pgtable_cfg *cfg);
+			struct io_pgtable_cfg *cfg, struct device *dev);
 	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
 			 int status);
 	int (*def_domain_type)(struct device *dev);
 	irqreturn_t (*global_fault)(int irq, void *dev);
 	irqreturn_t (*context_fault)(int irq, void *dev);
+	int (*alloc_context_bank)(struct arm_smmu_domain *smmu_domain,
+			struct device *dev, int start, int max);
+	int (*domain_get_attr)(struct arm_smmu_domain *smmu_domain,
+			enum iommu_attr attr, void *data);
+	int (*domain_set_attr)(struct arm_smmu_domain *smmu_domain,
+			enum iommu_attr attr, void *data);
 };
 
+#define INVALID_SMENDX			-1
+#define cfg_smendx(cfg, fw, i) \
+	(i >= fw->num_ids ? INVALID_SMENDX : cfg->smendx[i])
+#define for_each_cfg_sme(cfg, fw, i, idx) \
+	for (i = 0; idx = cfg_smendx(cfg, fw, i), i < fw->num_ids; ++i)
+
+static inline int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
+{
+	int idx;
+
+	do {
+		idx = find_next_zero_bit(map, end, start);
+		if (idx == end)
+			return -ENOSPC;
+	} while (test_and_set_bit(idx, map));
+
+	return idx;
+}
+
 static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
 {
 	return smmu->base + (n << smmu->pgshift);
@@ -471,7 +523,9 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
 struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu);
 struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu);
+struct arm_smmu_device *qcom_adreno_smmu_impl_init(struct arm_smmu_device *smmu);
 
+void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx);
 int arm_mmu500_reset(struct arm_smmu_device *smmu);
 
 #endif /* _ARM_SMMU_H */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
