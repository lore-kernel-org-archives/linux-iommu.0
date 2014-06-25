From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 V3 15/21] iommu/vt-d: dynamically allocate and free
	seq_id for DMAR units
Date: Wed, 25 Jun 2014 17:02:41 +0800
Message-ID: <1403686967-10887-16-git-send-email-jiang.liu@linux.intel.com>
References: <1403686967-10887-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1403686967-10887-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Introduce functions to support dynamic IOMMU seq_id allocating and
releasing, which will be used to support DMAR hotplug.

Also rename IOMMU_UNITS_SUPPORTED as DMAR_UNITS_SUPPORTED.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/dmar.c        |   40 ++++++++++++++++++++++++++++++++++------
 drivers/iommu/intel-iommu.c |   13 +++----------
 include/linux/dmar.h        |    6 ++++++
 3 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 8e3ae29b7008..4aba78731ed8 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -69,6 +69,7 @@ LIST_HEAD(dmar_drhd_units);
 struct acpi_table_header * __initdata dmar_tbl;
 static acpi_size dmar_tbl_size;
 static int dmar_dev_scope_status = 1;
+static unsigned long dmar_seq_ids[BITS_TO_LONGS(DMAR_UNITS_SUPPORTED)];
 
 static int alloc_iommu(struct dmar_drhd_unit *drhd);
 static void free_iommu(struct intel_iommu *iommu);
@@ -928,11 +929,32 @@ out:
 	return err;
 }
 
+static int dmar_alloc_seq_id(struct intel_iommu *iommu)
+{
+	iommu->seq_id = find_first_zero_bit(dmar_seq_ids,
+					    DMAR_UNITS_SUPPORTED);
+	if (iommu->seq_id >= DMAR_UNITS_SUPPORTED) {
+		iommu->seq_id = -1;
+	} else {
+		set_bit(iommu->seq_id, dmar_seq_ids);
+		sprintf(iommu->name, "dmar%d", iommu->seq_id);
+	}
+
+	return iommu->seq_id;
+}
+
+static void dmar_free_seq_id(struct intel_iommu *iommu)
+{
+	if (iommu->seq_id >= 0) {
+		clear_bit(iommu->seq_id, dmar_seq_ids);
+		iommu->seq_id = -1;
+	}
+}
+
 static int alloc_iommu(struct dmar_drhd_unit *drhd)
 {
 	struct intel_iommu *iommu;
 	u32 ver, sts;
-	static int iommu_allocated = 0;
 	int agaw = 0;
 	int msagaw = 0;
 	int err;
@@ -946,13 +968,16 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	if (!iommu)
 		return -ENOMEM;
 
-	iommu->seq_id = iommu_allocated++;
-	sprintf (iommu->name, "dmar%d", iommu->seq_id);
+	if (dmar_alloc_seq_id(iommu) < 0) {
+		pr_err("IOMMU: failed to allocate seq_id\n");
+		err = -ENOSPC;
+		goto error;
+	}
 
 	err = map_iommu(iommu, drhd->reg_base_addr);
 	if (err) {
 		pr_err("IOMMU: failed to map %s\n", iommu->name);
-		goto error;
+		goto error_free_seq_id;
 	}
 
 	err = -EINVAL;
@@ -996,9 +1021,11 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	drhd->iommu = iommu;
 	return 0;
 
- err_unmap:
+err_unmap:
 	unmap_iommu(iommu);
- error:
+error_free_seq_id:
+	dmar_free_seq_id(iommu);
+error:
 	kfree(iommu);
 	return err;
 }
@@ -1020,6 +1047,7 @@ static void free_iommu(struct intel_iommu *iommu)
 	if (iommu->reg)
 		unmap_iommu(iommu);
 
+	dmar_free_seq_id(iommu);
 	kfree(iommu);
 }
 
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 531049f70d96..d19c51138646 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -329,17 +329,10 @@ static int hw_pass_through = 1;
 /* si_domain contains mulitple devices */
 #define DOMAIN_FLAG_STATIC_IDENTITY	(1 << 1)
 
-/* define the limit of IOMMUs supported in each domain */
-#ifdef	CONFIG_X86
-# define	IOMMU_UNITS_SUPPORTED	MAX_IO_APICS
-#else
-# define	IOMMU_UNITS_SUPPORTED	64
-#endif
-
 struct dmar_domain {
 	int	id;			/* domain id */
 	int	nid;			/* node id */
-	DECLARE_BITMAP(iommu_bmp, IOMMU_UNITS_SUPPORTED);
+	DECLARE_BITMAP(iommu_bmp, DMAR_UNITS_SUPPORTED);
 					/* bitmap of iommus this domain uses*/
 
 	struct list_head devices; 	/* all devices' list */
@@ -2720,12 +2713,12 @@ static int __init init_dmars(void)
 		 * threaded kernel __init code path all other access are read
 		 * only
 		 */
-		if (g_num_of_iommus < IOMMU_UNITS_SUPPORTED) {
+		if (g_num_of_iommus < DMAR_UNITS_SUPPORTED) {
 			g_num_of_iommus++;
 			continue;
 		}
 		printk_once(KERN_ERR "intel-iommu: exceeded %d IOMMUs\n",
-			  IOMMU_UNITS_SUPPORTED);
+			  DMAR_UNITS_SUPPORTED);
 	}
 
 	g_iommus = kcalloc(g_num_of_iommus, sizeof(struct intel_iommu *),
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index fac8ca34f9a8..c8a576bc3a98 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -30,6 +30,12 @@
 
 struct acpi_dmar_header;
 
+#ifdef	CONFIG_X86
+# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
+#else
+# define	DMAR_UNITS_SUPPORTED	64
+#endif
+
 /* DMAR Flags */
 #define DMAR_INTR_REMAP		0x1
 #define DMAR_X2APIC_OPT_OUT	0x2
-- 
1.7.10.4
