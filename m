Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415C72882BE
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842159; cv=none; b=r/EWXRR7DFzhLNoEkEuNQiNtKaOK3A6ZCwKC1ztpLdfaQNn92gKoEDB2+P0R5PQOIxzobcxDd3gN9APJEYtMDFZiebTUfSeRu1Cebd3KsHPzMctlndGfd8r0wCKukgOJKSWWdRs7EsTuSBugOpFVN5yyfenaZgZAmuvRaYWDYug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842159; c=relaxed/simple;
	bh=6PyyETF8k40quxwBmvqxGNRspbk5r7aeCKVnubAF4nA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=feqwDxRtobuYZNXwnu4U2bDxoUnmrAjVzZUjTj8zELxE2IkcGYaDRQRetTizhGTPaXyBdPyhGdvg0BEAXAEbMvblGyU8V1mLkOkO69z1+VMPm0+RrWnaTOOfz6mW1orJheNd3kOdyyfF2W1R8FONlVdVZZK/vaMcMOdo+896WdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mzvi5N+g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OsHpo96U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mzvi5N+g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OsHpo96U"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B47Tvnb996526
	for <iommu@lists.linux.dev>; Thu, 4 Dec 2025 09:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4j1Hi40g4e6
	iwRM+cXGeU/TgM79ai7droalmMWQn/KY=; b=Mzvi5N+gFxr5HBTEWfWw51cdLDK
	7TfXsrxF2dcqm9s9VHEbR6pKkUY+KUzvM2vanfqRBlEdszBumkxfRA8U7ywDs4XE
	Hv8R7m8KWJKbeW05solzTwyiAFp+84UkrtoqVAIG8ui3k9lflcT0hDS7dIP87dHX
	aqTJSE2BBooufyBxa4uxT7LsiadnWWC+ViIXQa1LyLjIUBwpPnsvrijb0FV0M4vX
	2dPWmSmCgZ1qhhQVqknxvitW4unl4v9EQBXGbZbtIJg2wAfKu+mmVo0TaDLhq+FT
	hPlin362FKJjEOsU1W3FaIsF7H80iaN8afAznjvW/EDmKXDmaxg+uio/S1w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4au5yc0gvq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 04 Dec 2025 09:55:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29be4d2ef78so18451095ad.2
        for <iommu@lists.linux.dev>; Thu, 04 Dec 2025 01:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764842154; x=1765446954; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4j1Hi40g4e6iwRM+cXGeU/TgM79ai7droalmMWQn/KY=;
        b=OsHpo96UtWmFR7W0yTiMS8w+QQ8K/F78T1aIbBL/o07ELCZsIe9K2VY4aoTyZgIOTX
         FNCO6TltrrJOWWiWlK4nwHZMF5O6Mzst8nlDZedD6uv49kIxMAHx9CSlkJJPRkPSZemP
         AUrV19wRur2706SQGNCyOjAMbkGTtP+vaZIb4lcB1QsGtBMTuFbjrqreIEzmFTrK4pgr
         MpWU6+vXbbnM2ulsU37/ZEfxXG0eSRnsPDp+4qzqNrpjmxc0JdBKQgCZ/dHY30eGQ+/k
         Cs5Ul1P4CQvMzmIVoRaCPvKYLM5e5USZPn8bzuC0tTN1N4gTWEb0auEu3jhU+eITC4bS
         Y/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764842154; x=1765446954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4j1Hi40g4e6iwRM+cXGeU/TgM79ai7droalmMWQn/KY=;
        b=RNYzjV/EiwfkA/ruczfeEzRo7eQaO8OkbMeo58cDkMRW++Z8IdgGxCleHjTtdKwROZ
         lN3TJ6PvHEGhXfkXRfKRQH89z2yraUgtYdFL/QGgwjS0mHEFYNxXNWciK7iC9D1wfJao
         hICTSFZl8IOiKE2JdEbRv8k7CAgZI0WDjwxhyZ7ikcaCaPwKqXXl0T0WC7vKBVN93qnS
         sblSI5wCnlWL3dqXKH4bW03vXSvgH2MPxGk+igNjCzWIWApMHJfTwOBpbR6zwwJxqX9o
         cKkyLn2lOb1M0xfjpjlysMCdH7qZisQRRdJvxttFe4z2gkOhcvPaQbpkcBreRzI7fk38
         X8/g==
X-Gm-Message-State: AOJu0YzUMRJm1+5MtRoYV6BGvlHLoETBBetZHpwDYr5kp4lFiUCZ3bC/
	PW9P/tzOhTVQa1nfiQfm6Fr74P7h7QBp3DUP6dwqLNU5Z2AInLncXYk67KArdZI/hQzIougU/KJ
	keVCDwed5aYS/+nB8CMG5NAx+2BvGhEJXIxGtvAoWwY9WHf/y8EfxoTyxRg==
