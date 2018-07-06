From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Date: Fri, 6 Jul 2018 12:57:11 +0100
Message-ID: <5811ebe5-b2bd-efc1-bf54-a8f05432c4f8@arm.com>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
	<20180705193613.GA28905@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180705193613.GA28905-jcswGhMUV9g@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: JuergenUrban-Mmb7MZpHnFY@public.gmane.org, noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/07/18 20:36, Christoph Hellwig wrote:
>> -	BUG_ON(!ops);
>> -	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
>> -
>>   	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
>>   		return cpu_addr;
>>   
>> +	BUG_ON(!ops);
>> +	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
> 
> I think doing dma on a device without ops is completely broken no matter
> what you think of it, so I very much disagree with that part of the change.
> 
> Also while I don't think not having a dma mask is a good idea even for
> a driver purely using dma coherent pools.  If the pools really are on
> the device itself I can see why it might not matter, but for the case
> commonly used on some ARM SOCs where we just reserve memory for certain
> devices from a system pool it very much does matter.
> 
> There really is no good excuse to not set a coherent mask in the drivers.

Right, I was rather on the fence about this - on the one hand it is 
objectively wrong per the API for drivers to call dma_alloc_coherent() 
without a prior successful dma_set_coherent_mask() call, but then I 
thought that in the case when they're *only* using it as a proxy for 
dma_alloc_from_dev_coherent() and explicitly don't want regular 
allocations from kernel memory to ever happen, then maybe it might be 
somewhat reasonable. But indeed I hadn't really given enough thought to 
the reserved-memory carveout case, where we definitely don't want to let 
a legitimate warning be hidden on a developer's machine but hit by users 
with different system configurations.

Fredrik, are you happy to fix up your driver to initialise a suitable 
mask at probe time?

Robin.
