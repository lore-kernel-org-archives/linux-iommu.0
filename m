From: "Nath, Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] iommu/amd: flush IOTLB for specific domains only
Date: Thu, 30 Mar 2017 06:23:13 +0000
Message-ID: <MWHPR12MB15186B0A864F247BFBEF8EAD9C340@MWHPR12MB1518.namprd12.prod.outlook.com>
References: <20170322112242.GK29659@8bytes.org>
	<1490595427-11979-1-git-send-email-arindam.nath@amd.com>
	<CAD8Lp46RjsUJEvCR5qVY6p8za5H9iDGTAyJMDd1zO7gbgBvqfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
To: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Cc: "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

>-----Original Message-----
>From: Nath, Arindam
>Sent: Monday, March 27, 2017 5:57 PM
>To: 'Daniel Drake'
>Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; Deucher, Alexander; Bridgman, John; amd-
>gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Suthikulpanit,
>Suravee; Linux Upstreaming Team
>Subject: RE: [PATCH] iommu/amd: flush IOTLB for specific domains only
>
>>-----Original Message-----
>>From: Daniel Drake [mailto:drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org]
>>Sent: Monday, March 27, 2017 5:56 PM
>>To: Nath, Arindam
>>Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; Deucher, Alexander; Bridgman, John; amd-
>>gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Suthikulpanit,
>>Suravee; Linux Upstreaming Team
>>Subject: Re: [PATCH] iommu/amd: flush IOTLB for specific domains only
>>
>>Hi Arindam,
>>
>>You CC'd me on this - does this mean that it is a fix for the issue
>>described in the thread "amd-iommu: can't boot with amdgpu, AMD-Vi:
>>Completion-Wait loop timed out" ?
>
>Yes Daniel, please test this patch to confirm if the issue gets resolved.

Daniel, did you get chance to test this patch?

Thanks,
Arindam

>
>Thanks,
>Arindam
>
>>
>>Thanks
>>Daniel
>>
>>
>>On Mon, Mar 27, 2017 at 12:17 AM,  <arindam.nath-5C7GfCeVMHo@public.gmane.org> wrote:
>>> From: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
>>>
>>> The idea behind flush queues is to defer the IOTLB flushing
>>> for domains for which the mappings are no longer valid. We
>>> add such domains in queue_add(), and when the queue size
>>> reaches FLUSH_QUEUE_SIZE, we perform __queue_flush().
>>>
>>> Since we have already taken lock before __queue_flush()
>>> is called, we need to make sure the IOTLB flushing is
>>> performed as quickly as possible.
>>>
>>> In the current implementation, we perform IOTLB flushing
>>> for all domains irrespective of which ones were actually
>>> added in the flush queue initially. This can be quite
>>> expensive especially for domains for which unmapping is
>>> not required at this point of time.
>>>
>>> This patch makes use of domain information in
>>> 'struct flush_queue_entry' to make sure we only flush
>>> IOTLBs for domains who need it, skipping others.
>>>
>>> Signed-off-by: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>  drivers/iommu/amd_iommu.c | 15 ++++++++-------
>>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>>> index 98940d1..6a9a048 100644
>>> --- a/drivers/iommu/amd_iommu.c
>>> +++ b/drivers/iommu/amd_iommu.c
>>> @@ -2227,15 +2227,16 @@ static struct iommu_group
>>*amd_iommu_device_group(struct device *dev)
>>>
>>>  static void __queue_flush(struct flush_queue *queue)
>>>  {
>>> -       struct protection_domain *domain;
>>> -       unsigned long flags;
>>>         int idx;
>>>
>>> -       /* First flush TLB of all known domains */
>>> -       spin_lock_irqsave(&amd_iommu_pd_lock, flags);
>>> -       list_for_each_entry(domain, &amd_iommu_pd_list, list)
>>> -               domain_flush_tlb(domain);
>>> -       spin_unlock_irqrestore(&amd_iommu_pd_lock, flags);
>>> +       /* First flush TLB of all domains which were added to flush queue */
>>> +       for (idx = 0; idx < queue->next; ++idx) {
>>> +               struct flush_queue_entry *entry;
>>> +
>>> +               entry = queue->entries + idx;
>>> +
>>> +               domain_flush_tlb(&entry->dma_dom->domain);
>>> +       }
>>>
>>>         /* Wait until flushes have completed */
>>>         domain_flush_complete(NULL);
>>> --
>>> 1.9.1
>>>
