Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC2826529A
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766353006; cv=none; b=ieVL+kvIW5mAC5bEHak5Daxi9gV1cpETjNkGrLCSdHtgHLcEQ6PCGzxL7BDUAIcI6WBUdOUr8SIZU38Iom1LjXICfzQmyJZmW0hMm4feNqOmV2mUzdrXBhbe5YArQjlblOF//rOjTlhqGW+XUnUO1iDoyfw77UZy9LJZFzdrrpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766353006; c=relaxed/simple;
	bh=76x0waUT0Gi8/G+fPPa1V6w6ovWJhH1EZ6CFW2yDzKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lSjufGYS5LN8zcNixAezk3yBzgVoOePOjyikvsyo+Anw+4iSh14WI+y1vM+HDmtvTlGL6KH6RxhVdn/4z+qMHh785AbwpNiC/fTLC1hOzHsTPhGGlL5la2gTZW8N3Xm0rJA0YfwgDdCT7a7Iz2PmgE/76XgKgmmhIEwFk/XNyTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IcPyaoZf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OSqcDRbE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IcPyaoZf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OSqcDRbE"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLK5qjm3428890
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 21:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lTfUooU6YQ/
	6LN/6Wkk5DxaIFgRPD3nxUH9oNYW4Q6s=; b=IcPyaoZfxMeMxuH0tA75qrQ/t7f
	y5JuT69+LLOSAtvMdivQPIiRrgjFrtDwZH1A78hHwzOt7zoDcFZoCJuxFytpB9uZ
	aqSws+3dz2oEmEpsAviFZ7AjPBGelQNJ7BTWgRz9kkFp5vHOELcsJu0ssiFl970v
	37xRrv2QyIPbwzQrveMZ1QGIcN5a1L3o9QzTZLxNtzCk+rny3oKk4GncUXgHZ2Qu
	KmwiBJWHD7Eg7j/cN/Kh0myZS4RwSYckL9ZgZfIFlCYgRauHNobo1f0kGfHvhr5s
	71IBE7cy1Nqn23T1vOX0Nxqpg90nF3mrqwEPkoMDJ2EkKz6CFM0qHyZ2Cvw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mrtax8p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 21:36:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c93f0849dso3109274a91.1
        for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 13:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766353003; x=1766957803; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTfUooU6YQ/6LN/6Wkk5DxaIFgRPD3nxUH9oNYW4Q6s=;
        b=OSqcDRbEUNKnKJAR9qbgmGXUfu7f1eGGeOw2xzrHocvKDQouhnNwP6ZlzUZU7GJzj3
         cpai/euU3gAR0vZU1tXwVUfSI8/MyDmRNaGAqkxqdkLtdeQH83Jsgyw1JfrdnkdwOL6n
         Lo3iPyU68dIeR1EbUmtcQeI5Uw1y38tLrC8B0HGdi3gGNKguty8Kj3FTp8pTf599uwdq
         QNM4HiRCi9j1thQ7K3bGbRsUSaZ4DPDQKFM1Xfg8nZZQyzh4d0j1ULHroqwmP8hb6o9t
         l7Hx6NoPMQdtj8u3muZdDWm0T7Mv9Qn5zQPAZjl5B0zQFVx6ZhBIjiH6KAFg8Jx4J2/l
         x+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766353003; x=1766957803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lTfUooU6YQ/6LN/6Wkk5DxaIFgRPD3nxUH9oNYW4Q6s=;
        b=sCJ3RTHczr8joyEJwOElfdEcGsk0YQ6JjQgg2wp+7/mlvIsIku6PS5NRYPxhWGUmZn
         m63hSYYxCjSF66W7Wu1PC+1xHK/vf5VkNixKBvETjcxtLsIpviJn+RmAET1TIYkz5eeb
         qTNJ8aRPOfxGDSDyG6X9BANkYVuXeheJGtqCzUayn2/VZFAxvZk4Ix7cQ+LQ4PQAGu89
         Dnx4QeVLJgGSnqX+5FhX4gcMSC5xlEFwjbXiehR4GDcfvqavPeE9D/gYYzyGT/JAO+dg
         RPzLiaAQuWMkKSMkp0ZPts6R6Mw9+q3v4cr2gFfIex7UXwW33AZ1lhQkrx76bXD9RsrW
         3hnA==
X-Gm-Message-State: AOJu0Yx7FQZ+ZmEf4/wbcw+HhBIEOnn3v6qrLL5xSCLvpRnIzMYhL7ew
	vPhNTUIq70qlQNlvo7se1pZfRgovHPNNwmNsRaj1/LO2i3c7+em3+aQ8FmK8naxrgydn1Cvc9wU
	OhjTUKqdmBBvLHgDAhWPTM34g5+Ee/4G62K8pUDEy7dRGndcwm4SBCXGeEg==
