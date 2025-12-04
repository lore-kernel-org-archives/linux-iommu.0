Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A24D29E109
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842151; cv=none; b=jAG8JuJaXQ+YhuVTUPcpGMo1AYiKB6DdxRTtlDSV6TExP0OwacZrNzPc36TijkChRWwZKJtW4C5DjXtUWToBv5vy+M8mfVHLSgyS1+P1rrRw42FzUAhUAtGKIEsY4ei02H9W3WZdwhFWIMqK/U5pFj72kOyDJgH9vHnndyekDno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842151; c=relaxed/simple;
	bh=Q5WRkKpyNFdbwHCAdlIO1JtLhoqGJ6yKGFP0g8RLsAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=meYnF1gvqqEydiAl2KgPCML4FD9bvGNFsGe4bmjvT0VeT0fOMXSgAPMezK9js+lzz8NkaCcTUhy3KGmz9t8gijePBxSilYzdEvqYxUeOV+f3SgOaYUBTSIeGHMxueZn0r+8woh07P6Y6+fk/vIcf+/f/qlzQMOJF4IkjO89SScQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ccbgS7Tr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=THoleQfK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ccbgS7Tr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="THoleQfK"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B48bOaK830190
	for <iommu@lists.linux.dev>; Thu, 4 Dec 2025 09:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RTHii2RLOwx
	Qg87de6ltvKhXlBHDtZXgHyW74oiIDH8=; b=ccbgS7TrD/txKOXrC+7Ky0N5IHE
	WW7nfIV8WgcibHa31F654e0SBk/lyEFbyzuk/fLUv+u85TlyZZZAwSeY20cr98M9
	7gUo3GxVfkB7q7xVHyG/GHEXDrKrSJSPw2p8bkGDGRFHL+EkOUmagHbTjZYRTyGk
	S8uu7VqW71klRBgiSGhp1XSu+KaGVb/yvjqC6wFzcevZrJ0N+GZQLVrx9zDBO5cl
	Ac32ZjywAakm/AwyPbDJVG+EUQB4Gk8gGgaK7MU9+uxU1LRAgJeYTly9V8x7ZZ/Z
	wgL7b2RnKN2TcKFAe3vSDZScNOA2A/cq5HMQHF4gvZC0sn2M7NnLPnwpAlw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4au6xp0aqm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 04 Dec 2025 09:55:49 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b4933bc4aeso676348b3a.2
        for <iommu@lists.linux.dev>; Thu, 04 Dec 2025 01:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764842148; x=1765446948; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTHii2RLOwxQg87de6ltvKhXlBHDtZXgHyW74oiIDH8=;
        b=THoleQfKAdrPH6YHBK35MX+9sSEt+Eq6TYiioJ3Vaj1NgBKQF6ZsejLD1CNLHGC1LK
         Syn6KHlWtF6kVeeyR+77p1pn+eoJ8ya/gXx3AzrylC0UVxrqRTua7zSyoDiwqiRCvFip
         RkV1gSonIYHHlFMrD6SE3XdrWO/p4WyZHUA/SCKwLichbewK8PZI0FCJzf2h7fq6R8WB
         LfamNJQcLLvIzCZmhnZoVpnEDowO4Zp/0FWPm9PROFbofJf+dXnHWZ2Wl8psZrYSTFpW
         NpCZw51SFBmyDUJG/ddWPuoDl07hig3oNmcXpsVS4vMOr8hmhpnYSmrgqwiy5zVSZ8pp
         DU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764842148; x=1765446948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RTHii2RLOwxQg87de6ltvKhXlBHDtZXgHyW74oiIDH8=;
        b=PCGwGOSdQMDy63nGi1dFvyyMDC9yMqFQfhdajEBklKzRl7VeszsBLfi6oYkByfNdo0
         neMILU7lLasjhgxCl4X00lIY5cEzYJjdkzOXliCFbDQLmdh9m1YnrM4oe9y6e5qWGLNO
         Cnjmr5jPC1/7MjY4HaFmbQpwOtD2fMIiF6hljZf03lvFe1ChtF57f6sJSyAJHRiB684h
         XvMOJw/2ekd7CkKpLn4qIvv7LqKvXPU69nR0dkDNiDMMnHqCQa9KyILVr6bo4rW6jwQs
         8FlImLUDNyqwOE32H+AJ9yI8uLUBxyGvJcL3Ghr6eEJGP5WB8iaMYnnJcykMGQNUR5ap
         ETzg==
