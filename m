From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v14 04/16] iommu/dma: MSI doorbell alloc/free
Date: Mon, 17 Oct 2016 16:25:36 +0200
Message-ID: <422b6060-3c58-0bd3-b0ee-78803b5da7fc@redhat.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
	<1476278544-3397-5-git-send-email-eric.auger@redhat.com>
	<87lgxrqijs.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <87lgxrqijs.fsf-Z9gB6HwUD+TZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Cc: yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Punit,

On 14/10/2016 13:25, Punit Agrawal wrote:
> Hi Eric,
> 
> One query and a comment below.
> 
> Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> writes:
> 
>> We introduce the capability to (un)register MSI doorbells.
>>
>> A doorbell region is characterized by its physical address base, size,
>> and whether it its safe (ie. it implements IRQ remapping). A doorbell
>> can be per-cpu or global. We currently only care about global doorbells.
>>
>> A function returns whether all registered doorbells are safe.
>>
>> MSI controllers likely to work along with IOMMU that translate MSI
>> transaction must register their doorbells to allow device assignment
>> with MSI support.  Otherwise the MSI transactions will cause IOMMU faults.
>>
>> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>
>> ---
>>
>> v13 -> v14:
>> - previously in msi-doorbell.h/c
>> ---
>>  drivers/iommu/dma-iommu.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/dma-iommu.h | 41 ++++++++++++++++++++++++++
>>  2 files changed, 116 insertions(+)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index d45f9a0..d8a7d86 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -43,6 +43,38 @@ struct iommu_dma_cookie {
>>  	spinlock_t		msi_lock;
>>  };
>>  
>> +/**
>> + * struct iommu_msi_doorbell_info - MSI doorbell region descriptor
>> + * @percpu_doorbells: per cpu doorbell base address
>> + * @global_doorbell: base address of the doorbell
>> + * @doorbell_is_percpu: is the doorbell per cpu or global?
>> + * @safe: true if irq remapping is implemented
>> + * @size: size of the doorbell
>> + */
>> +struct iommu_msi_doorbell_info {
>> +	union {
>> +		phys_addr_t __percpu    *percpu_doorbells;
> 
> Out of curiosity, have you come across systems that have per-cpu
> doorbells? I couldn't find a system that'd help solidify my
> understanding on it's usage.

This came out after a discussion With Marc. However at the moment I am
not aware of any MSI controller featuring per-cpu doorbell. Not sure
whether it stays relevant to keep this notion at that stage.

> 
>> +		phys_addr_t             global_doorbell;
>> +	};
>> +	bool    doorbell_is_percpu;
>> +	bool    safe;
> 
> Although you've got the comment above, 'safe' doesn't quite convey it's
> purpose. Can this be renamed to something more descriptive -
> 'intr_remapping' or 'intr_isolation' perhaps?

Yes definitively

Thanks

Eric
> 
> Thanks,
> Punit
> 
> 
> [...]
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
