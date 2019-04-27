From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 7/9] dpaa_eth: fix iova handling for contiguous frames
Date: Sat, 27 Apr 2019 09:46:12 -0700
Message-ID: <20190427164612.GA12450@infradead.org>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
 <20190427071031.6563-8-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190427071031.6563-8-laurentiu.tudor@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: laurentiu.tudor@nxp.com
Cc: netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com, camelia.groza@nxp.com, leoyang.li@nxp.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Sat, Apr 27, 2019 at 10:10:29AM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> The driver relies on the no longer valid assumption that dma addresses
> (iovas) are identical to physical addressees and uses phys_to_virt() to
> make iova -> vaddr conversions. Fix this by adding a function that does
> proper iova -> phys conversions using the iommu api and update the code
> to use it.
> Also, a dma_unmap_single() call had to be moved further down the code
> because iova -> vaddr conversions were required before the unmap.
> For now only the contiguous frame case is handled and the SG case is
> split in a following patch.
> While at it, clean-up a redundant dpaa_bpid2pool() and pass the bp
> as parameter.

Err, this is broken.  A driver using the DMA API has no business
call IOMMU APIs.  Just save the _virtual_ address used for the mapping
away and use that again.  We should not go through crazy gymnastics
like this.
