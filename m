From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 03/10] iommu/ipmmu-vmsa: Teach xlate() to skip disabled iommus
Date: Fri, 18 Mar 2016 10:46:51 +0100
Message-ID: <CAMuHMdVYP4YtwE0eXiu49A4+p+siKPMEbMqoGFnagZ=RFnVDgg@mail.gmail.com>
References: <20160317162909.24104.31682.sendpatchset@little-apple>
	<20160317162937.24104.40724.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160317162937.24104.40724.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <joro@8bytes.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 17, 2016 at 5:29 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Right now the ->xlate() call gets invoked even though
> the iommu device has status = "disabled" in DT, so
> make sure we skip over disabled devices.
>
> In my mind it would make sense to have this at some
> shared level, but I guess some users may want to
> configure the iommu regardless of DT state.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>  drivers/iommu/ipmmu-vmsa.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> --- 0017/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c     2016-03-18 00:16:51.200513000 +0900
> @@ -890,7 +890,13 @@ static struct iommu_group *ipmmu_device_
>  static int ipmmu_of_xlate_dma(struct device *dev,
>                               struct of_phandle_args *spec)
>  {
> -       /* dummy callback to satisfy of_iommu_configure() */
> +       /* If the IPMMU device is disabled in DT then return error
> +        * to make sure the of_iommu code does not install ops
> +        * even though the iommu device is disabled
> +        */
> +       if (!of_device_is_available(spec->np))
> +               return -ENODEV;
> +
>         return 0;

I think this should be handled in drivers/iommu/of_iommu.c:of_iommu_init()
instead, cfr. commit 3e5dd6f6e690048d ("clk: Ignore disabled DT clock
providers").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
