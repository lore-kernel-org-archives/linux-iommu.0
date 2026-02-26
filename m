Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224BD372B3A
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091979; cv=none; b=SDd1y4Qk1Lu1ZbDz6hOGvZxazk/65xEleerziRUD/4i6gFR0ooruTOts84N43rFoRlnG3dpyJubuk64h/5iJZXERzl1LNKnvufCvQp5dYNlJTrnguuNHFKZntegeRGXtincrLZv86uAURsH6Aq/nbT8jlhMygiDMUeKRN5sV5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091979; c=relaxed/simple;
	bh=97fKR9KkmUm0My3uS7H/kxmfkSVg30uh7kelDLJQK4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Di0VoK06ExzixGiRSNZGF5sf4HS0OGENPTYXhG2brB84v+HW7aztRoplJW9vwy0RQ0xYaIWeDXouFk/52cKDG8AqQbShrgjgRiZ4JVfMThJzqiu4SRZGasrq0coHeVXutKaRoZDzPT6Mtqk9qpIGIVUCYxQJSgGzv0ZWDHbQcxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZmERtqMG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GY+Cpm59; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZmERtqMG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GY+Cpm59"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4VkBk1280867
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 07:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Pf/xZ2rGDI8
	y/EE7BrQDE/5TEa5/yMessBlTMF9VMd0=; b=ZmERtqMG9TGAKdYtQqdNXqRUm/m
	m7k33+nJX3fUxNk/I/KeNQlCaXeblD3+SEFCC05oNM0PVR/fEvoIskQqqQC+Olg+
	k5l8ZXTkkLh++zm6hcY7Jeddz+F00nEWu4TCYJDjqsVSC16JZCPNh1c5nsXYK+b5
	+lSZwwg/rcYJeUh/LJhg4MpWZAetSazyDOBWDFuka4odRar//MeXSaedd1nCrRig
	hgDGMLQwvw+7ouAbUZAAHsrqT2VU2Dze3FSuKGaEkaWAJhf+hMp6twWj8ZdMMQeb
	MuOJvJmA2a5sxPmy3UgWatkSJaTI0RMAqu8cambV5wzyzMd1tSwYFbKikRw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chx39kru4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 07:46:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c70fc78a985so225268a12.1
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 23:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772091974; x=1772696774; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf/xZ2rGDI8y/EE7BrQDE/5TEa5/yMessBlTMF9VMd0=;
        b=GY+Cpm59LK64z/tAphQpq+4QXuUpyL0/sMi5Lb8GAdLw7TiC8R+PhTdO/NBpeUFYbS
         vhcCN5RWsXSy4vtEDepzMEmm7I17HV5oF2KUAa9pty9gKNnxK5tEHelv1UWNiINwzgmi
         Spzn176nDzc3hEkAnllT4wYJ4ST3jYcWFyqoHsvWJ+NVdRkVEaLjMLhKec/lIeuD5u67
         0msL/blptPMCtcXBj+u71534fHnYvS4CAqe8uRq4ips9w+YUKH6hLX3wV1rBBciLivK8
         OGSyy2gzk/ly7kHM1K9JMdSTqVNEksDJCvlZlQdNxuAX0Siskj4HDlUui8PqTiEAPE/6
         zvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772091974; x=1772696774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pf/xZ2rGDI8y/EE7BrQDE/5TEa5/yMessBlTMF9VMd0=;
        b=bSf9hXH6aXfqVlLl0lgT47WHIX/5gZBOK5knd59CO2hI6nh/rLwi7VibDOXzMCaG5T
         fThLsMdarES6jxZPwIHiU1WuscdysxdT7jAc2FbcAzDQ5kolAzY+uEqiz55ZsB08vLWI
         3Z2aQz/r3cV691D8FqPoQlErk4SJQWp2JCN9uXoSymP99uwd81/ETGLEqSgB2rIq1edu
         IjIu4ykkGV2eBXLnW+6pFY6p7Lf+/0lYavXucicVqCvHJLFlDii2cAGM7MzAMYSUL3qi
         hgMrD4iSuXx0LJhaEZ50uAn3lOXFOsXMTj1W2q8yYrFI9Z6nF5KN/2zwND41AGZw+bnD
         2azw==
