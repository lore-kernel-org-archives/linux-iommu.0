From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH] iommu/vt-d: Fix intel_pasid_max_id
Date: Tue, 30 Apr 2019 22:37:53 +0200
Message-ID: <1f71902d-28c6-4e63-b4b8-dafbb8881694@redhat.com>
References: <20190430072940.10467-1-eric.auger@redhat.com>
 <20190430110108.7c751195@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430110108.7c751195@jacob-builder>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: eric.auger.pro@gmail.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

On 4/30/19 8:01 PM, Jacob Pan wrote:
> On Tue, 30 Apr 2019 09:29:40 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> Extended Capability Register PSS field (PASID Size Supported)
>> corresponds to the PASID bit size -1.
>>
>> "A value of N in this field indicates hardware supports PASID
>> field of N+1 bits (For example, value of 7 in this field,
>> indicates 8-bit PASIDs are supported)".
>>
>> Fix the computation of intel_pasid_max_id accordingly.
>>
>> Fixes: 562831747f62 ("iommu/vt-d: Global PASID name space")
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  drivers/iommu/intel-iommu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 28cb713d728c..c3f1bfc81d2e 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -3331,7 +3331,7 @@ static int __init init_dmars(void)
>>  		 * than the smallest supported.
>>  		 */
>>  		if (pasid_supported(iommu)) {
>> -			u32 temp = 2 << ecap_pss(iommu->ecap);
>> +			u32 temp = 2 << (ecap_pss(iommu->ecap) + 1);
> here it is "2 << bits" not "1 << bits", so the original code is correct.
> 
> But I agree it would be more clear to the spec. if we do:
> 1 << (ecap_pss(iommu->ecap) + 1);
Oups OK, my eyes. Forget it :-(

Thanks

Eric
>>  
>>  			intel_pasid_max_id = min_t(u32, temp,
>>  						   intel_pasid_max_id);
> 
