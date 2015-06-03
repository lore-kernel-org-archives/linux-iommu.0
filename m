From: Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH 1/3] drm/exynos: fimd: ensure proper hw state in
 fimd_clear_channel()
Date: Wed, 03 Jun 2015 11:18:56 +0900
Message-ID: <556E6410.3040600@samsung.com>
References: <1433157316-6341-1-git-send-email-m.szyprowski@samsung.com>
 <1433157316-6341-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1433157316-6341-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

I have merged atomic patch series. Can you re-base your patch series on
top of exynos-drm-next?

Thanks,
Inki Dae

On 2015=EB=85=84 06=EC=9B=94 01=EC=9D=BC 20:15, Marek Szyprowski wrote:
> One should not do any assumptions on the stare of the fimd hardware
> during driver initialization, so to properly reset fimd before enabli=
ng
> IOMMU, one should ensure that all power domains and clocks are really
> enabled. This patch adds calls to power on/off in the
> fimd_clear_channel() function to ensure that any access to fimd
> registers will be performed with clocks and power domains enabled.
>=20
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c | 26 +++++++++++++++++-----=
----
>  1 file changed, 17 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/d=
rm/exynos/exynos_drm_fimd.c
> index a0edab833148..d10ad3920e78 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> @@ -242,12 +242,21 @@ static void fimd_enable_shadow_channel_path(str=
uct fimd_context *ctx,
>  	writel(val, ctx->regs + SHADOWCON);
>  }
> =20
> -static void fimd_clear_channel(struct fimd_context *ctx)
> +static int fimd_poweron(struct fimd_context *ctx);
> +static int fimd_poweroff(struct fimd_context *ctx);
> +
> +static int fimd_clear_channel(struct fimd_context *ctx)
>  {
>  	unsigned int win, ch_enabled =3D 0;
> +	int ret;
> =20
>  	DRM_DEBUG_KMS("%s\n", __FILE__);
> =20
> +	/* Hardware is in unknown state, so ensure it get enabled properly =
*/
> +	ret =3D fimd_poweron(ctx);
> +	if (ret)
> +		return ret;
> +
>  	/* Check if any channel is enabled. */
>  	for (win =3D 0; win < WINDOWS_NR; win++) {
>  		u32 val =3D readl(ctx->regs + WINCON(win));
> @@ -258,19 +267,15 @@ static void fimd_clear_channel(struct fimd_cont=
ext *ctx)
>  			if (ctx->driver_data->has_shadowcon)
>  				fimd_enable_shadow_channel_path(ctx, win,
>  								false);
> -
>  			ch_enabled =3D 1;
>  		}
>  	}
> =20
>  	/* Wait for vsync, as disable channel takes effect at next vsync */
> -	if (ch_enabled) {
> -		unsigned int state =3D ctx->suspended;
> -
> -		ctx->suspended =3D 0;
> +	if (ch_enabled)
>  		fimd_wait_for_vblank(ctx->crtc);
> -		ctx->suspended =3D state;
> -	}
> +
> +	return fimd_poweroff(ctx);
>  }
> =20
>  static int fimd_iommu_attach_devices(struct fimd_context *ctx,
> @@ -285,7 +290,10 @@ static int fimd_iommu_attach_devices(struct fimd=
_context *ctx,
>  		 * If any channel is already active, iommu will throw
>  		 * a PAGE FAULT when enabled. So clear any channel if enabled.
>  		 */
> -		fimd_clear_channel(ctx);
> +		ret =3D fimd_clear_channel(ctx);
> +		if (ret)
> +			return ret;
> +
>  		ret =3D drm_iommu_attach_device(ctx->drm_dev, ctx->dev);
>  		if (ret) {
>  			DRM_ERROR("drm_iommu_attach failed.\n");
>=20
