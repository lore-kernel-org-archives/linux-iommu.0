Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8B374187
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 02:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778294779; cv=none; b=l6AxYOAOpLCmr0ibIbQUOzn0IBazcn45osr9EGNFjLVpvS6B5nJDkVdhpgLwiXo94Tm7rrOJMjPvE3Es2VvBHMxoLz0JccpS0ka29RtMXLTR/Ok+pWIGHcemVdUBbuh6GEobtrKGlyg1RrvcK662LHs9bY1C8l3iPUu4EOMgkgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778294779; c=relaxed/simple;
	bh=1CHe541rwMR755+XYhpWBe67FbEViElGc6eo0PqtuIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okvPOvQsJty3bEp9MIuSvJOigHiaUsOVKkn37HKnz7MirdiRLNVYk4ryMHMoY8W1HLLVcJGw55Mj0noHjNJ9lCrWSXL9vwdPF9Js8RveZobQmCt1b0N6Zxq37LEplNlqaC1LfsZHJ1LnIRqtYWkJM7UCNFmdYGMMnCegBrG8AvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5SKEJP7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5SKEJP7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778294779; x=1809830779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1CHe541rwMR755+XYhpWBe67FbEViElGc6eo0PqtuIs=;
  b=A5SKEJP7KzD3QHG0qZ0eq6rFWT8yvhl2VxM4sNb+QaMdr8VsjTslp+aG
   MDUKb/zDjucivt17QDyaXmzY+PLDlXSRNYDJFHo2kV9EaeuoEDXXu+E6O
   LQBnGDUY1ny7rOyqXHMgiZbLybJqV+eM+mGHXa51TgQZwRzgETOYODH5k
   qrM7aIZUAUcOKvWw2OMR7V5Xt++HfhKnPYrS2Chdl5rJITyXugco2nTbF
   X7bDLn3bjLC47l0PjvnDtXlFUzPV78+bNQr4kQIVvN7kK6eyHgAfBW9Bt
   j4YZPPqm/EY1ecat1CfWFe3d2MDsp8G/9zdL31tezT0WFAwZfLKUOeENW
   Q==;
X-CSE-ConnectionGUID: JmWjgwCDS+2E7Jn5V/qVTw==
X-CSE-MsgGUID: NlXAVk2+Qe+QI2z9iCm5rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="83142513"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="83142513"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 19:46:18 -0700
X-CSE-ConnectionGUID: trXECWAXT0egADMzpnLivA==
X-CSE-MsgGUID: PCzU8mnQRWuoKNNKnOWH0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="236103472"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa010.jf.intel.com with ESMTP; 08 May 2026 19:46:17 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
	=?UTF-8?q?Naval=20Alcal=C3=A1?= <ari@naval.cat>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iommu/vt-d: Fix oops due to out of scope access
Date: Sat,  9 May 2026 10:43:45 +0800
Message-ID: <20260509024348.3516523-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509024348.3516523-1-baolu.lu@linux.intel.com>
References: <20260509024348.3516523-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Below oops triggers when kill QEMU process:

  Oops: general protection fault, probably for non-canonical address 0x7fffffff844eaaa7: 0000 [#1] SMP NOPTI
  Call Trace:
   <TASK>
   do_raw_spin_lock+0xaa/0xc0
   _raw_spin_lock_irqsave+0x21/0x40
   domain_remove_dev_pasid+0x52/0x160
   intel_nested_set_dev_pasid+0x1b9/0x1e0
   __iommu_set_group_pasid+0x56/0x120
   pci_dev_reset_iommu_done+0xe3/0x180
   pcie_flr+0x65/0x160
   __pci_reset_function_locked+0x5b/0x120
   vfio_pci_core_close_device+0x63/0xe0 [vfio_pci_core]
   vfio_df_close+0x4f/0xa0
   vfio_df_unbind_iommufd+0x2d/0x60
   vfio_device_fops_release+0x3e/0x40
   __fput+0xe5/0x2c0
   task_work_run+0x58/0xa0
   do_exit+0x2c8/0x600
   do_group_exit+0x2f/0xa0
   get_signal+0x863/0x8c0
   arch_do_signal_or_restart+0x24/0x100
   exit_to_user_mode_loop+0x87/0x380
   do_syscall_64+0x2ff/0x11e0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

The global static blocked domain is a dummy domain without corresponding
dmar_domain structure, accessing beyond iommu_domain structure triggers
oops easily. Fix it by return early in domain_remove_dev_pasid() like
identity domain.

Fixes: 7d0c9da6c150 ("iommu/vt-d: Add set_dev_pasid callback for dma domain")
Cc: stable@vger.kernel.org
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260421031347.1408890-1-zhenzhong.duan@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2a6b6813a78d..a4b123c33022 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3530,8 +3530,8 @@ void domain_remove_dev_pasid(struct iommu_domain *domain,
 	if (!domain)
 		return;
 
-	/* Identity domain has no meta data for pasid. */
-	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+	/* Identity domain and blocked domain have no meta data for pasid. */
+	if (domain->type == IOMMU_DOMAIN_IDENTITY || domain->type == IOMMU_DOMAIN_BLOCKED)
 		return;
 
 	dmar_domain = to_dmar_domain(domain);
-- 
2.43.0

