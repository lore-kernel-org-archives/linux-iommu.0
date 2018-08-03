From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: do not redefined NEED_DMA_MAP_STATE
Date: Fri,  3 Aug 2018 20:48:39 +1000 (AEST)
Message-ID: <41hkKz6mdvz9s0R@ozlabs.org>
References: <20180730073721.15991-1-hch@lst.de>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20180730073721.15991-1-hch@lst.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, paulus@samba.org
Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2018-07-30 at 07:37:21 UTC, Christoph Hellwig wrote:
> kernel/dma/Kconfig already defines NEED_DMA_MAP_STATE, just select it
> from PPC64 and NOT_COHERENT_CACHE instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/06832fc004815b4b43628d21fc8171

cheers
