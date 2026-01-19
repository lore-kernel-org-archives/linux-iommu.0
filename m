Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A418027
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768801796; cv=none; b=Y9gZoJfMxmY957Hr5Z3CarphRifCHJDdGnUxmjnDqtJ+Zu0A3Fi65LYBB7/vklfDNlHkYMOaSWlmmPysDUbNmn0bI3cY7yMM0T3tER0bJcMTY9In85sSqBXGY0G/gT1X6H3HuFtNRjH4/VU+yqja8NAL1x/baiaQfBmZ3HLiaVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768801796; c=relaxed/simple;
	bh=iwdsHKVL9GPdmO4V+Dt2jvWm4Pg02ex9UC1gJCPlM9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uyylFQpXiHB5D5IkbVJVBmhy5pyilP6D8lsi95PlW2pL7y+GOIbiRbdkjUNSXnhLCevBQkO2O8gZ+P9q1DvVXSilPNTJEjLPRFSYXtiA/KTIkd2BmKw6Fx7KNA0K+U8H/5qvuyFv7zycxhDHAfGhRBH4SXE8TmLcD2S1fbT/V+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NRe0syI7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NRe0syI7"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60IEoauK3858098;
	Mon, 19 Jan 2026 05:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1xqybe8swxwjhf4pFqmy1gX9JZ0OHyLRIhI
	q/eezr2Q=; b=NRe0syI7Z06DjpwUBOWDYxjy8VXAThIsaYDewEIS58CjpgFqVVm
	us+dbBB6v7gO88FJ7PTYUDL2ooekqOyf8LEx8YKHPNg3BAXZOV2RBkY4uOm+kyuh
	m7FzAGquvXDE7qtUP/gTCHN6XbWfCjvJolmdEiel4AUvIphieuGoFRgdvWttm75L
	gP56Ch14crefCJahwptTABm9pdObmUGiBdwtg/+oMvQTdL9N+YMnsEuzQdErKEuq
	65+oQbSq6nZu6WTGK5IhgboWtTRdgXEWE2V2K3yVQdrREnLi9a/gS14OVOGUrUUL
	xERh/caCvqStHeyLh7iOvhv5Or0Iyj0JuyQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br1e5kysw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 05:49:47 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60J5nhdF031676;
	Mon, 19 Jan 2026 05:49:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gkwrjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 05:49:43 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60J5nhde031669;
	Mon, 19 Jan 2026 05:49:43 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-bvisredd-hyd.qualcomm.com [10.147.240.98])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60J5nhM5031668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 05:49:43 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4559132)
	id 1C05D58F; Mon, 19 Jan 2026 11:19:42 +0530 (+0530)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
To: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
        m.szyprowski@samsung.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [PATCH] dma-iommu: Introduce API to reserve IOVA regions for dynamically created devices
Date: Mon, 19 Jan 2026 11:19:36 +0530
Message-Id: <20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA0NSBTYWx0ZWRfX1N/t9NvrqWAZ
 fs5pCkcjGNZg9T/4t/PTarwJWZlPqQ/vDwu6BMKjbBX7KpFD26yM+R3CRHH/tqymtzJICe+GWbW
 e0fim+cJfVr1eX/xyIKIi+kzGr4rYLqFmqQtQx4ihHI3K2sF42fl43VHL3jdQJ6uSU8ALcLfOr3
 qRmYRtw5+l0y3HVaZ3o03oFeaz9NrlDw9MVRhQn+7PtNdu/aXHA9r7C/7CVEEIBYpXN4bX+cAq2
 Vqvi9Rar3V8y1rgOE8JDzEvXgXDtKEq+jJ2ABn9+YgGO51Q4k3k2kingMtbQoD6tl8f7VnuiJyr
 IlM1eK4IUR9/MyqswyqVNbTbIzvtjbLy0YtKtKHvbTJ41K/3F4VNqMkWvIkTC9dfQHRCfrteuBb
 Yx4qnQNTLbK9K6QsxPldDJAqfVtSkzDzWLgKaTgtD4GoEPEosAycKnjL/B32qZ3y7fUmfKJ1GMz
 OPqMGg/FVLg7MktaC8Q==
X-Proofpoint-GUID: n9C8zGnuwnpTJ-sCoCvJinfPDRm0mlsg
X-Authority-Analysis: v=2.4 cv=U5yfzOru c=1 sm=1 tr=0 ts=696dc5fb cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QMkpMWH4AvK_Fj9H1hwA:9
X-Proofpoint-ORIG-GUID: n9C8zGnuwnpTJ-sCoCvJinfPDRm0mlsg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190045

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
Link: https://lore.kernel.org/all/20251220023555.3017456-1-busanna.reddy@oss.qualcomm.com/
---
 drivers/iommu/dma-iommu.c   | 44 +++++++++++++++++++++++++++++++++++++
 include/linux/dma-mapping.h |  7 ++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index aeaf8fad985c3..baee119e1c277 100644
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
index 29973baa05816..75b65160a37f3 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -347,6 +347,8 @@ static inline bool dma_use_iova(struct dma_iova_state *state)
 	return state->__size != 0;
 }
 
+int dma_iova_set_resv_region(struct device *dev, unsigned long start,
+			     unsigned long length);
 bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
 		phys_addr_t phys, size_t size);
 void dma_iova_free(struct device *dev, struct dma_iova_state *state);
@@ -366,6 +368,11 @@ static inline bool dma_use_iova(struct dma_iova_state *state)
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

