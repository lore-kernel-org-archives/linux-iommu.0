From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 2/3] iommu/arm-smmu: Add qcom implementation
Date: Wed, 4 Jan 2017 12:16:51 -0500
Message-ID: <CAF6AEGv0kKBgchm29kU_kfYb1JFBVvPi_GL-_FqeiPEoyt296w@mail.gmail.com>
References: <1483479056-15202-1-git-send-email-robdclark@gmail.com>
	<1483479056-15202-3-git-send-email-robdclark@gmail.com>
	<20170103222832.GA19199@jcrouse-lnx.qualcomm.com>
	<003201d2668f$1b8456e0$528d04a0$@codeaurora.org>
	<CAF6AEGuT_qq-UJK3sdvtVqxfsLBH-_jZVKz1vF383tOYVQpraw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAF6AEGuT_qq-UJK3sdvtVqxfsLBH-_jZVKz1vF383tOYVQpraw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 4, 2017 at 9:31 AM, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Jan 4, 2017 at 8:33 AM, Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>> Hi,
>>
>>>-----Original Message-----
>>>From: linux-arm-msm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-arm-msm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Jordan Crouse
>>>Sent: Wednesday, January 04, 2017 3:59 AM
>>>To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Sricharan R
>>><sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>Subject: Re: [RFC 2/3] iommu/arm-smmu: Add qcom implementation
>>>
>>>On Tue, Jan 03, 2017 at 04:30:55PM -0500, Rob Clark wrote:
>>>> At least on the db820c I have, with the firmware I have, I'm not seeing
>>>> the SS bit set, even though the iommu is in a stalled state.  So for
>>>> this implementation ignore not having SS bit set.
>>>
>>>The SS bit gets set if SCTLR.CFCFG is set to 1. It works in the downstream
>>>kernel because the GPU driver writes directly to SCTLR in the IOMMU hardware
>>>(which of course is a crime against humanity but that is one of the many reasons
>>>why it is a *downstream* driver).
>>>
>>>My understanding is that SCTLR.CFCFG == 0 should automatically terminate the
>>>transaction so I don't understand why we need to write to RESUME. I'm not
>>>doubting Rob's patch, I'm doubting why we need it in the first place. It seems
>>>that if we have to write it regardless of the value of CFCFG then we should
>>>probably just do that instead of relying on the SS bit.
>>>
>>
>> The patch is setting CFCFG to 1, hence we require clearing the fault with a
>> write to the RESUME register. I tested these patches on arm-smmu with
>> the DB820c and saw that the 'FSR_SS' bit is getting set properly after a
>> fault on the adreno smmu.
>
> I'll drop this patch and re-test.. hopefully later today.  It's
> possible that I was having the problem w/ SS not set due to some other
> issue.  (This was what I was seeing initially after just reverting the
> patch that removed the stall/resume stuff.)  I probably need to double
> checkk that CFCFG bit isn't getting cleared somewhere.
>

Ok, we can drop this patch, I've confirmed the SS bit is getting set
properly so we don't need a hack.  Not really sure what was going on
earlier when I had this problem before, maybe CFCFG wasn't getting set
properly..

BR,
-R
