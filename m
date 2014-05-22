From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/3] iommu/exynos: Fix trivial typo
Date: Thu, 22 May 2014 09:50:55 +0530
Message-ID: <1400732456-5716-2-git-send-email-sachin.kamat@linaro.org>
References: <1400732456-5716-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1400732456-5716-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Fix typo and add missing punctuation.

Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/Kconfig |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index b067a62263d1..422807ff0999 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -181,10 +181,10 @@ config EXYNOS_IOMMU
 	depends on ARCH_EXYNOS
 	select IOMMU_API
 	help
-	  Support for the IOMMU(System MMU) of Samsung Exynos application
-	  processor family. This enables H/W multimedia accellerators to see
-	  non-linear physical memory chunks as a linear memory in their
-	  address spaces
+	  Support for the IOMMU (System MMU) of Samsung Exynos application
+	  processor family. This enables H/W multimedia accelerators to see
+	  non-linear physical memory chunks as linear memory in their
+	  address space.
 
 	  If unsure, say N here.
 
@@ -193,9 +193,9 @@ config EXYNOS_IOMMU_DEBUG
 	depends on EXYNOS_IOMMU
 	help
 	  Select this to see the detailed log message that shows what
-	  happens in the IOMMU driver
+	  happens in the IOMMU driver.
 
-	  Say N unless you need kernel log message for IOMMU debugging
+	  Say N unless you need kernel log message for IOMMU debugging.
 
 config SHMOBILE_IPMMU
 	bool
-- 
1.7.9.5
