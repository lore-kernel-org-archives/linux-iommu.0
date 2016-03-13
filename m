From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 1/2] iommu/io-pgtable: Add MTK 4GB mode in Short-descriptor
Date: Mon, 14 Mar 2016 06:01:10 +0800
Message-ID: <1457906471-31549-2-git-send-email-yong.wu@mediatek.com>
References: <1457906471-31549-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1457906471-31549-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, milton.chiang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

In MT8173, Normally the first 1GB PA is for the HW SRAM and Regs,
so the PA will be 33bits if the dram size is 4GB. We have a
"DRAM 4GB mode" toggle bit for this. If it's enabled, from CPU's
point of view, the dram PA will be from 0x1_00000000~0x1_ffffffff.

In short descriptor, the pagetable descriptor is always 32bit.
Mediatek extend bit9 in the lvl1 and lvl2 pgtable descriptor
as the 4GB mode.

In the 4GB mode, the bit9 must be set, then M4U help add 0x1_00000000
based on the PA in pagetable. Thus the M4U output address to EMI is
always 33bits(the input address is still 32bits).

We add a special quirk for this MTK-4GB mode. And in the standard
spec, Bit9 in the lvl1 is "IMPLEMENTATION DEFINED", while it's AP[2]
in the lvl2, therefore if this quirk is enabled, NO_PERMS is also
expected.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 13 ++++++++++++-
 drivers/iommu/io-pgtable.h         |  6 ++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 9fcceb1..32b371b 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -121,6 +121,8 @@
 #define ARM_V7S_TEX_MASK		0x7
 #define ARM_V7S_ATTR_TEX(val)		(((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
 
+#define ARM_V7S_ATTR_MTK_4GB		BIT(9) /* MTK extend it for 4GB mode */
+
 /* *well, except for TEX on level 2 large pages, of course :( */
 #define ARM_V7S_CONT_PAGE_TEX_SHIFT	6
 #define ARM_V7S_CONT_PAGE_TEX_MASK	(ARM_V7S_TEX_MASK << ARM_V7S_CONT_PAGE_TEX_SHIFT)
@@ -364,6 +366,9 @@ static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
 	if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
 		pte |= ARM_V7S_ATTR_NS_SECTION;
 
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)
+		pte |= ARM_V7S_ATTR_MTK_4GB;
+
 	if (num_entries > 1)
 		pte = arm_v7s_pte_to_cont(pte, lvl);
 
@@ -625,9 +630,15 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
 			    IO_PGTABLE_QUIRK_NO_PERMS |
-			    IO_PGTABLE_QUIRK_TLBI_ON_MAP))
+			    IO_PGTABLE_QUIRK_TLBI_ON_MAP |
+			    IO_PGTABLE_QUIRK_ARM_MTK_4GB))
 		return NULL;
 
+	/* If ARM_MTK_4GB is enabled, the NO_PERMS is also expected. */
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB &&
+	    !(cfg->quirks & IO_PGTABLE_QUIRK_NO_PERMS))
+			return NULL;
+
 	data = kmalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return NULL;
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index d4f5027..969d82c 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -60,10 +60,16 @@ struct io_pgtable_cfg {
 	 * IO_PGTABLE_QUIRK_TLBI_ON_MAP: If the format forbids caching invalid
 	 *	(unmapped) entries but the hardware might do so anyway, perform
 	 *	TLB maintenance when mapping as well as when unmapping.
+	 *
+	 * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) Set bit 9 in all
+	 *	PTEs, for Mediatek IOMMUs which treat it as a 33rd address bit
+	 *	when the SoC is in "4GB mode" and they can only access the high
+	 *	remap of DRAM (0x1_00000000 to 0x1_ffffffff).
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
 	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2)
+	#define IO_PGTABLE_QUIRK_ARM_MTK_4GB	BIT(3)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
-- 
1.8.1.1.dirty
