From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC v2 4/8] iommu: Add a list of iommu_reserved_region in
	iommu_domain
Date: Thu, 10 Nov 2016 12:48:52 +0000
Message-ID: <7c6095e8-1f7c-317b-3df7-02c8a4cfe5b7@arm.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
	<1478258646-3117-5-git-send-email-eric.auger@redhat.com>
	<71bfe2a5-455e-9335-ba81-097ef24399ee@arm.com>
	<fd35f7e3-6d97-7e67-a5c5-bb633ce0e8fd@redhat.com>
	<6851a74a-775a-bd20-cdea-4cf06f5f0289@arm.com>
	<6c2e1c81-e951-a284-b547-733369128e7e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6c2e1c81-e951-a284-b547-733369128e7e-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 10/11/16 12:14, Auger Eric wrote:
> Hi Robin,
> 
> On 10/11/2016 12:54, Robin Murphy wrote:
>> Hi Eric,
>>
>> On 10/11/16 11:22, Auger Eric wrote:
>>> Hi Robin,
>>>
>>> On 04/11/2016 15:00, Robin Murphy wrote:
>>>> Hi Eric,
>>>>
>>>> Thanks for posting this new series - the bottom-up approach is a lot
>>>> easier to reason about :)
>>>>
>>>> On 04/11/16 11:24, Eric Auger wrote:
>>>>> Introduce a new iommu_reserved_region struct. This embodies
>>>>> an IOVA reserved region that cannot be used along with the IOMMU
>>>>> API. The list is protected by a dedicated mutex.
>>>>
>>>> In the light of these patches, I think I'm settling into agreement that
>>>> the iommu_domain is the sweet spot for accessing this information - the
>>>> underlying magic address ranges might be properties of various bits of
>>>> hardware many of which aren't the IOMMU itself, but they only start to
>>>> matter at the point you start wanting to use an IOMMU domain at the
>>>> higher level. Therefore, having a callback in the domain ops to pull
>>>> everything together fits rather neatly.
>>> Using get_dm_regions could have make sense but this approach now is
>>> ruled out by sysfs API approach. If attribute file is bound to be used
>>> before iommu domains are created, we cannot rely on any iommu_domain
>>> based callback. Back to square 1?
>>
>> I think it's still OK. The thing about these reserved regions is that as
>> a property of the underlying hardware they must be common to any domain
>> for a given group, therefore without loss of generality we can simply
>> query group->domain->ops->get_dm_regions(), and can expect the reserved
>> ones will be the same regardless of what domain that points to
>> (identity-mapped IVMD/RMRR/etc.
> Are they really? P2P reserved regions depend on iommu_domain right?

Indeed. To use the SMMU example, reprogramming S2CRs to target a
different context bank (i.e. attaching to a different domain) won't
affect the fact that the transactions aren't even reaching the SMMU in
the first place. That's why we need the exact same information for DMA
domains, thus why getting it for free via the dm_regions mechanism would
be really neat.

The visibility of P2P regions, doorbells, etc. for a given device is
ultimately a property of the hardware topology, and topology happens to
be what the iommu_group already represents*. There looks to be a snag
when we try to consider the addresses of such regions, since addresses
are the business of iommu_domains, not groups, but as there is a 1:1
relationship between a group and its default domain, things end up tying
together quite neatly.

Robin.

*in fact, I've just had an idea that way we check ACS paths to determine
groups might similarly be a finer-grained way to detect what P2P
regions, if any, are actually relevant.

> Now I did not consider default_domain usability, I acknowledge. I will
> send a POC anyway.
> 
>  regions may not be, but we'd be
>> filtering those out anyway). The default DMA domains need this
>> information too, and since those are allocated at group creation,
>> group->domain should always be non-NULL and interrogable.
>>
>> Plus, the groups are already there in sysfs, and, being representative
>> of device topology, would seem to be an ideal place to expose the
>> addressing limitations relevant to the devices within them. This really
>> feels like it's all falling into place (on the kernel end, at least, I'm
>> sticking to the sidelines on the userspace discussion ;)).
> 
> Thanks
> 
> Eric
>>
>> Robin.
>>
>>>
>>> Thanks
>>>
>>> Eric
>>>>
>>>>>
>>>>> An iommu domain now owns a list of those.
>>>>>
>>>>> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>>>>
>>>>> ---
>>>>> ---
>>>>>  drivers/iommu/iommu.c |  2 ++
>>>>>  include/linux/iommu.h | 17 +++++++++++++++++
>>>>>  2 files changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>>> index 9a2f196..0af07492 100644
>>>>> --- a/drivers/iommu/iommu.c
>>>>> +++ b/drivers/iommu/iommu.c
>>>>> @@ -1061,6 +1061,8 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>>>>  
>>>>>  	domain->ops  = bus->iommu_ops;
>>>>>  	domain->type = type;
>>>>> +	INIT_LIST_HEAD(&domain->reserved_regions);
>>>>> +	mutex_init(&domain->resv_mutex);
>>>>>  	/* Assume all sizes by default; the driver may override this later */
>>>>>  	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>>>>>  
>>>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>>>> index 436dc21..0f2eb64 100644
>>>>> --- a/include/linux/iommu.h
>>>>> +++ b/include/linux/iommu.h
>>>>> @@ -84,6 +84,8 @@ struct iommu_domain {
>>>>>  	void *handler_token;
>>>>>  	struct iommu_domain_geometry geometry;
>>>>>  	void *iova_cookie;
>>>>> +	struct list_head reserved_regions;
>>>>> +	struct mutex resv_mutex; /* protects the reserved region list */
>>>>>  };
>>>>>  
>>>>>  enum iommu_cap {
>>>>> @@ -131,6 +133,21 @@ struct iommu_dm_region {
>>>>>  	int			prot;
>>>>>  };
>>>>>  
>>>>> +/**
>>>>> + * struct iommu_reserved_region - descriptor for a reserved iova region
>>>>> + * @list: Linked list pointers
>>>>> + * @start: IOVA base address of the region
>>>>> + * @length: Length of the region in bytes
>>>>> + */
>>>>> +struct iommu_reserved_region {
>>>>> +	struct list_head	list;
>>>>> +	dma_addr_t		start;
>>>>> +	size_t			length;
>>>>> +};
>>>>
>>>> Looking at this in context with the dm_region above, though, I come to
>>>> the surprising realisation that these *are* dm_regions, even at the
>>>> fundamental level - on the one hand you've got physical addresses which
>>>> can't be remapped (because something is already using them), while on
>>>> the other you've got physical addresses which can't be remapped (because
>>>> the IOMMU is incapable). In fact for reserved regions *other* than our
>>>> faked-up MSI region there's no harm if the IOMMU were to actually
>>>> identity-map them.
>>>>
>>>> Let's just add this to the existing infrastructure, either with some
>>>> kind of IOMMU_NOMAP flag or simply prot = 0. That way it automatically
>>>> gets shared between the VFIO and DMA cases for free!
>>>>
>>>> Robin.
>>>>
>>>>> +
>>>>> +#define iommu_reserved_region_for_each(resv, d) \
>>>>> +	list_for_each_entry(resv, &(d)->reserved_regions, list)
>>>>> +
>>>>>  #ifdef CONFIG_IOMMU_API
>>>>>  
>>>>>  /**
>>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>
