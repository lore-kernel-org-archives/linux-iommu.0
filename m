From: Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH v2] iommu/amd: Reserve exclusion range in iova-domain
Date: Tue, 2 Apr 2019 13:20:14 -0700
Message-ID: <20190402202014.bzjw6eidksg6vymj@cantor>
References: <20190329151037.19112-1-joro@8bytes.org>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190329151037.19112-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Gary R Hook <ghook@amd.com>, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

On Fri Mar 29 19, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>If a device has an exclusion range specified in the IVRS
>table, this region needs to be reserved in the iova-domain
>of that device. This hasn't happened until now and can cause
>data corruption on data transfered with these devices.
>
>Treat exclusion ranges as reserved regions in the iommu-core
>to fix the problem.
>
>Fixes: be2a022c0dd0 ('x86, AMD IOMMU: add functions to parse IOMMU memory mapping requirements for devices')
>Signed-off-by: Joerg Roedel <jroedel@suse.de>

I have a version of this that applies to 4.4 and 4,9 using the older
dm_region code if that would be useful for stable.


--8<--

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 0ad8b7c78a43..f388458624cf 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3165,11 +3165,14 @@ static void amd_iommu_get_dm_regions(struct device *dev,
 		}
 
 		region->start = entry->address_start;
+		region->type = IOMMU_RESV_DIRECT;
 		region->length = entry->address_end - entry->address_start;
 		if (entry->prot & IOMMU_PROT_IR)
 			region->prot |= IOMMU_READ;
 		if (entry->prot & IOMMU_PROT_IW)
 			region->prot |= IOMMU_WRITE;
+		if (entry->prot & IOMMU_UNITY_MAP_FLAG_EXCL_RANGE)
+			region->type = IOMMU_RESV_RESERVED;
 
 		list_add_tail(&region->list, head);
 	}
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 94f1bf772ec9..d84041bc77ac 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1495,6 +1495,9 @@ static int __init init_unity_map_range(struct ivmd_header *m)
 	if (e == NULL)
 		return -ENOMEM;
 
+	if (m->flags & IVMD_FLAG_EXCL_RANGE)
+		init_exclusion_range(m);
+
 	switch (m->type) {
 	default:
 		kfree(e);
@@ -1541,9 +1544,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 
 	while (p < end) {
 		m = (struct ivmd_header *)p;
-		if (m->flags & IVMD_FLAG_EXCL_RANGE)
-			init_exclusion_range(m);
-		else if (m->flags & IVMD_FLAG_UNITY_MAP)
+		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
 			init_unity_map_range(m);
 
 		p += m->length;
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index b08cf57bf455..31d27eb70565 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -324,6 +324,8 @@
 #define IOMMU_PROT_IR 0x01
 #define IOMMU_PROT_IW 0x02
 
+#define IOMMU_UNITY_MAP_FLAG_EXCL_RANGE        (1 << 2)
+
 /* IOMMU capabilities */
 #define IOMMU_CAP_IOTLB   24
 #define IOMMU_CAP_NPCACHE 26
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a070fa39521a..ef4aa2879952 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -351,6 +351,9 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 		start = ALIGN(entry->start, pg_size);
 		end   = ALIGN(entry->start + entry->length, pg_size);
 
+		if (entry->type != IOMMU_RESV_DIRECT)
+			continue;
+
 		for (addr = start; addr < end; addr += pg_size) {
 			phys_addr_t phys_addr;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f28dff313b07..15b7378f67f3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -115,18 +115,23 @@ enum iommu_attr {
 	DOMAIN_ATTR_MAX,
 };
 
+#define IOMMU_RESV_DIRECT	(1 << 0)
+#define IOMMU_RESV_RESERVED	(1 << 1)
+
 /**
  * struct iommu_dm_region - descriptor for a direct mapped memory region
  * @list: Linked list pointers
  * @start: System physical start address of the region
  * @length: Length of the region in bytes
  * @prot: IOMMU Protection flags (READ/WRITE/...)
+ * @type: Type of region (DIRECT, RESERVED)
  */
 struct iommu_dm_region {
 	struct list_head	list;
 	phys_addr_t		start;
 	size_t			length;
 	int			prot;
+	int			type;
 };
 
 #ifdef CONFIG_IOMMU_API
-- 
2.21.0
