From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 07/10] iommu/amd: factor out setting the remap table for a devid
Date: Thu, 22 Mar 2018 16:22:39 +0100
Message-ID: <20180322152242.12705-8-bigeasy@linutronix.de>
References: <20180322152242.12705-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322152242.12705-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, Scott Wood <swood@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: iommu@lists.linux-foundation.org

Setting the IRQ remap table for a specific devid (or its alias devid)
includes three steps. Those three steps are always repeated each time
this is done.
Introduce a new helper function, move those steps there and use that
function instead. The compiler can still decide if it is worth to
inline.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/amd_iommu.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index ea120c7b46c9..11ea2d656be8 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3617,6 +3617,14 @@ static struct irq_remap_table *get_irq_table(u16 dev=
id)
 	return table;
 }
=20
+static void set_remap_table_entry(struct amd_iommu *iommu, u16 devid,
+				  struct irq_remap_table *table)
+{
+	irq_lookup_table[devid] =3D table;
+	set_dte_irq_entry(devid, table);
+	iommu_flush_dte(iommu, devid);
+}
+
 static struct irq_remap_table *alloc_irq_table(u16 devid)
 {
 	struct irq_remap_table *table =3D NULL;
@@ -3637,9 +3645,7 @@ static struct irq_remap_table *alloc_irq_table(u16 de=
vid)
 	alias =3D amd_iommu_alias_table[devid];
 	table =3D irq_lookup_table[alias];
 	if (table) {
-		irq_lookup_table[devid] =3D table;
-		set_dte_irq_entry(devid, table);
-		iommu_flush_dte(iommu, devid);
+		set_remap_table_entry(iommu, devid, table);
 		goto out;
 	}
=20
@@ -3666,14 +3672,9 @@ static struct irq_remap_table *alloc_irq_table(u16 d=
evid)
 		       (MAX_IRQS_PER_TABLE * (sizeof(u64) * 2)));
=20
=20
-	irq_lookup_table[devid] =3D table;
-	set_dte_irq_entry(devid, table);
-	iommu_flush_dte(iommu, devid);
-	if (devid !=3D alias) {
-		irq_lookup_table[alias] =3D table;
-		set_dte_irq_entry(alias, table);
-		iommu_flush_dte(iommu, alias);
-	}
+	set_remap_table_entry(iommu, devid, table);
+	if (devid !=3D alias)
+		set_remap_table_entry(iommu, alias, table);
=20
 out:
 	iommu_completion_wait(iommu);
--=20
2.16.2
