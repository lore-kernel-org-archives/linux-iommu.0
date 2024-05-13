Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BB9446BD
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715642056; cv=none; b=ZaM+OUt1MUi1s/wdFB1RlXBTJZChfhDdROo5XG4GIFDK4ReeL+2XT3iQssicoEMsRKg4IAEQET6UZ2b2HjCfhG0c91dVOh0PQmz06ruwifWH2dPRHfwrWU/Y/XazfBF8ZGj4/S/At0UZ5VRXZ76hhOKT+DHyX7i7niqJSRcFbEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715642056; c=relaxed/simple;
	bh=tx7E2f0GxPxvBaGc/bmN1M48jZl3m4a2E1TZi9bi+48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rN17ky/x0SdUGfEKiceg6xt8PXMiC+EHXieBO6npQ53DPqVLqpWHb6sh0r09KOCamKzPukSAp2UiX4MA1hPofncZNdNC+z5QbJHK4IaDm8lgrGrHtdkfcQAZEPbmwBJpTOgRoPgEggz1a0QopofIS7zidzckcuXeSsNibWj/ubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iCfF8pCl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iCfF8pCl"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1edc696df2bso42875665ad.0
        for <iommu@lists.linux.dev>; Mon, 13 May 2024 16:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715642054; x=1716246854; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/UTWRBSAvd0X00gI81fMU/F+YZQ/Mige07NOxJW4aqM=;
        b=iCfF8pClOQUjSkrHbvFEyxMDXqbYK/cmH5OKf+3Y0dtYm+ds2QpbVh2Xb4xXggrDnR
         HN661rVxDjICOyzg8aX/MM6ckPTTYt6YCHJXXQrB0KuQ8B6Z2y4sHXEeLpceyal/CMa9
         DtmLx+9kYWciLX+KpWrk1HJJ+a1iDYDtEgz5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715642054; x=1716246854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UTWRBSAvd0X00gI81fMU/F+YZQ/Mige07NOxJW4aqM=;
        b=I7hsYf/jAQe4t8fz7huGWSJnpahBrCZ2j2HLh/xAbClrLhQK2hy/VEd9/eFsmFeuto
         dZXczj4ek7Gzkny6WioYNABnUTrXDmmIWytGDveBT7coWtCVaR3zapUbt+IBqbUHamhB
         zLqzCq/udcfCj2r+vXVpuZqE2OM7qNLY9NWk8YpFhX1ZcEkCuiVq8nowfesEWIHOYURO
         fNCFfVwZmZRtVj9JxzDgrab2oAMLqOG74KLQcc7a1HoelC+feztgKa6/N1Z3ImD6hxvQ
         BGLcRAauWTx0SvqqOLvZotFMUvjQnMSdb816CjdpRQsDnkLd8Efsn0s4PqKmPdhk6n9t
         xhug==
X-Forwarded-Encrypted: i=1; AJvYcCURj5Av9AN+FoBVYtcLn8bm4fraY8fMTzenIfizbnrdXyCUnhhYODPuSAL/wyV9dTXf7rmWlt59lbfZCF16Tq2CwWhslfw=
X-Gm-Message-State: AOJu0YzQZOGeSnbaKAbkTDLPD7aRYNF2HLsWmVlKC3js3sgd+D/M9iDz
	xxVjgkYMgMxBL95QJsm1rFtP/NSdPzbkgwjq3fq69cYcIcM6cuW4G40oBIbOGw==
X-Google-Smtp-Source: AGHT+IF8+sauERaqDzjL2bI/eirzDn0nfnNAe5M0xI+wO+jJKg/7dcYov0Rv8fpzNykL4ic967Yyvw==
X-Received: by 2002:a17:903:1207:b0:1e7:b6f4:2d75 with SMTP id d9443c01a7336-1ef43d16e9amr162929375ad.6.1715642054153;
        Mon, 13 May 2024 16:14:14 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1165:227d:25c3:aee6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c160c63sm84391945ad.282.2024.05.13.16.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:14:13 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: Stephen Boyd <swboyd@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Chen Lin <chen45464546@163.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu: Don't disable next-page prefetcher on devices it works on
Date: Mon, 13 May 2024 16:13:47 -0700
Message-ID: <20240513161343.1.I5db5530070a1335e6cc3c55e056c2a84b1031308@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On sc7180 trogdor devices we get a scary warning at bootup:
  arm-smmu 15000000.iommu:
  Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK

We spent some time trying to figure out how we were going to fix these
errata and whether we needed to do a firmware update. Upon closer
inspection, however, we realized that the errata don't apply to us.
Specifically, the errata document says that for these errata:
* Found in: r0p0
* Fixed in: r2p2

...and trogdor devices appear to be running r2p4. That means that they
are unaffected despite the scary warning.

The issue is that the kernel unconditionally tries to disable the
prefetcher even on unaffected devices and then warns when it's unable
to.

Let's change the kernel to only disable the prefetcher on affected
devices, which will get rid of the scary warning on devices that are
unaffected. As per the comment the prefetcher is
"not-particularly-beneficial" but it shouldn't hurt to leave it on for
devices where it doesn't cause problems.

Fixes: f87f6e5b4539 ("iommu/arm-smmu: Warn once when the perfetcher errata patch fails to apply")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 9dc772f2cbb2..d9b38b0db0d4 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -109,7 +109,7 @@ static struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smm
 
 int arm_mmu500_reset(struct arm_smmu_device *smmu)
 {
-	u32 reg, major;
+	u32 reg, major, minor;
 	int i;
 	/*
 	 * On MMU-500 r2p0 onwards we need to clear ACR.CACHE_LOCK before
@@ -118,6 +118,7 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
 	 */
 	reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_ID7);
 	major = FIELD_GET(ARM_SMMU_ID7_MAJOR, reg);
+	minor = FIELD_GET(ARM_SMMU_ID7_MINOR, reg);
 	reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sACR);
 	if (major >= 2)
 		reg &= ~ARM_MMU500_ACR_CACHE_LOCK;
@@ -131,14 +132,18 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
 	/*
 	 * Disable MMU-500's not-particularly-beneficial next-page
 	 * prefetcher for the sake of errata #841119 and #826419.
+	 * These errata only affect r0p0 through r2p1 (fixed in r2p2).
 	 */
-	for (i = 0; i < smmu->num_context_banks; ++i) {
-		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
-		reg &= ~ARM_MMU500_ACTLR_CPRE;
-		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
-		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
-		if (reg & ARM_MMU500_ACTLR_CPRE)
-			dev_warn_once(smmu->dev, "Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK\n");
+	if (major < 2 || (major == 2 && minor < 2)) {
+		for (i = 0; i < smmu->num_context_banks; ++i) {
+			reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
+			reg &= ~ARM_MMU500_ACTLR_CPRE;
+			arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
+			reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
+			if (reg & ARM_MMU500_ACTLR_CPRE)
+				dev_warn_once(smmu->dev,
+					      "Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK\n");
+		}
 	}
 
 	return 0;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

