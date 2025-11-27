Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106052DEA90
	for <iommu@lists.linux.dev>; Thu, 27 Nov 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764263213; cv=none; b=BLEPacZlpKtgHjPs7BUBIINJTC8RY9qXyq6z/j/JT4L6fLOr700KF9GVGWuDwusQGG8cKm4n6FfcE60L9umJdIj7McQz011c7mQvlafomQZbawdb9KPjdqNlQLBOTO32Rz25g5PsnMf3ZutKwKSVwO90K5j3nQVUd5lUWUcva+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764263213; c=relaxed/simple;
	bh=2pGjFtgygQog81j5hyJ9qMqnB4KDkiHYVL7dMBUtSK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kwipsb6rFHjy/uXDK77Ijpzp045rbxeNA/CXIDqIzHTjEWfZ+ClEjS5IMdSkqZ6TzBvx79nfpEkaU/Jex0L9E4SkFTKnkFrr2Ipc3ASknv4/Uvpl6qABmMK6BG2xWq3SzmOPRPbaXSfjXF0D51lkhpoKtMG4dnaLu8C9nrZ/6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=Xhp1Zbn6; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="Xhp1Zbn6"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bc169af247eso837717a12.2
        for <iommu@lists.linux.dev>; Thu, 27 Nov 2025 09:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1764263210; x=1764868010; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O1wzZVQNXVHZbxIkXXGbICah4xL6MedDn9xemncaRUY=;
        b=Xhp1Zbn6r1/UJj9+fVlwsoQr6DRjvPRZTUE7j6gfpFyKkPjhWPcoEincEpP5E46kTW
         v4kuvRH4N0ouXa2uaW/Sfw087MP+sK/a51swwQeEoPlz3GCdIiLjz6JbYUgW6jhMnnZQ
         NK7L/P7unK76d1rKAEMN+7fxyw4E05ZV20i9dEArdFU3v2oj904twK41R22dq/+Zeem4
         jVg6Mll38d4Wv+04dTScgD5EZLLZ271+T3WjT75To5HA6f37dZ07/sB96mrMCRIEEihL
         dhD5KBgzE7zP7IrdoSXdVEUUacFbN2kc2j9LNCGKwiqnI1E8IsygenbPVN7WuI2bWn+c
         eoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764263210; x=1764868010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1wzZVQNXVHZbxIkXXGbICah4xL6MedDn9xemncaRUY=;
        b=kyN2Aa36CHzh1Y+Si3tzndVsloVEsdNy3jRlds38aYKr9VVTkJUv5BVZV+8zit64qt
         3ZjRrwBG/bRjfbGKrUqhEpY+UyIbS5mZTqoa8avDtmian7Jururni6M8jW1jlMWsHaK+
         VryAyUCVPG87vdD9qQn/9wWF0pym9Dps7BxTn+glwa62F046weMEZsORYfffseOlPj9G
         /3F49m9s5hCDab53amNkTNu0r9RVa3yo1kD5DjLbEd0eez2D1djmj3wzW+vZOMyDs7bS
         vOgWydVUzyi5WSH/WkggGtdZy+5vCuxCazT4DwO4e0zc/Zva1yCwESESlE1Qkh32LzL3
         RJig==
X-Gm-Message-State: AOJu0YyJViKXXI8uogvKcumZRLG4wXTpTW5sZQaMmlhnrjpHgRA/PI/a
	G6u64BysSOPt5UI/BOTa1lJOzpWQQUi1S6/6QFEcMmKMJQ9T87Opd00kqdBTFvActck=
X-Gm-Gg: ASbGncvxY4SOsWpPykYXliEHGcP+S6TJwBRnIaHdEgneCOSUz9IdvVBMqfy6LCFqP79
	zLJo69eCfkotNsLtSvlzEJBjFjbB19z/H+CEHaLAQXEPZ5ya/QgiPE3qTqCQmDimGM17tfh/gss
	7OFhpjfitbVBKweVn+6Noe645Gjj21LBhvU11oOqEfcGHMakJlGEz+PFft67mUR66gfofnWEDs8
	BzACDUHEUpTQdJ0QkzARqQm5cxjfKVnP4ecwTeBOsfaJTuUVIm6fombXAw6go90+h0vQUPXcH+Z
	rMRCvS1ccah3FRGZBbBLmPaNb5KmiIbS5NrGTmAMWCTCAVlTAliCfQQYr+urVr+bVEnRvf/XWEx
	MP+QtJNS6456OBXgGOhcdXm9f5DGmGRk2zhQUf81sTJ49TxJdh0zhNynxz6mf0qs+63lWI8AkxS
	3kkKXVtTcOwoE3
