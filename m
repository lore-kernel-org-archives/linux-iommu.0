From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V3 5/5] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Thu, 11 Feb 2016 15:34:38 +0700
Message-ID: <56BC479E.2070004@amd.com>
References: <1455058435-8716-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1455058435-8716-6-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20160210171401.GI23914@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160210171401.GI23914-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Boris,

Thank you very much for catching several styling issues. I should have 
taken care of that earlier.  I'll clean them up.  Please see my other 
comments below.

Thanks,
Suravee

On 02/11/2016 12:14 AM, Borislav Petkov wrote:
> On Tue, Feb 09, 2016 at 04:53:55PM -0600, Suravee Suthikulpanit wrote:
>> [...]
>>
>> -	/* IOMMU pc counter register is only 48 bits */
>> -	count &= 0xFFFFFFFFFFFFULL;
>> +	pr_debug("perf: amd_iommu:perf_iommu_read\n");
>
> What is that debug statement good for? Can it go?
>
>  From looking at that file, it has a bunch more which are completely
> useless and can be deleted. In a separate patch.

Sure. I'll add a new patch to remove all these pr_debug.

>> [...]
>> +	if (!perf_iommu_cnts)
>> +		return -ENOMEM;
>> +
>>   	ret = perf_pmu_register(&perf_iommu->pmu, name, -1);
>>   	if (ret) {
>>   		pr_err("perf: amd_iommu: Failed to initialized.\n");
>
> You can define pr_fmt to "perf/amd_iommu: " at the beginning of this
> file and then you don't need to supply that prefix each time you call
> pr_*

Good point. I'll take care of this.

> And that sentence above it wrong. It should be:
>
> 	pr_err("Error initializing AMD IOMMU perf counters.\n");
>
> or something like that.
>

OK.

>> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
>> index 531b2e1..7b1b561 100644
>> --- a/drivers/iommu/amd_iommu_init.c
>> +++ b/drivers/iommu/amd_iommu_init.c
>> @@ -1133,6 +1133,9 @@ static int __init init_iommu_all(struct acpi_table_header *table)
>>   	return 0;
>>   }
>>
>> +static int _amd_iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
>> +					 u8 bank, u8 cntr, u8 fxn,
>> +					 u64 *value, bool is_write);
>
> static int _amd_iommu_this_func_name_is_def_too_long
>

I'll rename all these functions to make it shorter and less confusing.

>> [...]
>> +
>> +int amd_iommu_pc_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn, u64 *value)
>> +{
>> +	struct amd_iommu *iommu;
>> +
>> +	for_each_iommu(iommu) {
>> +		int ret = _amd_iommu_pc_get_set_reg_val(iommu, bank, cntr,
>> +							fxn, value, true);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(amd_iommu_pc_set_reg_val);
>
> Why isn't this EXPORT_SYMBOL_GPL?

Actually, I am just trying to match other exported functions in the AMD 
IOMMU driver. May be Joerg can let us know why these functions are not 
EXPORT_SYMBOL_GPL to begin with.

>> +	 * which should have been programmed the same way.
>> +	 * and aggregate the counter values.
>
> That comment is a sentence with a fullstop in the middle.
>
>> +	 */
>> +	for_each_iommu(iommu) {
>> +		u64 tmp;
>> +
>> +		if (i >= num)
>> +			return -EINVAL;
>> +
>> +		ret = _amd_iommu_pc_get_set_reg_val(iommu, bank, cntr,
>> +							IOMMU_PC_COUNTER_REG,
>> +							&tmp, false);
>> +		if (ret)
>> +			return ret;
>
> So if one of those intermediary calls of _amd_iommu_pc_get_set_reg_val()
> fails, we return here not having read all counters. Unwind and handle
> that error properly maybe?
>
> Same issue above.

Good point. So, for writing, I'll make sure to unset the 
registers/counters when we encounter errors.

For reading counters, I think it is acceptable to say that users cannot 
rely on the return values in the array if the function returns non-zero 
value (success).

Thanks,
Suravee
