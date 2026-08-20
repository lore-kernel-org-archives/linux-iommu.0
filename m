Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3BB2C08D0
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250397; cv=pass; b=YGPeKh+EqtIc/yWyLCTQhfRMueVEkWSaM41h/2yPtTQpjORm8pwU/QaV6iSLHR9BwzGdutG8EDyjMfzuz/hilBpn6DREjzXo8T3E0QXZp95DdrBV//rRej7L/hbkVKRP91ggR8Md3++ntN6mmtsE4T3shMgyaC3uymWKwTYF3TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250397; c=relaxed/simple;
	bh=18IUh81J0b86a3W+lQs4sDn7VNmfdgzqQ+UD/TE3X9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZSyczUChN7dNvXax5e5a4FP0AVyiq2VFWEfP1cPB+0N6LrmhweXPdwbuzx8+XiWnk2N82jWJrSr0XRxSe5fEU+wAsxTJXiSzM0UwmF80rrmfgwaMGh7LoVjZUgOlnJHBNnExhLO9i2nzUZvIh/R9gnUwIBCi2zVaOP7EUuiblY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=Vi7u0cub; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="Vi7u0cub"
ARC-Seal: i=1; a=rsa-sha256; t=1787250342; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HF32ISM/uEyK4gRh5NtqxolfYdi8az5wCQqvIueEgy2dQ+EVbEw5UDXx5uto7tlznhZTbwLyzIkz63QvQFx+v0lORJKGBENgMFFVpI9MqwYoJIx7TzhV3b4xEonfAx3xTYfzd1rG/hUAJO9V46bbqVXU332b+Letg8hRVWWVtdQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787250342; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=d3hPnqjKAIHz/zAfdOruI20sr8Ovqz4LhRY6tH14zL8=; 
	b=l+Y6OZL7r/CQ1hNAA047laeGWUeJreOE6kylbSu51OvypzrcpZQMlRfRFOoYq0KJ8XbjbPEdxWTk/On72JBtUg8HMM2KDVCIq2737zbUxvaD+s/QcgVhqzbP9uPFCbGcBBpzMx2YLZ98v9XFGODhL2HzfRLTtjYY95NcKyMCIF0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787250342;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=d3hPnqjKAIHz/zAfdOruI20sr8Ovqz4LhRY6tH14zL8=;
	b=Vi7u0cubXwkfbEixpFSMvzEOerrv+R0/1UbJs+LHx2ar9S0daj4Q32ocyrFM9Sx8
	RuzgoE00zNxJ7tbKumf6VFDnmCiT+YBOxLoyCajhXAexRPOeL9OzSsYy4qlgUPO8T9h
	jIqu8+P0ySl77PfvWW3IdOJ95Uz6XspWKd4I5svGsmTLOvuCk09HwHhjjwtvD2/Nk9G
	jjklzlOvGXzwCyekoQiA5IDHmsHzXcAzy3TNLnPsoKzUALVcTpfbd2Ngqawz689USe+
	GGoNPjjLE6n89KRoEhW4kPDR7kmZ4zg5wIrWGPV511qC1PtzFE0XIkYbeWEj9S7MFxn
	o1bPzpPcZQ==
Received: by mx.zohomail.com with SMTPS id 1787250340595905.3242166317438;
	Thu, 20 Aug 2026 11:25:40 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Fri, 21 Aug 2026 02:25:09 +0800
Subject: [PATCH v2 3/3] iommu/amd: Remove ad-hoc checks that are never true
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-amd-iommu-fix-acs-v2-3-982472452638@rong.moe>
References: <20260821-amd-iommu-fix-acs-v2-0-982472452638@rong.moe>
In-Reply-To: <20260821-amd-iommu-fix-acs-v2-0-982472452638@rong.moe>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, 
 Huang Rui <ray.huang@amd.com>
Cc: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-1f2f7
X-ZohoMailClient: External

The state transitions of the AMD IOMMU Initialization State Machine
imply that some ad-hoc checks will never be true. In detail, they are
only reachable if the previous state transitions have succeeded, but the
conditions are only true if the previous state transitions have failed.

Therefore, remove the redundant ad-hoc checks.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/iommu/amd/init.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0e63ad653284..9ecefe12aabf 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -163,7 +163,6 @@ int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
 static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
-static bool amd_iommu_detected;
 static bool amd_iommu_disabled __initdata;
 static bool amd_iommu_force_enable __initdata;
 static bool amd_iommu_irtcachedis;
@@ -3222,9 +3221,6 @@ static int __init early_amd_iommu_init(void)
 	acpi_status status;
 	u8 efr_hats, max_vasize;
 
-	if (!amd_iommu_detected)
-		return -ENODEV;
-
 	status = acpi_get_table("IVRS", 0, &ivrs_base);
 	if (status == AE_NOT_FOUND)
 		return -ENODEV;
@@ -3303,7 +3299,7 @@ static int __init early_amd_iommu_init(void)
 	}
 
 	/* Disable any previously enabled IOMMUs */
-	if (!is_kdump_kernel() || amd_iommu_disabled)
+	if (!is_kdump_kernel())
 		disable_iommus();
 
 	if (amd_iommu_irq_remap)
@@ -3398,12 +3394,6 @@ static __init void iommu_snp_enable(void)
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return;
 
-	/* SNP support required IOMMU to be ON */
-	if (no_iommu) {
-		pr_warn("SNP: IOMMU disabled, SNP cannot be supported.\n");
-		goto disable_snp;
-	}
-
 	amd_iommu_snp_mode0_sup = check_feature2(FEATURE_SNP_PAGE_MODE0_SUP);
 	/*
 	 * If SNP page mode 0 is not enabled, then SNP support requires that IOMMU
@@ -3716,7 +3706,6 @@ void __init amd_iommu_detect(void)
 	if (ret)
 		goto disable_snp;
 
-	amd_iommu_detected = true;
 	iommu_detected = 1;
 	x86_init.iommu.iommu_init = amd_iommu_init;
 	return;

-- 
2.55.0

