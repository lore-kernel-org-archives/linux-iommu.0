From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu: exynos: add support for dt based instantiation
	for iommu devices
Date: Sat, 17 Nov 2012 22:37:34 +0100
Message-ID: <20121117213734.GV25742@8bytes.org>
References: <1352108895-21087-1-git-send-email-rahul.sharma@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352108895-21087-1-git-send-email-rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, prashanth.g-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, s.shirish-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 05, 2012 at 03:18:15PM +0530, Rahul Sharma wrote:
>  drivers/iommu/exynos-iommu.c |   28 +++++++++++++++++++++++++---
>  2 files changed, 26 insertions(+), 4 deletions(-)

I added the following build-fix to the arm/exynos branch too:

>From e706d84c9fecd7855191eab2f9e2e0234a0f8e05 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Date: Sat, 17 Nov 2012 22:29:32 +0100
Subject: [PATCH] iommu/exynos: Fix build error in exynos_sysmmu_probe

Fix the following build error:

  CC      drivers/iommu/exynos-iommu.o
/data/repos/linux/drivers/iommu/exynos-iommu.c: In function 'exynos_sysmmu_probe':
/data/repos/linux/drivers/iommu/exynos-iommu.c:647:43: error: dereferencing pointer to incomplete type
make[3]: *** [drivers/iommu/exynos-iommu.o] Error 1

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 9079f71..da1975d 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -26,6 +26,7 @@
 #include <linux/memblock.h>
 #include <linux/export.h>
 #include <linux/of_platform.h>
+#include <linux/of.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
-- 
1.7.9.5
