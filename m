From: "Nath, Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] iommu/amd: flush IOTLB for specific domains only (v2)
Date: Sun, 21 May 2017 07:25:27 +0000
Message-ID: <MWHPR12MB1518FD4897E89DB7165978879CFB0@MWHPR12MB1518.namprd12.prod.outlook.com>
References: <20170407102039.GW7266@8bytes.org>
	<1495188151-14358-1-git-send-email-arindam.nath@amd.com>
	<1495200930.4360.6.camel@rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1495200930.4360.6.camel-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
	Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org" <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Craig Stein <stein12c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher,
	Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org" <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, "michel-otUistvHUpPR7s880joybQ@public.gmane.org" <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

>-----Original Message-----
>From: Jan Vesely [mailto:jv356-nChP9VK/LToysehGhLVACCmkPJUwDNjP@public.gmane.org] On Behalf Of Jan
>Vesely
>Sent: Friday, May 19, 2017 7:06 PM
>To: Nath, Arindam; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>Cc: Bridgman, John; Joerg Roedel; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org;
>drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org; Craig Stein; Suthikulpanit, Suravee; Deucher,
>Alexander; Kuehling, Felix; linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org; michel-otUistvHUpPR7s880joybQ@public.gmane.org
>Subject: Re: [PATCH] iommu/amd: flush IOTLB for specific domains only (v2)
>
>On Fri, 2017-05-19 at 15:32 +0530, arindam.nath-5C7GfCeVMHo@public.gmane.org wrote:
>> From: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
>>
>> Change History
>> --------------
>>
>> v2: changes suggested by Joerg
>> - add flush flag to improve efficiency of flush operation

Joerg, do you have any comments on the patch?

Thanks,
Arindam

>>
>> v1:
>> - The idea behind flush queues is to defer the IOTLB flushing
>>   for domains for which the mappings are no longer valid. We
>>   add such domains in queue_add(), and when the queue size
>>   reaches FLUSH_QUEUE_SIZE, we perform __queue_flush().
>>
>>   Since we have already taken lock before __queue_flush()
>>   is called, we need to make sure the IOTLB flushing is
>>   performed as quickly as possible.
>>
>>   In the current implementation, we perform IOTLB flushing
>>   for all domains irrespective of which ones were actually
>>   added in the flush queue initially. This can be quite
>>   expensive especially for domains for which unmapping is
>>   not required at this point of time.
>>
>>   This patch makes use of domain information in
>>   'struct flush_queue_entry' to make sure we only flush
>>   IOTLBs for domains who need it, skipping others.
>
>Hi,
>
>just a note, the patch also fixes "AMD-Vi: Completion-Wait loop timed
>out" boot hang on my system (carrizo + iceland) [0,1,2]. Presumably the
>old loop also tried to flush domains that included powered-off devices.
>
>regards,
>Jan
>
>[0] https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/issues/20
>[1] https://bugs.freedesktop.org/show_bug.cgi?id=101029
>[2] https://bugzilla.redhat.com/show_bug.cgi?id=1448121
>
>>
>> Suggested-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
>> ---
>>  drivers/iommu/amd_iommu.c       | 27 ++++++++++++++++++++-------
>>  drivers/iommu/amd_iommu_types.h |  2 ++
>>  2 files changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>> index 63cacf5..1edeebec 100644
>> --- a/drivers/iommu/amd_iommu.c
>> +++ b/drivers/iommu/amd_iommu.c
>> @@ -2227,15 +2227,26 @@ static struct iommu_group
>*amd_iommu_device_group(struct device *dev)
>>
>>  static void __queue_flush(struct flush_queue *queue)
>>  {
>> -	struct protection_domain *domain;
>> -	unsigned long flags;
>>  	int idx;
>>
>> -	/* First flush TLB of all known domains */
>> -	spin_lock_irqsave(&amd_iommu_pd_lock, flags);
>> -	list_for_each_entry(domain, &amd_iommu_pd_list, list)
>> -		domain_flush_tlb(domain);
>> -	spin_unlock_irqrestore(&amd_iommu_pd_lock, flags);
>> +	/* First flush TLB of all domains which were added to flush queue */
>> +	for (idx = 0; idx < queue->next; ++idx) {
>> +		struct flush_queue_entry *entry;
>> +
>> +		entry = queue->entries + idx;
>> +
>> +		/*
>> +		 * There might be cases where multiple IOVA entries for the
>> +		 * same domain are queued in the flush queue. To avoid
>> +		 * flushing the same domain again, we check whether the
>> +		 * flag is set or not. This improves the efficiency of
>> +		 * flush operation.
>> +		 */
>> +		if (!entry->dma_dom->domain.already_flushed) {
>> +			entry->dma_dom->domain.already_flushed = true;
>> +			domain_flush_tlb(&entry->dma_dom->domain);
>> +		}
>> +	}
>>
>>  	/* Wait until flushes have completed */
>>  	domain_flush_complete(NULL);
>> @@ -2289,6 +2300,8 @@ static void queue_add(struct dma_ops_domain
>*dma_dom,
>>  	pages     = __roundup_pow_of_two(pages);
>>  	address >>= PAGE_SHIFT;
>>
>> +	dma_dom->domain.already_flushed = false;
>> +
>>  	queue = get_cpu_ptr(&flush_queue);
>>  	spin_lock_irqsave(&queue->lock, flags);
>>
>> diff --git a/drivers/iommu/amd_iommu_types.h
>b/drivers/iommu/amd_iommu_types.h
>> index 4de8f41..4f5519d 100644
>> --- a/drivers/iommu/amd_iommu_types.h
>> +++ b/drivers/iommu/amd_iommu_types.h
>> @@ -454,6 +454,8 @@ struct protection_domain {
>>  	bool updated;		/* complete domain flush required */
>>  	unsigned dev_cnt;	/* devices assigned to this domain */
>>  	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference
>count */
>> +	bool already_flushed;	/* flag to avoid flushing the same domain
>again
>> +				   in a single invocation of __queue_flush() */
>>  };
>>
>>  /*
>
>--
>Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
