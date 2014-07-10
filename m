From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] iommu: qcom-iommu-v0 IOMMU
Date: Thu, 10 Jul 2014 19:47:09 -0400
Message-ID: <CAF6AEGvr-5D437QCG+wf01OHJQ_7ydPutJDmODhzAJooenk=2A@mail.gmail.com>
References: <1405020077-16148-1-git-send-email-robdclark@gmail.com>
	<20140710215348.GQ20486@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140710215348.GQ20486-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 10, 2014 at 5:53 PM, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> On 07/10, Rob Clark wrote:
>> So, in it's current form, this is superficially a copy of msm_iommu
>> plus DT conversion.  But the pre-DT IOMMU driver had fairly different
>> structure.. ie. psuedo root device, with IOMMU devices hanging off
>> that, and context devices hanging off that.  The context devices were
>> what the client device would attach (which was also somewhat non-
>> standard.. see msm_iommu_get_ctx()).
>>
>> I couldn't really think of some sane way to refactor this and add DT
>> while at the same time keeping compatibility with the old pre-DT msm
>> stuff.  So I copied to a new driver.
>>
>> It was pointed out that nothing upstream actually *used* the msm_iommu
>> driver.  So if no one objects to dropping pre-DT support, then I could
>> do some patch rejuggling + sed to make this replace the old driver
>> instead.
>
> +1
>
>> +
>> +// TODO any good reason for global lock vs per-iommu lock?
>> +DEFINE_SPINLOCK(qcom_iommu_lock);
>
> static?

oh, yes.. ofc

I do wonder if we might want to make locking a bit more fine grained
to reduce contention (but, otoh, the gpu driver isn't going to contend
with itself, and other drivers probably aren't taxing the iommu quite
so hard).  But I guess it would be ok to leave that as a future
optimization.

>
>> +static LIST_HEAD(qcom_iommu_devices);
>> +
>> +/* Note that a single iommu_domain can, for devices sitting behind
>> + * more than one IOMMU (ie. one per AXI interface) will have more
>> + * than one iommu in the iommu_list.  But all are programmed to
>> + * point at the same pagetables so from client device perspective
>> + * they act as a single IOMMU.
>> + */
>> +struct qcom_domain_priv {
>> +     unsigned long *pgtable;
>> +     struct list_head iommu_list;  /* list of attached 'struct qcom_iommu' */
>> +};
>> +
>> +static int __enable_clocks(struct qcom_iommu *iommu)
>> +{
>> +     int ret;
>> +
>> +     ret = clk_prepare_enable(iommu->pclk);
>
> Looks like __enable_clocks() is called from within a spinlock
> sometimes. Please move the prepare call outside of any atomic
> sections and also enable CONFIG_PROVE_LOCKING and/or
> CONFIG_DEBUG_ATOMIC_SLEEP to find such problems.

good point.  I haven't gotten around to running this against a debug
kernel.  It is only at the 'just barely works now' stage, I just
wanted to send for early feedback on the approach.  (Mainly to make
sure no one screams bloody murder about dropping pre-DT support from
old driver.)

BR,
-R

>> +     if (ret)
>> +             goto fail;
>> +
>> +     if (iommu->clk) {
>> +             ret = clk_prepare_enable(iommu->clk);
>> +             if (ret)
>> +                     clk_disable_unprepare(iommu->pclk);
>> +     }
>> +fail:
>> +     return ret;
>> +}
>> +
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
