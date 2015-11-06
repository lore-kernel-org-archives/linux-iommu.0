From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch v2 6/9] iommu/amd: Add functions
	copy_command_buffer/copy_event_buffer
Date: Fri,  6 Nov 2015 20:10:48 +0800
Message-ID: <1446811851-20623-7-git-send-email-bhe@redhat.com>
References: <1446811851-20623-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1446811851-20623-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c  | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_types.h |  1 +
 2 files changed, 40 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 16aea93..9c414f0 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -739,6 +739,45 @@ static void copy_dev_tables(void)
         }
 }
 
+static void copy_command_buffer(void)
+{
+        u64 entry;
+        u32 lo, hi;
+        phys_addr_t old_phys;
+        u64 old_virt;
+        struct amd_iommu *iommu;
+
+        for_each_iommu(iommu) {
+                lo = readl(iommu->mmio_base + MMIO_CMD_BUF_OFFSET);
+                hi = readl(iommu->mmio_base + MMIO_CMD_BUF_OFFSET + 4);
+                entry = (((u64) hi) << 32) + lo;
+                old_phys &= (1<<MMIO_CMD_SIZE_SHIFT) -1;
+                old_virt = ioremap_cache(old_phys, CMD_BUFFER_SIZE);
+                memcpy(iommu->cmd_buf, old_virt, CMD_BUFFER_SIZE);
+		iommu->cmd_buf_size &= ~(CMD_BUFFER_UNINITIALIZED);
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
+}
+
 /* sets a specific bit in the device table entry. */
 static void set_dev_entry_bit(u16 devid, u8 bit)
 {
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index a481c74..4277cc9 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -209,6 +209,7 @@
 /* constants for event buffer handling */
 #define EVT_BUFFER_SIZE		8192 /* 512 entries */
 #define EVT_LEN_MASK		(0x9ULL << 56)
+#define MMIO_EVT_SIZE_SHIFT 56
 
 /* Constants for PPR Log handling */
 #define PPR_LOG_ENTRIES		512
-- 
2.4.0
