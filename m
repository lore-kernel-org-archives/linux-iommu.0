From: Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH 12/29] DRM: Exynos: fix window clear code
Date: Mon, 01 Sep 2014 22:37:44 +0900
Message-ID: <540476A8.8030502@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
 <1407235677-26324-13-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1407235677-26324-13-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

On 2014=EB=85=84 08=EC=9B=94 05=EC=9D=BC 19:47, Marek Szyprowski wrote:
> To correctly disable hardware window during driver init, both enable =
bits
> (WINCONx_ENWIN in WINCON and SHADOWCON_CHx_ENABLE in SHADOWCON) must =
be
> cleared, otherwise hardware fails to re-enable such window later.
>=20
> While touching this function, also temporarily disable ctx->suspended=
 flag
> to let fimd_wait_for_vblank function really to do its job.
>=20
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c | 25 ++++++++++++++++++----=
---
>  1 file changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/d=
rm/exynos/exynos_drm_fimd.c
> index 41904df..7a363d2 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> @@ -165,27 +165,38 @@ static void fimd_wait_for_vblank(struct exynos_=
drm_manager *mgr)
>  		DRM_DEBUG_KMS("vblank wait timed out.\n");
>  }
> =20
> -
>  static void fimd_clear_channel(struct exynos_drm_manager *mgr)
>  {
>  	struct fimd_context *ctx =3D mgr->ctx;
> -	int win, ch_enabled =3D 0;
> +	int state, win, ch_enabled =3D 0;

It doesn't need to declare state variable here because this variable is
used only when ch_enabled is 1.

> =20
>  	DRM_DEBUG_KMS("%s\n", __FILE__);
> =20
>  	/* Check if any channel is enabled. */
>  	for (win =3D 0; win < WINDOWS_NR; win++) {
> -		u32 val =3D readl(ctx->regs + SHADOWCON);
> -		if (val & SHADOWCON_CHx_ENABLE(win)) {
> -			val &=3D ~SHADOWCON_CHx_ENABLE(win);
> -			writel(val, ctx->regs + SHADOWCON);
> +		u32 val =3D readl(ctx->regs + WINCON(win));

WARNING: Missing a blank line after declarations

> +		if (val & WINCONx_ENWIN) {
> +			/* wincon */
> +			val &=3D ~WINCONx_ENWIN;
> +			writel(val, ctx->regs + WINCON(win));
> +
> +			/* unprotect windows */
> +			if (ctx->driver_data->has_shadowcon) {
> +				val =3D readl(ctx->regs + SHADOWCON);
> +				val &=3D ~SHADOWCON_CHx_ENABLE(win);
> +				writel(val, ctx->regs + SHADOWCON);
> +			}
>  			ch_enabled =3D 1;
>  		}
>  	}
> =20
>  	/* Wait for vsync, as disable channel takes effect at next vsync */
> -	if (ch_enabled)
> +	if (ch_enabled) {
> +		state =3D ctx->suspended;

int state =3D ctx->suspended;

> +		ctx->suspended =3D 0;
>  		fimd_wait_for_vblank(mgr);
> +		ctx->suspended =3D state;
> +	}
>  }
> =20
>  static int fimd_mgr_initialize(struct exynos_drm_manager *mgr,
>=20

Above is trivial so I fixed them. Picked it up.

Thanks,
Inki Dae
