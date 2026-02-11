Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146B32AAD1
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 05:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770788524; cv=none; b=sKOT2ywmAJIyIWV2clITjuTVdbjoxMIgVHa1HMDN4UIAm74AyonMIb+qb3cNZE8gt4BWzU/rwCDQ5IGJsMJWuQSMP9XIChGZdV61BwKkjdHkXf8eKAoIbdk/BdvTMIKulEJMnqjo5OqoCz0UoxMujSeExuzvcTOxAIkpwyvHxu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770788524; c=relaxed/simple;
	bh=97fKR9KkmUm0My3uS7H/kxmfkSVg30uh7kelDLJQK4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VMu7Go6F5WwCFvybduUxZAZ9YSEafRF56oXB4HhcYhhA214nCj4OXLrWkWlidjnispzFv051PPFiMTc3ZHg9oYxvunsednYMIP7emJ14dCyYuyPGGP+gZlqUM2sRSTdJxJJz0PFkAMF4j3TLkMuDQauMewdZkIIOoEjK9gHIZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dEFR8tiS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MapOR32u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dEFR8tiS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MapOR32u"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B3cXMf838122
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 05:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Pf/xZ2rGDI8
	y/EE7BrQDE/5TEa5/yMessBlTMF9VMd0=; b=dEFR8tiSF7TyIW69yNM0iACZ+Go
	UzqVjJHomeqHniB4x3qOHeJSz8g/uZyuXXsKVE0PBZk7MxuRFCHaNXvEgELSR5D1
	2NP3+Y1DCZzfLfMZaDw5Ax0nOPVn1nYLfEN7U1xBC521plLnnpg+N8TVLfTBpaNc
	56SwwVGxUlNGit/583E0D16yzB2N0Lr8UyNd+OAS7zfaGDvvTVHvrTQ2ZWMFrdgs
	Eb6zNHzhzPH4elz+l+ecpULy/SRud1XmaQ+onvGuH6J2Uu1naFX3UmQqsXRkbXa1
	84mpVLrY0NqhC7hO5yNEwE6Izb1HOHKrFYtwxlerNuwCLzjRGaYkmTRJKVQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8j1t89n7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 05:42:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a90510a6d1so4155005ad.0
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 21:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770788522; x=1771393322; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf/xZ2rGDI8y/EE7BrQDE/5TEa5/yMessBlTMF9VMd0=;
        b=MapOR32uK7CeGnFPB8MWVAsNBzqrHj3v6Bg0Q8RyrMvkM5AOides79MAhA1bSUkW81
         FrIaisbhBY0qqwwRt0J8rlOBP5kg1ncOLgrpPh+gnIN7dT0FPy9mVJQWMrPmqYG83dWa
         KZd/0vKp7lJdlHWI0Zz/8ilTWWiR9q0zYOaLGktbyt24EE4d6aihqUUbkE8JskwHrGfJ
         JOZ876UdARhrsRkn+ULnf3kUErfttI+7fHSa+D9bubiNNpqXBMWm39EfJ/Ds1j+TBTIb
         qUe7TTwxQUUqnvNuhw7ITMEdSdAciVOolIqXLGH3DcNb62YH4W+sLdgUDsC6ZzW0GZCH
         AOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770788522; x=1771393322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pf/xZ2rGDI8y/EE7BrQDE/5TEa5/yMessBlTMF9VMd0=;
        b=jSArIRhBs4NOVj+kYnZo7wpj0hSSnUpV4Ozo4bslkBtGbjFn5bTf2N34JLiBxkkmWs
         vmk5uIJqxteN2QNAfjEhEwa/De/Jh0B+U8AgMOtFk0iMoORjP5prcpt6KWv8U6KfHEBq
         ui70am4nYmU2w11eooxzbBrMFALWfmBbXb09I6MUGqu1Fe6x1Z9C++QVN71CdK047IQg
         3O+QiFdAkAraZ15id5CZwa66Yyp6UhlbRBW2+U8Vx+uzRkNAuhx3NvVgLmMNvkx/uZ11
         38RUbsbxiCrnFegnM8+LomvMMM+q6UNf4YVNEVx1NczEHa2Wwmea8WV00JNb6rRCwPM3
         cn/w==
