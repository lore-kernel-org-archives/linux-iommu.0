Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524434321C
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 05:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770788511; cv=none; b=dioHbVu6WMWXi/FYLPTvJj6lQhceRZ/+p/XXWIJCS8b31/CSBZJHCWYol35zI7AQrcIClPTGTUGIhpAEaq9Ppy4Jdc6JMUvl5b0rUiT8lARsHsc1Rj9xm6svhoVy+MtwEtz0xR93iJMmqY0/94+1O1MucslXk9QIKilg2iEycSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770788511; c=relaxed/simple;
	bh=62wE/dFO70wWM6jtNkIEjSDoZ/uTZDrsSnyLOGNH7AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mwh1dUZRlDFy06aOlEu6qGwSBSCPwX475kC5OCsOscRBzArsygByMKfoo5ch8bM4eyx9yDdqUpdxnD1NT0pccCErfljNsLiUzQsQHiviACJpgHU3ET/CazEnPxkKY5XtHx+rLg/qBFJHrR57mmG0mAxe2i3euZznv+PIceG177E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CqOc8hZD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dTYCE3Qh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CqOc8hZD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dTYCE3Qh"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B2Jxbb4128545
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 05:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3ukvPHoLd8R
	ybKSkJJjyIW6Pfs0lLwz5oAOgnyruNtE=; b=CqOc8hZDMLTBxxbQqQK/WNgBngs
	ZTY8mmVLI9SXpAr5LnLvwZTP2NAg4qHtYTy7ZgHwZff4eOPP9WhWn7mTO5VPSfpj
	hOpieoOGOKOB+JRnVfgF1OBz9zUkUoJBvLhlKKASLrHRWd1ipmH5RXZ/NaddnSOy
	dCW+AcpWGf6HGBO9bYPrWu8lQqx5bvVQubhUplD3+vQJlo7lsdHFdaEBneivmMpj
	Yv4vUgBMZJBO+D9NPEMg59fgRJyn3a+XVF2f+QLWVxAB7bsZfzkUb5kBmC0lQ32F
	YF7gnQ3mTLXoG2oXWZ/ESFLb1ERlzgUTNbESC2GdQ5awLijPXBH9TBMtO5g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8gvm0fcm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 05:41:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aad5fc5b2fso16353555ad.1
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 21:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770788508; x=1771393308; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ukvPHoLd8RybKSkJJjyIW6Pfs0lLwz5oAOgnyruNtE=;
        b=dTYCE3QhAmL0wfrTghxWrHJw8GnqGXB5rdYvwDbzD6nM87JroVPEkgqVJV/2hm5hko
         1zow80MydmKwEi9oyKi8w0PVwZ5YeI3Xv2bLsPBKw6+59X5NrtAD4Amfd0HV4GECcfOQ
         FMti52lTtmrXDrx3XT1HGeSjYMA43AaWWAcnP8PwDl/Am3AcN1Y530xVpCK7PBn+Rexx
         GWaIFIVJkKmzS8VrtXUzGH2EavcfSUGj1e9R3jE+5Xq43yNa19hixL2aYTdPpSWZDPIH
         kP0BiB9DxiPw8ZHBNhV/YwQySyWvGNqiuFEv1i1fyxNSpiNZIL2xAoaUIey4uP6h+b2W
         poYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770788508; x=1771393308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ukvPHoLd8RybKSkJJjyIW6Pfs0lLwz5oAOgnyruNtE=;
        b=sAF3b1/4KlFTdXTlHEZ9Ri4zQT0tOgPIr3G04T3QneOgbq4M2YJc/ixS5nPDWDRnz/
         75KB1HSHKi/mZsFzUdjuxH6UuH0HF5Go+I1sQL8Ne5OZpQy4HNt6tso57l4mE2xbGN7d
         txk00FMXIX0I8cS9aKYMKilyS5BLQq83vvQ/Gjnz4+kw49JWzcoKPJlGbDi88FPWcMR5
         5tuf2qOG48C2tWEApzL4IuQEq7GQpPDDeU5+IFKsMFt9I7J3Fai6un0cnRAjeutENumI
         57D71zCsc880+M1Dgui0xQT6QSlhJv95FjMChR2d7mHm7j3Il24E3uHKYTu/mmttxvNs
         f7PA==
