Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E06634CFD9
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718359; cv=none; b=Cg9t+pZYC+5e680Nn5Fm1ksi7vOdbkKTxHGfMHROYlCD+YGjfrowftx20scUTGLHOW9kmRH5Tqb14IY82PVu2x5vggiQ4jBmieCjkx3ns5upGXuc4wtCO/ewzGL1DkTbxrhrAAzKIKMsLZxv3FGiorYoM5Pj6TiZuHTvmrqBnWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718359; c=relaxed/simple;
	bh=T3kbuo/lnBAsRSHIuVzth2R+h3EBmwiyu4jVDhbNj38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6LU7RJr43CaDS6duxxBxJqIJVaVQpiRV0DNWtNl/HMF5jPa/TuYoiM2S2VfvbPe6KTrkrQqGlzeFN1fvihxBWgTgXHMdsQ0nB9hJ9PXZb4BmUH11MLzXdHqV+IqD1j+KwxLPn8t/6kL3DMX3EQKwNVGzkgd6UU1VR5R2AgQOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YjE1EBL9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hrLnXHqu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YjE1EBL9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hrLnXHqu"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A6oPTQ857026
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 10:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nLKoY351lPc
	koL8Rw1hfM5rSYnNnXA//kxjH/u8a+nA=; b=YjE1EBL9zpxI3bxlD5nNUIaxe9C
	0nywLf8u9AA1+zIAYgD37WOL1r+K7Ykm2f76wYcaW0dMfVdoxHAhlQ1hAPYWrJh0
	D+uJjVyHdWoXkpII7Mt9cylqzg2uEHzatQ3SIw7GgisqZ3It/ePfxOAmxWiAxE4E
	1ykVIvG5iJ2Ya/l9lxKBmoKnCbJox1OIIsJw49RIYxRAs3LgHRD8R5xp1A9jxL84
	41botvcVfVUfUJUTE4Mlh1WuGIobgZoeI8AtH9ZNZoUwKqkwUiYrjtZC8/xvi5fx
	WPAsJWNfNO11n4FJHOPEUHw72GRbKaz24Xvce13JP6cxb1NuIXgbwdZ3cRQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7ga63sfy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 10:12:37 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81f3ed6e935so7967328b3a.3
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 02:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770718357; x=1771323157; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLKoY351lPckoL8Rw1hfM5rSYnNnXA//kxjH/u8a+nA=;
        b=hrLnXHquV2LDLaw0MPjlZSGUbZoGejZvD7gsUopakuLw8/Alj6J0+gLNemCD4BHaW6
         lqX+yQl/6xhn5rkuWIDqpqWadC2pa7AepUliszhznYqvTz0Kh/ehUWuB6V8vyqD5eExL
         bYXK0jEbFVfSjP3z44muzLGlAH6CC9ynYVPRLJzlim/CRuEIeNpKAD6EKOv4hgdtY9AV
         gXdJ2hkTg+xpAYyIDguimyf4RHvhgi6oGM5P6EoYGlxhdUz2Ro8GiulwUjD91LGF1eLV
         e8c1hPaehsP0NDGoaeJHeeBCt6xX+YFDETjl+VopOz0Nu33blHS5oEmfMe9jdWnnEGl+
         9fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770718357; x=1771323157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nLKoY351lPckoL8Rw1hfM5rSYnNnXA//kxjH/u8a+nA=;
        b=kYD3pXd6Y57tOcqdHKzYePY6ryGgCG7akrlwUqeX/f4+Siun/ywqzYq+5rjU5/osRd
         0ulyUEVfVlZ/HA3y2KbO3YLB4Hoh+fBxRJtCSwxN26+Z2kyZR2+MYMKZEOjZbvritz6D
         pka6UXJRse/kFti/1EaZ1ZlV6RUOalmLOVC/9TlD6n2DhamoTEIDv9jhzvsaQh+cS+jB
         VZEjIf1q78AzxhOee0FbnBJcYIKspeTFgwe6sc+JdKRYVwTJooSzKyzjD8m/NcDVAUp9
         gTPRbru1RPpAaNXPNnQMGU69+2iX/VkLGxecw7U2kzrBA5K7AT6dbjJSOEe4FHUj+mwg
         yCMw==
X-Gm-Message-State: AOJu0Yzslg8khNwQPHtZTU3oNyeuV0niVKGN+Vx0b4sjLhRfsxk2Ults
	z7fItGP+lFy2gGy7UP444t3SywqHYok+xa8XKo8Jdk4UpOT+XR+xCmtehfG4WWxeCR8Z/7++Vqc
	ZQusREL/bOczdEc7d1Cp2aBzErDoImv0MbCIu/+Qw1XuwwRebVFTUQ03qtLnVQ7+a8w==
