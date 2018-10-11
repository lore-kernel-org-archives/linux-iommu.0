From: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu: arm-smmu: handle client iommu translation fault
	handlers
Date: Thu, 11 Oct 2018 15:26:57 +0300
Message-ID: <6edd8f71-4363-01b6-6b45-aebc92604559@linaro.org>
References: <20181010144407.23336-1-stanimir.varbanov@linaro.org>
	<20181010170837.GC16512@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181010170837.GC16512-5wv7dgnIgG8@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 10/10/2018 08:08 PM, Will Deacon wrote:
> On Wed, Oct 10, 2018 at 05:44:07PM +0300, Stanimir Varbanov wrote:
>> Call iommu client translation fault handler(s).
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 066f4c8daf4e..02a8aab0cc59 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -568,6 +568,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>>  			    fsr, iova, fsynr, cfg->cbndx);
>>  
>>  	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
>> +
>> +	report_iommu_fault(domain, smmu->dev, iova, 0);
> 
> Who's using this? Generally, the callback here isn't so useful because it's

The idea was to use it from video driver to dump few multimedia
interconnect registers which will give us some more info about the fault.

> called in irq context. We also don't enable stalling since 3714ce1d6655.
> 
> We previously had fairly detailed discussions on the list with Rob Clark
> about alternative ways to design this, but I don't remember where it ended
> up.

It will be useful if you point me to the discussion. Thanks!

-- 
regards,
Stan
