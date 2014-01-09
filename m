From: Mark Zhang <nvmarkzhang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/6] iommu/tegra124: smmu: support more than 32 bit pa
Date: Thu, 09 Jan 2014 10:28:01 +0800
Message-ID: <52CE0931.2090405@gmail.com>
References: <1386246319-17851-1-git-send-email-hdoyu@nvidia.com>
	<1386246319-17851-5-git-send-email-hdoyu@nvidia.com>
	<52CB8FD1.4070306@gmail.com>
	<20140108134550.GF1592@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140108134550.GF1592-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 01/08/2014 09:45 PM, Thierry Reding wrote:
> On Tue, Jan 07, 2014 at 01:25:37PM +0800, Mark Zhang wrote:
>> On 12/05/2013 08:25 PM, Hiroshi Doyu wrote:
> [...]
>>> @@ -526,6 +530,21 @@ static int smmu_setup_regs(struct smmu_device *smmu)
>>>  	return 0;
>>>  }
>>>  
>>> +static void flush_ptc_by_addr(struct smmu_device *smmu, unsigned long *pte,
>>> +			      struct page *page)
>>> +{
>>> +	u32 val;
>>> +
>>> +	val = VA_PAGE_TO_PA_HI(pte, page);
>>> +	if (val)
>>> +		smmu_write(smmu, val, SMMU_PTC_FLUSH_1);
>>> +
>>
>> This is not correct, according to my tests. We should write
>> "SMMU_PTC_FLUSH_1" even when the "val" is zero.
>>
>> So I just copied Pavan's original work here, after applied this, the
>> SMMU works correctly:
>>
>> -       val = VA_PAGE_TO_PA_HI(pte, page);
>> -       if (val)
>> +       if (!pte) {
>> +               smmu_write(smmu, SMMU_PTC_FLUSH_TYPE_ALL, SMMU_PTC_FLUSH);
>> +               return;
>> +       }
>> +
>> +       if (of_machine_is_compatible("nvidia,tegra124")) {
> 
> This check should be replaced by some flag so we don't have to compare
> strings every time the PTC is flushed.
> 

Yes, I believe Hiroshi will consider this in his v8 series.

Mark
> Thierry
> 
