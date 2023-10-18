Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C46827700
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0C0E2F4;
	Wed, 18 Oct 2023 08:35:31 -0700 (PDT)
Received: from [10.57.67.203] (unknown [10.57.67.203])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74FAE3F64C;
	Wed, 18 Oct 2023 08:34:49 -0700 (PDT)
Message-ID: <70cc8d3d-1ddf-4700-ac15-bcd74fae2b2a@arm.com>
Date: Wed, 18 Oct 2023 16:34:20 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ARM IOMMU] IOMMU framework concurrency issue
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>, Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: will@kernel.org, joro@8bytes.org, baolu.lu@linux.intel.com,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 quic_tingweiz@quicinc.com
References: <e2e20e1c-6450-4ac5-9804-b0000acdf7de@quicinc.com>
 <20231017163337.GE282036@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231017163337.GE282036@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-10-17 17:33, Jason Gunthorpe wrote:
> On Tue, Oct 17, 2023 at 07:10:23PM +0800, Zhenhua Huang wrote:
>> Dear experts,
>>
>> Saw a few crashes in our projects because of concurrency between (1) and
>> (2).
>>
>> bus notifier or bus_iommu_probe:
>> 	__iommu_probe_device
>> 		acquire iommu_probe_device_lock only
>> 		iommu_init_device()
>> 			//touch dev->iommu (1)
>> 			dev_iommu_get()
>> 			->probe_device()
>>
>> Client device probing path:
>> of_dma_configure			
>> 	of_iommu_configure
>> 		//touch dev->iommu  (2)
>> 		...
>>
>>
>> We already have 01657bc14a39 ("iommu: Avoid races around device probe") and
>> the big comment in __iommu_probe_device() refers to adopt device_lock()
>> further. Notice your big effort to utilize it, and IMO it can address above
>> issue(which protects dev->iommu):
> 
> I think something else has gone wrong here, you should not be able to
> get to any really_probe() before the iommu side has done its part.
> 
> Even with proper device locking the poor device that is racing isn't
> going to work properly as the IOMMU won't be guarenteed to be
> consistently configured.
> 
> This seems like you need to resolve boot time ordering in your
> platform? (I don't know exactly how ARM works here though)
> 
> eg make sure the iommu driver is fully registered before allowing any
> concurrent probes. Once the iommu driver is registered it will be able
> to catch the bus notifiers and serialize things properly.

Ugh, I think I see at least how this happens for device which *don't* 
have an IOMMU - because iommu_init_device() has to transiently allocate 
dev->iommu in order to call ops->probe_device in order to discover that 
the device doesn't actually have an IOMMU (and thus free dev->iommu 
again). That still leaves a window where dev_iommu_fwspec_get() from 
elsewhere could return a pointer which becomes a UAF bomb, I guess 
b54240ad4943 didn't close it completely.

However I think my bus ops series might also happen to fix this, since 
with that we shouldn't get as far as that dev_iommu_get() unless we 
found ops which we can expect to be valid for the given device, so we 
should no longer be doing the allocate/free cycle except in the rare 
case that ->probe_device() suffers an unexpected genuine failure.

Thanks,
Robin.
