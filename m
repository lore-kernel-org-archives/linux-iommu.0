Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072E823EAA5
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760070; cv=none; b=f47CI9DjN8jlgwk5SJ6T13xtpklAOgLqXao3Zos96FEh1LbR2Ud6cbEwr1nSmB/TeL/8hZFFYxnzUc29R981S7AfSL+LmhbfJD+0MWoJ0lIPZctusVDKGfuago/rm/HJwcBjzHbW5fHh3FcE7I1w4j7FHLBNTAGk0RtTjxou9KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760070; c=relaxed/simple;
	bh=mpaDYN+Xiq4Aav2kxzaZQj9ObGgV8czuZtdwtzXBjMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jBONCm/3tnLRpXSwPR4nJ7G8jg7TXvclFA/YPVfkzmZVx50a5HUnoHd/XjAEzrgZm8WVziUb468EruCLyIzHAGSlL63Lb8hA+0tWDSthXbTI1Q2PIOESnnElHUpUbx1QiNYOaXjxmspX5yMhBEANHsUY7sqhMSm/InOfJqO83sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZYjwN7L/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UjNNwNAS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZYjwN7L/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UjNNwNAS"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60I3MQgM1952521
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 18:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xrWF3I5wfsg
	I7ritNiCaBX3buJieLQCC0f8TTZ7Ptao=; b=ZYjwN7L/h81Y6CKyhcoKBTABj3D
	qBYa3833ZgUON8aC0P9Z1PdYjH8ASwiyRFhUA3eW7rgk0aNfU7tJXOGzs2H5Pxod
	3ABNSGc1yRbuYk79edOV8dYxtCR7GgDxCJ+jatV68+fmzgBODbTMSB68KBFXFmv+
	EChBpfXktjDnQ/hivjZ3oY4t7TxqN+NpN0hmQARs9/I9H9Pxra8ridvGQRHXP10x
	UnsXPN6TPxzYDGjqleBExBpZgpY9E/yTG2RO3TA25ml8Pvkq61jGx5h226QquPYu
	RFzJ/NFDojGMeeflU4fcshqOG4W0opAARLMJi1RZtlnqZimvWxMIyD0TrAA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br1cqay7m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 18:14:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81f48cec0ccso2728478b3a.0
        for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 10:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768760068; x=1769364868; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrWF3I5wfsgI7ritNiCaBX3buJieLQCC0f8TTZ7Ptao=;
        b=UjNNwNASL31YKXfa2FelDtQ/pyizn+HT5PjKe+tOo01xH2g12o4ShN2rW259BkDPpX
         wf//cODg/4+s4W3I8D5XelgvyEklZuF8+1iyTRPMGQcJd35RSdooiO3URTiYpvvlQ1Fj
         3+H98T4suR4WU4ITmWHSVM8d5bDCMVZ6VrboDG7PTaVKLL1oaAG7IIZEeoc6gry19c0J
         DdKGTh7Eeoy+C2T9eomC1Za7YmZLMgzCG1+uZMh54gueE0fEyPIeaJS+ffq1jzCsBKBb
         tTOqERp79kZgS8LjZ1YupkEPq3JKd1i2fOGjlux6proROcYG6MxKmPaMY8SzPNSKG1j0
         UkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760068; x=1769364868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xrWF3I5wfsgI7ritNiCaBX3buJieLQCC0f8TTZ7Ptao=;
        b=BaeA5NhxMuzq5mr/QpO17MASU6ztyZhdiquhQKRYOmxlq+9FhOQGDhZ0whwJGPHInO
         QKKDvCAxQmJQnAPKXTUWgLf45YTveFOvfuzSldq2zfM9h5bIRuRHYYQKv0ptJ0UaRSQp
         ccqUR2/BlOBQDEm6DoDhofQC/zb1ASsfBs75ktEQZiwpIy4ptdTlrfZ8Hv5a7hcd9K1n
         pIhiIaO/pflv56fpjjeXdWwPyNMntYjZ6oeNGBHdhbXLLKJb9DXpUE1eEGGw8mA/o2Zi
         LvKhkoUQ5Q5h4QQjeJg0tkRic0Id9RKz5TEhwFZGHRrT9pplscaxbMxs96qPZ0awMqRw
         JK4w==
