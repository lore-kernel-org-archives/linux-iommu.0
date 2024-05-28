Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496613E028
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935838; cv=none; b=hnAKB7QNFQCv29RixGPii8ERPxjm5PjxkMD2q1JD+sPQnWrYskdmuTEAJm1XrDKq1yn+1RTVgtwu3MSg2+Wqlv5iAjsJo0dSMhi07YbETm3FTLth3OI0l6y8RUpo6Dqt17hafu2OAdsILvu9uRPjZ9M8r4rj2VW/1MHXeF5uGGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935838; c=relaxed/simple;
	bh=blDQ4VKJZsvCJgTAq1HdIoEH4fQqa82gOAkhFVfh+jE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nf64pa0G3wWpFMK6Vuc8lga6G6Kf5B/iQ4tPFE1liMPUVT8G4T/7hfRN/wjiNBEJ8PZOxJPDiiiu/z6Ykgu1Ojt1R6d4NH7AjpsRfbN46B66vKJTbkP+mtnCAASI5OljYPwPqFMyD+tG0lIrQJSYl82HwshFqov1cJYRlIRpLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hzzgA9md; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hzzgA9md"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SApKtB016256;
	Tue, 28 May 2024 22:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n8phL+/iiUppOXLHIq1lKJqQfTen+tuP0L2Rk09N7Ak=; b=hzzgA9mdSdkdGKqN
	hZITW+l+vitiGC650rts21rmoa8OYMqT+1KRpggF1jDTAOUPKi7lncQxGOBRCu5q
	MNdy4oCfg8UtEAMmVGYY2MqgRL1xyiu+QMH1kJ2R+bv6FOAdXSI+kVD9yDujjSM5
	PLKChH0++KXf67XyL5SG8hVuN7NbfKEt+D8UdVxYDYf01NC+GaBkVHpoEijAvoS0
	pxnSzCRPKVIZPdbRDi2i36DfWe0X7C5Wf592tJ2hf3PEuxQe7hHoz/p0BeEUKOR+
	yu56bLBT67mI3Go6rts1aWObeChldd2qbrA8fychkGaN3eSn6jXOYnLpV7Tj7tlc
	k9921Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2nffym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 22:37:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44SMb7WO012676
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 22:37:07 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 May 2024 15:37:03 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <robh@kernel.org>, <saravanak@google.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <catalin.marinas@arm.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kernel@quicinc.com>,
        Oreoluwa Babatunde
	<quic_obabatun@quicinc.com>
Subject: [PATCH v6 1/4] of: reserved_mem: Restruture how the reserved memory regions are processed
Date: Tue, 28 May 2024 15:36:47 -0700
Message-ID: <20240528223650.619532-2-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528223650.619532-1-quic_obabatun@quicinc.com>
References: <20240528223650.619532-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pFWuLlTuchbqPkUcXIECaAB_6-MS76gr
X-Proofpoint-GUID: pFWuLlTuchbqPkUcXIECaAB_6-MS76gr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405280168

The current implementation processes the reserved memory regions in two
stages which are done with two separate functions within the
early_init_fdt_scan_reserved_mem() function.

Within the two stages of processing, the reserved memory regions are
broken up into two groups which are processed differently:
i) Statically-placed reserved memory regions
i.e. regions defined with a static start address and size using the
     "reg" property in the DT.
ii) Dynamically-placed reserved memory regions.
i.e. regions defined by specifying a range of addresses where they can
     be placed in memory using the "alloc_ranges" and "size" properties
     in the DT.

Stage 1: fdt_scan_reserved_mem()
This stage of the reserved memory processing is used to scan through the
reserved memory nodes defined in the devicetree and do the following on
each of the nodes:

1) If the node represents a statically-placed reserved memory region,
   i.e. it is defined using the "reg" property:
   - Call memblock_reserve() or memblock_mark_nomap() as needed.
   - Add the information for the reserved region to the reserved_mem
     array.
     eg: fdt_reserved_mem_save_node(node, name, base, size);

2) If the node represents a dynamically-placed reserved memory region,
   i.e. it is defined using "alloc-ranges" and "size" properties:
   - Add the information for the region to the reserved_mem array with
     the starting address and size set to 0.
     eg: fdt_reserved_mem_save_node(node, name, 0, 0);

Stage 2: fdt_init_reserved_mem()
This stage of the reserved memory processing is used to iterate through
the reserved_mem array which was populated in stage 1 and do the
following on each of the entries:

1) If the entry represents a statically-placed reserved memory region:
   - Call the region specific init function.
2) If the entry represents a dynamically-placed reserved memory region:
   - Call __reserved_mem_alloc_size() which is used to allocate memory
     for the region using memblock_phys_alloc_range(), and call
     memblock_mark_nomap() on the allocated region if the region is
     specified as a no-map region.
   - Call the region specific init function.

On architectures such as arm64, the dynamic allocation of the
reserved_mem array needs to be done after the page tables have been
setup because memblock allocated memory is not writable until then. This
means that the reserved_mem array will not be available to store any
reserved memory information until after the page tables have been setup.

It is possible to call memblock_reserve() and memblock_mark_nomap() on
the statically-placed reserved memory regions and not need to save them
to the reserved_mem array until later. This is because all the
information we need is present in the devicetree.
Dynamically-placed reserved memory regions on the other hand get
assigned a start address only at runtime, and since memblock_reserve()
and memblock_mark_nomap() need to be called before the memory mappings
are created, the allocation needs to happen before the page tables are
setup.

