From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/6] powerpc/fsl_pci: Store the platform device
	information corresponding to the pci controller.
Date: Tue, 26 Feb 2013 06:16:10 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D3BD338@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
	<1361191939-21260-3-git-send-email-Varun.Sethi@freescale.com>
	<CALRxmdDc9TuxH7HgAF3_iLgatoaOUML6fUt8SU+sxHyz6ZVjfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CALRxmdDc9TuxH7HgAF3_iLgatoaOUML6fUt8SU+sxHyz6ZVjfw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stuart Yoder <b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch is not present in Joerg's tree and the add_device API in the PAMU driver requires this patch.

-Varun

> -----Original Message-----
> From: Stuart Yoder [mailto:b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Tuesday, February 26, 2013 5:39 AM
> To: Sethi Varun-B16395
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wood Scott-B07421; Joerg Roedel; Yoder
> Stuart-B08248
> Subject: Re: [PATCH 2/6] powerpc/fsl_pci: Store the platform device
> information corresponding to the pci controller.
> 
> This patch was submitted separately to linuxppc-dev (and was already
> applied).  You don't need it in this patch set, right?
> 
> Stuart
> 
> On Mon, Feb 18, 2013 at 6:52 AM, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> wrote:
> > The pci controller structure has a provision to store the device
> > strcuture pointer of the corresponding platform device. Currently this
> > information is not stored during fsl pci controller initialization.
> > This information is required while dealing with iommu groups for pci
> > devices connected to the fsl pci controller. For the case where the
> > pci devices can't be paritioned, they would fall under the same device
> group as the pci controller.
> >
> > This patch stores the platform device information in the pci
> > controller structure during initialization.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >  arch/powerpc/sysdev/fsl_pci.c |    9 +++++++--
> >  arch/powerpc/sysdev/fsl_pci.h |    2 +-
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c
> > b/arch/powerpc/sysdev/fsl_pci.c index 92a5915..b393ae7 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -421,13 +421,16 @@ void fsl_pcibios_fixup_bus(struct pci_bus *bus)
> >         }
> >  }
> >
> > -int __init fsl_add_bridge(struct device_node *dev, int is_primary)
> > +int __init fsl_add_bridge(struct platform_device *pdev, int
> > +is_primary)
> >  {
> >         int len;
> >         struct pci_controller *hose;
> >         struct resource rsrc;
> >         const int *bus_range;
> >         u8 hdr_type, progif;
> > +       struct device_node *dev;
> > +
> > +       dev = pdev->dev.of_node;
> >
> >         if (!of_device_is_available(dev)) {
> >                 pr_warning("%s: disabled\n", dev->full_name); @@
> > -453,6 +456,8 @@ int __init fsl_add_bridge(struct device_node *dev, int
> is_primary)
> >         if (!hose)
> >                 return -ENOMEM;
> >
> > +       /* set platform device as the parent */
> > +       hose->parent = &pdev->dev;
> >         hose->first_busno = bus_range ? bus_range[0] : 0x0;
> >         hose->last_busno = bus_range ? bus_range[1] : 0xff;
> >
> > @@ -880,7 +885,7 @@ static int fsl_pci_probe(struct platform_device
> > *pdev)  #endif
> >
> >         node = pdev->dev.of_node;
> > -       ret = fsl_add_bridge(node, fsl_pci_primary == node);
> > +       ret = fsl_add_bridge(pdev, fsl_pci_primary == node);
> >
> >  #ifdef CONFIG_SWIOTLB
> >         if (ret == 0) {
> > diff --git a/arch/powerpc/sysdev/fsl_pci.h
> > b/arch/powerpc/sysdev/fsl_pci.h index d078537..c495c00 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.h
> > +++ b/arch/powerpc/sysdev/fsl_pci.h
> > @@ -91,7 +91,7 @@ struct ccsr_pci {
> >         __be32  pex_err_cap_r3;         /* 0x.e34 - PCIE error capture
> register 0 */
> >  };
> >
> > -extern int fsl_add_bridge(struct device_node *dev, int is_primary);
> > +extern int fsl_add_bridge(struct platform_device *pdev, int
> > +is_primary);
> >  extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);  extern int
> > mpc83xx_add_bridge(struct device_node *dev);
> >  u64 fsl_pci_immrbar_base(struct pci_controller *hose);
> > --
> > 1.7.4.1
> >
> >
> > _______________________________________________
> > iommu mailing list
> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
