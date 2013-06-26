From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/2] iommu: Quirked PCIe bridge test and search function
Date: Tue, 25 Jun 2013 22:20:35 -0600
Message-ID: <CAErSpo5_P9tPdmpq2XO-X-d5NUWFG8Nbm_byKOkd5d4b8UMcMQ@mail.gmail.com>
References: <20130528183527.3318.5365.stgit@bling.home> <20130528184020.3318.7800.stgit@bling.home>
 <20130620135914.GS2575@8bytes.org> <1371743091.32709.52.camel@ul30vt.home> <20130620161538.GH3589@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20130620161538.GH3589@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, Stephen Hemminger <stephen@networkplumber.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Don Dutile <ddutile@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 20, 2013 at 10:15 AM, Joerg Roedel <joro@8bytes.org> wrote:
> On Thu, Jun 20, 2013 at 09:44:51AM -0600, Alex Williamson wrote:
>> On Thu, 2013-06-20 at 15:59 +0200, Joerg Roedel wrote:
>> > On Tue, May 28, 2013 at 12:40:20PM -0600, Alex Williamson wrote:
>> > > + if (!pci_is_root_bus(pdev->bus)) {
>> > > +         struct pci_dev *parent = pdev->bus->self;
>> > > +
>> > > +         if (pci_is_pcie(parent) &&
>> > > +             pci_pcie_type(parent) != PCI_EXP_TYPE_PCI_BRIDGE)
>> > > +                 return true;
>> > > + }
>> >
>> > Hmm, that looks a bit dangerous.
>>
>> How so?  The algorithm seems pretty simple and logical.
>
> It is simple, but it is still a heuristic that may fail at some point,
> no?
>
>> Actually, I believe Bjorn rejected the idea of a fixed list because this
>> problem is detectable.  He also doesn't want me messing with quirks to
>> pci_is_pcie() in PCI because he wants a 1:1 relation between that and
>> having a PCIe capability.  So, I'm stuck and this is where it's ended
>> up.  Thanks,
>
> I think implementing such a list is much safer.
>
> Bjorn, why didn't you like that idea?

Sorry, I can't remember, and I haven't been able to find the
discussion where I said that.  I think the current patches are all in
drivers/iommu, and if a list makes sense there, it's fine with me.

Bjorn
