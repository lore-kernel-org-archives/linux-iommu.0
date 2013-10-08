From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 1/7] powerpc: Add interface to get msi region information
Date: Tue, 8 Oct 2013 12:09:16 -0500
Message-ID: <1381252156.7979.247.camel@snotra.buserror.net>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
	<1379575763-2091-2-git-send-email-Bharat.Bhushan@freescale.com>
	<20130924235812.GD9302@google.com>
	<6A3DF150A5B70D4F9B66A25E3F7C888D0718FA58@039-SN2MPN1-011.039d.mgd.msft.net>
	<CAErSpo742BOxzxRaFQn+UnsNday4_8LM6+3G6=cfp9DHecPxDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAErSpo742BOxzxRaFQn+UnsNday4_8LM6+3G6=cfp9DHecPxDg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2013-10-08 at 10:47 -0600, Bjorn Helgaas wrote:
> On Thu, Oct 3, 2013 at 11:19 PM, Bhushan Bharat-R65777
> <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> 
> >> I don't know enough about VFIO to understand why these new interfaces are
> >> needed.  Is this the first VFIO IOMMU driver?  I see vfio_iommu_spapr_tce.c and
> >> vfio_iommu_type1.c but I don't know if they're comparable to the Freescale PAMU.
> >> Do other VFIO IOMMU implementations support MSI?  If so, do they handle the
> >> problem of mapping the MSI regions in a different way?
> >
> > PAMU is an aperture type of IOMMU while other are paging type, So they are completely different from what PAMU is and handle that differently.
> 
> This is not an explanation or a justification for adding new
> interfaces.  I still have no idea what an "aperture type IOMMU" is,
> other than that it is "different."  But I see that Alex is working on
> this issue with you in a different thread, so I'm sure you guys will
> sort it out.

PAMU is a very constrained IOMMU that cannot do arbitrary page mappings.
Due to these constraints, we cannot map the MSI I/O page at its normal
address while also mapping RAM at the address we want.  The address we
can map it at depends on the addresses of other mappings, so it can't be
hidden in the IOMMU driver -- the user needs to be in control.

Another difference is that (if I understand correctly) PCs handle MSIs
specially, via interrupt remapping, rather than being translated as a
normal memory access through the IOMMU.

-Scott
