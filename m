Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3D2139C6
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425276; cv=none; b=CWlw7IPdjYGQP0ZbgxRTTur3UWfR2zvYBlnnDhazlf6trXpYSOPRTzj8PXaS36xPTbcAzeBkV9pFdE3JRpbdVcGXCIgTvs7vm12mdU6sbzU4SAt6ITZI4ubepnSKkgolfYSoIEyYDK29ZbIr7eOaXRK7L0cLw+kki2wya3pQHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425276; c=relaxed/simple;
	bh=BDBmDyccHRflUGd3TTsGguZUgycuTkMDFd08JVxGEV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F++eqWr99sFZzPIXdgvUlDFIzP9Igdwnkj7hxSbUy7ZOTjfrvnk5qtRcKp0aXiHYCyVsqXnE42VTpAsJ6lampnsCHY6/yb+zYuz/JZ9xmjRh5BOlEg928NkssN0V8zGgCpT/unWV04oTAt3ZWh6ACP7IjsrEvrJUb6TksIgEHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P8N6zYf1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P8N6zYf1"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498FCTSR029341;
	Tue, 8 Oct 2024 22:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lWNtWICrAzQQluJn+83vGqSrGRA+mMtPEtMA1eX+KKc=; b=P8N6zYf1XNy8BZfp
	UjN/PskeZpqJhVVekY3cB3qoxDSAA7ipFiSPr6JAMHwgeNOSr85UDKIKr8sE83z+
	Kn7cqAMm32OcN4ScGXOjf4QLnj6L1LaFCNOmRQ+GNfeH4XW3Q+/LHzFInqvxI8a7
	xn8LhubEvEGbWHXRm67xADXNiqBAlODq/tiplWDlXXUq65BCMbgsY/PmIre4D7eB
	V5uvcepCD2RDiA6mCy9hTpIGfZ948tUJsgAbECd/am4zhanH6vhtm3+GNrrLjgmu
	FBmSSZtjZerGzkFl1nzmnvNBoET6KF9e16AuGN7KYLLqTvt5BLzlgMQzjHSAbdls
	6od2xg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424yj02jmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 22:07:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 498M7gMI025189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 22:07:42 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 8 Oct 2024 15:07:40 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <robh@kernel.org>
CC: <aisheng.dong@nxp.com>, <andy@black.fi.intel.com>,
        <catalin.marinas@arm.com>, <devicetree@vger.kernel.org>, <hch@lst.de>,
        <iommu@lists.linux.dev>, <kernel@quicinc.com>, <klarasmodin@gmail.com>,
        <linux-kernel@vger.kernel.org>, <m.szyprowski@samsung.com>,
        <quic_ninanaik@quicinc.com>, <robin.murphy@arm.com>,
        <saravanak@google.com>, <will@kernel.org>,
        Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [PATCH v10 1/2] of: reserved_mem: Restruture how the reserved memory regions are processed
Date: Tue, 8 Oct 2024 15:06:23 -0700
Message-ID: <20241008220624.551309-2-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008220624.551309-1-quic_obabatun@quicinc.com>
References: <20241008220624.551309-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q0RFZWyQX90GgQwTp0DRIDGNhUz5J474
X-Proofpoint-ORIG-GUID: Q0RFZWyQX90GgQwTp0DRIDGNhUz5J474
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080141

Reserved memory regions defined in the devicetree can be broken up into
two groups:
i) Statically-placed reserved memory regions
i.e. regions defined with a static start address and size using the
     "reg" property.
ii) Dynamically-placed reserved memory regions.
i.e. regions defined by specifying an address range where they can be
     placed in memory using the "alloc_ranges" and "size" properties.

These regions are processed and set aside at boot time.
This is done in two stages as seen below:

Stage 1:
At this stage, fdt_scan_reserved_mem() scans through the child nodes of
the reserved_memory node using the flattened devicetree and does the
following:

1) If the node represents a statically-placed reserved memory region,
   i.e. if it is defined using the "reg" property:
   - Call memblock_reserve() or memblock_mark_nomap() as needed.
   - Add the information for that region into the reserved_mem array
     using fdt_reserved_mem_save_node().
     i.e. fdt_reserved_mem_save_node(node, name, base, size).

