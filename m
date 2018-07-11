From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 9/9] iommu/vt-d: Remove the obsolete per iommu pasid
	tables
Date: Wed, 11 Jul 2018 14:43:51 +0800
Message-ID: <5B45A727.3080801@linux.intel.com>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
	<1531113778-28238-10-git-send-email-baolu.lu@linux.intel.com>
	<20180711024506.GB2359@xz-mi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180711024506.GB2359@xz-mi>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Peter,

On 07/11/2018 10:45 AM, Peter Xu wrote:
> On Mon, Jul 09, 2018 at 01:22:58PM +0800, Lu Baolu wrote:
>> The obsolete per iommu pasid tables are no longer used. Hence,
>> clean up them.
>>
>> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Reviewed-by: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/iommu/intel-iommu.c |  6 +++---
>>  drivers/iommu/intel-svm.c   | 17 ++---------------
>>  include/linux/intel-iommu.h |  5 ++---
>>  3 files changed, 7 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index f8609b5..9a88081 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -1755,7 +1755,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
>>  	if (pasid_enabled(iommu)) {
>>  		if (ecap_prs(iommu->ecap))
>>  			intel_svm_finish_prq(iommu);
>> -		intel_svm_free_pasid_tables(iommu);
>> +		intel_svm_exit(iommu);
>>  	}
>>  #endif
>>  }
>> @@ -3336,7 +3336,7 @@ static int __init init_dmars(void)
>>  			hw_pass_through = 0;
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>  		if (pasid_enabled(iommu))
>> -			intel_svm_alloc_pasid_tables(iommu);
>> +			intel_svm_init(iommu);
>>  #endif
>>  	}
>>  
>> @@ -4330,7 +4330,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>>  
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>  	if (pasid_enabled(iommu))
>> -		intel_svm_alloc_pasid_tables(iommu);
>> +		intel_svm_init(iommu);
>>  #endif
>>  
>>  	if (dmaru->ignored) {
>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>> index a253cde..eb30836 100644
>> --- a/drivers/iommu/intel-svm.c
>> +++ b/drivers/iommu/intel-svm.c
>> @@ -38,7 +38,7 @@ struct pasid_state_entry {
>>  	u64 val;
>>  };
>>  
>> -int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>> +int intel_svm_init(struct intel_iommu *iommu)
>>  {
>>  	struct page *pages;
>>  	int order;
>> @@ -63,15 +63,6 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>>  		iommu->pasid_max = 0x20000;
>>  
>>  	order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
>> -	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
>> -	if (!pages) {
>> -		pr_warn("IOMMU: %s: Failed to allocate PASID table\n",
>> -			iommu->name);
>> -		return -ENOMEM;
>> -	}
>> -	iommu->pasid_table = page_address(pages);
>> -	pr_info("%s: Allocated order %d PASID table.\n", iommu->name, order);
>> -
>>  	if (ecap_dis(iommu->ecap)) {
>>  		/* Just making it explicit... */
>>  		BUILD_BUG_ON(sizeof(struct pasid_entry) != sizeof(struct pasid_state_entry));
> Then do we still need the so-called pasid state table?  I tried to
> find out what it did before but I failed since I see that the bit 27
> of the extended cap is marked as reserved now in the latest vt-d spec
> (then ecap_dis could be meaningless too).
>
> Asked since if we don't need both the per-iommu pasid table and the
> pasid state table, then maybe we don't need intel_svm_init() at all?
>
>> @@ -86,14 +77,10 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>>  	return 0;
>>  }
>>  
>> -int intel_svm_free_pasid_tables(struct intel_iommu *iommu)
>> +int intel_svm_exit(struct intel_iommu *iommu)
> Same thing applies to this exit() function - after we removed the
> per-iommu idr, per-iommu pasid table, and (possibly obsolete)
> per-iommu pasid state table, do we need that at all?
>
> Thanks,
>

Good eyes!

Yes, we will cleanup this with a following patch series which enables
features defined in the vt-d v3.0.

Best regards,
Lu Baolu
