From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 05/10] iommu/ipmmu-vmsa: Add device tree bindings documentation
Date: Tue, 16 Dec 2014 14:52:39 +0100
Message-ID: <CAMuHMdXC8C7BuTdK8-RkqaQ6dqi1bxRHFz1CttGQi3u9w6QD7Q@mail.gmail.com>
References: <1418737457-22042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1418737457-22042-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1418737457-22042-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: iommu@lists.linux-foundation.org, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On Tue, Dec 16, 2014 at 2:44 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks!

Apart from the minor nit below:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> +       ipmmu_mx: mmu@fe951800 {

fe951000

(yes, having to put the same information in two places will cause discrepancies)

> +               compatible = "renasas,ipmmu-vmsa";
> +               reg = <0 0xfe951000 0 0x1000>;
> +               interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 221 IRQ_TYPE_LEVEL_HIGH>;
> +               #iommu-cells = <1>;
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
