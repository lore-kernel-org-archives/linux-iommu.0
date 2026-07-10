Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20B63783D8
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685508; cv=none; b=NxvgqVvTo2m3GwzOfWmWOKMhZjLYFOzcWSkG8G0VFLyeq3PxCD1LxwhDhYTZs27gMIzOI64SjWxDghJkuFNFcoyTwKhXGAxsFFxFTJ+1xJ4eh1Mkdx3w5lGBFRKI0PrBO9NznovSbwfVLGpV93S3RBRHO1F5gmhBmN2l9kNOz8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685508; c=relaxed/simple;
	bh=Q2see9+GI8xU//+CtviZOZx19CnBHqZmF8tVQaULcbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9cwwiBy9GpGnKprR+V4Wbrf+VR1sKvyW0YjOx8EQh7ds2R84PUrEhzeh3y77LciuYNAi0ymrgMv91QqMxL03UwviDBfK2KV5yqs11GeppSObbtk1/lbNzRNfN7g6lHQCmFT9ribut6cDqhmlXqlYaJ2Zi+rAer0fhV+bXjo7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D5p3BRWS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D5p3BRWS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AFAF1E7D;
	Fri, 10 Jul 2026 05:11:40 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12DFD3F85F;
	Fri, 10 Jul 2026 05:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783685504; bh=Q2see9+GI8xU//+CtviZOZx19CnBHqZmF8tVQaULcbE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D5p3BRWSyMoNDxD/QaUv5QMjXLFZnnn18JTuKVPlAZXBN450QHvPpSetMzN/GZ3zj
	 W2IiiMPdZtGLD+M+Anx7Qy1UV4t86jKoZu1P3IZDMTQyiPguDn8CfF299YNnaznMWE
	 KZwYaOSphRKwtuby8ouXyFEY7FmW5cqo+6Mbxy0k=
Message-ID: <15bbada2-3214-45dc-8934-a6dbe207c887@arm.com>
Date: Fri, 10 Jul 2026 13:11:41 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/rockchip: implement .flush_iotlb_all
To: Will Deacon <will@kernel.org>, Jiaxing Hu <huhuvmb88@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 jgg@ziepe.ca
References: <20260710060513.863714-1-huhuvmb88@gmail.com>
 <alDQevX58XvdRcWc@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <alDQevX58XvdRcWc@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/07/2026 11:59 am, Will Deacon wrote:
> On Fri, Jul 10, 2026 at 06:05:13PM +1200, Jiaxing Hu wrote:
>> rk_iommu invalidates the IOTLB synchronously in .unmap (via
>> rk_iommu_zap_iova), so it stays consistent without a deferred .iotlb_sync
>> and does not advertise IOMMU_CAP_DEFERRED_FLUSH.
>>
>> It never implemented the optional .flush_iotlb_all op, though, and
>> iommu_flush_iotlb_all() is a no-op when that op is absent -- so on Rockchip
>> a driver that owns an rk_iommu domain and calls it to flush the whole
>> domain's TLB (e.g. before reusing a mapping, without unmapping it) gets
>> nothing, even though the hardware can do it: rk_iommu already issues
>> ZAP_CACHE for range shootdowns.
>>
>> Implement it with that same primitive: ZAP_CACHE every bank of every IOMMU
>> on the domain, under the runtime-PM + clk guard already used by
>> rk_iommu_zap_iova().
>>
>> Found while bringing up an out-of-tree RK3576 NPU (accel/rocket) driver
>> that flushes before each submit; on Rockchip that flush did nothing.
>>
>> Signed-off-by: Jiaxing Hu <huhuvmb88@gmail.com>
>> ---
> 
> We tried to get rid of iommu_flush_iotlb_all() in 69e5a17511f6
> ("iommu: Remove useless flush from iommu_create_device_direct_mappings()")
> but we had to revert that in a33bf8d8ce7e ("iommu: Restore
> iommu_flush_iotlb_all()") because of a user in the MSM driver.

We wanted rid of the public API (indeed partly due to the prospect of 
client drivers abusing it), but the actual ->flush_tlb_all driver op 
remains crucial to the flush queue mechanism, so there's no harm in 
drivers implementing it *if* they also implement the relevant 
optimisations to avoid synchronous flushing in unmap_pages to make 
CAP_DEFERRED_FLUSH worthwhile.

Thanks,
Robin.

> So I think this is the wrong direction. We should try harder to remove
> the function rather than add new implementations of it. I'm assuming
> you're only adding it for some out-of-tree code that calls it?
> 
> Will

