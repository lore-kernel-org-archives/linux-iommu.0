From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V2 1/3] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Thu, 9 Feb 2017 19:05:16 +0530
Message-ID: <004f01d282d9$5dd0e110$1972a330$@codeaurora.org>
References: <1486055420-19671-1-git-send-email-sricharan@codeaurora.org> <1486055420-19671-2-git-send-email-sricharan@codeaurora.org> <20170202174218.GO31394@leverpostej> <017701d281f9$927c5fb0$b7751f10$@codeaurora.org> <20170208114002.GD15459@leverpostej> <018401d28207$34db60a0$9e9221e0$@codeaurora.org> <b55359d8-2665-aef0-3215-53a0e8f21bcd@arm.com> <000301d28211$a5233a90$ef69afb0$@codeaurora.org> <20170208135252.GF15459@leverpostej> <db9bc01c-635d-1a57-8a6c-9be19a0cda16@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <db9bc01c-635d-1a57-8a6c-9be19a0cda16-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-us
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Robin Murphy' <robin.murphy-5wv7dgnIgG8@public.gmane.org>, 'Mark Rutland' <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

>-----Original Message-----
>From: linux-arm-kernel [mailto:linux-arm-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org] On Behalf Of Robin Murphy
>Sent: Wednesday, February 08, 2017 8:01 PM
>To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>; Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
>will.deacon-5wv7dgnIgG8@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org; linux-arm-
>kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
>Subject: Re: [PATCH V2 1/3] iommu/arm-smmu: Add pm_runtime/sleep ops
>
>On 08/02/17 13:52, Mark Rutland wrote:
>> On Wed, Feb 08, 2017 at 07:15:37PM +0530, Sricharan wrote:
>>>> Clocks are not architectural, so it only makes sense to associate them
>>>> with an implementation-specific compatible string. There's also no
>>>
>>> ok, it for this the QCOM specific implementation binding is tried(going to).
>>>
>>>> guarantee that different microarchitectures have equivalent internal
>>>> clock domains - I'm not sure if "the SMMU's underlying bus access" is
>>>> meant to refer to accesses *by* the SMMU, i.e. page table walks,
>>>> accesses *through* the SMMU by upstream masters, or both
>>>
>>> In the above QCOM case, it is actually both. Its the same path for both the
>>> page table walker and upstream masters.
>
>Right, that's what I feared. As far as I can make out the current ARM
>implementations, transactions passing through will require at least
>TBUn_BCLK for the appropriate TBU, but would also need the page table
>walker clocked with CCLK to resolve TLB misses. But then the programming
>interface is also in the CCLK domain (not counting the incoming APB or
>AXI clock for the actual slave port itself). Thus this 'generic' clock
>binding already isn't compatible with MMU-40x/500.
>

Right, this implementation's clock bindings are not going to compatible with
MMU-500. There is also another soc which integrates MMU-500.  So
will have to add the clock bindings for MMU-500 as well separately.
Also in MMU-500 i saw that there is a possibility where the clock-domain
can be shared between the TCU logic, programming interface and PTW read
channel.  Does this mean that the TCU-clock has to be 'ON' for both register
access and PTW, similar to above ?. So for MMU-500 clock bindings there
can be a CFG_CLK (optional and not required in shared case), TBUn_CLK and
TCU_CLK

Regards,
 Sricharan

>>>> differences are rather significant. I'd also note that an MMU-500
>>>> configuration may have up to *33* clocks.
>>>>
>>>> Either way, the QCOM implementation deserves its own compatible if only
>>>> for the sake of the imp-def gaps in the architecture (e.g. FSR.SS
>>>> behaviour WRT to IRQs as touched upon in the other thread).
>>>>
>>>
>>> Ok, slightly unclear, so you mean then *clocks* are not good enough reason
>>> to have a new compatible ?
>>
>> I beleive Robin's point was even if the clocks didn't matter, there are
>> other reasons we should have the QCOM-specific compatible string.
>>
>> So we should have one regardless.
>
>Exactly.
>
>Robin.
>
>>
>> Thanks,
>> Mark.
>>
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
