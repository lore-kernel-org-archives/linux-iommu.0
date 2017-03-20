From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/9] iommu: add qcom_iommu
Date: Mon, 20 Mar 2017 11:11:24 -0400
Message-ID: <CAF6AEGtk5PgXJLmNzL9drE=2nSyjfS1B7_N8RVaueOHbg4PRSw@mail.gmail.com>
References: <20170301174258.14618-1-robdclark@gmail.com>
	<20170301174258.14618-6-robdclark@gmail.com>
	<075356ad9df70ee2a54ea782f143522c@codeaurora.org>
	<CAF6AEGsoHwDRR02nxz_fkeSPrXBRmG_38xvkF6f0=m+Ucj_soA@mail.gmail.com>
	<6398dcd5-812d-f746-5bd8-2288b0cc501d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6398dcd5-812d-f746-5bd8-2288b0cc501d-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-msm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 20, 2017 at 10:21 AM, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> Hi Rob,
>
> sorry for the delayed response. Was not there mostly last week.
>
>
> On 3/13/2017 11:49 PM, Rob Clark wrote:
>>
>> On Mon, Mar 13, 2017 at 9:38 AM,  <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>>
>>> Hi Rob,
>>>
>>> [..]
>>>
>>>
>>>> +static int qcom_iommu_init_domain(struct iommu_domain *domain,
>>>> +                                 struct qcom_iommu_dev *qcom_iommu,
>>>> +                                 struct iommu_fwspec *fwspec)
>>>> +{
>>>> +       struct qcom_iommu_domain *qcom_domain =
>>>> to_qcom_iommu_domain(domain);
>>>> +       struct io_pgtable_ops *pgtbl_ops;
>>>> +       struct io_pgtable_cfg pgtbl_cfg;
>>>> +       int i, ret = 0;
>>>> +       u32 reg;
>>>> +
>>>> +       mutex_lock(&qcom_domain->init_mutex);
>>>> +       if (qcom_domain->iommu)
>>>> +               goto out_unlock;
>>>> +
>>>> +       pgtbl_cfg = (struct io_pgtable_cfg) {
>>>> +               .pgsize_bitmap  = qcom_iommu_ops.pgsize_bitmap,
>>>> +               .ias            = 32,
>>>> +               .oas            = 40,
>>>> +               .tlb            = &qcom_gather_ops,
>>>> +               .iommu_dev      = qcom_iommu->dev,
>>>> +       };
>>>> +
>>>> +       qcom_domain->iommu = qcom_iommu;
>>>> +       pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg,
>>>> fwspec);
>>>
>>>
>>>
>>> So why not pass in the ctx pointer itself
>>> that we get below as a cookie ? That would basically
>>> avoid iterating through the list in the tlb_ops ?
>>
>>
>> The issue is that one domain might be attached to a device with multiple
>> ctx's.
>>
>
> ok, interesting, what's the usecase for this ? Dynamic domain
> has 1-ctx shared with multiple domains, but this seems to be
> the inverse.

For example, the gpu has the "user" and "priv" contexts.  And at least
for now we attach a single domain.  (Actually we might not be
triggering the gpu yet to use the "user" context, so it hasn't really
been an issue yet.. that may possibly anger arm-smmu in the future..)

>> Although perhaps __to_ctx() could be made a bit more clever.  I was
>> mostly in "make it work, optimize later" mode ;-)
>>
>> Note also, I'm thinking (both for qcom_iommu and arm-smmu) that we
>> want to move pgtbl alloc into _domain_alloc().. or at least that would
>> allow the driver to iommu_map/unmap() before attaching the domain.
>> (Partly this depends on how the iommu task and/or dynamic domain stuff
>> works out.. but one way or another we want to be able to map things to
>> pagetables that aren't the currently attached pagetables)
>
>
> ok, the dynamic domain patches i remember was tweaking the attach path
> to make this work. So are you trying to avoid that and simple do only
> a dynamic_domain_alloc instead ?
>

I probably need to look more closely at the dynamic domain stuff.
Although I'm not sure that we'll enable per-process pagetables on
anything earlier than a5xx so possibly we only care about arm-smmu for
that..

BR,
-R
