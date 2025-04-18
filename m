Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60B263C71
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744946173; cv=none; b=RisQcxOAMwL+LV6G0zFiZyWQ2NOjtIBl6+UMi1NlcWwx2jliEUDcP464k/rZbttjIe8K5Yg+BCb7RgSNpU2dmjUgoIflQnx0z2/Loj61pyV3tlvnmvo4dpwNpXVfo7W1vxOGedf0j+1vR4ImMOCK0jpBNQ13YlWyRaZaBppfVF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744946173; c=relaxed/simple;
	bh=CKh9qggo+rmj99kU0diFTRU9xqoaNX6PAPME7n+az0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuklpZmXj6Jd7Z/k/36HdRSHrJUSqPco3nIPzm6+B4HjFDhaC5b4lDNyHnwQ8NFYa8B9h8k6/meiHsuyLMoWyrIlppxvPnAwhP4WEVQ1IvfgABu9/6BzEFPHTyzmf85rzsPpfcgXGnXc/lm3Jlq9+Uwmfls/zOJSCa9r9KErd1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIJbJdA0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIJbJdA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744946172; x=1776482172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CKh9qggo+rmj99kU0diFTRU9xqoaNX6PAPME7n+az0c=;
  b=bIJbJdA0ITuS237PgRQz2wc5aSAzrZHFmD5TfjR4OtVZDJ9MkFhG7NhV
   8rlYu+0hoNoZIO9TuMEbSSK7mXCn9HJrs+8G71tSfSR2F3kouAbj+hofc
   4e1GQAwGW9XGYCu8nk5oPs5HIkoLaKOGMRXE3tfTDgowV/nWHhSkCgiml
   HEp2cliN/x7vPYEWz+tLgopJJCc+0SzVw1seN7R8AmBUvirXsljLUqwFY
   L2z7wkwPku9vY/0S0BIIeY+1HSIJ63JbLTWv2qKJelp+RzFI0PuDhgfsV
   wyZGWDcdkkOu8i21RBenR4wfZlSj5h6KsE9mtLqkVn3YAhHBLVCD0PsUC
   w==;
X-CSE-ConnectionGUID: EJ+J/5dTQRGvmkOgtJLihg==
X-CSE-MsgGUID: +wVZfMs/Q5io4vom+CcmJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="34188986"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="34188986"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 20:16:11 -0700
X-CSE-ConnectionGUID: PS/j4FJBQY64yaLlFAVSLQ==
X-CSE-MsgGUID: 5DMKj7WpTVuSh09HOH+6hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="130994581"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 17 Apr 2025 20:16:09 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Mingcong Bai <jeffbai@aosc.io>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Apply quirk_iommu_igfx for 8086:0044 (QM57/QS57)
Date: Fri, 18 Apr 2025 11:16:42 +0800
Message-ID: <20250418031642.1810175-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418031642.1810175-1-baolu.lu@linux.intel.com>
References: <20250418031642.1810175-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mingcong Bai <jeffbai@aosc.io>

On the Lenovo ThinkPad X201, when Intel VT-d is enabled in the BIOS, the
kernel boots with errors related to DMAR, the graphical interface appeared
quite choppy, and the system resets erratically within a minute after it
booted:

DMAR: DRHD: handling fault status reg 3
DMAR: [DMA Write NO_PASID] Request device [00:02.0] fault addr 0xb97ff000
[fault reason 0x05] PTE Write access is not set

Upon comparing boot logs with VT-d on/off, I found that the Intel Calpella
quirk (`quirk_calpella_no_shadow_gtt()') correctly applied the igfx IOMMU
disable/quirk correctly:

pci 0000:00:00.0: DMAR: BIOS has allocated no shadow GTT; disabling IOMMU
for graphics

Whereas with VT-d on, it went into the "else" branch, which then
triggered the DMAR handling fault above:

... else if (!disable_igfx_iommu) {
	/* we have to ensure the gfx device is idle before we flush */
	pci_info(dev, "Disabling batched IOTLB flush on Ironlake\n");
	iommu_set_dma_strict();
}

Now, this is not exactly scientific, but moving 0x0044 to quirk_iommu_igfx
seems to have fixed the aforementioned issue. Running a few `git blame'
runs on the function, I have found that the quirk was originally
introduced as a fix specific to ThinkPad X201:

commit 9eecabcb9a92 ("intel-iommu: Abort IOMMU setup for igfx if BIOS gave
no shadow GTT space")

Which was later revised twice to the "else" branch we saw above:

- 2011: commit 6fbcfb3e467a ("intel-iommu: Workaround IOTLB hang on
  Ironlake GPU")
- 2024: commit ba00196ca41c ("iommu/vt-d: Decouple igfx_off from graphic
  identity mapping")

I'm uncertain whether further testings on this particular laptops were
done in 2011 and (honestly I'm not sure) 2024, but I would be happy to do
some distro-specific testing if that's what would be required to verify
this patch.

P.S., I also see IDs 0x0040, 0x0062, and 0x006a listed under the same
`quirk_calpella_no_shadow_gtt()' quirk, but I'm not sure how similar these
chipsets are (if they share the same issue with VT-d or even, indeed, if
this issue is specific to a bug in the Lenovo BIOS). With regards to
0x0062, it seems to be a Centrino wireless card, but not a chipset?

I have also listed a couple (distro and kernel) bug reports below as
references (some of them are from 7-8 years ago!), as they seem to be
similar issue found on different Westmere/Ironlake, Haswell, and Broadwell
hardware setups.

Cc: stable@vger.kernel.org
Fixes: 6fbcfb3e467a ("intel-iommu: Workaround IOTLB hang on Ironlake GPU")
Fixes: ba00196ca41c ("iommu/vt-d: Decouple igfx_off from graphic identity mapping")
Link: https://groups.google.com/g/qubes-users/c/4NP4goUds2c?pli=1
Link: https://bugs.archlinux.org/task/65362
Link: https://bbs.archlinux.org/viewtopic.php?id=230323
Reported-by: Wenhao Sun <weiguangtwk@outlook.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=197029
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
Link: https://lore.kernel.org/r/20250415133330.12528-1-jeffbai@aosc.io
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b29da2d96d0b..64935e14b9ec 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4432,6 +4432,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e30, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e40, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e90, quirk_iommu_igfx);
 
+/* QM57/QS57 integrated gfx malfunctions with dmar */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_iommu_igfx);
+
 /* Broadwell igfx malfunctions with dmar */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1606, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x160B, quirk_iommu_igfx);
@@ -4509,7 +4512,6 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_calpella_no_shadow_gtt);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0062, quirk_calpella_no_shadow_gtt);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x006a, quirk_calpella_no_shadow_gtt);
 
-- 
2.43.0

