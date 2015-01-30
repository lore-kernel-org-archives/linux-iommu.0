From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu: disable on !MMU builds
Date: Fri, 30 Jan 2015 13:40:04 +0100
Message-ID: <20150130124004.GF3702@8bytes.org>
References: <1685569.C1Ne1erBMA@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1685569.C1Ne1erBMA@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 28, 2015 at 03:45:53PM +0100, Arnd Bergmann wrote:
> A lot of the IOMMU support code does not build if the CPU does
> not have an MMU itself, and it's not clear if there is any
> use case for it, so let's just disable it and wait for anybody
> to need it.
> 
> This avoids randconfig errors like
> 
> ../arch/arm/mm/dma-mapping.c: In function '__iommu_alloc_remap':
> ../arch/arm/mm/dma-mapping.c:1278:34: error: 'VM_ARM_DMA_CONSISTENT' undeclared (first use in this function)
>   area = get_vm_area_caller(size, VM_ARM_DMA_CONSISTENT | VM_USERMAP,
>                                   ^
> ../arch/arm/mm/dma-mapping.c:1278:34: note: each undeclared identifier is reported only once for each function it appears in
> ../arch/arm/mm/dma-mapping.c: In function '__atomic_get_pages':
> ../arch/arm/mm/dma-mapping.c:1358:27: error: 'atomic_pool' undeclared (first use in this function)
>   struct dma_pool *pool = &atomic_pool;
> 
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

Applied to core branch, thanks.
