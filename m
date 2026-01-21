Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162A436358
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 05:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974884; cv=none; b=JKIIU4L+XR8xvG9mctQexRnoC3U4rgP3JqCir1NygCAaX94EdCONbGOOgj8vqsDr5+7jrNwNAQNzGfMQRdkNM6nPX9LgCU/meGUr2VEmciej+TPv91FoyVuRo/AWSMZJWF2/38oxaeUjQWX+USQAGPAotOH/LM2IL8bngsoU9RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974884; c=relaxed/simple;
	bh=xaTFyBurmmvNtHA7oMxSSwhBxJ/ddKy3uGWyizniZzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HbNQJYvXvU/nydr/nieH2w6tMDcZMx1yDwXGJ1dNWrm+lm12nSSylFWGsa6000GqZu9ZqWoPrwwrB2Rmfv5YKUpcCyP83eVNBFH6G6jO+7usD78r1uxk5Eb7v5r5rcUMFSsIFk5k00X4qWoW9tlct5//ycUQ5v2bc+1ym1tmRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oQNfYemq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b/77BBHw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oQNfYemq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b/77BBHw"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KKj6XD798267
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 05:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=byjsK3rK402
	/tmrgBPq1R1oFXm1Avf0oayBzPBZFLwM=; b=oQNfYemq7sOYpLaD7mdjHsqUEfZ
	KdEUXZ6cJvw3guYbIomA+sTCEF5nCe1dyZ8s1/XsRBeDBocCirl0IkT1WugS9Mf0
	OwFFmFc0Bey9gWdmqWQtVwi8ATLtNoAlbkwqldM38xdc8+L3bH9BYaEmXk5NPgMq
	II6LhMzaW/+rwG3BJwK1ERnD34VgPVZiTT+vlPKeo2pa2ykvBqXMXECHTTwyfsto
	Z1bCGcLKq1VR70PJN8jXDjT7HmeeFEdieDUO5HmfF5jIqomov+lOrL5OcDVE/gDV
	PRS5TCp34jQA0tCzTfHkyf4o6hE5SNQbcDrJSvk/6uL789y+6GtDCum9bkg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bta6q36uv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 05:54:41 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7dd05696910so3740297b3a.2
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 21:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768974881; x=1769579681; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byjsK3rK402/tmrgBPq1R1oFXm1Avf0oayBzPBZFLwM=;
        b=b/77BBHwaA9Ns8EeC00aUBd0mWltl2vv1DKEgTFaXJKnu6IYotH4F8gbROYwM5BrYJ
         LMBhXIHyt4Z5RSBoustBh4xvooAEkEKNGzhh8eAsT+/QaE6BWrEfe/+d7FHgWMBEJjHk
         Tr+cWhdGg/CgGAvKmqDHMw978ALEFeBboLgnrFESeXekIibDz3fP02k6QVqTUr3bq/hw
         wyv+MtAxp1CO+hexeh7zBALTHu3G+kE2FgPvcS+CcD1CvK9QN92dz1x/kAUkoZZEzlMh
         T3zP6hKrU2qB+tRko0ssZKrXABBYjqWAxM0Bh24qe/hiec9fhtCHevkJwWbDcNeCTM2/
         c39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768974881; x=1769579681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=byjsK3rK402/tmrgBPq1R1oFXm1Avf0oayBzPBZFLwM=;
        b=tOP1sBkJ96UfQHKbFEyafoo66r10bxJhWRrCXfWdvDk5tZcR0+BBtWfED8z2tGhBuD
         uEfwLnKcjBe/yqoTocW6biUM730xHHmmf5EaLJLvBJpWPh30o3uCja18sq47+LArBchD
         K+pLKdKI+VPKkB7YbziW5VCQ08SM5lA8ceQxQAODpAcY9dHzKFAQ9Kw4iRVDl7NrVZ54
         F5s9BnCijA+JEPgAIUz3zYPpPyoemtSGuuQANhigKprjz6HAqlo0eKdS2yK+2XpmyQvQ
         tDoNWEEDUL8+nLcm18iLmpgl2x6f9z4KBXbd62MYeRBUp4wn3+zFM0zB+vXO/y+MO+in
         wlDg==
