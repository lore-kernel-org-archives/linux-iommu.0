From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v9 5/5] iommu/arm-smmu: Add support for qcom,smmu-v2
	variant
Date: Wed, 11 Apr 2018 10:45:24 +0530
Message-ID: <ff1c730f-0009-58e5-cf4a-45fe9ab93d1e@codeaurora.org>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
	<20180313085534.11650-6-vivek.gautam@codeaurora.org>
	<61d30fff-1bf8-d2c1-bbe9-f93de836ae77@huawei.com>
	<7d5af071-ef98-8461-3ce9-e84fc0b3956a@codeaurora.org>
	<d97872fe-5e8e-cc27-e385-64cea8ea2458@huawei.com>
	<CAAFQd5Cj3qaqt8ACabZwN4ZKaNbF9N9suGVaOKD8-kNxgfeeVA@mail.gmail.com>
	<65a57964-805b-3a38-71a2-0c383af30539@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <65a57964-805b-3a38-71a2-0c383af30539-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, gaojianbo-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Yisheng,


On 4/11/2018 6:52 AM, Yisheng Xie wrote:
> Hi Tomasz,
>
> On 2018/4/10 21:14, Tomasz Figa wrote:
>> Hi Yisheng,
>>
>> Sorry, I think we missed your question here.
>>
>> On Wed, Mar 28, 2018 at 3:12 PM Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:
>>
>>> Hi Vivek,
>>> On 2018/3/28 12:37, Vivek Gautam wrote:
>>>> Hi Yisheng
>>>>
>>>>
>>>> On 3/28/2018 6:54 AM, Yisheng Xie wrote:
>>>>> Hi Vivek,
>>>>>
>>>>> On 2018/3/13 16:55, Vivek Gautam wrote:
>>>>>> +- power-domains:  Specifiers for power domains required to be
>> powered on for
>>>>>> +                  the SMMU to operate, as per generic power domain
>> bindings.
>>>>>> +
>>>>> In this patchset, power-domains is not used right? And you just do the
>> clock gating,
>>>>> but not power gating, right?
>>>> We are handling the power-domains too. Please see the example in this
>> binding doc.
>>
>>> I see, but I do not find the point in code of these patchset, do you mean
>> PMIC(e.g mmcc)
>>> will gate the power domain of SMMU(e.g. MDSS_GDSC of mmcc) when PMIC
>> suspend?
>>
>>
>> If respective SoC power domains is registered as a standard genpd PM
>> domain, then the runtime PM subsystem will take care of power domain
>> control at runtime suspend and resume.
>>
> Get it, thanks for your explain, I should have learned about this.

Sorry, i missed your subsequent question, and Tomasz has explained it now.
Let me know if you have further questions.

regards
Vivek
>
> Thanks
> Yisheng
>
>> Best regards,
>> Tomasz
>>
>> .
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
