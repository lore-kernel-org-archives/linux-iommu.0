From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] iommu: Quirked PCIe bridge test and search function
Date: Thu, 20 Jun 2013 18:15:38 +0200
Message-ID: <20130620161538.GH3589@8bytes.org>
References: <20130528183527.3318.5365.stgit@bling.home>
	<20130528184020.3318.7800.stgit@bling.home>
	<20130620135914.GS2575@8bytes.org>
	<1371743091.32709.52.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371743091.32709.52.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 20, 2013 at 09:44:51AM -0600, Alex Williamson wrote:
> On Thu, 2013-06-20 at 15:59 +0200, Joerg Roedel wrote:
> > On Tue, May 28, 2013 at 12:40:20PM -0600, Alex Williamson wrote:
> > > +	if (!pci_is_root_bus(pdev->bus)) {
> > > +		struct pci_dev *parent = pdev->bus->self;
> > > +
> > > +		if (pci_is_pcie(parent) &&
> > > +		    pci_pcie_type(parent) != PCI_EXP_TYPE_PCI_BRIDGE)
> > > +			return true;
> > > +	}
> > 
> > Hmm, that looks a bit dangerous.
> 
> How so?  The algorithm seems pretty simple and logical.

It is simple, but it is still a heuristic that may fail at some point,
no?

> Actually, I believe Bjorn rejected the idea of a fixed list because this
> problem is detectable.  He also doesn't want me messing with quirks to
> pci_is_pcie() in PCI because he wants a 1:1 relation between that and
> having a PCIe capability.  So, I'm stuck and this is where it's ended
> up.  Thanks,

I think implementing such a list is much safer.

Bjorn, why didn't you like that idea?


	Joerg
