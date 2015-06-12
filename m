From: Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH v2 1/3] drm/exynos: fimd: ensure proper hw state in
 fimd_clear_channel()
Date: Fri, 12 Jun 2015 18:08:19 +0900
Message-ID: <557AA183.1070100@samsung.com>
References: <1433319984-18683-1-git-send-email-m.szyprowski@samsung.com>
 <1433319984-18683-2-git-send-email-m.szyprowski@samsung.com>
 <5579A38C.8040604@samsung.com> <557AA0D3.8010808@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <557AA0D3.8010808@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On 2015=EB=85=84 06=EC=9B=94 12=EC=9D=BC 18:05, Marek Szyprowski wrote:
> Hello,
>=20
> On 2015-06-11 17:04, Inki Dae wrote:
>> On 2015=EB=85=84 06=EC=9B=94 03=EC=9D=BC 17:26, Marek Szyprowski wro=
te:
>>> One should not do any assumptions on the stare of the fimd hardware
>>> during driver initialization, so to properly reset fimd before enab=
ling
>>> IOMMU, one should ensure that all power domains and clocks are real=
ly
>>> enabled. This patch adds pm_runtime and clocks management in the
>>> fimd_clear_channel() function to ensure that any access to fimd
>>> registers will be performed with clocks and power domains enabled.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.u=
k>
>>> ---
>>>   drivers/gpu/drm/exynos/exynos_drm_fimd.c | 22 ++++++++++++++++++-=
---
>>>   1 file changed, 18 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
>>> b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
>>> index 96618534358e..3ec9d4299a86 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
>>> @@ -242,12 +242,21 @@ static void
>>> fimd_enable_shadow_channel_path(struct fimd_context *ctx,
>>>       writel(val, ctx->regs + SHADOWCON);
>>>   }
>>>   +static int fimd_enable_vblank(struct exynos_drm_crtc *crtc);
>>> +static void fimd_disable_vblank(struct exynos_drm_crtc *crtc);
>> You can remove abvoe declarations. See the below comment.
>>
>>> +
>>>   static void fimd_clear_channel(struct fimd_context *ctx)
>>>   {
>>>       unsigned int win, ch_enabled =3D 0;
>>>         DRM_DEBUG_KMS("%s\n", __FILE__);
>>>   +    /* Hardware is in unknown state, so ensure it gets enabled
>>> properly */
>>> +    pm_runtime_get_sync(ctx->dev);
>>> +
>>> +    clk_prepare_enable(ctx->bus_clk);
>>> +    clk_prepare_enable(ctx->lcd_clk);
>>> +
>>>       /* Check if any channel is enabled. */
>>>       for (win =3D 0; win < WINDOWS_NR; win++) {
>>>           u32 val =3D readl(ctx->regs + WINCON(win));
>>> @@ -265,12 +274,17 @@ static void fimd_clear_channel(struct
>>> fimd_context *ctx)
>>>         /* Wait for vsync, as disable channel takes effect at next
>>> vsync */
>>>       if (ch_enabled) {
>>> -        unsigned int state =3D ctx->suspended;
>>> -
>>> -        ctx->suspended =3D 0;
>>> +        ctx->suspended =3D false;
>>> +        fimd_enable_vblank(ctx->crtc);
>> I think you can call enable_vblank callback instead of
>> fimd_enable_vblank function because ctx object has exynos_crtc objec=
t.
>>
>> i.e.,
>>         struct exynos_drm_crtc_ops *ops =3D ctx->crtc->ops;
>>         ...
>>         if (ops->enable_vblank)
>>             ops->enable_vblank(ctx->crtc);
>>         ...
>=20
> Well, I don't like such indirect calls to known functions, but if you
> prefer
> this approach I will send an updated patch in a minute. There is also
> alternative
> way of getting rid of forward declarations. Code of fimd_enable_vblan=
k and
> fimd_disable_vblank can be moved closer to fimd_wait_vblank function.
> I will also send such alternative patch. Feel free to select the one
> that better
> fits your preferences.

Latter one it's better.

Thanks,
Inki Dae

>=20
>>>           fimd_wait_for_vblank(ctx->crtc);
>>> -        ctx->suspended =3D state;
>>> +        fimd_disable_vblank(ctx->crtc);
>> Ditto.
>>
>> Thanks,
>> Inki Dae
>>
>>> +        ctx->suspended =3D true;
>>>       }
>>> +
>>> +    clk_disable_unprepare(ctx->lcd_clk);
>>> +    clk_disable_unprepare(ctx->bus_clk);
>>> +
>>> +    pm_runtime_put(ctx->dev);
>>>   }
>>>     static int fimd_iommu_attach_devices(struct fimd_context *ctx,
>>>
>>
>=20
> Best regards
