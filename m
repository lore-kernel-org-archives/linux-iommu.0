From: Helen Koike <helen.koike@collabora.com>
Subject: [PATCH v3] drm/rockchip: update cursors asynchronously through
 atomic.
Date: Thu, 22 Nov 2018 21:30:49 -0200
Message-ID: <d3fb3b21-6c3d-6b01-727b-dbd66540ce92@collabora.com>
References: <20181119190805.19139-1-helen.koike@collabora.com>
 <CAAFQd5DDZwhdMDbrHthQwm2bQ3+NoZNcemAktVTxkR3=LfnnTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAFQd5DDZwhdMDbrHthQwm2bQ3+NoZNcemAktVTxkR3=LfnnTg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, David Airlie <airlied@linux.ie>, "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Gustavo Padovan <gustavo.padovan@collabora.com>, Sean Paul <seanpaul@google.com>, kernel@collabora.com, =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@google.com>
List-Id: iommu@lists.linux-foundation.org

Hi Tomasz,

On 11/20/18 4:48 AM, Tomasz Figa wrote:
> Hi Helen,
> 
> On Tue, Nov 20, 2018 at 4:08 AM Helen Koike <helen.koike@collabora.com> wrote:
>>
>> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>
>> Add support to async updates of cursors by using the new atomic
>> interface for that.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> [updated for upstream]
>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>>
>> ---
>> Hello,
>>
>> This is the third version of the async-plane update suport to the
>> Rockchip driver.
>>
> 
> Thanks for a quick respin. Please see my comments inline. (I'll try to
> be better at responding from now on...)
> 
>> I tested running igt kms_cursor_legacy and kms_atomic tests using a 96Boards Ficus.
>>
>> Note that before the patch, the following igt tests failed:
>>
>>         basic-flip-before-cursor-atomic
>>         basic-flip-before-cursor-legacy
>>         cursor-vs-flip-atomic
>>         cursor-vs-flip-legacy
>>         cursor-vs-flip-toggle
>>         flip-vs-cursor-atomic
>>         flip-vs-cursor-busy-crc-atomic
>>         flip-vs-cursor-busy-crc-legacy
>>         flip-vs-cursor-crc-atomic
>>         flip-vs-cursor-crc-legacy
>>         flip-vs-cursor-legacy
>>
>> Full log: https://people.collabora.com/~koike/results-4.20/html/
>>
>> Now with the patch applied the following were fixed:
>>         basic-flip-before-cursor-atomic
>>         basic-flip-before-cursor-legacy
>>         flip-vs-cursor-atomic
>>         flip-vs-cursor-legacy
>>
>> Full log: https://people.collabora.com/~koike/results-4.20-async/html/
> 
> Could you also test modetest, with the -C switch to test the legacy
> cursor API? I remember it triggering crashes due to synchronization
> issues easily.

Sure. I tested with
$ modetest -M rockchip -s 37:1920x1080 -C

I also vary the mode but I couldn't trigger any crashes.

