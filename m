From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/3] iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
Date: Mon, 23 Jan 2017 13:42:15 +0100
Message-ID: <CAMuHMdXc6iMgnN9GCgu4DecX2HVbReu_4=cb+6_LMD39=DYnMA@mail.gmail.com>
References: <148517158986.13306.314435910710426381.sendpatchset@little-apple> <148517162908.13306.2467186615655446796.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <148517162908.13306.2467186615655446796.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <joro@8bytes.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On Mon, Jan 23, 2017 at 12:40 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Bump up the maximum numbers of micro-TLBS to 48.
>
> Each IPMMU device instance get micro-TLB assignment via
> the "iommus" property in DT. Older SoCs tend to use a
> maximum number of 32 micro-TLBs per IPMMU instance however
> newer SoCs such as r8a7796 make use of up to 48 micro-TLBs.
>
> At this point no SoC specific handling is done to validate
> the maximum number of micro-TLBs, and because of that the
> DT information is assumed to be within correct range for
> each particular SoC.
>
> If needed in the future SoC specific feature flags can be
> added to handle the maximum number of micro-TLBs without
> requiring DT changes, however at this point this does not
> seem necessary.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> @@ -1141,7 +1145,7 @@ static int ipmmu_probe(struct platform_d
>         }
>
>         mmu->dev = &pdev->dev;
> -       mmu->num_utlbs = 32;
> +       mmu->num_utlbs = 48;

This value is only used to validate the utlb channel numbers received from DT,
in ipmmu_init_platform_device(), right?

>         spin_lock_init(&mmu->lock);
>         bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
>         mmu->features = match->data;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