X-Gm-Gg: AZuq6aIKZpQebXrVX+2nX+WlS/bh9K0HgnsgvuATTv9ZNAGUMkHX8RxCfcsaqiNZvJy
	gboVHcQvkVBIZ8ecIPNp5bZE5fBU/jL8+GPsInNhrqH9AFuxZq84dDtPWrkzdqG5YVIH77B/ZrC
	vcKQ+D9QOCWSYuUxE/O8d9EX3zOlMFaagUZnSxXzOTB8eRZilHin/uH/D8xCRe/VHFH5UOIch7R
	hej59K6WBH2BedXqXeaCkSW6CKyLxJbClQOQ5B/6TMIOBHwN1qEFSz88aAzMK8NApG4KplRFqP9
	VWa80521h5jmnM9vYq3F6heHX+kfANBttzkyvKIKdw+GOPa1bT5OzgHH6Ya3diU6MFeQalyb8XA
	+JBoPunzHfjty5rzH+c1hyuz2mkwGYKQGwVv0NVjtfqgqVBT+M0WGcQ9z
X-Received: by 2002:a05:6a00:399c:b0:822:bd7:e94f with SMTP id d2e1a72fcca58-82441754ec6mr14095281b3a.53.1770718356470;
        Tue, 10 Feb 2026 02:12:36 -0800 (PST)
X-Received: by 2002:a05:6a00:399c:b0:822:bd7:e94f with SMTP id d2e1a72fcca58-82441754ec6mr14095255b3a.53.1770718355945;
        Tue, 10 Feb 2026 02:12:35 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82441884b75sm14380940b3a.39.2026.02.10.02.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 02:12:35 -0800 (PST)
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
Subject: [PATCH v7 2/3] of: factor arguments passed to of_map_id() into a struct
Date: Tue, 10 Feb 2026 15:41:56 +0530
Message-Id: <20260210101157.2145113-3-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210101157.2145113-1-vijayanand.jitta@oss.qualcomm.com>
References: <20260210101157.2145113-1-vijayanand.jitta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HbDG9012ibG7Q1o4a4wqaIuHcugdA2tU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA4NCBTYWx0ZWRfXzQrz8dPIk+Sg
 GB1Z16dqd06lHCR1PAiTEbzBQg6mAmTDMQyErrCyNaqLF5LXJ1rU+6cDNnP+bFh9GZ4NZ3MCz54
 5Nlwzm0+riOvL4CZYmTj+72wv7qwXCQP0CNHyugtFE5OgWs/hMDXz7qQe6jCXS9fpHZJCp3mO5m
 r91H2NTrXsZr0DMFppvWyvOOh8U9B8C4UcWMBOnT7JkdtEdSs0gVpA7Br74rGhnjq416JIeU//8
 Ysx9OR3F3bzZFMfMf0wvbR/jEUAb7fZO0Mf693BFxnhSvCIKzb5QNWQ6ShkrjtuDTRvOW+yvoCs
 8h+464Uo02hqBIFci00ZkrwqrYIS6X3mlzHxWhUXI5QMQ41exkNfYVOcY0wPlCPvYtj6yvlCcn3
 ukRnUVp58eb4hwOkSDhGLxAvso0bj6f5M/WLtLOI+udO34LtROXoFvkYwTXYcvIcz4Biho4zNAT
 /kp0s5f2E5wdvnYLouA==
X-Authority-Analysis: v=2.4 cv=WK1yn3sR c=1 sm=1 tr=0 ts=698b0495 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=ElOSpzbGmGz6VRiAvVQA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: HbDG9012ibG7Q1o4a4wqaIuHcugdA2tU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100084

From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>

Introduce a new struct type where the optional arguments passed to
of_map_id() are Currently embedded as of_phandle_args struct.
Subsequent patches add additional arguments to the struct that the
caller expects to be filled of_map_id().

Suggested-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c              |  2 +-
 drivers/of/base.c                     | 37 +++++++++++++--------------
 drivers/pci/controller/dwc/pci-imx6.c |  8 +++++-
 drivers/pci/controller/pcie-apple.c   |  4 ++-
 drivers/xen/grant-dma-ops.c           |  2 +-
 include/linux/of.h                    | 21 ++++++++++-----
 6 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a511ecf21fcd..d255d0f58e8c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -48,7 +48,7 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args);
