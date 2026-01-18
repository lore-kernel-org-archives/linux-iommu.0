Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E12FE058
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760065; cv=none; b=UuV1q3rIWQzRX+gsQ3K5yMfZTQeZAX/fSsfaUm9Ok8BWSNyxN0A0f3LLY3b6+dWX1GC7Ds63tLIhQQRfCL8d/r9slh1IBClOWoOVIRbdQk7OdIDkwXonxg7GLtn3hYCbsokjHGMJ2Wn0cwaa8n3GPL2gyCWx1SWlSn9j6i12X9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760065; c=relaxed/simple;
	bh=TSZ/wDnFHxeXqt9KfR/SGAOinyXK0kimEehYm8g6Jkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SqtsaBYmdghBB8K6oH0TvpJo3sBguZrjFuXAb88b4nN8TGsLj1Z373Ox2KAzmY1UXIM0bmwtbkc/O1aqIv51zl3macspk62I2U+HveN0kWKNPr+tsEhMpj679zGn+rppZmy5E3s/xs8VWaNkVO2GllwX/oEU7fgayhPupwUPj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YrPR4YRS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eQ8yWXvG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YrPR4YRS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eQ8yWXvG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60I5toPM2467513
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 18:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FN3oWZbw5sV
	GuRs9dWSdopr6ooa0/d6f+oL1v6bf4sE=; b=YrPR4YRSl2VJssPIvWcmVzJMqXw
	PeBlK1BthWhXB63Tvehj4cqG3jCZiyPtaYLvKLmTTQSHEwPN1prhBRBFicW3AGuG
	sslsiN4oZP/zcPHoi8sOYOCIAsSPIucNzsVquDEz7Tx+3uyQ0L72fhbobD56dcqB
	xBVwzfc+WFDfT9C4vVkcAU19TUS5mIQJIgqgkM82gLaZpmAlwwl0w6rXF8ICc3tF
	dd7PdCruzhI6UE57KvNHsQfMrcBtTXnz1BcsEKCYk20uq3Ak+ZmkqqFVVsPGtqHF
	aXbcVlTTsQ3Q8SgjO+cV9PmgAOnNTxyDjgDAFFoBJtaBEnAKgVEdmGfhf8Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br36darxw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 18:14:22 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c551e6fe4b4so2245302a12.3
        for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 10:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768760062; x=1769364862; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FN3oWZbw5sVGuRs9dWSdopr6ooa0/d6f+oL1v6bf4sE=;
        b=eQ8yWXvGYuqWmnXFxNq8TeLlu7+ixJDLvYey4WuwAKD9KfnHU2yLEUoIsqrfvda8Lh
         WwlZOmRm4Y2FtB9p/N/puOOTmEAeFBZCMphanWw1FwQRhH1cXbJC2ie4aHAWd2OdxMTp
         CLPQvgQde03lJF6jR79YyqVsV7g6DTVSGqtYygiueLIKpaVMxKEEzP3pyeF6DgNW1v9l
         6pFfjXQZ2cJnXgDsNY/ULkF65kOFOOe3UBFgKplSfyZZTiEJ7G1aj8U+dAXtQCOWOms9
         gdD+ihb5X9W1Izabn8VDk/HwvmhCFrt7RMAmbXjUSe4HTayXkMOtZlzsVOPl0HSFIJH5
         tBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760062; x=1769364862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FN3oWZbw5sVGuRs9dWSdopr6ooa0/d6f+oL1v6bf4sE=;
        b=cSfS26kqq+xiCSGcmQP/zvokLMYy+N/7tl/am5ygFkzOKMs7mzyOwIFzr4+5RkS3kV
         ncuLN8WB0N7M4fxUBD9hw5TrggpdwmU75zLUj7w6hldGpJInDIuy6ObDTVk0xtrvP29T
         ed6FR/qSUj22pha7wmcOdqzTiyMSSucVG8i8W5Dk7RUKxMYgtB33DSGWEROyHZ9nHR2B
         w5ZBCySOMvZg2Z4Dkk+Apz4QzGGBrUGH5Je9TNqT90j3dyHLv1QWN+9lxFFgFs6zW7iy
         sj/MmcIDlVZz/kH5sD9BufZ3bTOvnTF+RsjjbTnnVEsPz0hVbhuC3MipUETjJYm47jKk
         rOlw==
