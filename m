Received: from va-2-112.ptr.blmpb.com (va-2-112.ptr.blmpb.com [209.127.231.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D527260F
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765387648; cv=none; b=tM7b1cIk5jQiKHplAGhOAd80c3iOeCSgs5TO8ZkqL5AFy71NmBWEOV830Pt5ulY+K2v4qudpcQzUbbf9Y5nWMTc9mTatgQRI5m3SwunNpQ3wu8AxbDYYSDNpeS/nNL6LBa4IOIsJPl3pn4544SX8Syt7M+j3plHN9BG5mIA4D8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765387648; c=relaxed/simple;
	bh=v5dfAdFg2bZ9A4uKfLuBxR1upNVSd71MOEKUSk0QLx4=;
	h=Cc:Subject:Mime-Version:To:Date:Message-Id:Content-Type:From; b=HK7Fzat0aKlWVnwnwhk6hiF2adGSgtqom57gW01NJHLufxeU0mLQfHzXK9omnyKS1TQvzrWXiWoZNYuDVG4DLuAq7VRAFoBFrd+XPtFEqfEJim4VVV2hRH4M5OcBRNFCnmJG1z9L3E4quyJKBI9n/kiyUSj9iSGqdkO+VH39U7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HTVARP53; arc=none smtp.client-ip=209.127.231.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HTVARP53"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765386917; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=gE/YvSYAf74m9e+7eGIasZfsK/u+D4wUS1SrNjLAz9c=;
 b=HTVARP53Ha0F4UXAA7SPxU5e2eUb/LqZPtzixNpoo8KrvB1XB1MPKNLqbL4L7ydTITAcg+
 TjacMbx/m/j5FFj66j6nMfEieqV3sF384EYZKGsNrpM9M+QYYgAjN0hbESFcnwGTyMGvDF
 K6yMZAPjNa7ipyZNKFMFHxdhFLU0hr6WPwRidPgRB4+Jb9UyaETj0fT8FQRrv6EYKb8dCy
 CgTb1L32GwC0Q0rQ0dAdv0XRhIRMnjaQSZFN7n8eNMpdCXTDq28AASgmyWGLjK1Pfntcw0
 RbKPjEO/mclNwfHRKEQIgZ2QFYGGhz4efQyUKa2tT7H2Ah5VmXBG1XLS0m2cqg==
Cc: <haifeng.zhao@linux.intel.com>, <guojinhui.liam@bytedance.com>, 
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <joro@8bytes.org>, 
	<will@kernel.org>
Date: Thu, 11 Dec 2025 01:14:29 +0800
Message-Id: <20251210171431.1589-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.17.1
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
X-Lms-Return-Path: <lba+26939aaa3+ec406b+lists.linux.dev+guojinhui.liam@bytedance.com>

We hit hard-lockups when the Intel IOMMU waits indefinitely for an ATS invalidation
that cannot complete, especially under GDR high-load conditions.

1. Hard-lock when a passthrough PCIe NIC with ATS enabled link-down in Intel IOMMU
   non-scalable mode. Two scenarios exist: NIC link-down with an explicit link-down
   event and link-down without any event.

   a) NIC link-down with an explicit link-dow event.
      Call Trace:
       qi_submit_sync
       qi_flush_dev_iotlb
       __context_flush_dev_iotlb.part.0
       domain_context_clear_one_cb
       pci_for_each_dma_alias
       device_block_translation
       blocking_domain_attach_dev
       iommu_deinit_device
       __iommu_group_remove_device
       iommu_release_device
       iommu_bus_notifier
       blocking_notifier_call_chain
       bus_notify
       device_del
       pci_remove_bus_device
       pci_stop_and_remove_bus_device
       pciehp_unconfigure_device
       pciehp_disable_slot
       pciehp_handle_presence_or_link_change
       pciehp_ist

   b) NIC link-down without an event - hard-lock on VM destroy.
      Call Trace:
       qi_submit_sync
       qi_flush_dev_iotlb
       __context_flush_dev_iotlb.part.0
       domain_context_clear_one_cb
       pci_for_each_dma_alias
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

2. Hard-lock when a passthrough PCIe NIC with ATS enabled link-down in Intel IOMMU
   scalable mode; NIC link-down without an event hard-locks on VM destroy.
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

Fix both issues with two patches:
1. Skip dev-IOTLB flush for inaccessible devices in __context_flush_dev_iotlb() using
   pci_device_is_present().
2. Use pci_device_is_present() instead of pci_dev_is_disconnected() to decide when to
   skip ATS invalidation in devtlb_invalidation_with_pasid().

Jinhui Guo (2):
  iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device without
    scalable mode
  iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in
    scalable mode

 drivers/iommu/intel/pasid.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.20.1
