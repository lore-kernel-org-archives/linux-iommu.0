Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE912D1F44
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760058; cv=none; b=neKof4q/BhtjM+lvMl+uN5yYek3vQEu7CKqeT4rEyL00j+T9W2aF5/P0pjhIMrVWRzoO3A2R0bAXh5VYwQHcXkmwzFnsXHrnWkCPz915Hoib555qQM/5sZRKQDPIN/DbG67LKFXCyLIbCtVcgY5Qb7fq4aA+PoXvSrsbVRw5D7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760058; c=relaxed/simple;
	bh=vkcDznwWj/qjFMBulKmjQOCoF8Ar2DR3hx4Aku8xDU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dk1IeDkrLVs6igkXgjXxpchRRMRj+uby6tqN0tLZ6+PZdJltf5NxsqwXPPuCxoK1HhsNvr1EjffHVmFOnQdlJsF43gqFR29856+yvkw0sjBFWUWyF96HtkSeUyiHJiZJamvLSuAbbVQkjH7D4ao33KPDQh9cyyy++bhivT1eRAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EzN+2k4N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BqkCdPMX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EzN+2k4N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BqkCdPMX"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60I7dMwJ1772667
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 18:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=67t6RAhLzyt
	rgRuVauxjrKxLIpAZrpKmZdGn8t+btIA=; b=EzN+2k4NrM7LuXrWo7G1bUIbumD
	OTNAK1l+TrY4gyVn7XnIgQyU6eyUGdOGjlFjAIfHm6sBAITz/2HEUTI99W8gWt/r
	B8ZmG4egbpUH/U7hy5A6xnxplPWDsLrfJVnZ8C5utr+ktLXkrtfIZN55IqC5vg5n
	JY0pWIUNo23UDKTY5IY6A2kEAx71yWE7ZI5stIsu1FUTEdSFBn77123+rZnbRrBu
	ueX7ztwOcBiuiO/dzRGkqOofKnm+Id2r4CgAE8HN4NJ19vHlx5hoDB1FbpNMAqVU
	gSlWjTLdG55FQBiXMu7HWOrYANMCnS1qb9l/GkHQdHaBUJKdripqciSWV1w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br3q9an3n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 18:14:16 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-81f3de65b79so2333861b3a.2
        for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 10:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768760056; x=1769364856; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67t6RAhLzytrgRuVauxjrKxLIpAZrpKmZdGn8t+btIA=;
        b=BqkCdPMXeS8tBI4MmVlBp6DhdUGpxKmkNQCtEox8RAucYoa8Gv5WpbMGilIKEvvmAt
         /Ww2xPRlfzJzyLBoOf1hMWgCBXfW0k9ADF8zvVYmO73v9VgUwynq0Y7wlShgT23jlPKg
         Vicph5GXKlXjAVvMkJ0YbpxYG5qQzeNH+d/30GVQ8U82GuD/NktUbq7SVNdurrlwevUa
         KhrnwduFp9yw4ROA12qcqGgcKuuSaQ7D9qMHczFvARo+6RPrNqHid8Zg6ORBY9LtwAnC
         qeWpvqIW4Hp02lpL0lqTTvLNlSUR65AzB5mXXxdb1u1VPhhLsHXfwRCfX4WFXXtFlJhz
         TP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760056; x=1769364856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67t6RAhLzytrgRuVauxjrKxLIpAZrpKmZdGn8t+btIA=;
        b=iIjfVbsaBwMYvp0W2EqvWoSVxUI5vODtFCqE99vdrmwoeYP25lMNvlhJG7pCznbGte
         u4stDAOxb2O2VSimzjYhRhGxnOlOdWvuKB++2KXq2Xk1kYfiV5qpaD/bFHUX0l0T+jPM
         rLQoTfHY/MA4oTEOV6gC9enVFzb5+3b05uMELa/ncX3WQ34TzOBLhHo7VIQDaBPvitPX
         +Sjf1pxU1vR0BwZc9fmfTRIZFUFM4HAIovOeHiTBQfdRAH1zKXGOhIAtmqvQv9f+rzRl
         QfDHxhyfH+onpkNWPjg11oIuXER1pOESX0h06FQqP6GWIYFwVKD5aO58/yikwfHlVuMJ
         Xo2A==
X-Gm-Message-State: AOJu0Yw+G0ODhmwzB1Yg6UsyNXgP/+znrvzXQl4nTdXByBsjRkJ7Vwz+
	8O6CKZMS3Qk+8FjTWzDGQAgaRmxotMGXm+RAdDDoYqVUHKUep1m+vpuu5AjMYpOnD9LxE6PCYY4
	RbD2VVrd68ONY9o+zCCeKghaX674+E66a6csD71NxegjOmIdbFamsGo5Zfg==
X-Gm-Gg: AY/fxX6JNA7/sRA7Y9zQIVEgcBp6Hakj6nEQuaXlvz4EjRFR9bzDeXeLbeRlyCC+PpB
	XSHSxl0qfRoxSDaNNsd3nTO88UGRmwpn0bVfCjcmXKwErSYLPyaORkjR7KiZtIaWGmlnxBdiyT4
	WiFFsGQN4Bu/d6DvmtwYTudKGR6bl8Glr/CFA4DllJJt1EvahMjMowZzpJae4i5Dn/UQCvtiV9d
	3LhTmqG1pJZAQsZ8zV61dlqj3HrC5U/nTq1naaEt4XsjSiHUXocXTXpYTTRSbFC2fOHEHwPKBMp
	Ng4h5sQhvGizZ2NB/QhnwDo9wCWZ2Oss/tnLIdsPq5c2HwoScQv5M80JjDG7J3aCeiKVtNUDKNv
	9BxgCGXetl70neXU8ReWKx5nlzdC+imkmwuu1lgiZIVQt