X-Gm-Gg: ASbGncuOBn+QO0LMULilumtW51DFriSH+Vkzh2JIniHgBXlqNj1uoSBjCd5MlfknBmb
	w6wTy9Ojo0GdLJUObNhcUtDQZzu3Gr20xxBcTpQrhPscdFzkONr9L8WA/nIS8wGxYx+X0mcdcxr
	7SLcsYJnfatvSjKstlT/O7xwFY0xWMmX2WKR0zI9HtXRL2cMIc07EBy/WMHqBErEYAhriYbQT5i
	WpxXRSF0md84jhZBTZuJ3Kbz3wGwBGn3XJXbCdUqjlHF2pfrn5HuoZ6dikIPjYTqkN1LLW5EpUP
	ghckEU2F4u7GErTlf6U2qlSx+ELwohdPOvEPsehg5Njd9wsmTJr8TomyX4VDTFtlnJHiyeJc7t2
	Kbtq2mlG22lJU9Dmds5CNlkMgH8SBtF8VdG2v5VoxWtJ0
X-Received: by 2002:a17:903:240c:b0:295:4d50:aaab with SMTP id d9443c01a7336-29d682e400cmr56474635ad.20.1764842154338;
        Thu, 04 Dec 2025 01:55:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmnx0tg7Ob7VxFE7lJfcQbFgCacVT6NfmWVYjlbUz1vyx71fsGDZgckt+aMRDyp2ueVvMt+g==
X-Received: by 2002:a17:903:240c:b0:295:4d50:aaab with SMTP id d9443c01a7336-29d682e400cmr56474365ad.20.1764842153817;
        Thu, 04 Dec 2025 01:55:53 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6817389fdsm1380436a12.1.2025.12.04.01.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 01:55:53 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, charan.kalla@oss.qualcomm.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vijayanand.jitta@oss.qualcomm.com
Subject: [PATCH v2 2/3] of: factor arguments passed to of_map_id() into a struct
Date: Thu,  4 Dec 2025 15:25:29 +0530
Message-Id: <20251204095530.8627-3-vijayanand.jitta@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=QstTHFyd c=1 sm=1 tr=0 ts=69315aab cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=TItJH5Yx5ZyhTHJNrZAA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 95V51YeVmEKlcE2cnV76bdvxLWUdK7cH
X-Proofpoint-GUID: 95V51YeVmEKlcE2cnV76bdvxLWUdK7cH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDA4MSBTYWx0ZWRfX+yGoshTAdQxd
 0VFwuuK09fOuJUXvfc/djDYnzQBDtP7iwAwlFONm/c3hqPhZxv10HF5z/+gVRsfjD9Q3STJsFX2
 uys3zUQePm37sX3lYXuBwIMmbWqLns2Rg1Sjj4oiPvVt9bW2k7Ei6xQag/5TxMHzBZbdoRt4TmF
 1FxHwM8gMyuw6TVcqnm2Xs6V1nRmWNNUNkDy6nGT84AyDPVsKP8wM2QA3uAnJml1HMWk0QSbD7K
 v8THgt4gcPaQIRAgJp8EefoNWr2Y0yecV3aP6gSv1fEGX4dmVMZt9sVmpTxbz0KRfe2Xy5IvHNe
 RRiTzEi9fELaVw383pnNacfVyQ/q7r59Wvc8h41G/ARloTLixJEFBxQ0pFwlByu69dqhfTubDkT
 KVCBb8Nf8lazZhQ8Wz4ykc9D8qg4FA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512040081

From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>

Introduce a new struct type where the optional arguments passed to
of_map_id() are in struct. Subsequent patches add additional arguments
to the struct that the caller expects to be filled of_map_id().

Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c              |  6 +++++-
 drivers/of/base.c                     | 31 ++++++++++++++-------------
 drivers/pci/controller/dwc/pci-imx6.c |  6 +++++-
 drivers/pci/controller/pcie-apple.c   |  5 ++++-
 drivers/xen/grant-dma-ops.c           |  5 ++++-
 include/linux/of.h                    | 23 ++++++++++++++------
 6 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a511ecf21fcd..eac62bc441c5 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -46,9 +46,13 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 				     const u32 *id)
 {
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
+	struct of_map_id_arg arg = {
+		.target = &iommu_spec.np,
+		.id_out = iommu_spec.args,
+	};
 	int err;
 
-	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args);
+	err = of_map_iommu_id(master_np, *id, &arg);
 	if (err)
 		return err;
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 7043acd971a0..b8f78a9e6a09 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2051,8 +2051,9 @@ int of_find_last_cache_level(unsigned int cpu)
  * @id: device ID to map.
  * @map_name: property name of the map to use.
  * @map_mask_name: optional property name of the mask to use.
