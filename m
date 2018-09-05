From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 0/5] Qcom smmu-500 TLB invalidation errata for sdm845
Date: Wed, 5 Sep 2018 14:52:21 +0530
Message-ID: <3f74124c-b09f-a92d-117d-a747d33a4561@codeaurora.org>
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
	<20180814114009.GF28664@arm.com>
	<ad4e9f85-ff57-ad26-fb25-7b4c08683a52@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ad4e9f85-ff57-ad26-fb25-7b4c08683a52-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


On 8/14/2018 5:54 PM, Vivek Gautam wrote:
> Hi Will,
>
>
> On 8/14/2018 5:10 PM, Will Deacon wrote:
>> Hi Vivek,
>>
>> On Tue, Aug 14, 2018 at 04:25:23PM +0530, Vivek Gautam wrote:
>>> Qcom's implementation of arm,mmu-500 on sdm845 has a 
>>> functional/performance
>>> errata [1] because of which the TCU cache look ups are stalled during
>>> invalidation cycle. This is mitigated by serializing all the 
>>> invalidation
>>> requests coming to the smmu.
>> How does this implementation differ from the one supported by 
>> qcom_iommu.c?
>> I notice you're adding firmware hooks here, which we avoided by 
>> having the
>> extra driver. Please help me understand which devices exist, how they
>> differ, and which drivers are intended to support them!
>
> IIRC, the qcom_iommu driver was intended to support the static context 
> bank - SID
> mapping, and is very specific to the smmu-v2 version present on 
> msm8916 soc.
> However, this is the qcom's mmu-500 implementation specific errata. 
> qcom_iommu
> will not be able to support mmu-500 configurations.
> Rob Clark can add more.
> Let you know what you suggest.

Rob, can you please comment about how qcom-smmu driver has different 
implementation
from arm-smmu driver?
Will, in case we would want to use arm-smmu driver, what would you 
suggest for
having the firmware hooks?
Thanks.

Best regards
Vivek
>
>>
>> Also -- you didn't CC all the maintainers for the firmware bits, so 
>> adding
>> Andy here for that, and Rob for the previous question.
>
> I added Andy to the series, would you want me to add Rob H also?
>
> Best regards
> Vivek
>
>>
>> Thanks,
>>
>> Will
>
