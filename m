From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 3/7] vfio/type1: bypass unmap/unpin and replay for
	VFIO_IOVA_RESERVED slots
Date: Wed, 11 May 2016 14:58:14 +0200
Message-ID: <57332C66.30105@linaro.org>
References: <1462362858-2925-1-git-send-email-eric.auger@linaro.org>
	<1462362858-2925-4-git-send-email-eric.auger@linaro.org>
	<20160509164936.1a5ae402@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160509164936.1a5ae402-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, eric.auger-qxv4g6HH51o@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Alex,
On 05/10/2016 12:49 AM, Alex Williamson wrote:
> On Wed,  4 May 2016 11:54:14 +0000
> Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> 
>> Before allowing the end-user to create VFIO_IOVA_RESERVED dma slots,
>> let's implement the expected behavior for removal and replay. As opposed
>> to user dma slots, IOVAs are not systematically bound to PAs and PAs are
>> not pinned. VFIO just initializes the IOVA "aperture". IOVAs are allocated
>> outside of the VFIO framework, typically the MSI layer which is
>> responsible to free and unmap them. The MSI mapping resources are freeed
>> by the IOMMU driver on domain destruction.
>>
>> Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> ---
>>
>> v7 -> v8:
>> - do no destroy anything anymore, just bypass unmap/unpin and iommu_map
>>   on replay
>> ---
>>  drivers/vfio/vfio_iommu_type1.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 2d769d4..94a9916 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -391,7 +391,7 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
>>  	struct vfio_domain *domain, *d;
>>  	long unlocked = 0;
>>  
>> -	if (!dma->size)
>> +	if (!dma->size || dma->type != VFIO_IOVA_USER)
>>  		return;
>>  	/*
>>  	 * We use the IOMMU to track the physical addresses, otherwise we'd
>> @@ -727,6 +727,9 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
>>  		dma = rb_entry(n, struct vfio_dma, node);
>>  		iova = dma->iova;
>>  
>> +		if (dma->type == VFIO_IOVA_RESERVED)
>> +			continue;
>> +
> 
> But you do still need some sort of replay mechanism, right?  Not to
> replay the IOVA to PA mapping, but to call iommu_msi_set_aperture() for
> the new domain.  How will you know that this entry is an MSI reserved
> range or something else?  Perhaps we can't have a generic "reserved"
> type here.
Thanks for spotting this bug. I was not testing this case yet and
effectively I need to replay the set_aperture.

Thanks for the review

Best Regards

Eric

> 
>>  		while (iova < dma->iova + dma->size) {
>>  			phys_addr_t phys = iommu_iova_to_phys(d->domain, iova);
>>  			size_t size;
> 
