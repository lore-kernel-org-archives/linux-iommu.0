Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CB048DB37
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394839; cv=none; b=Js7NzH18bBwPQDZ6VpNM1nPRHkbJia0Gtr4g81dM/6IhHgZp+dRLDHLgqdGG2Utw7Ucr0WWOAFDI+L1h3TY/yFNSRGy2cxJzn5nl9H0tnfuPfs7YdPa4sgLgmkarKPtjpHGn+Ckt6bcLgU4l1mxAlYix8VoYl0haP2XTGLVseQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394839; c=relaxed/simple;
	bh=0T98m1ELRc4eTtBMW8+nPuPgIS0HZy+hRlapM4lfh7g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZFVAjQrtKmKjOQr2xyVQ8TA8QprYSguya1lZbj6znzy2Rs4RrULVCP9Zz8w3F44an7BiKjjFC2vZVWTJSQInuh9iG3OOTRZLg6kMoMCXC1y+Wv6Fq4gEh+m4yHNyPL2peL5+EWxJyvPle2YGYwCcyTRP7iHTsXTkp2AbuPKu1do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6TLGGkT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6TLGGkT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792394838; x=1823930838;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0T98m1ELRc4eTtBMW8+nPuPgIS0HZy+hRlapM4lfh7g=;
  b=I6TLGGkTJZ8ZMMAHp5vz8pZC963V+67E1T2FnSI8qWdd+4mlCj3a4ymT
   nNFgAD0416NkXAdgerQjMt7rb4g4erqjFtsSP3vYnyX/7ymHgmcUum/4Q
   T8JV8QD1mwGnWXG/uE887t7w2k5M27GOULVtYYqm0yUxZHPnbDUucFr5k
   7qv8Q3vNY/aOnGYqGGs5JB34FTioofd+c22pRK+98jlHQ6mlBxQtopsLp
   cwMEWUUOsIdL5N+7CfnPgMT9y7Nc0L1R8McRx181OZKT7bsJmsweK4kCL
   YMA52GZ8TGvdYrfhqzYpt1Y3bE666r0x81TzCPqGcEITlYEN8Qu2XeITC
   A==;
X-CSE-ConnectionGUID: G7+9Ake2S+imszY2hdtpPA==
X-CSE-MsgGUID: mNlyxhiVQ0GC0jrvAfWHtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1070551"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1070551"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 00:27:17 -0700
X-CSE-ConnectionGUID: ABrjHQwhQfC7Fzeh5vgpCQ==
X-CSE-MsgGUID: UqkibW+DSqiD7OLmcaTHLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2826014"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 00:27:15 -0700
Message-ID: <ea131a99-d3f0-4d52-a076-d80d84d690e8@linux.intel.com>
Date: Mon, 19 Oct 2026 15:27:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, robin.murphy@arm.com, joro@8bytes.org
Subject: Re: iommu/dma: SATA RMRR reservation omission in shared group on HP
 Gen8
To: Renato Machelett <renato@machelett.com>, iommu@lists.linux.dev,
 kernel-team@lists.ubuntu.com