X-Gm-Message-State: AOJu0Yw2UqEhXsw7Pwa0nTQ+WSH9OBpXFhFS07SGz1s1DJKspV0Y5w/6
	RXiHtBbE3vbCx08IcXXCHHGkJ2YQg+eXBPG3oo7Z8UrUgZ+VSA9Re2bg4TOsTxnhDOr8MXuC94+
	NclJfoNpXF8s1la4jZjSdQ6MbiAnZ+LPuJ49GBnoOO7FNCJMv4ejMp+6/N8W+VYUHzw==
X-Gm-Gg: ASbGncsm6Wqp0h+eF8ZglQblcwtrdESR4R2lW3bTqxTzS8ehp69OzTxqOTR8gP2d2Gi
	CRfThd8SdY5/Wnd5ktvNK9xwkx/BYD0mZNhLCPztwnh3DFJ/LR2r31sBKKCqAMckrwMwm8TYcJq
	UJQNdpI4R2TnCol7OoWSEyyfm8IqhtVHo8Q/235o0EpXfYs6sUeJ1TM1DKM5f/3+Gw16XrXknC5
	znLbzcZWbZyqg7vJvp89UX/GL0lJOr9yq9R7p6Mro5FXwhwDiHYsl3TDbVMD+bQcja7MAceofpz
	MaSxTJOFUweelF4QElfU0lC9XI0+Oal913v5vm3QSxMpm74hfXdWzURle764Kpb8SpUP/YhnML3
	wVYYTCsORHlfgc2lR0nPI5wZ1vxS5Gz9SSYQ9RDmUcTkt
X-Received: by 2002:a05:6a20:914f:b0:35d:3533:3dc3 with SMTP id adf61e73a8af0-364034d65e7mr3167137637.0.1764842148335;
        Thu, 04 Dec 2025 01:55:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3bSXLdxVXUYRIgsjlgz0h6EiUD4YFBwgWd3A851Q4FLR+fZ2b9jkBuDemkSTpDV7tY93+Yw==
X-Received: by 2002:a05:6a20:914f:b0:35d:3533:3dc3 with SMTP id adf61e73a8af0-364034d65e7mr3167110637.0.1764842147824;
        Thu, 04 Dec 2025 01:55:47 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6817389fdsm1380436a12.1.2025.12.04.01.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 01:55:47 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, charan.kalla@oss.qualcomm.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vijayanand.jitta@oss.qualcomm.com
Subject: [PATCH v2 1/3] of: Add convenience wrappers for of_map_id()
Date: Thu,  4 Dec 2025 15:25:28 +0530
Message-Id: <20251204095530.8627-2-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com>
References: <20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RKW+3oi+ c=1 sm=1 tr=0 ts=69315aa5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=zC5qE-s5kk4CCBLE0fQA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: Ug_BIsEqs2QmiMY7z88m0Nkp5qo0Ua6H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDA4MSBTYWx0ZWRfXxij6dDXQrV9h
 ApR8/XsWXB6axKSssAMS+LVnOE3N8p8P95Smh44LfM8/7YnwNJY+juq7j/7St7TMEHeNSBBVddC
 xWQfwEPyLfPp5FCWLsSYlRIz7asqOtHSH2UFmBhw9WcxIex9qML23DH6iAWuOFMSgqXJwNkS8pz
 bXx3iuC+P5sRDeLePK45XX9CRORZCRYNteXaOEbSsOoiopbPfDnN9d6qXWWtL0o1rjHYF/hQleK
 PPhya1vS28mnx9pf3EXgENTpa5QMLUmWvBg3YJtx4YiClPQShMO2z/qcMpmOwBRJa3nwTOMLZ1p
 Hl84u4gD6yfoP8aDPZMVP1nX2gnzQNDgfwQizs5c7HSGDL+Wa1a4L3mD1B1z+aNS0+3xazsYoVc
 yHDyJf4qEC59GfcdR24iLQdRE2zXPA==
X-Proofpoint-ORIG-GUID: Ug_BIsEqs2QmiMY7z88m0Nkp5qo0Ua6H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512040081

From: Robin Murphy <robin.murphy@arm.com>

Since we now have quite a few users parsing "iommu-map" and "msi-map"
properties, give them some wrappers to conveniently encapsulate the
appropriate sets of property names. This will also make it easier to
then change of_map_id() to correctly account for specifier cells.

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

