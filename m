Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60AD24E4C4
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766352993; cv=none; b=D+IunQ3d+KEGHnZJZa5P0JTLsxjcCy2DDO4wyrqi6py2bn8OEYFApCacLAgIWx0VQKMObnfVzJEOPmxEiKMhtTlxA8xvalBpcoGda8Gsx3zRqrkHzoI+LdCu+M9TdIXsZW5n84bZ34IvO4BjGPz8ZBWXBqWs1CazHsmZ7uFXhBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766352993; c=relaxed/simple;
	bh=ZI/dat0pnePJL3uDPgam7hb7hJJGmBB96a+N9P+pXEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dj8ZSkcx0uqCp4zCX9hA6KuFg7CgQsXmRDlqCdFV4FodHMKigOff5IRPAP6doDh7RAJg+2TS2DHH7P0yuvu9VTlp4EsXmCL+AbpRictmy+V98YA6qpZN338THAE/qkc5ywFdLreHcqEoEsx1OBKAgnRpjeAo9PYYL8bg5RufZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RpW8pqMS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V5GOmwsg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RpW8pqMS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V5GOmwsg"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BL7E53G3718347
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 21:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LPwYAZthCsX
	O+QFdi7+uTYp6zaILxY0tD6IDNL46v60=; b=RpW8pqMS1xNcrfJo/kbs/d2xfER
	+e+VULeLyEiCGMaZbcTCk+JM56exryugfE25nCgZbblJLMwtwkoim292a82kAQTQ
	AxDqD3Wva36TcRMxHU3GNxy4HY7Xm8TJ3rBylLWPkvkTDhpVg+vUe7uFkexQvIdk
	uNXv0gBIQ9u8rZWwFz9t/LOgIgNK/O/gg9zlKypBijor+fhyoVt0bn36AcCDK6G6
	yYCpuwJ57X9fxnKtGFzar3eYDPa8uBUUY5Zz7L0Rzui46nd8zlhnnVEcxBdroyau
	vg7X7cBIED2muvFP+5jX4REdM1V2yUq8lIav8x42UbLHOKpdDFMxqVdMILg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mydtwmu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 21:36:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0d59f0198so44017825ad.1
        for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 13:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766352990; x=1766957790; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPwYAZthCsXO+QFdi7+uTYp6zaILxY0tD6IDNL46v60=;
        b=V5GOmwsgfaj0dujHAwZw3GRkj5//1MkoxcTkt//g3vXV/I57OHvprjdCoCDwmTtBNv
         furx6RGKEhjepAMbmjc/Xgy9XwftPG/Y3TMcV7l6BRvjf4suULVfqypbjXm5iR0JU26u
         HihM8OUbyOKr7UHD0qXb7J8Ykxd61DhIjwk9HwbmLlu26u6e5YzttCaVj7TbVZDzXsJ7
         rLh8Q1B5ZsjcUwCVRClTAZcXd4clekYgpnt9+1FDpQKeZXlQom/ZIL8ihmCdBAtCVSkX
         8ehNfVReQDOycenyEodTVPdwx1j821K47RI8V3j8EEuN+ChaY9eJooY09Gbjz1X8VBSl
         +ffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766352990; x=1766957790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPwYAZthCsXO+QFdi7+uTYp6zaILxY0tD6IDNL46v60=;
        b=F6Q+/FLwEAiBO2RqVLhN4tp/CS34G6Z179AwbYhIgwqCaRfkNS5Zze7jidAcRPPrJP
         +15klvZ9by24Xpq7vN+jw184lw2sOwcC/BFyVAZQKqG4S9rnIkfI39mGlyTx1ZHg9tWp
         WeFP/nxJ9ipZv2aJrJ3UG1w9PsrQeRbfCj+ix7ePXrEB451ojuCCyalswniOPFVMEhWc
         lJkhXBBwjUfbeCBhOxW4wkOkauQXwyeI8eBq53LOCnLMAq5hsI4J/3lAV1CsU5OUcg64
         OS36vYSKEFMEUd0SKWA2ylAcbHeI0LV/0cR+R4UIn5ODnpbzeN9lxQUyo9DP372RdKHZ
         SM3w==
X-Gm-Message-State: AOJu0Yyvh9K4HbwyaQxaAHAlDjaK5ee8Hr82vSjmNmvC5ArKpW/PgIly
	Q+9A+VmKljoaEonykRN1eRdeV97M4rt+3P58a2HQ86GxqpFoaBvgWXBUNnk0FSiVJuQE2rwrKb9
	TQHdrm+B6DjHde39izFhrbnHrbLlInxi6AMRSThSf2VTAApr9/sQJwcjvug==
