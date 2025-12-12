Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DF720B7ED
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765536385; cv=none; b=J/nGsvRa1AJQW9qo7MY2zRdyWGQYooUFpUmpnq/rf1xP43oS9SM9ng2F2PNQf3CCRoQjWeZLs0VzhhS4EMDmb4Pxc/XWQuzB/7QU4jgtN7ln5oA/NN++XfJBgELLTn0qi6zoz/u4nz3bLM3R6NgRCE2l6iK4LTKnqnjrTMN7gL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765536385; c=relaxed/simple;
	bh=W4l0KbS0D+ZN4m3+souWSNXvU8JJ/5D8kBmDVMOpLcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a44ewypHyL1kMaMjUpOR7KT32GI3/m68vJYQtRYrt3T04SLAnCJ5Aqo6kXbH/Ve640aJgI6xEaR0nsa5uKNJmJdA7iwcRGUU6fegFpKsfaUze6YhFiivvBFDY/jDHi2hllNS3CJgom05YhXDQ76bn4s3fFhZb6tUbLD41WxmCO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C65E7FEC;
	Fri, 12 Dec 2025 02:46:15 -0800 (PST)
Received: from [10.57.93.22] (unknown [10.57.93.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5ACB3F762;
	Fri, 12 Dec 2025 02:46:21 -0800 (PST)
Message-ID: <650659ac-22f0-4fc0-ad43-8d4169cf2432@arm.com>
Date: Fri, 12 Dec 2025 10:46:15 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow stream ID sharing for
 devices behind PCIe-to-PCI bridges
To: Jason Gunthorpe <jgg@ziepe.ca>, Nirmoy Das <nirmoyd@nvidia.com>
Cc: will@kernel.org, joro@8bytes.org, nicolinc@nvidia.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251211133933.4128100-1-nirmoyd@nvidia.com>
 <aTu4xsAApNupRGYC@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aTu4xsAApNupRGYC@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-12 6:40 am, Jason Gunthorpe wrote:
> On Thu, Dec 11, 2025 at 05:39:33AM -0800, Nirmoy Das wrote:
>> ASPEED BMC controllers have VGA and USB functions behind a PCIe-to-PCI
>> bridge that causes them to share the same stream ID:
>>
>>    \-[0005:e0]---00.0-[e1-e2]----00.0-[e2]--+-00.0  ASPEED Graphics Family
>>                                             \-02.0  ASPEED USB Controller
>>
>> Both devices get stream ID(0x5e200) due to bridge aliasing. Currently this
>> USB controller gets rejected with "Aliasing StreamID unsupported", causing
>> USB timeout errors. Allow stream ID sharing when both devices are on
>> the same bus behind a PCIe-to-PCI bridge to fix this issue.
> 
> I don't think this is right, if you actually need stream ID sharing
> then I seem to recall the driver needs more changes. We don't want
> this in general.

Yes, as I said on the last one not so long ago, we cannot simply cross 
our fingers and hope that aliasing at the SMMU StreamID level stems from 
something at the PCI RID level that pci_device_group() would be aware 
of, because there is no guarantee that RID->StreamID mappings are 1:1.

Thanks,
Robin.

> IMHO ASPEED has wrong PCI config space and there isn't any actual PCI
> bus here that would force RID aliasing to worry about. I suggest going
> to ASPEED to find out and confirm that they don't actually share the
> RIDs and then let's quirk the PCI devices to disable alias generation
> in the first place.
> 
> Also, complain to them to fix their config space to report a PCIe bridge
> type in future devices. :)
> 
> Jason

