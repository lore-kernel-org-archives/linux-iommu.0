From: Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH char-misc-testing 1/1] Revert "iommu: Allow iova to be used
	without requiring IOMMU_SUPPORT"
Date: Mon,  5 Oct 2015 10:37:01 -0700
Message-ID: <6471c669038a1f1ad4b2342226290c453b052e6a.1444066190.git.sudeep.dutt@intel.com>
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
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: David Woodhouse <david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashutosh Dixit <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Nikhil Rao <nikhil.rao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Revert 'commit 353649e5da90 ("iommu: Allow iova to be used without
requiring IOMMU_SUPPORT"). This commit is made unnecessary by
'commit ac6d83ccd9c5 ("misc: mic: Fix SCIF build failure with
IOMMU_SUPPORT disabled") and will create a conflict upon merging
with 4.3-rc4. The correct long term solution is to move the iova
library from drivers/iommu into lib/iova which will be done in
a future patch.

Cc: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Ashutosh Dixit <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 71d1c46..d9da766 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -12,9 +12,6 @@ menuconfig IOMMU_SUPPORT
 	  remap DMA requests and/or remap interrupts from other devices on the
 	  system.
 
-config IOMMU_IOVA
-	tristate
-
 if IOMMU_SUPPORT
 
 menu "Generic IOMMU Pagetable Support"
@@ -45,6 +42,9 @@ config IOMMU_IO_PGTABLE_LPAE_SELFTEST
 
 endmenu
 
+config IOMMU_IOVA
+	tristate
+
 config OF_IOMMU
        def_bool y
        depends on OF && IOMMU_API
-- 
1.8.2.1
