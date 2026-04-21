Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5770337DEB4
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776799619; cv=none; b=Y035YlvsgcUsuKrYuELSzAfGGXtJ7t128FAe6mGlItpx4N70/0S038Yvcrd6rAXaepyNwp4nSZqPaLvtHvCHlnkZKpj4xdEGErWJUvmQrckgApM3sD5kOxZIr1XhWofARy79m5ndcNmplwL04KCQGg9JgJG5cSBnXbTDRzCihYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776799619; c=relaxed/simple;
	bh=vfjoOLZRLHrzWh7KAuxNROKCvJcO+e8hunyr5RlAQqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IzF0LxHR+IDgTH/vkE4oWomFos/0lK+gmulpfbY3mt/aVzUxZLWzA0wW7DwXinNzpKRwNT0BV/FLWdp5GDb9o1YvWaw6qgrDnzqXG4XHwkuo1EgWNGp+e1PIw4DQ3Lb9RUIhXb3i4ay+fGml+iZcS+QZbj2eBWoVpIDjOhDawAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JQtQxoid; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JQtQxoid"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776799615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3sJeS58A7kF1kifMPXuvvNzeZ+Rukp0hi1eq+lRanZ8=;
	b=JQtQxoidpVLNT0G+sauoSitoJ3zFwptAdIyH957gu0hFiqm2pd+7P53lmPHmWIcH7m5n+e
	lTPWsRjeZLpF8S8GR+QAinQDMOjsIYrTUQJYVvKXSvRqGVKTDpTzpDEwm1alERGG8e8Xw6
	YMF7wJRcAKnbMshTdBsSD+LuPycfccs=
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Date: Tue, 21 Apr 2026 19:26:13 +0000
Subject: [PATCH] iommu/amd: Bounds-check devid in __rlookup_amd_iommu()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-amd-iommu-rlookup-bounds-v1-1-bbac5f0f48bd@linux.dev>
X-B4-Tracking: v=1; b=H4sIAFXP52kC/yWMSw6CQBAFr0J6bUcYCTFexbiYTwOtzgzpZogJ4
 e6CLuvlVa2gJEwKt2oFoYWVc9qhOVXgR5sGQg47g6lNV7emQRsDco6xoLxzfpUJXS4pKLZkat/
 2/uK6K+z6JNTz55e+P/6sxT3Jz0fveDirhE5s8uMxZeGB0zlanUlg274Qh8D+nAAAAA==
X-Change-ID: 20260421-amd-iommu-rlookup-bounds-4e20c4fc3b68
To: Joerg Roedel <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Ziyuan Chen <zc@anthropic.com>, Josef Bacik <josef@toxicpanda.com>, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
X-Migadu-Flow: FLOW_OUT

iommu_device_register() walks every device on the PCI bus via
bus_for_each_dev() and calls amd_iommu_probe_device() for each. The
inlined check_device() path computes the device's sbdf, calls
rlookup_amd_iommu() to find the owning IOMMU, and only afterwards
verifies devid <= pci_seg->last_bdf. __rlookup_amd_iommu() indexes
rlookup_table[devid] with no bounds check of its own, so for a PCI
device whose BDF is not described by the IVRS, the lookup reads past
the end of the allocation before the caller's bounds check can run.

This was harmless before commit e874c666b15b ("iommu/amd: Change
rlookup, irq_lookup, and alias to use kvalloc()"): the table was a
zeroed page-order allocation, so the over-read returned NULL and the
caller's NULL check skipped the device. After that commit the table is
a tight kvcalloc() and the over-read returns adjacent slab contents,
which check_device() then dereferences as a struct amd_iommu *,
causing a boot-time GPF.

Seen on Google Compute Engine ct6e VMs, where the virtualized IVRS
describes only the four TPU endpoints 00:04.0-07.0; the gVNIC at
00:08.0 (devid 0x40) indexes 56 bytes past the 456-byte allocation,
into the adjacent kmalloc-512 slab object:

  pci 0000:00:04.0: Adding to iommu group 0
  pci 0000:00:05.0: Adding to iommu group 1
  pci 0000:00:06.0: Adding to iommu group 2
  pci 0000:00:07.0: Adding to iommu group 3
  Oops: general protection fault, probably for non-canonical address 0x3a64695f78746382: 0000 [#1] SMP NOPTI
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.22 #1
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/06/2025
  RIP: 0010:amd_iommu_probe_device+0x54/0x3a0
  Call Trace:
   __iommu_probe_device+0x107/0x520
   probe_iommu_group+0x29/0x50
   bus_for_each_dev+0x7e/0xe0
   iommu_device_register+0xc9/0x240
   iommu_go_to_state+0x9c0/0x1c60
   amd_iommu_init+0x14/0x40
   pci_iommu_init+0x16/0x60
   do_one_initcall+0x47/0x2f0

Guard the array access in __rlookup_amd_iommu(). With the fix applied
on 6.18.22, the gVNIC at 00:08.0 is skipped cleanly and the VM boots.

Fixes: e874c666b15b ("iommu/amd: Change rlookup, irq_lookup, and alias to use kvalloc()")
Cc: stable@vger.kernel.org
Reported-by: Ziyuan Chen <zc@anthropic.com>
Tested-by: Ziyuan Chen <zc@anthropic.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Assisted-by: Claude:unspecified
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 drivers/iommu/amd/iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 760d5f4623b55..66dd0b6b98069 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -351,8 +351,12 @@ static struct amd_iommu *__rlookup_amd_iommu(u16 seg, u16 devid)
 	struct amd_iommu_pci_seg *pci_seg;
 
 	for_each_pci_segment(pci_seg) {
-		if (pci_seg->id == seg)
-			return pci_seg->rlookup_table[devid];
+		if (pci_seg->id != seg)
+			continue;
+		/* IVRS may not describe every device on the bus */
+		if (devid > pci_seg->last_bdf)
+			return NULL;
+		return pci_seg->rlookup_table[devid];
 	}
 	return NULL;
 }

---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260421-amd-iommu-rlookup-bounds-4e20c4fc3b68

Best regards,
--  
Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