References: <02b201dd5ea3$02b88430$08298c90$@machelett.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <02b201dd5ea3$02b88430$08298c90$@machelett.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/18/2026 9:50 AM, Renato Machelett wrote:
> Hello,
> 
> I am hitting a recurring DMA PTE collision issue on an HP ProLiant DL320e Gen8 v2 (Xeon E3-1230 v3, Intel C222 Lynx Point PCH, BIOS P80 tested with both 03/28/2014 and 04/04/2019) on Ubuntu 24.04 with 6.8.0-146-generic. In Ubuntu's 6.8.0-147-generic source, drivers/iommu/dma-iommu.c is byte-identical.
> 
> On Ubuntu Launchpad, bug 2160616 (https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2160616) reported the same 0xf1f7e collisions on HP Gen8 hardware and was marked as a duplicate of bug 2158934 (the PCIe ACS quirk regression reverted in 6.8.0-136.136). However, 6.8.0-146 already contains that ACS revert and still reproduces these collisions with intel_iommu=on, because on the Intel C222 PCH 00:1f.0 (LPC bridge, 8086:8c4e) and 00:1f.2 (AHCI SATA controller, 8086:8c02) are multifunction siblings without ACS hardware and share IOMMU group 8:
> 
>    pci 0000:00:1f.0: Adding to iommu group 8
>    pci 0000:00:1f.2: Adding to iommu group 8
> 
> The ProLiant DMAR table defines 23 pages of RMRR (0xf1f7e000-0xf1f94fff) scoped to 00:1f.2 (SATA), but not to 00:1f.0 (LPC).
> 
> My source analysis points to drivers/iommu/dma-iommu.c (matching the Oct 2024 thread at https://lists.openwall.net/linux-kernel/2024/10/24/1195):
> 1. During bus probing (bus_iommu_probe -> iommu_setup_default_domain, drivers/iommu/iommu.c:2014, :3150), iommu_create_device_direct_mappings() installs 00:1f.2's 23 identity PTEs (0xf1f7e003..0xf1f94003) into group 8's hardware IOMMU page table.
> 2. When bus_iommu_probe() finalizes group 8 in member order (00:1f.0 first, 00:1f.2 second), iommu_dma_init_domain() (drivers/iommu/dma-iommu.c:701-727) initializes iovad->start_pfn and calls iova_reserve_iommu_regions() for 00:1f.0 (which has no RMRRs), then takes the already-initialized iovad->start_pfn early return (lines 701-713) for 00:1f.2 without reserving 00:1f.2's RMRRs in the IOVA allocator.
> 3. Because iommu_dma_alloc_iova() prefers allocations below 4 GiB (pci_32bit_workaround), ordinary ahci disk I/O can allocate these unreserved vPFNs (0xf1f7e..0xf1f94):
> 
>    DMAR: ERROR: DMA PTE for vPFN 0xf1f7e already set (to f1f7e003 not 11f04e003)
>    WARNING: CPU: 3 PID: 2210 at drivers/iommu/intel/iommu.c:2227 __domain_mapping+0x2b5/0x320
>    Call Trace:
>     <TASK>
>     intel_iommu_map_pages+0xe1/0x140
>     __iommu_map+0x121/0x280
>     iommu_map_sg+0xbf/0x1f0
>     iommu_dma_map_sg+0x463/0x4f0
>     __dma_map_sg_attrs+0x35/0xd0
>     dma_map_sg_attrs+0xe/0x30
>     ata_qc_issue+0x131/0x320
> 
> 4. In __domain_mapping() (drivers/iommu/intel/iommu.c:2218), cmpxchg64_local(&pte->val, 0ULL, pteval) sees the pre-existing RMRR identity PTE (0xf1f7e003) and logs the warning, but does not fail the mapping, leaving the identity translation in place. A subsequent DMA transfer could therefore access the RMRR page instead of the intended RAM buffer (I also observed cached ext4 inode checksum errors on this host, though I have not proven the completed DMA link directly). Subsequent DMA unmapping in dma_pte_clear_level() (drivers/iommu/intel/iommu.c:1097) calls dma_clear_pte(), clearing the covered identity PTE so repeated allocations at that vPFN need not produce another warning.
> 
> Separately, when testing Ubuntu Noble HWE 7.0.0-38-generic on the same host, drivers/iommu/dma-iommu.c still has the same initialized-domain early return before per-device reservation, and I also observed immediate VT-d faults during boot ("DMAR: [DMA Write NO_PASID] Request device [00:1f.2] fault addr 0xf4c00000 [fault reason 0x0c] non-zero reserved fields in PTE", CAP=0xd2008c20660462, ECAP=0xf010da) followed by ATA Emask 0x40 (AC_ERR_SYSTEM) failures. This kernel uses drivers/iommu/generic_pt/fmt/vtdss.h, whose permission handling in vtdss_pt_iommu_set_prot() differs from the legacy implementation (no longer OR'ing bit 0 on IOMMU_WRITE), though I have not established which specific PTE field caused the 0x0c fault.
> 
> I am currently running with intel_iommu=off as a workaround. Is there an existing fix or backport for this shared-group reservation omission?

Thank you for the report. This issue still appears to exist in the
latest upstream kernel:

static int iommu_dma_init_domain(struct iommu_domain *domain, struct 
device *dev)
{
...
         /* start_pfn is always nonzero for an already-initialised domain */
         if (iovad->start_pfn) {
                 if (1UL << order != iovad->granule ||
                     base_pfn != iovad->start_pfn) {
                         pr_warn("Incompatible range for DMA domain\n");
                         return -EFAULT;
                 }

                 return 0;
         }
...
}

The early return is still there. Have you tried reserving the second
device's RMRR in the IOVA allocator as well? Something like:

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 68ee57800fef..e9b39009f109 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -704,7 +704,7 @@ static int iommu_dma_init_domain(struct iommu_domain 
*domain, struct device *dev
                         return -EFAULT;
                 }

-               return 0;
+               return iova_reserve_iommu_regions(dev, domain);
         }

         init_iova_domain(iovad, 1UL << order, base_pfn);

This would at least confirm your analysis.

Thanks,
baolu
