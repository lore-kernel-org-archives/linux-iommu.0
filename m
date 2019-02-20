From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 6/7] iommu/ipmmu-vmsa: Extract hardware context initialization
Date: Wed, 20 Feb 2019 16:43:57 +0100
Message-ID: <CAMuHMdUo+XtRiNY_nOW8ZgCGFVo3au1=0Q7L2nU29QcPYVkgNg@mail.gmail.com>
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-7-geert+renesas@glider.be> <20190220153533.GH3516@pendragon.ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220153533.GH3516@pendragon.ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On Wed, Feb 20, 2019 at 4:35 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, Feb 20, 2019 at 04:05:30PM +0100, Geert Uytterhoeven wrote:
> > ipmmu_domain_init_context() takes care of (1) initializing the software
> > domain, and (2) initializing the hardware context for the domain.
> >
> > Extract the code to initialize the hardware context into a new subroutine
> > ipmmu_context_init(), to prepare for later reuse.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/iommu/ipmmu-vmsa.c | 91 ++++++++++++++++++++------------------
> >  1 file changed, 48 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index 0a21e734466eb1bd..92a766dd8b459f0c 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -404,52 +404,10 @@ static void ipmmu_domain_free_context(struct ipmmu_vmsa_device *mmu,
> >       spin_unlock_irqrestore(&mmu->lock, flags);
> >  }
> >
> > -static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
> > +static void ipmmu_context_init(struct ipmmu_vmsa_domain *domain)
>
> ipmmu_context_init() vs. ipmmmu_domain_init_context() is confusing. You
> could call this one ipmmu_domain_setup_context() maybe ?

Thanks, that name was actually on my shortlist, and may make most sense.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
