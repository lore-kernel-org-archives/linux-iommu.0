Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1301734CFD4
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718365; cv=none; b=pO6l0kjBoGg6da6wVIQGu5GTPsIv+mMYs9VoGqhCx1np3ktUXrTLy49N6kYadU5XColr+JqyWtywaXaHjus75oDH9F/GX88ZeWnKy2kVCThtOPDDOltl/izJUpfbFt56M9zXqq16aPCPPs5RGCc98ACi31wNzyL0YqC2DgL0qi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718365; c=relaxed/simple;
	bh=KhYoy59fUOTm+5d7kVEFeRmtrhESQxj0OSJ/tMHru5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KOMTkUwn5KvWdqjnu9ma9sr0bnEK/5AEnJeVtLDav1VGDdkHY/eBYSOoXuz+VQoyy40UBI8dCffwKuhCCDb2tvQtXm8DIoCnQBBaLWy6R3CcqM22uBhmZrvQgW/i9uaOcz4E6M+bKQl0UaGrdU73Jz0CH4rN+5qVUpz6hPwML2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kfy+zMf9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JmnwiNAu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kfy+zMf9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JmnwiNAu"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A72Qda441443
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 10:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/bweSHaD2R2
	QwumX9pHEOQfXBYHAiY8r/k8oYTXiWAU=; b=Kfy+zMf90JSITdAk7xhYorU6j0Y
	/0DE5jx3YLaRNT+xRD0jj8ko9FOjhchsMhkrRZKuwr5EEfU73C1aM40HiIvug1M0
	uFKSZPBdDbLDg37ZlvqzfZ0MkcpziLF62u3ljzhqEBVTF0k/9+MwWpFXkGBokI6t
	MgxhBc5myZ69JlGWNaM+aFLNfypOVMlZYOA/zOowLfce9Nj86P1yoFX6jNm32w4l
	enNqMb/4rgyIjOzWQRGznlQHkftwCaqxgHjaUnebuERfgqmBGFIhfi+tz5b+gD6o
	dScdBFfQmrbYvHdCO5ezv/bxPxgoA4PD9QuzpeW4iQWGjC+C1ZF2Sc8cECw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7qp9j653-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 10:12:43 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81f53036ac9so4698764b3a.3
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 02:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770718363; x=1771323163; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bweSHaD2R2QwumX9pHEOQfXBYHAiY8r/k8oYTXiWAU=;
        b=JmnwiNAukZrSeMhTs4iabL/Lb1yE5E5vjJKQAh7QQrnSKzD4EgLw0lQfhKmnDPtnsZ
         69rJnqHjplPMPpP30rn4etKLCm9DjnOELzMYlCIzsgpwqrg/C/3Rk6xdytIsNcHIODP3
         YD+c5pf43SBiKBXE9kofHH8c1o5t17oMp9Rc1kI6lefvqjnEeDUiIZ49Th6I2r1NnVaD
         rjGWrcOzd/mUOf5a7gWeWZYCjm9+98oTgv7a+uM8TLbwOrmPPNVrfUIWr9/XikbpNBog
         +EGZms/ZwiSbyTvOu3RiOaWRQ01mDIJQzO+3tfkfSm5J6HJhkPYRS1WfU9rtEilOMs4a
         yC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770718363; x=1771323163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/bweSHaD2R2QwumX9pHEOQfXBYHAiY8r/k8oYTXiWAU=;
        b=ZGKv/w6Ww0Zx/7AI3LfbyYVhifJ+uj1kz8r9ZjzuaL88owWYUhYjS+UjBmMWQ/H42x
         D2zi3le9uVZByFega0fdTgI/b6FYOLiv81DNEUXLZFLHb47k3M10NcPDQhM9Ik/Lq7Qc
         K4GBa3dk3axcz4zoNlbqjL6LlJ8C1STa7WrMZJLgbG1uFc4tTEGt001PcDYKfp3ashMp
         YnTWWA44sw4TE+HLcM184RRBTh5EAhgp19Cu4BZxQT91yksNj7efZguMO1zlPWP7sRaG
         5FvaUQbTic13DtzCsH6JmE3sgL9oYrv0IOp6XwJqgKh87q+6wSub/AQhkIZr9LaQl87X
         YCMg==
X-Gm-Message-State: AOJu0Yx8BlTzuPW18z2yZi1FMQN75KoqLZjtJs/dgH+tedNNFgmtIu5e
	JdmyoXIld0icv66Tl9YUc2JzrTe72Ik73mBfDUJGeRfHWB3QDkovSfmMDnz0OqjKSKY+rC2okZA
	3nTtPQU7u3c3okXxxEm/ARDU3BKhgBRhZY1f8XnGa1UD9JAdaEgfrnc0Rkw==
