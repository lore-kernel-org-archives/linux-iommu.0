Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57C42F8EBE
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778237161; cv=none; b=kf3ITaAm1Wisa1JKMmZg0c77rDhqDBH0bLlqxNVGyUDAef50BaEkmZpl21Bvy3CJSNcNfx2MSc4KaCNO7C0WF5WScRPvS2NqBRw/FWKhzV3jvhWQd73FFUtxssmiZyX+KPztfMYJJLsNBHjvYVQZGvtwr+li781IIGg/ObN4yeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778237161; c=relaxed/simple;
	bh=yyZzoYvssdmpBPRlr1SJGXb2t0ugmFYZleDiF4Y/D5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDZwrRoKARAR2s4spcNWN9K/rOZNRoA9oYntUTBUyd75CvsoSvwbHkPEpTsTv1SikOemNVNvmO2pY9ZazMGGK+nFjUWy6PtGuJUmsB2fQdRP1Id9f0m1dO08lrU8rb74ybHOXIDhlV/I/0GqtsbHSb0hgwLpRA8ZWbPbx7QtFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KA0eieWe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KA0eieWe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C128B1C01;
	Fri,  8 May 2026 03:45:52 -0700 (PDT)
Received: from [10.57.63.248] (unknown [10.57.63.248])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 847223F763;
	Fri,  8 May 2026 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778237158; bh=yyZzoYvssdmpBPRlr1SJGXb2t0ugmFYZleDiF4Y/D5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KA0eieWeLNPgGr4n8aoPRUnkbT8E4iRGWp0RUrRa49SRyuVOv1N1sDkNm3t3stpI6
	 v1GwklLlCbo96Le5Flzdm3+ihD+p7kNSNC6JdvDw62LmHlg8wlHvUDlEoHCb73WJl7
	 q+KVVETaIvT6Q/oEAyLPh7f87zK2Ng7uMffYH+2o=
Message-ID: <b00c0492-e71a-4be6-b95f-ec3b424cc8ac@arm.com>
Date: Fri, 8 May 2026 11:45:50 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iommu: Add PCI vendor:device ID to IOMMU fault logs
To: Yigit Oguz <yigitogu@amazon.de>, joro@8bytes.org, will@kernel.org,
 baolu.lu@linux.intel.com, dwmw2@infradead.org, suravee.suthikulpanit@amd.com
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260506150541.60467-1-yigitogu@amazon.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260506150541.60467-1-yigitogu@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-06 4:05 pm, Yigit Oguz wrote:
> IOMMU fault and event logs currently identify devices using only their
> PCI segment/bus/device/function (SSSS:BB:DD.F). While mapping a single
> BDF to a device type is straightforward, doing so at scale across many
> hosts and thousands of fault events requires additional tooling and
> manual cross-referencing. Including the vendor:device ID directly in
> the log line makes each event self-contained and immediately actionable
> without any post-processing.

Sorry, but why are unexpected DMA faults happening "at scale" in the 
first place? If you have so many broken drivers that disambiguating them 
needs help from the kernel, something seems fundamentally wrong with 
that picture. Conversely if these are devices assigned to userspace then 
we should perhaps reconsider their ability to spam up the host kernel 
log at will anyway.

I'm not saying I necessarily have anything against this change in 
particular, but it has a strong smell of effort being spent on the wrong 
thing...

(And even then AFAICS it only really helps in the specific scenario of 
having only one of each type of device, otherwise you're back to still 
needing per-system knowledge of how BDFs map to physical instances to 
know what's what.)

Thanks,
Robin.

> This series adds vendor:device ID (VVVV:DDDD) to IOMMU event logs for
> ARM SMMUv3, Intel VT-d and AMD IOMMU.
> 
> Before:
>    arm-smmu-v3 arm-smmu-v3.0.auto: event: F_TRANSLATION client: 0000:2b:11.6
>      sid: 0x158e ssid: 0x0 iova: 0x280000000000 ipa: 0x0
>    DMAR: [DMA Write NO_PASID] Request device [86:00.0] fault addr 0xe0000000
>      [fault reason 0x05] PTE Write access is not set
>    AMD-Vi: Event logged [IO_PAGE_FAULT device=0000:41:00.0 domain=0x000a
>      address=0xe0000000 flags=0x0020]
> 
> After:
>    arm-smmu-v3 arm-smmu-v3.0.auto: event: F_TRANSLATION client: 0000:2b:11.6 [8086:1533]
>      sid: 0x158e ssid: 0x0 iova: 0x280000000000 ipa: 0x0
>    DMAR: [DMA Write NO_PASID] Request device [0000:86:00.0 8086:1533] fault addr 0xe0000000
>      [fault reason 0x05] PTE Write access is not set
>    AMD-Vi: Event logged [IO_PAGE_FAULT device=0000:41:00.0 8086:1533 domain=0x000a
>      address=0xe0000000 flags=0x0020]
> 
> Patch 1 adds vendor:device ID to ARM SMMUv3 translation fault logs.
> Patch 2 adds PCI segment and vendor:device ID to Intel VT-d DMAR
>          fault logs.
> Patch 3 adds a devid_str helper and vendor:device ID to all AMD IOMMU
>          event log paths.
> 
> Testing:
> Build-tested against mainline Linux (torvalds/master).
> 
> Runtime-tested on a custom downstream branch on ARM SMMUv3, Intel VT-d and
> AMD IOMMU hosts. Translation faults were induced in a virtualized setup
> by removing DMA mappings for an in-use region, causing the assigned device's
> subsequent DMA transactions to hit unmapped IOVAs and produce
> translation fault events. The resulting log lines were verified to
> contain the PCI vendor:device ID on all three platforms.
> 
> Lilit Janpoladyan (1):
>    iommu/arm-smmu-v3: Print PCI vendor:device ID in SMMU translation
>      fault logs
> 
> Yigit Oguz (2):
>    iommu/vt-d: Add PCI segment and vendor:device ID to DMAR fault logs
>    iommu/amd: Add vendor:device ID to AMD IOMMU event logs
> 
>   drivers/iommu/amd/iommu.c                   | 94 +++++++++++++--------
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 ++++++-
>   drivers/iommu/intel/dmar.c                  | 33 +++++---
>   3 files changed, 104 insertions(+), 52 deletions(-)
> 

