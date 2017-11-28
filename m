From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
Date: Tue, 28 Nov 2017 15:05:14 -0500
Message-ID: <CAF6AEGu3nZiyNN+KjRmKm57fPOvT+qHUPNJzs=84EWEU+CDcCA@mail.gmail.com>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
 <1499333825-7658-4-git-send-email-vivek.gautam@codeaurora.org>
 <20170712225459.GZ22780@codeaurora.org> <5ee0bacd-e557-a6c4-a897-844fb12ea6ae@codeaurora.org>
 <4dbc938c-ac88-9bd4-cf00-458008ae24c1@codeaurora.org> <CAF6AEGsFOtsOjt1sLNPSFLEcu-7d1zxCOhTeC+P8e0TDbb1dSA@mail.gmail.com>
 <CAFp+6iH-WR4gNExaOBfnwy7GG7DXrjdytPvnMHNmo64YQZdQWQ@mail.gmail.com>
 <CAF6AEGsw2=nERuJ8UCBr_kTBS0TigaA9LL1Hxw3JmNiu4oycOA@mail.gmail.com>
 <CAFp+6iGyB-iVb+vyDr6Dzk1FG6baiNy_kZWjB3sm_GViDh6rnQ@mail.gmail.com>
 <20171127222238.GF18379@codeaurora.org> <CAF6AEGtq2_tMBd1U_t19s8Eg7+-RPQ+E_pCZCd75iFs6_bx53A@mail.gmail.com>
 <3a2f74e9-90cf-d843-d801-15eb614d7abe@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3a2f74e9-90cf-d843-d801-15eb614d7abe-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-ar>
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 28, 2017 at 8:43 AM, Vivek Gautam
<vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>
>
> On 11/28/2017 05:13 AM, Rob Clark wrote:
>>
>> On Mon, Nov 27, 2017 at 5:22 PM, Stephen Boyd<sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> wrote:
>>>
>>> On 11/15, Vivek Gautam wrote:
>>>>
>>>> Hi,
>>>>
>>>>
>>>> On Mon, Aug 7, 2017 at 5:59 PM, Rob Clark<robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>  wrote:
>>>>>
>>>>> On Mon, Aug 7, 2017 at 4:27 AM, Vivek Gautam
>>>>> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>  wrote:
>>>>>>
>>>>>> On Thu, Jul 13, 2017 at 5:20 PM, Rob Clark<robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>>> wrote:
>>>>>>>
>>>>>>> On Thu, Jul 13, 2017 at 1:35 AM, Sricharan
>>>>>>> R<sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>  wrote:
>>>>>>>>
>>>>>>>> Hi Vivek,
>>>>>>>>
>>>>>>>> On 7/13/2017 10:43 AM, Vivek Gautam wrote:
>>>>>>>>>
>>>>>>>>> Hi Stephen,
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 07/13/2017 04:24 AM, Stephen Boyd wrote:
>>>>>>>>>>
>>>>>>>>>> On 07/06, Vivek Gautam wrote:
>>>>>>>>>>>
>>>>>>>>>>> @@ -1231,12 +1237,18 @@ static int arm_smmu_map(struct
>>>>>>>>>>> iommu_domain *domain, unsigned long iova,
>>>>>>>>>>>    static size_t arm_smmu_unmap(struct iommu_domain *domain,
>>>>>>>>>>> unsigned long iova,
>>>>>>>>>>>                     size_t size)
>>>>>>>>>>>    {
>>>>>>>>>>> -    struct io_pgtable_ops *ops =
>>>>>>>>>>> to_smmu_domain(domain)->pgtbl_ops;
>>>>>>>>>>> +    struct arm_smmu_domain *smmu_domain =
>>>>>>>>>>> to_smmu_domain(domain);
>>>>>>>>>>> +    struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
>>>>>>>>>>> +    size_t ret;
>>>>>>>>>>>          if (!ops)
>>>>>>>>>>>            return 0;
>>>>>>>>>>>    -    return ops->unmap(ops, iova, size);
>>>>>>>>>>> +    pm_runtime_get_sync(smmu_domain->smmu->dev);
>>>>>>>>>>
>>>>>>>>>> Can these map/unmap ops be called from an atomic context? I seem
>>>>>>>>>> to recall that being a problem before.
>>>>>>>>>
>>>>>>>>> That's something which was dropped in the following patch merged in
>>>>>>>>> master:
>>>>>>>>> 523d7423e21b iommu/arm-smmu: Remove io-pgtable spinlock
>>>>>>>>>
>>>>>>>>> Looks like we don't  need locks here anymore?
>>>>>>>>
>>>>>>>>   Apart from the locking, wonder why a explicit pm_runtime is needed
>>>>>>>>   from unmap. Somehow looks like some path in the master using that
>>>>>>>>   should have enabled the pm ?
>>>>>>>>
>>>>>>> Yes, there are a bunch of scenarios where unmap can happen with
>>>>>>> disabled master (but not in atomic context).
>>>>>>
>>>>>> I would like to understand whether there is a situation where an unmap
>>>>>> is
>>>>>> called in atomic context without an enabled master?
>>>>>>
>>>>>> Let's say we have the case where all the unmap calls in atomic context
>>>>>> happen
>>>>>> only from the master's context (in which case the device link should
>>>>>> take care of
>>>>>> the pm state of smmu), and the only unmap that happen in non-atomic
>>>>>> context
>>>>>> is the one with master disabled. In such a case doesn it make sense to
>>>>>> distinguish
>>>>>> the atomic/non-atomic context and add pm_runtime_get_sync()/put_sync()
>>>>>> only
>>>>>> for the non-atomic context since that would be the one with master
>>>>>> disabled.
>>>>>>
>>>>> At least drm/msm needs to hold obj->lock (a mutex) in unmap, so it
>>>>> won't unmap anything in atomic ctx (but it can unmap w/ master
>>>>> disabled).  I can't really comment about other non-gpu drivers.  It
>>>>> seems like a reasonable constraint that either master is enabled or
>>>>> not in atomic ctx.
>>>>>
>>>>> Currently we actually wrap unmap w/ pm_runtime_get/put_sync(), but I'd
>>>>> like to drop that to avoid powering up the gpu.
>>>>
>>>> Since the deferring the TLB maintenance doesn't look like the best
>>>> approach [1],
>>>> how about if we try to power-up only the smmu from different client
>>>> devices such as,
>>>> GPU in the unmap path. Then we won't need to add pm_runtime_get/put()
>>>> calls in
>>>> arm_smmu_unmap().
>>>>
>>>> The client device can use something like - pm_runtime_get_supplier()
>>>> since
>>>> we already have the device link in place with this patch series. This
>>>> should
>>>> power-on the supplier (which is smmu) without turning on the consumer
>>>> (such as GPU).
>>>>
>>>> pm_runtime_get_supplier() however is not exported at this moment.
>>>> Will it be useful to export this API and use it in the drivers.
>>>>
>>> I'm not sure pm_runtime_get_supplier() is correct either. That
>>> feels like we're relying on the GPU driver knowing the internal
>>> details of how the device links are configured.
>>>
>> what does pm_runtime_get_supplier() do if IOMMU driver hasn't setup
>> device-link?
>
>
> It will be a no-op.
>
>> If it is a no-op, then I guess the GPU driver calling
>> pm_runtime_get_supplier() seems reasonable, and less annoying than
>> having special cases in pm_resume path.. I don't feel too bad about
>> having "just in case" get/put_supplier() calls in the unmap path.
>>
>> Also, presumably we still want to avoid powering up GPU even if we
>> short circuit the firmware loading and rest of "booting up the GPU"..
>> since presumably the GPU draws somewhat more power than the IOMMU..
>> having the pm_resume/suspend path know about the diff between waking
>> up / suspending the iommu and itself doesn't really feel less-bad than
>> just doing "just in case" get/put_supplier() calls.
>
>
> If it sounds okay, then i can send a patch that exports the
> pm_runtime_get/put_suppliers() APIs.
>

sounds good to me

BR,
-R


>
> Best regards
> Vivek
>
>> BR,
>> -R
>>
>>> Is there some way to have the GPU driver know in its runtime PM
>>> resume hook that it doesn't need to be powered on because it
>>> isn't actively drawing anything or processing commands? I'm
>>> thinking of the code calling pm_runtime_get() as proposed around
>>> the IOMMU unmap path in the GPU driver and then having the
>>> runtime PM resume hook in the GPU driver return some special
>>> value to indicate that it didn't really resume because it didn't
>>> need to and to treat the device as runtime suspended but not
>>> return an error. Then the runtime PM core can keep track of that
>>> and try to power the GPU on again when another pm_runtime_get()
>>> is called on the GPU device.
>>>
>>> This keeps the consumer API the same, always pm_runtime_get(),
>>> but leaves the device driver logic of what to do when the GPU
>>> doesn't need to power on to the runtime PM hook where the driver
>>> has all the information.
>>>
>>> --
>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>>> a Linux Foundation Collaborative Project
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm"
>> in
>> the body of a message tomajordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info athttp://vger.kernel.org/majordomo-info.html
>
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>
> a Linux Foundation Collaborative Project
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
