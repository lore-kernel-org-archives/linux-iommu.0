Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81323B61B
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776741242; cv=none; b=lbriCZesXf9VGOaoSgAS+jTPxM+2ReU0lHHADj4J66I2wclG/vaB7wvpZsjyoF4LYZvkXf4bg5UOXMQDsFKRqpp3FUhP2Poeet9SFE2T5eJV2GZ3NfamAQGcfRlzyhmwYA/+WlLIjjhk/t2Pw30cBvs7YKnbe5vUntuG6kCZ3nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776741242; c=relaxed/simple;
	bh=AO7OUSIeGh+bUJgfFEqZZCgGEDGjrmomo5Rbqsn4B2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VB8xri+qlUXkMQStWox1CESc2FWi1oNd7i8ESdkql9bWEBQcX2KYA9obkyx2XgbdTqpLO6dLtJw6LKFTOIadYPTzngcrbNydA3FI2xL8Yfm2KbnanA7/ga5IAibPbLe8XGMpGCtRQBskgXzPFFB49PUrWJpfKWxzrfQNRTOC1LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaZXufLF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaZXufLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776741240; x=1808277240;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AO7OUSIeGh+bUJgfFEqZZCgGEDGjrmomo5Rbqsn4B2s=;
  b=CaZXufLFWcIIthoh7RrZ4Oa4bop22ZyfUL0vRwhqCg04ASO0FFd6vynZ
   NYXtzjTx2en+GvNMEOHwRl7sA5ZkjrRF0OzkYFkHDDwHXVKBH8jgo+0FH
   /tgNDNSWTMmx6Xu6q+UbfNzh/TPr6dpUNJgAYXAKPxmCZzx2KqO7b82qb
   dIxaG2C+pApvjDsk/pccGkCkPF04ZTxwh3gkt2vTOao4wuui0RPN3/lFn
   IhGXr3YHcv1Npbr1nb+2607kB79YugRiNChXTvkhWBH9ODS6t07Nx9AfY
   To5TNqG67y6clf8o5HHFkk3ivMQDxXdqMbms8JaOKO5nAFxEdM+TUHLBQ
   A==;
X-CSE-ConnectionGUID: 2BaKktLxRFmAhrmSH1n2pw==
X-CSE-MsgGUID: 1/37CPTmSKClA0zQCMIIIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88365691"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="88365691"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 20:14:00 -0700
X-CSE-ConnectionGUID: eoqWj4EOSNe2bmFa6U+e7g==
X-CSE-MsgGUID: 5uDfAP29SSCZV93RHGKK5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="230863062"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 20:13:56 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	kevin.tian@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/vt-d: Fix oops due to out of scope access
Date: Mon, 20 Apr 2026 23:13:47 -0400
Message-ID: <20260421031347.1408890-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c3d18cd77d2f..52aa12dbeea1 100644
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
2.47.3