X-Gm-Gg: AY/fxX7M/QIGBz3kOHrA8iTyVosqOak5OqWhDXlD9PEkz1wNNQP2Q81CXFMbvBUfZT2
	BQomzDreZfpk91xJ9gUwIDQ8XM0iVGdRMAT/F1+ENOFMwtmtwuQ1rmJGkp1CKZfuJzPLsUVjDTS
	WlUC9gUfQHBdQ5qdSOxqAqmn+rt532qVALk5dJoOCuFJDCw0m2NSLMIM61SIaM0ud6aBzij4gqT
	gSVAWpJvfeMPv04E8p6nUaxZQVg52e0HWaM3HbmnsI7AT57VNE5UoJ4YSzFbmLGeWFAIdCsI4SQ
	1eO1/5rnBOrz4qh4k6pGxTVrAIw3efHVaUV5WZAYwBNiL2EhuHfbg0ifaRFL9uHrHM5UHzDxkNS
	KnA9Rcajz4knHhdS7wkggRTZUclkjyi8OZUZIOHVlk9ut
X-Received: by 2002:a17:90b:2cce:b0:343:6a63:85d5 with SMTP id 98e67ed59e1d1-34e90de2570mr8296071a91.16.1766353002575;
        Sun, 21 Dec 2025 13:36:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExqI7Jno+XhZu6DZAHUuo8szMM/almYtDUdvO8izu0OaxMl7ybeXGhn2dL8JLTkTnp/7rKSg==
X-Received: by 2002:a17:90b:2cce:b0:343:6a63:85d5 with SMTP id 98e67ed59e1d1-34e90de2570mr8296045a91.16.1766353002020;
        Sun, 21 Dec 2025 13:36:42 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dcc7c8sm10950163a91.15.2025.12.21.13.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 13:36:41 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, saravanak@google.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v3 3/3] of: Respect #{iommu,msi}-cells in maps
Date: Mon, 22 Dec 2025 03:06:02 +0530
Message-Id: <20251221213602.2413124-4-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251221213602.2413124-1-vijayanand.jitta@oss.qualcomm.com>
References: <20251221213602.2413124-1-vijayanand.jitta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sUmb3ShKNzQ4b7xg-KyKm66yhv0T3Ctc
X-Proofpoint-GUID: sUmb3ShKNzQ4b7xg-KyKm66yhv0T3Ctc
X-Authority-Analysis: v=2.4 cv=CeEFJbrl c=1 sm=1 tr=0 ts=6948686b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=wJGdY9mNwEi-N7fqGJcA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDIwNCBTYWx0ZWRfXwOyCMBwXxqiV
 FcO/CJdAWAIPSyS6z7h64Fty3lJGfmmqtyHPZYCtNtTpNPeDC4NnMt+O46rzU6exiDfE2j3HeGl
 AtDmVbqBT8h1KrEjFeL2uy8we0e9zeyZ2Z+spRNcqseE/s0b8G/jeOb/oKe6dAN6svVjYVt9Psl
 kVc0r5nPKfCTlP55lx77FB8E5Er8UwVbIgkkZvLRgY7YIKIvtfA5rbFN4QuLdx2Dfae6KYbVt/H
 EgN+3fNd2xONPM4g+PrvpLlBRi+5CP5BYmWXuW/2ZY043ZWsVnS2F2Owcg1cLhOLNTMEW0MM6A4
 0mnc2TBmPZ7tpspTY0gXWlg8rmwudch2L5UhXcEgwliTuNy8IJ7MKVE6ATphEb5PdlRDZ+Gd0m3
 aUiK1RIMWlPw6l7TBJiJ4/YPgYifa6hgBwYeNfgLiTsthIPBLwg8+tw4QHUKJLoMmgn3fgqSMyQ
 bhMJwhQ6/ScjnaPodUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512210204

From: Robin Murphy <robin.murphy@arm.com>

So far our parsing of {iommu,msi}-map properites has always blindly
asusmed that the output specifiers will always have exactly 1 cell.
This typically does happen to be the case, but is not actually enforced
(and the PCI msi-map binding even explicitly states support for 0 or 1
cells) - as a result we've now ended up with dodgy DTs out in the field
which depend on this behaviour to map a 1-cell specifier for a 2-cell
provider, despite that being bogus per the bindings themselves.

Since there is some potential use in being able to map at least single
input IDs to multi-cell output specifiers (and properly support 0-cell
outputs as well), add support for properly parsing and using the target
nodes' #cells values, albeit with the unfortunate complication of still
having to work around expectations of the old behaviour too.

