From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [RFC v2 4/8] iommu: Add a list of iommu_reserved_region in
 iommu_domain
Date: Thu, 10 Nov 2016 12:22:26 +0100
Message-ID: <fd35f7e3-6d97-7e67-a5c5-bb633ce0e8fd@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-5-git-send-email-eric.auger@redhat.com>
 <71bfe2a5-455e-9335-ba81-097ef24399ee@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <71bfe2a5-455e-9335-ba81-097ef24399ee@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org
Cc: drjones@redhat.com, kvm@vger.kernel.org, punit.agrawal@arm.com, linux-kernel@vger.kernel.org, diana.craciun@nxp.com, iommu@lists.linux-foundation.org, pranav.sawargaonkar@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 04/11/2016 15:00, Robin Murphy wrote:
> Hi Eric,
> 
> Thanks for posting this new series - the bottom-up approach is a lot
> easier to reason about :)
> 
> On 04/11/16 11:24, Eric Auger wrote:
>> Introduce a new iommu_reserved_region struct. This embodies
>> an IOVA reserved region that cannot be used along with the IOMMU
>> API. The list is protected by a dedicated mutex.
> 
> In the light of these patches, I think I'm settling into agreement that
> the iommu_domain is the sweet spot for accessing this information - the
> underlying magic address ranges might be properties of various bits of
> hardware many of which aren't the IOMMU itself, but they only start to
> matter at the point you start wanting to use an IOMMU domain at the
> higher level. Therefore, having a callback in the domain ops to pull
> everything together fits rather neatly.
Using get_dm_regions could have make sense but this approach now is
ruled out by sysfs API approach. If attribute file is bound to be used
before iommu domains are created, we cannot rely on any iommu_domain
based callback. Back to square 1?

Thanks

Eric
> 
>>
>> An iommu domain now owns a list of those.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> ---
>>  drivers/iommu/iommu.c |  2 ++
>>  include/linux/iommu.h | 17 +++++++++++++++++
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 9a2f196..0af07492 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1061,6 +1061,8 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>  
>>  	domain->ops  = bus->iommu_ops;
>>  	domain->type = type;
>> +	INIT_LIST_HEAD(&domain->reserved_regions);
>> +	mutex_init(&domain->resv_mutex);
>>  	/* Assume all sizes by default; the driver may override this later */
>>  	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>>  
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 436dc21..0f2eb64 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -84,6 +84,8 @@ struct iommu_domain {
>>  	void *handler_token;
>>  	struct iommu_domain_geometry geometry;
>>  	void *iova_cookie;
>> +	struct list_head reserved_regions;
>> +	struct mutex resv_mutex; /* protects the reserved region list */
>>  };
>>  
>>  enum iommu_cap {
>> @@ -131,6 +133,21 @@ struct iommu_dm_region {
>>  	int			prot;
>>  };
>>  
>> +/**
>> + * struct iommu_reserved_region - descriptor for a reserved iova region
>> + * @list: Linked list pointers
>> + * @start: IOVA base address of the region
>> + * @length: Length of the region in bytes
>> + */
>> +struct iommu_reserved_region {
>> +	struct list_head	list;
>> +	dma_addr_t		start;
>> +	size_t			length;
>> +};
> 
> Looking at this in context with the dm_region above, though, I come to
> the surprising realisation that these *are* dm_regions, even at the
> fundamental level - on the one hand you've got physical addresses which
> can't be remapped (because something is already using them), while on
> the other you've got physical addresses which can't be remapped (because
> the IOMMU is incapable). In fact for reserved regions *other* than our
> faked-up MSI region there's no harm if the IOMMU were to actually
> identity-map them.
> 
> Let's just add this to the existing infrastructure, either with some
> kind of IOMMU_NOMAP flag or simply prot = 0. That way it automatically
> gets shared between the VFIO and DMA cases for free!
> 
> Robin.
> 
>> +
>> +#define iommu_reserved_region_for_each(resv, d) \
>> +	list_for_each_entry(resv, &(d)->reserved_regions, list)
>> +
>>  #ifdef CONFIG_IOMMU_API
>>  
>>  /**
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
