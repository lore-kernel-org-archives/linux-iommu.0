Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2060E392C50
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250381; cv=pass; b=Y6U5yureIgxb3ByBVSFN1y08g769SITyVQgZAKdSoj62pQqUUQs0nQGX5gT1Fs7wnsN2V1X07nNu4+SfUE/a6UDBdsWHAEZbsE9g0D1moiGGwL3Eui+Z7cZaq9vBiXlKpJfipriiN8sk8mUMdwKi1YGGQn44kNnOVF3yPTSEVNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250381; c=relaxed/simple;
	bh=2h+sGBdTXdrt98jWCFRyslaO/ml0lW75Ecel2aXyRX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BQ7kUPmoEfK9yd7+4jDyGjshiyUwI2t6yRvcATqbdPkdkFj3z9v07o9eYyLfWK8049TUmmGs1wkQjJ4HAf9d+C2HnkrcYEMdOU4NGe/qK3Uhw4nOiRGF6/m9ARIRY2Q/8FKElJpaUZPnLgjpmvWoGjtmnqoj7YHPqzq9UgmzhLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=iBqat2dm; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="iBqat2dm"
ARC-Seal: i=1; a=rsa-sha256; t=1787250338; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CnkMsHZoilBaFDgO6BVtfQdnHv8PcpNy2SROprzz5kNbcdenZk2w7YzL14ICDkrRCNK0hpmgK4o/GQ6KMzR1Eg2prqDukTNdOQD8VmFFy+7hGUlU6ofizx5tGwLJpgHq2KIxrHyasRL22qlN1Z0L/tP7DAhC45KHYsIdq+q6Iak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787250338; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HVhad97Z0mDE/xMaSmWIH609y3dtGJh1KG2Bs3OcPc0=; 
	b=MmajNFY0WKe0vnoaFiVKaAwzygIlhHQdWzcDwiBdky+gWpTYMbxGG+JwWCty+q3yupiI6STGmLS7C25Tbl1+3n6KuNoBMgEvZ1j5cgBTax1mFwBS5QftzrO/J3XaRgndeeYE75pLpGsXw6KpMHOmpzSJzmrcRGS1KS412kJXTp8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787250338;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=HVhad97Z0mDE/xMaSmWIH609y3dtGJh1KG2Bs3OcPc0=;
	b=iBqat2dmQkwSwxX4Vpp29bltlsNt4p16luHbNxhWADhtpXmj5HPhgcqvU3S25PFc
	ZUaplsYBe/7kQMuhyk1GHlCfseb/TlUrI0Jw1eThpLVG/3e5h7yNPy+luoVbEXgdyKI
	mpf71xEds82o3PK5ZyCoRDp/hqdapHdeQNyYW6JukX0YNwzj1OSpbBwye2+1d7AaSCb
	TuDfzSPbaM3iCsOJKgOmMYmUuPWICHa1iC7yXfadoytbtbs2m0Ox/DHjl8TbwHJ++jF
	kkiKTxFTDc312dHcE8wdRWLaxVHxQC3QCBHB3s5Iq+wrUqiA/02Fl76u34NaN5xXgde
	f/0AhdkSZw==
Received: by mx.zohomail.com with SMTPS id 1787250336202502.16508339597954;
	Thu, 20 Aug 2026 11:25:36 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Fri, 21 Aug 2026 02:25:08 +0800
Subject: [PATCH v2 2/3] iommu/amd: Disallow implicit START_STATE =>
 IVRS_DETECTED transition
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-amd-iommu-fix-acs-v2-2-982472452638@rong.moe>
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
index a720796cca3b..0e63ad653284 100644
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

