From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 01/10] iommu/ipmmu-vmsa: Introduce features, break out alias
Date: Wed, 16 Dec 2015 09:17:59 +0100
Message-ID: <CAMuHMdV2DzMVyWNX2Z3dOH4OV7_6G28HQMKcB9pEA06Vq=ZBhg@mail.gmail.com>
References: <20151215130508.13535.26186.sendpatchset@little-apple>
	<20151215130518.13535.13822.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20151215130518.13535.13822.sendpatchset@little-apple>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On Tue, Dec 15, 2015 at 2:05 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Introduce struct ipmmu_features to track various hardware
> and software implementation changes inside the driver for
> various kinds of IPMMU hardware. Add use_ns_alias_offset
> as a first example of a feature to control if the secure
> register bank offset should be used or not.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>  drivers/iommu/ipmmu-vmsa.c |   34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
>
> --- 0009/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c     2015-12-15 13:41:22.600513000 +0900
> @@ -31,6 +31,10 @@
>
>  #define IPMMU_CTX_MAX 1
>
> +struct ipmmu_features {
> +       bool use_ns_alias_offset;
> +};

Given you're adding more than 4 features in this series, you may want to
consider using an unsigned int bitfield instead.

That way you could also store it directly in of_device_id.data, if you want.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
