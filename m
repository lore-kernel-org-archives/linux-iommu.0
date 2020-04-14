Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E319C55180
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63C32075E
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JI5QkA97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63C32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A90BD86E4F;
	Tue, 14 Apr 2020 17:04:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HhvUJC23Rg33; Tue, 14 Apr 2020 17:04:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2599686E32;
	Tue, 14 Apr 2020 17:04:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DB30C089E;
	Tue, 14 Apr 2020 17:04:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41227C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2BF5421577
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Um0rc2v9s-88 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 17:04:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by silver.osuosl.org (Postfix) with ESMTPS id EA7FB2154A
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:45 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id f13so15227947wrm.13
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iFQo4eLK0C51ieV33vlbkwWvrpzk0Iu0nUGg4g65CHs=;
 b=JI5QkA97eezOSapi2fPqRY+esAG4E9fuADRTO9KkwAXqshRxQg2LKwGOVpQ8bEJ81f
 7XPxMj7271i5R78HnNq28pZSLk3B7jV9yN0c4/bTfJRpnWpYm9Lt2jtqPzuqS2HV02Z2
 hkq9kvDb8FIDY1FaOeaNgULZXDgiAcMd9YqMGytbbSvWq4fOyoPZG5zIKdYtbwIwjSXa
 /p9Mczkd/c2xupqo0EB5V5OSAvg3O/E1/F5JPD2SgV6IMuTc6+yiI7lkQVerTEvPWxXm
 XspXwZKvxZ42rz0b7zJEQWuYEyF6WUnRsl/SYo5BgSVSgOvKFQDMOtkvWsn7y2Hxn6V5
 9ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iFQo4eLK0C51ieV33vlbkwWvrpzk0Iu0nUGg4g65CHs=;
 b=ZFhhBpLHUqQt9WfQwPuY7tT3tTmaZVgVQo9s0Qe9hbQVXhxz4iCCxSPyDVjA1FbpSy
 4IoGinpFJw9/0XqcCPqT+7pHwLKSfx+GWf/esLM2o+Gfg5lg/+AOSjfMXDkIUle9rnKE
 wKJnmm3K7xx2al8LXaOhC5muWHcvHlJgMnzsAmmylDnIP/evhLyyXMr/XEfvRlFsXtOX
 MCAboLYhmw9bNMDeSzBV8rRo/I4/4B7pVpROfUMAxmxqQK77emsqbnA/t1Pa3KeOQZSz
 6j/BjEUf+dmMs00SZOqXlNqi7NUOmiVRQcMabmdxbVoG91sG65JCEDB3k10oJo7iZe4c
 bZpQ==
X-Gm-Message-State: AGi0PubdRHGoO8dQl/gwCr9WyQqGuXA2bQ08qcHk2WJrlXBvOgVhxCW+
 j41+yf1z7ALJ4hd315s5304AbO/DScrF8g==
X-Google-Smtp-Source: APiQypLZa+lawPw64nTDrcMPpw0HQPprW6BlaWllx/hPptH94lEGFoejVXa1lUE2ugeNThH+6x6yTQ==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr23364377wrp.327.1586883883718; 
 Tue, 14 Apr 2020 10:04:43 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 10:04:43 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v5 18/25] iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
Date: Tue, 14 Apr 2020 19:02:46 +0200
Message-Id: <20200414170252.714402-19-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 catalin.marinas@arm.com, robin.murphy@arm.com, jgg@ziepe.ca,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com
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

iommu-sva calls us when an mm is modified. Perform the required ATC
invalidations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v4->v5: more comments
---
 drivers/iommu/arm-smmu-v3.c | 70 ++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 6640c2ac2a7c5..c4bffb14461aa 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2375,6 +2375,20 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
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
@@ -2418,12 +2432,12 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
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
@@ -2934,7 +2948,7 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation via the SMMU.
 	 */
 	wmb();
-	arm_smmu_atc_inv_master(master);
+	arm_smmu_atc_inv_master(master, 0);
 	atomic_dec(&smmu_domain->nr_ats_masters);
 }
 
@@ -3131,7 +3145,22 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 static void arm_smmu_mm_invalidate(struct device *dev, int pasid, void *entry,
 				   unsigned long iova, size_t size)
 {
-	/* TODO: Invalidate ATC */
+	int i;
+	struct arm_smmu_cmdq_ent cmd;
+	struct arm_smmu_cmdq_batch cmds = {};
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	if (!master->ats_enabled)
+		return;
+
+	arm_smmu_atc_inv_to_cmd(pasid, iova, size, &cmd);
+
+	for (i = 0; i < master->num_sids; i++) {
+		cmd.atc.sid = master->sids[i];
+		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
+	}
+
+	arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
 static int arm_smmu_mm_attach(struct device *dev, int pasid, void *entry,
@@ -3168,26 +3197,43 @@ static void arm_smmu_mm_clear(struct device *dev, int pasid, void *entry)
 	 * for this ASID, so we need to do it manually.
 	 */
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-
-	/* TODO: invalidate ATC */
+	arm_smmu_atc_inv_domain(smmu_domain, pasid, 0, 0);
 }
 
 static void arm_smmu_mm_detach(struct device *dev, int pasid, void *entry,
 			       bool detach_domain, bool cleared)
 {
 	struct arm_smmu_ctx_desc *cd = entry;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	if (detach_domain) {
+	if (detach_domain)
 		arm_smmu_write_ctx_desc(smmu_domain, pasid, NULL);
 
-		if (!cleared)
-			/* See comment in arm_smmu_mm_clear() */
-			arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-	}
+	/*
+	 * If we went through clear(), we've already invalidated, and no new TLB
+	 * entry can have been formed.
+	 */
+	if (cleared)
+		return;
+
+	if (detach_domain) {
+		/* See comment in arm_smmu_mm_clear() */
+		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
+		arm_smmu_atc_inv_domain(smmu_domain, pasid, 0, 0);
 
-	/* TODO: invalidate ATC */
+	} else if (master->ats_enabled) {
+		/*
+		 * There are more devices bound with this PASID in this domain,
+		 * so we cannot yet clear the PASID entry, and this device could
+		 * create new ATC entries. Invalidate the ATC for the sake of
+		 * it. On unbinding the last device we'll properly invalidate
+		 * all ATCs in the domain. Alternatively, an early detach_dev()
+		 * on this device will also flush the ATC.
+		 */
+		arm_smmu_atc_inv_master(master, pasid);
+	}
 }
 
 static void *arm_smmu_mm_alloc(struct mm_struct *mm)
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
