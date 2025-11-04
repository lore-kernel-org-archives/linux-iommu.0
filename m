Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64A30498E;
	Tue,  4 Nov 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246304; cv=none; b=rKFwh5qRFSwc5a4Vywa3aNIAb6DJ1CoWnIxXDzWD82hFvvfxt1bCmoTbMLsvU98PM+dYGJD1VA8FTbIo8Fj0FYGq9P4PTmqIBcjtSvGrHDeB9dJj87kW95lQWNRJHSaxzuAGlZ/bf/lYvQDGG+yG8+TSdnLg2XIh0xc5JnQR614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246304; c=relaxed/simple;
	bh=v+xOWBPbvDz7bnEO5XCha45ZulYnmP25LmBbH1q+KKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R8xZ3nuw42gCGUOTIhUJI9Mn+oYiVR/BO5q80k3Y76CUEp/nJNJwqdKbO8Q0EV1PH+7WNE42sSi3KOVJXkw/qpottjsiHsP+IaoV4a4U3Zpwbm5Y+yxAqQfSn8MDEFEtUhbsRFh2PxdlicmcU4rKXGkBfS5On8JHW0AJrxZQJtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CZYd56/z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CZYd56/z"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48gXR61527979;
	Tue, 4 Nov 2025 08:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LRw7+qj4LEY
	pfVWu5QKj1ZR4weQUxjuYT8L3W/JkIwI=; b=CZYd56/zN37fZS3Lnnn3oRXx+7k
	9hvloChf8l8s7o7Tk4HIuSTO6RcuRVhis+Y5RY4LfdgUQLqJ5M9CCYTRphapkHn7
	mvF9KEmzeZcYRJKAF+ptmHyaphNoaE7m85uO1FYC3N9WD+JmSOFW83+vQjEsOjG+
	s0t8x4PambZm/3ASj0QkghSh3epiCsVnurMn87GWwN8WvwGGIGaZgTZKs4JYb7Pw
	gCxQ9TGlaPDF0cxc0CWIiq5ybEsfI6sIAN8aZCJOrfrZ2teCD4jW3m8slR5lShZq
	SgW9r21WOpI194cRyOgiJm3JrMtWDb1zW49N2ucaUEIKJNquzDTXSlGRiSQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70kcaawc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:31 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A48pSbW016753;
	Tue, 4 Nov 2025 08:51:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a5b9m551p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:28 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A48pRMD016588;
	Tue, 4 Nov 2025 08:51:27 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-charante-hyd.qualcomm.com [10.213.97.134])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5A48pRrW016406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:27 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 389980)
	id 019AD5F3; Tue,  4 Nov 2025 14:21:25 +0530 (+0530)
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, saravanak@google.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: [PATCH 5/6] of: add infra to parse iommu-map per IOMMU cell count
Date: Tue,  4 Nov 2025 14:21:04 +0530
Message-Id: <74d4ddf90c0fb485fda1feec5116dc38e5fd23cf.1762235099.git.charan.kalla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA3MSBTYWx0ZWRfX07WpWfF5QneF
 EnPsF3z1oaYM7MZfacAQZ0KNCAxQxwKmwRTxggLrBIB6uxpFy3GoawW8Qk6NyddyMYwNCSh1vPY
 5IY25elxHLBOltCsm2l2IymOeGEMI8sJiz9wsfqwlCD3NjGqZklivI7SmazPq3V9HQur6LkijPo
 jeigtkTxGTAThQEgd8As+hx1MDAdoWbN9ZUh5DAn36dFYSlo5uTYqGV+JuqeWm9+dcY5tTYw3jL
 xrJosKSO4BgRyEiEZGC0s50Hb32ZG88UaYY5QVZ7xDJGmtSAThasGnMG8ePlhS6iSBQ/YIFan2Y
 d99NBPByl3/G51szFeq8uJb7P+4+StZZLAZF5znm6g1Ec4QZvi0pM+0ZlpZiEIgT8QkZuvRr7Zp
 YN1AXgaqguAL24eypsVipqbPGFYj/A==
X-Proofpoint-GUID: 8BLlCd0obkKfLcpCr1zW1em2N0soqc1h
X-Proofpoint-ORIG-GUID: 8BLlCd0obkKfLcpCr1zW1em2N0soqc1h
X-Authority-Analysis: v=2.4 cv=TIJIilla c=1 sm=1 tr=0 ts=6909be94 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=axFHAr6IENSvUrugGRcA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040071

