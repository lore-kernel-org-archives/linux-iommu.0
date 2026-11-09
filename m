Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794260216;
	b=Y6iKevvusF8GV6mAUYN0fOZTnRsNcmPVhxJNRV4zbV5VhQpAIaDgvU+a1oPtdVJUV1Ao
	 sDSnRDA7EUuT7Uv3XgfUCzxXZnabrPQbqAzsQrEn5Ql9b6J2sZ4QyQ57lbuz+wJEuVIUd
	 /sYoaor72d77yJEbbj98aKzkWu5Vf0n7hcraQYBhSf+1KRFy60f023WkQQhobx+waRSVx
	 EWBd1+BWaTcM8Xk6h4uGS0LUkXnFkQRcWDhuDotd71whpcBPeCyuBhLcTTx5diJNQIkLi
	 zJ4jtAX6FTgHBhUnN+bTHP/8763zlgbS0sU+J0x/klQELiZ5fcLQEu7cH0dwtYnnGRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260216;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wNEcqcf2Bak8iU+Tyv3XvPD2MsQ9tlicZ0G0IJwdxvA=;
	b=z1sEXXI907rrggT3vMrlynCA7/uTajKuxDfzoNvOlrNUF2pCWl1FCPWqhFipNsuu1BEp
	 R1MlXL0djUHVGz4OGnqV9zilxBVLWkwNbOdNjWsEvA3p2JpKVY8I4+C74EAeLXAGjSOrd
	 bOK36gu9ZPujL+ENEIPgtomWRI9mEA+Mwb8iq5HTmOoFcO2+YSKx1Vup1Cp7iikUZr3Iu
	 oww55llrovmg7XAtpfw/twGMwmWEzXKxdohnbhK9gtheHozBJaIQEtErcyAkPn02q6zhn
	 wGHba9n0hL/Iqhi/m/FAhCzw1UP1MY/IlSBguv3mDOoausJw2oFxF+oRsGcSa0QiIUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIo7kSaq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B67606A321;
	Mon,  9 Nov 2026 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIo7kSaq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794260215;
	b=hc1NeB6wq5/3rZWX1gO0tXoDKOJLgfaq6+UnLPoylT0gRL0dZZkXOwxxyKK8Z5DI/mD1
	 r6b6DxCD4l5fKdZN/aVAQu/tu6aYfwzpZgjUQfhBvCP6aDW8DSntboUvrIZQejMFUiT5S
	 xUIYVytJEVKN6V/HLZdvJsxjLTho0EFk8ffXh7rDQ383vuPLj7oG4eSdV6k55uigLX06W
	 8hJQFamjPlnD9JI22+p1dHytbCZ2MhqYQghd7H7Q5WrlmOZ+pISG8ek3rbV2F+x0fmGiz
	 4Z378oW2VUn6fFuYbpkzSWl7kCBkk/nHawKSyKJ5mJOOP2lKX8lPFHRvwdXurnudFhQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794260215;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wNEcqcf2Bak8iU+Tyv3XvPD2MsQ9tlicZ0G0IJwdxvA=;
	b=K8h9nDgXka4RFG1ceFkgsYdD6Xx0YbIzxUAqgvHWGe4mVVqUOT6DRO76rYxmpinbmP1Z
	 cMyad2xrwVczqExcdyTwo17mrXi5nWDMtC9JM0Aqs/2zSY7imA/GE/HexlPbYrhhINK5F
	 jU0li+sIpk4jWRmyBzoFeCxIrGRlZPdapupUkNQ7e5eG8gUDcAop5dIE5pfJyLbKELU3c
	 z4H2sMOLgz9hXGnl3SsF/IMXAUCpha/YbyyHfgkx6Xad059vQXd/MuoVaa9ROGSXJQbfo
	 ZV5gterXuAAVub3oTz3eMoHnn5Rf1IRilTMZX8EeHdatqaDTGO8ZX7F6Syyvv5TjIcw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9B3AF1F0089F;
	Mon,  9 Nov 2026 21:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794260215;
	bh=wNEcqcf2Bak8iU+Tyv3XvPD2MsQ9tlicZ0G0IJwdxvA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=aIo7kSaqQlW09bkz3aEhV+TIWBlo7rUvCwLBOCqCSIvnfcEawVDg0Xjd/ktqGTcSb
	 S6cDJ2uqC2uB9kpXiXt3VTAbghh1hfDzmxjHzYRwQSLkuOYTBBv8cQjN183s17jQav
	 rbHtMy+1ycuNMyE3aWddtrSNeluFCVaHmscr9MxG+BA/t1/+FrdyMa98qZN2ADUNG4
	 1kIs8thGtxs31ZHjauOsLp/j80+Ck+xsS8I05QZ9IoOeWY+NBDx6wr1XdiRaKdfRrt
	 z0GY3PooQogtxoghqwTGr37CzxVcqtbBlngh5+gCOOfKwo7v4V3PPcC6x/WQTtsw/E
	 h/WNhxeuyaLsA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id ED18248687;
	Mon,  9 Nov 2026 21:36:53 +0000 (UTC)
