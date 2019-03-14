From: Helen Koike <helen.koike@collabora.com>
Subject: Re: [PATCH v2 1/5] drm/rockchip: fix fb references in async update
Date: Thu, 14 Mar 2019 14:51:20 -0300
Message-ID: <dd7de9ff-0ac8-80fd-b88b-250bdf988921@collabora.com>
References: <20190312022204.2775-1-helen.koike@collabora.com>
 <20190312022204.2775-2-helen.koike@collabora.com>
 <20190312073438.05ad8173@collabora.com>
 <f888a2d0-c6b1-8995-7254-ba2923dd22f9@collabora.com>
 <20190312165243.5b771e4a@collabora.com>
 <CAAFQd5CCEDaxLbw0E9NJJ-tEcHd8-Lidvcvt8qfPAnKu7uuj8w@mail.gmail.com>
 <05750143-708b-b84e-af67-82ec6815bd89@daenzer.net>
 <ed44e1f4-07da-b1cb-b5cb-d34d29758502@collabora.com>
 <d91d5582-3ccf-2249-21ee-9ccf115096b2@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d91d5582-3ccf-2249-21ee-9ccf115096b2@daenzer.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, Tomasz Figa <tfiga@chromium.org>, Boris Brezillon <boris.brezillon@collabora.com>
Cc: =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@google.com>, Sean Paul <seanpaul@google.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, kernel@collabora.com, nicholas.kazlauskas@amd.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org



