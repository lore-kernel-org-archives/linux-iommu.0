Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63BFA41;
	Tue,  4 Nov 2025 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246301; cv=none; b=NV3H2q85IOF4e05ca54YDlT8WTVjiXfbATUMrzifCm/vaHG559wBzF9W/AHQbElgXeEVUzncuYPEA1OgdD9X294xYBznj5AKSb9Y40Q6tIl9p10WaKuGWJ51b8/DYrJkX2avWTYhem+wKBhgUGfYNkgcDIcNwvLxdGNwv+BmAxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246301; c=relaxed/simple;
	bh=gOuIyGLZ0rbsf6nsYKEXLYFRABxPkLduPu93VheiC5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Er8tnWHF8NYRqrtC0VUBc6it2NieGzed4Yhmd4/ISzhH7XO7vS/MfySKO4Dy32jnACzCE2PlznPtTONX8q1IRjzfqlrfYQZ3ya5jXbf8AYfk7cXzMYcAn7rm+v+3p9mlJol7QXpwQma8lGOx1uQAECJEdmw5Cj9yNxvDxXelMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FMOYF+0M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FMOYF+0M"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48gXTa1527981;
	Tue, 4 Nov 2025 08:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Oq7jhL9Dsoo
	0hdUeRXSucX/YZ/8jt6Z0ez9C2jRwySw=; b=FMOYF+0MpVKuVZi4kNvGvLUK5tT
	xMhbxjtHkyn1KMHpRO2vL3Mqlrfp3OqQa9IabEs5GA+uMQsuhQveFTFSRZSjPSEB
	jkTMZ/EjW5eMbAtkEswak4rEenZHdg8hMi+ffs4ZZBVC2HBg2kRBTyDlaCWkVlzU
	IuKJl8Uac72XEpAEKzLVcLEVme2LEBIPBZelxHhw1MJ488NSWWm68vuN3rwlA5E3
	H9nxk4cFAAclFqU8D9VSgwxi0FqYzdiX0WwG3b1kvxP6o16sTDaqfsTlVyLDHc+s
	LeoWnhEbDFmenzlLkCm5rBtDY9AoX1V3SHCwJXACvl0kN7nHh57a6Cnjc/w==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70kcaawb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:30 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A48pRYQ016331;
	Tue, 4 Nov 2025 08:51:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a5b9m5515-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:28 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A48pQqe016287;
	Tue, 4 Nov 2025 08:51:26 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-charante-hyd.qualcomm.com [10.213.97.134])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5A48pQGK016281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:26 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 389980)
	id E95125DC; Tue,  4 Nov 2025 14:21:25 +0530 (+0530)
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, saravanak@google.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: [PATCH 2/6] of: introduce wrapper function to query the cell count
Date: Tue,  4 Nov 2025 14:21:01 +0530
Message-Id: <47bdcf06aacc1fec791577ffd4a4a94034a4d3ed.1762235099.git.charan.kalla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA3MSBTYWx0ZWRfX+1vBt2H+M/UU
 ID9AzEO28/YPq9PKXJPhWtDkt+oXwGERlbBi4EMTlJ4Ym2kE/eAvfHuG2G7mKiQM0AYkgFbM7qC
 3YH2acO3350kp/3CpFRuPLR75gdNtjM+k1RAGOaF2CgsPJRgaBG84nZfIQS8l8Ak/YKlxhy+QHZ
 tSZUfaoIYVpa0RKDFVqjVWwg1LwqWt+c1h0mBzGqyDGL3YTH1/ahjkZtfeNRK61gkMYSMqtoQo6
 M+hEgv3Luj7sXr3jWVdxeEJTByARUJ/1NIVrL5TRpOvrFfuLM3TNoI7/A1lT3RM1Qya5YOieu7s
 Q7X820p9LsdZQlPfD8knFW66VJUV+9iIQx1z6mp40znUrBuPuKRTf1wxwItuw233Ik8N0Azwrqb
 AvVcjb+icCEKwUDG4cp/GMo9X1Kaag==
X-Proofpoint-GUID: DNCsy5Ha3fOIxbIBPK7z2uGPo4mgHSqK
X-Proofpoint-ORIG-GUID: DNCsy5Ha3fOIxbIBPK7z2uGPo4mgHSqK
X-Authority-Analysis: v=2.4 cv=TIJIilla c=1 sm=1 tr=0 ts=6909be93 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=mpKIZ7k51TbimRKpb2YA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040071

Introduce the wrapper function, of_map_id_cell_count(), to query the
actual cell count that need to be considered by the of_map_id() when
used for translating the <property>-map entries. Accordingly make sure
of_map_id_or_funcid() operates on this returned cell count.

This wrapper function returns cell count as 1 thus no functional
changes.

The subsequent patches improve the logic in wrapper function to detect
the proper cell count.

Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
---
 drivers/of/base.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index ac6b726cd5e3..5e76abcc7940 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2045,6 +2045,12 @@ int of_find_last_cache_level(unsigned int cpu)
 	return cache_level;
 }
 
+static int of_map_id_cell_count(const __be32 *map, const char *map_name,
+				int map_len)
+{
+	return 1;
+}
+
 /*
  * Look at the documentation of of_map_id.
  */
@@ -2053,6 +2059,7 @@ static int of_map_id_or_funcid(const struct device_node *np, u32 id,
 		struct device_node **target, u32 *id_out)
 {
 	u32 map_mask, masked_id;
+	u32 cell_count, total_cells;
 	int map_len;
 	const __be32 *map = NULL;
 
@@ -2068,7 +2075,13 @@ static int of_map_id_or_funcid(const struct device_node *np, u32 id,
 		return 0;
 	}
 
-	if (!map_len || map_len % (4 * sizeof(*map))) {
+	cell_count = of_map_id_cell_count(map, map_name, map_len);
+	if (!cell_count)
+		return -EINVAL;
+
+	total_cells = 2 + cell_count + 1;
+
+	if (!map_len || map_len % (total_cells * sizeof(*map))) {
 		pr_err("%pOF: Error: Bad %s length: %d\n", np,
 			map_name, map_len);
 		return -EINVAL;
@@ -2085,12 +2098,12 @@ static int of_map_id_or_funcid(const struct device_node *np, u32 id,
 		of_property_read_u32(np, map_mask_name, &map_mask);
 
 	masked_id = map_mask & id;
-	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
+	for ( ; map_len > 0; map_len -= total_cells * sizeof(*map), map += total_cells) {
 		struct device_node *phandle_node;
 		u32 id_base = be32_to_cpup(map + 0);
 		u32 phandle = be32_to_cpup(map + 1);
 		u32 out_base = be32_to_cpup(map + 2);
-		u32 id_len = be32_to_cpup(map + 3);
+		u32 id_len = be32_to_cpup(map + total_cells - 1);
 
 		if (id_base & ~map_mask) {
 			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores id-base (0x%x)\n",
-- 
2.34.1

