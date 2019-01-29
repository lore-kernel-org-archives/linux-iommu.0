From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH 2/5] drivers/base: add a function to test peer to
 peer capability
Date: Tue, 29 Jan 2019 14:54:23 -0500
Message-ID: <20190129195421.GJ3176@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-3-jglisse@redhat.com>
 <98d345af-7928-2a50-7bc4-582916dfac80@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <98d345af-7928-2a50-7bc4-582916dfac80@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 29, 2019 at 11:26:01AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2019-01-29 10:47 a.m., jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > device_test_p2p() return true if two devices can peer to peer to
> > each other. We add a generic function as different inter-connect
> > can support peer to peer and we want to genericaly test this no
> > matter what the inter-connect might be. However this version only
> > support PCIE for now.
> 
> This doesn't appear to be used in any of the further patches; so it's
> very confusing.
> 
> I'm not sure a struct device wrapper is really necessary...

I wanted to allow other non pci device to join in the fun but
yes right now i have only be doing this on pci devices.

Jérôme
