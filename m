Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8F34D901
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394256; cv=pass; b=nanZXyA6bQKfzAL8OnboimX3pw2apRqrGADBirj8EvciXkUPl+tdtuzyqGxfBom2RDSJDztvZ4mgI8+dkQ5H3CBGU9sHlAx2I7onUs8cSG7tUBcqI/H9jGP8ZmtHu6ntjZ+Lj5lAeKrYANyl7h0Aiz2CbTcYBK2lyEOhCWKwN6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394256; c=relaxed/simple;
	bh=ngv1jsIY7bOz47ZIJ91h19FVKbduEhKYjMkWXNddfxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gxaPhv9+CAcnxb3bQvrNIqPo3YdT+WJmObqUUQHSpMxRr6cNq3E7rdkFLX66ZUvghudrfNKmYUjSWhQ60bleNUjKmVwMCkISCuW8vbNmGxobiRIT1tF01C7d8hc4kqkjW2IlFarZxE8X16h0EA/utwrbB6orAT9ZfXeIkKkCheo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=FUO+4Cze; arc=pass smtp.client-ip=165.173.182.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="FUO+4Cze"
ARC-Seal: i=1; a=rsa-sha256; t=1786394216; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VtUHVC3hnxpRudVPehGgoVjQ6dJAT9/5kvRcsITr4FwYPBtPeb4pMQz29QZRVoaFS139VKL/f6PweeDOfB8LbFE3CK/PonQOsNGZmEbz5GtdRuSXlxWccWwW3b6v+XrrsXSipEUJYGodglSdaWyY+z3Kz7nVTXXcs65imGmOxk0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786394216; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QyAPXfkwdfCl1wuSfurBA1idyeUEZ/UK8YGNq+iZBCg=; 
	b=DH5rgcPoNv1BoN17b4Eo/575nAkiv/c74pdfI+KfQ/RPV5vxj8JV42WJYASlbp0mnYbz2vcWVSDW0+kYopzBHOtcMSfslMo1bEP4Pm4y7BZ+5nNtJGPE3ei/g14mRSZD5ydJiEJGKQXcblbcc6tMam4ZF2Dz5M9qhiQwdyqQnXs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786394215;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=QyAPXfkwdfCl1wuSfurBA1idyeUEZ/UK8YGNq+iZBCg=;
	b=FUO+4Czek4X1FNYb1CJdpTnt5pQ4wsWVdQoXWNotss1vKPnPc3+DNTWLA+Xxe0P+
	tTz3nuEJB3ZMfbUEN3Q5ehIImVmREOTZMrNThY3CQJz+DZqCBucJnG+jMYwoINW9cXC
	mnfYXjGKB0dllhzzkH3uvi6MW6i5NvJQ44US3SAT1sgmo2/w9L0knqGC4O7b3OlKwJO
	g1oHJ9npRJ5TNRt7QzIP0s+Jfk0M6yCQn7WyeBxCnm2JTWt2v7MlDdSeQc3K6uQz/vP
	9sHw9SrH2b8gMmXm6DA+B3+XYTos3vulX916ZWeApfF99m2SEPgwV+UHEx1jzwC7VN9
	xmFyYzPncg==
Received: by mx.zohomail.com with SMTPS id 1786394212949738.2946935663375;
	Mon, 10 Aug 2026 13:36:52 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Tue, 11 Aug 2026 04:36:19 +0800
Subject: [PATCH 2/2] iommu/amd: Remove ad-hoc checks that are never true
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-amd-iommu-fix-acs-v1-2-d64e2172408d@rong.moe>
References: <20260811-amd-iommu-fix-acs-v1-0-d64e2172408d@rong.moe>
In-Reply-To: <20260811-amd-iommu-fix-acs-v1-0-d64e2172408d@rong.moe>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, 
 Huang Rui <ray.huang@amd.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-2f6f2
X-ZohoMailClient: External

The state transitions of the AMD IOMMU Initialization State Machine
imply that some ad-hoc checks will never be true, so remove them.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/iommu/amd/init.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 31fce7c8f530..c988a6ee8b31 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -163,7 +163,6 @@ int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
 static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
-static bool amd_iommu_detected;
 static bool amd_iommu_disabled __initdata;
 static bool amd_iommu_force_enable __initdata;
 static bool amd_iommu_irtcachedis;
@@ -3190,9 +3189,6 @@ static int __init early_amd_iommu_init(void)
 	acpi_status status;
 	u8 efr_hats, max_vasize;
 
-	if (!amd_iommu_detected)
-		return -ENODEV;
-
 	status = acpi_get_table("IVRS", 0, &ivrs_base);
 	if (status == AE_NOT_FOUND)
 		return -ENODEV;
@@ -3271,7 +3267,7 @@ static int __init early_amd_iommu_init(void)
 	}
 
 	/* Disable any previously enabled IOMMUs */
-	if (!is_kdump_kernel() || amd_iommu_disabled)
+	if (!is_kdump_kernel())
 		disable_iommus();
 
 	if (amd_iommu_irq_remap)
@@ -3369,8 +3365,8 @@ static __init void iommu_snp_enable(void)
 	 * The SNP support requires that IOMMU must be enabled, and is
 	 * configured with V1 page table (DTE[Mode] = 0 is not supported).
 	 */
-	if (no_iommu || iommu_default_passthrough()) {
-		pr_warn("SNP: IOMMU disabled or configured in passthrough mode, SNP cannot be supported.\n");
+	if (iommu_default_passthrough()) {
+		pr_warn("SNP: IOMMU is configured in passthrough mode, SNP cannot be supported.\n");
 		goto disable_snp;
 	}
 
@@ -3660,7 +3656,6 @@ void __init amd_iommu_detect(void)
 	if (ret)
 		goto disable_snp;
 
-	amd_iommu_detected = true;
 	iommu_detected = 1;
 	x86_init.iommu.iommu_init = amd_iommu_init;
 	return;

-- 
2.55.0

