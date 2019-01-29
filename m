From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Tue, 29 Jan 2019 13:39:49 -0700
Message-ID: <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129193250.GK10108@mellanox.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>, Jerome Glisse <jglisse@redhat.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org



On 2019-01-29 12:32 p.m., Jason Gunthorpe wrote:
> Jerome, I think it would be nice to have a helper scheme - I think the
> simple case would be simple remapping of PCI BAR memory, so if we
> could have, say something like:
> 
> static const struct vm_operations_struct my_ops {
>   .p2p_map = p2p_ioremap_map_op,
>   .p2p_unmap = p2p_ioremap_unmap_op,
> }
> 
> struct ioremap_data {
>   [..]
> }
> 
> fops_mmap() {
>    vma->private_data = &driver_priv->ioremap_data;
>    return p2p_ioremap_device_memory(vma, exporting_device, [..]);
> }

This is roughly what I was expecting, except I don't see exactly what
the p2p_map and p2p_unmap callbacks are for. The importing driver should
see p2pdma/hmm struct pages and use the appropriate function to map
them. It shouldn't be the responsibility of the exporting driver to
implement the mapping. And I don't think we should have 'special' vma's
for this (though we may need something to ensure we don't get mapping
requests mixed with different types of pages...).

I also figured there'd be a fault version of p2p_ioremap_device_memory()
for when you are mapping P2P memory and you want to assign the pages
lazily. Though, this can come later when someone wants to implement that.

Logan
