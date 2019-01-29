From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH 2/5] drivers/base: add a function to test peer to
 peer capability
Date: Tue, 29 Jan 2019 14:56:52 -0500
Message-ID: <20190129195651.GK3176@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-3-jglisse@redhat.com>
 <20190129194605.GC32069@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129194605.GC32069@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 29, 2019 at 08:46:05PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 29, 2019 at 12:47:25PM -0500, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > device_test_p2p() return true if two devices can peer to peer to
> > each other. We add a generic function as different inter-connect
> > can support peer to peer and we want to genericaly test this no
> > matter what the inter-connect might be. However this version only
> > support PCIE for now.
> 
> There is no defintion of "peer to peer" in the driver/device model, so
> why should this be in the driver core at all?
> 
> Especially as you only do this for PCI, why not just keep it in the PCI
> layer, that way you _know_ you are dealing with the right pointer types
> and there is no need to mess around with the driver core at all.

Ok i will drop the core device change. I wanted to allow other non
PCI to join latter on (ie allow PCI device to export to non PCI device)
but if that ever happen then we can update pci exporter at the same
time we introduce non pci importer.

Cheers,
Jérôme