> 
>>
>> Tomasz, as you mentined in v2 about waiting the hardware before updating
>> the framebuffer, now I call the loop you pointed out in the async path,
>> was that what you had in mind? Or do you think I would make sense to
>> call the vop_crtc_atomic_flush() instead of just exposing that loop?
>>
>> Thanks
>> Helen
>>
>> Changes in v3:
>> - Rebased on top of drm-misc
>> - Fix missing include in rockchip_drm_vop.c
>> - New function vop_crtc_atomic_commit_flush
>>
>> Changes in v2:
>> - v2: https://patchwork.freedesktop.org/patch/254180/
>> - Change the framebuffer as well to cover jumpy cursor when hovering
>>   text boxes or hyperlink. (Tomasz)
>> - Use the PSR inhibit mechanism when accessing VOP hardware instead of
>>   PSR flushing (Tomasz)
>>
>> Changes in v1:
>> - Rebased on top of drm-misc
>> - In async_check call drm_atomic_helper_check_plane_state to check that
>>   the desired plane is valid and update various bits of derived state
>>   (clipped coordinates etc.)
>> - In async_check allow to configure new scaling in the fast path.
>> - In async_update force to flush all registered PSR encoders.
>> - In async_update call atomic_update directly.
>> - In async_update call vop_cfg_done needed to set the vop registers and take effect.
>>
>>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |  36 -------
>>  drivers/gpu/drm/rockchip/rockchip_drm_psr.c |  37 +++++++
>>  drivers/gpu/drm/rockchip/rockchip_drm_psr.h |   3 +
>>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 108 +++++++++++++++++---
>>  4 files changed, 131 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>> index ea18cb2a76c0..08bec50d9c5d 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>> @@ -127,42 +127,6 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
>>         return ERR_PTR(ret);
>>  }
>>
>> -static void
>> -rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state)
>> -{
>> -       struct drm_crtc *crtc;
>> -       struct drm_crtc_state *crtc_state;
>> -       struct drm_encoder *encoder;
>> -       u32 encoder_mask = 0;
>> -       int i;
>> -
>> -       for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
>> -               encoder_mask |= crtc_state->encoder_mask;
>> -               encoder_mask |= crtc->state->encoder_mask;
>> -       }
>> -
>> -       drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
>> -               rockchip_drm_psr_inhibit_get(encoder);
>> -}
>> -
>> -static void
>> -rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state)
>> -{
>> -       struct drm_crtc *crtc;
>> -       struct drm_crtc_state *crtc_state;
>> -       struct drm_encoder *encoder;
>> -       u32 encoder_mask = 0;
>> -       int i;
>> -
>> -       for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
>> -               encoder_mask |= crtc_state->encoder_mask;
>> -               encoder_mask |= crtc->state->encoder_mask;
>> -       }
>> -
>> -       drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
>> -               rockchip_drm_psr_inhibit_put(encoder);
>> -}
>> -
>>  static void
>>  rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
>>  {
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
>> index 01ff3c858875..22a70ab6e214 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
>> @@ -13,6 +13,7 @@
>>   */
>>
>>  #include <drm/drmP.h>
>> +#include <drm/drm_atomic.h>
>>  #include <drm/drm_crtc_helper.h>
>>
>>  #include "rockchip_drm_drv.h"
>> @@ -109,6 +110,42 @@ int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder)
>>  }
>>  EXPORT_SYMBOL(rockchip_drm_psr_inhibit_put);
>>
>> +void rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state)
>> +{
>> +       struct drm_crtc *crtc;
>> +       struct drm_crtc_state *crtc_state;
>> +       struct drm_encoder *encoder;
>> +       u32 encoder_mask = 0;
>> +       int i;
>> +
>> +       for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
>> +               encoder_mask |= crtc_state->encoder_mask;
>> +               encoder_mask |= crtc->state->encoder_mask;
>> +       }
>> +
>> +       drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
>> +               rockchip_drm_psr_inhibit_get(encoder);
>> +}
>> +EXPORT_SYMBOL(rockchip_drm_psr_inhibit_get_state);
>> +
>> +void rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state)
>> +{
>> +       struct drm_crtc *crtc;
>> +       struct drm_crtc_state *crtc_state;
>> +       struct drm_encoder *encoder;
>> +       u32 encoder_mask = 0;
>> +       int i;
>> +
>> +       for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
>> +               encoder_mask |= crtc_state->encoder_mask;
>> +               encoder_mask |= crtc->state->encoder_mask;
>> +       }
>> +
>> +       drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
>> +               rockchip_drm_psr_inhibit_put(encoder);
>> +}
>> +EXPORT_SYMBOL(rockchip_drm_psr_inhibit_put_state);
>> +
>>  /**
>>   * rockchip_drm_psr_inhibit_get - acquire PSR inhibit on given encoder
>>   * @encoder: encoder to obtain the PSR encoder
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
>> index 860c62494496..25350ba3237b 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
>> @@ -20,6 +20,9 @@ void rockchip_drm_psr_flush_all(struct drm_device *dev);
>>  int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder);
>>  int rockchip_drm_psr_inhibit_get(struct drm_encoder *encoder);
>>
>> +void rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state);
>> +void rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state);
>> +
>>  int rockchip_drm_psr_register(struct drm_encoder *encoder,
>>                         int (*psr_set)(struct drm_encoder *, bool enable));
>>  void rockchip_drm_psr_unregister(struct drm_encoder *encoder);
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> index fb70fb486fbf..176d6e8207ed 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> @@ -15,6 +15,7 @@
>>  #include <drm/drm.h>
>>  #include <drm/drmP.h>
>>  #include <drm/drm_atomic.h>
>> +#include <drm/drm_atomic_uapi.h>
>>  #include <drm/drm_crtc.h>
>>  #include <drm/drm_crtc_helper.h>
>>  #include <drm/drm_flip_work.h>
>> @@ -819,10 +820,99 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>>         spin_unlock(&vop->reg_lock);
>>  }
>>
>> +static int vop_plane_atomic_async_check(struct drm_plane *plane,
>> +                                       struct drm_plane_state *state)
>> +{
>> +       struct vop_win *vop_win = to_vop_win(plane);
>> +       const struct vop_win_data *win = vop_win->data;
>> +       int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
>> +                                       DRM_PLANE_HELPER_NO_SCALING;
>> +       int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
>> +                                       DRM_PLANE_HELPER_NO_SCALING;
>> +       struct drm_crtc_state *crtc_state;
>> +       int ret;
>> +
>> +       if (plane != state->crtc->cursor)
>> +               return -EINVAL;
>> +
>> +       if (!plane->state)
>> +               return -EINVAL;
>> +
>> +       if (!plane->state->fb)
>> +               return -EINVAL;
>> +
>> +       if (state->state)
>> +               crtc_state = drm_atomic_get_existing_crtc_state(state->state,
>> +                                                               state->crtc);
>> +       else /* Special case for asynchronous cursor updates. */
>> +               crtc_state = plane->crtc->state;
>> +
>> +       ret = drm_atomic_helper_check_plane_state(plane->state,
>> +                                                 crtc_state,
>> +                                                 min_scale, max_scale,
>> +                                                 true, true);
>> +       return ret;
>> +}
>> +
>> +static void vop_crtc_atomic_commit_flush(struct drm_crtc *crtc,
>> +                                        struct drm_crtc_state *old_crtc_state)
>> +{
>> +       struct drm_atomic_state *old_state = old_crtc_state->state;
>> +       struct drm_plane_state *old_plane_state, *new_plane_state;
>> +       struct vop *vop = to_vop(crtc);
>> +       struct drm_plane *plane;
>> +       int i;
>> +
>> +       for_each_oldnew_plane_in_state(old_state, plane, old_plane_state,
>> +                                      new_plane_state, i) {
> 
> Hmm, from what I can see, we're not going through the full atomic
> commit sequence, with state flip, so I'm not sure where we would get
> the new state here from.
> 
>> +               if (!old_plane_state->fb)
>> +                       continue;
>> +
>> +               if (old_plane_state->fb == new_plane_state->fb)
>> +                       continue;
>> +
>> +               drm_framebuffer_get(old_plane_state->fb);
>> +               WARN_ON(drm_crtc_vblank_get(crtc) != 0);
>> +               drm_flip_work_queue(&vop->fb_unref_work, old_plane_state->fb);
>> +               set_bit(VOP_PENDING_FB_UNREF, &vop->pending);
>> +       }
>> +}
>> +
>> +static void vop_plane_atomic_async_update(struct drm_plane *plane,
>> +                                         struct drm_plane_state *new_state)
>> +{
>> +       struct vop *vop = to_vop(plane->state->crtc);
>> +
>> +       if (vop->crtc.state->state)
>> +               vop_crtc_atomic_commit_flush(&vop->crtc, vop->crtc.state);
> 
> Since we just operate on one plane here, we could just do like this:
> 
> if (plane->state->fb && plane->state->fb != new_state->fb) {
>                drm_framebuffer_get(plane->state->fb);
>                WARN_ON(drm_crtc_vblank_get(crtc) != 0);
>                drm_flip_work_queue(&vop->fb_unref_work, plane->state->fb);
>                set_bit(VOP_PENDING_FB_UNREF, &vop->pending);
> }
> 
> However, we cannot simply to this here, because it races with the
> vblank interrupt. We need to program the hw plane with the new fb
> first and trigger the update. This needs all the careful handling that
> is done in vop_crtc_atomic_flush() and so my original suggestion to
> just call it.

vop_crtc_atomic_flush() also updates the crtc->state->event, I don't
think we want that.

And actually I don't think we have this race condition, please see below

> 
> Of course to call it in its current shape, one needs to have a full
> atomic state from a commit, after a flip, but we only have the new
> plane state here. Perhaps you could duplicate existing state, update
> the desired plane state, flip and then call vop_crtc_atomic_flush()?

Could you please clarify your proposal? You mean duplicating
plane->state ? I'm trying to see how this would fit it in the code.
The drm_atomic_state structure at plate->state->state is actually always
NULL (as an async update is applied right away).


> 
> Best regards,
> Tomasz
> 

>From your comment in v2:

> Isn't this going to drop the old fb reference on the floor without
> waiting for the hardware to actually stop scanning out from it?

I've been trying to analyze this better, I also got some help from
Gustavo Padovan, and I think there is no problem here as the
configuration we are doing here will just be taken into consideration by
the hardware in the next vblank, so I guess we can set and re-set
plane->fb as much as we want.

>From the async_update docs:

     *  - Some hw might still scan out the old buffer until the next
     *    vblank, however we let go of the fb references as soon as
     *    we run this hook. For now drivers must implement their own workers
     *    for deferring if needed, until a common solution is created.

So the idea is to let the reference go asap, then we shouldn't need an
extra drm_framebuffer_get() as done by vop_crtc_atomic_flush().

Does it make sense to you?

Unless I am missing something, the patch v2 is essentially correct, if
not, then vc4 driver is also broken.

Please, let me know what you think and I'll send the v4.

Regards,
Helen