X-Gm-Message-State: AOJu0YxH0XS5AWWzOWwm4B4DvRy1RuHBC6KJTzv108Hpc9NNK8RJ/aOL
	ox+Aakgumf3YbAvV+K8uLyWOVoVFD7+Ca8mDJ+zaLaPsKNL/3lShAIFYYh09uPgpvKL/i8X3vJA
	vVdn0MX2pcKF2I+sWtopotaCm4BvM2Ce8XnJQbSDQO4SKIo971pdzWmBXaQ==
X-Gm-Gg: AY/fxX4TKchFCjwA04VPrRQoyA7MAvjA36vGMYY5NdjNzSBi6gQ9RSBCCobi5XpY8Ui
	V0zy7YMnjXBsNKAOcgKQO+bfmXUXRdAznR19L1ruAIh63FDEf0IDQK4DLYOTgqeRay/DmDoy9il
	u374a3mjwpCAry13nxHkTLrhYWCPOjqsXGxx2uJry6vl6wazuaPYZrG6jSlaxqusqHxC/lP3m/H
	mmW5A91RIhN5AvPou2XGr0xyqKKMeOlxOnZeBYZgaOyItdIUbqG0wMEwPZhDJNAqJ5jFXkMib7w
	6HKw3PmUuO195c17Zp7YqCdX/lY1NlAhIqWaydFAqx11vG2r+K3tlgt3fQV2+JZp4VpzudgWxJt
	USq1BrFy+tUpvfWV6K3ZI8i0E5R36z/7ZKW8FoGmOWLCp
X-Received: by 2002:a05:6a00:8d2:b0:81e:408e:47c9 with SMTP id d2e1a72fcca58-81f9f69002amr7418558b3a.11.1768760067513;
        Sun, 18 Jan 2026 10:14:27 -0800 (PST)
X-Received: by 2002:a05:6a00:8d2:b0:81e:408e:47c9 with SMTP id d2e1a72fcca58-81f9f69002amr7418529b3a.11.1768760066858;
        Sun, 18 Jan 2026 10:14:26 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1277a15sm7070759b3a.42.2026.01.18.10.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:14:26 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vijayanand.jitta@oss.qualcomm.com
Subject: [PATCH v5 3/3] of: Respect #{iommu,msi}-cells in maps
Date: Sun, 18 Jan 2026 23:41:25 +0530
Message-Id: <20260118181125.1436036-4-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260118181125.1436036-1-vijayanand.jitta@oss.qualcomm.com>
References: <20260118181125.1436036-1-vijayanand.jitta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JanPg144fnvbde6j4oNhyzeG8O3wkA2P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE2MCBTYWx0ZWRfX0hoGIPcQuy+O
 BIocrE1E7gmqEzUW3eUjFjXb989pYbWtoRHRRwjglNU2iw+a86exvBs0LCd0PmXQKpGtJdcBqFk
 anLKzDjWwap49dGBP8+8XkZODmGUpKg9bii7ngp8zZ73A6/B9rff6Q8FsUsYDMCQkNR75+LJZ4B
 e6bZZ0zzSJqM6WYuucVriwX5GcFfYxcyZrOSPUq12RP0yvxzC8xadOfL7mKA7BBAOVy1tOVRAYy
 9NP2a+dBBLotO8VgJlAwgC7DOWvdE2KhmRoZn5SexHb7/UFGy5PrEMq52evAOiKMfiLAxh+hcKd
 sh2lxVRqi8l51/SFaBQv/f6FcHOS2ld4AHletb42c3fBXHqyg0Dt/5A/5J04kPbXgiDvV7HYF/+
 ePfXVAy67cKpQk/1eAFjGxTKioOZWn/IAF9gw7LxWmVao+vN6lwy6f5/aRB+uJY19MkDcFw14v1
 MdhaJnpYXUt+vwj8krg==