Since there are multi-cell output specifiers, the callers of of_map_id()
may need to get the exact cell output value for further processing.
Added support for that part --charan

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c |   2 +-
 drivers/of/base.c        | 116 +++++++++++++++++++++++++++++++--------
 include/linux/of.h       |  16 +++---
 3 files changed, 102 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 74779b77ba13..ece830ec4c19 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -45,7 +45,7 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 				     struct device *dev,
 				     const u32 *id)
 {
-	struct of_phandle_args iommu_spec = { .args_count = 1 };
+	struct of_phandle_args iommu_spec = {};
 	struct of_map_id_arg arg = {
 		.map_args = iommu_spec,
 	};
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 4dca3d37a34b..aedff1c03995 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2045,11 +2045,38 @@ int of_find_last_cache_level(unsigned int cpu)
 	return cache_level;
 }
 
+/*
+ * Some DTs have an iommu-map targeting a 2-cell IOMMU node while
+ * specifying only 1 cell. Fortunately they all consist of value '1'
+ * as the 2nd cell entry with the same target, so check for that pattern.
+ *
+ * Example:
+ * 	IOMMU node:
+ * 		#iommu-cells = <2>;
+ *
+ *	Device node:
+ *		iommu-map = <0x0000 &smmu 0x0000 0x1>,
+ *			    <0x0100 &smmu 0x0100 0x1>;
+ */
+static bool of_check_bad_map(const __be32 *map, int len)
+{
+	__be32 phandle = map[1];
+
+	if (len % 4)
+		return false;
+	for (int i = 0; i < len; i += 4) {
+		if (map[i + 1] != phandle || map[i + 3] != cpu_to_be32(1))
+			return false;
+	}
+	return true;
+}
+
 /**
  * of_map_id - Translate an ID through a downstream mapping.
  * @np: root complex device node.
  * @id: device ID to map.
  * @map_name: property name of the map to use.
+ * @cells_name: property name of target specifier cells.
  * @map_mask_name: optional property name of the mask to use.
  * @arg: contains the optional params, wrapped in a struct of_phandle_args,
  *	which includes:
@@ -2067,18 +2094,19 @@ int of_find_last_cache_level(unsigned int cpu)
  *
  * Return: 0 on success or a standard error code on failure.
  */
