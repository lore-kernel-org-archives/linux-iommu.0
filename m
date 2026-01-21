Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A10742B731
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 05:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974881; cv=none; b=PY9+1wjMg5K2NH+yF/stMF+tR8GULpHkke7WmCxsF2FGNia5O5ep26JoXgJKZARSfXZ582JCXQu5Qn0fVqxitlEe6m05jdncmaF5XI8c2UP91YG1eEjZRIgiBV2vXty53Bc7aQrUN5TsPzP3I6d60wwtU/HmxwJji2cGwHLAe8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974881; c=relaxed/simple;
	bh=RR9FWlUz+1xVRmoePtM/Bqph/SAqgDPzbxXNpm+2Xx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fEMG5KVvEjbs1LpN+Jho4IrJH/GjHcc6TCVoAm8+g5YHLI+cJ/bsWFzzJyiD/TGNbqbQoZOEPlgZ6pLuHp3B/ECDzLjZS8oxH8iMlH4NPDWQTJYgAeiPFJwYOXxK9RRq9JX+60sFScxjsGl53teBxB2TMCQQvm3LhTDPmZcrAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=glNMt0bD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A1xwKt6b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="glNMt0bD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A1xwKt6b"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L5mLqT1530084
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 05:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1ykmUyUQ1bF
	wmEK+dIW9dl9UbR2EOlU3YHXvC7GZAyM=; b=glNMt0bDf50Bx5hpaKQx2Ab5cl4
	qhjfm4joHYToHlGUYJB2gFaz7s6BUk7g8/HTOzLZrFOiPOscU38BSiNpdb83tDcE
	mSsVUHgoIxYUOTxN0ADhqSRLy4YV9J2G9DJRNjMUt6hqOhvg32S0QPcE8LSdHlnA
	7axvkBE2PdE5F9mCJVODD/xhZKx9CjIC4O2rRtqnYvycZODxRwB8LiJWQxxTXH7H
	JQiUGfki6WA7bIvfUHMByiVHKFxLVldz/DDmejsiQetTDxZwBn3RH6HK/pnhvgsl
	EkxZujEoowaUzhx507otl0X1nybMnPFCOjUACd1sASdnny7mOotwLX17c1w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bth83hpyh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 05:54:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a351686c17so58012315ad.0
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 21:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768974876; x=1769579676; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ykmUyUQ1bFwmEK+dIW9dl9UbR2EOlU3YHXvC7GZAyM=;
        b=A1xwKt6b1FaMyUe+fsWzqotKNtoiS2gdLBqC1tuO5Dv8IMvyjWwmRlnmYo5bvag/e0
         PltdwSTSO9xe/LxGjUZ0zEMAERiH3xNzj98BHTL/CGVA4Pq3CRVReBCEcaCY7imTWR6G
         XuWZe+PQZeQs3Gs9I4ISsZVAooPyTGW0b5OLHCvwyWqEBDAxLhKtONwq9uPci62zo1Zq
         lFgG/kR8uRTdXahDDDc2xbEG4J9a/uqzP70gQjn4fVLhu6LV0ukLfCt22qocGxdrlb7P
         fvE6vF+lEcIL2+i1JM2iHgAtkhuMbKuUx7DQYsiawKreYWCxr1Ky1+Oq2Uvx9iip1P6X
         i6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768974876; x=1769579676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ykmUyUQ1bFwmEK+dIW9dl9UbR2EOlU3YHXvC7GZAyM=;
        b=fDWiGVS8+omLI9h6UuJUeTp7d41geSJ6yA/98aVjqiX8DLwbQ9OxHJ3lEo2VnuclsW
         enLLdVCEmmOh558+YTE80QTiM7ct93Nhirwl6Lc23A92s2Fg6wcrecsIn3nqN78AMIne
         yU74+/fsfw5rJt5hEiU1DDQbFOK9K8i6K/w4jbia7SLka5BPpg21NjhEf48HrP5nP68f
         hV8m2rjlDICUFCIrgfuIZRKLuHmGvIggX1PCt8Yy5TnQP0xXmjXyE+TMkm+eMjNOrQ5D
         orsGm1hf223UT2wMr1Xx82244odjLOmZCFYy35J39GmcHDzMGRt/h5fyeEFxRi4lyDeO
         e9qw==
X-Gm-Message-State: AOJu0Ywhq8TeNJfb/T1leNAtUHnK9v5vO2Sv+RnzkxFOZJHUmou+M0Is
	O8zxpTNT3DdoYNWjxQiMr9X8RenWJoPMdsDU2fPuye23vIEQX+3Zx/oVVa+JcusCHZeYI+jQwAX
	i774uiBMZNKp3f9pk0OliIzudMBrlOYGcWszp9FHnicp2GdksT6k2rZSZpw==
