From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/13] driver core: Add iommu_group tracking to struct
 device
Date: Fri, 11 May 2012 17:00:40 -0700
Message-ID: <20120512000040.GA17559@kroah.com>
References: <20120511222148.30496.68571.stgit@bling.home>
 <20120511225534.30496.54563.stgit@bling.home>
 <20120511233821.GA9335@kroah.com>
 <1336780681.12477.198.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1336780681.12477.198.camel@bling.home>
Sender: linux-pci-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: benh@kernel.crashing.org, aik@ozlabs.ru, david@gibson.dropbear.id.au, joerg.roedel@amd.com, dwmw2@infradead.org, chrisw@sous-sol.org, agraf@suse.de, benve@cisco.com, aafabbri@cisco.com, B08248@freescale.com, B07421@freescale.com, avi@redhat.com, konrad.wilk@oracle.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com
List-Id: iommu@lists.linux-foundation.org

On Fri, May 11, 2012 at 05:58:01PM -0600, Alex Williamson wrote:
> On Fri, 2012-05-11 at 16:38 -0700, Greg KH wrote:
> > On Fri, May 11, 2012 at 04:55:35PM -0600, Alex Williamson wrote:
> > > IOMMU groups allow IOMMU drivers to represent DMA visibility
> > > and isolation of devices.  Multiple devices may be grouped
> > > together for the purposes of DMA.  Placing a pointer on
> > > struct device enable easy access for things like streaming
> > > DMA programming and drivers like VFIO.
> > > 
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > 
> > Can't you get this today from the iommu_ops pointer that is on the bus
> > that the device is associated with?  Or can devices on a bus have
> > different iommu_group pointers?
> 
> The latter, each device on a bus might be it's own group.  This is often
> the case on x86 unless PCIe-to-PCI bridges obscure the device
> visibility.  Thanks,

Ah, ok, then I have no objection to add this to struct device:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