X-Gm-Message-State: AOJu0Ywk1fq0SalnWEI0clItE/Iy5uvwJ4NvOMwZkD1Q+MDwruMH1l8c
	ZVQcmE7JljZInYiLbxtq+E2dnmGnuAfyrkeLkddO7kB7+eIo5BZgih/fNDFT8JSbpOaPC0RY9JL
	iAovZeozZUXTneD8sr8uAtScuZqmfOrEEL/eryllZRpb7Mm6VrCEX0F/taQ==
X-Gm-Gg: AZuq6aKVSri2g5xW2lw8f5eeNIM8Raq9+I6ujSlg1SQBrGtO3XRszVE6XEl4/ztcnWl
	0AYMo6+F5rQEmjc+0D/hszKc5Lp8G1egDZVMXu9254HISCiZXobmDD7b1LiEGc3JH1sr3/XnUJ2
	IhBqhsfHVcDLFYezC12XZGXUrkS3X6WtSb/s/GWowkdCkAIP12q4Xz51lj2XHco7XJnj6CjdCCC
	JZS+CNIQ7n52pJx5/fQv7eZC0aeXWXSetbaQL1FyJLaYMIaOJzBZABge0qlIBZbUN62lyZGKj8i
	7n8IMvcpATiIWAZLftN5W5ij51zDcfJfuDJo4ldoLkcsMOv9apLNzpAUiMmR4FLroaIVmBfIIEK
	MMXS6ZrMhG6N2y1Gq5oUdPdvumaouHQMCNOmMa4+ZCIAI+Nw3pC1ABGeO
X-Received: by 2002:a17:903:2f08:b0:2a0:9fc8:a98b with SMTP id d9443c01a7336-2a95181196fmr166691905ad.40.1770788508441;
        Tue, 10 Feb 2026 21:41:48 -0800 (PST)
X-Received: by 2002:a17:903:2f08:b0:2a0:9fc8:a98b with SMTP id d9443c01a7336-2a95181196fmr166691725ad.40.1770788507959;
        Tue, 10 Feb 2026 21:41:47 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2986f0adsm9932875ad.26.2026.02.10.21.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 21:41:47 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v8 1/3] of: Add convenience wrappers for of_map_id()
Date: Wed, 11 Feb 2026 11:10:31 +0530
Message-Id: <20260211054033.2796660-2-vijayanand.jitta@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=ctiWUl4i c=1 sm=1 tr=0 ts=698c169d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=wrOk0Nx1w3hKWqktZycA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA0NCBTYWx0ZWRfX5pbS7Ve3Qzfp
 jSL8XAUUxZCBFS2M97gLdGT70eFKzm0jdG2SNoQy8R2PAtdtvS9iSoxoo4XPpa42cIHdEpCYjq+
 ziYokdS1kOPh2pGPLkpfhtHRfaXy4eh63GLV8dwac8IcxeDvfgkMRynE1dyyaWwrYYUu3Jp8wgk
 P2MhxIyrSwQ6qFFhOQIWbd104WTq8I8iiWpnKFde+VWHhXiSplINuykKfn0kHC5c8RhHo1Tjlac
 HIArzLRXNDAAmHm4pH64bGGI1zWUGlVAvXu5W+epGuTpCJuYQOb4fhBH1iuRcki7mu/QSemCxmw
 qlEUNp+WzQW08RVqrOL7AC61jbNFM7OvaLpx2LePXis+fceJBNdSDET9yfJyJLg+Xf4mRR/6aEK
 H5iMzslavm3y/yit0y+34O1gONGCSD+3IWxZY1DdRkByzZjn8/rNlBy/asbO2j5xrvVNcGl0peG
 gSqSdKy1iKpXDuVKx8w==
X-Proofpoint-GUID: ATWCitilXpia5vfabfoLn-w6F8idaio0
X-Proofpoint-ORIG-GUID: ATWCitilXpia5vfabfoLn-w6F8idaio0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110044

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
index a832cdb2e697..b30d0dc0a1aa 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -179,7 +179,7 @@ static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u
 
 	struct device_node *msi_ctrl __free(device_node) = NULL;
 
-	return of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &msi_ctrl, dev_id);
+	return of_map_msi_id(dev->of_node, dev->id, &msi_ctrl, dev_id);
 }
 
 static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
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
index a5b8d0b71677..bff8289f804a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1144,8 +1144,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 	u32 sid = 0;
 
 	target = NULL;
-	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask",
-			  &target, &sid_i);
+	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
 	if (target) {
 		of_node_put(target);
 	} else {
@@ -1158,8 +1157,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
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
index be6ec4916adf..824649867810 100644
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

