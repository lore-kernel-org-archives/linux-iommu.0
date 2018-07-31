From: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Subject: Re: [PATCH] powerpc: do not redefined NEED_DMA_MAP_STATE
Date: Tue, 31 Jul 2018 20:47:53 +1000
Message-ID: <87d0v3heau.fsf@concordia.ellerman.id.au>
References: <20180730073721.15991-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180730073721.15991-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> writes:

> kernel/dma/Kconfig already defines NEED_DMA_MAP_STATE, just select it
> from PPC64 and NOT_COHERENT_CACHE instead.
>
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> ---
>  arch/powerpc/Kconfig                   | 3 ---
>  arch/powerpc/platforms/Kconfig.cputype | 2 ++
>  2 files changed, 2 insertions(+), 3 deletions(-)

Thanks.

I did this instead:

commit 870771ae76010c5e42ee8e0278f5823e46e96e3f (HEAD -> next-test)
Author:     Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
AuthorDate: Mon Jul 30 09:37:21 2018 +0200
Commit:     Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
CommitDate: Tue Jul 31 20:43:57 2018 +1000

    powerpc: Do not redefine NEED_DMA_MAP_STATE
    
    kernel/dma/Kconfig already defines NEED_DMA_MAP_STATE, just select it
    from CONFIG_PPC using the same condition as an if guard.
    
    Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
    [mpe: Move it under PPC]
    Signed-off-by: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5eb4d969afbf..ee38fce075ee 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -226,6 +226,7 @@ config PPC
        select IRQ_DOMAIN
        select IRQ_FORCED_THREADING
        select MODULES_USE_ELF_RELA
+       select NEED_DMA_MAP_STATE               if PPC64 || NOT_COHERENT_CACHE
        select NEED_SG_DMA_LENGTH
        select NO_BOOTMEM
        select OF
@@ -885,9 +886,6 @@ config ZONE_DMA
        bool
        default y
 
-config NEED_DMA_MAP_STATE
-       def_bool (PPC64 || NOT_COHERENT_CACHE)
-
 config GENERIC_ISA_DMA
        bool
        depends on ISA_DMA_API


cheers
