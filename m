From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/vt-d: replace *hdr with hdr[0] in struct
	dmar_drhd_unit
Date: Sun, 20 Mar 2016 13:59:37 +0000
Message-ID: <20160320135937.GA7827@vultr.guest>
References: <1457819859-28668-1-git-send-email-richard.weiyang@gmail.com>
Reply-To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1457819859-28668-1-git-send-email-richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Obsolete this one. V2 is sent.

On Sat, Mar 12, 2016 at 09:57:38PM +0000, Wei Yang wrote:
>hdr in struct dmar_drhd_unit is used to point the DMAR hardware unit copied
>at the end of struct dmar_drhd_unit. One zero-sized array may be more
>elegant for this purpose.
>
>This patch replace *hdr with hdr[0] in struct dmar_drhd_unit.
>
>Besides this, this patch includes other two changes:
>1. remove unnecessary type cast in dmar_table_detect()
>2. type cast from acpi_dmar_header to acpi_dmar_hardware_unit directly
>
>Signed-off-by: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>---
> drivers/iommu/dmar.c | 15 ++++-----------
> include/linux/dmar.h |  2 +-
> 2 files changed, 5 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
>index 80e3c17..d6dd23f 100644
>--- a/drivers/iommu/dmar.c
>+++ b/drivers/iommu/dmar.c
>@@ -292,8 +292,7 @@ static int dmar_pci_bus_add_dev(struct dmar_pci_notify_info *info)
> 		if (dmaru->include_all)
> 			continue;
> 
>-		drhd = container_of(dmaru->hdr,
>-				    struct acpi_dmar_hardware_unit, header);
>+		drhd = (struct acpi_dmar_hardware_unit *)dmaru->hdr;
> 		ret = dmar_insert_dev_scope(info, (void *)(drhd + 1),
> 				((void *)drhd) + drhd->header.length,
> 				dmaru->segment,
>@@ -390,7 +389,6 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
> 	 * If header is allocated from slab by ACPI _DSM method, we need to
> 	 * copy the content because the memory buffer will be freed on return.
> 	 */
>-	dmaru->hdr = (void *)(dmaru + 1);
> 	memcpy(dmaru->hdr, header, header->length);
> 	dmaru->reg_base_addr = drhd->address;
> 	dmaru->segment = drhd->segment;
>@@ -529,8 +527,7 @@ static int __init dmar_table_detect(void)
> 
> 	/* if we could find DMAR table, then there are DMAR devices */
> 	status = acpi_get_table_with_size(ACPI_SIG_DMAR, 0,
>-				(struct acpi_table_header **)&dmar_tbl,
>-				&dmar_tbl_size);
>+				&dmar_tbl, &dmar_tbl_size);
> 
> 	if (ACPI_SUCCESS(status) && !dmar_tbl) {
> 		pr_warn("Unable to map DMAR\n");
>@@ -663,9 +660,7 @@ dmar_find_matched_drhd_unit(struct pci_dev *dev)
> 
> 	rcu_read_lock();
> 	for_each_drhd_unit(dmaru) {
>-		drhd = container_of(dmaru->hdr,
>-				    struct acpi_dmar_hardware_unit,
>-				    header);
>+		drhd = (struct acpi_dmar_hardware_unit *)dmaru->hdr;
> 
> 		if (dmaru->include_all &&
> 		    drhd->segment == pci_domain_nr(dev->bus))
>@@ -693,9 +688,7 @@ static void __init dmar_acpi_insert_dev_scope(u8 device_number,
> 	struct acpi_dmar_pci_path *path;
> 
> 	for_each_drhd_unit(dmaru) {
>-		drhd = container_of(dmaru->hdr,
>-				    struct acpi_dmar_hardware_unit,
>-				    header);
>+		drhd = (struct acpi_dmar_hardware_unit *)dmaru->hdr;
> 
> 		for (scope = (void *)(drhd + 1);
> 		     (unsigned long)scope < ((unsigned long)drhd) + drhd->header.length;
>diff --git a/include/linux/dmar.h b/include/linux/dmar.h
>index e9bc929..5f6da7e 100644
>--- a/include/linux/dmar.h
>+++ b/include/linux/dmar.h
>@@ -52,7 +52,6 @@ struct dmar_dev_scope {
> extern struct acpi_table_header *dmar_tbl;
> struct dmar_drhd_unit {
> 	struct list_head list;		/* list of drhd units	*/
>-	struct  acpi_dmar_header *hdr;	/* ACPI header		*/
> 	u64	reg_base_addr;		/* register base address*/
> 	struct	dmar_dev_scope *devices;/* target device array	*/
> 	int	devices_cnt;		/* target device count	*/
>@@ -60,6 +59,7 @@ struct dmar_drhd_unit {
> 	u8	ignored:1; 		/* ignore drhd		*/
> 	u8	include_all:1;
> 	struct intel_iommu *iommu;
>+	struct  acpi_dmar_header hdr[0];/* ACPI header		*/
> };
> 
> struct dmar_pci_path {
>-- 
>2.5.0

-- 
Wei Yang
Help you, Help me