2) If the node represents a dynamically-placed reserved memory region,
   i.e. if it is defined using "alloc-ranges" and "size" properties:
   - Add the information for that region to the reserved_mem array with
     the starting address and size set to 0.
     i.e. fdt_reserved_mem_save_node(node, name, 0, 0).
   Note: This region is saved to the array with a starting address of 0
   because a starting address is not yet allocated for it.

Stage 2:
After iterating through all the reserved memory nodes and storing their
relevant information in the reserved_mem array,fdt_init_reserved_mem() is
called and does the following:

1) For statically-placed reserved memory regions:
   - Call the region specific init function using
     __reserved_mem_init_node().
2) For dynamically-placed reserved memory regions:
   - Call __reserved_mem_alloc_size() which is used to allocate memory
     for each of these regions, and mark them as nomap if they have the
     nomap property specified in the DT.
   - Call the region specific init function.

The current size of the resvered_mem array is 64 as is defined by
MAX_RESERVED_REGIONS. This means that there is a limitation of 64 for
how many reserved memory regions can be specified on a system.
As systems continue to grow more and more complex, the number of
reserved memory regions needed are also growing and are starting to hit
this 64 count limit, hence the need to make the reserved_mem array
dynamically sized (i.e. dynamically allocating memory for the
reserved_mem array using membock_alloc_*).

On architectures such as arm64, memory allocated using memblock is
writable only after the page tables have been setup. This means that if
the reserved_mem array is going to be dynamically allocated, it needs to
happen after the page tables have been setup, not before.

Since the reserved memory regions are currently being processed and
added to the array before the page tables are setup, there is a need to
change the order in which some of the processing is done to allow for
the reserved_mem array to be dynamically sized.

It is possible to process the statically-placed reserved memory regions
without needing to store them in the reserved_mem array until after the
page tables have been setup because all the information stored in the
array is readily available in the devicetree and can be referenced at
any time.
Dynamically-placed reserved memory regions on the other hand get
assigned a start address only at runtime, and hence need a place to be
stored once they are allocated since there is no other referrence to the
start address for these regions.

Hence this patch changes the processing order of the reserved memory
regions in the following ways:

Step 1:
fdt_scan_reserved_mem() scans through the child nodes of
the reserved_memory node using the flattened devicetree and does the
following:

1) If the node represents a statically-placed reserved memory region,
   i.e. if it is defined using the "reg" property:
   - Call memblock_reserve() or memblock_mark_nomap() as needed.

2) If the node represents a dynamically-placed reserved memory region,
   i.e. if it is defined using "alloc-ranges" and "size" properties:
   - Call __reserved_mem_alloc_size() which will:
     i) Allocate memory for the reserved region and call
     memblock_mark_nomap() as needed.
     ii) Call the region specific initialization function using
     fdt_init_reserved_mem_node().
     iii) Save the region information in the reserved_mem array using
     fdt_reserved_mem_save_node().

Step 2:
1) This stage of the reserved memory processing is now only used to add
   the statically-placed reserved memory regions into the reserved_mem
   array using fdt_scan_reserved_mem_reg_nodes(), as well as call their
   region specific initialization functions.

2) This step has also been moved to be after the page tables are
   setup. Moving this will allow us to replace the reserved_mem
   array with a dynamically sized array before storing the rest of
   these regions.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c             |   5 +-
 drivers/of/of_private.h      |   3 +-
 drivers/of/of_reserved_mem.c | 168 ++++++++++++++++++++++++-----------
 3 files changed, 122 insertions(+), 54 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4d528c10df3a..d0dbc8183ac4 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -511,8 +511,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
 			break;
 		memblock_reserve(base, size);
 	}
