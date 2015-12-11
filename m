From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] perf/x86/amd: Adding support for new IOMMU performance event
Date: Fri, 11 Dec 2015 16:53:17 -0600
Message-ID: <1449874397-27056-1-git-send-email-Suravee.Suthikulpanit@amd.com>
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
To: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>

This patch adds new IOMMU performance event based on
the information in table 74 of the AMD I/O Virtualization Technology
(IOMMU) Specification (Document Id: 4882, Rev 2.62, Feb 2015)

Link: http://support.amd.com/TechDocs/48882_IOMMU.pdf
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/kernel/cpu/perf_event_amd_iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/perf_event_amd_iommu.c b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
index 97242a9..86f8259 100644
--- a/arch/x86/kernel/cpu/perf_event_amd_iommu.c
+++ b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
@@ -118,6 +118,11 @@ static struct amd_iommu_event_desc amd_iommu_v2_event_descs[] = {
 	AMD_IOMMU_EVENT_DESC(cmd_processed,           "csource=0x11"),
 	AMD_IOMMU_EVENT_DESC(cmd_processed_inv,       "csource=0x12"),
 	AMD_IOMMU_EVENT_DESC(tlb_inv,                 "csource=0x13"),
+	AMD_IOMMU_EVENT_DESC(ign_rd_wr_mmio_1ff8h,    "csource=0x14"),
+	AMD_IOMMU_EVENT_DESC(vapic_int_non_guest,     "csource=0x15"),
+	AMD_IOMMU_EVENT_DESC(vapic_int_guest,         "csource=0x16"),
+	AMD_IOMMU_EVENT_DESC(smi_recv,                "csource=0x17"),
+	AMD_IOMMU_EVENT_DESC(smi_blk,                 "csource=0x18"),
 	{ /* end: all zeroes */ },
 };
 
-- 
1.9.1
