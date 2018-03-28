From: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v9 5/5] iommu/arm-smmu: Add support for qcom,smmu-v2
	variant
Date: Wed, 28 Mar 2018 14:11:07 +0800
Message-ID: <d97872fe-5e8e-cc27-e385-64cea8ea2458@huawei.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
	<20180313085534.11650-6-vivek.gautam@codeaurora.org>
	<61d30fff-1bf8-d2c1-bbe9-f93de836ae77@huawei.com>
	<7d5af071-ef98-8461-3ce9-e84fc0b3956a@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <7d5af071-ef98-8461-3ce9-e84fc0b3956a-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Gaojianbo <gaojianbo-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Vivek,

On 2018/3/28 12:37, Vivek Gautam wrote:
> Hi Yisheng
> 
> 
> On 3/28/2018 6:54 AM, Yisheng Xie wrote:
>> Hi Vivek,
>>
>> On 2018/3/13 16:55, Vivek Gautam wrote:
>>> +- power-domains:  Specifiers for power domains required to be powered on for
>>> +                  the SMMU to operate, as per generic power domain bindings.
>>> +
>> In this patchset, power-domains is not used right? And you just do the clock gating,
>> but not power gating, right?
> 
> We are handling the power-domains too. Please see the example in this binding doc.

I see, but I do not find the point in code of these patchset, do you mean PMIC(e.g mmcc)
will gate the power domain of SMMU(e.g. MDSS_GDSC of mmcc) when PMIC suspend?

> 
>>
>> Another question is if smmu do power gating, it will reset some of its registers, so
>> it need save at suspend and restore at resume, right?
> 
> Qualcomm implementation of the arm-smmu has the retenetion enabled. So the smmu doesn't
> loose state when power is pulled out of it.
> And now we are just selectively enabling the runtime pm. So only the platforms that can really
> support runtime pm can enable it.

Get it, thanks for your explain.

Thanks
Yisheng
> 
> Thanks
> Vivek
>>
>> Thanks
>> Yisheng
>>
> 
> 
> 