-
-	fdt_init_reserved_mem();
 }
 
 /**
@@ -1212,6 +1210,9 @@ void __init unflatten_device_tree(void)
 {
 	void *fdt = initial_boot_params;
 
+	/* Save the statically-placed regions in the reserved_mem array */
+	fdt_scan_reserved_mem_reg_nodes();
+
 	/* Don't use the bootloader provided DTB if ACPI is enabled */
 	if (!acpi_disabled)
 		fdt = NULL;
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 04aa2a91f851..29525c0b9939 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -9,6 +9,7 @@
  */
 
 #define FDT_ALIGN_SIZE 8
+#define MAX_RESERVED_REGIONS    64
 
 /**
  * struct alias_prop - Alias property in 'aliases' node
@@ -180,7 +181,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 #endif
 
 int fdt_scan_reserved_mem(void);
-void fdt_init_reserved_mem(void);
+void __init fdt_scan_reserved_mem_reg_nodes(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 46e1c3fbc769..2011174211f9 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -27,7 +27,6 @@
 
 #include "of_private.h"
 
-#define MAX_RESERVED_REGIONS	64
 static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
 static int reserved_mem_count;
 
@@ -56,6 +55,7 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	return err;
 }
 
+static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem);
 /*
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
@@ -74,6 +74,9 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
 	rmem->base = base;
 	rmem->size = size;
 
+	/* Call the region specific initialization function */
+	fdt_init_reserved_mem_node(rmem);
+
 	reserved_mem_count++;
 	return;
 }
@@ -106,7 +109,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	phys_addr_t base, size;
 	int len;
 	const __be32 *prop;
-	int first = 1;
 	bool nomap;
 
 	prop = of_get_flat_dt_prop(node, "reg", &len);
@@ -134,10 +136,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 			       uname, &base, (unsigned long)(size / SZ_1M));
 
 		len -= t_len;
-		if (first) {
-			fdt_reserved_mem_save_node(node, uname, base, size);
-			first = 0;
-		}
 	}
 	return 0;
 }
@@ -165,12 +163,77 @@ static int __init __reserved_mem_check_root(unsigned long node)
 	return 0;
 }
 
+static void __init __rmem_check_for_overlap(void);
+
+/**
+ * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
+ * reserved memory regions.
+ *
+ * This function is used to scan through the DT and store the
+ * information for the reserved memory regions that are defined using
+ * the "reg" property. The region node number, name, base address, and
+ * size are all stored in the reserved_mem array by calling the
+ * fdt_reserved_mem_save_node() function.
+ */
+void __init fdt_scan_reserved_mem_reg_nodes(void)
+{
+	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+	const void *fdt = initial_boot_params;
+	phys_addr_t base, size;
+	const __be32 *prop;
+	int node, child;
+	int len;
+
+	if (!fdt)
+		return;
+
+	node = fdt_path_offset(fdt, "/reserved-memory");
+	if (node < 0) {
+		pr_info("Reserved memory: No reserved-memory node in the DT\n");
+		return;
+	}
+
+	if (__reserved_mem_check_root(node)) {
+		pr_err("Reserved memory: unsupported node format, ignoring\n");
+		return;
+	}
+
+	fdt_for_each_subnode(child, fdt, node) {
+		const char *uname;
+
+		prop = of_get_flat_dt_prop(child, "reg", &len);
+		if (!prop)
+			continue;
+		if (!of_fdt_device_is_available(fdt, child))
+			continue;
+
+		uname = fdt_get_name(fdt, child, NULL);
+		if (len && len % t_len != 0) {
+			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
+			       uname);
+			continue;
+		}
+		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
+		size = dt_mem_next_cell(dt_root_size_cells, &prop);
+
+		if (size)
+			fdt_reserved_mem_save_node(child, uname, base, size);
+	}
+
+	/* check for overlapping reserved regions */
+	__rmem_check_for_overlap();
+}
+
+static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname);
+
 /*
  * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
  */
 int __init fdt_scan_reserved_mem(void)
 {
 	int node, child;
+	int dynamic_nodes_cnt = 0;
+	int dynamic_nodes[MAX_RESERVED_REGIONS];
 	const void *fdt = initial_boot_params;
 
 	node = fdt_path_offset(fdt, "/reserved-memory");
@@ -192,8 +255,24 @@ int __init fdt_scan_reserved_mem(void)
 		uname = fdt_get_name(fdt, child, NULL);
 
 		err = __reserved_mem_reserve_reg(child, uname);
-		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
-			fdt_reserved_mem_save_node(child, uname, 0, 0);
+		/*
+		 * Save the nodes for the dynamically-placed regions
+		 * into an array which will be used for allocation right
+		 * after all the statically-placed regions are reserved
+		 * or marked as no-map. This is done to avoid dynamically
+		 * allocating from one of the statically-placed regions.
+		 */
+		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL)) {
+			dynamic_nodes[dynamic_nodes_cnt] = child;
+			dynamic_nodes_cnt++;
+		}
+	}
+	for (int i = 0; i < dynamic_nodes_cnt; i++) {
+		const char *uname;
+
+		child = dynamic_nodes[i];
+		uname = fdt_get_name(fdt, child, NULL);
+		__reserved_mem_alloc_size(child, uname);
 	}
 	return 0;
 }
