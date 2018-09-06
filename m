From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH v2 02/10] iommu/vt-d: Add multiple domains per device
	query
Date: Thu, 6 Sep 2018 08:54:02 +0800
Message-ID: <ab3262a3-ab50-c107-e63f-17d17754c539@linux.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
	<20180830040922.30426-3-baolu.lu@linux.intel.com>
	<20180905133540.5d7a7ea3@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180905133540.5d7a7ea3-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 09/06/2018 03:35 AM, Alex Williamson wrote:
> On Thu, 30 Aug 2018 12:09:14 +0800
> Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> 
>> Add the response to IOMMU_CAP_AUX_DOMAIN capability query
>> through iommu_capable(). Return true if IOMMUs support the
>> scalable mode, return false otherwise.
>>
>> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>   drivers/iommu/intel-iommu.c | 31 +++++++++++++++++++++++++++++--
>>   1 file changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 3e49d4029058..891ae70e7bf2 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -5193,12 +5193,39 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
>>   	return phys;
>>   }
>>   
>> +static inline bool scalable_mode_support(void)
>> +{
>> +	struct dmar_drhd_unit *drhd;
>> +	struct intel_iommu *iommu;
>> +	bool ret = true;
>> +
>> +	rcu_read_lock();
>> +	for_each_active_iommu(iommu, drhd) {
>> +		if (!sm_supported(iommu)) {
>> +			ret = false;
>> +			break;
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	return ret;
>> +}
>> +
>>   static bool intel_iommu_capable(enum iommu_cap cap)
>>   {
>> -	if (cap == IOMMU_CAP_CACHE_COHERENCY)
>> +	switch (cap) {
>> +	case IOMMU_CAP_CACHE_COHERENCY:
>>   		return domain_update_iommu_snooping(NULL) == 1;
>> -	if (cap == IOMMU_CAP_INTR_REMAP)
>> +	case IOMMU_CAP_INTR_REMAP:
>>   		return irq_remapping_enabled == 1;
>> +	case IOMMU_CAP_AUX_DOMAIN:
>> +		return scalable_mode_support();
>> +	case IOMMU_CAP_NOEXEC:
>> +	/* PASSTHROUGH */
>> +	default:
>> +		pr_info("Unsupported capability query %d\n", cap);
>> +		break;
> 
> Please don't do this, there's no reason to be noisy about a query of a
> capability that VT-d doesn't know about.  We implement capabilities
> exactly so that relevant drivers can expose a feature and others can
> happily (and quietly) ignore them.  Thanks,

Fair enough. I will remove it in the next version.

Best regards,
Lu Baolu
