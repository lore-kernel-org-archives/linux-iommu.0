Received: from enforcer.machelett.com (enforcer.machelett.com [85.25.207.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCABB155757
	for <iommu@lists.linux.dev>; Sun, 18 Oct 2026 01:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.25.207.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792288567; cv=none; b=EaqDwg7eRUZxpT1zaWdViPf7DuXr82qZj0hclF38oK7FKQzgKp4O8zIoLtWdyqHCJdQi6eadtN9Ld0Zj8e7wmmp2+9rk7k0LUHmGZMHljdGrO1MlnFhZq+NYCITRgD8gEIofvvfVWc55toy2iFO+Bpx138sIEC89vAJjaaYrcds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792288567; c=relaxed/simple;
	bh=INkyGhxuf2ncKMV1C63Lpz06FWz77n//VGCaeT7Jyt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TTazzseNyow0sUJpXVbuknmPQJNtf00iugnPOdEc+jbN6lw2XkvZv50SMZGC1u8hTJELY2XHU3T1sg8604+Dgi6JpjWN231FAgq5vr792RCo0jZOpnfqvIG3BTZTdTeZK/9+mdRLRR+5dRuiZ/3NFmFGEZllqjx3FiNJgjxTxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=machelett.com; spf=pass smtp.mailfrom=machelett.com; dkim=pass (1024-bit key) header.d=machelett.com header.i=@machelett.com header.b=L3vTUUAv; arc=none smtp.client-ip=85.25.207.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=machelett.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machelett.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=machelett.com header.i=@machelett.com header.b="L3vTUUAv"
Received: from localhost (localhost [127.0.0.1])
	by enforcer.machelett.com (Postfix) with ESMTP id 2D622390090A;
	Sun, 18 Oct 2026 03:50:11 +0200 (CEST)
X-Virus-Scanned: Debian amavis at machelett.com
Received: from enforcer.machelett.com ([127.0.0.1])
 by localhost (enforcer.machelett.com [127.0.0.1]) (amavis, port 10024)
 with LMTP id sn6cLzKLxH78; Sun, 18 Oct 2026 03:50:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=machelett.com;
	s=mail; t=1792288210;
	bh=20lCdNjxVdddOU0IEUN1YmUFTYoS9csqiMmSnMvdXgk=;
	h=From:To:Cc:Subject:Date:From;
	b=L3vTUUAvM8z686HP1Axx4v3x8P7W9APknz0xsvs1zYT66f3Z5VPRLSDCSUE4JfPdc
	 mAuKIK2l+Qykk7s5P8J9eZ9PF90A5KtFxAFDJC++vwWpF0mFfzWhPA44YUq5GkYzIa
	 5JhQXiuIdNk0WUNhE0qBR6kf4f+TX6NpyfLWK63k=
Received: from RAIDER (ip-037-049-016-046.um09.pools.vodafone-ip.de [37.49.16.46])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by enforcer.machelett.com (Postfix) with ESMTPSA id D1E3A39002C8;
	Sun, 18 Oct 2026 03:50:10 +0200 (CEST)
From: "Renato Machelett" <renato@machelett.com>
To: <iommu@lists.linux.dev>,
	<kernel-team@lists.ubuntu.com>
Cc: <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>,
	<joro@8bytes.org>
Subject: iommu/dma: SATA RMRR reservation omission in shared group on HP Gen8
Date: Sun, 18 Oct 2026 03:50:10 +0200
Organization: Machelett Software & Consulting
Message-ID: <02b201dd5ea3$02b88430$08298c90$@machelett.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ad1eop9ftz9XZwIZQAC9DrEvO272kg==
Content-Language: en-de

Hello,

I am hitting a recurring DMA PTE collision issue on an HP ProLiant =
DL320e Gen8 v2 (Xeon E3-1230 v3, Intel C222 Lynx Point PCH, BIOS P80 =
tested with both 03/28/2014 and 04/04/2019) on Ubuntu 24.04 with =
6.8.0-146-generic. In Ubuntu's 6.8.0-147-generic source, =
drivers/iommu/dma-iommu.c is byte-identical.

On Ubuntu Launchpad, bug 2160616 =
(https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2160616) reported =
the same 0xf1f7e collisions on HP Gen8 hardware and was marked as a =
duplicate of bug 2158934 (the PCIe ACS quirk regression reverted in =
6.8.0-136.136). However, 6.8.0-146 already contains that ACS revert and =
still reproduces these collisions with intel_iommu=3Don, because on the =
Intel C222 PCH 00:1f.0 (LPC bridge, 8086:8c4e) and 00:1f.2 (AHCI SATA =
controller, 8086:8c02) are multifunction siblings without ACS hardware =
and share IOMMU group 8:

  pci 0000:00:1f.0: Adding to iommu group 8
  pci 0000:00:1f.2: Adding to iommu group 8

The ProLiant DMAR table defines 23 pages of RMRR (0xf1f7e000-0xf1f94fff) =
scoped to 00:1f.2 (SATA), but not to 00:1f.0 (LPC).

My source analysis points to drivers/iommu/dma-iommu.c (matching the Oct =
2024 thread at https://lists.openwall.net/linux-kernel/2024/10/24/1195):
1. During bus probing (bus_iommu_probe -> iommu_setup_default_domain, =
drivers/iommu/iommu.c:2014, :3150), =
iommu_create_device_direct_mappings() installs 00:1f.2's 23 identity =
PTEs (0xf1f7e003..0xf1f94003) into group 8's hardware IOMMU page table.
2. When bus_iommu_probe() finalizes group 8 in member order (00:1f.0 =
first, 00:1f.2 second), iommu_dma_init_domain() =
(drivers/iommu/dma-iommu.c:701-727) initializes iovad->start_pfn and =
calls iova_reserve_iommu_regions() for 00:1f.0 (which has no RMRRs), =
then takes the already-initialized iovad->start_pfn early return (lines =
701-713) for 00:1f.2 without reserving 00:1f.2's RMRRs in the IOVA =
allocator.
3. Because iommu_dma_alloc_iova() prefers allocations below 4 GiB =
(pci_32bit_workaround), ordinary ahci disk I/O can allocate these =
unreserved vPFNs (0xf1f7e..0xf1f94):

  DMAR: ERROR: DMA PTE for vPFN 0xf1f7e already set (to f1f7e003 not =
11f04e003)
  WARNING: CPU: 3 PID: 2210 at drivers/iommu/intel/iommu.c:2227 =
__domain_mapping+0x2b5/0x320
  Call Trace:
   <TASK>
   intel_iommu_map_pages+0xe1/0x140
   __iommu_map+0x121/0x280
   iommu_map_sg+0xbf/0x1f0
   iommu_dma_map_sg+0x463/0x4f0
   __dma_map_sg_attrs+0x35/0xd0
   dma_map_sg_attrs+0xe/0x30
   ata_qc_issue+0x131/0x320

4. In __domain_mapping() (drivers/iommu/intel/iommu.c:2218), =
cmpxchg64_local(&pte->val, 0ULL, pteval) sees the pre-existing RMRR =
identity PTE (0xf1f7e003) and logs the warning, but does not fail the =
mapping, leaving the identity translation in place. A subsequent DMA =
transfer could therefore access the RMRR page instead of the intended =
RAM buffer (I also observed cached ext4 inode checksum errors on this =
host, though I have not proven the completed DMA link directly). =
Subsequent DMA unmapping in dma_pte_clear_level() =
(drivers/iommu/intel/iommu.c:1097) calls dma_clear_pte(), clearing the =
covered identity PTE so repeated allocations at that vPFN need not =
produce another warning.

Separately, when testing Ubuntu Noble HWE 7.0.0-38-generic on the same =
host, drivers/iommu/dma-iommu.c still has the same initialized-domain =
early return before per-device reservation, and I also observed =
immediate VT-d faults during boot ("DMAR: [DMA Write NO_PASID] Request =
device [00:1f.2] fault addr 0xf4c00000 [fault reason 0x0c] non-zero =
reserved fields in PTE", CAP=3D0xd2008c20660462, ECAP=3D0xf010da) =
followed by ATA Emask 0x40 (AC_ERR_SYSTEM) failures. This kernel uses =
drivers/iommu/generic_pt/fmt/vtdss.h, whose permission handling in =
vtdss_pt_iommu_set_prot() differs from the legacy implementation (no =
longer OR'ing bit 0 on IOMMU_WRITE), though I have not established which =
specific PTE field caused the 0x0c fault.

I am currently running with intel_iommu=3Doff as a workaround. Is there =
an existing fix or backport for this shared-group reservation omission?

Thank you!
Renato

