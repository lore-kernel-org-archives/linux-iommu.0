Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EE5314A83;
	Tue,  4 Nov 2025 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246308; cv=none; b=iHwrAkWgNNbqs0hSHGqwPOkgA1oOd4i1fjtwsyqbGmj8zPUjwgMz4vVA1KjFh2hiHUKaz7XSwdRxSjsCmesAvdeWLgDN1EQT4at7NmjdT7V8AAJaiJ1mQ89pyYKJ2IwbetF1/mFX5jPg3Dd0leoigpY4iX11staqyCb1cCRIirs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246308; c=relaxed/simple;
	bh=mLruDlEZpcAE+IuTNq42rMPwrhABiGAhexansMamHZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZz6MqlCDDETlENJ7mxtTlr8oGK7Hvx3CicgVKkQh4szPIQ14q2uXpgPBGjserZ/EEthEBuppYkT8waM+QAfX+az/L3BO10MxU2vPmZ34mJekuwyj1M1grj24+U45vEH0wMFNR8ZD6IZPmAqBACXsofXSp3SgRXRfEZ80foYu0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TQnRYLbc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TQnRYLbc"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48g1O71539201;
	Tue, 4 Nov 2025 08:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+ZuRnhq5ccx
	yJ+X3JbRtjqSMLJfknP1ZPy17VyWbkSk=; b=TQnRYLbco6kPS++sz0Dazb62A8v
	Zom3I6s2Zvbw0DYjqu0qC+rTqvmSjAl/Q17eyLqMZnb/sx7xxxY96GSZA3KIOOS4
	QJ+8A3icG+cUrlP7pWBHBsOI9hZOi+PNcq6mI5+Wyz8kfbgHJJcWZi8QIwnt/bhd
	5ukQkZ27POdZPb6KicyjcvbETIWoiLsBayedu/sAStzm1kVUH7nL6iTY2z+DFGxf
	o/U7zyyAFCq1IhnZU4MphFk7gaxnLFhAMbza9EOyV7ah8GVOy8XgdGNJc8/Kcd1V
	DzSWMnNe7Aqg0CWGWjp+HNeR5tAe1LiYCuDnuqUjg8ObumbS1lp/3XY9VhA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a78eqs0vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:32 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A48pRxw016332;
	Tue, 4 Nov 2025 08:51:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a5b9m5516-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:28 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A48pQAK016288;
	Tue, 4 Nov 2025 08:51:26 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-charante-hyd.qualcomm.com [10.213.97.134])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5A48pQZM016280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:26 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 389980)
	id E562258D; Tue,  4 Nov 2025 14:21:25 +0530 (+0530)
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, saravanak@google.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: [PATCH 1/6] of: create a wrapper for of_map_id()
Date: Tue,  4 Nov 2025 14:21:00 +0530
Message-Id: <b4fd122260aea1ba1e4e9ae655edb7d2e7e15e31.1762235099.git.charan.kalla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA3MSBTYWx0ZWRfX1/gbpZPmscpG
 dJiOFyqq9iAEGAR1RXhMfmIR8AqkjfnCO0fmFguukWVYTUnCZKkhQ0V7YcL3NvTFL1ElcopzO4k
 h4aLBkFCX7V85IONSXyDCmqLFZahBb/YQGXkfYrn+A2IsredVYERfi38o9LircnWzmRwMDnS/XF
 AdZLWi4IIHuFdt51+x8HPnEYojDz/f6qFK+ONpizMyHywp/f2+juNoe4P5ij5FjVN2n+weT+i0n
 Yz+CS26SYRMCLUEmxXk3MA+5Zl2oIS1tANdPscO/LECwGDao9Xli6BTWp5uQtO6gJ08eolx+RXm
 UNwHp/9OXCm8XoqJyKpUwxV3VrTpzPS8jrUelhoclsdnMQOUaWneymueOBfWQL77oGVGuJoNs3c
 XZX5SWBnqaTyTjnwxVuRSbaMD9mudw==
X-Authority-Analysis: v=2.4 cv=fofRpV4f c=1 sm=1 tr=0 ts=6909be95 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=C1h7rMXQnfWixEfEKm8A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: flEi_oXo8DHNVG3B-HTixhTabSdpD4xI
X-Proofpoint-GUID: flEi_oXo8DHNVG3B-HTixhTabSdpD4xI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040071

Make a new function, of_map_id_or_funcid(), which simply wraps
of_map_id().  The of_map_id_or_funcid() is improved in the subsequent
patches to parse the 'iommu-map' property based on the #iommu-cells.

No functional changes.

Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
---
 drivers/of/base.c | 52 ++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 7043acd971a0..ac6b726cd5e3 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2045,28 +2045,12 @@ int of_find_last_cache_level(unsigned int cpu)
 	return cache_level;
 }
 
-/**
- * of_map_id - Translate an ID through a downstream mapping.
- * @np: root complex device node.
- * @id: device ID to map.
- * @map_name: property name of the map to use.
- * @map_mask_name: optional property name of the mask to use.
- * @target: optional pointer to a target device node.
- * @id_out: optional pointer to receive the translated ID.
- *
- * Given a device ID, look up the appropriate implementation-defined
- * platform ID and/or the target device which receives transactions on that
- * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
- * @id_out may be NULL if only the other is required. If @target points to
- * a non-NULL device node pointer, only entries targeting that node will be
- * matched; if it points to a NULL value, it will receive the device node of
- * the first matching target phandle, with a reference held.
- *
- * Return: 0 on success or a standard error code on failure.
+/*
+ * Look at the documentation of of_map_id.
  */
-int of_map_id(const struct device_node *np, u32 id,
-	       const char *map_name, const char *map_mask_name,
-	       struct device_node **target, u32 *id_out)
+static int of_map_id_or_funcid(const struct device_node *np, u32 id,
+		const char *map_name, const char *map_mask_name,
+		struct device_node **target, u32 *id_out)
 {
 	u32 map_mask, masked_id;
 	int map_len;
@@ -2149,4 +2133,30 @@ int of_map_id(const struct device_node *np, u32 id,
 		*id_out = id;
 	return 0;
 }
+
+/**
+ * of_map_id - Translate an ID through a downstream mapping.
+ * @np: root complex device node.
+ * @id: device ID to map.
+ * @map_name: property name of the map to use.
+ * @map_mask_name: optional property name of the mask to use.
+ * @target: optional pointer to a target device node.
+ * @id_out: optional pointer to receive the translated ID.
+ *
+ * Given a device ID, look up the appropriate implementation-defined
+ * platform ID and/or the target device which receives transactions on that
+ * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
+ * @id_out may be NULL if only the other is required. If @target points to
+ * a non-NULL device node pointer, only entries targeting that node will be
+ * matched; if it points to a NULL value, it will receive the device node of
+ * the first matching target phandle, with a reference held.
+ *
+ * Return: 0 on success or a standard error code on failure.
+ */
+int of_map_id(const struct device_node *np, u32 id,
+	const char *map_name, const char *map_mask_name,
+	struct device_node **target, u32 *id_out)
+{
+	return of_map_id_or_funcid(np, id, map_name, map_mask_name, target, id_out);
+}
 EXPORT_SYMBOL_GPL(of_map_id);
-- 
2.34.1

