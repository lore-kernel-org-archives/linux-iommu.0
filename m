From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 2/2] iommu/mediatek: Fix a build warning of BIT(32) in ARM
Date: Thu, 24 Aug 2017 15:42:12 +0800
Message-ID: <1503560532-24416-2-git-send-email-yong.wu@mediatek.com>
References: <1503560532-24416-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1503560532-24416-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The commit ("iommu/mediatek: Enlarge the validate PA range
for 4GB mode") introduce the following build warning while ARCH=arm:

   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_iova_to_phys':
   include/linux/bitops.h:6:24: warning: left shift count >= width
of type [-Wshift-count-overflow]
    #define BIT(nr)   (1UL << (nr))
                           ^
>> drivers/iommu/mtk_iommu.c:407:9: note: in expansion of macro 'BIT'
      pa |= BIT(32);

  drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_probe':
   include/linux/bitops.h:6:24: warning: left shift count >= width
of type [-Wshift-count-overflow]
    #define BIT(nr)   (1UL << (nr))
                           ^
   drivers/iommu/mtk_iommu.c:589:35: note: in expansion of macro 'BIT'
     data->enable_4GB = !!(max_pfn > (BIT(32) >> PAGE_SHIFT));

Use BIT_ULL instead of BIT.

Reported-by: kernel test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/iommu/mtk_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index bc00e40..bd515be 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -404,7 +404,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
 	if (data->enable_4GB)
-		pa |= BIT(32);
+		pa |= BIT_ULL(32);
 
 	return pa;
 }
@@ -586,7 +586,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
 
 	/* Whether the current dram is over 4GB */
-	data->enable_4GB = !!(max_pfn > (BIT(32) >> PAGE_SHIFT));
+	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->base = devm_ioremap_resource(dev, res);
-- 
1.9.1
