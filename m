Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8EB34DCD7
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 01:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046690; cv=none; b=dVSZw18UW95/VaP1eMWxbdPnVA6f8oEssIahMrIEZmbtCY2BIbzf/ziRkEzrw5/Hf6KsvAHQrN5YvFEUjIVh9oCAsZtI6DHb4F20DCZEx41+ykKyh9ix4zKGZlTmmETrH8T0mDalcFdT+SsCRog6nocb4bCR4oTadkyXa5T5mXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046690; c=relaxed/simple;
	bh=o8WhUb2cIgqs47EaaOIo01hqCpRDU6Atj+vOy0GL3BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Typ6lkTjPEMJ3C+WDIdbjs0AKcU0jo/bAzi6DMWMSB5oteH7ZrEDRyXgYKcmm2GMGEn5ohcFUTl0dUaTn/Klds6HGRfw/hp/ogcfcY+jXaeBdrZeLXRUpKFQV9PlixIABI/l71xangBQVh3uU/QMp4tUF8W8aoEcNrWjsNKd+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NnXQOqAo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NnXQOqAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769046688; x=1800582688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o8WhUb2cIgqs47EaaOIo01hqCpRDU6Atj+vOy0GL3BM=;
  b=NnXQOqAoWw7oRkUtU7MS14dDpxvLWhvl3JCtQBQje920hLSjYxUiRYZD
   yHSmWHfOmTEX/AOpB2eQwLwEx/K/UzC88zuHUtoSkK6FTq76p1kJctvZJ
   1DApRiwTN5EA7fodAp71fOB6ypSsu9KkzIrDaHsYcp4gX5zdovPz7I8Zo
   /tASuO+LB5WpBHowskEQLED7kI/3e70hOfR2NHvmbtBsVqYUiICj04BKk
   dkWHlzkVdTeGRHsdqLXyK5VLCxvTkXqC6YURb/Wu4+ip4krZ/zLbFwrh2
   iZSmBFgUNwaKlC3bfduFiBeR4QwiQom/vAaZm79IkrcSi2S7QeMmfv3KY
   w==;
X-CSE-ConnectionGUID: 2WrBLXa5ThiXPl9FXlVGGw==
X-CSE-MsgGUID: N/Vu4H/zTe2dgrK13R/f1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81393042"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="81393042"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 17:51:28 -0800
X-CSE-ConnectionGUID: QNETBFCOTPqqEIAqbWZd6g==
X-CSE-MsgGUID: WrbwaRmkSUKKv3lTrwu7vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="211455628"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa004.fm.intel.com with ESMTP; 21 Jan 2026 17:51:26 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Jinhui Guo <guojinhui.liam@bytedance.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in scalable mode
Date: Thu, 22 Jan 2026 09:48:51 +0800
Message-ID: <20260122014856.2457052-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122014856.2457052-1-baolu.lu@linux.intel.com>
References: <20260122014856.2457052-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jinhui Guo <guojinhui.liam@bytedance.com>

Commit 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation
request when device is disconnected") relies on
pci_dev_is_disconnected() to skip ATS invalidation for
safely-removed devices, but it does not cover link-down caused
by faults, which can still hard-lock the system.

For example, if a VM fails to connect to the PCIe device,
"virsh destroy" is executed to release resources and isolate
the fault, but a hard-lockup occurs while releasing the group fd.

Call Trace:
 qi_submit_sync
 qi_flush_dev_iotlb
 intel_pasid_tear_down_entry
 device_block_translation
 blocking_domain_attach_dev
 __iommu_attach_device
 __iommu_device_set_domain
 __iommu_group_set_domain_internal
 iommu_detach_group
 vfio_iommu_type1_detach_group
 vfio_group_detach_container
 vfio_group_fops_release
 __fput

Although pci_device_is_present() is slower than
pci_dev_is_disconnected(), it still takes only ~70 µs on a
ConnectX-5 (8 GT/s, x2) and becomes even faster as PCIe speed
and width increase.

Besides, devtlb_invalidation_with_pasid() is called only in the
paths below, which are far less frequent than memory map/unmap.

1. mm-struct release
2. {attach,release}_dev
3. set/remove PASID
4. dirty-tracking setup

The gain in system stability far outweighs the negligible cost
of using pci_device_is_present() instead of pci_dev_is_disconnected()
to decide when to skip ATS invalidation, especially under GDR
high-load conditions.

Fixes: 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation request when device is disconnected")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
Link: https://lore.kernel.org/r/20251211035946.2071-3-guojinhui.liam@bytedance.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3f6d78180d79..99692f88b883 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -218,7 +218,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	if (!info || !info->ats_enabled)
 		return;
 
-	if (pci_dev_is_disconnected(to_pci_dev(dev)))
+	if (!pci_device_is_present(to_pci_dev(dev)))
 		return;
 
 	sid = PCI_DEVID(info->bus, info->devfn);
-- 
2.43.0

