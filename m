Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E4620A5D5
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408557; cv=none; b=Hq7ENxNgEWT7zLnpVswXX5Z67PubFeAiFwYhJZEbVbV0fiZnUb0A2quGV+ytl73NiFqg/H4t4hNaB0S/hb8i5dUPcuDNigEZObMwN0ppXoqf+1+dfRqkw9/DGW8ZqTX/ItRCPnJJojgE/UMYX07TrgSO5lkFR4GhZYd9wa9fcCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408557; c=relaxed/simple;
	bh=1SO9DPjUlevAXVNWLg4ulo6oYUbhChI1qbMPw0Ix46Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5q/oX7IEbaend2tNG2GFXtE4C+xFp8Fco7eYwVsAad+PFDR4ZAOYE84IbO8ubrU3b7UlPF2OR7lMW/4F15r5G798/EwWWUJ4ra5WekkSV3fNa3+5JFROXCbutolUeGdhAkeuO3oDUP6/jKWoG8aZNwFSxZzZj1kjwICENcGffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7F161063;
	Wed, 19 Mar 2025 11:22:41 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 479B13F673;
	Wed, 19 Mar 2025 11:22:32 -0700 (PDT)
Message-ID: <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
Date: Wed, 19 Mar 2025 18:22:30 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System Sleep
 ops
To: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>,
 Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
References: <20250319004254.2547950-1-praan@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250319004254.2547950-1-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/03/2025 12:42 am, Pranjal Shrivastava wrote:
> As arm-smmu-v3 rapidly finds its way into SoCs designed for hand-held
> devices, power management capabilities, similar to its predecessors, are
> crucial for these applications. This series introduces power management
> support for the arm-smmu-v3 driver.
> 
> Design
> =======
> The arm-smmu-v3 primarily operates with in-memory data structures
> through HW registers pointing to these data structures in some fashion.
> The proposed design tries to make use of this fact for implementing the
> suspend and resume ops.
> 
> 1. Suspend / Resume
> An initial idea for the "suspend" op is to wait till the command queue
> finishes all commands before disabling the SMMU through CR0. In order to
> avoid mis-use / spurious transactions (b/w SMMU disable -> power-down),
> the GBPA register is configured to abort all transactions.

But why disable SMMUEN at all? We can't expect the SMMU to come back in 
the same configuration we left it anyway (*including* GBPA, note), so 
what's the benefit of spending time and effort to potentially change its 
behaviour for a handful of microseconds before it all goes dark anyway?

Draining the command queue shouldn't strictly be necessary it only 
contains invalidations and syncs, since we know all the cached state 
they could refer to is going to be thrown away by the time the SMMU has 
come back anyway. If anything, making sure there are no outstanding IOPF 
handlers and the event queue and PRI queue are clear (as expected) seems 
more important, because the potential to lose hardware tokens or leave a 
stalled transaction across the interconnect would be A Bad Thing.

> The resume operation uses the `arm_smmu_device_reset` function which
> re-initializes the HW using the SW-copies maintained by the driver. For
> example, prod/cons for queues, base addresses for queues & tables. The
> arm_smmu_device_reset also clears the TLBs.
> 
> 2. Interrupt Re-config
> a. Wired irqs: the series refactors the `arm_smmu_setup_irqs` to be
> able to enable/disable irqs and install their handlers separately to
> help with the re-initialization of the interrupts correctly.
> 
> b. MSIs: The thought was of 2 approaches to teardown & re-config MSIs:
> 
>   1. Free MSIs on suspend and re-alloc on resume (implemented in series)
>   2. Meddle with the msi_desc and use get_cached_msi_msg to resume MSIs.

3: Just explicitly save/restore the IRQ_CFG{0,1} registers in the PM 
callbacks.
4: Have arm_smmu_write_msi_msg() stash the values, and defer the actual 
IRQ_CFG register writes until arm_smmu_setup_irqs(), alongside IRQ_CTRL.

If the other options aren't sufficiently clean or straightforward, 
another 36 bytes per arm_smmu_device instance isn't the end of the world...

> The first approach (implemented in this series) may be potentially
> slower, whereas the second one could reduce the time taken to resume.
> However, the second one feels hacky as it forces us to cache the msi_msg
> in `arm_smmu_write_msg` or in the core code (`irq_chip_write_msi_msg`)
> as suggested in [1].
>    
> 3. Invoking runtime_pm_get/put
> Given that most of the configuration done by arm-smmu-v3 is stored in
> memory, the initial idea is to focus on areas where the driver accesses
> the hw via exposed ops, like iommmu_ops, iommu_flush_ops, sva_ops etc.
> 
> Instead of wrapping every exposed op with an rpm_get/put, the idea is to
> follow through till a logical common point (lowest common ancestor in
> the call hierarchies) and wrap those with the rpm_get/put calls.

As mentioned already, I think there should be very few, if any, places 
where we actually need an rpm_get() to explicitly resume a suspended 
SMMU. All the initial hardware probing and reset can (and should) be 
done before PM is enabled; IRQ handlers can reasonably assume that any 
call while the SMMU is suspended must be shared or spurious, so don't 
need to look (even more so if we do still clear IRQ_CTRL on suspend); 
any commands issued while suspended are either safe to ignore 
(CFGI/TLBI/PREFETCH) or nonsensical (RESUME/PRI_RESP) - the only one I'm 
not entirely sure about off the top of my head is ATC_INV, which might 
depend on whether the PCI code can guarantee that an endpoint will 
resume with a clean ATC.

I don't see SVA and VFIO needing any special considerations, so it might 
just be the new vIOMMU stuff which may need to hold PM enabled for the 
lifetime of things exposed to userspace.

Thanks,
Robin.

> Future Work
> ===========
> - Elide TLBIs when the SMMU is powered down
> 
> Call for Review
> ================
> Any insights/comments on the proposed changes are appreciated,
> especially in areas related to locking, atomic contexts, early resume
> etc. or any potential optimization.
> 
> Note: The series isn't tested with MSIs as I couldn't find a platform
> that supports MSIs. Any help in testing MSIs is appreciated.
> 
> References
> ===========
> [1]
> https://lore.kernel.org/lkml/20210721013350.17664-1-cuibixuan@huawei.com/T/#m06bf92e2306ba52c106f2d4d24765921d4e9781e
> 
> [2]
> https://lore.kernel.org/all/20180830144541.17740-1-vivek.gautam@codeaurora.org/
> 
> Pranjal Shrivastava (5):
>    iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
>    iommu/arm-smmu-v3: Add a helper to wait till cmdq drains
>    iommu/arm-smmu-v3: Implement pm_runtime & system sleep ops
>    iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
>    iommu/arm-smmu-v3: Invoke pm_runtime before hw access
> 
>   .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  22 +-
>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  24 ++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 297 ++++++++++++++++--
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   5 +
>   4 files changed, 326 insertions(+), 22 deletions(-)
> 