On 3/14/19 6:15 AM, Michel Dänzer wrote:
> On 2019-03-13 7:08 p.m., Helen Koike wrote:
>> On 3/13/19 6:58 AM, Michel Dänzer wrote:
>>> On 2019-03-13 4:42 a.m., Tomasz Figa wrote:
>>>> On Wed, Mar 13, 2019 at 12:52 AM Boris Brezillon
>>>> <boris.brezillon@collabora.com> wrote:
>>>>> On Tue, 12 Mar 2019 12:34:45 -0300
>>>>> Helen Koike <helen.koike@collabora.com> wrote:
>>>>>> On 3/12/19 3:34 AM, Boris Brezillon wrote:
>>>>>>> On Mon, 11 Mar 2019 23:21:59 -0300
>>>>>>> Helen Koike <helen.koike@collabora.com> wrote:
>>>>>>>
>>>>>>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>>>>>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>>>>>>> @@ -912,30 +912,31 @@ static void vop_plane_atomic_async_update(struct drm_plane *plane,
>>>>>>>>                                      struct drm_plane_state *new_state)
>>>>>>>>  {
>>>>>>>>    struct vop *vop = to_vop(plane->state->crtc);
>>>>>>>> -  struct drm_plane_state *plane_state;
>>>>>>>> +  struct drm_framebuffer *old_fb = plane->state->fb;
>>>>>>>>
>>>>>>>> -  plane_state = plane->funcs->atomic_duplicate_state(plane);
>>>>>>>> -  plane_state->crtc_x = new_state->crtc_x;
>>>>>>>> -  plane_state->crtc_y = new_state->crtc_y;
>>>>>>>> -  plane_state->crtc_h = new_state->crtc_h;
>>>>>>>> -  plane_state->crtc_w = new_state->crtc_w;
>>>>>>>> -  plane_state->src_x = new_state->src_x;
>>>>>>>> -  plane_state->src_y = new_state->src_y;
>>>>>>>> -  plane_state->src_h = new_state->src_h;
>>>>>>>> -  plane_state->src_w = new_state->src_w;
>>>>>>>> -
>>>>>>>> -  if (plane_state->fb != new_state->fb)
>>>>>>>> -          drm_atomic_set_fb_for_plane(plane_state, new_state->fb);
>>>>>>>> -
>>>>>>>> -  swap(plane_state, plane->state);
>>>>>>>> -
>>>>>>>> -  if (plane->state->fb && plane->state->fb != new_state->fb) {
>>>>>>>> +  /*
>>>>>>>> +   * A scanout can still be occurring, so we can't drop the reference to
>>>>>>>> +   * the old framebuffer. To solve this we get a reference to old_fb and
>>>>>>>> +   * set a worker to release it later.
>>>>>>>
>>>>>>> Hm, doesn't look like an async update to me if we have to wait for the
>>>>>>> next VBLANK to happen to get the new content on the screen. Maybe we
>>>>>>> should reject async updates when old_fb != new_fb in the rk
>>>>>>> ->async_check() hook.
>>>>>>
>>>>>> Unless I am misunderstanding this, we don't wait here, we just grab a
>>>>>> reference to the fb in case it is being still used by the hw, so it
>>>>>> doesn't get released prematurely.
>>>>>
>>>>> I was just reacting to the comment that says the new FB should stay
>>>>> around until the next VBLANK event happens. If the FB must stay around
>>>>> that probably means the HW is still using, which made me wonder if this
>>>>> HW actually supports async update (where async means "update now and
>>>>> don't care about about tearing"). Or maybe it takes some time to switch
>>>>> to the new FB and waiting for the next VBLANK to release the old FB was
>>>>> an easy solution to not wait for the flip to actually happen in
>>>>> ->async_update() (which is kind of a combination of async+non-blocking).
>>>>
>>>> The hardware switches framebuffers on vblank, so whatever framebuffer
>>>> is currently being scanned out from needs to stay there until the
>>>> hardware switches to the new one in shadow registers. If that doesn't
>>>> happen, you get IOMMU faults and the display controller stops working
>>>> since we don't have any fault handling currently, just printing a
>>>> message.
>>>
>>> Sounds like your hardware doesn't actually support async flips. It's
>>> probably better for the driver not to pretend otherwise.
>>
>> I think wee need to clarify the meaning of the async_update callback
>> (and we should clarify it in the docs).
>>
>> The way I understand what the async_update callback should do is: don't
>> block (i.e. don't wait for the next vblank),
> 
> Note that those are two separate things. "Async flips" are about "don't
> wait for vblank", not about "don't block".
> 
> 
>> and update the hw state at some point with the latest state from the
>> last call to async_update.
>>
>> Which means that: any driver can implement the async_update callback,
>> independently if it supports changing its state right away or not.
>> If hw supports, async_update can change the hw state right away, if not,
>> then changes will be applied in the next vblank (it can even amend the
>> pending commit if there is one).
>> With this, we can remove all the legacy cursor code to use the
>> async_update callback, since async_update can be called 100 times before
>> the next vblank, and the latest state will be set to the hw without
>> waiting 100 vblanks.
>>
>> Please, let me know if this is your understanding as well. If not, then
>> we need to remodel things.
> 
> While this may make sense for cursor updates, I don't think it does for
> async flips. If the flip only actually takes effect during the next
> vblank, it doesn't really fit the definition and userspace expectation
> of an async flip. It's better to clearly communicate to userspace that
> the hardware cannot do async flips, than to pretend it can and fake
> them. Userspace has to deal with this anyway, since async flips weren't
> always supported in general.
> 
> 

What do you think if we separate two concepts here:

- amend mode: works like cursor updates, i.e, update the hw state at
some point with the latest state from the last call to async_update. No
special hardware support is required.

- async update: update hw state immediately. This depends if the hw
supports it or not.

Every async update is an amend, but the opposite is not necessarily true.

What do you think if we rename the current async_update to amend_update,
and we add a parameter "force_async" to it? (or maybe
force_immediate_update?)
Then amend_check with force_async=1 would fail if the hardware doesn't
support it (we could also add flags in the capabilities to inform
userspace the expected behaviour of things and if the hw supports
force_sync).

Like this, we can implement the cursors using the amend_update (which is
now called async_update), and async_flips with amend_update with
force_async=1.

If this sounds a reasonable proposal I can try to work on a prof of
concept. What do you think? Let me know if you have any other ideas.

Thanks,
Helen
