From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 03/06] iommu/ipmmu-vmsa: Break out utlb control function
Date: Tue, 29 Dec 2015 02:05:17 +0200
Message-ID: <1823351.xcsKyrzciK@avalon>
References: <20151215120212.26216.61530.sendpatchset@little-apple> <20151215120239.26216.43390.sendpatchset@little-apple> <CAMuHMdXYzO=+xuH2UwOUzDPoiyW-fBBaby91Ywr_Moa9bi17YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXYzO=+xuH2UwOUzDPoiyW-fBBaby91Ywr_Moa9bi17YQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On Tuesday 15 December 2015 16:48:42 Geert Uytterhoeven wrote:
> On Tue, Dec 15, 2015 at 1:02 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > --- 0004/drivers/iommu/ipmmu-vmsa.c
> > +++ work/drivers/iommu/ipmmu-vmsa.c     2015-12-15 13:17:40.580513000
> > +0900
> > @@ -279,9 +279,18 @@ static void ipmmu_utlb_enable(struct ipm
> >  static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
> >                                unsigned int utlb)
> >  {
> > -       struct ipmmu_vmsa_device *mmu = domain->mmu;
> > +       ipmmu_write(domain->mmu, IMUCTR(utlb), 0);
> > +}
> > +
> > +static void ipmmu_utlb_ctrl(struct ipmmu_vmsa_domain *domain,
> > +                           void (*fn)(struct ipmmu_vmsa_domain *,
> > +                                      unsigned int utlb), struct device
> > *dev)
> > +{
> > +       struct ipmmu_vmsa_dev_data *dev_data = get_dev_data(dev);
> > +       unsigned int i;
> > 
> > -       ipmmu_write(mmu, IMUCTR(utlb), 0);
> > +       for (i = 0; i < dev_data->num_utlbs; ++i)
> > +               fn(domain, dev_data->utlbs[i]);
> > 
> >  }
> 
> Unless you have further plans with the "fn" parameter, I would simply pass
> a bool enable/disable flag instead of a function pointer.

I agree with Geert. What's your plan here ?

-- 
Regards,

Laurent Pinchart