- * @target: optional pointer to a target device node.
- * @id_out: optional pointer to receive the translated ID.
+ * @arg: contains the optional params, @target which is a pointer
+ *	to the target device node and id_out which is a pointer
+ *	to receive the translated ID.
  *
  * Given a device ID, look up the appropriate implementation-defined
  * platform ID and/or the target device which receives transactions on that
@@ -2066,21 +2067,21 @@ int of_find_last_cache_level(unsigned int cpu)
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
+	if (!np || !map_name || !arg || (!arg->target && !arg->id_out))
 		return -EINVAL;
 
 	map = of_get_property(np, map_name, &map_len);
 	if (!map) {
-		if (target)
+		if (arg->target)
 			return -ENODEV;
 		/* Otherwise, no map implies no translation */
-		*id_out = id;
+		*arg->id_out = id;
 		return 0;
 	}
 
@@ -2122,18 +2123,18 @@ int of_map_id(const struct device_node *np, u32 id,
 		if (!phandle_node)
 			return -ENODEV;
 
-		if (target) {
-			if (*target)
+		if (arg->target) {
+			if (*arg->target)
 				of_node_put(phandle_node);
 			else
-				*target = phandle_node;
+				*arg->target = phandle_node;
 
-			if (*target != phandle_node)
+			if (*arg->target != phandle_node)
 				continue;
 		}
 
-		if (id_out)
-			*id_out = masked_id - id_base + out_base;
+		if (arg->id_out)
+			*arg->id_out = masked_id - id_base + out_base;
 
 		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
 			np, map_name, map_mask, id_base, out_base,
@@ -2142,11 +2143,11 @@ int of_map_id(const struct device_node *np, u32 id,
 	}
 
 	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
-		id, target && *target ? *target : NULL);
+		id, arg->target && *arg->target ? *arg->target : NULL);
 
 	/* Bypasses translation */
-	if (id_out)
-		*id_out = id;
+	if (arg->id_out)
+		*arg->id_out = id;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_map_id);
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c8da2e88e9c6..7b54295e553b 100644
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
+	arg.target = &target;
+	arg.id_out = &sid_i;
+	err_i = of_map_iommu_id(dev->of_node, rid, &arg);
 	if (target) {
 		of_node_put(target);
 	} else {
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index ce21728d6e51..965f65ce8ad3 100644
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
+	arg.target = NULL;
+	arg.id_out = &sid;
+	err = of_map_iommu_id(port->pcie->dev->of_node, rid, &arg);
 	if (err)
 		return err;
 
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index b661f9c1f4fe..179f6f43a57b 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -319,9 +319,12 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
 
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
+		struct of_map_id_arg arg = {};
 		u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
 
-		if (of_map_iommu_id(np, rid, &iommu_spec.np, iommu_spec.args)) {
+		arg.target = &iommu_spec.np;
+		arg.id_out = iommu_spec.args;
+		if (of_map_iommu_id(np, rid, &arg)) {
 			dev_dbg(dev, "Cannot translate ID\n");
 			return -ESRCH;
 		}
diff --git a/include/linux/of.h b/include/linux/of.h
index 8cd486d89da2..21bdce2b37ca 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -25,6 +25,12 @@
 typedef u32 phandle;
 typedef u32 ihandle;
 
+struct device_node;
+struct of_map_id_arg {
+	struct device_node **target;
+	u32 *id_out;
+};
+
 struct property {
 	char	*name;
 	int	length;
@@ -458,7 +464,7 @@ bool of_console_check(const struct device_node *dn, char *name, int index);
 
 int of_map_id(const struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
-	       struct device_node **target, u32 *id_out);
+	       struct of_map_id_arg *arg);
 
 phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
 
@@ -907,7 +913,7 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
 
 static inline int of_map_id(const struct device_node *np, u32 id,
 			     const char *map_name, const char *map_mask_name,
-			     struct device_node **target, u32 *id_out)
+			     struct of_map_id_arg *arg)
 {
 	return -EINVAL;
 }
@@ -1436,17 +1442,20 @@ static inline int of_property_read_s32(const struct device_node *np,
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
+		.target = target,
+		.id_out = id_out,
+	};
+
+	return of_map_id(np, id, "msi-map", "msi-map-mask", &arg);
 }
 
 #define of_for_each_phandle(it, err, np, ln, cn, cc)			\
-- 
2.34.1