X-Gm-Gg: AZuq6aKCQskim6668rIdguFDC4fHiN9zxruuWP9VdffHR6YwzKTBKI0sPeHJy341DaR
	atmDY5t/RLty9D8xb4nPJlDMBijIRCxHgBnMipyIKSnrNkYtdXpruE73uv7usXo3L7PsTwjvP83
	FCP7GZN2dMJ/rCewpLPPkPgnN40tH5A1RiTlWG8CeK5Pm60ndxjTixF85dAFSsJ3z2aEQWQswQx
	9AuLv3Zhd8reD8bCDzs9mHnrT2CgKN37RZAOXLo/UkSIXwWUplt/Q3czVoTK/VP8aAD95klppsY
	vTFZft3Yk1VJzDEb76jCx4YoXv3OTmFhnKrrRI45R6eOrg3N5T1vQj0LcxyNWNMRqNgkDUdkS2G
	KdXUPcVuVbY2oTpNFVdgAWm58rR7i008bdTWyFNxy82KE4xUReI/kO1Hx
X-Received: by 2002:a05:6a00:4fc8:b0:824:1ab7:f02f with SMTP id d2e1a72fcca58-824417b12d6mr12955634b3a.65.1770718362580;
        Tue, 10 Feb 2026 02:12:42 -0800 (PST)
X-Received: by 2002:a05:6a00:4fc8:b0:824:1ab7:f02f with SMTP id d2e1a72fcca58-824417b12d6mr12955608b3a.65.1770718362074;
        Tue, 10 Feb 2026 02:12:42 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82441884b75sm14380940b3a.39.2026.02.10.02.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 02:12:41 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v7 3/3] of: Respect #{iommu,msi}-cells in maps
Date: Tue, 10 Feb 2026 15:41:57 +0530
Message-Id: <20260210101157.2145113-4-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210101157.2145113-1-vijayanand.jitta@oss.qualcomm.com>
References: <20260210101157.2145113-1-vijayanand.jitta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5-P05hoK1K40KtfWa-LI_OUtUsG1HRrX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA4NCBTYWx0ZWRfXygoBGCgkw9ou
 ttZsdr2W5FOHY/15jSVhnkioEMAZfqzrPMtPdGo9YpV/JvbPP5r+8PnsdnP0IrMCFOY//wEOGUn
 gzx0vUm0eotF24OTOa1qXJkWcjAAalfZkGaB3PD7tx1/2xe5gQ0B9EO7myq7iIg/4ULlCmLateS
 PrW19biH0/FCmYbMQfdo2PsyaGWSm+5VMO2dheUOZFWdrKHTFNGvw0mhkUjFMP3UXhlpmTsDcol
 6MN17sM+HUyGJ+DErMRBKpUeZZjhigh5blfE/UqA6HS/HSmacz0BFUrrazfNpXUAzZYQhdwVDtl
 f+q6zO2dAH+jARQtVoEnezrjwM9CPwNDeqiwWiqrD01/1ZGo+j/Dnjr+HN9mY/lS4lXOgPL3l8l
 6u0v2qqRLUgp0pHQyeh8MJgPjLHiKeD5mZZ01kI+ix8eefBp7KM/+9wYdOsvNjxAObkpz6V2jKF
 AwdKJ15B9rgnAJVa9kQ==
X-Authority-Analysis: v=2.4 cv=dP2rWeZb c=1 sm=1 tr=0 ts=698b049b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=wJGdY9mNwEi-N7fqGJcA:9 a=zc0IvFSfCIW2DFIPzwfm:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 5-P05hoK1K40KtfWa-LI_OUtUsG1HRrX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100084

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
Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c |   2 +-
 drivers/of/base.c        | 117 +++++++++++++++++++++++++++++++--------
 include/linux/of.h       |  16 +++---
 3 files changed, 102 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index d255d0f58e8c..a18bb60f6f3d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -45,7 +45,7 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 				     struct device *dev,
 				     const u32 *id)
 {
-	struct of_phandle_args iommu_spec = { .args_count = 1 };
+	struct of_phandle_args iommu_spec = {};
 	int err;
 
 	err = of_map_iommu_id(master_np, *id, &iommu_spec);
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 6c3628255908..596bcf993dcb 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2096,11 +2096,38 @@ int of_find_last_cache_level(unsigned int cpu)
 	return cache_level;
 }
 
+/*
+ * Some DTs have an iommu-map targeting a 2-cell IOMMU node while
+ * specifying only 1 cell. Fortunately they all consist of value '1'
+ * as the 2nd cell entry with the same target, so check for that pattern.
+ *
+ * Example:
+ *	IOMMU node:
+ *		#iommu-cells = <2>;
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
  * @arg: of_phandle_args structure,
  *	which includes:
@@ -2118,18 +2145,19 @@ int of_find_last_cache_level(unsigned int cpu)
  *
  * Return: 0 on success or a standard error code on failure.
  */
