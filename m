Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6D4423A9D
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 05:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974874; cv=none; b=SuEveBZFWDyjvW1HDPfUG0lE8SEwxuABMTxbjp3PE40L/XDqc/lyCWR18+sxQIqPbRN1XUHj2r+ZnMl9qo63/yf3vRjuaxUM86Z8bnnQvrE4feoICaPxg2ZYTGWafsLiBnCa+bwfUwL340CKiAcfPAconjTWQhxKB0WRVthx458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974874; c=relaxed/simple;
	bh=ZXUiTl4+2nF18kNLH5IJnoSTF9D9+5pWu6v1dqL2crI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZSGAINEKoI1tyOzLRKZFBCvU+SQieW8oxB8PmB+qb3nYzO2hNiAKVOBWSP2L3UXRXN8Vef9S8yp7mfa3/w5rHXOU+Xr7wPlJWV8g2OVvEiJhOML4u3Nz25pUzolzzXbWx6vJyrl5BxSMzbQqdtBNYrXdMkDd3kIAVXXldNrqU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nyE8Ft1u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JjxXd/DW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nyE8Ft1u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JjxXd/DW"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KL0JAD781938
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 05:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uMbzqoMsnSD
	IM7szmbD2+8L3whOzIkWXJhIlQStUWFE=; b=nyE8Ft1uSqLFegiuBP881seA9mF
	Mr5nWOJ4u7pNaGvP9bXlkhgyBHQC+oMR1NM0UX3a7xH5MAGp+2hjYZvbfr3cpmmf
	EZ28VlfZiQMdF6pIyjmZo7CyQ6VXGWH22LB3+BmE7vYcocH835upHDfJmi+XBhz1
	kL7vihwlhe8YGDtY/coobYgPF61jx2eKyRl0J85ir1ehVToIV+kOwbcUwTLcr5iM
	evr/KZwBnYsGC0T4Xttrkmy7QVDYuKvMGYsrFBn5gkImNsG2Ok5WweL9W6TCdtbU
	x9LBonSGavI9QQ00krjqfHAjqNj58sk7jn5/G6N8C2IU27Hf1NUjtWttR9A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btatyu5rk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 05:54:31 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81c43a20b32so5157040b3a.0
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 21:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768974871; x=1769579671; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMbzqoMsnSDIM7szmbD2+8L3whOzIkWXJhIlQStUWFE=;
        b=JjxXd/DWGhtSOlkpP60ta40nSY/n2V3+4GwDl7enBgw9Ms8qrlSNwFb0lg0tpu7SDa
         QSYj7Aool3pjtUpwyauJX3+KmG6BgPCl9ShCt53LwBcOU4mlvEQGD6AabjTD/t5W6UuI
         PyjDZH72tl5QziglsaYktdO3etI2UkwxkegRMuQQY6ZKW57J+vMORb7P2MYbRaCLFhqT
         GyXEtO52rC3PpkDQmIUo8zbJOZz4S1Nm2BEIXvYXYbwRH9T2mLJmN1s0xB+i3KjNdHDd
         Qbu48/dxD5FT3zOmlf8hZDWRf1rOC1UuHFjV6JQH38JgXrcGOIo17ljtRj77EbvlCQ3t
         oL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768974871; x=1769579671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uMbzqoMsnSDIM7szmbD2+8L3whOzIkWXJhIlQStUWFE=;
        b=KlG9U4Uez25c6iPEQZtVzDWwmqYrYFrmJb6kKWTTdDDccwSaXu/qqe7IJVmbNImZBp
         s+3+XtHIBP865yP3ov8YRDgKKynuc66Wf+HqBj0G4tnYdNd3NhQ8Hmb5Y2Jjqj60qwT6
         9jDNjjHhRTaB/Wqkj3WVpPYYSA7Q6KKXqxjreyd2XEhweP3bMABPWrk2fHuQc1a+jTq0
         FnJa7RySh8NS0Ah8sj+8n9oP6vlF5qNEnnTWo5WnJQ7fsq53lKpE9W9Mk5VXHfw3UGiT
         ZOfx6GnHQ87o3PfMvOa+XexDq0LY3EdORHMN1ltm1fHeda3Qq5jlYXRyQqK5+yewzvfm
         wh7g==
