From: Julien Grall <julien.grall@arm.com>
Subject: Re: [Xen-devel] [PATCH] Revert "swiotlb: remove SWIOTLB_MAP_ERROR"
Date: Fri, 8 Mar 2019 17:25:57 +0000
Message-ID: <124f4e49-9eb1-99d9-35f4-c2ef3dff8415@arm.com>
References: <20190304195951.1118807-1-arnd@arndb.de>
 <b0b995a1-3211-870f-01af-ce837c18e8f9@arm.com>
 <CAK8P3a2KQKTDQCQcFR7ZTFJ+_XhfKpy9W27r+YV=iD6hLVu2xg@mail.gmail.com>
 <957e168a-2589-89c7-3a72-5071a7b6c65a@arm.com>
 <20190308152355.GA20230@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308152355.GA20230@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>, xen-devel <xen-devel@lists.xenproject.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On 08/03/2019 15:23, Christoph Hellwig wrote:
> On Tue, Mar 05, 2019 at 09:41:46AM +0000, Julien Grall wrote:
>> On Xen, dma_addr_t will always be 64-bit while the phys_addr_t will depend
>> on the MMU type. So we may have phys_addr_t smaller than dma_addr_t from
>> the kernel point of view.
> 
> How can dma_addr_t on arm have value > 32-bit when physical
> addresses are 32-bit only?

The number of platform with IOMMU protected all DMA-capable device is not yet 
there. So we decided to not require IOMMU for Dom0. Instead, its memory is be 
directly mapped (i.e guest physical address == host physical address) and will 
always be below 4GB to cater the short page table case.

In the common case, Dom0 also contains the PV backend drivers. Those drivers may 
directly use the guest buffer in the DMA request (so a copy is avoided). To 
avoid using a bounce buffer too much, xen-swiotlb will find the host physical 
address associated to the guest buffer and will use it to compute the DMA address.

While Dom0 kernel may only deal with 32-bit physical address, the hypervisor can 
still deal with up to 40-bit physical address. This means the guest memory can 
be allocated above the 4GB threshold. Hence why the dma_addr_t is always 64-bit 
with CONFIG_XEN=y.

Cheers,

-- 
Julien Grall