To make it easier to handle dynamically-placed reserved memory regions
before the page tables are setup, this patch makes changes to the steps
above to process the reserved memory regions in the following ways:

Step 1: fdt_scan_reserved_mem()
This stage of the reserved memory processing is used to scan through the
reserved memory nodes defined in the devicetree and do the following on
each of the nodes:

1) If the node represents a statically-placed reserved memory region,
   i.e. it is defined using the "reg" property:
   - Call memblock_reserve() or memblock_mark_nomap() as needed.

2) If the node represents a dynamically-placed reserved memory region,
   i.e. it is defined using "alloc-ranges" and "size" properties:
   - Call __reserved_mem_alloc_size() which will:
     i) Allocate memory for the reserved memory region.
     ii) Call memblock_mark_nomap() as needed.
     Note: There is no need to explicitly call memblock_reserve() here
     because it is already called by memblock when the memory for the
     region is being allocated.
     iii) Save the information for the region in the reserved_mem array.

Step 2: fdt_init_reserved_mem()
This stage of the reserved memory processing is used to:

1) Add the information for the statically-placed reserved memory into
   the reserved_mem array.

2) Iterate through all the entries in the array and call the region
   specific init function for each of them.

fdt_init_reserved_mem() is also now called from within the
unflatten_device_tree() function so that this step happens after the
page tables have been setup.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c             |   5 +-
 drivers/of/of_private.h      |   1 +
 drivers/of/of_reserved_mem.c | 134 +++++++++++++++++++++++++----------
 3 files changed, 100 insertions(+), 40 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a8a04f27915b..527e6bc1c096 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -532,8 +532,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
 			break;
 		memblock_reserve(base, size);
 	}
-
-	fdt_init_reserved_mem();
 }
 
 /**
@@ -1259,6 +1257,9 @@ void __init unflatten_device_tree(void)
 	of_alias_scan(early_init_dt_alloc_memory_arch);
 
 	unittest_unflatten_overlay_base();
+
+	/* initialize the reserved memory regions */
+	fdt_init_reserved_mem();
 }
 
 /**
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 94fc0aa07af9..d889b8c17ca3 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -9,6 +9,7 @@
  */
 
 #define FDT_ALIGN_SIZE 8
+#define MAX_RESERVED_REGIONS    64
 
 /**
  * struct alias_prop - Alias property in 'aliases' node
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 46e1c3fbc769..78ffc2635f11 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -27,7 +27,6 @@
 
 #include "of_private.h"
 
-#define MAX_RESERVED_REGIONS	64
 static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
 static int reserved_mem_count;
 
@@ -106,7 +105,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	phys_addr_t base, size;
 	int len;
 	const __be32 *prop;
-	int first = 1;
 	bool nomap;
 
 	prop = of_get_flat_dt_prop(node, "reg", &len);
@@ -134,10 +132,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 			       uname, &base, (unsigned long)(size / SZ_1M));
 
 		len -= t_len;
-		if (first) {
-			fdt_reserved_mem_save_node(node, uname, base, size);
-			first = 0;
-		}
 	}
 	return 0;
 }
@@ -165,12 +159,69 @@ static int __init __reserved_mem_check_root(unsigned long node)
 	return 0;
 }
 
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
+static void __init fdt_scan_reserved_mem_reg_nodes(void)
+{
+	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+	const void *fdt = initial_boot_params;
+	phys_addr_t base, size;
+	const __be32 *prop;
+	int node, child;
+	int len;
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
@@ -192,8 +243,24 @@ int __init fdt_scan_reserved_mem(void)
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
@@ -253,8 +320,7 @@ static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
  * __reserved_mem_alloc_size() - allocate reserved memory described by
  *	'size', 'alignment'  and 'alloc-ranges' properties.
  */
-static int __init __reserved_mem_alloc_size(unsigned long node,
-	const char *uname, phys_addr_t *res_base, phys_addr_t *res_size)
+static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
 {
 	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
 	phys_addr_t start = 0, end = 0;
@@ -333,10 +399,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-
-	*res_base = base;
-	*res_size = size;
-
+	fdt_reserved_mem_save_node(node, uname, base, size);
 	return 0;
 }
 
@@ -431,6 +494,8 @@ void __init fdt_init_reserved_mem(void)
 {
 	int i;
 
+	fdt_scan_reserved_mem_reg_nodes();
+
 	/* check for overlapping reserved regions */
 	__rmem_check_for_overlap();
 
@@ -442,30 +507,23 @@ void __init fdt_init_reserved_mem(void)
 
 		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
 
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
+		err = __reserved_mem_init_node(rmem);
+		if (err != 0 && err != -ENOENT) {
+			pr_info("node %s compatible matching fail\n", rmem->name);
+			if (nomap)
+				memblock_clear_nomap(rmem->base, rmem->size);
+			else
+				memblock_phys_free(rmem->base, rmem->size);
+		} else {
+			phys_addr_t end = rmem->base + rmem->size - 1;
+			bool reusable =
+				(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
+
+			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
+				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
+				nomap ? "nomap" : "map",
+				reusable ? "reusable" : "non-reusable",
+				rmem->name ? rmem->name : "unknown");
 		}
 	}
 }
-- 
2.34.1

