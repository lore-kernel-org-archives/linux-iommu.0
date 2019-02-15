From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/5] sparc64: refactor the ali DMA quirk
Date: Fri, 15 Feb 2019 10:34:31 -0800 (PST)
Message-ID: <20190215.103431.281080744416004293.davem@davemloft.net>
References: <20190215144559.8777-1-hch@lst.de>
        <20190215144559.8777-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215144559.8777-3-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: deller@gmx.de, robin.murphy@arm.com, iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Christoph Hellwig <hch@lst.de>
Date: Fri, 15 Feb 2019 15:45:56 +0100

> Do the quirk first in the dma_supported routines, as we don't need
> any of the other checks for it, and remove the duplicate mask checking
> that is already done by the callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
