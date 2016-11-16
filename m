From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] iommu: mtk: add common-clk dependency
Date: Wed, 16 Nov 2016 11:38:50 -0800
Message-ID: <20161116193850.GK25626@codeaurora.org>
References: <20161116152837.3508723-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161116152837.3508723-1-arnd-r2nGTMty4D4@public.gmane.org>
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
Cc: James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Erin Lo <erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/16, Arnd Bergmann wrote:
> After the MT2701 clock driver was added, we get a harmless warning for
> the iommu driver that selects it, when compile-testing without
> COMMON_CLK.
> 
> warning: (MTK_IOMMU_V1) selects COMMON_CLK_MT2701_IMGSYS which has unmet direct dependencies (COMMON_CLK)
> 
> Adding a dependency on COMMON_CLK avoids the warning.
> 
> Fixes: e9862118272a ("clk: mediatek: Add MT2701 clock support")
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

Hm.. why is an iommu driver selecting a clk driver? They should
be using standard clk APIs so it's not like they need it for
build time correctness. Shouldn't we drop the selects instead?
Those look to have been introduced a few kernel versions ago, but
they were selecting options that didn't exist until a few days
ago when I merged the mediatek clk driver. The clk options are
user-visible, so it should be possible to select them in the
configuration phase.

----8<----
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 8ee54d71c7eb..37e204f3d9be 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -352,9 +352,6 @@ config MTK_IOMMU_V1
 	select IOMMU_API
 	select MEMORY
 	select MTK_SMI
-	select COMMON_CLK_MT2701_MMSYS
-	select COMMON_CLK_MT2701_IMGSYS
-	select COMMON_CLK_MT2701_VDECSYS
 	help
 	  Support for the M4U on certain Mediatek SoCs. M4U generation 1 HW is
 	  Multimedia Memory Managememt Unit. This option enables remapping of

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