X-Google-Smtp-Source: AGHT+IGn2E7HnK8x4QEe26xP5j2AoT30DIB6+NZ7ezurJPylhUsc9dliLtZqgwxqaptGKRKgxK/+Ww==
X-Received: by 2002:a05:7300:5a1d:b0:2a4:3593:969b with SMTP id 5a478bee46e88-2a71927a5a0mr12709691eec.24.1764263209953;
        Thu, 27 Nov 2025 09:06:49 -0800 (PST)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a96560986csm12251610eec.2.2025.11.27.09.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 09:06:49 -0800 (PST)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH next] iommu/vt-d: Use shallowest supported table depth in sagaw
Date: Thu, 27 Nov 2025 09:06:35 -0800
Message-ID: <8f257d2651eb8a4358fcbd47b0145002e5f1d638.1764237717.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A Skylake machine has problems with strict translation on next-20251124:

    pci 0000:06:00.0: Adding to iommu group 18
    ------------[ cut here ]------------
    WARNING: drivers/iommu/iommu.c:3055 at iommu_setup_default_domain+0x268/0x2f0, CPU#2: swapper/0/1
    CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.0-rc6-next-20251124 #1 PREEMPTLAZY
    Hardware name: ASUSTeK COMPUTER INC. WS C246M PRO Series/WS C246M PRO Series, BIOS 6101 06/26/2024
    RIP: 0010:iommu_setup_default_domain+0x268/0x2f0
    <snip>
    Call Trace:
     <TASK>
     iommu_device_register+0x126/0x200
     intel_iommu_init+0x2bf/0x580
     pci_iommu_init+0xb/0x30
     do_one_initcall+0xad/0x1c0
     kernel_init_freeable+0x238/0x290
     kernel_init+0x16/0x120
     ret_from_fork+0x1ba/0x1f0
     ret_from_fork_asm+0x11/0x20
     </TASK>
    Kernel panic - not syncing: kernel: panic_on_warn set ...
    <snip>
    Dumping ftrace buffer:
    ---------------------------------
     2)               |    __iommu_group_set_domain_internal() { /* <-iommu_setup_default_domain+0x25e/0x2f0 */
     2)               |      __iommu_device_set_domain() { /* <-__iommu_group_set_domain_internal+0x6d/0x140 */
     2)               |        __iommu_attach_device() { /* <-__iommu_device_set_domain+0x6d/0xb0 */
     2)               |          intel_iommu_attach_device() { /* <-__iommu_attach_device+0x1f/0xe0 */
     2)   0.140 us    |            device_block_translation(); /* <-intel_iommu_attach_device+0x19/0x80 ret=0xffffffff81b5e980 */
     2)               |            paging_domain_compatible() { /* <-intel_iommu_attach_device+0x24/0x80 */
     2)               |              paging_domain_compatible_second_stage() { /* <-paging_domain_compatible+0x47/0x170 */
     2)   0.137 us    |                pt_iommu_vtdss_hw_info(); /* <-paging_domain_compatible_second_stage+0x29/0x1a0 ret=0x1 */
     2)   0.530 us    |              } /* paging_domain_compatible_second_stage ret=-22 */
     2)   0.907 us    |            } /* paging_domain_compatible ret=-22 */
     2)   1.653 us    |          } /* intel_iommu_attach_device ret=-22 */
     2)   2.157 us    |        } /* __iommu_attach_device ret=-22 */
     2)   2.528 us    |      } /* __iommu_device_set_domain ret=-22 */
     2)   2.954 us    |    } /* __iommu_group_set_domain_internal ret=-22 */
    ---------------------------------
    Rebooting in 10 seconds..

The failing condition in paging_domain_compatible_second_stage() is:

    /* Page table level is supported. */
    if (!(cap_sagaw(iommu->cap) & BIT(pt_info.aw)))
        return -EINVAL;

This happens because, for many domains on this machine, MGAW=39 but
SAGAW=0x04: that claims a 39-bit maximum address width, but also claims
to only support 48-bit/4-level paging, which seems odd.

Before the GENERIC_PT rewrite, the kernel only looked at SAGAW, so this
machine has been happily running for years using 4-level paging.

Now, the kernel refuses to use 4-level paging because MGAW=39. But SAGAW
claims not to support anything else, so we hit the -EINVAL case above
and fail to initialize.

If I force 4-level paging, everything works. If I force 39-bit/3-level
paging, nothing works (lots of bad context faults). So it seems like the
machine really only supports 4-level paging despite the 3-level MGAW.