X-Gm-Message-State: AOJu0YwQuBJV8EdwPqD4UwwPEwx8UUS9Kfkgjk4OsHZKHeBa6j9WvRyR
	ybdnZXj/SZAezGMMmd3JBL4iaDBgkqsfF9v9aYtSFp3S0uwu/BeEYb9daCGX4kxwEAFBZQyvlc7
	dJjWlwCOVVE3Ol3kfWx0dOucHcymTaHhQmuogWNmQhp5nj4AKnty5V3Kz2w==
X-Gm-Gg: AZuq6aKVlepYD/pXgllMtj8VJK3UELY+AW3/bGeL8KwJOQfk14kYI2s30Yw249gK9Ij
	9afbBxqpuKaZ6Q3Tmd+8y4a/ldEwIVWEKJb57IVPLCbjWm1sVInv5BYY+WnlPB8EoiWxsbMTamj
	zISWOKkhx1CgHc4LuPv7zp61d5LrDSEJgVHKq5fbyYQE9G2+9wv4+BGENQ0O9dfBNO9vr6Nxtix
	5GQmSdFcpvfN9dPx0eXA5tfY0SrDLsoEY+1NHF43hD+mR2X+TxtykjL0isdbgUuWBix9JWUrAKF
	S0hAiZoRRXC26RL6D6BnFvoT4bdm5SHsSZYDjZ/AeV123jK6mWiWtFZELnRCPvphwYogg0uqJuz
	PNzLKt7RQip2h/59ZHHWNvMN2ZWyNdF7DzLp+29H0/ZQV
X-Received: by 2002:a05:6a00:39a3:b0:81f:4e36:38af with SMTP id d2e1a72fcca58-81fa0340a7emr15191984b3a.60.1768974880561;
        Tue, 20 Jan 2026 21:54:40 -0800 (PST)
X-Received: by 2002:a05:6a00:39a3:b0:81f:4e36:38af with SMTP id d2e1a72fcca58-81fa0340a7emr15191965b3a.60.1768974880020;
        Tue, 20 Jan 2026 21:54:40 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1278061sm13831927b3a.44.2026.01.20.21.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:54:39 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v6 3/3] of: Respect #{iommu,msi}-cells in maps
Date: Wed, 21 Jan 2026 11:24:00 +0530
Message-Id: <20260121055400.937856-4-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com>
References: <20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QohTHFyd c=1 sm=1 tr=0 ts=69706a21 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=wJGdY9mNwEi-N7fqGJcA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA0NiBTYWx0ZWRfX7RDVCNqpc+B2
 9MABcCPkCNFHQTpK9On8is9nhMS9E9gcHePl2vKYe0jEbBr4Hy03KqdUkAJ6eH3+pjj4hLITlD0
 DBkAz90NYhgg4O3wFJf9SOHML2F3/zVhKAs+77fc6FiRrprbkUePfhRFJx4YEQCJWN+X+81zGkZ
 ZMsKVtuUybNQ2+i3FsOIzD2nzmoStVrqHdSbXUyyeM8pibfwlNAbBjQDCKr1ZduQwN3HoJfDv4c
 RVeFJ6qvSrk7AnVvL0ao3DbLdVVRh74TXEDU6awE90bvhOm0jq6CDPYbqIFZHGFx7hMLfC/QXcD
 snavPaA7ZL96VW86oI2hRZXrhmJ1S2bWZGLOue/M8UB2VwoenmTdw4e+Gj2PEBdHkDAjm+e9KLn
 bM1XXOZ/sI+pfJxFIVCgjASshlRK0XbMkIFQYRpEqoa2/zVZ8jBup/HKpjoUlw8kAGNY+D1GT4L
 XAuSl8ujPHuK6phv+pQ==
X-Proofpoint-GUID: WveEFGGpWLO7VX1coZOmPbb293egJqpe
X-Proofpoint-ORIG-GUID: WveEFGGpWLO7VX1coZOmPbb293egJqpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210046

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
index fa0acabfd420..0825f3dc93f2 100644
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
  * @arg: contains the optional params, wrapped in a struct of_phandle_args,
  *	which includes:
@@ -2118,18 +2145,19 @@ int of_find_last_cache_level(unsigned int cpu)
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
@@ -2184,11 +2246,14 @@ int of_map_id(const struct device_node *np, u32 id,
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
 
@@ -2198,5 +2263,9 @@ int of_map_id(const struct device_node *np, u32 id,
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
index 514f4f018f99..9efa6f93712c 100644
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
+			    struct of_map_id_arg *arg)
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