X-Gm-Gg: AZuq6aKQTOInTtQuypqZzscMtIR6Xe5YkvDX6jjMJfievRTbqRbMtCU+tACZcsxckZm
	OJS6mlp65gRGHdCTOJwdJBazFZ+J84XObhDRKTywl9Cs9DKAXbzZWERvY5r9/IY3O/pCR+/bIgM
	RYwp8nCGuMMWwGx6KMJFaa5UwxeVCOof/NG5QiEZXLgUeLNsAA/rWIqDOo/nfU9k0DosO7n0wdA
	xn8S1meIqfBCPhnP4vhgOdgQiXW90UKAPcLL4zFIqRh6dkY41ZxaCYm0PQ+lK71EAOnyrXouhT9
	OKWl5FIqxc7bkdt25qEazRk/cToLtMhhy2L5syqFpmqpHHHAcGoDw7WK9jpYk0WLo+8q9PlEMGM
	NB2OzHMZhaOEVHJWhITmFdkYTdCCEvsa7q5EWi3GNRahQ
X-Received: by 2002:a17:903:3c26:b0:2a0:941a:6b08 with SMTP id d9443c01a7336-2a7175395a4mr150649755ad.21.1768974876147;
        Tue, 20 Jan 2026 21:54:36 -0800 (PST)
X-Received: by 2002:a17:903:3c26:b0:2a0:941a:6b08 with SMTP id d9443c01a7336-2a7175395a4mr150649445ad.21.1768974875620;
        Tue, 20 Jan 2026 21:54:35 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1278061sm13831927b3a.44.2026.01.20.21.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:54:35 -0800 (PST)
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
Subject: [PATCH v6 2/3] of: factor arguments passed to of_map_id() into a struct
Date: Wed, 21 Jan 2026 11:23:59 +0530
Message-Id: <20260121055400.937856-3-vijayanand.jitta@oss.qualcomm.com>
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
X-Proofpoint-GUID: MsjnaX27sfAwuPbU063VvMiS-5Wq1tmB
X-Authority-Analysis: v=2.4 cv=TeSbdBQh c=1 sm=1 tr=0 ts=69706a1c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=rukgfAGnDChJCile_RwA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA0NiBTYWx0ZWRfX5X66YJ/q1lIa
 4m7AjLyaYaK/++l2jT8fg4fjP2VAdBVnwQhMVC4libGLdII4cs4sMoOz1cdNCHIPY407jbBOS8H
 O8d2C2mp4/9s6tgzPQDX2K5XIQQ7EdIzz21+q0e/A7++VYjubrSz82DodNDmBF6sMDYHHhr2axC
 e/MwQVLm7Yw11I4sjNg37G6uLKISrjqdWmiCQvbAeL1empgXMVlvsAeW3P4v/7l7to8Q6tm4yFH
 CKWFrXhdygJbqwYf0QR/JFADqAD8sICO+w0HR2ywe2825WRFlXdyvpkY4xNlkqH1ub0PcuoOQ6m
 Q+sNzOSwDEcJmoGE66onrQn6BSMm0o+EIJ2tQ8kY8i529Qq4mlRpQAA6Cf4FExWOsOM09CSKcn0
 eNcpQ2h0loVKW7PwL/imJ0bptng6ResZ2p9NZeHsjw8yWwd2Ot9rq7xFwRbvmZ/EB5lWKGb6uA8
 xsYWnaxFC44ilP4MsSA==
X-Proofpoint-ORIG-GUID: MsjnaX27sfAwuPbU063VvMiS-5Wq1tmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210046

From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>

Introduce a new struct type where the optional arguments passed to
of_map_id() are Currently embedded as of_phandle_args struct.
Subsequent patches add additional arguments to the struct that the
caller expects to be filled of_map_id().

Suggested-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
 drivers/cdx/cdx_msi.c                 |  2 +-
 drivers/iommu/of_iommu.c              | 12 ++++++---
 drivers/of/base.c                     | 37 +++++++++++++--------------
 drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++--
 drivers/pci/controller/pcie-apple.c   |  4 ++-
 drivers/xen/grant-dma-ops.c           | 20 +++++++++------
 include/linux/of.h                    | 32 ++++++++++++++++++-----
 7 files changed, 75 insertions(+), 42 deletions(-)

diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
index 63b3544ec997..7ed9643f1815 100644
--- a/drivers/cdx/cdx_msi.c
+++ b/drivers/cdx/cdx_msi.c
@@ -124,7 +124,7 @@ static int cdx_msi_prepare(struct irq_domain *msi_domain,
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
 	struct device *parent = cdx_dev->cdx->dev;
 	struct msi_domain_info *msi_info;
-	u32 dev_id;
+	u32 dev_id = 0;
 	int ret;
 
 	/* Retrieve device ID from requestor ID using parent device */
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a511ecf21fcd..646ac5a67475 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -45,15 +45,19 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 				     struct device *dev,
 				     const u32 *id)
 {
-	struct of_phandle_args iommu_spec = { .args_count = 1 };
+	struct of_map_id_arg arg = {
+		.map_args = {
+			.args_count = 1,
+		},
+	};
 	int err;
 
-	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args);
+	err = of_map_iommu_id(master_np, *id, &arg);
 	if (err)
 		return err;
 
-	err = of_iommu_xlate(dev, &iommu_spec);
-	of_node_put(iommu_spec.np);
+	err = of_iommu_xlate(dev, &arg.map_args);
+	of_node_put(arg.map_args.np);
 	return err;
 }
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 57420806c1a2..fa0acabfd420 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2102,8 +2102,11 @@ int of_find_last_cache_level(unsigned int cpu)
  * @id: device ID to map.
  * @map_name: property name of the map to use.
  * @map_mask_name: optional property name of the mask to use.
- * @target: optional pointer to a target device node.
- * @id_out: optional pointer to receive the translated ID.
+ * @arg: contains the optional params, wrapped in a struct of_phandle_args,
+ *	which includes:
+ *	np: pointer to the target device node
+ *	args_count: number of arguments
+ *	args[]: array to receive the translated ID(s).
  *
  * Given a device ID, look up the appropriate implementation-defined
  * platform ID and/or the target device which receives transactions on that
@@ -2117,21 +2120,21 @@ int of_find_last_cache_level(unsigned int cpu)
  */
 int of_map_id(const struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
-	       struct device_node **target, u32 *id_out)
+	       struct of_map_id_arg *arg)
 {
 	u32 map_mask, masked_id;
 	int map_len;
 	const __be32 *map = NULL;
 
-	if (!np || !map_name || (!target && !id_out))
+	if (!np || !map_name || !arg)
 		return -EINVAL;
 
 	map = of_get_property(np, map_name, &map_len);
 	if (!map) {
-		if (target)
+		if (arg->map_args.np)
 			return -ENODEV;
 		/* Otherwise, no map implies no translation */
-		*id_out = id;
+		arg->map_args.args[0] = id;
 		return 0;
 	}
 
@@ -2173,18 +2176,15 @@ int of_map_id(const struct device_node *np, u32 id,
 		if (!phandle_node)
 			return -ENODEV;
 
-		if (target) {
-			if (*target)
-				of_node_put(phandle_node);
-			else
-				*target = phandle_node;
+		if (arg->map_args.np)
+			of_node_put(phandle_node);
+		else
+			arg->map_args.np = phandle_node;
 
-			if (*target != phandle_node)
-				continue;
-		}
+		if (arg->map_args.np != phandle_node)
+			continue;
 
-		if (id_out)
-			*id_out = masked_id - id_base + out_base;
+		arg->map_args.args[0] = masked_id - id_base + out_base;
 
 		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
 			np, map_name, map_mask, id_base, out_base,
@@ -2193,11 +2193,10 @@ int of_map_id(const struct device_node *np, u32 id,
 	}
 
 	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
-		id, target && *target ? *target : NULL);
+		id, arg->map_args.np  ? arg->map_args.np : NULL);
 
 	/* Bypasses translation */