Add support to parse the iommu-map per the IOMMU specifer defined cell
length, defined in IOMMU controller.

When cell count is more than 1, it is generally complex to assume any
relation between input id and output specifier, thus it is invalid for
len > 1. And for such cases where linear relation is not possible, pass
the arguments without any translation to the iommu layer.

when IOMMU cell count is > 1, iommu-map is represented as:
<rid &iommu cell0 ... celln len>, where len == 1.

To add this infra, of_map_id_or_funcid() takes additional arguments,
callback function and arguments to it, and of_map_id() passes NULL
to these arguments thus callers of of_map_id() are not effected.

Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
---
 drivers/of/base.c  | 131 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/of.h |   4 ++
 2 files changed, 124 insertions(+), 11 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 997b2deb96f0..cd221c003dd5 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2045,6 +2045,35 @@ int of_find_last_cache_level(unsigned int cpu)
 	return cache_level;
 }
 
+/**
+ * of_iommu_map_id_actual_cell_count - determine the cell count for iommu-map.
+ *
+ * @map: pointer to the iommu-map property data that needs to be translated.
+ * @map_len: length of @map in bytes.
+ * @cell_count: value of #iommu-cells.
+ *
+ * The tuple represnting the iommu-map is in the format of
+ * 2 + cell_count(of #iommu-cells) + 1.
+ *
+ * Return: > 0 for success, 0 for failure.
+ */
+static u32 of_iommu_map_id_actual_cell_count(const __be32 *map, int map_len, u32 cell_count)
+{
+	u32 total_cell_count = 2 + cell_count + 1;
+
+	if (map_len % total_cell_count != 0)
+		return 0;
+
+	for (; map_len > 0; map_len -= total_cell_count * sizeof(*map), map += total_cell_count)
+		if (be32_to_cpup(map + total_cell_count - 1) != 1)
+			break;
+
+	if (map_len <= 0)
+		return cell_count;
+
+	return 0;
+}
+
 /**
  * of_iommu_map_id_legacy_cell_count - Determine the cell count for iommu-map.
  *
@@ -2091,12 +2120,14 @@ static u32 of_iommu_map_id_legacy_cell_count(const __be32 *map, int map_len)
  * Return: number of cells that the caller should be considered while parsing
  * the @map. It is > 0 for success, 0 for failure.
  */
