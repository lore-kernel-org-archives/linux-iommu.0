From: Ashutosh Dixit <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH char-misc-next v2 04/22] iommu: Allow iova to be used without
	requiring IOMMU_SUPPORT
Date: Tue, 29 Sep 2015 18:09:05 -0700
Message-ID: <bff58cca8a0f5591e0a39680ff73e8ee34269668.1443573394.git.ashutosh.dixit@intel.com>
References: <cover.1443573394.git.ashutosh.dixit@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1443573394.git.ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashutosh Dixit <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Nikhil Rao <nikhil.rao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

iova is a library which can be built without IOMMU_SUPPORT

Signed-off-by: Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d9da766..71d1c46 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -12,6 +12,9 @@ menuconfig IOMMU_SUPPORT
 	  remap DMA requests and/or remap interrupts from other devices on the
 	  system.
 
+config IOMMU_IOVA
+	tristate
+
 if IOMMU_SUPPORT
 
 menu "Generic IOMMU Pagetable Support"
@@ -42,9 +45,6 @@ config IOMMU_IO_PGTABLE_LPAE_SELFTEST
 
 endmenu
 
-config IOMMU_IOVA
-	tristate
-
 config OF_IOMMU
        def_bool y
        depends on OF && IOMMU_API
-- 
2.0.0.rc3.2.g998f840
