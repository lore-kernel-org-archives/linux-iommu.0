From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 4/5] sparc64/pci_sun4v: allow large DMA masks
Date: Fri, 15 Feb 2019 10:35:31 -0800 (PST)
Message-ID: <20190215.103531.2177713502969625146.davem@davemloft.net>
References: <20190215144559.8777-1-hch@lst.de>
        <20190215144559.8777-5-hch@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215144559.8777-5-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: deller@gmx.de, robin.murphy@arm.com, iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Christoph Hellwig <hch@lst.de>
Date: Fri, 15 Feb 2019 15:45:58 +0100

> We've been moving to a model where the device just sets the DMA mask
> supported by it, instead of having to fallback to something it thinks
> the platform might support.  Sparc64 is the remaining holdout forcing
> drivers to supply a matching mask.  Change dma_4v_supported to just
> check if the supplied dma mask is large enough. and adjust the mapping
> code to check ATU presence in addition to the DMA mask to decice on
                                                            ^^^^^^

"decide"

> the mapping method.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
