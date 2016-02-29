From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2] perf/x86/amd: Adding support for new IOMMU performance
	event
Date: Sun, 28 Feb 2016 22:23:29 -0600
Message-ID: <1456719809-20906-1-git-send-email-Suravee.Suthikulpanit@amd.com>
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
To: mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch adds new IOMMU performance event based on
the information in table 74 of the AMD I/O Virtualization Technology
(IOMMU) Specification (Document Id: 4882, Rev 2.62, Feb 2015)

Link: http://support.amd.com/TechDocs/48882_IOMMU.pdf

Reviewed-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---

Hi Ingo/Peter,

I have re-based the patch from tips, and re-send this as V2.
If there is no other concern, would you please accept this patch
when you get a chance. FYI, here is the link to V1
(https://lkml.org/lkml/2015/12/11/891).

Thanks,
Suravee

 arch/x86/events/amd/iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 635e5eb..40625ca 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
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
