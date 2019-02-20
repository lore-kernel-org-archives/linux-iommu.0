From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/7] iommu/ipmmu-vmsa: Prepare to handle 40-bit error addresses
Date: Wed, 20 Feb 2019 16:42:15 +0100
Message-ID: <CAMuHMdWkQ918Y61tMJbHEu29AGLEyNwbvZbSBB-RRH7YYUNRcA@mail.gmail.com>
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-4-geert+renesas@glider.be> <20190220153057.GF3516@pendragon.ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220153057.GF3516@pendragon.ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On Wed, Feb 20, 2019 at 4:31 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, Feb 20, 2019 at 04:05:27PM +0100, Geert Uytterhoeven wrote:
> > On R-Car Gen3, the faulting virtual address is a 40-bit address, and
> > comprised of two registers.  Read the upper address part, and combine
> > both parts, when running on a 64-bit system.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Apart from this, the driver doesn't support 40-bit IOVA addresses yet.
> > ---
> >  drivers/iommu/ipmmu-vmsa.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index ac70cb967ff821c6..4d07c26c97848b65 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -186,7 +186,9 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
> >  #define IMMAIR_ATTR_IDX_WBRWA                1
> >  #define IMMAIR_ATTR_IDX_DEV          2
> >
> > -#define IMEAR                                0x0030
> > +#define IMEAR                                0x0030  /* R-Car Gen2 */
> > +#define IMELAR                               IMEAR   /* R-Car Gen3 */
>
> I would have defined that as a single macro.

Fair enough.

> > +#define IMEUAR                               0x0034  /* R-Car Gen3 */
> >
> >  #define IMPCTR                               0x0200
> >  #define IMPSTR                               0x0208
> > @@ -521,14 +523,16 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
> >  {
> >       const u32 err_mask = IMSTR_MHIT | IMSTR_ABORT | IMSTR_PF | IMSTR_TF;
> >       struct ipmmu_vmsa_device *mmu = domain->mmu;
> > +     unsigned long iova;
>
> Isn't there a more appropriate type, such as dma_addr_t possibly ?

Good question! Thanks for opening the can of worms ;-)

I used "unsigned long", as that's what the "iova" parameter of
report_iommu_fault() (called in this function) takes.

However, dma_addr_t would probably be a better choice.

Note that most iommu_ops methods take unsigned long, except for
.iova_to_phys(), which takes dma_addr_t.
Also, all io_pgtable_ops methods take unsigned long, including
.iova_to_phys().

The latter is interesting, as several IOMMU drivers forward the iova
received in their iommu_ops.iova_to_phys() methods to
io_pgtable_ops.iova_to_phys(), thus truncating the value on e.g. arm32
with LPAE.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