I initially thought this was a latent firmware bug. But I can't actually
find anything in the VT-d spec which says the page table can't be deeper
than the physical address width. If it really is allowed, it's certainly
wasteful, but it seems to be the only way this machine will work.

Fix this by using the smallest page table depth supported by SAGAW which
is large enough to contain MGAW, allowing a deeper table than MGAW if
the hardware only supports that configuration.

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/iommu/generic_pt/fmt/vtdss.h |  7 ++++++
 drivers/iommu/intel/iommu.c          | 32 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h     |  4 ++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/iommu/generic_pt/fmt/vtdss.h b/drivers/iommu/generic_pt/fmt/vtdss.h
index d9774848eb6f..bbf6861d9be5 100644
--- a/drivers/iommu/generic_pt/fmt/vtdss.h
+++ b/drivers/iommu/generic_pt/fmt/vtdss.h
@@ -249,6 +249,13 @@ static inline int vtdss_pt_iommu_fmt_init(struct pt_iommu_vtdss *iommu_table,
 {
 	struct pt_vtdss *table = &iommu_table->vtdss_pt;
 	unsigned int vasz_lg2 = cfg->common.hw_max_vasz_lg2;
+	unsigned int ptsz_lg2 = cfg->common.hw_min_ptsz_lg2;
+
+	if (vasz_lg2 < ptsz_lg2) {
+		pr_warn_once(FW_BUG "HW requires wasteful %ubit PT with %ubit MGAW\n",
+			ptsz_lg2, vasz_lg2);
+		vasz_lg2 = ptsz_lg2;
+	}
 
 	if (vasz_lg2 > PT_MAX_VA_ADDRESS_LG2)
 		return -EOPNOTSUPP;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d745f833d8b5..d44766bba3d7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2798,6 +2798,36 @@ static struct dmar_domain *paging_domain_alloc(void)
 	return domain;
 }
 
+static unsigned int compute_min_ptsz_lg2(struct intel_iommu *iommu)
+{
+	unsigned int sagaw = cap_sagaw(iommu->cap);
+	unsigned int mgaw = cap_mgaw(iommu->cap);
+
+	/*
+	 * Return the shallowest pagetable depth sufficient to represent the
+	 * maximum guest address width which is supported by the hardware. On
+	 * some hardware, that shallowest depth is deeper than the MGAW.
+	 */
+
+	if (mgaw > 48)
+		goto five;
+
+	if (mgaw > 39)
+		goto four;
+
+	if (sagaw & BIT(1))
+		return 39;
+four:
+	if (sagaw & BIT(2))
+		return 48;
+five:
+	if (sagaw & BIT(3))
+		return 57;
+
+	pr_warn(FW_BUG "Can't satisfy mgaw=%u and sagaw=%02x", mgaw, sagaw);
+	return mgaw;
+}
+
 static struct iommu_domain *
 intel_iommu_domain_alloc_first_stage(struct device *dev,
 				     struct intel_iommu *iommu, u32 flags)
@@ -2832,6 +2862,7 @@ intel_iommu_domain_alloc_first_stage(struct device *dev,
 	cfg.common.hw_max_vasz_lg2 = min(cap_mgaw(iommu->cap),
 					 cfg.common.hw_max_vasz_lg2);
 	cfg.common.hw_max_oasz_lg2 = 52;
+	cfg.common.hw_min_ptsz_lg2 = compute_min_ptsz_lg2(iommu);
 	cfg.common.features = BIT(PT_FEAT_SIGN_EXTEND) |
 			      BIT(PT_FEAT_FLUSH_RANGE);
 	/* First stage always uses scalable mode */
@@ -2916,6 +2947,7 @@ intel_iommu_domain_alloc_second_stage(struct device *dev,
 
 	cfg.common.hw_max_vasz_lg2 = compute_vasz_lg2_ss(iommu);
 	cfg.common.hw_max_oasz_lg2 = 52;
+	cfg.common.hw_min_ptsz_lg2 = compute_min_ptsz_lg2(iommu);
 	cfg.common.features = BIT(PT_FEAT_FLUSH_RANGE);
 
 	/*
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index cfe05a77f86b..8c32e492d6d1 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -188,6 +188,10 @@ struct pt_iommu_cfg {
 	 * might select a lower maximum OA.
 	 */
 	u8 hw_max_oasz_lg2;
+	/**
+	 * @hw_min_ptsz_lg2: Minimum page table depth the IOMMU HW can support.
+	 */
+	u8 hw_min_ptsz_lg2;
 };
 
 /* Generate the exported function signatures from iommu_pt.h */
-- 
2.47.3

