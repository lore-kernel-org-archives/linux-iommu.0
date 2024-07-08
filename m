Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FB914F9E6
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480015; cv=none; b=rKs8VeNxw1u5ZFexAFRokT++D0vpoovclTZWFGU9NSJ/RQ9D8q86QbcyT4CiH4NzMglkCwAomAe16fCnLyNxl3FixBJ66rpAzCm+pEvEq87qi6ZPDJOUvcZEYK2qmABU88bHbK4BLRfxWHkuFu+/x3oYV9zNFYYZu99lSM7PvwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480015; c=relaxed/simple;
	bh=qAotXApEBKYcIPDOzYD1J5xTTBY7cx5D4CJnoNaSCI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FI1o7olk7yBSoc0GmRWmKtbqz1kUthIZH19amosPMwkOnLAe0Yn9wuAJH2AyMFPPFfJGZzcU+8k9JERsKvHpSeJWYnMxGdI/ptQYLfl59JIcuKpxN+SZtvi1v9ZZLPf1Ni/z5mqzZY0+G0QYMei9ZNw+/oiTKzJffQZId18AXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FFuxzUb1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FFuxzUb1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468MqHMQ001076;
	Mon, 8 Jul 2024 23:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rn+gzeF51A64pAxmwb0k2S+UtKezO+Y/dzS+iADQdzY=; b=FFuxzUb1sXKe6caL
	PPIVJ0rOb3Dj3WK2PD8XNOb9YhulvGOk2B4Q5uJypIeXkRkbbXiOamgLZb8L2vQ8
	lqS3TxAMeiD8ObRfCRgLrTkXVMf/zQshkkCOle/hJROVGYaiL0xCxz0VeG6KsfB1
	xs72Z53P/Ei/5ZIQDdIQ4L89NJIcGRGvgwMfINgxPZarZSYBbOvB/sj417+DIyhR
	E8O06eknmCKeyVm/RXmMRFHXhcF0UGZ5vyvOS0Eob2XqqmPqD6z3WdMYblx3SS2t
	WYCrjR5DSHgP7QqvjdFA88bW0S5afVVxID2a+DYYBZpTX602THjisVDAy0zzS8Ys
	C8fGmQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x514wxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 23:06:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 468N6hrK030810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 23:06:43 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 8 Jul 2024 16:06:40 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <robh@kernel.org>, <saravanak@google.com>, <klarasmodin@gmail.com>,
        <aisheng.dong@nxp.com>
CC: <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <kernel@quicinc.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [PATCH 1/4] Revert "of: reserved_mem: Restructure code to call reserved mem init functions earlier"
Date: Mon, 8 Jul 2024 16:06:10 -0700
Message-ID: <20240708230613.448846-2-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: uGO7mNtF0tyaXgwokbgg9UrIHHtDWOx-
X-Proofpoint-ORIG-GUID: uGO7mNtF0tyaXgwokbgg9UrIHHtDWOx-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_13,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080172

This reverts commit f2a524d9ef5b2cf9b06c4a59374bb5efbf697ba0.

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

Since this fix is based on changes that were made to use the
unflatten_devicetree APIs, revert it. The fix will be reapplied with the
relevant changes needed to make use of the fdt APIs instead.

[1] https://lore.kernel.org/all/20240610213403.GA1697364@thelio-3990X/

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c             |  2 +-
 drivers/of/of_private.h      |  2 +-
 drivers/of/of_reserved_mem.c | 83 +++++++++++++++---------------------
 3 files changed, 37 insertions(+), 50 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ea2dff0478c7..9cde2abd2fc0 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1239,7 +1239,7 @@ void __init unflatten_device_tree(void)
 	unittest_unflatten_overlay_base();
 
 	/* initialize the reserved memory regions */
-	of_scan_reserved_mem_reg_nodes();
+	of_init_reserved_mem();
 }
 
 /**
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 7412aed903df..01b33c4b1e9f 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -181,7 +181,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 #endif
 
 int fdt_scan_reserved_mem(void);
-void of_scan_reserved_mem_reg_nodes(void);
+void of_init_reserved_mem(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index b31001728866..eb54490a0a11 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -97,8 +97,6 @@ static void __init alloc_reserved_mem_array(void)
 	reserved_mem = new_array;
 }
 
-static void __init of_init_reserved_mem_node(struct reserved_mem *rmem);
-
 /*
  * of_reserved_mem_save_node() - save fdt node for second pass initialization
  */
