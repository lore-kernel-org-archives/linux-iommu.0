Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064B13DDD2
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935837; cv=none; b=uHYzQagTomM64gy0nJAVOPZmDhe33y/1CDyHMpntaVbGA2DDtaL56p4MXUn013X8f57RPB2iNugQpJnfH+epY27X43uVKcXNnK8wnggNHuncvWn7q4klHToDaJMKblPOuLMmS1UcYtaH8Wab1btrr3qikxr/1YpiBU+wZdLapEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935837; c=relaxed/simple;
	bh=f/wMmYi6UZRy8QxejzPHagMItqPx2bLrAyn1NdDAVOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XywVnyME+GPEOe56b4rkdckGyMnDTwloRSMgyqnqFuDqRjPzZVuLQU1TMBDbLUtuQ3AJEyS2ycESBgXHVhSBfpXizSARkMhulnwxH9byh2zCEHHc8KmiJRGe6Jv2WRr81LRPlGk7Z1iryzVU+MKuX37j5KFv7SRCIP1rq/W3vWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WXl+ZJYg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WXl+ZJYg"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SK210b023160;
	Tue, 28 May 2024 22:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TYrVUge4E6wCMx/VszD8q2aUwvXf9s6S+k2yI28riOs=; b=WXl+ZJYgDwQTysNH
	+9rQc0HsxPPP64UOSj8cXWCj3GEccCCJbWezT1TeLw/y5vVs6nLJsKHBXzLjzDsY
	Ka8kwneJp9Wuvnf5Ztz6oS+sIamniGIOfiqpkbyW7M1RbymCKrBML+cSGPQ1Ca7R
	XVY4HjGGRoPh2xcv13RezdN35zmZb752M/YsX9mmDptc1l5HC0FGVcNNG62wrPhb
	95L0Zj3Nc67agfEer7wESlBGpQN9q8vRckIGVpKZu3ZlOQUKrL6MlNzZoyIRllXa
	eTF7AKYJqmM0kF4g/ebSrrnhBckrRuk61q8nWD66qxpiGsgQxGfqZ03NaNieifka
	EH4q/g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2pqgre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 22:37:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44SMb7WR012676
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
Subject: [PATCH v6 4/4] of: reserved_mem: Rename fdt_* functions to refelct the change from using fdt APIs
Date: Tue, 28 May 2024 15:36:50 -0700
Message-ID: <20240528223650.619532-5-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: wyv7XFpnzhLojwKF4wVgPuz5z9ucbnPR
X-Proofpoint-ORIG-GUID: wyv7XFpnzhLojwKF4wVgPuz5z9ucbnPR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280167

Rename the relevant reserved_mem functions to account for them no longer
using the flattened devicetree (fdt) APIs.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c             |  2 +-
 drivers/of/of_private.h      |  2 +-
 drivers/of/of_reserved_mem.c | 22 +++++++++++-----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 527e6bc1c096..79b7348ea7a4 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1259,7 +1259,7 @@ void __init unflatten_device_tree(void)
 	unittest_unflatten_overlay_base();
 
 	/* initialize the reserved memory regions */
-	fdt_init_reserved_mem();
+	of_init_reserved_mem();
 }
 
 /**
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index d889b8c17ca3..7a744336084b 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -178,7 +178,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 #endif
 
 int fdt_scan_reserved_mem(void);
-void fdt_init_reserved_mem(void);
+void of_init_reserved_mem(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 05283cd24c3b..e326bbef0a13 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -98,10 +98,10 @@ static void __init alloc_reserved_mem_array(void)
 }
 
 /*
- * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
+ * of_reserved_mem_save_node() - save fdt node for second pass initialization
  */
-static void __init fdt_reserved_mem_save_node(struct device_node *node, const char *uname,
-					      phys_addr_t base, phys_addr_t size)
+static void __init of_reserved_mem_save_node(struct device_node *node, const char *uname,
+					     phys_addr_t base, phys_addr_t size)
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
@@ -231,16 +231,16 @@ static int __init of_reserved_mem_check_root(struct device_node *node)
 }
 
 /**
- * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
+ * of_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
  * reserved memory regions.
  *
  * This function is used to scan through the DT and store the
  * information for the reserved memory regions that are defined using
  * the "reg" property. The region node number, name, base address, and
  * size are all stored in the reserved_mem array by calling the
- * fdt_reserved_mem_save_node() function.
+ * of_reserved_mem_save_node() function.
  */
-static void __init fdt_scan_reserved_mem_reg_nodes(void)
+static void __init of_scan_reserved_mem_reg_nodes(void)
 {
 	struct device_node *node, *child;
 	phys_addr_t base, size;
@@ -278,7 +278,7 @@ static void __init fdt_scan_reserved_mem_reg_nodes(void)
 		size = res.end - res.start + 1;
 
 		if (size)
-			fdt_reserved_mem_save_node(child, uname, base, size);
+			of_reserved_mem_save_node(child, uname, base, size);
 	}
 }
 
@@ -476,7 +476,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-	fdt_reserved_mem_save_node(NULL, uname, base, size);
+	of_reserved_mem_save_node(NULL, uname, base, size);
 	return 0;
 }
 
@@ -560,15 +560,15 @@ static void __init __rmem_check_for_overlap(void)
 }
 
 /**
- * fdt_init_reserved_mem() - allocate and init all saved reserved memory regions
+ * of_init_reserved_mem() - allocate and init all saved reserved memory regions
  */
-void __init fdt_init_reserved_mem(void)
+void __init of_init_reserved_mem(void)
 {
 	int i;
 
 	alloc_reserved_mem_array();
 
-	fdt_scan_reserved_mem_reg_nodes();
+	of_scan_reserved_mem_reg_nodes();
 
 	/* check for overlapping reserved regions */
 	__rmem_check_for_overlap();
-- 
2.34.1

