From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/mediatek: include linux/dma-mapping.h
Date: Wed, 17 May 2017 14:51:45 +0200
Message-ID: <20170517125144.GD11068@8bytes.org>
References: <20170511113619.2596882-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170511113619.2596882-1-arnd-r2nGTMty4D4@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, May 11, 2017 at 01:35:51PM +0200, Arnd Bergmann wrote:
> The mediatek iommu driver relied on an implicit include of dma-mapping.h,
> but for some reason that is no longer there in 4.12-rc1:
> 
> drivers/iommu/mtk_iommu_v1.c: In function 'mtk_iommu_domain_finalise':
> drivers/iommu/mtk_iommu_v1.c:233:16: error: implicit declaration of function 'dma_zalloc_coherent'; did you mean 'debug_dma_alloc_coherent'? [-Werror=implicit-function-declaration]
> drivers/iommu/mtk_iommu_v1.c: In function 'mtk_iommu_domain_free':
> drivers/iommu/mtk_iommu_v1.c:265:2: error: implicit declaration of function 'dma_free_coherent'; did you mean 'debug_dma_free_coherent'? [-Werror=implicit-function-declaration]
> 
> This adds an explicit #include to make it build again.
> 
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

Applied to iommu/fixes, thanks Arnd.

This was probably another victim of 

	208480b iommu: Remove trace-events include from iommu.h