-static int of_iommu_map_id_cell_count(const __be32 *map, int map_len)
+static int of_iommu_map_id_cell_count(const __be32 *map, int map_len, u32 cells)
 {
+	u32 legacy_iommu_cells;
+
 	if (map_len % 4 != 0)
-		return 0;
+		legacy_iommu_cells = of_iommu_map_id_legacy_cell_count(map, map_len);
 
-	return of_iommu_map_id_legacy_cell_count(map, map_len);
+	return legacy_iommu_cells ? : of_iommu_map_id_actual_cell_count(map, map_len, cells);
 }
 
 /**
@@ -2137,22 +2168,82 @@ static int of_map_id_cell_count(const __be32 *map, const char *map_name,
 	}
 
 	if (cells > 1 && !strcmp(map_name, "iommu-map"))
-		return of_iommu_map_id_cell_count(map, map_len);
+		return of_iommu_map_id_cell_count(map, map_len, cells);
 
 	return cells;
 }
 
-/*
- * Look at the documentation of of_map_id.
+/**
+ * of_map_id_untranslated - handle mapping of id that can't be translated.
+ *
+ * @map: pointer to the property data that needs to be translated, eg: msi-map/iommu-map.
+ * @cell_count: cell_count related to @map property.
+ * @id: input id that is given for translation.
+ * @arg: argument passed to the @fn.
+ * @pargs: filled by the contents of @map and pass to the @fn.
+ * @fn: Callback function that operated on @dev and @fn.
+ *
+ * The function populates the phandle args structure with the node and
+ * specifier cells, then invokes the callback function. The callback is
+ * responsible for releasing the node reference via of_node_put().
+ *
+ * Return: 0 on success, -EAGAIN, by fn() if ID doesn't match (continue searching),
+ *	   and standard error code on failure.
+ */
+static int of_map_id_untranslated(const __be32 *map, u32 cell_count, u32 id,
+			void *arg, struct of_phandle_args *pargs,
+			of_map_id_cb fn)
+{
+	struct device_node *phandle_node;
+	u32 id_base = be32_to_cpup(map + 0);
+	u32 phandle = be32_to_cpup(map + 1);
+	int ret, i;
+
+	if (!pargs || !fn)
+		return -EINVAL;
+
+	phandle_node = of_find_node_by_phandle(phandle);
+	if (!phandle_node)
+		return -ENODEV;
+
+	pargs->np = phandle_node;
+	pargs->args_count = cell_count;
+	for (i = 0; i < cell_count; ++i)
+		pargs->args[i] = be32_to_cpup(map + 2 + i);
+
+	/* fn() is responsible for calling of_node_put(pargs->np). */
+	ret = fn(id, id_base, arg, pargs);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * of_map_id_or_funcid - map an id through downstream mapping.
+ *
+ * @arg - optional argument and is passed onto @fn.
+ * @pargs - optional argument and is passed onto @fn.
+ * @fn - optional argument and is callback.
+ * Look at the documentation of of_map_id() for additional info.
+ *
+ * This is a wrapper function that includes iommu-map functionality,
+ * IOMMU specifier of which contains #iommu-cells > 1, i.e., tuple
+ * length that can be parsed by of_map_id() is > 4.
+ *
+ * Return: 0 on success or a standard error code on failure.
  */
 static int of_map_id_or_funcid(const struct device_node *np, u32 id,
 		const char *map_name, const char *map_mask_name,
-		struct device_node **target, u32 *id_out)
+		struct device_node **target, u32 *id_out,
+		void *arg, struct of_phandle_args *pargs,
+		of_map_id_cb fn)
 {
 	u32 map_mask, masked_id;
 	u32 cell_count, total_cells;
 	int map_len;
 	const __be32 *map = NULL;
+	bool mapped_id_or_funcid = false;
 
 	if (!np || !map_name || (!target && !id_out))
 		return -EINVAL;
@@ -2163,7 +2254,7 @@ static int of_map_id_or_funcid(const struct device_node *np, u32 id,
 			return -ENODEV;
 		/* Otherwise, no map implies no translation */
 		*id_out = id;
-		return 0;
+		goto bypass_or_callback;
 	}
 
 	cell_count = of_map_id_cell_count(map, map_name, map_len);
@@ -2195,6 +2286,15 @@ static int of_map_id_or_funcid(const struct device_node *np, u32 id,
 		u32 phandle = be32_to_cpup(map + 1);
 		u32 out_base = be32_to_cpup(map + 2);
 		u32 id_len = be32_to_cpup(map + total_cells - 1);
+		int ret;
+
+		if (cell_count > 1) {
+			ret = of_map_id_untranslated(map, cell_count, id, arg, pargs, fn);
+			if (ret && ret != -EAGAIN)
+				return ret;
+			mapped_id_or_funcid = true;
+			continue;
+		}
 
 		if (id_base & ~map_mask) {
 			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores id-base (0x%x)\n",
@@ -2226,7 +2326,13 @@ static int of_map_id_or_funcid(const struct device_node *np, u32 id,
 		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
 			np, map_name, map_mask, id_base, out_base,
 			id_len, id, masked_id - id_base + out_base);
-		return 0;
+		goto bypass_or_callback;
+	}
+
+	if (cell_count > 1) {
+		if (mapped_id_or_funcid)
+			return 0;
+		return -EINVAL;
 	}
 
 	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
@@ -2235,7 +2341,9 @@ static int of_map_id_or_funcid(const struct device_node *np, u32 id,
 	/* Bypasses translation */
 	if (id_out)
 		*id_out = id;
-	return 0;
+
+bypass_or_callback:
+	return fn ? fn(id, id, arg, pargs) : 0;
 }
 
 /**
@@ -2261,6 +2369,7 @@ int of_map_id(const struct device_node *np, u32 id,
 	const char *map_name, const char *map_mask_name,
 	struct device_node **target, u32 *id_out)
 {
-	return of_map_id_or_funcid(np, id, map_name, map_mask_name, target, id_out);
+	return of_map_id_or_funcid(np, id, map_name, map_mask_name, target, id_out,
+					NULL, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(of_map_id);
diff --git a/include/linux/of.h b/include/linux/of.h
index a62154aeda1b..f8d976205ff4 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -22,8 +22,12 @@
 
 #include <asm/byteorder.h>
 
+struct of_phandle_args;
+
 typedef u32 phandle;
 typedef u32 ihandle;
+typedef int (*of_map_id_cb)(u32 id, u32 id_base, void *arg,
+				struct of_phandle_args *pargs);
 
 struct property {
 	char	*name;
-- 
2.34.1

