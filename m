From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix crash on early domain free
Date: Wed, 7 Nov 2018 16:50:40 +0100
Message-ID: <CAMuHMdWPkMtnGrxrtFGmyJ5NEvSSCiMUVXXBWX+NS-J4tQXLAw@mail.gmail.com>
References: <20181107131850.11584-1-geert+renesas@glider.be>
 <e4dcd8b2-768e-b11d-b6de-337b7e942050@arm.com> <20181107153418.cge2dj5zmztahxrf@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107153418.cge2dj5zmztahxrf@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jörg,

On Wed, Nov 7, 2018 at 4:34 PM Joerg Roedel <joro@8bytes.org> wrote:
> On Wed, Nov 07, 2018 at 01:22:52PM +0000, Robin Murphy wrote:
> > On 2018-11-07 1:18 pm, Geert Uytterhoeven wrote:
> > > Fix this by checking if the domain's context already exists, before
> > > trying to destroy it.
> >
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> Does this need a Fixes-tag? If so, which patch should be in that tag?

I think this bug has been present since the initial version of the driver, but
this failure mode has probably never been tested before.

It only got triggered by the combination of commits 6c2fb2ea76361da9
("of/device: Set bus DMA mask as appropriate") and b4ebe6063204da58
("dma-direct: implement complete bus_dma_mask handling"), which is being
fixed by "of/device: Really only set bus DMA mask when
appropriate" (https://patchwork.kernel.org/patch/10670177/).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
