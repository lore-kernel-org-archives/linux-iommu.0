Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115F236435;
	Tue,  4 Nov 2025 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246302; cv=none; b=sPLhVYmthN5WtLXOIjQsRbhg9WDcxJkXEKLQOdZpps9oTrd2M621MjxaGOOe9WUuYgG7dmL4W8b5VIJScgmxKnNbtM2pIfPL4TR7I1zT3BsO1PMiiI7rK5DrXfmmPAxFQFEPyVDeu+UIDqO6j0UnZtLYGNInep6W4FsMsn63oQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246302; c=relaxed/simple;
	bh=XCY0Z71BdTxrrSgzNHFZhGpfRPzUHeTVmW322U6dziE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xd864tAwIm4oAa5jN9RfIssxLHYt44wVbuc8CGKmePTvhM36mtMfKOJyH3W04lMPRXTsFODa7aKca06mKhSJJvPKcbzqw8dcUlMBuoAOMC6WvPG+ZFxXbomMp0A3fldX7EJfkwk42E/fuTAUQN0u2VL3WW1Pv+ONched+WfVBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SLwv7PN3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SLwv7PN3"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48hLuT1538222;
	Tue, 4 Nov 2025 08:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FY5KN/Z4hUL
	a2oDzKHYZj3toI3qk0xKEi+95itkuq5U=; b=SLwv7PN3TxcEC8JhJIEShnDbNLq
	UoX+uLlZmoikBiXigxOUywXE6iZj/NePyUj6OLUG2lk4SMLk8hnF385nDmOBx7X3
	8QbaGPORWaBiDMD6XTDFs1TbN3DVBEHVQQfFnVygxQn3VqW6MH9eWk9DPZ7sj+8N
	cE00oNgKpaJcLg6UVFH3gEtILa8lv8lQhwYrkpWnJRMPRbg9BRp0WIaTGH046Z5T
	bISIxTie/VNhOB6LzZ+GVci4O4cMdV85M4j3bPtQh1pz/vm5JW+kp2b0gAZuy734
	XbsFs/zAWHMqD1tnU8JvXBhrgZmFiyctxBgjJX4MSc7CGS9XmbO7+pDUlmg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6xjqtrwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:31 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A48pRxv016332;
	Tue, 4 Nov 2025 08:51:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a5b9m5514-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:28 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A48pQuQ016286;
	Tue, 4 Nov 2025 08:51:26 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-charante-hyd.qualcomm.com [10.213.97.134])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5A48pQoq016278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:26 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 389980)
	id F19D55F0; Tue,  4 Nov 2025 14:21:25 +0530 (+0530)
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, saravanak@google.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: [PATCH 4/6] of: detect and handle legacy iommu-map parsing
Date: Tue,  4 Nov 2025 14:21:03 +0530
Message-Id: <02f3524f5e3974e73223bda9f4d15cba322ba169.1762235099.git.charan.kalla@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
References: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
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
X-Proofpoint-GUID: zJlUc7ZesWvR0ms0IjDK-PpNLFzDfbeH
X-Proofpoint-ORIG-GUID: zJlUc7ZesWvR0ms0IjDK-PpNLFzDfbeH
X-Authority-Analysis: v=2.4 cv=criWUl4i c=1 sm=1 tr=0 ts=6909be94 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=UxKIiJim7WOWCxwSnxQA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA3MSBTYWx0ZWRfX6w1OZrlflcx3
 HP4C9hZx1aK1/c6zYS1Fqbbn5BRM2DUlYSMb2FHVoCfsJSVEYdksN6K6pC1EPxVVSTtGqizgUBT
 GyJ06SBYHtQEa1VUB8eD4LNyUFlpv+pO0EDYG5Z6AToS9+vW+2uKu8ScQXcIv4M9qBSGhmc/f5S
 0iBSr8sImRN2QhNPJuDM0o2uNcwoF9SqiwpMAHTn4nDg+FxipuMWLCu39o9DlAkxCC1g5M/EnVm
 vhELvPz/lbUuTQKOU/8J7WjaNQo61HQStGRBWXxSX2vtJ4GK1+N/lSBxjqoV3acOD/5eFMyvIH0
 +HwEUQhAYdTundzKmKcQ76WypT0oN9lOIRV+jgHq3xej289BaznuQuocmmeQVANSc4bCyAeknZp
 xDSu8EDtq5mrymsijNUCuSg8sETSJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040071