X-Gm-Message-State: AOJu0Yy2djUZjmPraufFrfvLI5FNbMDpUiLugtyaMUhBcP6/Fwz73RO8
	T/hUphr+HmoO2DOxppChBhiRAh2Gh7A0LkhU0jGsA0ECC8HxEN7iki4yM59zyCFO5XU+egGKf+D
	ZnZUlNaA90kNe2schR+yRaSykH8WvT8L7jIpi1V+FyIw/utyOppXKCO2qgQ==
X-Gm-Gg: AY/fxX7gdHRiP8L/bb9TYlQPYiHjXrcsl3GmkTBSgwWdNlsvmtqvsSi4MPImmb2R50o
	BRgw/w2bBOhZaExgtIMH7i727mmeLdRCl4gyESwVGC/88O6j6NkVllygWZMdeSdWj1ZU5dJyptr
	RlkbkHd3etnIY9imHpzGKZd8nyU79/ykHAZuoutDY4WlirxNFaeuUPFMSHfR7x3ZK6lnQvh3Apw
	4ZHSob/A7AtxSi9V/eNfR8UF61Zg2pwfuq8mKyeyqW/FhOU9COU5wGyeN31IefyNMTPY3qVpDLf
	Lklvw5rQoorxleJL7Tff15zBjxQHc5zrq3Sh8R74EjEazAEfLq2V6qCUoAYHvbD5WrwlM2QCtBI
	40QS+ryMUKDqmQaKpBDs1mZL+K7DrCc/s2Vqde5e728ot
X-Received: by 2002:a05:6a00:22cc:b0:81f:3afe:2824 with SMTP id d2e1a72fcca58-81f9fce5d63mr8295501b3a.24.1768760061957;
        Sun, 18 Jan 2026 10:14:21 -0800 (PST)
X-Received: by 2002:a05:6a00:22cc:b0:81f:3afe:2824 with SMTP id d2e1a72fcca58-81f9fce5d63mr8295485b3a.24.1768760061420;
        Sun, 18 Jan 2026 10:14:21 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1277a15sm7070759b3a.42.2026.01.18.10.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:14:21 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vijayanand.jitta@oss.qualcomm.com,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: [PATCH v5 2/3] of: factor arguments passed to of_map_id() into a struct
Date: Sun, 18 Jan 2026 23:41:24 +0530
Message-Id: <20260118181125.1436036-3-vijayanand.jitta@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE2MCBTYWx0ZWRfX4YVUV/69nzhv
 kYIiOLsHHGuaxm6NjyA9ahP7rgex1H8TuHc+cjsP2L0lKClzl4hh498aGUTrryByF/f1Eu3EVOm
 6vamu3VJNvkVXyOtWX7P8pMGnSoX4f4YD2OMHtzO232YwAxoM6w8B7tRx6PsEde+EWCLU/hrBcj
 ZSJ4+04m3DIewfBBKJ1nm9IFFh69riX6XvwHNVFNYtTZAkK49bJizRnZ2mtNzPSK8HQEOp+N6tk
 GLLLLnkLYS5O+XBDh7SZUrBcz9y8p76A/DXtkwo9fu1AYadaH52VbtJViqWzt3kOoaw+OIQSHdp
 Muz4C9xnuuyPB6SSu7N1W4midhYm6BHZPuWpdRREyEfeDYqph5PP9iM/PgNfuOLoQ5/9RxCPpdQ
 KIisiRCtKwHRliCMu0PiTGAhJ8pbGNslS1clbcx93t318/q4S47vEN9fTruyKGRxNzFuNnbUBhR
 KLY+4eoYjUaE0grxRtg==
X-Proofpoint-GUID: S--42rW3ADN88fpUW87hupDoyF3OCZ2E
X-Authority-Analysis: v=2.4 cv=GJ0F0+NK c=1 sm=1 tr=0 ts=696d22fe cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=rukgfAGnDChJCile_RwA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: S--42rW3ADN88fpUW87hupDoyF3OCZ2E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601180160

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
index 0b65039ece53..0c379fa051fe 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2098,8 +2098,11 @@ int of_find_last_cache_level(unsigned int cpu)
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
@@ -2113,21 +2116,21 @@ int of_find_last_cache_level(unsigned int cpu)
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
 
@@ -2169,18 +2172,15 @@ int of_map_id(const struct device_node *np, u32 id,
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
@@ -2189,11 +2189,10 @@ int of_map_id(const struct device_node *np, u32 id,
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

