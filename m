From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Tue, 29 Jan 2019 14:11:23 -0500
Message-ID: <20190129191120.GE3176@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 29, 2019 at 11:36:29AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2019-01-29 10:47 a.m., jglisse@redhat.com wrote:
> 
> > +	/*
> > +	 * Optional for device driver that want to allow peer to peer (p2p)
> > +	 * mapping of their vma (which can be back by some device memory) to
> > +	 * another device.
> > +	 *
> > +	 * Note that the exporting device driver might not have map anything
> > +	 * inside the vma for the CPU but might still want to allow a peer
> > +	 * device to access the range of memory corresponding to a range in
> > +	 * that vma.
> > +	 *
> > +	 * FOR PREDICTABILITY IF DRIVER SUCCESSFULY MAP A RANGE ONCE FOR A
> > +	 * DEVICE THEN FURTHER MAPPING OF THE SAME IF THE VMA IS STILL VALID
> > +	 * SHOULD ALSO BE SUCCESSFUL. Following this rule allow the importing
> > +	 * device to map once during setup and report any failure at that time
> > +	 * to the userspace. Further mapping of the same range might happen
> > +	 * after mmu notifier invalidation over the range. The exporting device
> > +	 * can use this to move things around (defrag BAR space for instance)
> > +	 * or do other similar task.
> > +	 *
> > +	 * IMPORTER MUST OBEY mmu_notifier NOTIFICATION AND CALL p2p_unmap()
> > +	 * WHEN A NOTIFIER IS CALL FOR THE RANGE ! THIS CAN HAPPEN AT ANY
> > +	 * POINT IN TIME WITH NO LOCK HELD.
> > +	 *
> > +	 * In below function, the device argument is the importing device,
> > +	 * the exporting device is the device to which the vma belongs.
> > +	 */
> > +	long (*p2p_map)(struct vm_area_struct *vma,
> > +			struct device *device,
> > +			unsigned long start,
> > +			unsigned long end,
> > +			dma_addr_t *pa,
> > +			bool write);
> > +	long (*p2p_unmap)(struct vm_area_struct *vma,
> > +			  struct device *device,
> > +			  unsigned long start,
> > +			  unsigned long end,
> > +			  dma_addr_t *pa);
> 
> I don't understand why we need new p2p_[un]map function pointers for
> this. In subsequent patches, they never appear to be set anywhere and
> are only called by the HMM code. I'd have expected it to be called by
> some core VMA code and set by HMM as that's what vm_operations_struct is
> for.
> 
> But the code as all very confusing, hard to follow and seems to be
> missing significant chunks. So I'm not really sure what is going on.

It is set by device driver when userspace do mmap(fd) where fd comes
from open("/dev/somedevicefile"). So it is set by device driver. HMM
has nothing to do with this. It must be set by device driver mmap
call back (mmap callback of struct file_operations). For this patch
you can completely ignore all the HMM patches. Maybe posting this as
2 separate patchset would make it clearer.

For instance see [1] for how a non HMM driver can export its memory
by just setting those callback. Note that a proper implementation of
this should also include some kind of driver policy on what to allow
to map and what to not allow ... All this is driver specific in any
way.

Cheers,
Jérôme

[1] https://cgit.freedesktop.org/~glisse/linux/commit/?h=wip-p2p-showcase&id=964214dcd4df96f296e2214042e8cfce135ae3d4