X-Gm-Message-State: AOJu0YyzS4e5dMaz6XJStb9DZcmcprCI9t6ox4iOMYom1qKSW1a2TzhU
	BDBskNro7LV3k79jIq5CAvsXi3965TkjPitTZr+ZoVqjAXo9Nq6mjnCdmadk6p5sa+VZ8ZFYeW8
	ZyG7lBdHNS4NqXBUrfj874wtTpC0nuEXlkSFtjQWoIi6WspyAeF3rwhEWVA==
X-Gm-Gg: AZuq6aJJArc3k9/bTHDso4skFKe8OmMu2s9gN24NCT+Byb0lAzh+PrkKSGaLiMx0vsd
	fGzwJA6lB02jt2SsmNjV7xPU32BGEevbUf5xnW+KwKZESp/WDe4Adj+KBoeFcvsMxWoBEJxe9Uq
	AsbXOqQwFvquUW9238bwaC9QLPja6vRknAdBDl/lWYh0oxR+sAAn2E7CryC8wkT/G6CKtEQhG+4
	A2P2DlS2p9bhPwpA5uPjJfO73f6b/hRIlmOwVjdA/FoIurXs363cXX/tVukjgpCOjePl+5F3uxQ
	qlaS8U1YkwwfOJyNFUOxr/YTmaiDRMO8unybZj1LRBLzwaUSl4F//ApTFz9fkNPmb60SDuqxiF2
	JEWnVLNBMcamL4Uc2aO2XCpRqvuMS6vqJRYRFWom/Qarj
X-Received: by 2002:a05:6a00:1805:b0:81f:5acb:55e5 with SMTP id d2e1a72fcca58-81fa1771fdbmr12076102b3a.2.1768974870719;
        Tue, 20 Jan 2026 21:54:30 -0800 (PST)
X-Received: by 2002:a05:6a00:1805:b0:81f:5acb:55e5 with SMTP id d2e1a72fcca58-81fa1771fdbmr12076083b3a.2.1768974870203;
        Tue, 20 Jan 2026 21:54:30 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1278061sm13831927b3a.44.2026.01.20.21.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:54:29 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v6 1/3] of: Add convenience wrappers for of_map_id()
Date: Wed, 21 Jan 2026 11:23:58 +0530
Message-Id: <20260121055400.937856-2-vijayanand.jitta@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA0NiBTYWx0ZWRfXzPvGU6rPJOQp
 vLLw4AHs+KDWDIiaSCwfemKy84JLJyFfSz6j8CMjGUvrljP64t/zXfoHDSE0aQkH6FkqxUzRWyC
 iuJusHDDTW6QNCGvoJvCJSIcCRqtKmYmd9m8tRfBvAbXdG1zV07q0q84FInVe5apZ9SG7BINLQn
 g++AgKucSyWuQH8Sg6DQMW1Yxc7XI+a57Obq3OnYyJJckpZ/dxgELnvf4h/XwmWfRnY/tjTx9+T
 2m4pRUtnYXsaPZckWdnzQyoHV+bFtgbdHXuwSDpRWULzg4AzYU8WDugFUM1dcfXLKCxEa5oRvW8
 5CZZS54vnIVeZ1UqRdHcV1GdLlXRFUAENPI0H0pMj7BoHBoGywcBUcPdNlYhe/iIm/6QVOupwS0
 IFxD+KoTUsA1sEAZkYBWEhwo2mMmzQkATeTAPb3Oeb6cEMSFjT9YyZBJfVUAOehxaUqvBcnh21P
 BjQVIEaM9m8L0sz1DMw==
X-Authority-Analysis: v=2.4 cv=IYeKmGqa c=1 sm=1 tr=0 ts=69706a17 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8
 a=wrOk0Nx1w3hKWqktZycA:9 a=zc0IvFSfCIW2DFIPzwfm:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: EM5jZbvlLtt3qoRkmlK04UxfBzUPaV2G
X-Proofpoint-ORIG-GUID: EM5jZbvlLtt3qoRkmlK04UxfBzUPaV2G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601210046

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
index f374d8b212b8..ddd046de70de 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -817,8 +817,7 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
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