X-Gm-Gg: AY/fxX6MWVbvndBRV1c77pBJ6IUAjBdpjoQT3ldJ+bIb19bmPfeNQvfPy3xRrswd/7L
	hu81J8nkoY+sCD6Lf9ozQYb01Q7CcxVNpOSWXHGL+GfMOfKUAIFlVnOs6oYB+ktcFd0lYritkLb
	yYK1ZIRjEPa0Wjvfs50j4AE3+Z+7Yjk0lzgUB//Quxv/DpRFOVzqlS+g4BtakP5fAGc/m9EaeNz
	8zcLo3KCeVKokNiETos7/6Go+aXPcUSJ8Eymka7vUJZ4k/7a5WuCLgQV1iW1tmdcG4p7WPUWPBm
	5vi8gbOgIHFm8IqMOWxNBO2aHL+adbntm2YUaoKGeIzwOGV/SuABgWFl024udg+wq580A2NYVwi
	GXNLXREty+W3Xcr1i8eWap4lfj3vb2I16NLY3ndfRAEio
X-Received: by 2002:a05:6a21:338a:b0:35f:6e12:186f with SMTP id adf61e73a8af0-376a7aed68cmr8628729637.23.1766352989837;
        Sun, 21 Dec 2025 13:36:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd1nWrqRTbCiMSBO6UqtQqKGo3Vxxy0BoNOtDC2XC5Q4ZeI6Hvgt2VnL6bDeMMm/1vB1QfNA==
X-Received: by 2002:a05:6a21:338a:b0:35f:6e12:186f with SMTP id adf61e73a8af0-376a7aed68cmr8628701637.23.1766352989279;
        Sun, 21 Dec 2025 13:36:29 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dcc7c8sm10950163a91.15.2025.12.21.13.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 13:36:28 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, saravanak@google.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v3 1/3] of: Add convenience wrappers for of_map_id()
Date: Mon, 22 Dec 2025 03:06:00 +0530
Message-Id: <20251221213602.2413124-2-vijayanand.jitta@oss.qualcomm.com>
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
X-Proofpoint-GUID: RYFLGSX-B1zP5C9Wcx7qOWtS6hCCECFM
X-Proofpoint-ORIG-GUID: RYFLGSX-B1zP5C9Wcx7qOWtS6hCCECFM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDIwNCBTYWx0ZWRfX4gXUW3nBS0Em
 TsqjOFZYsP9C+mYV7N9g7uUV3+3RzBEAauXqMWMpNWc4GEZvxOFfXR0V62vAaFQ4FDHNT1JU1Vb
 nuJtVIaYcIFWBDEyUABOjf5Bzikw/xEXVXV5mRIqdQse8VlKIQ3CNmsK1ysnGzzc/Be5fr4lo6w
 x6tJfAUXfBMEZwBjYteACarZGwI6Uqdxm8Xb0MKkGR7VFqlgT+wk7GXtT/iDgq+DpESpyvPpxgg
 sdqahuQvhvlqD0fsfZbLcPl+dlGh+dWC0iHJaIEM/BadQiApN35lyz7dOMVaN0NuPyQNkg/n1o9
 u7WQh4uDN13HbGu6fUW1/QnFuXnd7LOLIYCuHllEgeMee9guO54zqoSAP+NwxemOMLd7ofOib1Y
 Shg5cQY3oJpIP0oOF0vjgUwpEv4AnyZZol2o4XttoCJXAJUXp2jQkto1w6RIvOMtm8spJjHOs32
 3ObyW8XIDUfIDqf/kxQ==
X-Authority-Analysis: v=2.4 cv=N6wk1m9B c=1 sm=1 tr=0 ts=6948685e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zC5qE-s5kk4CCBLE0fQA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512210204

From: Robin Murphy <robin.murphy@arm.com>

Since we now have quite a few users parsing "iommu-map" and "msi-map"
properties, give them some wrappers to conveniently encapsulate the
appropriate sets of property names. This will also make it easier to
then change of_map_id() to correctly account for specifier cells.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
 drivers/cdx/cdx_msi.c                    |  3 +--
 drivers/iommu/of_iommu.c                 |  4 +---
 drivers/irqchip/irq-gic-its-msi-parent.c |  4 ++--
 drivers/of/irq.c                         |  3 +--
 drivers/pci/controller/dwc/pci-imx6.c    |  6 ++----
 drivers/pci/controller/pcie-apple.c      |  3 +--
 drivers/xen/grant-dma-ops.c              |  3 +--
 include/linux/of.h                       | 14 ++++++++++++++
 8 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
