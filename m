Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219AA199FCD
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035386; cv=none; b=KLF6GCRwIc8VjbX4ZuVRY3jkzqP48IqqxCUTSyDhzs4MRjcc6mm4ZWC6g6vmD8q+67ql4C7M4HSeFbBiFRS5dtyuA81mISi4EdeaQPzyu9wQMoXig5vsOEGWXa5bIJ+3AdXsXE5dJYhYMb6M7rzHO0sYxZYtis5oy3r5ha9meu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035386; c=relaxed/simple;
	bh=Sca1w6+M1Fa4xga2IU+7IGr5WdrMm9HCmGgNEibQRIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFsjMeyidozKBBgymOPPz3AYU2HoLT6NIx4p+5Q27aIZchAyL08QTxYUvp7Y9fUFbP3e43pqI0Kmjtgjl00C3/0TKgWsbskuam40xWWQ20Lk1zT6st41PgNo64/p0PhFSjUV4D2UpdEF6yItzrTaOMkaoFtsN0F7bMPRS6gyl2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K7BEYuBh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K7BEYuBh"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UFBfMW010668;
	Fri, 30 Aug 2024 16:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QDcyp35+X/FDNH02/gmXctPetcl8NyWSGu4roXmGmf8=; b=K7BEYuBhPKxRDY8f
	FDEAwmhyIwby7EXcUE6+AqeLvM8fiovzyCNjW/V/i24cwKhlNYyhUYjGu6d/aDgv
	Ltv2S1NWtuFyNF1LoPhnryJs93JuBdInIanaPPACPcMVs7S5XO38LPW79qagv80/
	oJ8HgtSXt/eTieOPgQbsEGLNs1qDaFIbHFb4IEy520mc27im25o1/CQGOnk6Iw/+
	EyVWv6yxMjNVN36UiFl3SPBTMtLnj2qu2vx/AqhJCVS8B732VA19pn+yV9hQ9CFA
	fPVW1b3lGE6MfqrHdk3E4+vhO9IFWK5CJS1b6JCa/s5by0qx5medVKd/MXK74gUS
	vCSPng==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419pv0spr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 16:29:35 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47UGTXYC011671
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 16:29:33 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 30 Aug 2024 09:29:30 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <robh@kernel.org>
CC: <andy@black.fi.intel.com>, <aisheng.dong@nxp.com>,
        <catalin.marinas@arm.com>, <devicetree@vger.kernel.org>, <hch@lst.de>,
        <iommu@lists.linux.dev>, <kernel@quicinc.com>, <klarasmodin@gmail.com>,
        <linux-kernel@vger.kernel.org>, <m.szyprowski@samsung.com>,
        <quic_obabatun@quicinc.com>, <robin.murphy@arm.com>,
        <saravanak@google.com>, <will@kernel.org>
Subject: [PATCH v8 2/2] of: reserved_mem: Add code to dynamically allocate reserved_mem array
Date: Fri, 30 Aug 2024 09:28:57 -0700
Message-ID: <20240830162857.2821502-3-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830162857.2821502-1-quic_obabatun@quicinc.com>
References: <20240830162857.2821502-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7erGiJ-mlvAvMBf9NB_2-aAoi1xa05Wm
X-Proofpoint-ORIG-GUID: 7erGiJ-mlvAvMBf9NB_2-aAoi1xa05Wm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300126

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
 drivers/of/of_reserved_mem.c | 68 +++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index a4487ee6c5ca..7452a2af7f1b 100644
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
 /*
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
@@ -63,7 +109,7 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
-	if (reserved_mem_count == ARRAY_SIZE(reserved_mem)) {
+	if (reserved_mem_count == total_reserved_mem_cnt) {
 		pr_err("not enough space for all defined regions.\n");
 		return;
 	}
@@ -202,6 +248,13 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
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
 
@@ -236,7 +289,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 int __init fdt_scan_reserved_mem(void)
 {
 	int node, child;
-	int dynamic_nodes_cnt = 0;
+	int dynamic_nodes_cnt = 0, count = 0;
 	int dynamic_nodes[MAX_RESERVED_REGIONS];
 	const void *fdt = initial_boot_params;
 
@@ -259,6 +312,9 @@ int __init fdt_scan_reserved_mem(void)
 		uname = fdt_get_name(fdt, child, NULL);
 
 		err = __reserved_mem_reserve_reg(child, uname);
+		if (!err)
+			count++;
+
 		/*
 		 * Save the nodes for the dynamically-placed regions
 		 * into an array which will be used for allocation right
@@ -273,11 +329,15 @@ int __init fdt_scan_reserved_mem(void)
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

