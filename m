Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760B113D8A2
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935838; cv=none; b=rA7ebnpw/M2h5kCDrO6of3S6j8fPJWO3gCUKEXLL3852ytPLHelLkwr6kZfcsyOSFGbOcNx1ZID6I4KDKsDtC1UtAIFjqkiPumxlg0tfVPnLCFaQV/mzwWclvuuL6dQQfF4C4IVGkPC3NPWygfpLRJKEA4wtgB0YoUNjMp3O8oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935838; c=relaxed/simple;
	bh=3hxjq3n/Rbx1YoohrpPmBxlaS+/WENfm4yf4nBLd5q8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVgGjFZWs8M+G6xpCnIx5C0XIOmcycfWrbeAHir2JlL4SclxgbKHEeKSY9QzXrYOxmNp7Wkyw5H+NMN1Dkc9dFyn4B/nXMhO//y6vLaark/l35OqSC6XXm9FunFBUQCwQ1XqWmV1oSmRLRB1f1qcZ4wCuX9AESdoCo4CblgovVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PsBO5CCF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PsBO5CCF"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SL3iax003640;
	Tue, 28 May 2024 22:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gz3XZZVJT4oGhs+9zgJTkY973qkuB93msz5Squ9jXMk=; b=PsBO5CCFINbPWaRT
	zisPU553DNU50CwB49EdYg+yq/R3DHSTb3ckr5qTD/vUjPJMUXOfNu6CJTV68EBo
	N10F869E016pgQW4Co4Dn9UUHCYsoFoXa8pQoq9YC2jKk98aPi3pKuSkI+P4kkAV
	09WeamZ1h+7jYFzomwdx3px1MpuwfPiijLRH4XWAM387iSalEkOB696yKWrXUN+D
	drxVtDKKQDbvm5vvnWb+pNjE+OOkfsWLoW8W0zjgcLK+TkraKVcXDgmte1JFS8pw
	nB840YsIuho8aoX5kT2Uen/ZyWxMnpI3MK/2B6V68R8nzPzU0NfYXrUKb0TICmOP
	n5vLBA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba1k7fty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 22:37:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44SMb7WP012676
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 22:37:07 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 May 2024 15:37:04 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <robh@kernel.org>, <saravanak@google.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <catalin.marinas@arm.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kernel@quicinc.com>,
        Oreoluwa Babatunde
	<quic_obabatun@quicinc.com>
Subject: [PATCH v6 3/4] of: reserved_mem: Use unflatten_devicetree APIs to scan reserved memory nodes
Date: Tue, 28 May 2024 15:36:49 -0700
Message-ID: <20240528223650.619532-4-quic_obabatun@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 8RoWvymOaRXmz1GwYAHGsOyMqY08yRM5
X-Proofpoint-GUID: 8RoWvymOaRXmz1GwYAHGsOyMqY08yRM5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280168

The unflatten_devicetree APIs have been setup and are available to be
used by the time the fdt_init_reserved_mem() function is called.
Since the unflatten_devicetree APIs are a more efficient way of scanning
through the DT nodes, switch to using these APIs to facilitate the rest
of the reserved memory processing.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/of_reserved_mem.c    | 93 ++++++++++++++++++++-------------
 include/linux/of_reserved_mem.h |  2 +-
 kernel/dma/coherent.c           | 10 ++--
 kernel/dma/contiguous.c         |  8 +--
 kernel/dma/swiotlb.c            | 10 ++--
 5 files changed, 72 insertions(+), 51 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 113d593ea031..05283cd24c3b 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/libfdt.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 #include <linux/mm.h>
@@ -99,7 +100,7 @@ static void __init alloc_reserved_mem_array(void)
 /*
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
-static void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
+static void __init fdt_reserved_mem_save_node(struct device_node *node, const char *uname,
 					      phys_addr_t base, phys_addr_t size)
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
@@ -109,7 +110,7 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
 		return;
 	}
 
-	rmem->fdt_node = node;
+	rmem->dev_node = node;
 	rmem->name = uname;
 	rmem->base = base;
 	rmem->size = size;
@@ -178,11 +179,11 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 }
 
 /*
- * __reserved_mem_check_root() - check if #size-cells, #address-cells provided
+ * __fdt_reserved_mem_check_root() - check if #size-cells, #address-cells provided
  * in /reserved-memory matches the values supported by the current implementation,
  * also check if ranges property has been provided
  */
