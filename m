From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] iommu/amd: Add workaround for event log erratum
Date: Thu, 19 Apr 2012 15:39:37 +0200
Message-ID: <1334842777-23214-2-git-send-email-joerg.roedel@amd.com>
References: <1334842777-23214-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1334842777-23214-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Due to a recent erratum it can happen that the head pointer
of the event-log is updated before the actual event-log
entry is written. This patch implements the recommended
workaround.

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org	# all stable kernels
Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |   29 +++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 08f3eec..d90a421 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -450,12 +450,27 @@ static void dump_command(unsigned long phys_addr)
 
 static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 {
-	u32 *event = __evt;
-	int type  = (event[1] >> EVENT_TYPE_SHIFT)  & EVENT_TYPE_MASK;
-	int devid = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
-	int domid = (event[1] >> EVENT_DOMID_SHIFT) & EVENT_DOMID_MASK;
-	int flags = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
-	u64 address = (u64)(((u64)event[3]) << 32) | event[2];
+	int type, devid, domid, flags;
+	volatile u32 *event = __evt;
+	int count = 0;
+	u64 address;
+
+retry:
+	type    = (event[1] >> EVENT_TYPE_SHIFT)  & EVENT_TYPE_MASK;
+	devid   = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
+	domid   = (event[1] >> EVENT_DOMID_SHIFT) & EVENT_DOMID_MASK;
+	flags   = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
+	address = (u64)(((u64)event[3]) << 32) | event[2];
+
+	if (type == 0) {
+		/* Did we hit the erratum? */
+		if (++count == LOOP_TIMEOUT) {
+			pr_err("AMD-Vi: No event written to event log\n");
+			return;
+		}
+		udelay(1);
+		goto retry;
+	}
 
 	printk(KERN_ERR "AMD-Vi: Event logged [");
 
@@ -508,6 +523,8 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	default:
 		printk(KERN_ERR "UNKNOWN type=0x%02x]\n", type);
 	}
+
+	memset(__evt, 0, 4 * sizeof(u32));
 }
 
 static void iommu_poll_events(struct amd_iommu *iommu)
-- 
1.7.5.4
