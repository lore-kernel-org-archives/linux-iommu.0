Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACADD3B19F
	for <iommu@lists.linux.dev>; Sat, 20 Dec 2025 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766198264; cv=none; b=bP7OX5idLqkcsSfF00qgC0fNUbhF6lpm4lo4M5F6tORRIGaUTDn6G5mY3L/jO1eqnR9DAtA3xByBkoe/r9FCCLu37UwfQp8UehpwPpr7gR8GMGjlu6OZiF+iQPPRo0K7Qeuf4l4wAlAJft0Mttc1H3nvu/t5YXOCrvbA/Wr7Wb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766198264; c=relaxed/simple;
	bh=6tcZDP34K/Fphfh/cEJn5CAXZIzMsbzrxwqkyQaf6mg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pobeQb7q+QorucNCNbh8Atwqql9DsNskOzZsqj/bfE3tmw4/7kPi5kkfitlTHh+rNhrEXOUPBwKD0zgcTGCIFx3s5MQeby7xoB8HoTLY/D8FhdUr+NBRDNKWDb7jSVA10NS5RQ0+wrucQR0oU9WTkcoNRkzSjrazI515U96604g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QkCRL64s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QkCRL64s"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJNNBIA2702425;
	Sat, 20 Dec 2025 02:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=yhJ44J6wwoHw5J0H8UeBAMbgQll9zeeCNxS
	SrKzr55o=; b=QkCRL64sUKmVdLCqEopmZCMlbIwAd7KMng4N/NkYnMWs6N1QdQm
	FzjTAZXenVDzgbK0cJxHKzAJiyQ2lR/i9JaWU+lsityMnqjNF0Yjp2HvmUqWP9NQ
	ipLC2BkfYM7IXnUtuvLQ43CLlHg5l10XQdZ1DE/1jOlCGmcvH+CiJUH3V6I/4lCJ
	OAZ3drN7yFOMhmYxtMEnQCzX1iJzxBhNY9eSw6MfBUaP5IsAdbhw1QTv0dwdc/Dt
	eX4y88eAi9oE/LL8no42N55bUJVmNJC0tm5gQ0oYsdWm2EwnzV77YKiOoV2sC608
	hOcTvNGdqfcYwOkWu8Uz/AfceYeh+eptWyg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5frq8c5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Dec 2025 02:37:28 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BK2bOx0012619;
	Sat, 20 Dec 2025 02:37:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4b3t8d2c83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Dec 2025 02:37:24 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BK2bODQ012613;
	Sat, 20 Dec 2025 02:37:24 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-bvisredd-hyd.qualcomm.com [10.147.240.98])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 5BK2bOvU012612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Dec 2025 02:37:24 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4559132)
	id 799295AA; Sat, 20 Dec 2025 08:07:23 +0530 (+0530)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
To: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
        m.szyprowski@samsung.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [RFC PATCH] dma-iommu: Introduce API to reserve IOVA regions for dynamically created devices
Date: Sat, 20 Dec 2025 08:05:55 +0530
Message-Id: <20251220023555.3017456-1-busanna.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9y9Ih05kc91ndsAggI_COoMTj3zSCIuR
X-Proofpoint-ORIG-GUID: 9y9Ih05kc91ndsAggI_COoMTj3zSCIuR
X-Authority-Analysis: v=2.4 cv=Mu9fKmae c=1 sm=1 tr=0 ts=69460be8 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=QMkpMWH4AvK_Fj9H1hwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIwMDAyMCBTYWx0ZWRfX2qY9tOEks8rQ
 MyI9h/JeOO6LRBr67Dulr+eBURXKKw/ZjTEna2wRxgi2zCQBobSY8NuIq+zN2S2OcDXt/gcFZSL
 hs9cenC/ylUdGr6OfYkprCwYKR9TotlcbIFawvGEXaaF9bOqUYjDJXXEMk0LihqbLpYh4VUwacf
 sv4vtBf0eZsoJzzKHA2vBedra3Al7AQYC6umaESktLgCTX4Ic6F7X89osTP3CaNNkHoYUpbOPhJ
 +Y17XHm9GKGps/x0aTMHKDEoE9SYRLnFP2ckGsyWHGN0fCuy4k+Ci09KZTgwekD/E+lE6s0RMZB
 4hZ7dqGm6ZDTNjPx9J2UuhLjF44zMUiTW9Fa18CsF6H5BSN2o3kbjT8RN2IeDXy7NCkwgIss/ob
 3oa7OqMaW/lsWCg6RIYNJEJrLpQLVaNBDbhxTIsC6dzTX9xEJfKh3ERZRzQuj6mCRysude/DFKf
 yOxvvUPbivcvLeE3GKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_08,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512200020

