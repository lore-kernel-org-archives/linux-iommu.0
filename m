From: <zhe.he@windriver.com>
Subject: [PATCH] kernel/dma: Fix panic caused by passing swiotlb to command line
Date: Mon, 17 Sep 2018 11:27:11 +0800
Message-ID: <1537154831-447363-1-git-send-email-zhe.he@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: zhe.he@windriver.com
List-Id: iommu@lists.linux-foundation.org

From: He Zhe <zhe.he@windriver.com>

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

This patch adds a check to prevent the panic.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: stable@vger.kernel.org
Cc: konrad.wilk@oracle.com
Cc: hch@lst.de
Cc: m.szyprowski@samsung.com
Cc: robin.murphy@arm.com
---
 kernel/dma/swiotlb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 4f8a6db..46fc34e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -109,6 +109,11 @@ static int late_alloc;
 static int __init
 setup_io_tlb_npages(char *str)
 {
+	if (!str) {
+		pr_err("Config string not provided\n");
+		return -EINVAL;
+	}
+
 	if (isdigit(*str)) {
 		io_tlb_nslabs = simple_strtoul(str, &str, 0);
 		/* avoid tail segment of size < IO_TLB_SEGSIZE */
-- 
2.7.4