X-Proofpoint-ORIG-GUID: JanPg144fnvbde6j4oNhyzeG8O3wkA2P
X-Authority-Analysis: v=2.4 cv=NfbrFmD4 c=1 sm=1 tr=0 ts=696d2304 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=wJGdY9mNwEi-N7fqGJcA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601180160

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
 drivers/iommu/of_iommu.c |   4 +-
 drivers/of/base.c        | 115 +++++++++++++++++++++++++++++++--------
 include/linux/of.h       |  16 +++---
 3 files changed, 101 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 646ac5a67475..768eaddf927b 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -46,9 +46,7 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 				     const u32 *id)
 {
 	struct of_map_id_arg arg = {
-		.map_args = {
-			.args_count = 1,
-		},
+		.map_args = {},
 	};
 	int err;
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 0c379fa051fe..da236108ab57 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2092,11 +2092,38 @@ int of_find_last_cache_level(unsigned int cpu)
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
  * @arg: contains the optional params, wrapped in a struct of_phandle_args,
  *	which includes:
@@ -2114,18 +2141,19 @@ int of_find_last_cache_level(unsigned int cpu)
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
 
 	if (!np || !map_name || !arg)
 		return -EINVAL;
 
-	map = of_get_property(np, map_name, &map_len);
+	map = of_get_property(np, map_name, &map_bytes);
 	if (!map) {
 		if (arg->map_args.np)
 			return -ENODEV;
@@ -2134,11 +2162,9 @@ int of_map_id(const struct device_node *np, u32 id,
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
@@ -2151,27 +2177,63 @@ int of_map_id(const struct device_node *np, u32 id,
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
-				map_mask, id_base);
+			pr_err("%pOF: Invalid %s translation - %s (0x%x) ignores id-base (0x%x)\n",
+			       np, map_name, map_mask_name, map_mask, id_base);
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
 		if (arg->map_args.np)
 			of_node_put(phandle_node);
 		else
@@ -2180,11 +2242,14 @@ int of_map_id(const struct device_node *np, u32 id,
 		if (arg->map_args.np != phandle_node)
 			continue;
 
-		arg->map_args.args[0] = masked_id - id_base + out_base;
+		for (int i = 0; i < cells; i++)
+			arg->map_args.args[i] = (id_off + be32_to_cpu(out_base[i]));
+
+		arg->map_args.args_count = cells;
 
 		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
-			np, map_name, map_mask, id_base, out_base,
-			id_len, id, masked_id - id_base + out_base);
+			np, map_name, map_mask, id_base, be32_to_cpup(out_base),
+			id_len, id, id_off + be32_to_cpup(out_base));
 		return 0;
 	}
 
@@ -2194,5 +2259,9 @@ int of_map_id(const struct device_node *np, u32 id,
 	/* Bypasses translation */
 	arg->map_args.args[0] = id;
 	return 0;
+
+err_map_len:
+	pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(of_map_id);
diff --git a/include/linux/of.h b/include/linux/of.h
index 514f4f018f99..acbf4fe5b16e 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -465,9 +465,9 @@ const char *of_prop_next_string(const struct property *prop, const char *cur);
 
 bool of_console_check(const struct device_node *dn, char *name, int index);
 
-int of_map_id(const struct device_node *np, u32 id,
-	       const char *map_name, const char *map_mask_name,
-	       struct of_map_id_arg *arg);
+int of_map_id(const struct device_node *np, u32 id, const char *map_name,
+	      const char *cells_name, const char *map_mask_name,
+	      struct of_map_id_arg *arg);
 
 phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
 
@@ -931,9 +931,9 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
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
@@ -1464,7 +1464,7 @@ static inline int of_property_read_s32(const struct device_node *np,
 static inline int of_map_iommu_id(const struct device_node *np, u32 id,
 				  struct of_map_id_arg *arg)
 {
-	return of_map_id(np, id, "iommu-map", "iommu-map-mask", arg);
+	return of_map_id(np, id, "iommu-map", "#iommu-cells", "iommu-map-mask", arg);
 }
 
 static inline int of_map_msi_id(const struct device_node *np, u32 id,
@@ -1480,7 +1480,7 @@ static inline int of_map_msi_id(const struct device_node *np, u32 id,
 		},
 	};
 
-	ret = of_map_id(np, id, "msi-map", "msi-map-mask", &arg);
+	ret = of_map_id(np, id, "msi-map", "#msi-cells", "msi-map-mask", &arg);
 	if (!ret) {
 		*target = arg.map_args.np;
 		*id_out = arg.map_args.args[0];
-- 
2.34.1

