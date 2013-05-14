From: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] IOMMU/AMD: Adding IOMMU PC resource management
Date: Tue, 14 May 2013 09:37:21 -0500
Message-ID: <51924C21.3020906@amd.com>
References: <1368481424-5626-1-git-send-email-steven.kinney@amd.com>
	<20130514070924.GA15942@dyad.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130514070924.GA15942-ml83lk9NYoCAxCfHYDuV95NvnLFust7K9Kp1ZRVAGBM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: steven.kinney-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 5/14/2013 2:09 AM, Peter Zijlstra wrote:
> On Mon, May 13, 2013 at 04:43:44PM -0500, steven.kinney-5C7GfCeVMHo@public.gmane.org wrote:
>> +static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>> +{
>> +	u32 val = 0xabcd, val2 = 0;
>> +
>> +	if (!iommu_feature(iommu, FEATURE_PC))
>> +		return;
>> +
>> +	amd_iommu_pc_present = true;
>> +
>> +	/* Check if the performance counters can be written to */
>> +	if ((0 != amd_iommu_pc_get_set_reg_val(0, 0, 0, 0, &val, true)) ||
>> +	    (0 != amd_iommu_pc_get_set_reg_val(0, 0, 0, 0, &val2, false)) ||
>> +	    (val != val2)) {
>> +		pr_err("AMD-Vi: Unable to write to IOMMU perf counter.\n");
> Would it make sense to clear amd_iommu_pc_present here?
Yes, I'll take care of this here.

Thank you,

Surave
