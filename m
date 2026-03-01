Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D8819F12D;
	Sun,  1 Mar 2026 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327820; cv=none; b=nqpqFFxw+A0MAJYstlhZzDvJFV6NRQmayLFOHadMmL78Kog0xCDzYV0VvcGBEQ/6GFj3U8eTIKbqTBtRtBmJgn7tN2moEYYWNTQwJxpYOAifHxqaPOkNX5l9WY0YeNaua/lONdQhASRB++eMQjsE/lSXIa1D+tQiaxWRLdqWXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327820; c=relaxed/simple;
	bh=X8RQuP12V/n1zRfV2jB/Xn5y4j18/PIJym8g2alYwrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TP9TKmie3Ajc7TGIg+FeJr9p248O+WFATuEih5OrWSPBLeRX3zq7n4JajKZuu92TDAq5dYiAxxvW2KdvG/Z8CWPgNlD93ovG+8ZN5nPhGgAMKLWD42jY2XZBwnah+KCy+oERWIqqae7lYVN0xW6zJ2jQfSGMl61dSObjqPOpWMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzqnSpfn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzqnSpfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9837C19421;
	Sun,  1 Mar 2026 01:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327820;
	bh=X8RQuP12V/n1zRfV2jB/Xn5y4j18/PIJym8g2alYwrw=;
	h=From:To:Cc:Subject:Date:From;
	b=pzqnSpfnBCmQakH1sFqRsjTT2XnIRnh1Wy4fEEDY+otkP4YRSuodQdi729K4PvbM3
	 qdhlrETNEaMDWxbgpnr8fJ/WaZ/j8lXrtL88iU+PqwVTXdQEWG6b3BV+3C2M5kJXat
	 GhxBo3xGzcbCp32jYe/LwMQqP6HwqxoVZXiuwAC/c//EaVYLMF7SeV7W2TrTw9Dg9P
	 m2rgHNzkvfG0OMJQEWjeRc0rqqsHrASoMBZIzeOZd5M/yhgCYL5hJLG6CWIlXQDSu5
	 X13y8bWoEuI5gQ7QpNy6eWL8uF+bXyw7EbHM6uv9XBXUHDY54/FmCd1nq6Wht/BEo5
	 Km9Mqjp0KEG5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	guojinhui.liam@bytedance.com
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	iommu@lists.linux.dev
Subject: FAILED: Patch "iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device without scalable mode" failed to apply to 6.18-stable tree
Date: Sat, 28 Feb 2026 20:15:47 -0500
Message-ID: <20260301011658.1669544-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 42662d19839f34735b718129ea200e3734b07e50 Mon Sep 17 00:00:00 2001
From: Jinhui Guo <guojinhui.liam@bytedance.com>
Date: Thu, 22 Jan 2026 09:48:50 +0800
Subject: [PATCH] iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device
 without scalable mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCIe endpoints with ATS enabled and passed through to userspace
(e.g., QEMU, DPDK) can hard-lock the host when their link drops,
either by surprise removal or by a link fault.

Commit 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation
request when device is disconnected") adds pci_dev_is_disconnected()
to devtlb_invalidation_with_pasid() so ATS invalidation is skipped
only when the device is being safely removed, but it applies only
when Intel IOMMU scalable mode is enabled.

With scalable mode disabled or unsupported, a system hard-lock
occurs when a PCIe endpoint's link drops because the Intel IOMMU
waits indefinitely for an ATS invalidation that cannot complete.

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

Commit 81e921fd3216 ("iommu/vt-d: Fix NULL domain on device release")
adds intel_pasid_teardown_sm_context() to intel_iommu_release_device(),
which calls qi_flush_dev_iotlb() and can also hard-lock the system
when a PCIe endpoint's link drops.

Call Trace:
 qi_submit_sync
 qi_flush_dev_iotlb
 __context_flush_dev_iotlb.part.0
 intel_context_flush_no_pasid
 device_pasid_table_teardown
 pci_pasid_table_teardown
 pci_for_each_dma_alias
 intel_pasid_teardown_sm_context
 intel_iommu_release_device
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

Sometimes the endpoint loses connection without a link-down event
(e.g., due to a link fault); killing the process (virsh destroy)
then hard-locks the host.

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

pci_dev_is_disconnected() only covers safe-removal paths;
pci_device_is_present() tests accessibility by reading
vendor/device IDs and internally calls pci_dev_is_disconnected().
On a ConnectX-5 (8 GT/s, x2) this costs ~70 µs.

Since __context_flush_dev_iotlb() is only called on
{attach,release}_dev paths (not hot), add pci_device_is_present()
there to skip inaccessible devices and avoid the hard-lock.

Fixes: 37764b952e1b ("iommu/vt-d: Global devTLB flush when present context entry changed")
Fixes: 81e921fd3216 ("iommu/vt-d: Fix NULL domain on device release")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
Link: https://lore.kernel.org/r/20251211035946.2071-2-guojinhui.liam@bytedance.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 drivers/iommu/intel/pasid.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3e2255057079c..3f6d78180d799 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -1102,6 +1102,14 @@ static void __context_flush_dev_iotlb(struct device_domain_info *info)
 	if (!info->ats_enabled)
 		return;
 
+	/*
+	 * Skip dev-IOTLB flush for inaccessible PCIe devices to prevent the
+	 * Intel IOMMU from waiting indefinitely for an ATS invalidation that
+	 * cannot complete.
+	 */
+	if (!pci_device_is_present(to_pci_dev(info->dev)))
+		return;
+
 	qi_flush_dev_iotlb(info->iommu, PCI_DEVID(info->bus, info->devfn),
 			   info->pfsid, info->ats_qdep, 0, MAX_AGAW_PFN_WIDTH);
 
-- 
2.51.0