From: Xuheng Li via B4 Relay <devnull+xuheng.cs.columbia.edu@kernel.org>
Date: Mon, 09 Nov 2026 21:36:54 +0000
Subject: [PATCH] iommu/arm-smmu-v3: Invalidate a new level-1 stream table
 descriptor
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-smmu-l1std-cfgi-v1-1-65e5203a6516@cs.columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0atI1gZMEaFeRVzUmtaAPxoVQby7x
 eVbzDygnIQV2uKBxJeobGsGlQX4ya2RUcZsMJVpiCqLuiwnzqTHiD5EQU+2HoxzgV0NudoTB7n
 /Y9e/7wcgNfKgYQAAAA==
X-Change-ID: 20261109-smmu-l1std-cfgi-c194b2aafea4
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Mostafa Saleh <smostafa@google.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 Xuheng Li <xuheng@cs.columbia.edu>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794260213; l=3824;
 i=xuheng@cs.columbia.edu; s=20261028; h=from:subject:message-id;
 bh=6TD+iMSmEHTURQXKPmgovA2DklVq76Pc1pkuQOMeEKo=;
 b=1k5jj+Kwjxcu2v8X9yi/0dkZeyGsFFuU3+Q2/V+RSonETOk4CeMcKHKtpXGIAkWXMO1wlnahj
 RG4BqgB1G36AqKQfKR/zqARvxcwBEi91PQTmwBZnb9wWYjux//W+PU8
X-Developer-Key: i=xuheng@cs.columbia.edu; a=ed25519;
 pk=L1HVV+goqxYmEMO/OXakL6uf9isSpgk2QrLlFqyZ2Qs=
X-Endpoint-Received: by B4 Relay for xuheng@cs.columbia.edu/20261028 with
 auth_id=1349
X-Original-From: Xuheng Li <xuheng@cs.columbia.edu>
Reply-To: xuheng@cs.columbia.edu
Content-Transfer-Encoding: 7bit

From: Xuheng Li <xuheng@cs.columbia.edu>

arm_smmu_init_l2_strtab() allocates a level-2 stream table when the first
master in its range is added, and makes the level-1 descriptor valid. It
issues no invalidation, and the attach that follows sends only the leaf
form of CMD_CFGI_STE.

IHI 0070 5.1.1 requires the non-leaf form of CMD_CFGI_STE when an L1STD
changes, including when an inactive descriptor with Span == 0 becomes
active. An SMMU that cached the inactive descriptor can keep terminating
the master's transactions as if its StreamID were invalid.

Issue a non-leaf CMD_CFGI_STE after writing the descriptor. The RMR path
runs before the stream table is programmed into the SMMU, and
arm_smmu_device_reset() then issues CMD_CFGI_ALL, so it needs none.

Fixes: 48ec83bcbcf5 ("iommu/arm-smmu: Add initial driver support for ARM SMMUv3 devices")
Signed-off-by: Xuheng Li <xuheng@cs.columbia.edu>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6d4520c47..f61cc6d86 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2030,7 +2030,8 @@ static void arm_smmu_init_initial_stes(struct arm_smmu_ste *strtab,
 	}
 }
 
-static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
+static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
+				   bool live)
 {
 	dma_addr_t l2ptr_dma;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
@@ -2053,6 +2054,14 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 				   ARRAY_SIZE((*l2table)->stes));
 	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[arm_smmu_strtab_l1_idx(sid)],
 				      l2ptr_dma);
+
+	/*
+	 * The SMMU may have cached the old, invalid L1 descriptor. Making it
+	 * valid needs the non-leaf form of CMD_CFGI_STE (IHI 0070 5.1.1).
+	 */
+	if (live)
+		arm_smmu_cmdq_issue_cmd_with_sync(smmu,
+						  arm_smmu_make_cmd_cfgi_ste(sid, false));
 	return 0;
 }
 
@@ -4261,7 +4270,8 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 	return sid < smmu->strtab_cfg.linear.num_ents;
 }
 
-static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
+static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid,
+				    bool live)
 {
 	/* Check the SIDs are in range of the SMMU and our stream table */
 	if (!arm_smmu_sid_in_range(smmu, sid))
@@ -4269,7 +4279,7 @@ static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
 
 	/* Ensure l2 strtab is initialised */
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
-		return arm_smmu_init_l2_strtab(smmu, sid);
+		return arm_smmu_init_l2_strtab(smmu, sid, live);
 
 	return 0;
 }
@@ -4333,7 +4343,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		struct rb_node *existing;
 		u32 sid = new_stream->id;
 
-		ret = arm_smmu_init_sid_strtab(smmu, sid);
+		ret = arm_smmu_init_sid_strtab(smmu, sid, true);
 		if (ret)
 			break;
 
@@ -5713,7 +5723,8 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 
 		rmr = container_of(e, struct iommu_iort_rmr_data, rr);
 		for (i = 0; i < rmr->num_sids; i++) {
-			ret = arm_smmu_init_sid_strtab(smmu, rmr->sids[i]);
+			/* The stream table is not programmed into the SMMU yet */
+			ret = arm_smmu_init_sid_strtab(smmu, rmr->sids[i], false);
 			if (ret) {
 				dev_err(smmu->dev, "RMR SID(0x%x) bypass failed\n",
 					rmr->sids[i]);

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261109-smmu-l1std-cfgi-c194b2aafea4

Best regards,
-- 
Xuheng Li <xuheng@cs.columbia.edu>


