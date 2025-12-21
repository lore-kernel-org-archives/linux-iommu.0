Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB9269D18
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766353000; cv=none; b=CHBYfkRmtFuiXwk7weSWVqGEEGBV7Je+TJec1NaNHQlENOaH2WaR2CFZPxb1d6BapBvZzDgev09APyzIMWMysxxmEpzOvupkvAx20NHsa5ob5wZ1vs6RkEk/kc7fdhVGxGG34XLNJBrQP3OajsO7GbVYApk7m0FStVs5cl07Ox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766353000; c=relaxed/simple;
	bh=16TSlotBLzuOien7sfW4ukR/bjvgeC0dcRNpEifG7Xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MPTbJl9ooRcm+1f6yxx8mKC/yAyUApi51QZNtVjS69EW2lLOZUYm8NupeyzYHM1xGVC3+yg17qolQA8lTQrnjExHSt93fydOgjkdVI7IIKFAvN+KO7i5bdD7ZiD98O8lVRStBqrIfZ5JXeyFyXzSixak5H7o7WJdfxAjMbJVZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ViGoJeBV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W0kROKqe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ViGoJeBV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W0kROKqe"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLKcl4B3540948
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 21:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RqYSFgOLrB+
	uWxpGTvI492+ogxltyaVnqIFarGItNPU=; b=ViGoJeBVoo+qMjadqwFLZObEOSO
	c00Y2HktniIFEq7cDO15DlfG7N6peWCm303j3V+pt6McZ+dQQk7/CIz48FnFz7YZ
	YByPWAFSF1EnoBZ+UoXSecWN3nPqeCCfVkUNnWLnwds9uSp3tzhMbGiwLg//U5uP
	hAg9W8PFX8UhcAyMPkxORyt35iWoSE/J9Zr+lppIItgSJPD7AXAcB5CoveSa0VvC
	eSbdXDDgeW4pQGD3JcBWgRZslfFGCqRelubASSamIFvqi11RPXRuX8QKpu9cSvps
	gVgpOs/kNFcY5cawOgWXj2Jj0TBud6NbHQblZc5PS/Vcze74viE5NjFRZOg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mru2x7j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 21:36:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f27176aa7so71739445ad.2
        for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 13:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766352997; x=1766957797; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqYSFgOLrB+uWxpGTvI492+ogxltyaVnqIFarGItNPU=;
        b=W0kROKqeAsXqutcuaIdrkXiZhcqnFmdAuoZIelZFeTCF49Rtrbm/1bn8t/Uj02JlyK
         qe1BpKtZbqyZRDwUAuAcNC0zrqUrOw2/F3+seh/ndpaUBUg8bY559eO9DsmHGRr+7xBS
         R9+bw0dj9cCxj/cnsTGayUt4kF8+CWDCUSwWd6olrFXqgMnHhGPtwRcYGzdAqNWfHgxx
         3FwtqDyBUn7NRDC/sb720qkwsyKxZYPdDfAyCO/n16ywBlVlH7S8VQFfZ6dpCljh3CH1
         BF0nM8iR+sSz0X2zc9064aKkCSfc858p5MxYEa0kl+bYpR81+9pafOJUZEgrgsbHvzqf
         Zssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766352997; x=1766957797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RqYSFgOLrB+uWxpGTvI492+ogxltyaVnqIFarGItNPU=;
        b=bPUxILYAeAgYmZc5/ZrNIaPbnziM7fCK0wKhaqZwHClTXJ44O34xu9eGSBw0MWLCH/
         bqOX9NrysxfkphCPmflWjitceiMp37J/xxxN0dqkK9gqk83RkDv6b2ZN10vEowLBbC1i
         2gh7WB+QgCgHelH25bxfMzo3hr/yyH4+yv9t8wvE/lrcGZpgP0ej92CykRVfVih8Pemn
         FAs9CdnlcvqNjdfx377i9+DdIXd+4+6dUMfSLLJOb6KeeST0zc84qLC5qkp41kWZkegW
         7pPswSwkciaFnODEG/6nV/n4TZDHEQTi3VOWKEkdAsLPGBn76vlc4eOSAqhnUk+4ey2B
         +lMg==
X-Gm-Message-State: AOJu0YwOTeZf7607oBMP8vvGad2wUt1gS3QJWt6LcSV+wwk3VbsBi+Io
	A5gHOZ5ViJvl5D8PTJ87W2xP3Sbwuk+l+Z6nrsAQ2ojK52F0ztS9bfudL5X0eUD+SKleW8+m6GV
	Sy4766fvEGY+JqIoTFKvv1JWa0nor2uC+Li0m92NRZBh/5plcAmVU6KDh0Q==
