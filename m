Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2F838D40C
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666412; cv=none; b=seEtL43E9shNy8ANdXHmIePJyPCyhAoyhsZXT971DzN3tddj48V03LrksoEKQiGufyxXfuklFm1i9ica3ZKLf/bN0U9fd0TH2UPNn4j1xuY8bETD/0ZZFZmJjCGSTe8QXAnVU58LPCxv8nBX5s5i2QwcaYvIKfihd6ITLUbszW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666412; c=relaxed/simple;
	bh=o0i0dsUkr2/aCIkvIovVeAJdYRkZWyCWYJpZfKXpGHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hxflXMdNpKJkumUQj5Tc7VueRj84ULRyZeTvSFH77lPgSrYqLl47hGEJ1dRTihFl1QwuG9oXO9/WrPBvHrPjQ3oEiyUS4bm5SbUk4LOs9peId9q6NoR53ipXCNswz/Tl51cQhiZGMESgZmUZPVechB1IUpvkT8Qzk8cn7tRrO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U0SNRAH0; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0SNRAH0"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-880e099bba5so3965517b3a.1
        for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790666410; x=1791271210; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRnDa4vAhhdrCZggWPWQopoSXxq018MvNv/VSTy8Lhs=;
        b=U0SNRAH0GjinhHpiE3UqffghtJeKJtyC27qvHBhRASHVCuotTUXka0eert5borIjxk
         xXobAFXnOdp5QZol2tkiF9xLorfCQEDW5Lugh4mJsDhw1djnpSAVHqrztPur/QWnWZhH
         W4z/l5PozsMrvMxaDO2O9xp+bvoElwTFVp1fm3r0GHxfr2JoIR3eFEUEeFlGM3XTWiqA
         HqW+RNjixpN8GzJeBB7+AOqqL8vXN/0UvoU6mg0whlZVPX2BTZaE8cMXbfoFXWPg4kqS
         kbCtS4Lkho947O2uKWfrrOnl+NcDLd1toIefWLhsGLUwCbJZh81I9D9IRUhQXD+plQcZ
         2GZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666410; x=1791271210;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aRnDa4vAhhdrCZggWPWQopoSXxq018MvNv/VSTy8Lhs=;
        b=C19wC1fSc939utxpcMRUK1n6plOjljECkptaQ1Wh4w1FrtCrVIv07Zf46b7gDNen9a
         AvhtvhGjGXwkgbgCTRM8WhjJ4s+Nd0dK7KIvscQyG2zhnJA1x2+LOggfvp5ZZ4NfE7Qy
         mnDNlbEKSPe4KiStYHLoTUkTkm0rN46RIHLTEF3zx1LNTGjb2clSI75CV6i9+YvgL0OA
         yG531r10LwolIS+h7d4ccHfdLYdPHRp0jjFRliNwWXDSJ4DztZYjY7m939Ck7UAokjsd
         tYdlDj6s0uXZYbhLnqwt3NYDKnPBSNEABHw+Jjy7GZ3zv/A6DNBiUM1SiCFILCqkT1g4
         7p+w==
X-Gm-Message-State: AFuF++kEomOUymo528QGGhdGkSX5VN01Po3S75lEr6NvSgWKlEXCjXLK
	Lz3cGHsc7MFJkG/172kYfsxvuJfuTHcr84BDVi6/jRcTNGuq33TYW+GBzRvhrizpkSbHOOXXmBc
	ALhB+iNOo8espnKRRn/RZgwq5pcObsxrE659FWBRKxEcc9RZvP1SNziWD9qMlxzAywf4ukDOdnP
	4+5b5w9EWAZGJsSt4KSI0d9uR93qOs8Q==
X-Received: from pfbhu13.prod.google.com ([2002:a05:6a00:698d:b0:884:7cdd:23d1])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94fb:b0:882:1d:c2ba
 with SMTP id d2e1a72fcca58-882001dcd3cmr5592982b3a.22.1790666410148; Tue, 29
 Sep 2026 00:20:10 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:19:48 +0000
