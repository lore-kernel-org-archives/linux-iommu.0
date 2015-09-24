From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 06/10] iommu/amd: Add functions
	copy_command_buffer/copy_event_buffer
Date: Thu, 24 Sep 2015 14:37:32 +0800
Message-ID: <1443076656-31776-7-git-send-email-bhe@redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1443076656-31776-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Copy command buffer and event buffer from the old to kdump kernel.

Still there are 2 problems:
  1) Not very sure if this is necessary. If do not copy the old command buffer, and
only set the newly allocated command buffer, is there anything wrong?

  2) If copy is needed, do we need to take care of the head and tail pointers? Since
in section 3.3 of AMD IOMMU spec it says: "Any or all command buffer entries may be
copied from the old command buffer to the new and software must set the head and tail
pointers appropriately." However from the spec the command buffer head pointer and
tail register store an offset from the base address, which point to the next command
to be read/written separately.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c  | 37 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_types.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 913a718..a334d14 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -713,7 +713,44 @@ static void copy_dev_tables(void)
                 }
                 iounmap(old_devtb);
         }
+}
+
+static void copy_command_buffer(void)
+{
+        u64 entry;
+        u32 lo, hi;
+        phys_addr_t old_phys;
+        u64 old_virt;
+        struct amd_iommu *iommu;
 
+        for_each_iommu(iommu) {
+                lo = readl(iommu->mmio_base + MMIO_CMD_BUF_OFFSET);
+                hi = readl(iommu->mmio_base + MMIO_CMD_BUF_OFFSET + 4);
+                entry = (((u64) hi) << 32) + lo;
+                old_phys &= (1<<MMIO_CMD_SIZE_SHIFT) -1;
+                old_virt = ioremap_cache(old_phys, CMD_BUFFER_SIZE);
+                memcpy(iommu->cmd_buf, old_virt, CMD_BUFFER_SIZE);
+                iounmap(old_virt);
+        }
+}
+
+static void copy_event_buffer(void)
+{
+        u64 entry;
+        u32 lo, hi;
+        phys_addr_t old_phys;
+        u64 old_virt;
+        struct amd_iommu *iommu;
+
+        for_each_iommu(iommu) {
+                lo = readl(iommu->mmio_base + MMIO_EVT_BUF_OFFSET);
+                hi = readl(iommu->mmio_base + MMIO_EVT_BUF_OFFSET + 4);
+                entry = (((u64) hi) << 32) + lo;
+                old_phys &= (1<<MMIO_EVT_SIZE_SHIFT) -1;
+                old_virt = ioremap_cache(old_phys, EVT_BUFFER_SIZE);
+                memcpy(iommu->evt_buf, old_virt, EVT_BUFFER_SIZE);
+                iounmap(old_virt);
+        }
 }
 
 /* sets a specific bit in the device table entry. */
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index d0f0cfb..250384e 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -208,6 +208,7 @@
 /* constants for event buffer handling */
 #define EVT_BUFFER_SIZE		8192 /* 512 entries */
 #define EVT_LEN_MASK		(0x9ULL << 56)
+#define MMIO_EVT_SIZE_SHIFT 56
 
 /* Constants for PPR Log handling */
 #define PPR_LOG_ENTRIES		512
-- 
2.4.0
