From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/2] iommu: Quirked PCIe bridge test and search function
Date: Wed, 26 Jun 2013 12:45:58 -0600
Message-ID: <1372272358.30572.560.camel@ul30vt.home>
References: <20130528183527.3318.5365.stgit@bling.home>
	<20130528184020.3318.7800.stgit@bling.home>
	<20130620135914.GS2575@8bytes.org>
	<1371743091.32709.52.camel@ul30vt.home>
	<20130620161538.GH3589@8bytes.org>
	<CAErSpo5_P9tPdmpq2XO-X-d5NUWFG8Nbm_byKOkd5d4b8UMcMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAErSpo5_P9tPdmpq2XO-X-d5NUWFG8Nbm_byKOkd5d4b8UMcMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Hemminger <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2013-06-25 at 22:20 -0600, Bjorn Helgaas wrote:
> On Thu, Jun 20, 2013 at 10:15 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> > On Thu, Jun 20, 2013 at 09:44:51AM -0600, Alex Williamson wrote:
> >> On Thu, 2013-06-20 at 15:59 +0200, Joerg Roedel wrote:
> >> > On Tue, May 28, 2013 at 12:40:20PM -0600, Alex Williamson wrote:
> >> > > + if (!pci_is_root_bus(pdev->bus)) {
> >> > > +         struct pci_dev *parent = pdev->bus->self;
> >> > > +
> >> > > +         if (pci_is_pcie(parent) &&
> >> > > +             pci_pcie_type(parent) != PCI_EXP_TYPE_PCI_BRIDGE)
> >> > > +                 return true;
> >> > > + }
> >> >
> >> > Hmm, that looks a bit dangerous.
> >>
> >> How so?  The algorithm seems pretty simple and logical.
> >
> > It is simple, but it is still a heuristic that may fail at some point,
> > no?
> >
> >> Actually, I believe Bjorn rejected the idea of a fixed list because this
> >> problem is detectable.  He also doesn't want me messing with quirks to
> >> pci_is_pcie() in PCI because he wants a 1:1 relation between that and
> >> having a PCIe capability.  So, I'm stuck and this is where it's ended
> >> up.  Thanks,
> >
> > I think implementing such a list is much safer.
> >
> > Bjorn, why didn't you like that idea?
> 
> Sorry, I can't remember, and I haven't been able to find the
> discussion where I said that.  I think the current patches are all in
> drivers/iommu, and if a list makes sense there, it's fine with me.

Here's the comment I remember

https://bugzilla.kernel.org/show_bug.cgi?id=44881#c7

        Comment #7 From Bjorn Helgaas 2012-08-23 15:58:39
        [snip]
        I doubt the upstream device is at fault.  More likely the
        downstream device is really a PCIe device (a PCIe-to-PCI bridge)
        but just fails to report a PCIe capability.  I think this
        situation is likely too common to deal with via quirks, so we'll
        have to figure out a way to just make this work.

Thanks,
Alex
