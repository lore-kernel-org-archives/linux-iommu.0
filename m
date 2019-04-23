From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 6/6] iommu/ipmmu-vmsa: Add suspend/resume support
Date: Tue, 23 Apr 2019 17:16:08 +0200
Message-ID: <CAMuHMdVKr=gbMJzvxe-wRbWxWt8TM8TrVauB8eYaGMz45Ko67w@mail.gmail.com>
References: <20190403182148.18058-1-geert+renesas@glider.be>
 <20190403182148.18058-7-geert+renesas@glider.be> <20190411083905.fpeicn5ia3ghbphe@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411083905.fpeicn5ia3ghbphe@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Simon,

On Thu, Apr 11, 2019 at 10:39 AM Simon Horman <horms@verge.net.au> wrote:
> On Wed, Apr 03, 2019 at 08:21:48PM +0200, Geert Uytterhoeven wrote:
> > During PSCI system suspend, R-Car Gen3 SoCs are powered down, and all
> > IPMMU state is lost.  Hence after s2ram, devices wired behind an IPMMU,
> > and configured to use it, will see their DMA operations hang.
> >
> > To fix this, restore all IPMMU contexts, and re-enable all active
> > micro-TLBs during system resume.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > This patch takes a different approach than the BSP, which implements a
> > bulk save/restore of all registers during system suspend/resume.
> >
> > v2:
> >   - Drop PSCI checks.
> > ---
> >  drivers/iommu/ipmmu-vmsa.c | 47 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 46 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index 56e84bcc9532e1ce..408ad0b2591925e0 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -36,7 +36,10 @@
> >  #define arm_iommu_detach_device(...) do {} while (0)
> >  #endif
> >
> > -#define IPMMU_CTX_MAX 8U
> > +#define IPMMU_CTX_MAX                8U
> > +#define IPMMU_CTX_INVALID    -1
> > +
> > +#define IPMMU_UTLB_MAX               48U
> >
> >  struct ipmmu_features {
> >       bool use_ns_alias_offset;
> > @@ -58,6 +61,7 @@ struct ipmmu_vmsa_device {
> >       spinlock_t lock;                        /* Protects ctx and domains[] */
> >       DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
> >       struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
>
> It might be possible to save a bit of memory on Gen 2 systems by
> making IPMMU_UTLB_MAX 32 when the driver is compiled for such systems.

This comment applies to the line below, right?

> > +     s8 utlb_ctx[IPMMU_UTLB_MAX];

So it's just 16 bytes, not 16 pointers.

Doing so would reduce struct ipmmu_vmsa_device from 148 to 132 bytes.
Given that structure is allocated by devm_kzalloc(), and devres alignment
was increased in commit a66d972465d15b1d ("devres: Align data[] to
ARCH_KMALLOC_MINALIGN"), I guess it won't make a difference.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