In-Reply-To: <20260929071950.2710070-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929071950.2710070-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929071950.2710070-8-praan@google.com>
Subject: [RFC PATCH v1 7/9] iommu/arm-smmu-v3: Retain SMMUEN across a Live
 Update restore
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

arm_smmu_device_reset() clears SMMUEN and rewrites CR1, CR2 and
STRTAB_BASE, aborting the DMA of the preserved devices. The kdump adoption
path already avoids this for a live Stream Table.

Introduce arm_smmu_strtab_is_live() and route a Live Update restore
through the kdump reset path. Also ack a stale GERROR, since the outgoing
kernel masked the interrupts, and skip installing the RMR bypass STEs.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 ++++++++++++++-------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3cf97f451b64..54c97ebc15b2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5048,6 +5048,13 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 	writel_relaxed(reg, smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
 }
 
+/* Adopted by kdump or restored by LU (a failed restore fails the probe) */
+static bool arm_smmu_strtab_is_live(struct arm_smmu_device *smmu)
+{
+	return (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) ||
+	       iommu_get_preserved_data(smmu->base_phys, IOMMU_ARM_SMMUV3);
+}
+
 static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	int ret;
@@ -5064,10 +5071,11 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	 * According to spec, updating STRTAB_BASE/CR1/CR2 when CR0_SMMUEN=1 is
 	 * CONSTRAINED UNPREDICTABLE. So, skip those register updates and rely
 	 * on the adopted stream table from the crashed kernel.
+	 * Same for a Live Update restore.
 	 */
-	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
-		dev_info(smmu->dev,
-			 "kdump: retaining SMMUEN for in-flight DMA\n");
+	if (arm_smmu_strtab_is_live(smmu)) {
+		dev_info(smmu->dev, "%s: retaining SMMUEN for in-flight DMA\n",
+			 is_kdump_kernel() ? "kdump" : "live update");
 		enables = reg & ~(CR0_CMDQEN | CR0_EVTQEN | CR0_PRIQEN);
 		goto reset_queues;
 	}
@@ -5103,7 +5111,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	arm_smmu_write_strtab(smmu);
 
 reset_queues:
-	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+	if (arm_smmu_strtab_is_live(smmu)) {
 		/*
 		 * Disable queues since arm_smmu_device_disable() was skipped.
 		 * CR0 fields are independent per spec, so the queue enable bits
@@ -5122,8 +5130,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	 * errors would be visible. Ack everything prior to re-enabling the CMDQ
 	 * as a stale CMDQ_ERR would halt the CMDQ and new command will timeout.
 	 * Acking SFM_ERR is defined too, although it would not exit the SFM.
+	 * Same for a Live Update, as the outgoing kernel masked the interrupts.
 	 */
-	if (is_kdump_kernel()) {
+	if (is_kdump_kernel() || arm_smmu_strtab_is_live(smmu)) {
 		u32 gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
 		u32 gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
 
@@ -5193,10 +5202,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	}
 
 	/*
-	 * In a kdump adopt case, retain the crashed kernel's ATS-check policy
-	 * captured above rather than forcing it on.
+	 * In a kdump adopt or a Live Update restore case, retain the previous
+	 * kernel's ATS-check policy captured above rather than forcing it on.
 	 */
-	if (!(smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) &&
+	if (!arm_smmu_strtab_is_live(smmu) &&
 	    (smmu->features & ARM_SMMU_FEAT_ATS)) {
 		enables |= CR0_ATSCHK;
 		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
@@ -5722,8 +5731,10 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	 * Kdump adoption keeps the crashed kernel's table live. Rewriting the
 	 * adopted STE here could expose an in-flight fetch to a transient V=0
 	 * entry, or change Cfg=translate to Cfg=bypass. Must skip here.
+	 * Same for a Live Update restore.
+	 * TODO: Re-install the bypass STEs of the unpreserved RMR SIDs.
 	 */
-	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT)
+	if (arm_smmu_strtab_is_live(smmu))
 		return;
 
 	INIT_LIST_HEAD(&rmr_list);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