X-Received: by 2002:a05:6a00:600b:b0:7e8:4587:e8c5 with SMTP id d2e1a72fcca58-81fa030fc84mr7460195b3a.56.1768760055718;
        Sun, 18 Jan 2026 10:14:15 -0800 (PST)
X-Received: by 2002:a05:6a00:600b:b0:7e8:4587:e8c5 with SMTP id d2e1a72fcca58-81fa030fc84mr7460170b3a.56.1768760055199;
        Sun, 18 Jan 2026 10:14:15 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1277a15sm7070759b3a.42.2026.01.18.10.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:14:14 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vijayanand.jitta@oss.qualcomm.com,
        Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 1/3] of: Add convenience wrappers for of_map_id()
Date: Sun, 18 Jan 2026 23:41:23 +0530
Message-Id: <20260118181125.1436036-2-vijayanand.jitta@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE2MCBTYWx0ZWRfXy6cMnyERlexT
 YzzE2cK81cljsD1GEkAOP42fRIJMCknZSrBEzQMVFo0DkHTld2xeQv5cxg3ThHwtCDrYtafIjkJ
 97frl1M8i3eSgNDRAmoBSGoDZXxy+usQ/O9stqz6krA7aMHGKjfAVqsKJeerU6+pFELKwaVIVUV
 m/PTclEtAu9LYYQTCvp2FjUUawaHA0KxkQ3B5BRKZwPOPPyWzunwPxNCwiOG+zNj/KjuZYdK7vF
 ZDmYJ+KqbCFRjyyxyPbO47aAqIZ2pdpyJhh2DTrchE803YoGuCQhrHOXmVfcdmaQ9gmSK/FlWUQ
 X1L4nFX1485/iKORdPIq3/V5q8X+B50SuxcxzzGTPcyPCGKHR22Ihmd+rTqQyPKUea1gytOjJ3B
 ttiC8rOywscTkrExhhOBwCFS3z3eVkuBHMkpWY8CxDSlHnCLFSVQ5VbjEHOElUvt90m9lrfwPz2
 hM6nWxfgw+3RNCqKiAw==
X-Proofpoint-ORIG-GUID: _F6YncaAWD-j0JZTrI-Lc0zANEzsFtsg
X-Proofpoint-GUID: _F6YncaAWD-j0JZTrI-Lc0zANEzsFtsg
X-Authority-Analysis: v=2.4 cv=dPurWeZb c=1 sm=1 tr=0 ts=696d22f8 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8
 a=wrOk0Nx1w3hKWqktZycA:9 a=2VI0MkxyNR6bbpdq8BZq:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601180160

From: Robin Murphy <robin.murphy@arm.com>

Since we now have quite a few users parsing "iommu-map" and "msi-map"
properties, give them some wrappers to conveniently encapsulate the
appropriate sets of property names. This will also make it easier to
then change of_map_id() to correctly account for specifier cells.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
 drivers/cdx/cdx_msi.c                    |  3 +--
 drivers/iommu/of_iommu.c                 |  4 +---
 drivers/irqchip/irq-gic-its-msi-parent.c |  2 +-
 drivers/of/irq.c                         |  3 +--
 drivers/pci/controller/dwc/pci-imx6.c    |  6 ++----
 drivers/pci/controller/pcie-apple.c      |  3 +--
 drivers/xen/grant-dma-ops.c              |  3 +--
 include/linux/of.h                       | 14 ++++++++++++++
 8 files changed, 22 insertions(+), 16 deletions(-)

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
index 12f45228c867..d5d8fa65c24d 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -173,7 +173,7 @@ static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u
 
 	struct device_node *msi_ctrl __free(device_node) = NULL;
 
-	return of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &msi_ctrl, dev_id);
+	return of_map_msi_id(dev->of_node, dev->id, &msi_ctrl, dev_id);
 }
 
 int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index e3816819dbfe..fb50ccb50cfd 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -747,8 +747,7 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
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
index 1d8677d7de04..c3e5cb3cb846 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1143,8 +1143,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 	u32 sid = 0;
 
 	target = NULL;
-	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask",
-			  &target, &sid_i);
+	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
 	if (target) {
 		of_node_put(target);
 	} else {
@@ -1157,8 +1156,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 	}
 
 	target = NULL;
-	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask",
-			  &target, &sid_m);
+	err_m = of_map_msi_id(dev->of_node, rid, &target, &sid_m);
 
 	/*
 	 *   err_m      target
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 2d92fc79f6dd..a0937b7b3c4d 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -764,8 +764,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
 	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
 		pci_name(pdev->bus->self), port->idx);
 
-	err = of_map_id(port->pcie->dev->of_node, rid, "iommu-map",
-			"iommu-map-mask", NULL, &sid);
+	err = of_map_iommu_id(port->pcie->dev->of_node, rid, NULL, &sid);
 	if (err)
 		return err;
 
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index c2603e700178..1b7696b2d762 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -325,8 +325,7 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
 		struct pci_dev *pdev = to_pci_dev(dev);
 		u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
 
-		if (of_map_id(np, rid, "iommu-map", "iommu-map-mask", &iommu_spec.np,
-				iommu_spec.args)) {
+		if (of_map_iommu_id(np, rid, &iommu_spec.np, iommu_spec.args)) {
 			dev_dbg(dev, "Cannot translate ID\n");
 			return -ESRCH;
 		}
diff --git a/include/linux/of.h b/include/linux/of.h
index 9bbdcf25a2b4..309c5681744b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1457,6 +1457,20 @@ static inline int of_property_read_s32(const struct device_node *np,
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