Drivers can create child devices dynamically. These child devices often
inherit parent device tree node, including its reserved iommu-address
ranges. While device tree can declare the multiple iommu-address ranges,
they still apply uniformly to any child inheriting the parent OF node.

This creates a limitation when child requires a different iommu-address
range than its parent, as device tree cannot express the reservation per
child.

Example layout and use case:
----------------------------
A multimedia subsystem with multiple child devices and distinct ranges:

    +-----------------------------------------------------------+
    | Device A reserved region (256 MB)                         |
    | 0x00000000 - 0x10000000                                   |
    +-----------------------------------------------------------+
    | Device B reserved region (512 MB)                         |
    | 0x00000000 - 0x20000000                                   |
    +-----------------------------------------------------------+
    | Device C reserved region (600 MB)                         |
    | 0x00000000 - 0x25800000                                   |
    +-----------------------------------------------------------+
    | Other reserved regions                                    |
    +-----------------------------------------------------------+

If we add Device C's reserved range (0x0 to 0x025800000) into iommu
address range into device tree and assign that OF node to Device B
and C, it wastes memory:
- Device A wastes ~344 MB
- Device B wastes ~88 MB

To avoid this, drivers can use the introduced API to set their device
specific IOVA region at runtime, ensuring the DMA mapping without
unnecessary address space reservation.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/iommu/dma-iommu.c   | 44 +++++++++++++++++++++++++++++++++++++
 include/linux/dma-mapping.h |  7 ++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c92088855450a..02c54cddf9417 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1743,6 +1743,50 @@ size_t iommu_dma_max_mapping_size(struct device *dev)
 	return SIZE_MAX;
 }
 
+/**
+ * dma_iova_set_resv_region - Set a reserved region in the IOVA space
+ * @dev: Device to set the reserved region for
+ * @start: Start of the reserved region
+ * @length: Length of the reserved region
+ *
+ * This function enables drivers to set device specific reservations at
+ * runtime, which is particularly useful for dynamically created child
+ * devices that requires distinct IOVA ranges than parent.
+ *
+ * Returns:
+ *  0        - Success
+ *  -ENODEV  - No valid IOMMU DMA domain for the device
+ *  -EINVAL  - Invalid domain or cookie type for this operation
+ *  -ENOMEM  - Failed to reserve the requested range
+ */
+int dma_iova_set_resv_region(struct device *dev, unsigned long start,
+			     unsigned long length)
+{
+	struct iommu_dma_cookie *cookie;
+	struct iommu_domain *domain;
+	struct iova_domain *iovad;
+	unsigned long lo, hi;
+
+	domain = iommu_get_dma_domain(dev);
+	if (!domain || domain->type != IOMMU_DOMAIN_DMA)
+		return -ENODEV;
+
+	cookie = domain->iova_cookie;
+	if (!cookie || domain->cookie_type != IOMMU_COOKIE_DMA_IOVA)
+		return -EINVAL;
+
+	iovad = &cookie->iovad;
+
+	lo = iova_pfn(iovad, start);
+	hi = iova_pfn(iovad, start + length - 1);
+
+	if (!reserve_iova(iovad, lo, hi))
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dma_iova_set_resv_region);
+
 /**
  * dma_iova_try_alloc - Try to allocate an IOVA space
  * @dev: Device to allocate the IOVA space for
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index aa36a0d1d9df6..c89147cf92231 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -339,6 +339,8 @@ static inline bool dma_use_iova(struct dma_iova_state *state)
 	return state->__size != 0;
 }
 
+int dma_iova_set_resv_region(struct device *dev, unsigned long start,
+			     unsigned long length);
 bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
 		phys_addr_t phys, size_t size);
 void dma_iova_free(struct device *dev, struct dma_iova_state *state);
@@ -358,6 +360,11 @@ static inline bool dma_use_iova(struct dma_iova_state *state)
 {
 	return false;
 }
+static inline int dma_iova_set_resv_region(struct device *dev, unsigned long start,
+					   unsigned long length)
+{
+	return -ENODEV;
+}
 static inline bool dma_iova_try_alloc(struct device *dev,
 		struct dma_iova_state *state, phys_addr_t phys, size_t size)
 {
-- 
2.34.1

