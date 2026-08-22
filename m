Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B00630E85B
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787437270; cv=pass; b=r3XdVEFwT3HRV4PlLiO3cj71jChkBJeW/5guSOqLLTsb0BGGhWE2PnnleHUKMEKWVYKF1xr+Z15PLVyG9fP1++e2qHyGGRfBmb23pIVCle0pef+IkQvC5A9h/D27URAGTa98/ZUqbvg9I0Vnuxom3iwWQLzj0OuR1a1qi/xSpCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787437270; c=relaxed/simple;
	bh=h8TfqPX2WpbnFrAtyGDcw4nT6/QR3iW+y9fFy/kl0X0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hpbdps059ku7AJ1oUAFuQ5bHS41gaYKY5sRKgJVLp0qySzQbiY6MvlAaoeqEOFgs+c3IgnCbHfTZxn5a5Ow4WZuHukvG/eGk//9Kztg1vMluuApspArWv9qkF7oA08j1HozoiXWzQbwzj015BS0rdpdDZccxOXlPohy6sjLRiFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=XE7FoOW6; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="XE7FoOW6"
ARC-Seal: i=1; a=rsa-sha256; t=1787437238; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z8dsnHSvCFZLeKQGnUeTeD57uew0Ndr4mqgGFUgWbZ3D9EJE/ZC6V3Uv2Ut8jna2TusSUETxh2k7YyQ+G9gVFhAc4Yz1upENpNBncmCCnp4UkkQXFGXpgWsxUNXt5ZUw/YCgyTcl3Rrpcdot90J+9EcDPPecZQxVfwMxiTJQjEQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787437238; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GtGsTB5Glx57MwzxsA8bZzWGARAfxh0/aSNYEXk1fWM=; 
	b=NP6dqMCrRPc7lkAjgBW5zKLD3RN4bF257130ywHvtuVci4yW4AcMRlgTjVs6n/jSSGmmT2ZrsYfHf/qlTsfVdwAP58WdwHE6T1GF0A90TJlJbI0TZIcXy9DUtnawqW3yprNzKwVVqnJ8mOg+zfRUNjD+ONX1cqgSd21yt2gKbsw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787437238;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=GtGsTB5Glx57MwzxsA8bZzWGARAfxh0/aSNYEXk1fWM=;
	b=XE7FoOW6Sbn3rfjLyBlFmI8ewyv84Squjei40GGv/74Pib7lGh/xHQF+kABwqbJ9
	PYax8k33bpafPCFEEwLEiHDZ26ngSoMDIc8E21Lsr8b6kVXpjIguoa7az5ya9PhMEAw
	PCFD/wp7UrBF4XBso/q+NFHImvqgwVWXIiShlSiFKtOTOEwe8/2FTChkYCIZMegBZ9v
	Zih0Mvlt57wVxiSkgFRw00YL9FBW9ALK2fYU/F9IvUnlF0J/5WdVlNNlRc4ku/cNNSK
	bdPwQEtvUVJzXXc054KOu5+i1eC0YFimvGVHvnAOJ2Vy2aiHuI+Aycm2z8mFbfRBWNa
	wGoaaruSCw==
Received: by mx.zohomail.com with SMTPS id 1787437237161845.8381860069328;
	Sat, 22 Aug 2026 15:20:37 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Sun, 23 Aug 2026 06:20:16 +0800
Subject: [PATCH v3 2/3] iommu/amd: Disallow implicit START_STATE =>
 IVRS_DETECTED transition
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-amd-iommu-fix-acs-v3-2-dd768e09d771@rong.moe>
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

Xen PV intentionally skips calling amd_iommu_detect() in order to gate
IOMMU initialization, as the Xen hypervisor has taken over the hardware.
However, due to amd_iommu_prepare() requesting ACPI_FINISHED while
setting up APIC, the state machine is still progressed, only to be
stopped midway due to the `!amd_iommu_detected' check in
early_amd_iommu_init(). This is worthless and fragile. It unnecessarily
calls detect_ivrs(), which leads to extra overhead, i.e., getting the
IVRS table and accessing the PCI config space.

Disallow implicit START_STATE => IVRS_DETECTED transition, so that
amd_iommu_prepare() and other paths no longer progress the state machine
accidentally. This should also help prevent potential bugs if more
housekeeping work is added to amd_iommu_detect() in the future.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/iommu/amd/init.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0fd0801a873f..72b5b11b9d75 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3571,6 +3571,19 @@ static int __init iommu_go_to_state(enum iommu_init_state state)
 {
 	int ret = -EINVAL;
 
+	/*
+	 * Some essential housekeeping work is done by amd_iommu_detect().
+	 * Skipping calling it implies that the platform (e.g., Xen hypervisor)
+	 * has taken over the hardware. Progressing the state machine in this
+	 * case is worthless and fragile.
+	 *
+	 * There are several paths requesting later states, so disallow implicit
+	 * START_STATE => IVRS_DETECTED transition to prevent these paths from
+	 * accidentally progressing the state machine.
+	 */
+	if (init_state == IOMMU_START_STATE && state != IOMMU_IVRS_DETECTED)
+		goto out;
+
 	while (init_state != state) {
 		if (init_state == IOMMU_NOT_FOUND         ||
 		    init_state == IOMMU_INIT_ERROR        ||
@@ -3579,6 +3592,7 @@ static int __init iommu_go_to_state(enum iommu_init_state state)
 		ret = state_next();
 	}
 
+out:
 	/*
 	 * SNP platform initilazation requires IOMMUs to be fully configured.
 	 * If the SNP support on IOMMUs has NOT been checked, simply mark SNP

-- 
2.55.0

