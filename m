Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7026FA6F;
	Sun,  1 Mar 2026 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329382; cv=none; b=BKPU5dp8S8qFpB1lyxjFA+XeTYnThbPWjFREad/oqVbuWZxrDUAeHGTn/tBtKMyt0VnQ58VJJ7VFtQoDec+ufzjFn3W5FjDENWHYVFGFJxIlMK+kWaa07XHdFb8kT7ueUA0a+rPIZSr9hYYjOckNbnYkb70+TAChBulfExAAT6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329382; c=relaxed/simple;
	bh=yz1KDReCXChk/d3BtAkAMYPjYynfLbVLMx2pwaENvJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ofGBXYQnLyFWlVx1+weFBKAvDRBmIAwsg3EvUAo6x5dinrToqyg4Ou6i1iGXHAGKxQpnFaCdSMG0cGpi9WPMK+1Yi19F2tIqc4S82glUF9ZpWnkqYEa+wU21mUDU419NzqM0SIYRZ02UGNNPp08zyHa56GHubn+jn0fIJjwoN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnqLATCE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnqLATCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C627CC19421;
	Sun,  1 Mar 2026 01:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329382;
	bh=yz1KDReCXChk/d3BtAkAMYPjYynfLbVLMx2pwaENvJs=;
	h=From:To:Cc:Subject:Date:From;
	b=SnqLATCE0CVVVfKgjyXpLh9KaAu+XVEABhRuVj9w9/60IaE7G/o7bAK98fb10Dh8S
	 2PMS9q9iqayjjGPVF19MwpunWsJ7rw7QPWy0N8zA6uNtJnkMk1TmlBoeSBB944kVBH
	 IZ0tsG8S8MRbULTuFO91w9Xk0dlosKDQMvON3jKg9lKLBAbuoJ7WJa85MWrGMcfOu/
	 lhA6ZUm8oIVnoCieG2lTcs+oOECOoEx0IAGQMNyCRi4dgbLoLH4ud/kzaw5ivFYqKq
	 rFh7Fa0RalQNSktTe9XGkVpSP3myAmkneNpcirQDplbKKwHE9w9j5ua8HDZKBWIin1
	 Ldi98ZlyJFZ1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	guojinhui.liam@bytedance.com
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	iommu@lists.linux.dev
Subject: FAILED: Patch "iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in scalable mode" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:43:00 -0500
Message-ID: <20260301014300.1704977-1-sashal@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 10e60d87813989e20eac1f3eda30b3bae461e7f9 Mon Sep 17 00:00:00 2001
From: Jinhui Guo <guojinhui.liam@bytedance.com>
Date: Thu, 22 Jan 2026 09:48:51 +0800
Subject: [PATCH] iommu/vt-d: Flush dev-IOTLB only when PCIe device is
 accessible in scalable mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 drivers/iommu/intel/pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3f6d78180d799..99692f88b8834 100644
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
2.51.0




