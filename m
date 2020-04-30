Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3BBCA9061
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1361E2051A
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdTx9q9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1361E2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0236088789;
	Thu, 30 Apr 2020 14:40:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zyedKi7Nw2sa; Thu, 30 Apr 2020 14:40:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 07C118879C;
	Thu, 30 Apr 2020 14:40:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9557C016F;
	Thu, 30 Apr 2020 14:40:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6E01C016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A2344251AE
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mtAZ6uS-bmIC for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 14:40:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 11D2D25028
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:42 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id x4so2153369wmj.1
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5zUk9NV0nU5TmSz+uWZW+0J3z6ZO8c45bE/F41UldBY=;
 b=hdTx9q9/ZBbgUC8/ufZMC68Zeis9W/RYxXDui8aFftSuMllKim0WGr4wx8hjminehP
 w1g/QaD2kaDN7e4b/Oot4dMemmy6yU9/xYXZzDgPDqvydC0M+3O369m72jEiXRiwoh4Q
 i9sPe28+qOx1cVjOwtZfZAPHopc0wdyPkjIQIMQ2c7FH+MZaoaRXEYOgYTEQXDFsaKUR
 fnu9Ofq0Ad+jqiOB9RX3dVIfO3pE3uTEbw4YMKfVwEHw08Ev0DJweclrvLf+op6gOheV
 b6oa+L4yDKBH7DkfS+f+u0eVik2GiUJxKykIvfc4MOaWRpfZjXdvgAuODWilHbJw3q8r
 Gh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5zUk9NV0nU5TmSz+uWZW+0J3z6ZO8c45bE/F41UldBY=;
 b=Q7TzoS+KogdHhYajhHdqNXHXgB0fQaIxxdtgPeY7JxO5Tg5nYtoxu2JR/nuB9UbnfP
 VYiQrX7ZoYtV7w0xI5BYqX2HibW5gagArOLY6CLqBk6q5/J6iiZQfs3pZcjBQLbnDkM+
 /T2A9QhyIKyHXARPI0ysaGTbzzYyPslM/Kaskstmk6cyMFX4H6rub0khdb3MfuVhElFL
 BFjGkHS6gTvPptZMzcpBZKZ6Z0JWL9MrMhssnjSbVQOa9/xtiYqW+hbI/TA4DS4pXkSm
 L2Z0d0B9s2LFh1pZV6N04+2tVMCUuumejHuVmEz2Kdo8y+R0nwZdUuI70B1a7TiyVDJ1
 hPUA==
X-Gm-Message-State: AGi0PubCc0B+DgVKwxxWzu4Ep2BMBcH8W6PlEbgmRA1uvZyF43sR5t2t
 TFrHqwhXf91mTw4OI+2HJ+UO6EiSl3o=
X-Google-Smtp-Source: APiQypLYnxQfwV9vUitaM0N+BAtQ0WTyZbQIbMQN53sHeaH1WhNxiOl1IRhWF/dZdB3Dd06HM1dwfw==
X-Received: by 2002:a1c:32c7:: with SMTP id y190mr3503540wmy.13.1588257640161; 
 Thu, 30 Apr 2020 07:40:40 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 07:40:39 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v6 18/25] iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
Date: Thu, 30 Apr 2020 16:34:17 +0200
Message-Id: <20200430143424.2787566-19-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, kevin.tian@intel.com, jgg@ziepe.ca,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 felix.kuehling@amd.com, will@kernel.org, christian.koenig@amd.com
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
 drivers/iommu/arm-smmu-v3.c | 56 ++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 00e5b69bb81a5..c65937d953b5f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -742,7 +742,7 @@ struct arm_smmu_mmu_notifier {
 	struct arm_smmu_ctx_desc	*cd;
 	bool				cleared;
 	refcount_t			refs;
-	struct arm_smmu_domain		*domain;
+	struct arm_smmu_domain __rcu	*domain;
 };
 
 #define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
@@ -2396,6 +2396,20 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
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
@@ -2439,12 +2453,12 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	cmd->atc.size	= log2_span;
 }
 
-static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
+static int arm_smmu_atc_inv_master(struct arm_smmu_master *master, int ssid)
 {
 	int i;
 	struct arm_smmu_cmdq_ent cmd;
 
-	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
+	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
 	for (i = 0; i < master->num_sids; i++) {
 		cmd.atc.sid = master->sids[i];
@@ -2958,7 +2972,7 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation via the SMMU.
 	 */
 	wmb();
-	arm_smmu_atc_inv_master(master);
+	arm_smmu_atc_inv_master(master, 0);
 	atomic_dec(&smmu_domain->nr_ats_masters);
 }
 
@@ -3187,7 +3201,22 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 					 struct mm_struct *mm,
 					 unsigned long start, unsigned long end)
 {
-	/* TODO: invalidate ATS */
+	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
+	struct arm_smmu_domain *smmu_domain;
+
+	rcu_read_lock();
+	smmu_domain = rcu_dereference(smmu_mn->domain);
+	if (smmu_domain) {
+		/*
+		 * Ensure that mm->pasid is valid. Pairs with the
+		 * smp_store_release() from rcu_assign_pointer() in
+		 * __arm_smmu_sva_bind()
+		 */
+		smp_rmb();
+		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start,
+					end - start + 1);
+	}
+	rcu_read_unlock();
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -3201,7 +3230,8 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 		return;
 	}
 
-	smmu_domain = smmu_mn->domain;
+	smmu_domain = rcu_dereference_protected(smmu_mn->domain,
+			lockdep_is_held(&arm_smmu_sva_lock));
 
 	/*
 	 * DMA may still be running. Keep the cd valid but disable
@@ -3210,7 +3240,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &invalid_cd);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
-	/* TODO: invalidate ATS */
+	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
 
 	smmu_mn->cleared = true;
 	mutex_unlock(&arm_smmu_sva_lock);
@@ -3251,7 +3281,8 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 		return ERR_CAST(mn);
 
 	smmu_mn = mn_to_smmu(mn);
-	if (smmu_mn->domain)
+	if (rcu_dereference_protected(smmu_mn->domain,
+				      lockdep_is_held(&arm_smmu_sva_lock)))
 		refcount_inc(&smmu_mn->refs);
 
 	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
@@ -3277,7 +3308,11 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 
 	bond->sva.dev = dev;
 	list_add(&bond->list, &master->bonds);
-	smmu_mn->domain = smmu_domain;
+	/*
+	 * Initialize domain last, since the invalidate() notifier assumes a
+	 * valid mm->pasid after fetching a valid domain.
+	 */
+	rcu_assign_pointer(smmu_mn->domain, smmu_domain);
 	return &bond->sva;
 
 err_free_pasid:
@@ -3318,7 +3353,8 @@ static void __arm_smmu_sva_unbind(struct iommu_sva *handle)
 		if (!smmu_mn->cleared) {
 			arm_smmu_tlb_inv_asid(smmu_domain->smmu,
 					      smmu_mn->cd->asid);
-			/* TODO: invalidate ATS */
+			arm_smmu_atc_inv_domain(smmu_domain, bond->mm->pasid,
+						0, 0);
 		}
 	}
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
