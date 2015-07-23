From: =?UTF-8?q?Salva=20Peir=C3=B3?= <speirofr@gmail.com>
Subject: [PATCH] iommu/omap: Fix debug_read_tlb() to use seq_printf()
Date: Thu, 23 Jul 2015 14:26:19 +0200
Message-ID: <1437654379-13356-1-git-send-email-speirofr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: =?UTF-8?q?Salva=20Peir=C3=B3?= <speirofr@gmail.com>, linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

The debug_read_tlb() uses the sprintf() functions directly on the buffe=
r
allocated by buf =3D kmalloc(count), without taking into account the si=
ze
of the buffer, with the consequence corrupting the heap, depending on
the count requested by the user.

The patch fixes the issue replacing sprintf() by seq_printf().

Signed-off-by: Salva Peir=C3=B3 <speirofr@gmail.com>
---
 drivers/iommu/omap-iommu-debug.c | 26 +++++++-------------------
 drivers/iommu/omap-iommu.c       | 28 +++++++++++-----------------
 drivers/iommu/omap-iommu.h       |  3 +--
 3 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iomm=
u-debug.c
index f3d20a2..5dcb85e 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -55,34 +55,22 @@ static ssize_t debug_read_regs(struct file *file, c=
har __user *userbuf,
 	return bytes;
 }
=20
-static ssize_t debug_read_tlb(struct file *file, char __user *userbuf,
-			      size_t count, loff_t *ppos)
+static int debug_read_tlb(struct seq_file *s, void *data)
 {
-	struct omap_iommu *obj =3D file->private_data;
-	char *p, *buf;
-	ssize_t bytes, rest;
+	struct omap_iommu *obj =3D s->private;
=20
 	if (is_omap_iommu_detached(obj))
 		return -EPERM;
=20
-	buf =3D kmalloc(count, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-	p =3D buf;
-
 	mutex_lock(&iommu_debug_lock);
=20
-	p +=3D sprintf(p, "%8s %8s\n", "cam:", "ram:");
-	p +=3D sprintf(p, "-----------------------------------------\n");
-	rest =3D count - (p - buf);
-	p +=3D omap_dump_tlb_entries(obj, p, rest);
-
-	bytes =3D simple_read_from_buffer(userbuf, count, ppos, buf, p - buf)=
;
+	seq_printf(s, "%8s %8s\n", "cam:", "ram:");
+	seq_puts(s, "-----------------------------------------\n");
+	omap_dump_tlb_entries(obj, s);
=20
 	mutex_unlock(&iommu_debug_lock);
-	kfree(buf);
=20
-	return bytes;
+	return 0;
 }
=20
 static void dump_ioptable(struct seq_file *s)
@@ -157,7 +145,7 @@ static int debug_read_pagetable(struct seq_file *s,=
 void *data)
 	};
=20
 DEBUG_FOPS_RO(regs);
-DEBUG_FOPS_RO(tlb);
+DEBUG_SEQ_FOPS_RO(tlb);
 DEBUG_SEQ_FOPS_RO(pagetable);
=20
 #define __DEBUG_ADD_FILE(attr, mode)					\
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index a22c33d..2247075e2 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -546,36 +546,30 @@ __dump_tlb_entries(struct omap_iommu *obj, struct=
 cr_regs *crs, int num)
 }
=20
 /**
- * iotlb_dump_cr - Dump an iommu tlb entry into buf
+ * iotlb_dump_cr - Dump an iommu tlb entry into seq_file
  * @obj:	target iommu
  * @cr:		contents of cam and ram register
- * @buf:	output buffer
+ * @s:	    output seq_file
  **/
 static ssize_t iotlb_dump_cr(struct omap_iommu *obj, struct cr_regs *c=
r,
-			     char *buf)
+		struct seq_file *s)
 {
-	char *p =3D buf;
-
 	/* FIXME: Need more detail analysis of cam/ram */
-	p +=3D sprintf(p, "%08x %08x %01x\n", cr->cam, cr->ram,
-					(cr->cam & MMU_CAM_P) ? 1 : 0);
-
-	return p - buf;
+	return seq_printf(s, "%08x %08x %01x\n", cr->cam, cr->ram,
+			(cr->cam & MMU_CAM_P) ? 1 : 0);
 }
=20
 /**
- * omap_dump_tlb_entries - dump cr arrays to given buffer
+ * omap_dump_tlb_entries - dump cr arrays to given seq_file
  * @obj:	target iommu
- * @buf:	output buffer
+ * @s:	    output seq_file
  **/
-size_t omap_dump_tlb_entries(struct omap_iommu *obj, char *buf, ssize_=
t bytes)
+size_t omap_dump_tlb_entries(struct omap_iommu *obj, struct seq_file *=
s)
 {
 	int i, num;
 	struct cr_regs *cr;
-	char *p =3D buf;
=20
-	num =3D bytes / sizeof(*cr);
-	num =3D min(obj->nr_tlb_entries, num);
+	num =3D obj->nr_tlb_entries;
=20
 	cr =3D kcalloc(num, sizeof(*cr), GFP_KERNEL);
 	if (!cr)
@@ -583,10 +577,10 @@ size_t omap_dump_tlb_entries(struct omap_iommu *o=
bj, char *buf, ssize_t bytes)
=20
 	num =3D __dump_tlb_entries(obj, cr, num);
 	for (i =3D 0; i < num; i++)
-		p +=3D iotlb_dump_cr(obj, cr + i, p);
+		iotlb_dump_cr(obj, cr + i, s);
 	kfree(cr);
=20
-	return p - buf;
+	return 0;
 }
=20
 #endif /* CONFIG_OMAP_IOMMU_DEBUG */
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index d736630..5df9755 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -193,8 +193,7 @@ static inline struct omap_iommu *dev_to_omap_iommu(=
struct device *dev)
 #ifdef CONFIG_OMAP_IOMMU_DEBUG
 extern ssize_t
 omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t len);
-extern size_t
-omap_dump_tlb_entries(struct omap_iommu *obj, char *buf, ssize_t len);
+extern size_t omap_dump_tlb_entries(struct omap_iommu *obj, struct seq=
_file *s);
=20
 void omap_iommu_debugfs_init(void);
 void omap_iommu_debugfs_exit(void);
--=20
2.1.4
