From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: Question on iommu_get_domain_for_dev() for DMA map/unmap
Date: Tue, 14 Aug 2018 12:07:52 +0100
Message-ID: <52c43ee9-c0f7-8348-809c-b6a02e14a042@huawei.com>
References: <6ddbe8b7-887e-0bf8-b76e-77b3a9a2fcac@huawei.com>
	<6a713c3a-a305-a4f8-4618-8162a7b6327e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6a713c3a-a305-a4f8-4618-8162a7b6327e-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Guohanjun (Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 14/08/2018 11:45, Robin Murphy wrote:
> Hi John,
>

Hi Robin,

> On 14/08/18 11:09, John Garry wrote:
>> Hi All,
>>
>> I have a question on function iommu_get_domain_for_dev() in DMA
>> mapping path, and why we need to get+put a reference to the iommu group.
>>
>> The background is that we have been testing iperf throughput
>> performance for a PCIe NIC card behind an SMMUv3, with small packets
>> and many threads (128) on a system with a lot cores (>64).
>>
>> We find that the reference counting on the iommu group in
>> iommu_dma_map_sg()->iommu_get_domain_for_dev()->kobject_get()/put() is
>> a big bottleneck. There is much contention on getting and putting the
>> reference to iommu_group.device_kobj.
>>
>> The question is do we actually need to get+put this reference for DMA
>> map/unmap, since the device already takes a reference to the
>> iommu_group.device_kobj when attached to the group? Is it to protect
>> against the device being removed and the group being freed as it is
>> dereferenced? If so, I would say it's not safe to reference the
>> associated iommu domain thereafter in the DMA map/unmap, as it would
>> be freed along with the iommu group.

Thanks for getting back to me.

>
> Yes, I agree that the reference is something we don't strictly need - if
> the group disappears while the device is in the middle of DMA things are
> beyond broken. However, the problem for iommu-dma as "generic" code was
> that since dev->iommu_group is opaque, there was no other way to
> actually retrieve the domain pointer.
>
> Now that hardware exists to show a real and measurable impact it
> probably is time to revisit this. I have an idea for what I think is a
> reasonable patch - let me throw that together...
>

So we had some patches floating around internally to work around this 
ref counting bottleneck by using RCU or per-cpu refcount, and they did 
improve performance considerably. I did like them so much, as they kept 
the same fundamental functionality.

Anyway we would appreciate any patch and test it.

> Robin.

All the best,
John

>
> .
>