-int of_map_id(const struct device_node *np, u32 id,
-	       const char *map_name, const char *map_mask_name,
-	       struct of_phandle_args *arg)
+int of_map_id(const struct device_node *np, u32 id, const char *map_name,
+	      const char *cells_name, const char *map_mask_name,
+	      struct of_phandle_args *arg)
 {
 	u32 map_mask, masked_id;
-	int map_len;
+	int map_bytes, map_len, offset = 0;
+	bool bad_map = false;
 	const __be32 *map = NULL;
 
 	if (!np || !map_name || !arg)
 		return -EINVAL;
 
-	map = of_get_property(np, map_name, &map_len);
+	map = of_get_property(np, map_name, &map_bytes);
 	if (!map) {
 		if (arg->np)
 			return -ENODEV;
@@ -2138,11 +2166,9 @@ int of_map_id(const struct device_node *np, u32 id,
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
@@ -2155,27 +2181,63 @@ int of_map_id(const struct device_node *np, u32 id,
 		of_property_read_u32(np, map_mask_name, &map_mask);
 
 	masked_id = map_mask & id;
-	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
+
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
-				map_mask, id_base);
+			pr_err("%pOF: Invalid %s translation - %s (0x%x) ignores id-base (0x%x)\n",
+			       np, map_name, map_mask_name, map_mask, id_base);
 			return -EFAULT;
 		}
 
-		if (masked_id < id_base || masked_id >= id_base + id_len)
-			continue;
-
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
+					     np, map_name, cells_name);
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
+			       np, map_name, id_len, cells);
+			return -EINVAL;
+		}
+		id_off = masked_id - id_base;
+		if (masked_id < id_base || id_off >= id_len)
+			continue;
+
 		if (arg->np)
 			of_node_put(phandle_node);
 		else
@@ -2184,11 +2246,14 @@ int of_map_id(const struct device_node *np, u32 id,
 		if (arg->np != phandle_node)
 			continue;
 
-		arg->args[0] = masked_id - id_base + out_base;
+		for (int i = 0; i < cells; i++)
+			arg->args[i] = (id_off + be32_to_cpu(out_base[i]));
+
+		arg->args_count = cells;
 
 		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
-			np, map_name, map_mask, id_base, out_base,
-			id_len, id, masked_id - id_base + out_base);
+			 np, map_name, map_mask, id_base, be32_to_cpup(out_base),
+			 id_len, id, id_off + be32_to_cpup(out_base));
 		return 0;
 	}
 
@@ -2198,5 +2263,9 @@ int of_map_id(const struct device_node *np, u32 id,
 	/* Bypasses translation */
 	arg->args[0] = id;
 	return 0;
+
+err_map_len:
+	pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(of_map_id);
diff --git a/include/linux/of.h b/include/linux/of.h
index 9d72d76f909d..5b5b5dc2d3f3 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -461,9 +461,9 @@ const char *of_prop_next_string(const struct property *prop, const char *cur);
 
 bool of_console_check(const struct device_node *dn, char *name, int index);
 
-int of_map_id(const struct device_node *np, u32 id,
-	       const char *map_name, const char *map_mask_name,
-	       struct of_phandle_args *arg);
+int of_map_id(const struct device_node *np, u32 id, const char *map_name,
+	      const char *cells_name, const char *map_mask_name,
+	      struct of_phandle_args *arg);
 
 phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
 
@@ -927,9 +927,9 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
 {
 }
 
-static inline int of_map_id(const struct device_node *np, u32 id,
-			     const char *map_name, const char *map_mask_name,
-			     struct of_phandle_args *arg)
+static inline int of_map_id(const struct device_node *np, u32 id, const char *map_name,
+			    const char *cells_name, const char *map_mask_name,
+			    struct of_phandle_args *arg)
 {
 	return -EINVAL;
 }
@@ -1460,7 +1460,7 @@ static inline int of_property_read_s32(const struct device_node *np,
 static inline int of_map_iommu_id(const struct device_node *np, u32 id,
 				  struct of_phandle_args *arg)
 {
-	return of_map_id(np, id, "iommu-map", "iommu-map-mask", arg);
+	return of_map_id(np, id, "iommu-map", "#iommu-cells", "iommu-map-mask", arg);
 }
 
 static inline int of_map_msi_id(const struct device_node *np, u32 id,
@@ -1469,7 +1469,7 @@ static inline int of_map_msi_id(const struct device_node *np, u32 id,
 	struct of_phandle_args msi_spec = { .np = *target, .args_count = 1 };
 	int ret;
 
-	ret = of_map_id(np, id, "msi-map", "msi-map-mask", &msi_spec);
+	ret = of_map_id(np, id, "msi-map", "#msi-cells", "msi-map-mask", &msi_spec);
 	if (!ret) {
 		*target = msi_spec.np;
 		*id_out = msi_spec.args[0];
-- 
2.34.1