-int of_map_id(const struct device_node *np, u32 id,
-	       const char *map_name, const char *map_mask_name,
-	       struct of_map_id_arg *arg)
+int of_map_id(const struct device_node *np, u32 id, const char *map_name,
+	      const char *cells_name, const char *map_mask_name,
+	      struct of_map_id_arg *arg)
 {
 	u32 map_mask, masked_id;
-	int map_len;
+	int map_bytes, map_len, offset = 0;
+	bool bad_map = false;
 	const __be32 *map = NULL;
 
 	if (!np || !map_name || !arg || (!arg->map_args.np && !arg->map_args.args))
 		return -EINVAL;
 
-	map = of_get_property(np, map_name, &map_len);
+	map = of_get_property(np, map_name, &map_bytes);
 	if (!map) {
 		if (arg->map_args.np)
 			return -ENODEV;
@@ -2087,11 +2115,9 @@ int of_map_id(const struct device_node *np, u32 id,
 		return 0;
 	}
 
-	if (!map_len || map_len % (4 * sizeof(*map))) {
-		pr_err("%pOF: Error: Bad %s length: %d\n", np,
-			map_name, map_len);
-		return -EINVAL;
-	}
+	if (map_bytes % sizeof(*map))
+		goto err_map_len;
+	map_len = map_bytes / sizeof(*map);
 
 	/* The default is to select all bits. */
 	map_mask = 0xffffffff;
@@ -2104,27 +2130,64 @@ int of_map_id(const struct device_node *np, u32 id,
 		of_property_read_u32(np, map_mask_name, &map_mask);
 
 	masked_id = map_mask & id;
-	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
+	while (offset < map_len) {
 		struct device_node *phandle_node;
-		u32 id_base = be32_to_cpup(map + 0);
-		u32 phandle = be32_to_cpup(map + 1);
-		u32 out_base = be32_to_cpup(map + 2);
-		u32 id_len = be32_to_cpup(map + 3);
+		u32 id_base, phandle, id_len, id_off, cells = 0;
+		const __be32 *out_base;
+
+		if (map_len - offset < 2)
+			goto err_map_len;
+
+		id_base = be32_to_cpup(map + offset);
 
 		if (id_base & ~map_mask) {
-			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores id-base (0x%x)\n",
-				np, map_name, map_name,
+			pr_err("%pOF: Invalid %s translation - %s (0x%x) ignores id-base (0x%x)\n",
+				np, map_name, map_mask_name,
 				map_mask, id_base);
 			return -EFAULT;
 		}
 
-		if (masked_id < id_base || masked_id >= id_base + id_len)
-			continue;
 
+		phandle = be32_to_cpup(map + offset + 1);
 		phandle_node = of_find_node_by_phandle(phandle);
 		if (!phandle_node)
 			return -ENODEV;
 
+		if (!bad_map && of_property_read_u32(phandle_node, cells_name, &cells)) {
+			pr_err("%pOF: missing %s property\n", phandle_node, cells_name);
+			return -EINVAL;
+		}
+
+		if (map_len - offset < 3 + cells)
+			goto err_map_len;
+
+		if (offset == 0 && cells == 2) {
+			bad_map = of_check_bad_map(map, map_len);
+			if (bad_map) {
+				pr_warn_once("%pOF: %s mismatches target %s, assuming extra cell of 0\n",
+				np, map_name, cells_name);
+				cells = 1;
+			}
+		}
+
+		out_base = map + offset + 2;
+		offset += 3 + cells;
+
+		id_len = be32_to_cpup(map + offset - 1);
+		if (id_len > 1 && cells > 1) {
+			/*
+			 * With 1 output cell we reasonably assume its value
+			 * has a linear relationship to the input; with more,
+			 * we'd need help from the provider to know what to do.
+			 */
+			pr_err("%pOF: Unsupported %s - cannot handle %d-ID range with %d-cell output specifier\n",
+				np, map_name, id_len, cells);
+			return -EINVAL;
+		}
+		id_off = masked_id - id_base;
+		if (masked_id < id_base || id_off >= id_len)
+			continue;
+
 		if (arg->map_args.np)
 			of_node_put(phandle_node);
 		else
@@ -2133,12 +2196,15 @@ int of_map_id(const struct device_node *np, u32 id,
 		if (arg->map_args.np != phandle_node)
 			continue;
 
-		if (arg->map_args.args)
-			*arg->map_args.args = masked_id - id_base + out_base;
+		for (int i = 0; arg->map_args.args && i < cells; i++)
+			arg->map_args.args[i] += (id_off + be32_to_cpu(out_base[i]));
+
+		if (arg->map_args.args_count)
+			arg->map_args.args_count = cells;
 
 		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
-			np, map_name, map_mask, id_base, out_base,
-			id_len, id, masked_id - id_base + out_base);
+			np, map_name, map_mask, id_base, be32_to_cpup(out_base),
+			id_len, id, id_off + be32_to_cpup(out_base));
 		return 0;
 	}
 
@@ -2149,5 +2215,9 @@ int of_map_id(const struct device_node *np, u32 id,
 	if (arg->map_args.args)
 		*arg->map_args.args = id;
 	return 0;
+
+err_map_len:
+	pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(of_map_id);
diff --git a/include/linux/of.h b/include/linux/of.h
index 0b0d545b80a3..ee07e8642133 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -460,9 +460,9 @@ const char *of_prop_next_string(const struct property *prop, const char *cur);
 
 bool of_console_check(const struct device_node *dn, char *name, int index);
 
-int of_map_id(const struct device_node *np, u32 id,
-	       const char *map_name, const char *map_mask_name,
-	       struct of_map_id_arg *arg);
+int of_map_id(const struct device_node *np, u32 id, const char *map_name,
+	      const char *cells_name, const char *map_mask_name,
+	      struct of_map_id_arg *arg);
 
 phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
 
@@ -909,9 +909,9 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
 {
 }
 
-static inline int of_map_id(const struct device_node *np, u32 id,
-			     const char *map_name, const char *map_mask_name,
-			     struct of_map_id_arg *arg)
+static inline int of_map_id(const struct device_node *np, u32 id, const char *map_name,
+			    const char *cells_name, const char *map_mask_name,
+			    struct of_map_id_arg *arg);
 {
 	return -EINVAL;
 }
@@ -1442,7 +1442,7 @@ static inline int of_property_read_s32(const struct device_node *np,
 static inline int of_map_iommu_id(const struct device_node *np, u32 id,
 				  struct of_map_id_arg *arg)
 {
-	return of_map_id(np, id, "iommu-map", "iommu-map-mask", arg);
+	return of_map_id(np, id, "iommu-map", "#iommu-cells", "iommu-map-mask", arg);
 }
 
 static inline int of_map_msi_id(const struct device_node *np, u32 id,
@@ -1456,7 +1456,7 @@ static inline int of_map_msi_id(const struct device_node *np, u32 id,
 		},
 	};
 
-	return of_map_id(np, id, "msi-map", "msi-map-mask", &arg);
+	return of_map_id(np, id, "msi-map", "#msi-cells", "msi-map-mask", &arg);
 }
 
 #define of_for_each_phandle(it, err, np, ln, cn, cc)			\
-- 
2.34.1

