From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V4 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
	add/remove device
Date: Thu, 13 Jul 2017 19:31:41 +0530
Message-ID: <CAFp+6iGr_WwhDTygc3Z7pmRJe704PAo_T_XLYvu-=f01cmnumA@mail.gmail.com>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
	<1499333825-7658-4-git-send-email-vivek.gautam@codeaurora.org>
	<20170712225459.GZ22780@codeaurora.org>
	<5ee0bacd-e557-a6c4-a897-844fb12ea6ae@codeaurora.org>
	<4dbc938c-ac88-9bd4-cf00-458008ae24c1@codeaurora.org>
	<CAFp+6iFdogDfKbwWta3AMGu2GuZ9NaR+Dv373N7LwwrF5cFYwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAFp+6iFdogDfKbwWta3AMGu2GuZ9NaR+Dv373N7LwwrF5cFYwQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, robin.murphy-5wv7dgnIgG8@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 13, 2017 at 7:27 PM, Vivek Gautam
<vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> On Thu, Jul 13, 2017 at 11:05 AM, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>> Hi Vivek,
>>
>> On 7/13/2017 10:43 AM, Vivek Gautam wrote:
>>> Hi Stephen,
>>>
>>>
>>> On 07/13/2017 04:24 AM, Stephen Boyd wrote:
>>>> On 07/06, Vivek Gautam wrote:
>>>>> @@ -1231,12 +1237,18 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
>>>>>   static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>>>>>                    size_t size)
>>>>>   {
>>>>> -    struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
>>>>> +    struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>>> +    struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
>>>>> +    size_t ret;
>>>>>         if (!ops)
>>>>>           return 0;
>>>>>   -    return ops->unmap(ops, iova, size);
>>>>> +    pm_runtime_get_sync(smmu_domain->smmu->dev);
>>>> Can these map/unmap ops be called from an atomic context? I seem
>>>> to recall that being a problem before.
>>>
>>> That's something which was dropped in the following patch merged in master:
>>> 523d7423e21b iommu/arm-smmu: Remove io-pgtable spinlock
>>>
>>> Looks like we don't  need locks here anymore?
>>
>>  Apart from the locking, wonder why a explicit pm_runtime is needed
>>  from unmap. Somehow looks like some path in the master using that
>>  should have enabled the pm ?
>
> Right, the master should have done a runtime_get(), and with
> device links the iommu will also resume.
>
> The master will call the unmap when it is attached to the iommu
> and therefore the iommu should be in resume state.
> We shouldn't have an unmap without the master attached anyways.
> Will investigate this further if we need the pm_runtime() calls
> around unmap or not.

My apologies. My email client didn't update the thread. So please ignore
this comment.

>
> Best regards
> Vivek
>
>>
>> Regards,
>>  Sricharan
>>
>> --
>> "QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>>
>> ---
>> This email has been checked for viruses by Avast antivirus software.
>> https://www.avast.com/antivirus
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project



-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
