From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/mediatek: select ARM_DMA_USE_IOMMU
Date: Mon, 29 Feb 2016 16:48:22 +0100
Message-ID: <20160229154822.GC13711@8bytes.org>
References: <1456737553-496245-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456737553-496245-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 29, 2016 at 10:19:06AM +0100, Arnd Bergmann wrote:
> The newly added Mediatek IOMMU driver uses the IOMMU_DMA infrastructure,
> but unlike other such drivers, it does not select 'ARM_DMA_USE_IOMMU',
> which is a prerequisite, leading to a link error:
> 
> warning: (MTK_IOMMU) selects IOMMU_DMA which has unmet direct dependencies (IOMMU_SUPPORT && NEED_SG_DMA_LENGTH)
> drivers/iommu/built-in.o: In function `iommu_put_dma_cookie':
> mtk_iommu.c:(.text+0x11fe): undefined reference to `put_iova_domain'
> drivers/iommu/built-in.o: In function `iommu_dma_init_domain':
> mtk_iommu.c:(.text+0x1316): undefined reference to `init_iova_domain'
> drivers/iommu/built-in.o: In function `__iommu_dma_unmap':
> mtk_iommu.c:(.text+0x1380): undefined reference to `find_iova'
> 
> This adds the same select that the other drivers have. On a related
> note, I wonder if we should just always select ARM_DMA_USE_IOMMU
> whenever any IOMMU driver is enabled. Are there any cases where
> we would enable an IOMMU but not use it?
> 
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Fixes: 0df4fabe208d ("iommu/mediatek: Add mt8173 IOMMU driver")
> ---
>  drivers/iommu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied both, thanks.
