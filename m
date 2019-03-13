From: Helen Koike <helen.koike@collabora.com>
Subject: Re: [PATCH v2 1/5] drm/rockchip: fix fb references in async update
Date: Wed, 13 Mar 2019 15:08:02 -0300
Message-ID: <ed44e1f4-07da-b1cb-b5cb-d34d29758502@collabora.com>
References: <20190312022204.2775-1-helen.koike@collabora.com>
 <20190312022204.2775-2-helen.koike@collabora.com>
 <20190312073438.05ad8173@collabora.com>
 <f888a2d0-c6b1-8995-7254-ba2923dd22f9@collabora.com>
 <20190312165243.5b771e4a@collabora.com>
 <CAAFQd5CCEDaxLbw0E9NJJ-tEcHd8-Lidvcvt8qfPAnKu7uuj8w@mail.gmail.com>
 <05750143-708b-b84e-af67-82ec6815bd89@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <05750143-708b-b84e-af67-82ec6815bd89@daenzer.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, Tomasz Figa <tfiga@chromium.org>, Boris Brezillon <boris.brezillon@collabora.com>
Cc: =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@google.com>, Sean Paul <seanpaul@google.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, kernel@collabora.com, nicholas.kazlauskas@amd.com, "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org



On 3/13/19 6:58 AM, Michel Dänzer wrote:
> On 2019-03-13 4:42 a.m., Tomasz Figa wrote:
>> On Wed, Mar 13, 2019 at 12:52 AM Boris Brezillon
>> <boris.brezillon@collabora.com> wrote:
>>>
>>> On Tue, 12 Mar 2019 12:34:45 -0300
>>> Helen Koike <helen.koike@collabora.com> wrote:
>>>
>>>> On 3/12/19 3:34 AM, Boris Brezillon wrote:
>>>>> On Mon, 11 Mar 2019 23:21:59 -0300
>>>>> Helen Koike <helen.koike@collabora.com> wrote:
>>>>>
>>>>>> In the case of async update, modifications are done in place, i.e. in the
>>>>>> current plane state, so the new_state is prepared and the new_state is
>>>>>> cleanup up (instead of the old_state, diferrently on what happen in a
>>>>>
>>>>>   ^ cleaned up                              ^ differently (but maybe
>>>>> "unlike what happens" is more appropriate here).
>>>>>
>>>>>> normal sync update).
>>>>>> To cleanup the old_fb properly, it needs to be placed in the new_state
>>>>>> in the end of async_update, so cleanup call will unreference the old_fb
>>>>>> correctly.
>>>>>>
>>>>>> Also, the previous code had a:
>>>>>>
>>>>>>    plane_state = plane->funcs->atomic_duplicate_state(plane);
>>>>>>    ...
>>>>>>    swap(plane_state, plane->state);
>>>>>>
>>>>>>    if (plane->state->fb && plane->state->fb != new_state->fb) {
>>>>>>    ...
>>>>>>    }
>>>>>>
>>>>>> Which was wrong, as the fb were just assigned to be equal, so this if
>>>>>> statement nevers evaluates to true.
>>>>>>
>>>>>> Another details is that the function drm_crtc_vblank_get() can only be
>>>>>> called when vop->is_enabled is true, otherwise it has no effect and
>>>>>> trows a WARN_ON().
>>>>>>
>>>>>> Calling drm_atomic_set_fb_for_plane() (which get a referent of the new
>>>>>> fb and pus the old fb) is not required, as it is taken care by
>>>>>> drm_mode_cursor_universal() when calling
>>>>>> drm_atomic_helper_update_plane().
>>>>>>
>>>>>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>>>>>>
>>>>>> ---
>>>>>> Hello,
>>>>>>
>>>>>> I tested on the rockchip ficus v1.1 using igt plane_cursor_legacy and
>>>>>> kms_cursor_legacy and I didn't see any regressions.
>>>>>>
>>>>>> Changes in v2: None
>>>>>>
>>>>>>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 42 ++++++++++++---------
>>>>>>  1 file changed, 24 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>>>>> index c7d4c6073ea5..a1ee8c156a7b 100644
>>>>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>>>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>>>>> @@ -912,30 +912,31 @@ static void vop_plane_atomic_async_update(struct drm_plane *plane,
>>>>>>                                      struct drm_plane_state *new_state)
>>>>>>  {
>>>>>>    struct vop *vop = to_vop(plane->state->crtc);
>>>>>> -  struct drm_plane_state *plane_state;
>>>>>> +  struct drm_framebuffer *old_fb = plane->state->fb;
>>>>>>
>>>>>> -  plane_state = plane->funcs->atomic_duplicate_state(plane);
>>>>>> -  plane_state->crtc_x = new_state->crtc_x;
>>>>>> -  plane_state->crtc_y = new_state->crtc_y;
>>>>>> -  plane_state->crtc_h = new_state->crtc_h;
>>>>>> -  plane_state->crtc_w = new_state->crtc_w;
>>>>>> -  plane_state->src_x = new_state->src_x;
>>>>>> -  plane_state->src_y = new_state->src_y;
>>>>>> -  plane_state->src_h = new_state->src_h;
>>>>>> -  plane_state->src_w = new_state->src_w;
>>>>>> -
>>>>>> -  if (plane_state->fb != new_state->fb)
>>>>>> -          drm_atomic_set_fb_for_plane(plane_state, new_state->fb);
>>>>>> -
>>>>>> -  swap(plane_state, plane->state);
>>>>>> -
>>>>>> -  if (plane->state->fb && plane->state->fb != new_state->fb) {
>>>>>> +  /*
>>>>>> +   * A scanout can still be occurring, so we can't drop the reference to
>>>>>> +   * the old framebuffer. To solve this we get a reference to old_fb and
>>>>>> +   * set a worker to release it later.
>>>>>
>>>>> Hm, doesn't look like an async update to me if we have to wait for the
>>>>> next VBLANK to happen to get the new content on the screen. Maybe we
>>>>> should reject async updates when old_fb != new_fb in the rk
>>>>> ->async_check() hook.
>>>>
>>>> Unless I am misunderstanding this, we don't wait here, we just grab a
>>>> reference to the fb in case it is being still used by the hw, so it
>>>> doesn't get released prematurely.
>>>
>>> I was just reacting to the comment that says the new FB should stay
>>> around until the next VBLANK event happens. If the FB must stay around
>>> that probably means the HW is still using, which made me wonder if this
>>> HW actually supports async update (where async means "update now and
>>> don't care about about tearing"). Or maybe it takes some time to switch
>>> to the new FB and waiting for the next VBLANK to release the old FB was
>>> an easy solution to not wait for the flip to actually happen in
>>> ->async_update() (which is kind of a combination of async+non-blocking).
>>
>> The hardware switches framebuffers on vblank, so whatever framebuffer
>> is currently being scanned out from needs to stay there until the
>> hardware switches to the new one in shadow registers. If that doesn't
>> happen, you get IOMMU faults and the display controller stops working
>> since we don't have any fault handling currently, just printing a
>> message.
> 
> Sounds like your hardware doesn't actually support async flips. It's
> probably better for the driver not to pretend otherwise.
> 
> 

I think wee need to clarify the meaning of the async_update callback
(and we should clarify it in the docs).

The way I understand what the async_update callback should do is: don't
block (i.e. don't wait for the next vblank), and update the hw state at
some point with the latest state from the last call to async_update.

Which means that: any driver can implement the async_update callback,
independently if it supports changing its state right away or not.
If hw supports, async_update can change the hw state right away, if not,
then changes will be applied in the next vblank (it can even amend the
pending commit if there is one).
With this, we can remove all the legacy cursor code to use the
async_update callback, since async_update can be called 100 times before
the next vblank, and the latest state will be set to the hw without
waiting 100 vblanks.

Please, let me know if this is your understanding as well. If not, then
we need to remodel things.

Thanks,
Helen
