Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021C36896D
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787437294; cv=pass; b=iu9hzcGpUi3AhjLy17xy8SIRjPLDsC7LOGkrILFIUhz6rDkFnX++iNJYd4Weth7halSrshBt+v/MoVISfmL20DxLMv9xVmCSkRSZ4y6Mb/SetMjvRNisfA+hOABNXHgW9Vt+lLLnU9xOXrrfEb5dI0IPNlZaWCaO2Uq8ljgNcpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787437294; c=relaxed/simple;
	bh=9cRh4fnrLLzesRftsjxaQGgX0HFD8hkIJVQaRFffjog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GUltaxPVFljY7C2uDdxLBaZtryF6pUL5b0wHdsEtAafKiXYt2NCPlhHGupBZO6NkI/qbUxZhf/iyZ4UPKPIhXMTcfwGjFY8GnXLmT8lJ3fs0xhQO0NnL7Czh7iySOQvY9ciH2ziRKvEtKhUoaGJDZ3qZNweJ2jNH6w5ihZD1j2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=E6lun4qZ; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="E6lun4qZ"
ARC-Seal: i=1; a=rsa-sha256; t=1787437244; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nmQu9g6hjH4roma0j+enZC/jqDciE+qM2o7Mh0XddobJEHlP56DcQ0ZElDYxouI4Aud1JkXHbiGuYRk0l04lbU9ZyGvfayZoCeF3OGrCeBGZ7oQ1WKdVXJWnDoEoHIdsnwhe9rMWmWrOma+5P8wA+4+03TVbbR7SqZxGsBGRPpc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787437244; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iyt8shaTMGeCWxc+lY/CB0B5V7Tna7mdBfZQ1b4z7Co=; 
	b=ZDUijIXG9Y5FaiHLM53rIigAD7CpIf/UmyaoyiG8vDV4yqBnX4BmNfoQYMuPrK7mmEsTDCzqHnd2Mc2XrQaw3bxEYUDLwruIsp3ngISAEnOK1H6rmmJij6CNqEa80aC5fnrmPKewmuWzOysLGJYzHWCmNQqJiEKMTBocV4xT2Ss=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787437244;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=iyt8shaTMGeCWxc+lY/CB0B5V7Tna7mdBfZQ1b4z7Co=;
	b=E6lun4qZnSURhKYpf1nGsx3Akfgchk5ZzjWk46B79yDt8VvsItsfmjlYcr51NbEo
	kSITpbToEJIyh3QXQsQJOxV86z1HYCSs1jizi5CX8Cr7UIFP2SmTKOMiUarD7Jpnsb2
	YhqPxWUl8aZrSbrBSlypGrmbrjpDGywvPhGQECTjrOYlBGrJyOecEN/JhwV7pF7P4E6
	Sk+lRd436Ccd6O9Dc5+lbLogz9WIX1HvMeJ/qNvb6pzEd2vGjRusPw37OTsXMuHQmHU
	V/xZeDvw1zTaTB4J98rDJlS8Rt6g5UqljWVzkN/6dY4aq3ZHGEwBd6agi9Wq2ngOTWi
	7S+Cw6VIkw==
Received: by mx.zohomail.com with SMTPS id 1787437243614168.4123985263932;
	Sat, 22 Aug 2026 15:20:43 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Sun, 23 Aug 2026 06:20:17 +0800
Subject: [PATCH v3 3/3] iommu/amd: Remove ad-hoc checks that are never true
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-amd-iommu-fix-acs-v3-3-dd768e09d771@rong.moe>
References: <20260823-amd-iommu-fix-acs-v3-0-dd768e09d771@rong.moe>
In-Reply-To: <20260823-amd-iommu-fix-acs-v3-0-dd768e09d771@rong.moe>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Huang Rui <ray.huang@amd.com>
Cc: Ankit Soni <Ankit.Soni@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
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
index 72b5b11b9d75..d81adb8efe0e 100644
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

