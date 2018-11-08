From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 05/12] iommu/vt-d: Reserve a domain id for FL and PT
	modes
Date: Thu, 8 Nov 2018 10:22:14 +0800
Message-ID: <855f56ac-80be-8179-ba99-45ef99ccb87f@linux.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
	<20181105053151.7173-6-baolu.lu@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439D5FAE7@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D5FAE7-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 11/7/18 2:55 PM, Liu, Yi L wrote:
> Hi Baolu,
> 
>> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
>> Sent: Monday, November 5, 2018 1:32 PM
>> Subject: [PATCH v4 05/12] iommu/vt-d: Reserve a domain id for FL and PT modes
>>
>> Vt-d spec rev3.0 (section 6.2.3.1) requires that each pasid
>> entry for first-level or pass-through translation should be
>> programmed with a domain id different from those used for
>> second-level or nested translation. It is recommended that
>> software could use a same domain id for all first-only and
>> pass-through translations.
>>
>> This reserves a domain id for first-level and pass-through
>> translations.
>>
>> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Sanjay Kumar <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>   drivers/iommu/intel-iommu.c | 10 ++++++++++
>>   drivers/iommu/intel-pasid.h |  6 ++++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 9331240c70b8..2f7455ee4e7a 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -1618,6 +1618,16 @@ static int iommu_init_domains(struct intel_iommu
>> *iommu)
>>   	 */
>>   	set_bit(0, iommu->domain_ids);
>>
>> +	/*
>> +	 * Vt-d spec rev3.0 (section 6.2.3.1) requires that each pasid
>> +	 * entry for first-level or pass-through translation modes should
>> +	 * be programmed with a domain id different from those used for
>> +	 * second-level or nested translation. We reserve a domain id for
>> +	 * this purpose.
>> +	 */
>> +	if (sm_supported(iommu))
>> +		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
> 
> "FLPT_DEFAULT_DID" looks very likely for first level translation. How about
> "PT_FL_DEFAULT_DID"?

We have comments above it, so people won't be confused.

> 
>>   	return 0;
>>   }
>>
>> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
>> index 12f480c2bb8b..03c1612d173c 100644
>> --- a/drivers/iommu/intel-pasid.h
>> +++ b/drivers/iommu/intel-pasid.h
>> @@ -17,6 +17,12 @@
>>   #define PDE_PFN_MASK			PAGE_MASK
>>   #define PASID_PDE_SHIFT			6
>>
>> +/*
>> + * Domain ID reserved for pasid entries programmed for first-level
>> + * only and pass-through transfer modes.
>> + */
>> +#define FLPT_DEFAULT_DID		1
> 
> Would be helpful to elaborate why DID 1 is selected in the patch
> description.

Yeah. DID 0 has been caved out for caching mode and we start from 1 for
this.

Best regards,
Lu Baolu
