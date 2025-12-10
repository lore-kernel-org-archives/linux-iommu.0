Received: from sg-1-101.ptr.blmpb.com (sg-1-101.ptr.blmpb.com [118.26.132.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FF323F424
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765387057; cv=none; b=ohgO2PsPgk+xXYwROQ8ib556ARTQjvk+hyxAm+MESqPa1sIq80KfUBqWuyAr6ICBWXXelB15gb6Ki1lLKQBYbobhQkcNcCdx6SFbM4WbBPtGtRZgIC2h2LbuoRAnhekucao0Dj3HZwHyqWpNJG5evwc0mBDIraFFcvGkYgNSB2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765387057; c=relaxed/simple;
	bh=fiAIMgiAauXV8AxhAqdIBNZ9/EkluTuz2VvwONvmCQ8=;
	h=Message-Id:References:In-Reply-To:From:Content-Type:Mime-Version:
	 Cc:To:Date:Subject; b=r+/HH+oPY8de2IPnXTfoPBk+D40LHhGY3uSra/Pzh4WbiLcJd7T70fuH5RLMk1zNEVXCraoPwqQegCXPFGwJgXLshqiRrqKF+n9cHFYYCQc7RRQ4DnLrmJ23UoVGrH+PotXSL1zS1f5Ie7zmmN0q+YTWgyAXdVikzmwtvmvcL70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=chHWsLq3; arc=none smtp.client-ip=118.26.132.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="chHWsLq3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765386929; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=AvqYlMPn7JWDEi0g2ZUmP/c7en8JLBZ1SfcbG3kZXjw=;
 b=chHWsLq3sLlY/TGALr3qtwXl48NZUP0CHAPXWU/BlgYKSAZRKxO7UUVpqh2dnVoRZin/HR
 KoaHvo08f/5TnB38VoKPjrfZzenM0qq2lcd31MLB3qkSgu+BkYkUNiiVv+NnXifgBiX0Xe
 gVjAxj/LqoXK8hfzplC4Jk2u2rQj+bTvPtatdpUXphwVeZMmUraNOiHXlnyiu0A+fcP19C
 gjKxH+Z1erKx0pEHCzzqcZ8U089CgCcEwVgAuaUP3CzScONEfHNP6dTaIK40Qb8msyPu3N
 zNjquM+zihB7JWbsKfaWO4cMPqXjMujaymNTFGH2Hdz/3SD6j/gEgxA/eyU1Ow==
Message-Id: <20251210171431.1589-2-guojinhui.liam@bytedance.com>
References: <20251210171431.1589-1-guojinhui.liam@bytedance.com>
In-Reply-To: <20251210171431.1589-1-guojinhui.liam@bytedance.com>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26939aaaf+0d3643+lists.linux.dev+guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Cc: <haifeng.zhao@linux.intel.com>, <guojinhui.liam@bytedance.com>, 
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
X-Mailer: git-send-email 2.17.1
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <joro@8bytes.org>, 
	<will@kernel.org>
Date: Thu, 11 Dec 2025 01:14:30 +0800
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH 1/2] iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device without scalable mode

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
On a ConnectX-5 (8 GT/s, x2) this costs ~70 =C2=B5s.

Since __context_flush_dev_iotlb() is only called on
{attach,release}_dev paths (not hot), add pci_device_is_present()
there to skip inaccessible devices and avoid the hard-lock.

Fixes: 37764b952e1b ("iommu/vt-d: Global devTLB flush when present context =
entry changed")
Fixes: 81e921fd3216 ("iommu/vt-d: Fix NULL domain on device release")
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/iommu/intel/pasid.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3e2255057079..b1e8eb6a6504 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -1099,9 +1099,20 @@ int intel_pasid_setup_sm_context(struct device *dev)
  */
 static void __context_flush_dev_iotlb(struct device_domain_info *info)
 {
+	struct pci_dev *pdev;
+
 	if (!info->ats_enabled)
 		return;
=20
+	/*
+	 * Skip dev-IOTLB flush for inaccessible PCIe devices to prevent the
+	 * Intel IOMMU from waiting indefinitely for an ATS invalidation that
+	 * cannot complete.
+	 */
+	pdev =3D dev_is_pci(info->dev) ? to_pci_dev(info->dev) : NULL;
+	if (pdev && !pci_device_is_present(pdev))
+		return;
+
 	qi_flush_dev_iotlb(info->iommu, PCI_DEVID(info->bus, info->devfn),
 			   info->pfsid, info->ats_qdep, 0, MAX_AGAW_PFN_WIDTH);
=20
--=20
2.20.1
