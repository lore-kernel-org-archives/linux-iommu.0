From: leizhen <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/8] iommu/arm-smmu: set EPD1 to disable TT1 translation
	table walk
Date: Tue, 30 Jun 2015 12:40:33 +0800
Message-ID: <55921DC1.7060606@huawei.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
	<1435307584-9812-5-git-send-email-thunder.leizhen@huawei.com>
	<20150629172622.GK17474@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150629172622.GK17474-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2015/6/30 1:26, Will Deacon wrote:
> On Fri, Jun 26, 2015 at 09:33:00AM +0100, Zhen Lei wrote:
>> Now we only use TT0 translation, disable TT1 translation will safer.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 43120ad..6d6712e 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -285,6 +285,7 @@
>>  #define ARM64_TCR_EPD1_MASK		0x1UL
>>
>>  #define CTXDESC_CD_0_ENDI		(1UL << 15)
>> +#define CTXDESC_CD_0_EPD1		(1UL << 30)
>>  #define CTXDESC_CD_0_V			(1UL << 31)
>>
>>  #define CTXDESC_CD_0_TCR_IPS_SHIFT	32
>> @@ -893,7 +894,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
>>  #endif
>>  	      CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET_PRIVATE |
>>  	      CTXDESC_CD_0_AA64 | (u64)cfg->cd.asid << CTXDESC_CD_0_ASID_SHIFT |
>> -	      CTXDESC_CD_0_V;
>> +	      CTXDESC_CD_0_EPD1 | CTXDESC_CD_0_V;
> 
> 
> This is redundant. EPD1 is already set by the io-pgtable code.

OK, I will drop this patch. I made a mistake.

> 
> Will
> 
> .
> 
