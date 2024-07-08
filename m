Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AAF14F9E6
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480017; cv=none; b=gBeJbwmVFZKjK9H9BLF+qOZrNFb5yN3TOnQ9mH5/MHKEeWDQwoCHAKtjyc2pKerQFdrRW5840+YSRR0b52LI0Ec0t0urAC/u0/6OwxToyPKgxNGAzSkZ2j/ooUVurC94OdlIgNpzMcij6zeXGotDM1mY+uHNbOeY5B/nXE7ofns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480017; c=relaxed/simple;
	bh=dqk74/g8hw83ErxVO4HV0rE2l5zJbF00MbBjhU5pCG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrDWUD1sAjGpQs037jLa2pW3oSb2lICU1MGoXgIHu8j7lDIkYNg4uT79F4hbkgl1N1Ucnj0yroZ3JTIZVAMgXf/SVFSAq7nh9Qo6mwlZEbhWqaMTD8q1hF5DHfk5bZTq0oq0a7zP0vcPZ6KKnyb8Yytjl4XvQ4vZM92+siOkBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LArWB2gx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LArWB2gx"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468BjZEA012919;
	Mon, 8 Jul 2024 23:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/Q4au3A0R0Dk0sLYiC1R6AlcGeFfXEO58uJl2/cskKs=; b=LArWB2gxQjK2qmpP
	68K66ExLQUYGnwbi9TmHfwE2QSCE4Ss5orDO9Z2q5wgtjruAQ7lARvVTmVgBI7yU
	nuoJsNskG08JRsDJj9nFvXXBf90+jWPvE7s5dq8Tyu9nbIB+2bOwxwLStMiZkD6A
	HuzSrz0s4UHj1z/IMImpq9GD1FcT2Eb3teC5QJc2VMzM7TmFnRkDZZgtJrXfFbw3
	Q/D6f5RVaraxxlYIFBpgtcKUdbmbNYLC+ITqEt70+EikPI0wV/d8AZPkdUgLY3d/
	qM2a14sb71JtRzqKkQk5pnKQwC1FtSIcGh0bjqG4qkKqNtLu+xtnjehke0mZr1A/
	RxbAqg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x514wxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 23:06:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 468N6jXn002225
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 23:06:45 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 8 Jul 2024 16:06:41 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <robh@kernel.org>, <saravanak@google.com>, <klarasmodin@gmail.com>,
        <aisheng.dong@nxp.com>
CC: <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <kernel@quicinc.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [PATCH 3/4] Revert "of: reserved_mem: Use unflatten_devicetree APIs to scan reserved memory nodes"
Date: Mon, 8 Jul 2024 16:06:12 -0700
Message-ID: <20240708230613.448846-4-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708230613.448846-1-quic_obabatun@quicinc.com>
References: <20240708230613.448846-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4PkZwP92vBgTEgi0zHUFBvAexrs2r8hH
X-Proofpoint-ORIG-GUID: 4PkZwP92vBgTEgi0zHUFBvAexrs2r8hH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_13,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080172

This reverts commit 59d2c3cbcb5a47483629d8d992886e2650d786df.