X-Gm-Message-State: AOJu0Yx6P4yhwU/yVHcl5P4vv/NuoGT93oNbMFF7bSOdM0rM5r01xcI1
	OEhVgMGf9qLaF3Zyw+CEK46IDnbtvWpGXAL3MHwn03xLa37j4MD/VHxW8SLcC19WFntDr7N85bd
	tebaTFA1+pl2T2rRKZtawG4EFYNQxXujkLu53UK/U8LDIgptuOkm7gki+Gg==
X-Gm-Gg: ATEYQzyNZv7OMdOgFTay9AQ96tNQnWkP8gJFcJ/L+LTK0+8BT83O4o2x4exQVxjbovy
	tdoS9eO4gqdBC2BCIAaEAWaGs0QWMUvnW1AMztzII/2ZDU5F98o0NYemoMGasdc9qgPOSflCPe1
	8XFaR6kVG1YydMB+vC0QfKNncuYWUDE7x8bHb9vPcBuTOZWPUFyUmGdY979NZIIkNUs0hlQJvhM
	9LXOcCxieouNuy+BWzuwgohpawgn90ZZCKg1wTCuM7EJpkqe6Z08oWdY0vuyEBb0xvTI3Cbabnx
	DgBQZkvb2b8U9HJfceR84XisLm6mLxaddOZCzxprAGFNeb1CYWxDuTLyVLqxpCw6ARI3F3qu6p1
	wlSKodXosoEO2+z3c4sA7WtRu+U3IfYJ03KD/1cX34xgA0GE28Va7it9n
X-Received: by 2002:a05:6a20:d43:b0:38e:99a0:105b with SMTP id adf61e73a8af0-39545f88028mr13948685637.51.1772091974423;
        Wed, 25 Feb 2026 23:46:14 -0800 (PST)
X-Received: by 2002:a05:6a20:d43:b0:38e:99a0:105b with SMTP id adf61e73a8af0-39545f88028mr13948664637.51.1772091973885;
        Wed, 25 Feb 2026 23:46:13 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359034bbfd4sm4891168a91.10.2026.02.25.23.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:46:13 -0800 (PST)
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
Subject: [RESEND,v8 3/3] of: Respect #{iommu,msi}-cells in maps
Date: Thu, 26 Feb 2026 13:12:45 +0530
Message-Id: <20260226074245.3098486-4-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226074245.3098486-1-vijayanand.jitta@oss.qualcomm.com>
References: <20260226074245.3098486-1-vijayanand.jitta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2OCBTYWx0ZWRfXw05u/PRq3b3j
 N9LvsqC4+1LqbEkuvUUsa7Ox3CrYlh5b3laKuwMxM27c0pj5FSNZlu3wuJqqAezkfUuyq+y6NUh
 M23kAKAYY+HaSwxzkuQqNychAUWRJfXrLevQRhwNDnro2QIuMXVs5PTL2JdBvIxMZv6y4dIrUS8
 DxM3XCrXRiJjZmACpeuUzpVNeBTHevNRfigen2BXOardIUC9oHCoSmQv3mVKKGP1qr/0GdF81oL
 Aqfwom+X/4HzZzi2CtoDAabGJEklA/Uosd8CmloTvF+sZoRUMgDamQH8MgKRwqjfbDK68iXvWTE
 Inp1a+Tc8VBwhG4N6fBCoDTgJHCV7Ol/BYBOdMRiCANDBn+HUhrkdxJnpR9NJi7Z76BIRTVkBFd
 NENRA+pmRgbZevyCDbrKuFrtSDwldm5ENYn2RSV1d+GkvZNrqXnT/Qs86NNSdUyaiq7g9ur4LEF
 VzWQMapqhZdnP4d0wow==
X-Authority-Analysis: v=2.4 cv=FvoIPmrq c=1 sm=1 tr=0 ts=699ffa47 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=wJGdY9mNwEi-N7fqGJcA:9 a=3WC7DwWrALyhR5TkjVHa:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: odzcj5PR9wp-kf-k78Ipuyf-j5Me13Qw
X-Proofpoint-ORIG-GUID: odzcj5PR9wp-kf-k78Ipuyf-j5Me13Qw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260068

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

