Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0249E2114
	for <iommu@lists.linux.dev>; Wed, 27 Dec 2023 03:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PsRUkh1+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703646069; x=1735182069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WG21CSSwsE/85hwPEnEufidCuVnAVIKF6sagH3cxk1U=;
  b=PsRUkh1+pk3uEIVTR+r2le7Tl5KFpQq/h10MdB6Y6WdqB4thqy2qZG0j
   BLFsp73nPFwBTlQBNpE/yWDxTZMC+oVJdZJmujBdcYOCNGz1xs4K2SNsP
   efSrfOj0Tj9+i17SSuUKnY/zP91+0mVo7s8+ImfqKahzTKLDHYkHxmX1H
   SGw3wxZM7Jc0Lapm57ZuzRaoBZwfrN4uFxp8FJ1mglzURU5C+EEwxfmZ1
   +fgmMnsli8+fKy1fIFgQvOMiPA4ThARTK9oBXrk5mD0Tfkx8Ai6TGseOR
   kYUbrJMWXCo4emYEp7WNx2daOL8HilQ+3r+YilfZEhwSaJkpHS9qagw3O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="3705806"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="3705806"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 18:59:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="951386099"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="951386099"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by orsmga005.jf.intel.com with ESMTP; 26 Dec 2023 18:59:37 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: bhelgaas@google.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	robin.murphy@arm.com,
	lukas@wunner.de
Cc: linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v8 4/5] iommu/vt-d: don't issue device-TLB invalidate request when device is disconnected
Date: Tue, 26 Dec 2023 21:59:22 -0500
Message-Id: <20231227025923.536148-5-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231227025923.536148-1-haifeng.zhao@linux.intel.com>
References: <20231227025923.536148-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Except those aggressive hotplug cases - surprise remove a hotplug device
while its safe removal is requested and handled in process by:

1. pull it out directly.
2. turn off its power.
3. bring the link down.
4. just died there that moment.

etc, in a word, 'gone' or 'disconnected'.

Mostly are regular normal safe removal and surprise removal unplug.
these hot unplug handling process could be optimized for fix the ATS
invalidation hang issue by calling pci_dev_is_disconnected() in function
devtlb_invalidation_with_pasid() to check target device state to avoid
sending meaningless ATS invalidation request to iommu when device is gone.
(see IMPLEMENTATION NOTE in PCIe spec r6.1 section 10.3.1)

For safe removal, device wouldn't be removed untill the whole software
handling process is done, it wouldn't trigger the hard lock up issue
caused by too long ATS invalidation timeout wait. in safe removal path,
device state isn't set to pci_channel_io_perm_failure in
pciehp_unconfigure_device() by checking 'presence' parameter, calling
pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will return
false there, wouldn't break the function.

For surprise removal, device state is set to pci_channel_io_perm_failure in
pciehp_unconfigure_device(), means device is already gone (disconnected)
call pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will
return true to break the function not to send ATS invalidation request to
the disconnected device blindly, thus avoid the further long time waiting
triggers the hard lockup.

safe removal & surprise removal

pciehp_ist()
   pciehp_handle_presence_or_link_change()
     pciehp_disable_slot()
       remove_board()
         pciehp_unconfigure_device(presence)

Tested-by: Haorong Ye <yehaorong@bytedance.com>
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 1c87fb1b1039..a08bdbec90eb 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -481,6 +481,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	if (!info || !info->ats_enabled)
 		return;
 
+	if (pci_dev_is_disconnected(to_pci_dev(dev)))
+		return;
+
 	sid = info->bus << 8 | info->devfn;
 	qdep = info->ats_qdep;
 	pfsid = info->pfsid;
-- 
2.31.1