+	err = of_map_iommu_id(master_np, *id, &iommu_spec);
 	if (err)
 		return err;
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 57420806c1a2..6c3628255908 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2102,8 +2102,11 @@ int of_find_last_cache_level(unsigned int cpu)
  * @id: device ID to map.
  * @map_name: property name of the map to use.
  * @map_mask_name: optional property name of the mask to use.
- * @target: optional pointer to a target device node.
- * @id_out: optional pointer to receive the translated ID.
+ * @arg: of_phandle_args structure,
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
+	       struct of_phandle_args *arg)
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
+		if (arg->np)
 			return -ENODEV;
 		/* Otherwise, no map implies no translation */
-		*id_out = id;
+		arg->args[0] = id;
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
+		if (arg->np)
+			of_node_put(phandle_node);
+		else
+			arg->np = phandle_node;
 
-			if (*target != phandle_node)
-				continue;
-		}
+		if (arg->np != phandle_node)
+			continue;
 
-		if (id_out)
-			*id_out = masked_id - id_base + out_base;
+		arg->args[0] = masked_id - id_base + out_base;
 
 		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
 			np, map_name, map_mask, id_base, out_base,
@@ -2193,11 +2193,10 @@ int of_map_id(const struct device_node *np, u32 id,
 	}
 
 	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
-		id, target && *target ? *target : NULL);
+		id, arg->np ? arg->np : NULL);
 
 	/* Bypasses translation */
-	if (id_out)
-		*id_out = id;
+	arg->args[0] = id;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_map_id);
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index bff8289f804a..74fc603b3f84 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1139,12 +1139,18 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 {
 	struct device *dev = imx_pcie->pci->dev;
 	struct device_node *target;
+	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	u32 sid_i, sid_m;
 	int err_i, err_m;
 	u32 sid = 0;
 
 	target = NULL;
-	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
+	err_i = of_map_iommu_id(dev->of_node, rid, &iommu_spec);
+	if (!err_i) {
+		target = iommu_spec.np;
+		sid_i = iommu_spec.args[0];
+	}
+
 	if (target) {
 		of_node_put(target);
 	} else {
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index a0937b7b3c4d..e1d4b37d200d 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -755,6 +755,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
 {
 	u32 sid, rid = pci_dev_id(pdev);
 	struct apple_pcie_port *port;
+	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int idx, err;
 
 	port = apple_pcie_get_port(pdev);
@@ -764,10 +765,11 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
 	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
 		pci_name(pdev->bus->self), port->idx);
 
-	err = of_map_iommu_id(port->pcie->dev->of_node, rid, NULL, &sid);
+	err = of_map_iommu_id(port->pcie->dev->of_node, rid, &iommu_spec);
 	if (err)
 		return err;
 
+	sid = iommu_spec.args[0];
 	mutex_lock(&port->pcie->lock);
 
 	idx = bitmap_find_free_region(port->sid_map, port->sid_map_sz, 0);
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 1b7696b2d762..5f1d6540049a 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -325,7 +325,7 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
 		struct pci_dev *pdev = to_pci_dev(dev);
 		u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
 
-		if (of_map_iommu_id(np, rid, &iommu_spec.np, iommu_spec.args)) {
+		if (of_map_iommu_id(np, rid, &iommu_spec)) {
 			dev_dbg(dev, "Cannot translate ID\n");
 			return -ESRCH;
 		}
diff --git a/include/linux/of.h b/include/linux/of.h
index 824649867810..9d72d76f909d 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -463,7 +463,7 @@ bool of_console_check(const struct device_node *dn, char *name, int index);
 
 int of_map_id(const struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
-	       struct device_node **target, u32 *id_out);
+	       struct of_phandle_args *arg);
 
 phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
 
@@ -929,7 +929,7 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
 
 static inline int of_map_id(const struct device_node *np, u32 id,
 			     const char *map_name, const char *map_mask_name,
-			     struct device_node **target, u32 *id_out)
+			     struct of_phandle_args *arg)
 {
 	return -EINVAL;
 }
@@ -1458,17 +1458,24 @@ static inline int of_property_read_s32(const struct device_node *np,
 }
 
 static inline int of_map_iommu_id(const struct device_node *np, u32 id,
-				  struct device_node **target, u32 *id_out)
+				  struct of_phandle_args *arg)
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
+	struct of_phandle_args msi_spec = { .np = *target, .args_count = 1 };
+	int ret;
+
+	ret = of_map_id(np, id, "msi-map", "msi-map-mask", &msi_spec);
+	if (!ret) {
+		*target = msi_spec.np;
+		*id_out = msi_spec.args[0];
+	}
+
+	return ret;
 }
 
 #define of_for_each_phandle(it, err, np, ln, cn, cc)			\
-- 
2.34.1

