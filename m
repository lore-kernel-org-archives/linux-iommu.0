From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: DMA mapping API(IOMMU) for ARM64?
Date: Tue, 18 Jun 2013 11:19:14 +0100
Message-ID: <20130618101914.GB3539@mudshark.cambridge.arm.com>
References: <20130618.053955.305832937374936961.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130618.053955.305832937374936961.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Arnd-r2nGTMty4D4@public.gmane.org" <Arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 18, 2013 at 03:39:55AM +0100, Hiroshi Doyu wrote:
> Hi,

Hello Hiroshi,

> Currently ARM64 supports swiotlb only as below[1]. AFAIU, swiotlb
> provides some kind of bounce buffer for some restricted H/Ws, and it
> cannot replace IOMMU H/W completely. So I'm wondering that we would
> need the IOMMU versions of dma_map_ops as Marek did for ARM32. If my
> understanding is correct, do you guys have any idea how it's going to
> be implemented? Can we reuse the current version of "iommu_ops" in
> "arch/arm/mm/dma-mapping.c" for ARM64 as well? Or do we need to
> rewrite 64bit version of iommu_ops completely in the same file as one
> with swiotlb, "arch/arm64/mm/dma-mapping.c"?
> 
> Any feedback would be really appreciated.

I've spoken briefly with Catalin about this and it seems like there might be
*some* scope for sharing common dma-mapping code between architectures.
There doesn't really need to be any architecture-specific details in
allocating iova space and the interface to the iommu drivers is
well-defined. The arch-specific stuff is bogged down in the non-coherent
buffer management, but that doesn't necessarily equate to lots of code.

So, the best bet would be to figure out how to split up what we have under
arch/arm/ so that it can be re-used by arm64 and potentially other
architectures (powerpc has some simple stuff for coherent mappings and some
less-simple stuff for non-coherent buffers).

Will
