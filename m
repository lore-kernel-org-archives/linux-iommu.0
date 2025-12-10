Received: from sg-1-103.ptr.blmpb.com (sg-1-103.ptr.blmpb.com [118.26.132.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36A03C465
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765386958; cv=none; b=YWAGfHiQR2KDX7Qehe2yTDMZ6mssWTJwzZUxZg3nYFnwP/FoUQJwtesOT7qcaJgS550iTULxECePulGlFMMFk8KWH4v2v9OYzgK/EEAMtjrrRXwYBElEeKBz9zwPj1A2jVlMdGIn8TCiM1/uoSPjckJu5n4146fUlYMReKJyhTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765386958; c=relaxed/simple;
	bh=JVpDEvrxrbWtEEQEuEUIisGJXq7Gm+HsqEypdIIT4Pk=;
	h=From:Date:Content-Type:References:Message-Id:Mime-Version:
	 In-Reply-To:To:Cc:Subject; b=a6mpcTWBRiKtovtRoKoKxlWNRes4ehtsJuXpikIHBf3gakUkGs/bHhULkr6kqkkAnGLkrCkr93SuvR9nJOHmYOWbyaLJfFnvXBlv3huvneG1PWokOljPXA9gJptbV+uXpWVmL5GDJshXY8TRvWzvZB14VjoN75ZeNbhgRRIdAN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XCJxho4V; arc=none smtp.client-ip=118.26.132.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XCJxho4V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765386942; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=CShaiNcFwFgIz00yFpNyGPher1OgtGoU+XBK8EUepuY=;
 b=XCJxho4V0+aLWwV1VH0yP5EEuGe3YWn8U1f3rLxw10DPYBPvGrbcre3skRHV5nd8T5jsC9
 XE73DysNn9rArFMLR+j5QCd4Wm9vtzxUsOSUIwyqX9nH0YnTHwbvvZFJ3bxP0fa2pu+VgT
 LIRaQhloXgm7y7KeuH9+rBp2vQ57+Ir2zwb3SauRfMRPLVODmxabum9Ca7j5FYbxFKXByN
 aN/M1GzrMUllVwpkdIRT84U6YEmY3dnLHWF6cvr6aXORKNvdBo0glPxTigdzsWMD6btRMj
 k3T0lla1OF2o5FYjvvQN0I1QheOrq2iokm/3fJdm0RMKileuloYbYyPC/XzswA==
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Date: Thu, 11 Dec 2025 01:14:31 +0800
Content-Type: text/plain; charset=UTF-8
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
References: <20251210171431.1589-1-guojinhui.liam@bytedance.com>
Message-Id: <20251210171431.1589-3-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
In-Reply-To: <20251210171431.1589-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <joro@8bytes.org>, 
	<will@kernel.org>
Cc: <haifeng.zhao@linux.intel.com>, <guojinhui.liam@bytedance.com>, 
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in scalable mode
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+26939aabc+cbe56a+lists.linux.dev+guojinhui.liam@bytedance.com>

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
pci_dev_is_disconnected(), it still takes only ~70 =C2=B5s on a
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

Fixes: 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation request when=
 device is disconnected")
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/iommu/intel/pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index b1e8eb6a6504..e9dea47decdb 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -218,7 +218,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iomm=
u,
 	if (!info || !info->ats_enabled)
 		return;
=20
-	if (pci_dev_is_disconnected(to_pci_dev(dev)))
+	if (!pci_device_is_present(to_pci_dev(dev)))
 		return;
=20
 	sid =3D PCI_DEVID(info->bus, info->devfn);
--=20
2.20.1
