From: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Date: Wed, 10 Apr 2019 11:28:27 +0100
Message-ID: <9036b1e7-bb1b-d681-829b-10088bc4c227@arm.com>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
 <CAL_Jsq+wAUS=gukDLoY6DWP40w4Wtyd_Y4B2S3KMCx2ekL97qg@mail.gmail.com>
 <CAAObsKCnycxxKWA+bUeU9vOu53eT9WZVkzdZ0KCtW9Xj9cV8Cw@mail.gmail.com>
 <CAL_Jsq+qcLRFX0xyKuFEDW3+n6oukfmgemtO4MumCFp_-qqcUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+qcLRFX0xyKuFEDW3+n6oukfmgemtO4MumCFp_-qqcUg@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, Linux IOMMU <iommu@lists.linux-foundation.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, "Marty E . Plummer" <hanetzer@startmail.com>, Robin Murphy <robin.murphy@arm.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On 09/04/2019 17:15, Rob Herring wrote:
> On Tue, Apr 9, 2019 at 10:56 AM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>>
>> On Mon, 8 Apr 2019 at 23:04, Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Fri, Apr 5, 2019 at 7:30 AM Steven Price <steven.price@arm.com> wrote:
>>>>
>>>> On 01/04/2019 08:47, Rob Herring wrote:
>>>>> This adds the initial driver for panfrost which supports Arm Mali
>>>>> Midgard and Bifrost family of GPUs. Currently, only the T860 and
>>>>> T760 Midgard GPUs have been tested.
>>>
>>> [...]
>>>>> +
>>>>> +             if (status & JOB_INT_MASK_ERR(j)) {
>>>>> +                     job_write(pfdev, JS_COMMAND_NEXT(j), JS_COMMAND_NOP);
>>>>> +                     job_write(pfdev, JS_COMMAND(j), JS_COMMAND_HARD_STOP_0);
>>>>
>>>> Hard-stopping an already completed job isn't likely to do very much :)
>>>> Also you are using the "_0" version which is only valid when "job chain
>>>> disambiguation" is present.
>>
>> Yeah, guess that can be removed.
> 
> Steven, TBC, are you suggesting removing both lines or leaving
> JS_COMMAND_NOP? I don't think we can ever have a pending job at this
> point as there's no queuing. So the NOP probably isn't needed, but
> doesn't hurt to have it either.

Both lines are redundant and can be removed. But equally neither will
cause any problems.

Writing NOP into the next register is basically only needed if you know
there's a job there which you no longer want to execute.

kbase does this in certain situations. The main one is on a GPU without
command chain disambiguation if you want to kill a particular job
there's a potential race. For example:

 * Submit job A, followed by job B to slot 0. Job A is currently
executing, job B is waiting in the _NEXT registers.

 * Kernel decides it wants to kill job A (it's taking too long, or the
application has quit).

 * Simply executing a JS_COMMAND_HARD_STOP is racy. If job A finishes
just before doing the register write, then it's actually job B that gets
killed (and it's not always safe to just re-execute a killed job).

 * Instead write NOP to JS_COMMAND_NEXT, then check (again) whether the
job currently running is the one you want. When you then HARD_STOP you
either hit the correct job, or 'miss' and do nothing.

Job chain disambiguation solves this problem by allowing the kernel to
tag each job with a flag, the hard-stop can then be targetted at the job
with the correct flag. Writing NOP into JS_COMMAND_NEXT is also useful
if in the above situation you want to kill job B. In that case you can't
hard-stop it (it hasn't start), so you simply want to remove it from the
_NEXT registers.

>>>> I suspect in this case you should also be signalling the fence? At the
>>>> moment you rely on the GPU timeout recovering from the fault.
>>>
>>> I'll defer to Tomeu who wrote this (IIRC).
>>
>> Yes, that would be an improvement.
> 
> Actually, I think that would break recovery because the job timeout
> will bail out if the done fence is signaled already. Perhaps we want
> to timeout immediately if that is possible with the scheduler.

Ideally you would signal the fence with an error code (which is
presumably what recovery does). There's no actual need to trigger a
timeout. I'm not sure quite how the DRM infrastructure handles this though.

Steve
