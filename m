Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325E8C433E1
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 17:18:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09FD120748
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 17:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wh77Pl8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FD120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DF745869CA;
	Mon, 17 Aug 2020 17:18:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p3iQ+Tb+nVTf; Mon, 17 Aug 2020 17:18:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 39B8B865C1;
	Mon, 17 Aug 2020 17:18:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B864C088E;
	Mon, 17 Aug 2020 17:18:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A73BEC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 17:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A3B3587AA1
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 17:18:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xx86dBBaQPiE for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 17:18:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B88C787A9C
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 17:18:45 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id f24so18657695ejx.6
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JCoH2lRg6LTS0uH8BEbD374EsMum3HM8um5mjXWMgFY=;
 b=wh77Pl8p7VhsWfYtDo3n6DBmHOPe2heBnBq0guxx4qKskF6TT5uRJRmB1PkbRrVsSP
 IS3H6HjUypgf3z8+9vf3JBWDtfIp8K6GjXj3sPHJY9ayfafAzUj4Bs5D1AZoH5TrN734
 zA0x0uIMwPbjh+SpOv9u6p2eB90ThzNaUuETtBKhxlS1muUOUrPK0rB7/Y30cVOI1tGh
 wrcg+HiwrQLvFommofIHIkLy4NU0P+23zkGwXR9SArSLVQDX5v6Xon0PXhTngeWIuczx
 8vsTxRxkdBf7KWJDapSJNYMwLWIoTfn2JgiG6BtJXgn0SxxtfjkAyL+isKCJ/kCPaBxy
 4dKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JCoH2lRg6LTS0uH8BEbD374EsMum3HM8um5mjXWMgFY=;
 b=p3Z7m3YYf7Dow3STtLdP0xonNXZWFGUJ1Da2tp24Kki+gCztqVVP+MdG4ROgG50QZO
 5AhgfnuPJfSgvFF5BgNBwZmRSHRLZ4LCO9uICSjynsjOH2O6AUZpVQGt1QAqvqykPLIt
 GmZ/EUVPwnn56BJ0kWt9OChI2f4I3HRPDfqM2TPAlBrLIiEZTlKvKpgteRHHUQYfHSQX
 RSxS1TuDwtaV0wnUu//GbE55yKGWg6qTK2tTJgGIxiCd8TltJYqMSNNao5ltbdkTUfLd
 O7ZUk4r2B1B8yCLyFMea9hyZsw0tXJViaGJM/p4ZRWSttiWh/wKGq9QDGl6oG8bs7aYj
 v0Vw==
X-Gm-Message-State: AOAM531TCaTeDFv0QKJLfDdOJRsWirhiXL/Ct9/UctryY7Ma0c8eo0PI
 1nLrJfG5EvZXzN+WAMD7OPS16lhq7b0oy4CC
X-Google-Smtp-Source: ABdhPJzN2Apt2XCnBMUZw4jM/OyD2HY/oKoTLYh1lPDSHcBQswUnAAiR44pPSXQCgeMEgwjVHNz9xg==
X-Received: by 2002:a17:906:eca4:: with SMTP id
 qh4mr15734299ejb.255.1597684723826; 
 Mon, 17 Aug 2020 10:18:43 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id lc18sm14672502ejb.29.2020.08.17.10.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 10:18:43 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH RESEND v9 13/13] iommu/arm-smmu-v3: Hook up ATC invalidation
 to mm ops
Date: Mon, 17 Aug 2020 19:15:59 +0200
Message-Id: <20200817171558.325917-14-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817171558.325917-1-jean-philippe@linaro.org>
References: <20200817171558.325917-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, robin.murphy@arm.com, zhengxiang9@huawei.com,
 zhangfei.gao@linaro.org, will@kernel.org
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

The invalidate_range() notifier is called for any change to the address
space. Perform the required ATC invalidations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h    |  2 ++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 16 +++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c    | 18 ++++++++++++++++--
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6365c81a4614..baa80498ad9f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -694,6 +694,8 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
+int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
+			    unsigned long iova, size_t size);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index fb9bfda2d192..1687aac2d96b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -178,6 +178,16 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 	}
 }
 
+static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
+					 struct mm_struct *mm,
+					 unsigned long start, unsigned long end)
+{
+	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
+
+	arm_smmu_atc_inv_domain(smmu_mn->domain, mm->pasid, start,
+				end - start + 1);
+}
+
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
@@ -196,6 +206,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &quiet_cd);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
+	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
 
 	smmu_mn->cleared = true;
 	mutex_unlock(&sva_lock);
@@ -207,6 +218,7 @@ static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
 }
 
 static struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
+	.invalidate_range	= arm_smmu_mm_invalidate_range,
 	.release		= arm_smmu_mm_release,
 	.free_notifier		= arm_smmu_mmu_notifier_free,
 };
@@ -279,8 +291,10 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	 * If we went through clear(), we've already invalidated, and no
 	 * new TLB entry can have been formed.
 	 */
-	if (!smmu_mn->cleared)
+	if (!smmu_mn->cleared) {
 		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
+		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+	}
 
 	/* Frees smmu_mn */
 	mmu_notifier_put(&smmu_mn->mn);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ae93cdd09eff..d85a49b41a15 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1515,6 +1515,20 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	size_t inval_grain_shift = 12;
 	unsigned long page_start, page_end;
 
+	/*
+	 * ATS and PASID:
+	 *
+	 * If substream_valid is clear, the PCIe TLP is sent without a PASID
+	 * prefix. In that case all ATC entries within the address range are
+	 * invalidated, including those that were requested with a PASID! There
+	 * is no way to invalidate only entries without PASID.
+	 *
+	 * When using STRTAB_STE_1_S1DSS_SSID0 (reserving CD 0 for non-PASID
+	 * traffic), translation requests without PASID create ATC entries
+	 * without PASID, which must be invalidated with substream_valid clear.
+	 * This has the unpleasant side-effect of invalidating all PASID-tagged
+	 * ATC entries within the address range.
+	 */
 	*cmd = (struct arm_smmu_cmdq_ent) {
 		.opcode			= CMDQ_OP_ATC_INV,
 		.substream_valid	= !!ssid,
@@ -1573,8 +1587,8 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	return arm_smmu_cmdq_issue_sync(master->smmu);
 }
 
-static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
-				   int ssid, unsigned long iova, size_t size)
+int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
+			    unsigned long iova, size_t size)
 {
 	int i;
 	unsigned long flags;
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
