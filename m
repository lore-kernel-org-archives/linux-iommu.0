Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712814F105
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480016; cv=none; b=heuF8Yap7YdeHGvN4uLzjXh7p1hP0Pph+TLErEhpQJTeRM1mz/oOMCFZYCSA4Vbv0+xBsIeO/0HQQlCp8L0wqLyL66C4NKZxgMMp5aRseB4T/O1IG+0mUDGftsHHsK5JtXanc0V/L7MgkepZQea8rrAJz7TMSvEtuBiIdPlIw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480016; c=relaxed/simple;
	bh=zGSc/L8jzl/pQVdLr9FvQQTeChDw0MR1gGzmyJO3vr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKTUrM7zHCMl4gF+3Bclc5PiLy+eepHxoftOGt9C/L92ZNC97pQ7YmsRa5OV2FlNjZUCUrWhS+fNhltyyP617zXN1Nrdh5CCszdgQnuyBKo8b/ML/ChNX6x/W8S5lFy/wMQ2Cb6HurE4dJ6Jo5ah7PjkDarGJQuG8PtzuQriA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TteSwMk3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TteSwMk3"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468Ae5qQ031488;
	Mon, 8 Jul 2024 23:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0koejm4VGDSM/h2pnzdW2EIsVKC+/j5rOi0OvCOvocE=; b=TteSwMk3VqrE/ih6
	j98SlpskCjKIoxqyxdb+tK/RZSr/+zduOzsQGcY0iu1QlCodo92lZVNoeiKZWkHv
	lsdGC3SDb/txyaMp4KT6gFaCa+dLrs794b5/XG6RVDiHcvEJUrxlt7sap+u72TRy
	J8RB3Sf/cOoUYllLRt5wOa3gOnmrckMhUFywLvKlfFUCQShRl5Nf4Z/mimnmz6CO
	W7Bq7ett9RDQkjJeY7MD24WpG3jPUjyCN+qvdHVGhFZBdnB3dhYMr7XKe9geZXDy
	0Gr48DEzz7jtHGAc4yuvCvSpd4pjSub4lMYf/yqkIBFdW9MNuAQfbGac9SLvqLoM
	Q9pg1w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wgwmu31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 23:06:47 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 468N6jWX030833
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 23:06:46 GMT
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
Subject: [PATCH 4/4] of: reserved_mem: Restructure code to call rmem init functions earlier
Date: Mon, 8 Jul 2024 16:06:13 -0700
Message-ID: <20240708230613.448846-5-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: VTB4CDXzZKMbfIHnLPt8VscNCrm-yE2u
X-Proofpoint-ORIG-GUID: VTB4CDXzZKMbfIHnLPt8VscNCrm-yE2u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080171

This reapplies the fix from commit f2a524d9ef5b ("of: reserved_mem:
Restructure code to call reserved mem init functions earlier") which now
uses the fdt APIs instead of the unflatten_devicetree APIs.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c             |  2 +-
 drivers/of/of_private.h      |  2 +-
 drivers/of/of_reserved_mem.c | 79 ++++++++++++++++++++----------------
 3 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index e0f93886cc17..b5b1c9c8ed0a 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1239,7 +1239,7 @@ void __init unflatten_device_tree(void)
 	unittest_unflatten_overlay_base();
 
 	/* initialize the reserved memory regions */
-	fdt_init_reserved_mem();
+	fdt_scan_reserved_mem_reg_nodes();
 }
 
 /**
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 32b10d45b558..7ee11623612e 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -181,7 +181,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 #endif
 
 int fdt_scan_reserved_mem(void);
-void fdt_init_reserved_mem(void);
+void fdt_scan_reserved_mem_reg_nodes(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 113d593ea031..3fa06670f751 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -96,6 +96,7 @@ static void __init alloc_reserved_mem_array(void)
 	reserved_mem = new_array;
 }
 
+static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem);
 /*
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
@@ -114,6 +115,7 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
 	rmem->base = base;
 	rmem->size = size;
 
+	fdt_init_reserved_mem_node(rmem);
 	reserved_mem_count++;
 	return;
 }
@@ -200,6 +202,7 @@ static int __init __reserved_mem_check_root(unsigned long node)
 	return 0;
 }
 
+static void __init __rmem_check_for_overlap(void);
 /**
  * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
  * reserved memory regions.
@@ -210,7 +213,7 @@ static int __init __reserved_mem_check_root(unsigned long node)
  * size are all stored in the reserved_mem array by calling the
  * fdt_reserved_mem_save_node() function.
  */
-static void __init fdt_scan_reserved_mem_reg_nodes(void)
+void __init fdt_scan_reserved_mem_reg_nodes(void)
 {
 	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
 	const void *fdt = initial_boot_params;
@@ -230,6 +233,13 @@ static void __init fdt_scan_reserved_mem_reg_nodes(void)
 		return;
 	}
 
+	/*
+	 * Allocate the exact size needed for the reserved_mem array and
+	 * copy all the contents from the previous array if allocation
+	 * is successful.
+	 */
+	alloc_reserved_mem_array();
+
 	fdt_for_each_subnode(child, fdt, node) {
 		const char *uname;
 
@@ -251,6 +261,9 @@ static void __init fdt_scan_reserved_mem_reg_nodes(void)
 		if (size)
 			fdt_reserved_mem_save_node(child, uname, base, size);
 	}
+
+	/* check for overlapping reserved regions */
+	__rmem_check_for_overlap();
 }
 
 static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname);
@@ -536,45 +549,39 @@ static void __init __rmem_check_for_overlap(void)
 }
 
 /**
- * fdt_init_reserved_mem() - allocate and init all saved reserved memory regions
+ * fdt_init_reserved_mem_node() - allocate and init an rmem memory region
+ * @rmem: reserved_mem object of the memory region to be initialized.
+ *
+ * This function is used to call the region specific initialization
+ * function on the rmem object passed as an argument. The rmem object
+ * will contain the base address, size, node name, and device_node of
+ * the reserved memory region to be initialized.
  */
-void __init fdt_init_reserved_mem(void)
+static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem)
 {
-	int i;
-
-	alloc_reserved_mem_array();
-
-	fdt_scan_reserved_mem_reg_nodes();
+	unsigned long node = rmem->fdt_node;
+	int err = 0;
+	bool nomap;
 
-	/* check for overlapping reserved regions */
-	__rmem_check_for_overlap();
+	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
 
-	for (i = 0; i < reserved_mem_count; i++) {
-		struct reserved_mem *rmem = &reserved_mem[i];
-		unsigned long node = rmem->fdt_node;
-		int err = 0;
-		bool nomap;
-
-		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
-
-		err = __reserved_mem_init_node(rmem);
-		if (err != 0 && err != -ENOENT) {
-			pr_info("node %s compatible matching fail\n", rmem->name);
-			if (nomap)
-				memblock_clear_nomap(rmem->base, rmem->size);
-			else
-				memblock_phys_free(rmem->base, rmem->size);
-		} else {
-			phys_addr_t end = rmem->base + rmem->size - 1;
-			bool reusable =
-				(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
-
-			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
-				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
-				nomap ? "nomap" : "map",
-				reusable ? "reusable" : "non-reusable",
-				rmem->name ? rmem->name : "unknown");
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

