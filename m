From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 1/3] iommu/fsl: Factor out PCI specific code.
Date: Tue, 15 Oct 2013 14:35:41 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A53D863@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381609954-15283-1-git-send-email-Varun.Sethi@freescale.com>
	<1381609954-15283-2-git-send-email-Varun.Sethi@freescale.com>
	<20131015001611.GA9203@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131015001611.GA9203-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
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
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Bjorn Helgaas
> Sent: Tuesday, October 15, 2013 5:46 AM
> To: Sethi Varun-B16395
> Cc: Yoder Stuart-B08248; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; Bhushan Bharat-R65777; Wood Scott-B07421; linuxppc-
> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Subject: Re: [PATCH 1/3] iommu/fsl: Factor out PCI specific code.
> 
> On Sun, Oct 13, 2013 at 02:02:32AM +0530, Varun Sethi wrote:
> > Factor out PCI specific code in the PAMU driver.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >  drivers/iommu/fsl_pamu_domain.c |   81 +++++++++++++++++++------------
> --------
> >  1 file changed, 40 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/iommu/fsl_pamu_domain.c
> > b/drivers/iommu/fsl_pamu_domain.c index c857c30..e02e1de 100644
> > --- a/drivers/iommu/fsl_pamu_domain.c
> > +++ b/drivers/iommu/fsl_pamu_domain.c
> > @@ -677,13 +677,9 @@ static int handle_attach_device(struct
> fsl_dma_domain *dma_domain,
> >  	return ret;
> >  }
> >
> > -static int fsl_pamu_attach_device(struct iommu_domain *domain,
> > -				  struct device *dev)
> > +static void check_for_pci_dma_device(struct device **dev)
> 
> "check_for_pci_dma_device()" doesn't give a good clue about what the
> function returns.  And why return something via a reference parameter
> when you could return it directly?
[Sethi Varun-B16395] I will rename the function to get_dma_device and make it return a pointer.
> 
> >  {
> > -	struct fsl_dma_domain *dma_domain = domain->priv;
> > -	const u32 *liodn;
> > -	u32 liodn_cnt;
> > -	int len, ret = 0;
> > +#ifdef CONFIG_PCI
> >  	struct pci_dev *pdev = NULL;
> >  	struct pci_controller *pci_ctl;
> 
> This is sort of a goofy looking function.  It would read much better as
> something like this:
> 
[Sethi Varun-B16395] Will make the change.

>       struct device *dma_dev = dev;
> 
>   #ifdef CONFIG_PCI
>       if (...) {
>           dma_dev = ...;
>       }
>   #endif
> 
>       return dma_dev;
> 
> Does this need to care about reference counting when you return a pointer
> to a different device?
> 
[Sethi Varun-B16395] Reference counting isn't required, as we are just obtaining the LIODN value from the PCI controller.

-Varun