X-Gm-Gg: AY/fxX6kGMwpK0sQYIaX+ItH/FFH/gt1xLdH6hk6PvOJaeZoGoVivMiElUczST2sIec
	bw07o2sBUDEDflkYSyHviaOZwgDgRaaPL/ai4lRzXjfsDLF0Dn9I9E9VNzgl6HhUnMIPGmthV7F
	wf47gHrCAyGmeXho+Nj+tORLUlPOkNMPXLNTX/UkQbf0xykbosia7V5NZkmmqg6mFFXwmTR2h8S
	mFZyzPMFCXQ6xBJC2j5QfpjVnKwbUEAQmgJjvItkI8dHtoMNI9gfVWzT7eyhPLGvODpkNK11Hci
	wbcMg0Junu5L0iAx6sDIP1K+aeOadlqrIb9TKgCMxL4itoP6opfDU0FpEwPtRZSzVt+ACaRUYcD
	KtXb3nKhIIdl2IKoDd4f8cJ3UYBjDygRF83JrcfFnF/nP
X-Received: by 2002:a17:902:e74c:b0:24b:270e:56c7 with SMTP id d9443c01a7336-2a2f22069e3mr99336125ad.7.1766352996605;
        Sun, 21 Dec 2025 13:36:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEu5g6C1Tc1/CWkGZfdt5tr82xA9G23JSzp10gkHSKJVdHoKnPqLmFdhu0g4UYH98Hmqj3g+A==
X-Received: by 2002:a17:902:e74c:b0:24b:270e:56c7 with SMTP id d9443c01a7336-2a2f22069e3mr99335915ad.7.1766352996108;
        Sun, 21 Dec 2025 13:36:36 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dcc7c8sm10950163a91.15.2025.12.21.13.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 13:36:35 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, saravanak@google.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v3 2/3] of: factor arguments passed to of_map_id() into a struct
Date: Mon, 22 Dec 2025 03:06:01 +0530
Message-Id: <20251221213602.2413124-3-vijayanand.jitta@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDIwNCBTYWx0ZWRfX0leE8aVC6TEn
 vOzzt1eze6M4dZAC3w6/AA8lL2YPVzYUKNgZ1HkAc+MG0gl5WGgx/Pl6wfpeSakpK3aPkTJsF3Z
 4Wc02oBKqmwCJQv3MJOLgsadCjweNtrvDG4hSJEzi1QrEjLyl2LH3vxHoWeeoUZtmXAJeztZjLC
 jP9RGmae+EhrkDshOhj7mIS3nkVFVrJMOB90yLkCTG5AM1JTgoVZGsWJo2L3EFJHPi5Q1voGyhC
 yDUnCuGIRB6+nf9P50MM0BGAiemAXOSJrz5OyyhXM5/DJVyHHKYetgUl5GqBCc6jdUYGGqSkx3Q
 PKVd9pssqpLumhOiG4CBpqpQgQADxxs48fMWAAzyfthHDF3QJxzlnWC+7fcH1SC3x1S/m5qZRvQ
 B3wu1reBrdzxzCcKuvb4K1EURKjAbuRG3Wtog/kMrl+YBO8kNn6MaST1LY0tx21FsOoXZ2N12aP
 UXAa1yVRXtUMPQUm9Jw==
X-Authority-Analysis: v=2.4 cv=VMnQXtPX c=1 sm=1 tr=0 ts=69486865 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=BO5FrL0GhfMJBgYdYhUA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 3_SnrmrtWdB0mQCYmCRlxp6bYDATdtrO
X-Proofpoint-GUID: 3_SnrmrtWdB0mQCYmCRlxp6bYDATdtrO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512210204

From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>

Introduce a new struct type where the optional arguments passed to
of_map_id() are Currently embedded as of_phandle_args struct.
Subsequent patches add additional arguments to the struct that the
caller expects to be filled of_map_id().

