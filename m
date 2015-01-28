From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu: Allocate a default domain for iommu groups
Date: Wed, 28 Jan 2015 15:11:03 +0000
Message-ID: <54C8FC07.2050003@arm.com>
References: <1422317339-22620-1-git-send-email-joro@8bytes.org>
	<1422317339-22620-3-git-send-email-joro@8bytes.org>
	<20150128143006.GQ1569@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150128143006.GQ1569-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 28/01/15 14:30, Will Deacon wrote:
> On Tue, Jan 27, 2015 at 12:08:56AM +0000, Joerg Roedel wrote:
>> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>>
>> The default domain will be used (if supported by the iommu
>> driver) when the devices in the iommu group are not attached
>> to any other domain.
>>
>> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>> ---
>>   drivers/iommu/iommu.c | 26 +++++++++++++++++++++++---
>>   1 file changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 34636eb..8f33ddd3 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -76,6 +76,9 @@ struct iommu_group_attribute iommu_group_attr_##_name =		\
>>   #define to_iommu_group(_kobj)		\
>>   	container_of(_kobj, struct iommu_group, kobj)
>>
>> +static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>> +						 enum iommu_domain_type type);
>> +
>>   static ssize_t iommu_group_attr_show(struct kobject *kobj,
>>   				     struct attribute *__attr, char *buf)
>>   {
>> @@ -362,6 +365,17 @@ rename:
>>
>>   	kobject_get(group->devices_kobj);
>>
>> +	/*
>> +	 * Try to allocate a default domain for the group, if this
>> +	 * hasn't happened yet. This is not the best place to do that,
>> +	 * it should happen in iommu_group_alloc(). But we have no
>> +	 * iommu_ops there yet, so the allocation has to happen here for
>> +	 * now.
>> +	 */
>> +	if (group->default_domain == NULL)
>> +		group->default_domain = __iommu_domain_alloc(dev->bus,
>> +							     IOMMU_DOMAIN_DMA);
>
> Having a per-group domain is wasteful for IOMMUs that only support a modest
> number of concurrent domains, so in reality I think we need to have one
> domain per IOMMU instance. Is that possible?

Strictly speaking, it is, provided you can identify instances (I've 
hacked up such a thing controlled from the DMA mapping side), but 
there's a question of how to handle devices with differing DMA ranges. 
The Intel IOVA allocator could actually handle them sharing one address 
space, since you can perform individual allocations with different 
constraints, but I'm not sure if that really makes sense. Perhaps one 
domain per dma-ranges variation per instance?

> One problem with the current per-bus approach is that __iommu_domain_alloc
> can't figure out which IOMMU instance corresponds to the group.

Indeed - I think it might make sense to pass devices around instead of 
buses, and for now stick in an abstraction like:

static const struct iommu_ops *get_iommu_for_dev(struct device *dev)
{
	return dev->bus->iommu_ops;
}

in which we can then later hook up some sort of of_iommu_get_ops-based 
lookup for non-PCI devices. Which ends up more or less looking like 
Thierry's original idea, but kept private to the IOMMU API internals.

Robin.
