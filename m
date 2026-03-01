Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004FF27FD76
	for <iommu@lists.linux.dev>; Sun,  1 Mar 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772354190; cv=none; b=E12nu8x2zoycxKCQH2V9BjWJ9ADdzug0Hy2DGK6fP2/tcPSO29zOj/+lAn9hW58InJ4bJOwHWG1YmqNPuM8g6FG3M/1Zolkcqgi1Linbk+3YO0WDwdYKiTByqTXrr3sDqDErEY4gx+aXH+n4U0FN7LVZEbp7SpCYrpVHh3MgjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772354190; c=relaxed/simple;
	bh=uk1nmLd+jn745Bwlsm669RsISU5Qlwjh0WjGr+U3C/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l3OpaWxH/JodcKJ+clOr9SuHHU5lFata8RPVei2xmtUyRkzylNoyySv2KajhNXKGivWIqVvseKXE5VemTGq1reGI4mlfCE+AqjkZOE5ZqVTLY3YdJHg3kyiBHLIf9cEz0ENBqX8gOi00weDCihYU8q94PqrPBLaux/Nf/Vz28DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WPZzCqUy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mfnu1Tsm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WPZzCqUy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mfnu1Tsm"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6216blUu861535
	for <iommu@lists.linux.dev>; Sun, 1 Mar 2026 08:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JWC4EWZ3YtPp4HbcYOknKtzY08XiWmMw2Q79Uzh+F0E=; b=WPZzCqUyGxdnLn2y
	pdgl6gf2J0urmQmnaJ/KOhuTlNLijdzlWjYEXvefXkcYImP7A9IEOnDlJgmDZ5vc
	yrqJnITXucUqL0TJZxVarZyKZBt/E7hQEi79M1bc9IAsRHhBGB+QUKuvXaJPdqvR
	l4ghcOtQUy6P88fH0JbkRNM1C1Taqr82HdyX/YnPo+C+hQTxrcceQqcXp16Owyjf
	xPIDTgjnEwBubkLLyqwxP+sH0M1Pq+RMJ/TdLSAJP5xVJT+LCdVB40myHCln8MJh
	A15mlyNS7NccWEFHCTMbVb/1DJhvhjvP0JyIE2KI7LUAGFJ8Zrjlnz2JezK+PoUc
	QEkgOg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cmgbar3wh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 01 Mar 2026 08:36:27 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b630753cc38so18467739a12.1
        for <iommu@lists.linux.dev>; Sun, 01 Mar 2026 00:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772354187; x=1772958987; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWC4EWZ3YtPp4HbcYOknKtzY08XiWmMw2Q79Uzh+F0E=;
        b=Mfnu1Tsmo436oonf4cI84y+aZcH0IKkgjSEbM+CoP1Sv5qp9inZtpxrQrQaQ17C6nX
         hfl1DAyWSR1eH/hazzPSxa8lItZIPILvckTU/JgXs3c8MORF5t91bWXLpRLX0mJt4nJz
         SCkZ/IJI8qSKY5UpUmNKf7Z1WVUBm2kIda7yvsgPKwPpPuvJgzbeS/7jmPg+1wG9v+Q+
         lcA0X+wKDv58hDJEmAVvui8D/5hxow8Y4voFDYGio+feUXrqW/58lhP5VQxtZQRklaP1
         mBFN6TbhU8faxOzXhp1qP9XgLuxVED3o48aFYz0bnEd2gNcGPlAbBmzIM71KlInwgsUK
         kEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772354187; x=1772958987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JWC4EWZ3YtPp4HbcYOknKtzY08XiWmMw2Q79Uzh+F0E=;
        b=V0Zb+XYUWXmbRzLD48m+ZBTa6volpexaDsEqZqg1A5zwAsMLy+TcbbFSauModlCiSM
         pQkylKQYiQdPaUtcdwzZBmesJW0Ch6lUi+ok3B2p5EHagk0hwMuRetGsZycj4BBVetrh
         dFwDNICSbB6GgbUps46z9Sbg4XAzNUUcGKt8xrLw2mQpdhftKyJuCLEW3PC9vE7Oxav8
         R0voDt1w6E2lN/b9HEbY5LhAOrQ2WFG+S1WmiM1mdv9LHkVpFX2aX6lcAZj3F3602iO6
         qlLsvd/cm1KT10F+Fa4t4mToiS/OBUu6lr1w1GGF/g1lZ4uRs+LBI9WUtQg0BTyvUqHr
         BfZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmWPWvAUL5Pba+l3Yvor62NzCcjayOyBOidthLElMuLD+Wpgt820btqLWF7az7vJdRBjRTFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/66nYmPEQyM8A5YQA3qZTULFTiClMPuJ27k/Wyd8+RkyzuERw
	/lxAd8mNgSQOmlpcIQuhATxBiT50o3ca4bcz3RaypM/txMusPFwQ/OjKUfTBVNtkhWLeEHSNr2L
	YSB5l2Erk5Kl/DI21U9Zt3jyREDs4HyID+1kO8yoAxjKVubVEbBakLZkPXg==
