Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8402DD60E;
	Sun,  1 Mar 2026 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328841; cv=none; b=IJJQaVNyiYBGRe6oBDWLNXRX63uyG6DEmpAL/QD5dEw+pbv4eFWiVgXZtzUhREC01zq9m2hE2F2R1ZXNRENV0/RtoajrFEal7FRxzdLmst6W7lciRt4DEcc75kzAGtRr1+P/eF+DyMNHXPbdJoWr312ljXDhlW5y49NQPRVD02Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328841; c=relaxed/simple;
	bh=lK2cUDVA/KPZHTP0nCHOFPktFoXz7F5l0IWN5/+fWvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CdLv7cE0uRhI6MI8heR9SshAq+xgpAvz7YwTIGv9YjpwiPpAkfdCgtXzbXi48eEON70yPOwOutI5EnAiImLnBww4s4iPkm68fdE01sqmsB9COM6rOXMZ/GCVoXNtU13m2JN4NXEON1KohuGCWlcgwOblvs0hmNFIP541pbWc3uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZINyhBA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZINyhBA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C978EC19421;
	Sun,  1 Mar 2026 01:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328841;
	bh=lK2cUDVA/KPZHTP0nCHOFPktFoXz7F5l0IWN5/+fWvs=;
	h=From:To:Cc:Subject:Date:From;
	b=mZINyhBAU8Wb4Bjz/0Vv2jwEoPGuzo5oMKzBDHRAnTytPHytCxgv7LgDjMeysOVft
	 u/Vv0utdSIx2FfaDCKqe9cCR8gkkNo0kU0VwKqTaop8+dx7RhE/vKnqtxyvmCPvuOk
	 WH6ude+RU7tiEzj0u13YJDOx9PCpxfZGBa6iK6p/MZN4FkTxKvSKwf9SEYUR19gaYR
	 ONI1KuoW/PEFd/XKDpxkIv3jbaYsj194uaeICI5cffsooP5B5LhQprpcrA7YJDeKmJ
	 azbRPot8oLrSxxOBsKWDHoV+3++QmeV9QuEEpcpdFPzYND8GJAZKMsK0uloLXFLfh3
	 Nq+xV1cQ853MA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	guojinhui.liam@bytedance.com
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	iommu@lists.linux.dev
Subject: FAILED: Patch "iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device without scalable mode" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:33:59 -0500
Message-ID: <20260301013359.1693331-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
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




