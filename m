Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516F714F105
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 23:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480014; cv=none; b=eZbSfWdtjQyQhGaYNKeyARvBbPqmToE+U+zfOffGWJjVD7zBjq1fmL8KM3h9xQwbM+5Dh74D3QPTRqELB3+J0CHSWW/BGIUEe1D/9PKCs1Pn64N6w88DC5vqdTIAoIc5wY/MdBCf/DFaW7zMGKtgeQEqC0Lfv3iwtTj6HhJebOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480014; c=relaxed/simple;
	bh=i4QsWEm3fx5o3M+X1H/cVzucI7u4tAyUy4uUwXPWnn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZY+VjP0acqL2onrGHezFe2HQWDNm9B8AmT5fYUO1J3TdsSIm1ydR7tJCfmgQc3ZxSb12eRJl1/thBlKFcWoBy83van9MYnIpMEQMbHe7m6rnMbFIapyv/iHro138uoIRweuMBQACY4XywGJm4ykEeDLbUUqTufU994y6k7fdxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V4UWKXIA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V4UWKXIA"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468AVBgH024152;
	Mon, 8 Jul 2024 23:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UX1TM2/EIhsljzM5TeftzHEHG+pICaapDVK47aGRIIM=; b=V4UWKXIA8phgWIpd
	M8Y0D+anpCLdhNjq0MRFqFwBS2EJHU68c73GX7QOZEA/gi07HfDyUjgLTpBEKFvv
	PpOIX3y+o3w7UI3Tw4QmW+X3FXRgiLHoOi6h8zSzWLVVNI55u9JfBGqO5BIniuII
	m4epHyLOkKdM8EehfzyI/9on/BQgUj3aywg1e8b9oRK9w/wfoD3ao/0wDNJ88Ywb
	2lvQrnAha0+rcDmW07WyN3D8Ok9z7ufjb7ldXRgYcRfwjeHnqeH0UbK0xeDb9Zda
	VZtIzdgwF/t4LO7UHpg1jIuxGpyM3/VELYvzJHbHgM0HzUuY7pkP2LGaES6tzfC0
	zCDYdQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x0t4y06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 23:06:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 468N6ibj002216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 23:06:44 GMT
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
Subject: [PATCH 2/4] Revert "of: reserved_mem: Rename fdt_* functions to refelct the change from using fdt APIs"
Date: Mon, 8 Jul 2024 16:06:11 -0700
Message-ID: <20240708230613.448846-3-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: 4ALZVNI4jzd8LHgY3Tywp5F2VrZqQnHl
X-Proofpoint-ORIG-GUID: 4ALZVNI4jzd8LHgY3Tywp5F2VrZqQnHl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080171

This reverts commit fec32ea96dd90bf0af97e001f380d4a240013aa0.

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
 drivers/of/fdt.c             |  2 +-
 drivers/of/of_private.h      |  2 +-
 drivers/of/of_reserved_mem.c | 22 +++++++++++-----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 9cde2abd2fc0..e0f93886cc17 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1239,7 +1239,7 @@ void __init unflatten_device_tree(void)
 	unittest_unflatten_overlay_base();
 
 	/* initialize the reserved memory regions */
-	of_init_reserved_mem();
+	fdt_init_reserved_mem();
 }
 
 /**
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 01b33c4b1e9f..32b10d45b558 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -181,7 +181,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 #endif
 
 int fdt_scan_reserved_mem(void);
-void of_init_reserved_mem(void);
+void fdt_init_reserved_mem(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index eb54490a0a11..784a49a27e7f 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -98,10 +98,10 @@ static void __init alloc_reserved_mem_array(void)
 }
 
 /*
- * of_reserved_mem_save_node() - save fdt node for second pass initialization
+ * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
-static void __init of_reserved_mem_save_node(struct device_node *node, const char *uname,
-					     phys_addr_t base, phys_addr_t size)
+static void __init fdt_reserved_mem_save_node(struct device_node *node, const char *uname,
+					      phys_addr_t base, phys_addr_t size)
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
@@ -202,16 +202,16 @@ static int __init __fdt_reserved_mem_check_root(unsigned long node)
 }
 
 /**
- * of_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
+ * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
  * reserved memory regions.
  *
  * This function is used to scan through the DT and store the
  * information for the reserved memory regions that are defined using
  * the "reg" property. The region node number, name, base address, and
  * size are all stored in the reserved_mem array by calling the
- * of_reserved_mem_save_node() function.
+ * fdt_reserved_mem_save_node() function.
  */
-static void __init of_scan_reserved_mem_reg_nodes(void)
+static void __init fdt_scan_reserved_mem_reg_nodes(void)
 {
 	struct device_node *node, *child;
 	phys_addr_t base, size;
@@ -244,7 +244,7 @@ static void __init of_scan_reserved_mem_reg_nodes(void)
 		size = res.end - res.start + 1;
 
 		if (size)
-			of_reserved_mem_save_node(child, uname, base, size);
+			fdt_reserved_mem_save_node(child, uname, base, size);
 	}
 }
 
@@ -442,7 +442,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-	of_reserved_mem_save_node(NULL, uname, base, size);
+	fdt_reserved_mem_save_node(NULL, uname, base, size);
 	return 0;
 }
 
@@ -526,15 +526,15 @@ static void __init __rmem_check_for_overlap(void)
 }
 
 /**
- * of_init_reserved_mem() - allocate and init all saved reserved memory regions
+ * fdt_init_reserved_mem() - allocate and init all saved reserved memory regions
  */
-void __init of_init_reserved_mem(void)
+void __init fdt_init_reserved_mem(void)
 {
 	int i;
 
 	alloc_reserved_mem_array();
 
-	of_scan_reserved_mem_reg_nodes();
+	fdt_scan_reserved_mem_reg_nodes();
 
 	/* check for overlapping reserved regions */
 	__rmem_check_for_overlap();
-- 
2.34.1

