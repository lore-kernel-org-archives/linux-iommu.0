Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682C12BE641
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731704; cv=none; b=iHdgZYKr1WFlPeCf96P7v6Xw/VX/CP0njioyWKaTuTdOk3hh8A4uLsO35AT0GU9SNSTes2js+JGSbqGUSOpsqxBzZ3Wb3Qn7VbJoHJZ5QyIsnYWtB6WSX0RzcNvkmJJy60F9y2fmkkeWcviucofOc5Njiw1mHGKLrdwMROUJM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731704; c=relaxed/simple;
	bh=t8XUKvJYJ1hz3fS50O5GBXEL5Y6SH6quebPpNgxd/4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CS6t6+v2y5joKFQwSgIJYFzHjW5pokF8ZqMYzp3Pwjvn1xoi49lhmifrAcZHIMSib+YJfls2My57sggzDPdsafpfZM+ylpstez4eoKBOorGkgNfR230c1l++meoJ1dkQLvPSNC/V9UhURnPVczLHPqxUFGGYCutMGRec5C/wCs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hWPFPrDN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hWPFPrDN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1F1B32C5;
	Thu,  9 Apr 2026 03:48:15 -0700 (PDT)
Received: from [10.57.85.238] (unknown [10.57.85.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A3EC3F632;
	Thu,  9 Apr 2026 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775731701; bh=t8XUKvJYJ1hz3fS50O5GBXEL5Y6SH6quebPpNgxd/4U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hWPFPrDNA8ryIaMISnrcGIhG8826sdvNhVMuxlBGTEPg7+IxP8gKRdz2LS5W7hqrC
	 FvPjIzJBUDBgmPTzdtGq9ZPdXzyvlc0qkMVAkzBo3JvKi/4DRQNEHC5lNNYljUPFWe
	 H9wagXhZD0eUMU3uEdytpFe1tSPcgLo/TPBR/VeE=
Message-ID: <c773c37c-b4ce-4f3f-927f-0be8a9b2d7a5@arm.com>
Date: Thu, 9 Apr 2026 11:48:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [FYI] iommu/iova: unbounded memory growth on 160-core ARM64 with
 64K pages and DMA-FQ
To: Alireza Haghdoost <haghdoost@uber.com>, linux-iommu@vger.kernel.org,
 iommu@lists.linux.dev
Cc: jroedel@suse.de, will@kernel.org, Nagi Parimi <nparimi@uber.com>,
 Kshitij Doshi <kshitijd@uber.com>, Jeff Bean <bean@uber.com>,
 Vikrant Soman <vsoman@uber.com>
References: <CA+w=M=SEUeGvXaK6OqdDVjYrbagnzDgAMgCRHbRqoYvS+OgW=w@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CA+w=M=SEUeGvXaK6OqdDVjYrbagnzDgAMgCRHbRqoYvS+OgW=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-04-08 7:26 pm, Alireza Haghdoost wrote:
> Hi all,
> 
> Sharing an observation of unbounded memory growth in the IOVA rcache
> depot on ARM64 that may be relevant to others running DMA-FQ on
> high-core-count machines.
> A config misconfiguration during a kernel upgrade from 6.1 to 6.18
> unintentionally switched our IOMMU default from passthrough to
> DMA-FQ. Over several weeks, 93
> ARM64 hosts (Ampere AmpereOne, 160 vCPUs, 1 TiB RAM, 64K pages,
> arm-smmu-v3, heavy NVMe + network IOPS) accumulated up to hundreds
> of GiB each of unreclaimable slab in iommu_iova objects, eventually
> OOM-killing production workloads. Total waste across the fleet was
> more than 25 TiB.
> The issue is resolved on our end by correcting the config back to
> passthrough. We're sharing it as a heads-up.
> 
> The slab growth appeared under dmaengine-unmap-2 due to SLUB cache
> merging with iommu_iova (both 64 bytes on ARM64). One host after 25
> days showed ~3 billion active objects at near-100% utilization,
> suggesting genuinely retained objects rather than slab fragmentation.
> Two things stood out as possible contributing factors:
> 1. Since commit 911aa1245da83 ("iommu/iova: Make the rcache depot
>     scale better", v6.7-rc1), the depot is an unbounded linked list.
>     The drain pops one magazine per 100ms tick and only when
>     depot_size > num_online_cpus(), which on 160 cores may not keep
>     pace with sustained high IOPS.

Hmm, TBH that makes me suspicious of a driver bug - IOVA magazines are 
only pushed to the depot list when IOVAs are freed, but in order to be 
freed, they obviously first need to be allocated, and allocation will 
pop full magazines back off the depot list, so the total number of IOVA 
allocations still only grows to the actual peak working set size of the 
overall system workload. Thus at least the _maximum_ iommu_iova cache 
usage for non-passthrough is not affected by the depot changes, the only 
difference is the struct iovas will tend to live longer as they will 
stay around in between uses more often, rather than be freed and 
reallocated in the slab cache itself. There is of course some additional 
memory cost in the iommu_iova_magazine cache, as there can now be 
significantly more magazines in flight, but even on big systems I'd 
expect that to only be in the order of tens of megabytes, so still 
pretty negligible overall.

Truly unbounded growth would stem from a driver passing the wrong size 
to dma_unmap, such that the magazines are pushed to the wrong depot 
list, and thus IOVAs are _not_ reused correctly. It's true that such a 
bug would have been heavily bounded by the fixed-size depot before, but 
hey, we don't optimise for bugs, and the whole point was that that was 
also severely bounding the performance of correct operation on large 
systems (i.e. >16 CPUs or thereabouts).

If some workload really does oscillate back and forth between doing lots 
of DMA and then needing as much memory as possible for other purposes, 
and is happy to trade the setup cost of the DMA phases for more 
"in-between" memory the we could certainly consider adding some sysctl 
tuneables for how aggressively the depot reclaim runs - that's something 
I always had in mind, but which didn't seem worth doing unless and until 
it could be proven to be useful.

> 2. With CONFIG_ARM64_64K_PAGES=y, each slab page holds 1024 64-byte
>     objects. Slab pages can only be reclaimed when all objects are
>     freed, which makes it harder for partial drain to translate into
>     actual memory reclaim.

I guess that legitimately long-lived IOVAs fragmenting other slab caches 
could still be a potential issue either way though, so we could perhaps 
also consider making a performance argument for SLAB_NO_MERGE here.

Thanks,
Robin.

> Our kernel cmdline included iommu=pt, which we expected to force
> passthrough. However, that parameter is only handled by x86-specific code
> (arch/x86/kernel/pci-dma.c). On ARM64, only iommu.passthrough=1 is
> recognized by the generic IOMMU core.
> 
> Sincerely,
> Alireza Haghdoost

