From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Tue, 29 Jan 2019 21:48:52 -0500
Message-ID: <20190130024851.GB10462@redhat.com>
References: <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com>
 <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205749.GN3176@redhat.com>
 <2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
 <20190129215028.GQ3176@redhat.com>
 <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
 <20190129234752.GR3176@redhat.com>
 <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 29, 2019 at 06:17:43PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2019-01-29 4:47 p.m., Jerome Glisse wrote:
> > The whole point is to allow to use device memory for range of virtual
> > address of a process when it does make sense to use device memory for
> > that range. So they are multiple cases where it does make sense:
> > [1] - Only the device is accessing the range and they are no CPU access
> >       For instance the program is executing/running a big function on
> >       the GPU and they are not concurrent CPU access, this is very
> >       common in all the existing GPGPU code. In fact AFAICT It is the
> >       most common pattern. So here you can use HMM private or public
> >       memory.
> > [2] - Both device and CPU access a common range of virtul address
> >       concurrently. In that case if you are on a platform with cache
> >       coherent inter-connect like OpenCAPI or CCIX then you can use
> >       HMM public device memory and have both access the same memory.
> >       You can not use HMM private memory.
> > 
> > So far on x86 we only have PCIE and thus so far on x86 we only have
> > private HMM device memory that is not accessible by the CPU in any
> > way.
> 
> I feel like you're just moving the rug out from under us... Before you
> said ignore HMM and I was asking about the use case that wasn't using
> HMM and how it works without HMM. In response, you just give me *way*
> too much information describing HMM. And still, as best as I can see,
> managing DMA mappings (which is different from the userspace mappings)
> for GPU P2P should be handled by HMM and the userspace mappings should
> *just* link VMAs to HMM pages using the standard infrastructure we
> already have.

For HMM P2P mapping we need to call into the driver to know if driver
wants to fallback to main memory (running out of BAR addresses) or if
it can allow a peer device to directly access its memory. We also need
the call to exporting device driver as only the exporting device driver
can map the HMM page pfn to some physical BAR address (which would be
allocated by driver for GPU).

I wanted to make sure the HMM case was understood too, sorry if it
caused confusion with the non HMM case which i describe below.


> >> And what struct pages are actually going to be backing these VMAs if
> >> it's not using HMM?
> > 
> > When you have some range of virtual address migrated to HMM private
> > memory then the CPU pte are special swap entry and they behave just
> > as if the memory was swapped to disk. So CPU access to those will
> > fault and trigger a migration back to main memory.
> 
> This isn't answering my question at all... I specifically asked what is
> backing the VMA when we are *not* using HMM.

So when you are not using HMM ie existing GPU object without HMM then
like i said you do not have any valid pte most of the time inside the
CPU page table ie the GPU driver only populate the pte with valid
entry when they are CPU page fault and it clear those as soon as the
corresponding object is use by the GPU. In fact some driver also unmap
it agressively from the BAR making the memory totaly un-accessible to
anything but the GPU.

GPU driver do not like CPU mapping, they are quite aggressive about
clearing them. Then everything i said about having userspace deciding
which object can be share, and, with who, do apply here. So for GPU you
do want to give control to GPU driver and you do not want to require valid
CPU pte for the vma so that the exporting driver can return valid
address to the importing peer device only.

Also exporting device driver might decide to fallback to main memory
(running out of BAR addresses for instance). So again here we want to
go through the exporting device driver so that it can take the right
action.

So the expected pattern (for GPU driver) is:
    - no valid pte for the special vma (mmap of device file)
    - importing device call p2p_map() for the vma if it succeed the
      first time then we expect it will succeed for the same vma and
      range next time we call it.
    - exporting driver can either return physical address to page
      into its BAR space that point to the correct device memory or
      fallback to main memory

Then at any point in time:
    - if GPU driver want to move the object around (for whatever
      reasons) it calls zap_vma_ptes() the fact that there is no
      valid CPU pte does not matter it will call mmu notifier and thus
      any importing device driver will invalidate its mapping
    - importing device driver that lost the mapping due to mmu
      notification can re-map by re-calling p2p_map() (it should
      check that the vma is still valid ...) and guideline is for
      the exporting device driver to succeed and return valid
      address to the new memory use for the object

This allow device driver like GPU to keep control. The expected
pattern is still the p2p mapping to stay undisrupted for their
whole lifetime. Invalidation should only be triggered if GPU driver
do need to move things around.

All the above is for the no HMM case ie mmap of a device file so
for any existing open source GPU device driver that do not support
HMM.

Cheers,
Jérôme