X-Gm-Message-State: AOJu0YxV78kzTA23zDgf8vYCFPU7VLgIu0Sr4E8rzQ29cFIlJujuD/Ov
	fmMozkfag9uiIku41fUJGuT2Ei5bnhlaq7RV9MxNjHvPjL9KdUrUa5kFc/aMDIgfFgc1d3U82V6
	zjyhVxP85jSldbXcY50g2pJ3YECLGPt0hOcGzqOZTBQ2GKRj7gTXn9qF1RQ==
X-Gm-Gg: AZuq6aJjMisPh/T6arCzMECF0mPyJtOZlw6b+l5idPcVxwaqZA2kmiYtL9c1lIRHoAS
	PgrNqEpcFi/sqbTM8EH/I5SQhufT390C/zjfPdN4WNJeqRFTRzE161+dwEhG1SGdyK8VyyDPYyr
	YVbQ1wRiTumDehNP0g7BaOzepaaNEZdvJvCUkb8om+gyS41R106JlxMGCPevFDOn6J6dGmUBYaQ
	F9hSmRyXG4TE0ByC80RHNgcxfZhMS+2JXlUuGeJxDAY8mOICI5QfJFcCInm0aLyxvNp0fW1Aug4
	3qBQM3TFsT7BpZJpkGLq8zczCCNBZQb1HLgAAL/gG9l9OkH23DzDPKaqY0dvXKxAujHrtjAwGgN
	liQ6Cz+S7QNfyAQkz+0lIfSvKTN4ZISu2qfvApvAKYNU62JrCxQethWu2
X-Received: by 2002:a17:902:f606:b0:2aa:f43d:7c4c with SMTP id d9443c01a7336-2ab1007c0f3mr46409895ad.9.1770788521560;
        Tue, 10 Feb 2026 21:42:01 -0800 (PST)
X-Received: by 2002:a17:902:f606:b0:2aa:f43d:7c4c with SMTP id d9443c01a7336-2ab1007c0f3mr46409715ad.9.1770788521005;
        Tue, 10 Feb 2026 21:42:01 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2986f0adsm9932875ad.26.2026.02.10.21.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 21:42:00 -0800 (PST)
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
Subject: [PATCH v8 3/3] of: Respect #{iommu,msi}-cells in maps
Date: Wed, 11 Feb 2026 11:10:33 +0530
Message-Id: <20260211054033.2796660-4-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211054033.2796660-1-vijayanand.jitta@oss.qualcomm.com>
References: <20260211054033.2796660-1-vijayanand.jitta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA0NCBTYWx0ZWRfXx/qw90jlpoHI
 18Ej4v7Gg0VGziopUX8s3qNWhWsOGL0meriDmltSxc3NFnYVGhReNUlWIAoKMYPfeBO7udi5Pu4
 3bxRG3iiM0EO38ZZ6VRFU6vLlHJkqsHHdtqSOnQywvZPwyCwCMBFH5rU6hfter0oY4ziGjzH9FS
 fVJhmsBzGHpF3S7SYxFn4ckyJ0gdekYniGqIpygD856Sk/km1TiZjmZrazzYSkrM9z2HsDIAYJV
 D4v4tqRC2SxT8glouxajpPuqHhJuYdWGS5CTCh/EYYeQ0+n2Os+Z5QeKVhhtv2nrACljVZMNTSM
 HUROvhXqRAPj4/GSAy8vDQZoHBxDEl6ysQFzz0yGvdBjDm0G6HJKV/P3b8nFVV6gO+KOZk+Ug2y
 VNo5bEPTdJ2Ws1UgSMToO47fSE5BkHomdkD45Ec7HYBEUpCS7Ty1K42qJxVJ0VVOlhv9bG+tvwD
 d0cBdmZe9i0KUt7nEjg==
X-Proofpoint-ORIG-GUID: gdEtfQIwC7FYhOAEukuezPqzvD1sdeNy
X-Authority-Analysis: v=2.4 cv=cabfb3DM c=1 sm=1 tr=0 ts=698c16aa cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=wJGdY9mNwEi-N7fqGJcA:9 a=uG9DUKGECoFWVXl0Dc02:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: gdEtfQIwC7FYhOAEukuezPqzvD1sdeNy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110044

From: Robin Murphy <robin.murphy@arm.com>

So far our parsing of {iommu,msi}-map properites has always blindly
assumed that the output specifiers will always have exactly 1 cell.
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

