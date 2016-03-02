From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Add r8a7795 DT binding
Date: Wed, 2 Mar 2016 09:17:53 +0100
Message-ID: <CAMuHMdV1rie8JJ4n4hvY5yJz3OTF_YsvuoVSxQ5QQSaujUoeiA@mail.gmail.com>
References: <20160229143309.28517.77269.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160229143309.28517.77269.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Joerg Roedel <joro@8bytes.org>, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On Mon, Feb 29, 2016 at 3:33 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Update the IPMMU DT binding documentation to include the r8a7795 compat
> string as well as the "renesas,ipmmu-main" property that on r8a7795 will
> be used to describe the topology and the relationship between the various
> cache IPMMU instances and the main IPMMU.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks for your patch!

> ---
>
>  Written against linux-next tag next-20160229
>
>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt |   15 ++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> --- 0001/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> +++ work/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt 2016-02-29 23:25:15.540513000 +0900
> @@ -7,23 +7,34 @@ connected to the IPMMU through a port ca
>
>  Required Properties:
>
> -  - compatible: Must contain SoC-specific and generic entries from below.
> +  - compatible: Must contain SoC-specific and generic entry below in case
> +    the device is compatible with the R-Car Gen2 VMSA-compatible IPMMU.
>
>      - "renesas,ipmmu-r8a73a4" for the R8A73A4 (R-Mobile APE6) IPMMU.
>      - "renesas,ipmmu-r8a7790" for the R8A7790 (R-Car H2) IPMMU.
>      - "renesas,ipmmu-r8a7791" for the R8A7791 (R-Car M2-W) IPMMU.
>      - "renesas,ipmmu-r8a7793" for the R8A7793 (R-Car M2-N) IPMMU.
>      - "renesas,ipmmu-r8a7794" for the R8A7794 (R-Car E2) IPMMU.
> +    - "renesas,ipmmu-r8a7795" for the R8A7795 (R-Car H3) IPMMU.
>      - "renesas,ipmmu-vmsa" for generic R-Car Gen2 VMSA-compatible IPMMU.
>
>    - reg: Base address and size of the IPMMU registers.
>    - interrupts: Specifiers for the MMU fault interrupts. For instances that
>      support secure mode two interrupts must be specified, for non-secure and
>      secure mode, in that order. For instances that don't support secure mode a
> -    single interrupt must be specified.
> +    single interrupt must be specified. Not required for cache IPMMUs.
>
>    - #iommu-cells: Must be 1.
>
> +Optional properties:
> +
> +  - renesas,ipmmu-main: reference to the main IPMMU instance in two cells.
> +    The first cell is a phandle to the main IPMMU and the second cell is
> +    the interrupt bit number associated with the particular cache IPMMU device.
> +    The interrupt bit number needs to match the main IPMMU IMSSTR register.
> +    Only used by cache IPMMU instances.
> +
> +

I think it would be good to include an example of how the optional properties
should be used.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
