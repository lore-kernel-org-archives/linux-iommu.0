From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Tue, 29 Jan 2019 11:36:29 -0700
Message-ID: <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129174728.6430-4-jglisse@redhat.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: jglisse@redhat.com, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org



On 2019-01-29 10:47 a.m., jglisse@redhat.com wrote:

> +	/*
> +	 * Optional for device driver that want to allow peer to peer (p2p)
> +	 * mapping of their vma (which can be back by some device memory) to
> +	 * another device.
> +	 *
> +	 * Note that the exporting device driver might not have map anything
> +	 * inside the vma for the CPU but might still want to allow a peer
> +	 * device to access the range of memory corresponding to a range in
> +	 * that vma.
> +	 *
> +	 * FOR PREDICTABILITY IF DRIVER SUCCESSFULY MAP A RANGE ONCE FOR A
> +	 * DEVICE THEN FURTHER MAPPING OF THE SAME IF THE VMA IS STILL VALID
> +	 * SHOULD ALSO BE SUCCESSFUL. Following this rule allow the importing
> +	 * device to map once during setup and report any failure at that time
> +	 * to the userspace. Further mapping of the same range might happen
> +	 * after mmu notifier invalidation over the range. The exporting device
> +	 * can use this to move things around (defrag BAR space for instance)
> +	 * or do other similar task.
> +	 *
> +	 * IMPORTER MUST OBEY mmu_notifier NOTIFICATION AND CALL p2p_unmap()
> +	 * WHEN A NOTIFIER IS CALL FOR THE RANGE ! THIS CAN HAPPEN AT ANY
> +	 * POINT IN TIME WITH NO LOCK HELD.
> +	 *
> +	 * In below function, the device argument is the importing device,
> +	 * the exporting device is the device to which the vma belongs.
> +	 */
> +	long (*p2p_map)(struct vm_area_struct *vma,
> +			struct device *device,
> +			unsigned long start,
> +			unsigned long end,
> +			dma_addr_t *pa,
> +			bool write);
> +	long (*p2p_unmap)(struct vm_area_struct *vma,
> +			  struct device *device,
> +			  unsigned long start,
> +			  unsigned long end,
> +			  dma_addr_t *pa);

I don't understand why we need new p2p_[un]map function pointers for
this. In subsequent patches, they never appear to be set anywhere and
are only called by the HMM code. I'd have expected it to be called by
some core VMA code and set by HMM as that's what vm_operations_struct is
for.

But the code as all very confusing, hard to follow and seems to be
missing significant chunks. So I'm not really sure what is going on.

Logan