index 91b95422b263..63b3544ec997 100644
--- a/drivers/cdx/cdx_msi.c
+++ b/drivers/cdx/cdx_msi.c
@@ -128,8 +128,7 @@ static int cdx_msi_prepare(struct irq_domain *msi_domain,
 	int ret;
 
 	/* Retrieve device ID from requestor ID using parent device */
-	ret = of_map_id(parent->of_node, cdx_dev->msi_dev_id, "msi-map", "msi-map-mask",
-			NULL, &dev_id);
+	ret = of_map_msi_id(parent->of_node, cdx_dev->msi_dev_id, NULL, &dev_id);
 	if (ret) {
 		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
 		return ret;
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 6b989a62def2..a511ecf21fcd 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -48,9 +48,7 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_map_id(master_np, *id, "iommu-map",
-			 "iommu-map-mask", &iommu_spec.np,
-			 iommu_spec.args);
+	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args);
 	if (err)
 		return err;
 
diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
index eb1473f1448a..0884c4cbd245 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -166,7 +166,7 @@ static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
 	if (ret) {
 		struct device_node *np = NULL;
 
-		ret = of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, dev_id);
+		ret = of_map_msi_id(dev->of_node, dev->id, &np, dev_id);
 		if (np)
 			of_node_put(np);
 	}
@@ -211,7 +211,7 @@ static int of_v5_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev
 	if (ret) {
 		struct device_node *np = NULL;
 
-		ret = of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, dev_id);
+		ret = of_map_msi_id(dev->of_node, dev->id, &np, dev_id);
 		if (np) {
 			ret = its_translate_frame_address(np, pa);
 			of_node_put(np);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 1cd93549d093..9549dda8f9d6 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -725,8 +725,7 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
 	 * "msi-map" or an "msi-parent" property.
 	 */
 	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
-		if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
-				"msi-map-mask", msi_np, &id_out))
+		if (!of_map_msi_id(parent_dev->of_node, id_in, msi_np, &id_out))
 			break;
 		if (!of_check_msi_parent(parent_dev->of_node, msi_np))
 			break;
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4668fc9648bf..c8da2e88e9c6 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1106,8 +1106,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 	u32 sid = 0;
 
 	target = NULL;
-	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask",
-			  &target, &sid_i);
+	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
 	if (target) {
 		of_node_put(target);
 	} else {
@@ -1120,8 +1119,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 	}
 
 	target = NULL;
-	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask",
-			  &target, &sid_m);
+	err_m = of_map_msi_id(dev->of_node, rid, &target, &sid_m);
 
 	/*
 	 *   err_m      target
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 0380d300adca..ce21728d6e51 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -791,8 +791,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
 	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
 		pci_name(pdev->bus->self), port->idx);
 
-	err = of_map_id(port->pcie->dev->of_node, rid, "iommu-map",
-			"iommu-map-mask", NULL, &sid);
+	err = of_map_iommu_id(port->pcie->dev->of_node, rid, NULL, &sid);
 	if (err)
 		return err;
 
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 29257d2639db..b661f9c1f4fe 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -321,8 +321,7 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
 		struct pci_dev *pdev = to_pci_dev(dev);
 		u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
 
-		if (of_map_id(np, rid, "iommu-map", "iommu-map-mask", &iommu_spec.np,
-				iommu_spec.args)) {
+		if (of_map_iommu_id(np, rid, &iommu_spec.np, iommu_spec.args)) {
 			dev_dbg(dev, "Cannot translate ID\n");
 			return -ESRCH;
 		}
diff --git a/include/linux/of.h b/include/linux/of.h
index 121a288ca92d..8cd486d89da2 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1435,6 +1435,20 @@ static inline int of_property_read_s32(const struct device_node *np,
 	return of_property_read_u32(np, propname, (u32*) out_value);
 }
 
+static inline int of_map_iommu_id(const struct device_node *np, u32 id,
+				  struct device_node **target, u32 *id_out)
+{
+	return of_map_id(np, id, "iommu-map", "iommu-map-mask",
+			 target, id_out);
+}
+
+static inline int of_map_msi_id(const struct device_node *np, u32 id,
+				struct device_node **target, u32 *id_out)
+{
+	return of_map_id(np, id, "msi-map", "msi-map-mask",
+			 target, id_out);
+}
+
 #define of_for_each_phandle(it, err, np, ln, cn, cc)			\
 	for (of_phandle_iterator_init((it), (np), (ln), (cn), (cc)),	\
 	     err = of_phandle_iterator_next(it);			\
-- 
2.34.1

