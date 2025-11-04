Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1A02BE053;
	Tue,  4 Nov 2025 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246302; cv=none; b=ar26M9manZZruFT7CjkRWvxmKrnQS2cI8kW0xiY7ZM2JRzoCdlmOYtUpxb0+ZGFv8Yu2TfxkGh5hmI6y32hS1qds5YmI2sGXk/87V5MyepyICSJSSr4RAk24rWueBFdhtNhvQbFTUCnoa7B+We9q0IJb2R+LtO6eNXdRUJNB13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246302; c=relaxed/simple;
	bh=XBHmA7qlPLX+kFD8ABJYT1oT3ouZH9Ry6KTyDXUW7qQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XzMSQQFxESrOy9ZW3WoYld76G+79YGo4DhcT5EFpgSl3kE4sjgvZg60nWf0GXtOrYYIgoJ1t1zDnUbmyPqsdbFPWKzYI57G1qOxhNdFjgBoTyNBv4U/+2sPWOTrqXPN56l3C2ACI+tl4Qf3LX7DFBj/0Kq1fKIqz/n2blYBaUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C5LqQKv8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C5LqQKv8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48gaET1458842;
	Tue, 4 Nov 2025 08:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ftPxWf+ghFV
	agk4AQyFCHqg3xEedQaBO5njDkQhWAAA=; b=C5LqQKv8sUKnMWGknpkqL2GE8jZ
	E1Ow/YxFAKeQ4qaoAib+vkXG1xyDcbqxUq38hkTVM4Vf15Fl/DCitnfcgEGyoK3q
	JJk1UM/4vd7fUtC1y8OgI3LKF6Ba+gaQuwI7zRAvlsBFxufIJpKLU02rifXdWaOv
	LaKSZcfWTep9xyLrVi/QXNGtbu095eaLQTIDfr39IaC7fkwAKXYqSQMuaeac5MoF
	q5KgjOjYDCmlxVSpdnQNfJulyPYThRBkT/saYapGuSpbMu178hxXti6CuziniZnB
	5ihskJ8W7H4rh2Z7CF0UGHJy1ulVxrVCz8XQT9bdZK066WQh+AZ5bosUlbA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70gea9h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:31 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A48pRhu016345;
	Tue, 4 Nov 2025 08:51:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a5b9m5517-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:27 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A48pQUb016290;
	Tue, 4 Nov 2025 08:51:27 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-charante-hyd.qualcomm.com [10.213.97.134])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5A48pQsO016277
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:26 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 389980)
	id ED8C75EF; Tue,  4 Nov 2025 14:21:25 +0530 (+0530)
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, saravanak@google.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: [PATCH 3/6] of: parse #<name>-cells property to get the cell count
Date: Tue,  4 Nov 2025 14:21:02 +0530
Message-Id: <d2caaf822fde3565e4e67158da751fc97afbaa92.1762235099.git.charan.kalla@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: aA3qhFG3oaAnLl2LhReDdYC0MDIdUDDN
X-Authority-Analysis: v=2.4 cv=bqBBxUai c=1 sm=1 tr=0 ts=6909be93 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=GmOhC2pl64uPHZqriGYA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA3MSBTYWx0ZWRfX0SiQ7Pyo1Xhf
 +JXzqwU0HXG/yTBJpCLkNoYH3EwBJyUDlsD7KzTDBxMc3WuK+TjOWOvZDO6JCCoJ1Dx0tw/Y4X7
 +TJM3hkQAGrY5Z09N7LgKcmqxpcj1713JNmgpFEpAScGa3fIMKlSIZKes/Up6x/dHdkXJgLkOWi
 Osn8Qh41SYF1HJr6RXij8YXXoU1k9R6qRkkgQ5xRWY67ffNf8AR2KPMyd+oxA9WfC2Ddc6zfXGJ
 +FPAXYQ0gbUCgMf29MpmayK6ezQi+fyEf2B56qApzXAxriMrjixtSjjaWRjylB+Y3EAcUbRAYiQ
 cvZBQYA4WdMjy8EWQ8n7dBqxUcc6T6PX8uwiewkgdZSt4XOQ4iPwU0UsbSLdK8vj3klLhi5Htcl
 Hm+JuTQt/WXEy0Ywp0d2jDJoAmY3SQ==
X-Proofpoint-GUID: aA3qhFG3oaAnLl2LhReDdYC0MDIdUDDN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040071

Implement the generic function, of_map_id_cell_count(), that can
parse and return the number of cells represented by #<name>-cells,
eg: #msi-cells, #iommu-cells.

Since the second argument of a property that is parsed by the
of_map_id() is always phandle, that represents a controller, probe
it to get the #<name>-cells property.

Further patches properly consume cell count value returned by this
wrapper and this patch just returns 1 irrespective of cells value, thus
no functional changes.

Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
---
 drivers/of/base.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 5e76abcc7940..e5ba8a318769 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2045,9 +2045,43 @@ int of_find_last_cache_level(unsigned int cpu)
 	return cache_level;
 }
 
+/**
+ * of_map_id_cell_count - parse the cell count.
+ *
+ * @map: pointer to the property data that needs to be translated, eg: msi-map/iommu-map.
+ * @map_name: name to identify the details of @map.
+ * @map_len: length of @map in bytes.
+ *
+ * Return: number of cells that the caller should be considered while parsing
+ * the @map. It is > 0 for success, 0 for failure.
+ */
 static int of_map_id_cell_count(const __be32 *map, const char *map_name,
 				int map_len)
 {
+	const char *cells_prop_name __free(kfree) = NULL;
+	struct device_node *node __free(device_node) = NULL;
+	u32 cells;
+	int ret;
+
+	/* map + 1 is a controller. */
+	node = of_find_node_by_phandle(be32_to_cpup(map + 1));
+	if (!node) {
+		pr_err("Failed to find controller node from phandle\n");
+		return 0;
+	}
+
+	/* get #<name>-cells property from #<name>-map */
+	cells_prop_name = kasprintf(GFP_KERNEL, "#%.*scells",
+			(int)strlen(map_name) - 3, map_name);
+	if (!cells_prop_name)
+		return 0;
+
+	ret = of_property_read_u32(node, cells_prop_name, &cells);
+	if (ret) {
+		pr_err("%pOF: Failed to read %s property\n", node, cells_prop_name);
+		return 0;
+	}
+
 	return 1;
 }
 
-- 
2.34.1