Suggested-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c              |  5 +++-
 drivers/of/base.c                     | 39 ++++++++++++++-------------
 drivers/pci/controller/dwc/pci-imx6.c |  6 ++++-
 drivers/pci/controller/pcie-apple.c   |  5 +++-
 drivers/xen/grant-dma-ops.c           |  4 ++-
 include/linux/of.h                    | 24 ++++++++++++-----
 6 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a511ecf21fcd..74779b77ba13 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -46,9 +46,12 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 				     const u32 *id)
 {
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
+	struct of_map_id_arg arg = {
+		.map_args = iommu_spec,
+	};
 	int err;
 
-	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args);
+	err = of_map_iommu_id(master_np, *id, &arg);
 	if (err)
 		return err;
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 7043acd971a0..4dca3d37a34b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2051,8 +2051,11 @@ int of_find_last_cache_level(unsigned int cpu)
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
@@ -2066,21 +2069,21 @@ int of_find_last_cache_level(unsigned int cpu)
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
+	if (!np || !map_name || !arg || (!arg->map_args.np && !arg->map_args.args))
 		return -EINVAL;
 
 	map = of_get_property(np, map_name, &map_len);
 	if (!map) {
-		if (target)
+		if (arg->map_args.np)
 			return -ENODEV;
 		/* Otherwise, no map implies no translation */
-		*id_out = id;
+		*arg->map_args.args = id;
 		return 0;
 	}
 
@@ -2122,18 +2125,16 @@ int of_map_id(const struct device_node *np, u32 id,
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
+		if (arg->map_args.args)
+			*arg->map_args.args = masked_id - id_base + out_base;
 
 		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
 			np, map_name, map_mask, id_base, out_base,
@@ -2142,11 +2143,11 @@ int of_map_id(const struct device_node *np, u32 id,
 	}
 
 	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
-		id, target && *target ? *target : NULL);
+		id, arg->map_args.np  ? arg->map_args.np : NULL);
 
 	/* Bypasses translation */
-	if (id_out)
-		*id_out = id;
+	if (arg->map_args.args)
+		*arg->map_args.args = id;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_map_id);
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c8da2e88e9c6..8dcdde2efb8a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1101,12 +1101,16 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 {
 	struct device *dev = imx_pcie->pci->dev;
 	struct device_node *target;
+	struct of_map_id_arg arg = {};
 	u32 sid_i, sid_m;
 	int err_i, err_m;
 	u32 sid = 0;
 
 	target = NULL;
-	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
+
+	arg.map_args.np = target;
+	arg.map_args.args[0] = sid_i;
+	err_i = of_map_iommu_id(dev->of_node, rid, &arg);
 	if (target) {
 		of_node_put(target);
 	} else {
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index ce21728d6e51..dea4a38cb4bb 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -782,6 +782,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
 {
 	u32 sid, rid = pci_dev_id(pdev);
 	struct apple_pcie_port *port;
+	struct of_map_id_arg arg = {};
 	int idx, err;
 
 	port = apple_pcie_get_port(pdev);
@@ -791,7 +792,9 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
 	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
 		pci_name(pdev->bus->self), port->idx);
 
-	err = of_map_iommu_id(port->pcie->dev->of_node, rid, NULL, &sid);
+	arg.map_args.np = NULL;
+	arg.map_args.args[0] = sid;
+	err = of_map_iommu_id(port->pcie->dev->of_node, rid, &arg);
 	if (err)
 		return err;
 
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index b661f9c1f4fe..d455104de159 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -319,9 +319,11 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
 
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
+		struct of_map_id_arg arg = {};
 		u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
 
-		if (of_map_iommu_id(np, rid, &iommu_spec.np, iommu_spec.args)) {
+		arg.map_args = iommu_spec;
+		if (of_map_iommu_id(np, rid, &arg)) {
 			dev_dbg(dev, "Cannot translate ID\n");
 			return -ESRCH;
 		}
diff --git a/include/linux/of.h b/include/linux/of.h
index 8cd486d89da2..0b0d545b80a3 100644
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
@@ -458,7 +462,7 @@ bool of_console_check(const struct device_node *dn, char *name, int index);
 
 int of_map_id(const struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
-	       struct device_node **target, u32 *id_out);
+	       struct of_map_id_arg *arg);
 
 phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
 
@@ -907,7 +911,7 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
 
 static inline int of_map_id(const struct device_node *np, u32 id,
 			     const char *map_name, const char *map_mask_name,
-			     struct device_node **target, u32 *id_out)
+			     struct of_map_id_arg *arg)
 {
 	return -EINVAL;
 }
@@ -1436,17 +1440,23 @@ static inline int of_property_read_s32(const struct device_node *np,
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
+	struct of_map_id_arg arg = {
+		.map_args = {
+			.np = *target,
+			.args_count = 1,
+			.args = { *id_out },
+		},
+	};
+
+	return of_map_id(np, id, "msi-map", "msi-map-mask", &arg);
 }
 
 #define of_for_each_phandle(it, err, np, ln, cn, cc)			\
-- 
2.34.1

