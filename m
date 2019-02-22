From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [01/32] net: pasemi: set a 64-bit DMA mask on the DMA device
Date: Fri, 22 Feb 2019 20:47:56 +1100 (AEDT)
Message-ID: <445RND0KxYz9sNT@ozlabs.org>
References: <20190213070133.11259-2-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213070133.11259-2-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>
Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2019-02-13 at 07:01:02 UTC, Christoph Hellwig wrote:
> The pasemi driver never set a DMA mask, and given that the powerpc
> DMA mapping routines never check it this worked ok so far.  But the
> generic dma-direct code which I plan to switch on for powerpc checks
> the DMA mask and fails unsupported mapping requests, so we need to
> make sure the proper 64-bit mask is set.
> 
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/74ebe3e733b791f37415b3a1b917ee50

cheers