With recent changes made to initialize the cma regions before the page
tables are setup, commit f2a524d9ef5b ("of: reserved_mem: Restructure
code to call reserved mem init functions earlier"), an issue was
introduced where the initialization of the cma regions fail and are
initialized as "non-reusable" regions instead of "reusable".

This issue occurs because the device_node of the regions are not yet
created by the time the cma regions are being initialized.

The cma regions need to be initialized before the page tables are setup
for them to be configured correctly as was realized in [1].

Hence, since the unflatten_devicetree APIs are not available until after
the page tables have been setup, revert back to using the fdt APIs. This
makes it possible to store a reference to each cma node in the
reserved_mem array by the time it is needed in their init function.

[1] https://lore.kernel.org/all/20240610213403.GA1697364@thelio-3990X/

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/of_reserved_mem.c    | 67 +++++++++++++++++++--------------
 include/linux/of_reserved_mem.h |  2 +-
 kernel/dma/coherent.c           | 10 +++--
 kernel/dma/contiguous.c         |  8 ++--
 kernel/dma/swiotlb.c            | 10 ++---
 5 files changed, 55 insertions(+), 42 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 784a49a27e7f..113d593ea031 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -14,7 +14,6 @@
 #include <linux/err.h>
 #include <linux/libfdt.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 #include <linux/mm.h>
@@ -100,7 +99,7 @@ static void __init alloc_reserved_mem_array(void)
 /*
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
-static void __init fdt_reserved_mem_save_node(struct device_node *node, const char *uname,
+static void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 					      phys_addr_t base, phys_addr_t size)
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
@@ -110,7 +109,7 @@ static void __init fdt_reserved_mem_save_node(struct device_node *node, const ch
 		return;
 	}
 
-	rmem->dev_node = node;
+	rmem->fdt_node = node;
 	rmem->name = uname;
 	rmem->base = base;
 	rmem->size = size;
@@ -179,11 +178,11 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 }
 
 /*
- * __fdt_reserved_mem_check_root() - check if #size-cells, #address-cells provided
+ * __reserved_mem_check_root() - check if #size-cells, #address-cells provided
  * in /reserved-memory matches the values supported by the current implementation,
  * also check if ranges property has been provided
  */
-static int __init __fdt_reserved_mem_check_root(unsigned long node)
+static int __init __reserved_mem_check_root(unsigned long node)
 {
 	const __be32 *prop;
 
@@ -213,35 +212,41 @@ static int __init __fdt_reserved_mem_check_root(unsigned long node)
  */
 static void __init fdt_scan_reserved_mem_reg_nodes(void)
 {
-	struct device_node *node, *child;
+	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+	const void *fdt = initial_boot_params;
 	phys_addr_t base, size;
+	const __be32 *prop;
+	int node, child;
+	int len;
 
-	node = of_find_node_by_path("/reserved-memory");
-	if (!node) {
+	node = fdt_path_offset(fdt, "/reserved-memory");
+	if (node < 0) {
 		pr_info("Reserved memory: No reserved-memory node in the DT\n");
 		return;
 	}
 
-	for_each_child_of_node(node, child) {
-		int ret = 0;
+	if (__reserved_mem_check_root(node)) {
+		pr_err("Reserved memory: unsupported node format, ignoring\n");
+		return;
+	}
+
+	fdt_for_each_subnode(child, fdt, node) {
 		const char *uname;
-		struct resource res;
-		struct reserved_mem *rmem;
 
-		if (!of_device_is_available(child))
+		prop = of_get_flat_dt_prop(child, "reg", &len);
+		if (!prop)
+			continue;
+		if (!of_fdt_device_is_available(fdt, child))
 			continue;
 
-		ret = of_address_to_resource(child, 0, &res);
-		if (ret) {
-			rmem = of_reserved_mem_lookup(child);
-			if (rmem)
-				rmem->dev_node = child;
+		uname = fdt_get_name(fdt, child, NULL);
+		if (len && len % t_len != 0) {
+			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
+			       uname);
 			continue;
 		}
-		uname = of_node_full_name(child);
-
-		base = res.start;
-		size = res.end - res.start + 1;
+		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
+		size = dt_mem_next_cell(dt_root_size_cells, &prop);
 
 		if (size)
 			fdt_reserved_mem_save_node(child, uname, base, size);
@@ -264,7 +269,7 @@ int __init fdt_scan_reserved_mem(void)
 	if (node < 0)
 		return -ENODEV;
 
-	if (__fdt_reserved_mem_check_root(node) != 0) {
+	if (__reserved_mem_check_root(node) != 0) {
 		pr_err("Reserved memory: unsupported node format, ignoring\n");
 		return -EINVAL;
 	}
@@ -442,7 +447,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-	fdt_reserved_mem_save_node(NULL, uname, base, size);
+	fdt_reserved_mem_save_node(node, uname, base, size);
 	return 0;
 }
 
@@ -462,7 +467,7 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
 		reservedmem_of_init_fn initfn = i->data;
 		const char *compat = i->compatible;
 
-		if (!of_device_is_compatible(rmem->dev_node, compat))
+		if (!of_flat_dt_is_compatible(rmem->fdt_node, compat))
 			continue;
 
 		ret = initfn(rmem);
@@ -495,6 +500,11 @@ static int __init __rmem_cmp(const void *a, const void *b)
 	if (ra->size > rb->size)
 		return 1;
 
+	if (ra->fdt_node < rb->fdt_node)
+		return -1;
+	if (ra->fdt_node > rb->fdt_node)
+		return 1;
+
 	return 0;
 }
 
@@ -541,11 +551,11 @@ void __init fdt_init_reserved_mem(void)
 
 	for (i = 0; i < reserved_mem_count; i++) {
 		struct reserved_mem *rmem = &reserved_mem[i];
-		struct device_node *node = rmem->dev_node;
+		unsigned long node = rmem->fdt_node;
 		int err = 0;
 		bool nomap;
 
-		nomap = of_property_present(node, "no-map");
+		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
 
 		err = __reserved_mem_init_node(rmem);
 		if (err != 0 && err != -ENOENT) {
@@ -556,7 +566,8 @@ void __init fdt_init_reserved_mem(void)
 				memblock_phys_free(rmem->base, rmem->size);
 		} else {
 			phys_addr_t end = rmem->base + rmem->size - 1;
-			bool reusable = of_property_present(node, "reusable");
+			bool reusable =
+				(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
 
 			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
 				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 769b8f67c8d3..e338282da652 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -10,7 +10,7 @@ struct reserved_mem_ops;
 
 struct reserved_mem {
 	const char			*name;
-	struct device_node              *dev_node;
+	unsigned long			fdt_node;
 	const struct reserved_mem_ops	*ops;
 	phys_addr_t			base;
 	phys_addr_t			size;
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 8f99586204fb..ff5683a57f77 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -362,18 +362,20 @@ static const struct reserved_mem_ops rmem_dma_ops = {
 
 static int __init rmem_dma_setup(struct reserved_mem *rmem)
 {
-	struct device_node *node = rmem->dev_node;
+	unsigned long node = rmem->fdt_node;
 
-	if (of_property_present(node, "reusable"))
+	if (of_get_flat_dt_prop(node, "reusable", NULL))
 		return -EINVAL;
 
-	if (IS_ENABLED(CONFIG_ARM) && !of_property_present(node, "no-map")) {
+#ifdef CONFIG_ARM
+	if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
 		pr_err("Reserved memory: regions without no-map are not yet supported\n");
 		return -EINVAL;
 	}
+#endif
 
 #ifdef CONFIG_DMA_GLOBAL_POOL
-	if (of_property_present(node, "linux,dma-default")) {
+	if (of_get_flat_dt_prop(node, "linux,dma-default", NULL)) {
 		WARN(dma_reserved_default_memory,
 		     "Reserved memory: region for default DMA coherent area is redefined\n");
 		dma_reserved_default_memory = rmem;
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 450e9e4be79c..055da410ac71 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -456,8 +456,8 @@ static const struct reserved_mem_ops rmem_cma_ops = {
 
 static int __init rmem_cma_setup(struct reserved_mem *rmem)
 {
-	struct device_node *node = rmem->dev_node;
-	bool default_cma = of_property_read_bool(node, "linux,cma-default");
+	unsigned long node = rmem->fdt_node;
+	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
 	struct cma *cma;
 	int err;
 
@@ -467,8 +467,8 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		return -EBUSY;
 	}
 
-	if (!of_property_present(node, "reusable") ||
-	    of_property_present(node, "no-map"))
+	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
+	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
 
 	if (!IS_ALIGNED(rmem->base | rmem->size, CMA_MIN_ALIGNMENT_BYTES)) {
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9949ddc14272..fe1ccb53596f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1859,12 +1859,12 @@ static const struct reserved_mem_ops rmem_swiotlb_ops = {
 
 static int __init rmem_swiotlb_setup(struct reserved_mem *rmem)
 {
-	struct device_node *node = rmem->dev_node;
+	unsigned long node = rmem->fdt_node;
 
-	if (of_property_present(node, "reusable") ||
-	    of_property_present(node, "linux,cma-default") ||
-	    of_property_present(node, "linux,dma-default") ||
-	    of_property_present(node, "no-map"))
+	if (of_get_flat_dt_prop(node, "reusable", NULL) ||
+	    of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
+	    of_get_flat_dt_prop(node, "linux,dma-default", NULL) ||
+	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
 
 	rmem->ops = &rmem_swiotlb_ops;
-- 
2.34.1

