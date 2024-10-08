Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2F179954
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425275; cv=none; b=jW32CPQAj9C3DW8aSGxijNBRHgoSlaGy5M0RPwztOtE8o6oxHYSnrHAXXbS2J/CTxFDO+22LVdoJcxmVcnCFdlcN1TcTFrM4o+wDJlOXNV9uhLQC1XdlTAKU5ON0OPtkS0dvUVr/o8SUuJQ2Ip27sRxCfdysq94m0dok53SPbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425275; c=relaxed/simple;
	bh=GK61cQ3mFSEWeMf+t1FMxrAGCvM8O5dxwMZJAPMq+tc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkN/03/JMlRZOk9oprdjHB7sVw3mb2YS3KVaZ5H6jlxBkLXA/9UStlSoFcKzT+g5JFrx/VxIHxykVEBaZuYPMkxAQ5g29rvMeWwBT1a0GhpEWXmg/xTFg74P2taK19+Jw/ASYLxjdK7AtBoHsIKD/7hSR9rsrCtlzwFtlPIKTog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kZeLUSL3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kZeLUSL3"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Ew9Tn029264;
	Tue, 8 Oct 2024 22:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	61KLYYbFXr/uwE+fC9yma3isXx1jdUM/pnhUeWSDiWs=; b=kZeLUSL3xRBhSm4e
	F61tQofG6E9H6vwxp4m5VD8d1TgTYlQIODq42U0wqv1mt8LRisNkVGrP7CrQbQ+U
	w3CIALNY1OMM6Zi5xRL2D0bdb9PFkKwD84PcGDsbBCdVwr/ohN25y0uWne26HzjW
	ljfZ1Pos/p6w1fGRmXRLbBZUqT0iFtRNcFME5kbvKUGwptq0NLsa7HbTeXyccabs
	E0tCEcQIyIHcoMGAaJFoYTz07qFa3nDMYE6EW0gfDwNa6g1Mj/PXUTF7Dpkct3bI
	ST0Duus3N3sxE94XLOolVex3dfYAvX6aVMF1mBvi2hzKVm1/q8phXwkn/ywbgIbG
	LT24rg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424yj02jn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 22:07:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 498M7gMK025189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 22:07:43 GMT
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
Subject: [PATCH v10 2/2] of: reserved_mem: Add code to dynamically allocate reserved_mem array
Date: Tue, 8 Oct 2024 15:06:24 -0700
Message-ID: <20241008220624.551309-3-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: qZlN18c2mZHCgcPGFSAGtLAWnROSEtfY
X-Proofpoint-ORIG-GUID: qZlN18c2mZHCgcPGFSAGtLAWnROSEtfY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080141

The reserved_mem array is statically allocated with a size of
MAX_RESERVED_REGIONS(64). Therefore, if the number of reserved_mem
regions exceeds this size, there will not be enough space to store
all the data.

Hence, extend the use of the static array by introducing a
dynamically allocated array based on the number of reserved memory
regions specified in the DT.

On architectures such as arm64, memblock allocated memory is not
writable until after the page tables have been setup. Hence, the
dynamic allocation of the reserved_mem array will need to be done only
after the page tables have been setup.

As a result, a temporary static array is still needed in the initial
stages to store the information of the dynamically-placed reserved
memory regions because the start address is selected only at run-time
and is not stored anywhere else.
It is not possible to wait until the reserved_mem array is allocated
because this is done after the page tables are setup and the reserved
memory regions need to be initialized before then.

After the reserved_mem array is allocated, all entries from the static
array is copied over to the new array, and the rest of the information
for the statically-placed reserved memory regions are read in from the
DT and stored in the new array as well.

Once the init process is completed, the temporary static array is
released back to the system because it is no longer needed. This is
achieved by marking it as __initdata.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/of_reserved_mem.c | 63 +++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 2011174211f9..45517b9e57b1 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -27,7 +27,9 @@
 
 #include "of_private.h"
 
-static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
+static struct reserved_mem reserved_mem_array[MAX_RESERVED_REGIONS] __initdata;
+static struct reserved_mem *reserved_mem __refdata = reserved_mem_array;
+static int total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
 static int reserved_mem_count;
 
 static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
@@ -55,6 +57,50 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	return err;
 }
 
+/*
+ * alloc_reserved_mem_array() - allocate memory for the reserved_mem
+ * array using memblock
+ *
+ * This function is used to allocate memory for the reserved_mem
+ * array according to the total number of reserved memory regions
+ * defined in the DT.
+ * After the new array is allocated, the information stored in
+ * the initial static array is copied over to this new array and
+ * the new array is used from this point on.
+ */
+static void __init alloc_reserved_mem_array(void)
+{
+	struct reserved_mem *new_array;
+	size_t alloc_size, copy_size, memset_size;
+
+	alloc_size = array_size(total_reserved_mem_cnt, sizeof(*new_array));
+	if (alloc_size == SIZE_MAX) {
+		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);
+		return;
+	}
+
+	new_array = memblock_alloc(alloc_size, SMP_CACHE_BYTES);
+	if (!new_array) {
+		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -ENOMEM);
+		return;
+	}
+
+	copy_size = array_size(reserved_mem_count, sizeof(*new_array));
+	if (copy_size == SIZE_MAX) {
+		memblock_free(new_array, alloc_size);
+		total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
+		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);
+		return;
+	}
+
+	memset_size = alloc_size - copy_size;
+
+	memcpy(new_array, reserved_mem, copy_size);
+	memset(new_array + reserved_mem_count, 0, memset_size);
+
+	reserved_mem = new_array;
+}
+
 static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem);
 /*
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
@@ -64,7 +110,7 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
-	if (reserved_mem_count == ARRAY_SIZE(reserved_mem)) {
+	if (reserved_mem_count == total_reserved_mem_cnt) {
 		pr_err("not enough space for all defined regions.\n");
 		return;
 	}
@@ -193,6 +239,9 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
 		return;
 	}
 
+	/* Attempt dynamic allocation of a new reserved_mem array */
+	alloc_reserved_mem_array();
+
 	if (__reserved_mem_check_root(node)) {
 		pr_err("Reserved memory: unsupported node format, ignoring\n");
 		return;
@@ -232,7 +281,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 int __init fdt_scan_reserved_mem(void)
 {
 	int node, child;
-	int dynamic_nodes_cnt = 0;
+	int dynamic_nodes_cnt = 0, count = 0;
 	int dynamic_nodes[MAX_RESERVED_REGIONS];
 	const void *fdt = initial_boot_params;
 
@@ -255,6 +304,8 @@ int __init fdt_scan_reserved_mem(void)
 		uname = fdt_get_name(fdt, child, NULL);
 
 		err = __reserved_mem_reserve_reg(child, uname);
+		if (!err)
+			count++;
 		/*
 		 * Save the nodes for the dynamically-placed regions
 		 * into an array which will be used for allocation right
@@ -269,11 +320,15 @@ int __init fdt_scan_reserved_mem(void)
 	}
 	for (int i = 0; i < dynamic_nodes_cnt; i++) {
 		const char *uname;
+		int err;
 
 		child = dynamic_nodes[i];
 		uname = fdt_get_name(fdt, child, NULL);
-		__reserved_mem_alloc_size(child, uname);
+		err = __reserved_mem_alloc_size(child, uname);
+		if (!err)
+			count++;
 	}
+	total_reserved_mem_cnt = count;
 	return 0;
 }
 
-- 
2.34.1

