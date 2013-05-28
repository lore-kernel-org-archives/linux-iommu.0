From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2 1/2] iommu: Quirked PCIe bridge test and search
 function
Date: Tue, 28 May 2013 13:28:19 -0700
Message-ID: <20130528132819.2f1bc333@nehalam.linuxnetplumber.net>
References: <20130528183527.3318.5365.stgit@bling.home>
	<20130528184020.3318.7800.stgit@bling.home>
	<20130528123827.2507c34e@nehalam.linuxnetplumber.net>
	<1369770790.2646.272.camel@ul30vt.home>
	<20130528125650.5ca5b419@nehalam.linuxnetplumber.net>
	<1369772124.2646.288.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1369772124.2646.288.camel@ul30vt.home>
Sender: linux-pci-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org, joro@8bytes.org, linux-pci@vger.kernel.org, ddutile@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Tue, 28 May 2013 14:15:24 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 2013-05-28 at 12:56 -0700, Stephen Hemminger wrote:
> > On Tue, 28 May 2013 13:53:10 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> > 
> > > On Tue, 2013-05-28 at 12:38 -0700, Stephen Hemminger wrote:
> > > > On Tue, 28 May 2013 12:40:20 -0600
> > > > Alex Williamson <alex.williamson@redhat.com> wrote:
> > > > 
> > > > > Some PCIe-to-PCI bridges are not fully compliant with the PCIe spec
> > > > > and do not include a PCIe capability.  pci_is_pcie() is not useful on
> > > > > these devices, making it difficult to determine where we transition
> > > > > from a legacy PCI bus to a PCIe link.  PCI-core doesn't want a quirked
> > > > > bridge test for fear of confusion that a PCIe capability would be
> > > > > expected, so implement it in IOMMU code.
> > > > > 
> > > > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > > 
> > > > This won't work for me because I run without IOMMU.
> > > > The overhead of IOMMU setup per-packet significantly impacts network performance.
> > > 
> > > You were one of the reporters of this issue:
> > > 
> > > http://www.spinics.net/lists/linux-pci/msg19579.html
> > > 
> > > Does this not work for you or are you saying this is not relevant to you
> > > because you no longer attempt to enable the IOMMU?  Thanks,
> > > 
> > 
> > For most usage, I gave up on using IOMMU/SR-IOV.
> 
> Ok, let's call that a "don't care" rather than "won't work" for the
> purposes of these patches.  I'll take you off the CC if there's another
> version.  Thanks,
> 
> Alex
> 

Yes, it is a don't care. but leave me on cc, because I may still need it.
