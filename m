From: <zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: [PATCH v2] kernel/dma: Fix panic caused by passing swiotlb to command
	line
Date: Mon, 3 Dec 2018 18:22:51 +0800
Message-ID: <1543832571-121638-1-git-send-email-zhe.he@windriver.com>
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
To: konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: He Zhe <zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>

setup_io_tlb_npages does not check input argument before passing it
to isdigit. The argument would be a NULL pointer if "swiotlb", without
its value, is set in command line and thus causes the following panic.

PANIC: early exception 0xe3 IP 10:ffffffffbb9b8e9f error 0 cr2 0x0
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc3-yocto-standard+ #9
[    0.000000] RIP: 0010:setup_io_tlb_npages+0xf/0x95
...
[    0.000000] Call Trace:
[    0.000000]  do_early_param+0x57/0x8e
[    0.000000]  parse_args+0x208/0x320
[    0.000000]  ? rdinit_setup+0x30/0x30
[    0.000000]  parse_early_options+0x29/0x2d
[    0.000000]  ? rdinit_setup+0x30/0x30
[    0.000000]  parse_early_param+0x36/0x4d
[    0.000000]  setup_arch+0x336/0x99e
[    0.000000]  start_kernel+0x6f/0x4e6
[    0.000000]  x86_64_start_reservations+0x24/0x26
[    0.000000]  x86_64_start_kernel+0x6f/0x72
[    0.000000]  secondary_startup_64+0xa4/0xb0

This patch adds a check to prevent the panic and sets it for 4MB by default.

Signed-off-by: He Zhe <zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
Cc: hch-jcswGhMUV9g@public.gmane.org
Cc: m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: robin.murphy-5wv7dgnIgG8@public.gmane.org

Signed-off-by: He Zhe <zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
---
v2: Set swiotlb for 4MB by default

 kernel/dma/swiotlb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 045930e..0e18cd4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -58,6 +58,9 @@
  */
 #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
 
+#define IO_TLB_DEFAULT_MB 4
+#define IO_TLB_DEFAULT_SLABS ((IO_TLB_DEFAULT_MB<<20) >> IO_TLB_SHIFT)
+
 enum swiotlb_force swiotlb_force;
 
 /*
@@ -103,6 +106,14 @@ static int late_alloc;
 static int __init
 setup_io_tlb_npages(char *str)
 {
+	if (!str) {
+		pr_err("No value provided for swiotlb, "
+		       "set it to %d slabs for %dMB by default.\n",
+		       IO_TLB_DEFAULT_SLABS, IO_TLB_DEFAULT_MB);
+		io_tlb_nslabs = IO_TLB_DEFAULT_SLABS;
+		return 0;
+	}
+
 	if (isdigit(*str)) {
 		io_tlb_nslabs = simple_strtoul(str, &str, 0);
 		/* avoid tail segment of size < IO_TLB_SEGSIZE */
-- 
2.7.4
