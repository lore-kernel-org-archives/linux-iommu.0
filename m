From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 15/23] iommu: handle page response timeout
Date: Wed, 30 May 2018 15:46:00 +0800
Message-ID: <5B0E56B8.3010606@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <5AF93E3A.2040902@linux.intel.com> <20180529092058.1942b223@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529092058.1942b223@jacob-builder>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 05/30/2018 12:20 AM, Jacob Pan wrote:
> On Mon, 14 May 2018 15:43:54 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
>> Hi,
>>
>> On 05/12/2018 04:54 AM, Jacob Pan wrote:
>>> When IO page faults are reported outside IOMMU subsystem, the page
>>> request handler may fail for various reasons. E.g. a guest received
>>> page requests but did not have a chance to run for a long time. The
>>> irresponsive behavior could hold off limited resources on the
>>> pending device.
>>> There can be hardware or credit based software solutions as
>>> suggested in the PCI ATS Ch-4. To provide a basic safty net this
>>> patch introduces a per device deferrable timer which monitors the
>>> longest pending page fault that requires a response. Proper action
>>> such as sending failure response code could be taken when timer
>>> expires but not included in this patch. We need to consider the
>>> life cycle of page groupd ID to prevent confusion with reused group
>>> ID by a device. For now, a warning message provides clue of such
>>> failure.
>>>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>>> ---
>>>  drivers/iommu/iommu.c | 53
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>> include/linux/iommu.h |  4 ++++ 2 files changed, 57 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 02fed3e..1f2f49e 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -827,6 +827,37 @@ int iommu_group_unregister_notifier(struct
>>> iommu_group *group, }
>>>  EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
>>>  
>>> +static void iommu_dev_fault_timer_fn(struct timer_list *t)
>>> +{
>>> +	struct iommu_fault_param *fparam = from_timer(fparam, t,
>>> timer);
>>> +	struct iommu_fault_event *evt;
>>> +
>>> +	u64 now;
>>> +
>>> +	now = get_jiffies_64();
>>> +
>>> +	/* The goal is to ensure driver or guest page fault
>>> handler(via vfio)
>>> +	 * send page response on time. Otherwise, limited queue
>>> resources
>>> +	 * may be occupied by some irresponsive guests or drivers.
>>> +	 * When per device pending fault list is not empty, we
>>> periodically checks
>>> +	 * if any anticipated page response time has expired.
>>> +	 *
>>> +	 * TODO:
>>> +	 * We could do the following if response time expires:
>>> +	 * 1. send page response code FAILURE to all pending PRQ
>>> +	 * 2. inform device driver or vfio
>>> +	 * 3. drain in-flight page requests and responses for this
>>> device
>>> +	 * 4. clear pending fault list such that driver can
>>> unregister fault
>>> +	 *    handler(otherwise blocked when pending faults are
>>> present).
>>> +	 */
>>> +	list_for_each_entry(evt, &fparam->faults, list) {
>>> +		if (time_after64(now, evt->expire))
>>> +			pr_err("Page response time expired!, pasid
>>> %d gid %d exp %llu now %llu\n",
>>> +				evt->pasid,
>>> evt->page_req_group_id, evt->expire, now);
>>> +	}
>>> +	mod_timer(t, now + prq_timeout);
>>> +}
>>> +  
>> This timer scheme is very rough.
>>
> yes, the timer is a rough safety net for misbehaved PRQ handlers such
> as a guest.
>> The timer expires every 10 seconds (by default).
>>
>> 0                   10                 20
>> 30                 40
>> +---------------+---------------+---------------+---------------+ ^
>> ^   ^  ^                        ^ |   |     |
>> |                         | F0 F1  F2 F3
>> (F1,F2,F3 will not be handled until here!)
>>
>> F0, F1, F2, F3 are four page faults happens during [0, 10s) time
>> window. F1, F2, F3 timeout won't be handled until the timer expires
>> again at 20s. That means a fault might be pending there until about
>> (2 * prq_timeout) seconds later.
>>
> correct. it could be 2x for the worst case. I should explain in
> comments.
>> Out of curiosity, Why not adding a timer in iommu_fault_event,
>> starting it in iommu_report_device_fault() and removing it in
>> iommu_page_response()?
>>
> I thought about that also but since we are just trying to have a broad
> and rough safety net (in addition to potential HW mechanism or credit
> based solution), my thought was that having a per device timer is more
> economical than per event.
> Thanks for the in-depth check!

Okay,  got your idea. Thanks for explanation.

Best regards,
Lu Baolu
