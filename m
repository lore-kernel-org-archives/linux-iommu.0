From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 0/5] Qcom smmu-500 TLB invalidation errata for sdm845
Date: Wed, 5 Sep 2018 16:55:22 +0530
Message-ID: <3ac669af-a68e-874f-4c3e-91a2e9f676af@codeaurora.org>
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
	<20180814114009.GF28664@arm.com>
	<ad4e9f85-ff57-ad26-fb25-7b4c08683a52@codeaurora.org>
	<3f74124c-b09f-a92d-117d-a747d33a4561@codeaurora.org>
	<CAF6AEGsuAXXtUbeteQk5ssZEqk8XLViDZH5PfxQjn6sg8+B08A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAF6AEGsuAXXtUbeteQk5ssZEqk8XLViDZH5PfxQjn6sg8+B08A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 9/5/2018 3:34 PM, Rob Clark wrote:
> On Wed, Sep 5, 2018 at 5:22 AM Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>
>> On 8/14/2018 5:54 PM, Vivek Gautam wrote:
>>> Hi Will,
>>>
>>>
>>> On 8/14/2018 5:10 PM, Will Deacon wrote:
>>>> Hi Vivek,
>>>>
>>>> On Tue, Aug 14, 2018 at 04:25:23PM +0530, Vivek Gautam wrote:
>>>>> Qcom's implementation of arm,mmu-500 on sdm845 has a
>>>>> functional/performance
>>>>> errata [1] because of which the TCU cache look ups are stalled during
>>>>> invalidation cycle. This is mitigated by serializing all the
>>>>> invalidation
>>>>> requests coming to the smmu.
>>>> How does this implementation differ from the one supported by
>>>> qcom_iommu.c?
>>>> I notice you're adding firmware hooks here, which we avoided by
>>>> having the
>>>> extra driver. Please help me understand which devices exist, how they
>>>> differ, and which drivers are intended to support them!
>>> IIRC, the qcom_iommu driver was intended to support the static context
>>> bank - SID
>>> mapping, and is very specific to the smmu-v2 version present on
>>> msm8916 soc.
>>> However, this is the qcom's mmu-500 implementation specific errata.
>>> qcom_iommu
>>> will not be able to support mmu-500 configurations.
>>> Rob Clark can add more.
>>> Let you know what you suggest.
>> Rob, can you please comment about how qcom-smmu driver has different
>> implementation
>> from arm-smmu driver?
> sorry, I missed this thread earlier.  But yeah, as you mentioned, the
> purpose for qcom_iommu.c was to deal with the static context/SID
> mapping.
>
> (I guess it is all just software, and we could make qcom_iommu.c
> support dynamic mapping as well, but I think then it starts to
> duplicate most of arm_smmu.c, so that doesn't seem like the right
> direction)

Thanks Rob for the response. I will wait for Will's response on how would he
like this support be implemented.

Best regards
Vivek
>
> BR,
> -R
>
>> Will, in case we would want to use arm-smmu driver, what would you
>> suggest for
>> having the firmware hooks?
>> Thanks.
>>
>> Best regards
>> Vivek