X-Gm-Gg: ATEYQzy0CcukHrq/JJ8h2wUGEe0hvZJTngrUPIUHNjqjKhiaLrp79ST9tQsT5+ukjzS
	allx9NqbXVPn6Ge7Hv+LzbYf1IYB3f20fhrKSuKvg1NkIbPkgVZtx6QN20IT0ImgO1Gfi+h91zF
	QdM1E9gJ4tRer4/NoGFV9j6Bk+DkisITpzCTkf01aZbRyhQi3pndYdE6Ulcg5LOq6Xtc5Enu3KC
	ndxr6yRLmfIFF0VOmXIfEJAkhyZFbxS/xM7X3RkseR+kQhJnt0Tb9PtBx7FuPks1x6ZYUQihkCw
	1CmINl8MQMXaCiEXqbqozZsRTnFG35PxU9HARB0kQpLHZRheR4azMyVeMENJkkYfb6YsfY1S1Bb
	3YkKezc9d6DviaZYdnrq/iKq2sXOt/E6J/UZlFcNHqXx7amQnsJpg52ED
X-Received: by 2002:a05:6a21:610e:b0:38e:9e81:d403 with SMTP id adf61e73a8af0-395c3a1b597mr8708796637.13.1772354186652;
        Sun, 01 Mar 2026 00:36:26 -0800 (PST)
X-Received: by 2002:a05:6a21:610e:b0:38e:9e81:d403 with SMTP id adf61e73a8af0-395c3a1b597mr8708760637.13.1772354186052;
        Sun, 01 Mar 2026 00:36:26 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82dd09sm9177300a12.28.2026.03.01.00.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 00:36:25 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Date: Sun, 01 Mar 2026 14:04:20 +0530
Subject: [PATCH v9 2/3] of: factor arguments passed to of_map_id() into a
 struct
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260301-parse_iommu_cells-v9-2-4d1bceecc5e1@oss.qualcomm.com>
References: <20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com>
In-Reply-To: <20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com>
To: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772354153; l=8142;
 i=vijayanand.jitta@oss.qualcomm.com; s=20260301; h=from:subject:message-id;
 bh=r2qfSqiqIjEbj4wTPrMkzeKvLvtgLnSihSwqEGZhuYg=;
 b=r/dhHroymMbLBDFlYf1GFDusEMnB4gD+ozyYy/V79x+uvbreXh9f3EYvZPK8M1Yk14K7fnxjU
 EevL6+OwaOGAPeTwTrmt9IjrFVaa9IWd9FQFUl0AWbT8tn7Gmzj0smi
X-Developer-Key: i=vijayanand.jitta@oss.qualcomm.com; a=ed25519;
 pk=Lpi7Cs3wHe8KZtqvyci7FTOLzsKpEHKGCaPNZw+1zRI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDA3NiBTYWx0ZWRfXwjv8GULESoJJ
 IMadA8V7x/zgxGWp7lm8/KQ0VMJNj1Sr9kCZEXk1mub6d7ofI3pXKaL/w45m0qVC0PMG1Iq5fwL
 nGD3K+QejWX4QJmoyDuUF8S0QsUx3YhoGCXLdJ2NCLzv9+Wg9HvPy2uGfA0G1QISZA/2vWX4JHn
 np267/su5ynDlDRgEVJzLAeaEPLtDmqj3jqUOvg49bkWF6DyuACCCdwsHoXSis+LJBgExHUzk+B
 EJK4nNF9Xa7eFaxxzm5ICmpbCIRnqiRS5S5yOfaU/hFFEM6ZqHUUbbuw93feU/YKoy+1/EePfxb
 J+BzNS6I+clUij83cRVEiovi8HV3A0oSzCThhhuCfCeBg8naHGncVQjMiaeionKYGILCYfRAkpL
 agPi+2lh7GvhngHuPpq+YhOSEz//wUfID6nQeQGmTqVODJ74sktDxxDj14rCHSNFXp1ZQ316GOp
 jLf8RK3g4lxqTa0H2Mg==
X-Authority-Analysis: v=2.4 cv=QfVrf8bv c=1 sm=1 tr=0 ts=69a3fa8b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=I3pr03k2-ahTGQre_g8A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: -lom86m5oAl33UwkkF3g3la1Tcl3JXiF
X-Proofpoint-GUID: -lom86m5oAl33UwkkF3g3la1Tcl3JXiF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603010076

From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>

Change of_map_id() to take a pointer to struct of_phandle_args
instead of passing target device node and translated IDs separately.
Update all callers accordingly.

Subsequent patch will make use of the args_count field in
struct of_phandle_args.

Suggested-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c              |  2 +-
 drivers/of/base.c                     | 37 +++++++++++++++++------------------
 drivers/pci/controller/dwc/pci-imx6.c |  8 +++++++-
 drivers/pci/controller/pcie-apple.c   |  4 +++-
 drivers/xen/grant-dma-ops.c           |  2 +-
 include/linux/of.h                    | 21 +++++++++++++-------
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

