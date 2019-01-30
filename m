From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Wed, 30 Jan 2019 10:43:29 -0500
Message-ID: <20190130154328.GA3177@redhat.com>
References: <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com>
 <20190129193250.GK10108@mellanox.com>
 <20190129195055.GH3176@redhat.com>
 <20190129202429.GL10108@mellanox.com>
 <20190129204359.GM3176@redhat.com>
 <20190129224016.GD4713@mellanox.com>
 <20190130000805.GS3176@redhat.com>
 <20190130043020.GC30598@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190130043020.GC30598@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 04:30:27AM +0000, Jason Gunthorpe wrote:
> On Tue, Jan 29, 2019 at 07:08:06PM -0500, Jerome Glisse wrote:
> > On Tue, Jan 29, 2019 at 11:02:25PM +0000, Jason Gunthorpe wrote:
> > > On Tue, Jan 29, 2019 at 03:44:00PM -0500, Jerome Glisse wrote:
> > > 
> > > > > But this API doesn't seem to offer any control - I thought that
> > > > > control was all coming from the mm/hmm notifiers triggering p2p_unmaps?
> > > > 
> > > > The control is within the driver implementation of those callbacks. 
> > > 
> > > Seems like what you mean by control is 'the exporter gets to choose
> > > the physical address at the instant of map' - which seems reasonable
> > > for GPU.
> > > 
> > > 
> > > > will only allow p2p map to succeed for objects that have been tagged by the
> > > > userspace in some way ie the userspace application is in control of what
> > > > can be map to peer device.
> > > 
> > > I would have thought this means the VMA for the object is created
> > > without the map/unmap ops? Or are GPU objects and VMAs unrelated?
> > 
> > GPU object and VMA are unrelated in all open source GPU driver i am
> > somewhat familiar with (AMD, Intel, NVidia). You can create a GPU
> > object and never map it (and thus never have it associated with a
> > vma) and in fact this is very common. For graphic you usualy only
> > have hand full of the hundreds of GPU object your application have
> > mapped.
> 
> I mean the other way does every VMA with a p2p_map/unmap point to
> exactly one GPU object?
> 
> ie I'm surprised you say that p2p_map needs to have policy, I would
> have though the policy is applied when the VMA is created (ie objects
> that are not for p2p do not have p2p_map set), and even for GPU
> p2p_map should really only have to do with window allocation and pure
> 'can I even do p2p' type functionality.

All userspace API to enable p2p happens after object creation and in
some case they are mutable ie you can decide to no longer share the
object (userspace application decision). The BAR address space is a
resource from GPU driver point of view and thus from userspace point
of view. As such decissions that affect how it is use an what object
can use it, can change over application lifetime.

This is why i would like to allow kernel driver to apply any such
access policy, decided by the application on its object (on top of
which the kernel GPU driver can apply its own policy for GPU resource
sharing by forcing some object to main memory).


> 
> > Idea is that we can only ask exporter to be predictable and still allow
> > them to fail if things are really going bad.
> 
> I think hot unplug / PCI error recovery is one of the 'really going
> bad' cases..

GPU can hang and all data becomes _undefined_, it can also be suspended
to save power (think laptop with discret GPU for instance). GPU threads
can be kill ... So they are few cases i can think of where either you
want to kill the p2p mapping and make sure the importer is aware and
might have a change to report back through its own userspace API, or
at very least fallback to dummy pages. In some of the above cases, for
instance suspend, you just want to move thing around to allow to shut
down device memory.


> > I think i put it in the comment above the ops but in any cases i should
> > write something in documentation with example and thorough guideline.
> > Note that there won't be any mmu notifier to mmap of a device file
> > unless the device driver calls for it or there is a syscall like munmap
> > or mremap or mprotect well any syscall that work on vma.
> 
> This is something we might need to explore, does calling
> zap_vma_ptes() invoke enough notifiers that a MMU notifiers or HMM
> mirror consumer will release any p2p maps on that VMA?

Yes it does.

> 
> > If we ever want to support full pin then we might have to add a
> > flag so that GPU driver can refuse an importer that wants things
> > pin forever.
> 
> This would become interesting for VFIO and RDMA at least - I don't
> think VFIO has anything like SVA so it would want to import a p2p_map
> and indicate that it will not respond to MMU notifiers.
> 
> GPU can refuse, but maybe RDMA would allow it...

Ok i will add a flag field in next post. GPU could allow pin but they
would most likely use main memory for any such object, hence it is no
longer really p2p but at least both device look at the same data.

Cheers,
Jérôme