-	if (id_out)
-		*id_out = id;
+	arg->map_args.args[0] = id;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_map_id);
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c3e5cb3cb846..641f9d34f7a9 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1138,12 +1138,18 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 {
 	struct device *dev = imx_pcie->pci->dev;
 	struct device_node *target;
-	u32 sid_i, sid_m;
+	struct of_map_id_arg arg = {};
+	u32 sid_i, sid_m = 0;
 	int err_i, err_m;
 	u32 sid = 0;
 
 	target = NULL;
-	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
+
+	err_i = of_map_iommu_id(dev->of_node, rid, &arg);
+	if (!err_i) {
+		target = arg.map_args.np;
+		sid_i = arg.map_args.args[0];
+	}
 	if (target) {
 		of_node_put(target);
 	} else {
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index a0937b7b3c4d..2df15fe075fa 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -755,6 +755,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
 {
 	u32 sid, rid = pci_dev_id(pdev);
 	struct apple_pcie_port *port;
+	struct of_map_id_arg arg = {};
 	int idx, err;
 
 	port = apple_pcie_get_port(pdev);
@@ -764,10 +765,11 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
 	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
 		pci_name(pdev->bus->self), port->idx);
 
-	err = of_map_iommu_id(port->pcie->dev->of_node, rid, NULL, &sid);
+	err = of_map_iommu_id(port->pcie->dev->of_node, rid, &arg);
 	if (err)
 		return err;
 
+	sid = arg.map_args.args[0];
 	mutex_lock(&port->pcie->lock);
 
 	idx = bitmap_find_free_region(port->sid_map, port->sid_map_sz, 0);
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 1b7696b2d762..8c332b7ff148 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -319,38 +319,42 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
 					   struct device_node *np,
 					   domid_t *backend_domid)
 {
-	struct of_phandle_args iommu_spec = { .args_count = 1 };
+	struct of_map_id_arg arg = {
+		.map_args = {
+			.args_count = 1,
+		},
+	};
 
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 		u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
 
-		if (of_map_iommu_id(np, rid, &iommu_spec.np, iommu_spec.args)) {
+		if (of_map_iommu_id(np, rid, &arg)) {
 			dev_dbg(dev, "Cannot translate ID\n");
 			return -ESRCH;
 		}
 	} else {
 		if (of_parse_phandle_with_args(np, "iommus", "#iommu-cells",
-				0, &iommu_spec)) {
+				0, &arg.map_args)) {
 			dev_dbg(dev, "Cannot parse iommus property\n");
 			return -ESRCH;
 		}
 	}
 
-	if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") ||
-			iommu_spec.args_count != 1) {
+	if (!of_device_is_compatible(arg.map_args.np, "xen,grant-dma") ||
+	    arg.map_args.args_count != 1) {
 		dev_dbg(dev, "Incompatible IOMMU node\n");
-		of_node_put(iommu_spec.np);
+		of_node_put(arg.map_args.np);
 		return -ESRCH;
 	}
 
-	of_node_put(iommu_spec.np);
+	of_node_put(arg.map_args.np);
 
 	/*
 	 * The endpoint ID here means the ID of the domain where the
 	 * corresponding backend is running
 	 */
-	*backend_domid = iommu_spec.args[0];
+	*backend_domid = arg.map_args.args[0];
 
 	return 0;
 }
diff --git a/include/linux/of.h b/include/linux/of.h
index 309c5681744b..514f4f018f99 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -74,6 +74,10 @@ struct of_phandle_args {
 	uint32_t args[MAX_PHANDLE_ARGS];
 };
 
+struct of_map_id_arg {
+	struct of_phandle_args map_args;
+};
+
 struct of_phandle_iterator {
 	/* Common iterator information */
 	const char *cells_name;
@@ -463,7 +467,7 @@ bool of_console_check(const struct device_node *dn, char *name, int index);
 
 int of_map_id(const struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
-	       struct device_node **target, u32 *id_out);
+	       struct of_map_id_arg *arg);
 
 phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
 
@@ -929,7 +933,7 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
 
 static inline int of_map_id(const struct device_node *np, u32 id,
 			     const char *map_name, const char *map_mask_name,
-			     struct device_node **target, u32 *id_out)
+			     struct of_map_id_arg *arg)
 {
 	return -EINVAL;
 }
@@ -1458,17 +1462,31 @@ static inline int of_property_read_s32(const struct device_node *np,
 }
 
 static inline int of_map_iommu_id(const struct device_node *np, u32 id,
-				  struct device_node **target, u32 *id_out)
+				  struct of_map_id_arg *arg)
 {
-	return of_map_id(np, id, "iommu-map", "iommu-map-mask",
-			 target, id_out);
+	return of_map_id(np, id, "iommu-map", "iommu-map-mask", arg);
 }
 
 static inline int of_map_msi_id(const struct device_node *np, u32 id,
 				struct device_node **target, u32 *id_out)
 {
-	return of_map_id(np, id, "msi-map", "msi-map-mask",
-			 target, id_out);
+	int ret;
+
+	struct of_map_id_arg arg = {
+		.map_args = {
+			.np = *target,
+			.args_count = 1,
+			.args = { *id_out },
+		},
+	};
+
+	ret = of_map_id(np, id, "msi-map", "msi-map-mask", &arg);
+	if (!ret) {
+		*target = arg.map_args.np;
+		*id_out = arg.map_args.args[0];
+	}
+
+	return ret;
 }
 
 #define of_for_each_phandle(it, err, np, ln, cn, cc)			\
-- 
2.34.1

