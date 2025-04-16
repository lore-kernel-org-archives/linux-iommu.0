Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF40161310
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788943; cv=none; b=BlT64JqNCPpakgo+nzxeh/epdQgx/6BFKNIHVnCvWmjDtNWud/0fogl7sOPBlK0/k5XvNigcVjPE2bd8iCCQ9Y5iZ9Twmyaf9R3elvdAPj/2sN3wmALSj2jFRG7b8+PFJ3aID+zg6BKVetEYLDFJG7VSk2XcyGW8tJ3DUfBUc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788943; c=relaxed/simple;
	bh=+H9GX5y26Nfo2MH/KkOqaPDNpwN4wm07XI8ZoMfksT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p43m7vUJo6WlF2HmjMpRNi0v9WZYSNbNL2u8BXZFiWDHAQwFy+erFJk1dWYQZIGpKLywYkZsJskRhMl3L40k0XW9cX/Fdj2dh0gfT5fkC9JMj87EvMawD+52YTjt0eF0XOOIdV6Zk2FJHEca4+cqA6Mq+5Hv6L4IxM0mjRyEWrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DB+VRTiy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DB+VRTiy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744788942; x=1776324942;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+H9GX5y26Nfo2MH/KkOqaPDNpwN4wm07XI8ZoMfksT0=;
  b=DB+VRTiy+b20NSMQL2Kki1IVvRzy3O+uWflTgbG2j9mlFZD8/z2kj2TZ
   4K3IjKfFrQIoGgvycZ0fYGkj5GyAQRr9vMrSAByKBK2I8a2aok9Fy3qVb
   8z0082i/Qa+KUzRfg1L6B+yq6/FhnlHmoVhxgqzUjrh6YttgUIJTOm/Z4
   s0MPws0tFAGFq3n9kFJwHmdeDP3nNLm0QGW6rs/gn0TEe0gCdkNVMjpSU
   cHrIfNP4uJjplKrXE/T6CU73nceHQCAY6F9MbxbZaV/9ianv6lY0uycou
   khhwuUeJVx7jA3/vWTBjHN34h+1v7TwZJ9Fvuth0G7inINBwZWjeetcLf
   g==;
X-CSE-ConnectionGUID: 0Gy7KsuaRLahGiObY3miHw==
X-CSE-MsgGUID: DajL28RGQ6qfmzdjBDYYSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="56958603"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="56958603"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:35:41 -0700
X-CSE-ConnectionGUID: C8PDJANBTxKKjBGNJq+46g==
X-CSE-MsgGUID: hdf1rhpcSiazkD8+FhZLIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="135205715"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 16 Apr 2025 00:35:39 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Revert ATS timing change to fix boot failure
Date: Wed, 16 Apr 2025 15:36:08 +0800
Message-ID: <20250416073608.1799578-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit <5518f239aff1> ("iommu/vt-d: Move scalable mode ATS enablement to
probe path") changed the PCI ATS enablement logic to run earlier,
specifically before the default domain attachment.

On some client platforms, this change resulted in boot failures, causing
the kernel to panic with the following message and call trace:

 Kernel panic - not syncing: DMAR hardware is malfunctioning
 CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3+ #175
 Call Trace:
  <TASK>
  dump_stack_lvl+0x6f/0xb0
  dump_stack+0x10/0x16
  panic+0x10a/0x2b7
  iommu_enable_translation.cold+0xc/0xc
  intel_iommu_init+0xe39/0xec0
  ? trace_hardirqs_on+0x1e/0xd0
  ? __pfx_pci_iommu_init+0x10/0x10
  pci_iommu_init+0xd/0x40
  do_one_initcall+0x5b/0x390
  kernel_init_freeable+0x26d/0x2b0
  ? __pfx_kernel_init+0x10/0x10
  kernel_init+0x15/0x120
  ret_from_fork+0x35/0x60
  ? __pfx_kernel_init+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
 RIP: 1f0f:0x0
 Code: Unable to access opcode bytes at 0xffffffffffffffd6.
 RSP: 0000:0000000000000000 EFLAGS: 841f0f2e66 ORIG_RAX:
      1f0f2e6600000000
 RAX: 0000000000000000 RBX: 1f0f2e6600000000 RCX:
      2e66000000000084
 RDX: 0000000000841f0f RSI: 000000841f0f2e66 RDI:
      00841f0f2e660000
 RBP: 00841f0f2e660000 R08: 00841f0f2e660000 R09:
      000000841f0f2e66
 R10: 0000000000841f0f R11: 2e66000000000084 R12:
      000000841f0f2e66
 R13: 0000000000841f0f R14: 2e66000000000084 R15:
      1f0f2e6600000000
  </TASK>
 ---[ end Kernel panic - not syncing: DMAR hardware is malfunctioning ]---

Fix this by reverting the timing change for ATS enablement introduced by
the offending commit and restoring the previous behavior.

Fixes: 5518f239aff1 ("iommu/vt-d: Move scalable mode ATS enablement to probe path")
Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Closes: https://lore.kernel.org/linux-iommu/01b9c72f-460d-4f77-b696-54c6825babc9@linux.intel.com/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b29da2d96d0b..e60b699e7b8c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3785,6 +3785,22 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	intel_iommu_debugfs_create_dev(info);
 
+	return &iommu->iommu;
+free_table:
+	intel_pasid_free_table(dev);
+clear_rbtree:
+	device_rbtree_remove(info);
+free:
+	kfree(info);
+
+	return ERR_PTR(ret);
+}
+
+static void intel_iommu_probe_finalize(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
 	/*
 	 * The PCIe spec, in its wisdom, declares that the behaviour of the
 	 * device is undefined if you enable PASID support after ATS support.
@@ -3792,22 +3808,12 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	 * we can't yet know if we're ever going to use it.
 	 */
 	if (info->pasid_supported &&
-	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
+	    !pci_enable_pasid(to_pci_dev(dev), info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
-	if (sm_supported(iommu))
+	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev))
 		iommu_enable_pci_ats(info);
 	iommu_enable_pci_pri(info);
-
-	return &iommu->iommu;
-free_table:
-	intel_pasid_free_table(dev);
-clear_rbtree:
-	device_rbtree_remove(info);
-free:
-	kfree(info);
-
-	return ERR_PTR(ret);
 }
 
 static void intel_iommu_release_device(struct device *dev)
@@ -4391,6 +4397,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_alloc_sva	= intel_svm_domain_alloc,
 	.domain_alloc_nested	= intel_iommu_domain_alloc_nested,
 	.probe_device		= intel_iommu_probe_device,
+	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.device_group		= intel_iommu_device_group,
-- 
2.43.0

