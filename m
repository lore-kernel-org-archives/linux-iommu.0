From: Christoph Hellwig <hch@lst.de>
Subject: Re: [Xen-devel] [PATCH] Revert "swiotlb: remove SWIOTLB_MAP_ERROR"
Date: Fri, 8 Mar 2019 16:23:55 +0100
Message-ID: <20190308152355.GA20230@lst.de>
References: <20190304195951.1118807-1-arnd@arndb.de> <b0b995a1-3211-870f-01af-ce837c18e8f9@arm.com> <CAK8P3a2KQKTDQCQcFR7ZTFJ+_XhfKpy9W27r+YV=iD6hLVu2xg@mail.gmail.com> <957e168a-2589-89c7-3a72-5071a7b6c65a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <957e168a-2589-89c7-3a72-5071a7b6c65a@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Julien Grall <julien.grall@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>, xen-devel <xen-devel@lists.xenproject.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 05, 2019 at 09:41:46AM +0000, Julien Grall wrote:
> On Xen, dma_addr_t will always be 64-bit while the phys_addr_t will depend 
> on the MMU type. So we may have phys_addr_t smaller than dma_addr_t from 
> the kernel point of view.

How can dma_addr_t on arm have value > 32-bit when physical
addresses are 32-bit only?