@@ -117,12 +115,6 @@ static void __init of_reserved_mem_save_node(struct device_node *node, const cha
 	rmem->base = base;
 	rmem->size = size;
 
-	/*
-	 * Run the region specific initialization function for the rmem
-	 * node.
-	 */
-	of_init_reserved_mem_node(rmem);
-
 	reserved_mem_count++;
 	return;
 }
@@ -209,8 +201,6 @@ static int __init __fdt_reserved_mem_check_root(unsigned long node)
 	return 0;
 }
 
-static void __init __rmem_check_for_overlap(void);
-
 /**
  * of_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
  * reserved memory regions.
@@ -221,7 +211,7 @@ static void __init __rmem_check_for_overlap(void);
  * size are all stored in the reserved_mem array by calling the
  * of_reserved_mem_save_node() function.
  */
-void __init of_scan_reserved_mem_reg_nodes(void)
+static void __init of_scan_reserved_mem_reg_nodes(void)
 {
 	struct device_node *node, *child;
 	phys_addr_t base, size;
@@ -232,13 +222,6 @@ void __init of_scan_reserved_mem_reg_nodes(void)
 		return;
 	}
 
-	/*
-	 * Before moving forward, allocate the exact size needed for the
-	 * reserved_mem array and copy all previously saved contents
-	 * into the new array if successful.
-	 */
-	alloc_reserved_mem_array();
-
 	for_each_child_of_node(node, child) {
 		int ret = 0;
 		const char *uname;
@@ -263,8 +246,6 @@ void __init of_scan_reserved_mem_reg_nodes(void)
 		if (size)
 			of_reserved_mem_save_node(child, uname, base, size);
 	}
-	/* check for overlapping reserved regions */
-	__rmem_check_for_overlap();
 }
 
 static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname);
@@ -545,38 +526,44 @@ static void __init __rmem_check_for_overlap(void)
 }
 
 /**
- * of_init_reserved_mem_node() - Initialize a saved reserved memory region.
- * @rmem: reserved_mem object of the memory region to be initialized.
- *
- * This function is used to call the region specific initialization
- * function on the rmem object passed as an argument. The rmem object
- * will contain the base address, size, node name, and device_node of
- * the reserved memory region to be initialized.
+ * of_init_reserved_mem() - allocate and init all saved reserved memory regions
  */
-static void __init of_init_reserved_mem_node(struct reserved_mem *rmem)
+void __init of_init_reserved_mem(void)
 {
-	int err;
-	bool nomap;
-	struct device_node *node = rmem->dev_node;
+	int i;
+
+	alloc_reserved_mem_array();
 
-	nomap = of_property_present(node, "no-map");
+	of_scan_reserved_mem_reg_nodes();
 
-	err = __reserved_mem_init_node(rmem);
-	if (err != 0 && err != -ENOENT) {
-		pr_info("node %s compatible matching fail\n", rmem->name);
-		if (nomap)
-			memblock_clear_nomap(rmem->base, rmem->size);
-		else
-			memblock_phys_free(rmem->base, rmem->size);
-	} else {
-		phys_addr_t end = rmem->base + rmem->size - 1;
-		bool reusable = of_property_present(node, "reusable");
-
-		pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
-			&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
-			nomap ? "nomap" : "map",
-			reusable ? "reusable" : "non-reusable",
-			rmem->name ? rmem->name : "unknown");
+	/* check for overlapping reserved regions */
+	__rmem_check_for_overlap();
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserved_mem *rmem = &reserved_mem[i];
+		struct device_node *node = rmem->dev_node;
+		int err = 0;
+		bool nomap;
+
+		nomap = of_property_present(node, "no-map");
+
+		err = __reserved_mem_init_node(rmem);
+		if (err != 0 && err != -ENOENT) {
+			pr_info("node %s compatible matching fail\n", rmem->name);
+			if (nomap)
+				memblock_clear_nomap(rmem->base, rmem->size);
+			else
+				memblock_phys_free(rmem->base, rmem->size);
+		} else {
+			phys_addr_t end = rmem->base + rmem->size - 1;
+			bool reusable = of_property_present(node, "reusable");
+
+			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
+				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
+				nomap ? "nomap" : "map",
+				reusable ? "reusable" : "non-reusable",
+				rmem->name ? rmem->name : "unknown");
+		}
 	}
 }
 
-- 
2.34.1