@@ -253,8 +332,7 @@ static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
  * __reserved_mem_alloc_size() - allocate reserved memory described by
  *	'size', 'alignment'  and 'alloc-ranges' properties.
  */
-static int __init __reserved_mem_alloc_size(unsigned long node,
-	const char *uname, phys_addr_t *res_base, phys_addr_t *res_size)
+static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
 {
 	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
 	phys_addr_t start = 0, end = 0;
@@ -334,9 +412,8 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 		return -ENOMEM;
 	}
 
-	*res_base = base;
-	*res_size = size;
-
+	/* Save region in the reserved_mem array */
+	fdt_reserved_mem_save_node(node, uname, base, size);
 	return 0;
 }
 
@@ -425,48 +502,37 @@ static void __init __rmem_check_for_overlap(void)
 }
 
 /**
- * fdt_init_reserved_mem() - allocate and init all saved reserved memory regions
+ * fdt_init_reserved_mem_node() - Initialize a reserved memory region
+ * @rmem: reserved_mem struct of the memory region to be initialized.
+ *
+ * This function is used to call the region specific initialization
+ * function for a reserved memory region.
  */
-void __init fdt_init_reserved_mem(void)
+static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem)
 {
-	int i;
-
-	/* check for overlapping reserved regions */
-	__rmem_check_for_overlap();
-
-	for (i = 0; i < reserved_mem_count; i++) {
-		struct reserved_mem *rmem = &reserved_mem[i];
-		unsigned long node = rmem->fdt_node;
-		int err = 0;
-		bool nomap;
+	unsigned long node = rmem->fdt_node;
+	int err = 0;
+	bool nomap;
 
-		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
 
-		if (rmem->size == 0)
-			err = __reserved_mem_alloc_size(node, rmem->name,
-						 &rmem->base, &rmem->size);
-		if (err == 0) {
-			err = __reserved_mem_init_node(rmem);
-			if (err != 0 && err != -ENOENT) {
-				pr_info("node %s compatible matching fail\n",
-					rmem->name);
-				if (nomap)
-					memblock_clear_nomap(rmem->base, rmem->size);
-				else
-					memblock_phys_free(rmem->base,
-							   rmem->size);
-			} else {
-				phys_addr_t end = rmem->base + rmem->size - 1;
-				bool reusable =
-					(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
-
-				pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
-					&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
-					nomap ? "nomap" : "map",
-					reusable ? "reusable" : "non-reusable",
-					rmem->name ? rmem->name : "unknown");
-			}
-		}
+	err = __reserved_mem_init_node(rmem);
+	if (err != 0 && err != -ENOENT) {
+		pr_info("node %s compatible matching fail\n", rmem->name);
+		if (nomap)
+			memblock_clear_nomap(rmem->base, rmem->size);
+		else
+			memblock_phys_free(rmem->base, rmem->size);
+	} else {
+		phys_addr_t end = rmem->base + rmem->size - 1;
+		bool reusable =
+			(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
+
+		pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
+			&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
+			nomap ? "nomap" : "map",
+			reusable ? "reusable" : "non-reusable",
+			rmem->name ? rmem->name : "unknown");
 	}
 }
 
-- 
2.34.1