of_map_id currently ignores the value of #property-cells and assumes
it's always 1. iommu-map is one of the two currently known users (the
other being msi-map where such issues haven't showed up *so far*).
The arm-smmu-v2 bindings (as an example) allow 2 cells, leading to
the map containing incomplete data.

There have long existed DTs ignoring this loss, where the map only
contained the first cell, so care is taken to try and preserve
compatibility with these - the format for such occurences is as follows:

iommu-map = <FUNC_ID1 &iommu_provider cell1 length>,
	    <FUNC_ID2 &iommu_provider cell1 length>;

If this 'legacy' scheme is used, we can check whether there's exactly
4n entries in the array and if the second entry in each group of 4 is
(the same) phandle and length = 1[1]. The only outstanding case would be
if the iommu-map references two separate iommu providers, but that's
highly unlikely.

Implement the above logic to make passing more than one cell possible.

[1] https://lore.kernel.org/all/8d88cd9d-16e8-43f9-8eb3-89862da1d0c1@arm.com/

Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
---
 drivers/of/base.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index e5ba8a318769..997b2deb96f0 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2045,6 +2045,60 @@ int of_find_last_cache_level(unsigned int cpu)
 	return cache_level;
 }
 
+/**
+ * of_iommu_map_id_legacy_cell_count - Determine the cell count for iommu-map.
+ *
+ * @map: pointer to the iommu-map property data that needs to be translated.
+ * @map_len: length of @map in bytes.
+ * @cell_count: value of #iommu-cells.
+ *
+ * It is the legacy case where the tuple representing iommu-map is always
+ * multiple of 4 and #iommu-cells > 1.
+ *
+ * Return: > 0 for success, 0 for failure.
+ */
+static u32 of_iommu_map_id_legacy_cell_count(const __be32 *map, int map_len)
+{
+	u32 phandle1, phandle2;
+
+	phandle1 = be32_to_cpup(map + 1);
+
+	for (map_len -= 4 * sizeof(*map), map += 4; map_len > 0;
+		map_len -= 4 * sizeof(*map), map += 4) {
+		u32 len;
+
+		phandle2 = be32_to_cpup(map + 1);
+		len = be32_to_cpup(map + 3);
+		if (phandle1 != phandle2 || len != 1)
+			break;
+	}
+
+	if (!map_len)
+		return 1;
+
+	return 0;
+}
+
+/**
+ * of_iommu_map_id_cell_count - Determine the cell count for iommu-map parsing.
+ *
+ * @map: pointer to the iommu-map property that needs to be translated.
+ * @map_len: length of @map in bytes.
+ *
+ * Use #iommu-cells property while parsing iommu-map. Detect and use legacy
+ * case where iommu-map is parsed as if cells = 1.
+ *
+ * Return: number of cells that the caller should be considered while parsing
+ * the @map. It is > 0 for success, 0 for failure.
+ */
+static int of_iommu_map_id_cell_count(const __be32 *map, int map_len)
+{
+	if (map_len % 4 != 0)
+		return 0;
+
+	return of_iommu_map_id_legacy_cell_count(map, map_len);
+}
+
 /**
  * of_map_id_cell_count - parse the cell count.
  *
@@ -2082,7 +2136,10 @@ static int of_map_id_cell_count(const __be32 *map, const char *map_name,
 		return 0;
 	}
 
-	return 1;
+	if (cells > 1 && !strcmp(map_name, "iommu-map"))
+		return of_iommu_map_id_cell_count(map, map_len);
+
+	return cells;
 }
 
 /*
-- 
2.34.1

