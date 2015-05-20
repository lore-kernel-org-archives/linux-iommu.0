From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v5 2/9] iommu,
	x86: Define new irte structure for VT-d Posted-Interrupts
Date: Wed, 20 May 2015 13:15:30 +0800
Message-ID: <1432098937-19527-3-git-send-email-feng.wu@intel.com>
References: <1432098937-19527-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432098937-19527-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add a new irte_pi structure for VT-d Posted-Interrupts.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 include/linux/dmar.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 8473756..c7f9cda 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -212,6 +212,38 @@ struct irte {
 	};
 };
 
+struct irte_pi {
+	union {
+		struct {
+			__u64   present		: 1,
+				fpd		: 1,
+				__reserved_1	: 6,
+				avail		: 4,
+				__reserved_2	: 2,
+				urg		: 1,
+				pst		: 1,
+				vector		: 8,
+				__reserved_3	: 14,
+				pda_l		: 26;
+		};
+		__u64 low;
+	};
+
+	union {
+		struct {
+			__u64	sid		: 16,
+				sq		: 2,
+				svt		: 2,
+				__reserved_4	: 12,
+				pda_h		: 32;
+		};
+		__u64 high;
+	};
+};
+
+#define PDA_LOW_BIT    26
+#define PDA_HIGH_BIT   32
+
 enum {
 	IRQ_REMAP_XAPIC_MODE,
 	IRQ_REMAP_X2APIC_MODE,
-- 
2.1.0