-static int __init __reserved_mem_check_root(unsigned long node)
+static int __init __fdt_reserved_mem_check_root(unsigned long node)
 {
 	const __be32 *prop;
 
@@ -200,6 +201,35 @@ static int __init __reserved_mem_check_root(unsigned long node)
 	return 0;
 }
 
+/*
+ * of_reserved_mem_check_root() - check if #size-cells, #address-cells provided
+ * in /reserved-memory matches the values supported by the current implementation,
+ * also check if ranges property has been provided
+ */
+static int __init of_reserved_mem_check_root(struct device_node *node)
+{
+	u32 prop;
+	int ret;
+
+	ret = of_property_read_u32(node, "#size-cells", &prop);
+	if (ret)
+		return ret;
+
+	if (prop != dt_root_size_cells)
+		return -EINVAL;
+
+	ret = of_property_read_u32(node, "#address-cells", &prop);
+	if (ret)
+		return ret;
+
+	if (prop != dt_root_addr_cells)
+		return -EINVAL;
+
+	if (!of_property_present(node, "ranges"))
+		return -EINVAL;
+	return 0;
+}
+
 /**
  * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
  * reserved memory regions.
@@ -212,41 +242,40 @@ static int __init __reserved_mem_check_root(unsigned long node)
  */
 static void __init fdt_scan_reserved_mem_reg_nodes(void)
 {
-	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
-	const void *fdt = initial_boot_params;
+	struct device_node *node, *child;
 	phys_addr_t base, size;
-	const __be32 *prop;
-	int node, child;
-	int len;
 
-	node = fdt_path_offset(fdt, "/reserved-memory");
-	if (node < 0) {
+	node = of_find_node_by_path("/reserved-memory");
+	if (!node) {
 		pr_info("Reserved memory: No reserved-memory node in the DT\n");
 		return;
 	}
 
-	if (__reserved_mem_check_root(node)) {
+	if (of_reserved_mem_check_root(node)) {
 		pr_err("Reserved memory: unsupported node format, ignoring\n");
 		return;
 	}
 
-	fdt_for_each_subnode(child, fdt, node) {
+	for_each_child_of_node(node, child) {
+		int ret = 0;
 		const char *uname;
+		struct resource res;
+		struct reserved_mem *rmem;
 
-		prop = of_get_flat_dt_prop(child, "reg", &len);
-		if (!prop)
-			continue;
-		if (!of_fdt_device_is_available(fdt, child))
+		if (!of_device_is_available(child))
 			continue;
 
-		uname = fdt_get_name(fdt, child, NULL);
-		if (len && len % t_len != 0) {
-			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
-			       uname);
+		ret = of_address_to_resource(child, 0, &res);
+		if (ret) {
+			rmem = of_reserved_mem_lookup(child);
+			if (rmem)
+				rmem->dev_node = child;
 			continue;
 		}
-		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
-		size = dt_mem_next_cell(dt_root_size_cells, &prop);
+		uname = of_node_full_name(child);
+
+		base = res.start;
+		size = res.end - res.start + 1;
 
 		if (size)
 			fdt_reserved_mem_save_node(child, uname, base, size);
@@ -269,7 +298,7 @@ int __init fdt_scan_reserved_mem(void)
 	if (node < 0)
 		return -ENODEV;
 
-	if (__reserved_mem_check_root(node) != 0) {
+	if (__fdt_reserved_mem_check_root(node) != 0) {
 		pr_err("Reserved memory: unsupported node format, ignoring\n");
 		return -EINVAL;
 	}
@@ -447,7 +476,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-	fdt_reserved_mem_save_node(node, uname, base, size);
+	fdt_reserved_mem_save_node(NULL, uname, base, size);
 	return 0;
 }
 
@@ -467,7 +496,7 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
 		reservedmem_of_init_fn initfn = i->data;
 		const char *compat = i->compatible;
 
-		if (!of_flat_dt_is_compatible(rmem->fdt_node, compat))
+		if (!of_device_is_compatible(rmem->dev_node, compat))
 			continue;
 
 		ret = initfn(rmem);
@@ -500,11 +529,6 @@ static int __init __rmem_cmp(const void *a, const void *b)
 	if (ra->size > rb->size)
 		return 1;
 
-	if (ra->fdt_node < rb->fdt_node)
-		return -1;
-	if (ra->fdt_node > rb->fdt_node)
-		return 1;
-
 	return 0;
 }
 
@@ -551,11 +575,11 @@ void __init fdt_init_reserved_mem(void)
 
 	for (i = 0; i < reserved_mem_count; i++) {
 		struct reserved_mem *rmem = &reserved_mem[i];
-		unsigned long node = rmem->fdt_node;
+		struct device_node *node = rmem->dev_node;
 		int err = 0;
 		bool nomap;
 
-		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+		nomap = of_property_present(node, "no-map");
 
 		err = __reserved_mem_init_node(rmem);
 		if (err != 0 && err != -ENOENT) {
@@ -566,8 +590,7 @@ void __init fdt_init_reserved_mem(void)
 				memblock_phys_free(rmem->base, rmem->size);
 		} else {
 			phys_addr_t end = rmem->base + rmem->size - 1;
-			bool reusable =
-				(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
+			bool reusable = of_property_present(node, "reusable");
 
 			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
 				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index e338282da652..769b8f67c8d3 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -10,7 +10,7 @@ struct reserved_mem_ops;
 
 struct reserved_mem {
 	const char			*name;
-	unsigned long			fdt_node;
+	struct device_node              *dev_node;
 	const struct reserved_mem_ops	*ops;
 	phys_addr_t			base;
 	phys_addr_t			size;
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index ff5683a57f77..8f99586204fb 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -362,20 +362,18 @@ static const struct reserved_mem_ops rmem_dma_ops = {
 
 static int __init rmem_dma_setup(struct reserved_mem *rmem)
 {
-	unsigned long node = rmem->fdt_node;
+	struct device_node *node = rmem->dev_node;
 
-	if (of_get_flat_dt_prop(node, "reusable", NULL))
+	if (of_property_present(node, "reusable"))
 		return -EINVAL;
 
-#ifdef CONFIG_ARM
-	if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
+	if (IS_ENABLED(CONFIG_ARM) && !of_property_present(node, "no-map")) {
 		pr_err("Reserved memory: regions without no-map are not yet supported\n");
 		return -EINVAL;
 	}
-#endif
 
 #ifdef CONFIG_DMA_GLOBAL_POOL
-	if (of_get_flat_dt_prop(node, "linux,dma-default", NULL)) {
+	if (of_property_present(node, "linux,dma-default")) {
 		WARN(dma_reserved_default_memory,
 		     "Reserved memory: region for default DMA coherent area is redefined\n");
 		dma_reserved_default_memory = rmem;
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 055da410ac71..450e9e4be79c 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -456,8 +456,8 @@ static const struct reserved_mem_ops rmem_cma_ops = {
 
 static int __init rmem_cma_setup(struct reserved_mem *rmem)
 {
-	unsigned long node = rmem->fdt_node;
-	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
+	struct device_node *node = rmem->dev_node;
+	bool default_cma = of_property_read_bool(node, "linux,cma-default");
 	struct cma *cma;
 	int err;
 
@@ -467,8 +467,8 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		return -EBUSY;
 	}
 
-	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
-	    of_get_flat_dt_prop(node, "no-map", NULL))
+	if (!of_property_present(node, "reusable") ||
+	    of_property_present(node, "no-map"))
 		return -EINVAL;
 
 	if (!IS_ALIGNED(rmem->base | rmem->size, CMA_MIN_ALIGNMENT_BYTES)) {
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index fe1ccb53596f..9949ddc14272 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1859,12 +1859,12 @@ static const struct reserved_mem_ops rmem_swiotlb_ops = {
 
 static int __init rmem_swiotlb_setup(struct reserved_mem *rmem)
 {
-	unsigned long node = rmem->fdt_node;
+	struct device_node *node = rmem->dev_node;
 
-	if (of_get_flat_dt_prop(node, "reusable", NULL) ||
-	    of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
-	    of_get_flat_dt_prop(node, "linux,dma-default", NULL) ||
-	    of_get_flat_dt_prop(node, "no-map", NULL))
+	if (of_property_present(node, "reusable") ||
+	    of_property_present(node, "linux,cma-default") ||
+	    of_property_present(node, "linux,dma-default") ||
+	    of_property_present(node, "no-map"))
 		return -EINVAL;
 
 	rmem->ops = &rmem_swiotlb_ops;
-- 
2.34.1

