From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v13 11/15] vfio/type1: Handle unmap/unpin and replay for
	VFIO_IOVA_RESERVED slots
Date: Fri, 7 Oct 2016 19:11:55 +0200
Message-ID: <5fe76a21-15d5-61e3-21c9-33046592a04c@redhat.com>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
	<1475743531-4780-12-git-send-email-eric.auger@redhat.com>
	<20161006141918.67928391@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161006141918.67928391-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
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
Cc: yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

On 06/10/2016 22:19, Alex Williamson wrote:
> On Thu,  6 Oct 2016 08:45:27 +0000
> Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
>> Before allowing the end-user to create VFIO_IOVA_RESERVED dma slots,
>> let's implement the expected behavior for removal and replay.
>>
>> As opposed to user dma slots, reserved IOVAs are not systematically bound
>> to PAs and PAs are not pinned. VFIO just initializes the IOVA "aperture".
>> IOVAs are allocated outside of the VFIO framework, by the MSI layer which
>> is responsible to free and unmap them. The MSI mapping resources are freeed
> 
> nit, extra 'e', "freed"
> 
>> by the IOMMU driver on domain destruction.
>>
>> On the creation of a new domain, the "replay" of a reserved slot simply
>> needs to set the MSI aperture on the new domain.
>>
>> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>
>> ---
>> v12 -> v13:
>> - use dma-iommu iommu_get_dma_msi_region_cookie
>>
>> v9 -> v10:
>> - replay of a reserved slot sets the MSI aperture on the new domain
>> - use VFIO_IOVA_RESERVED_MSI enum value instead of VFIO_IOVA_RESERVED
>>
>> v7 -> v8:
>> - do no destroy anything anymore, just bypass unmap/unpin and iommu_map
>>   on replay
>> ---
>>  drivers/vfio/Kconfig            |  1 +
>>  drivers/vfio/vfio_iommu_type1.c | 10 +++++++++-
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
>> index da6e2ce..673ec79 100644
>> --- a/drivers/vfio/Kconfig
>> +++ b/drivers/vfio/Kconfig
>> @@ -1,6 +1,7 @@
>>  config VFIO_IOMMU_TYPE1
>>  	tristate
>>  	depends on VFIO
>> +	select IOMMU_DMA
>>  	default n
>>  
>>  config VFIO_IOMMU_SPAPR_TCE
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 65a4038..5bc5fc9 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -36,6 +36,7 @@
>>  #include <linux/uaccess.h>
>>  #include <linux/vfio.h>
>>  #include <linux/workqueue.h>
>> +#include <linux/dma-iommu.h>
>>  
>>  #define DRIVER_VERSION  "0.2"
>>  #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>"
>> @@ -387,7 +388,7 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
>>  	struct vfio_domain *domain, *d;
>>  	long unlocked = 0;
>>  
>> -	if (!dma->size)
>> +	if (!dma->size || dma->type != VFIO_IOVA_USER)
>>  		return;
>>  	/*
>>  	 * We use the IOMMU to track the physical addresses, otherwise we'd
>> @@ -724,6 +725,13 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
>>  		dma = rb_entry(n, struct vfio_dma, node);
>>  		iova = dma->iova;
>>  
>> +		if (dma->type == VFIO_IOVA_RESERVED_MSI) {
>> +			ret = iommu_get_dma_msi_region_cookie(domain->domain,
>> +						     dma->iova, dma->size);
>> +			WARN_ON(ret);
>> +			continue;
>> +		}
> 
> Why is this a passable error?  We consider an iommu_map() error on any
> entry a failure.
Yes I agree.

Thanks

Eric
> 
>> +
>>  		while (iova < dma->iova + dma->size) {
>>  			phys_addr_t phys = iommu_iova_to_phys(d->domain, iova);
>>  			size_t size;
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
