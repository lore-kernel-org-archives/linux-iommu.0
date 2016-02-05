From: Andy Fleming <afleming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] powerpc: Fix incorrect PPC32 PAMU dependency
Date: Thu,  4 Feb 2016 20:16:06 -0600
Message-ID: <1454638566-1953-1-git-send-email-afleming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The Freescale PAMU can also be enabled on 64-bit power
chips. Commit 477ab7a19cec8409e4e2dd10e7348e4cac3c06e5
(iommu: Make more drivers depend on COMPILE_TEST)
added this false dependency. Fixed it by allowing PPC64, too.

Signed-off-by: Andy Fleming <afleming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index a1e75cb..63ec7ae 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -57,7 +57,7 @@ config IOMMU_DMA
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
-	depends on PPC32
+	depends on PPC32 || PPC64
 	depends on PPC_E500MC || COMPILE_TEST
 	select IOMMU_API
 	select GENERIC_ALLOCATOR
-- 
1.9.1
