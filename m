From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v6 2/8] iommu: dmar: Extend struct irte for VT-d Posted-Interrupts
Date: Thu, 21 May 2015 14:59:09 +0800
Message-ID: <1432191555-3516-3-git-send-email-feng.wu@intel.com>
References: <1432191555-3516-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432191555-3516-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

The IRTE (Interrupt Remapping Table Entry) is either an entry for
remapped or for posted interrupts. The hardware distiguishes between
remapped and posted entries by bit 15 in the low 64 bit of the
IRTE. If cleared the entry is remapped, if set it's posted.

The entries have common fields and dependent on the posted bit fields
with different meanings.

Extend struct irte to handle the differences between remap and posted
mode by having three structs in the unions:

	- Shared
	- Remapped
	- Posted

Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 include/linux/dmar.h | 70 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 8473756..0dbcabc 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -185,33 +185,73 @@ static inline int dmar_device_remove(void *handle)
 
 struct irte {
 	union {
+		/* Shared between remapped and posted mode*/
 		struct {
-			__u64	present 	: 1,
-				fpd		: 1,
-				dst_mode	: 1,
-				redir_hint	: 1,
-				trigger_mode	: 1,
-				dlvry_mode	: 3,
-				avail		: 4,
-				__reserved_1	: 4,
-				vector		: 8,
-				__reserved_2	: 8,
-				dest_id		: 32;
+			__u64	present		: 1,  /*  0      */
+				fpd		: 1,  /*  1      */
+				__res0		: 6,  /*  2 -  6 */
+				avail		: 4,  /*  8 - 11 */
+				__res1		: 3,  /* 12 - 14 */
+				pst		: 1,  /* 15      */
+				vector		: 8,  /* 16 - 23 */
+				__res2		: 40; /* 24 - 63 */
+		};
+
+		/* Remapped mode */
+		struct {
+			__u64	r_present	: 1,  /*  0      */
+				r_fpd		: 1,  /*  1      */
+				dst_mode	: 1,  /*  2      */
+				redir_hint	: 1,  /*  3      */
+				trigger_mode	: 1,  /*  4      */
+				dlvry_mode	: 3,  /*  5 -  7 */
+				r_avail		: 4,  /*  8 - 11 */
+				r_res0		: 4,  /* 12 - 15 */
+				r_vector	: 8,  /* 16 - 23 */
+				r_res1		: 8,  /* 24 - 31 */
+				dest_id		: 32; /* 32 - 63 */
+		};
+
+		/* Posted mode */
+		struct {
+			__u64	p_present	: 1,  /*  0      */
+				p_fpd		: 1,  /*  1      */
+				p_res0		: 6,  /*  2 -  7 */
+				p_avail		: 4,  /*  8 - 11 */
+				p_res1		: 2,  /* 12 - 13 */
+				p_urgent	: 1,  /* 14      */
+				p_pst		: 1,  /* 15      */
+				p_vector	: 8,  /* 16 - 23 */
+				p_res2		: 14, /* 24 - 37 */
+				pda_l		: 26; /* 38 - 63 */
 		};
 		__u64 low;
 	};
 
 	union {
+		/* Shared between remapped and posted mode*/
 		struct {
-			__u64	sid		: 16,
-				sq		: 2,
-				svt		: 2,
-				__reserved_3	: 44;
+			__u64	sid		: 16,  /* 64 - 79  */
+				sq		: 2,   /* 80 - 81  */
+				svt		: 2,   /* 82 - 83  */
+				__res3		: 44;  /* 84 - 127 */
+		};
+
+		/* Posted mode*/
+		struct {
+			__u64	p_sid		: 16,  /* 64 - 79  */
+				p_sq		: 2,   /* 80 - 81  */
+				p_svt		: 2,   /* 82 - 83  */
+				p_res3		: 12,  /* 84 - 95  */
+				pda_h		: 32;  /* 96 - 127 */
 		};
 		__u64 high;
 	};
 };
 
+#define PDA_LOW_BIT    26
+#define PDA_HIGH_BIT   32
+
 enum {
 	IRQ_REMAP_XAPIC_MODE,
 	IRQ_REMAP_X2APIC_MODE,
-- 
2.1.0
