Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF19B3F7E8C
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965938; cv=none; b=mIOQOcRqsTmK0muGTgVIL+E0XsHJFPt4WBB6rZBzioLVvOLnOvjERvzxOAt8+ZFfCuEGwT2HoM66Wl5pHLi0DkSfiMAJH0rOHA0iZ/sxMTPpUaqkCrvgWlrvX5v/L2rgustSUxWFEUGy2qBdPf+I6wHVofrR+nn+Gs9Gi++IzQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965938; c=relaxed/simple;
	bh=AFVNz1V0mlVDk2rZHCnh21rNF8+JAgNhzyXJ44LFVFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q6zQCc1IpwSHJAIJF0pPwpCEw/GzN9hM9R2zyKRs2smAVfZohZqffHsUGO79XevVp3YBzBTKBlyOIrJlCKOLaIlIqXcpfyGLy4hZdJWWQAcdLBg1vbEUQ5r6epvNuwLL6S6NQXs+SEvpNM2FwS1ERQwqAnLJBq4swvcAZKXRnKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZwBE3med; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MIBA62Io; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZwBE3med";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MIBA62Io"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VBjqut2407882
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 14:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vw4qt0eYK9YTsOqpYAiZjJgAyZUidFf8mtBjYqgk2Kw=; b=ZwBE3med9lysXbbD
	212MuW8sUcUsa2btNAuYgPAUc+UMpGnl1xbI2vfG6KD4Z4iAiOSf33UySRHOt4Tu
	N9IpsAM1db3F7sbefWc9UXpFPAuEeLSkZzG/Fje1feNawGRDd3L4wf5LOQNCJFMr
	mb/fEzwnKVxVUaYy2JiVs+kxG0hZ+jTvC8nltX1xjpFFv+8XhPTNkkSdoO3J1lyo
	PL0rDcrEXap9W8nJP9png/t8TLhQcsRJ/lAHcsoWQghHFfKP8+C/RUPDtzQNcWxL
	4fJ11X89skHYSgjYNDbtZxyTskUMwnQ/p5tLFt3iV0Efy5UrT12rR1I0C3D7yKNy
	/EJL8w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d80heugwn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 14:05:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b0f4e632caso57285305ad.3
        for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774965930; x=1775570730; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vw4qt0eYK9YTsOqpYAiZjJgAyZUidFf8mtBjYqgk2Kw=;
        b=MIBA62Io1cNfkVZrpXiQHsR8kmrbZO4bGuzAnhqp+CfnnnOGjie0sGD2hDD+pFKRe9
         8RuqgQ1QP1cjVgmAO3L9zqPa/3iOpp+3+eGIu9vPH6sYBuASV2hJKKnvccLN3nrWtEuK
         TZIodXC4SiN/LXLzn5lGukOng4eVfDI82pp1liWW3fRHzAnm5bPpeYXkM0B19BmQxz1T
         hTd9VKKVLsCxOUdSB5SltgCUI1WopQykw0KwbRgYWQLkmrrSc797oMY4tJUeL5bU+cD0
         /w23x97Xws4NDwRyiB9LjI8VI+pusbLqV9JCFAdgLU/oTJwEZPaQpNpvJ/AKebWi382H
         boyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774965930; x=1775570730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vw4qt0eYK9YTsOqpYAiZjJgAyZUidFf8mtBjYqgk2Kw=;
        b=RDrce0IF2FR6nNVJIS1E8QLHAujPKkSmLXFJizqkOVR2TPOJ1XmQ0vPI1c0brnVfJm
         Q4gM/1vy4d6lq1Mt8Xsj/T6ML5bKBaqsZiiGZ1ucKm7a9r7Lhbd5ABWZhShuc7U6TVCV
         F1hsRHDuLsK+JqmP7Yho6+k1FYiE/EvJaCD87RN6+kYs8AG1UNBHNuMTI7drerZWDxME
         2Seydnp5pMC8UYcSQKydMuQKGvq4FOfKr8TCX0NSuhKqAtHEaRwiW8sOxH4Bo4pWI6BB
         Jsh4d3l+liaCCIRl8ZWQ8ZwMnZzCScW69LYzwz86Pf5V40b85Zw7jE5JYWSRSFryBqh3
         zf1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaQMdzUxsd7JIEsv12uNe+0AiQeU/Bt3/u5++4ApYBb8/7+jFmcSLAYft+S7vt9kBD0RvdgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YweHwz1MfOP67UALoPOrtPX79Up+Rrwd8/Cubgl3z71ubiMrStO
	WTCTPV2E/0T0HekZ3QbHE3LuYN9Q0KsxdcOQevS1wcD6oFoWa7pCoRP/ZBpgJJgsXfxeorp9WUk
	95a6q6VZabvmaEA+l7ZXR+vLxKyM3Y4u3toMaeEi0RMLkUmX8Ryc1RpHKZw==
X-Gm-Gg: ATEYQzyK7oSpFOylHq8QdbE1v4+LQBruuLk/5P13Z2jPM9aoPRhkR/LGODk11Wi5zzS
	P7G9bRPSwzpkdvtNU3BUrWalssql3j/50JWXBaIGS5Xdh4BzLDHmcTweE1K5KOmscfL3kVEZl/p
	58DAFHJm/64+hKsI8Lz8NDTB87D5uK+XBr7eHoVZG72NnJr/t7PWAwGwbXW2nbQ+kk5iQXal4Pu
	Tvaie8+3ahiRQDBeEg8/VrTXiSJ34kEu1L45WrOAfp+es+Prg08+mh6jSn0URlmM8fgz7tIacC/
	EKNHSQ2xoB4bi/Dj3ThCjpizK9AA9QCnEz25FT3bmGSO4OUvB47RWFo+UFAAsSked0HlBMGR3fe
	MFOfWcMSYPRX0ksJmXWfPA/6cgy7FK8hbOUEc7XJTGuViXi5zFfJJMbEH
X-Received: by 2002:a17:902:f706:b0:2b2:5a5a:4f2f with SMTP id d9443c01a7336-2b25a5a526emr63773765ad.33.1774965929961;
        Tue, 31 Mar 2026 07:05:29 -0700 (PDT)
X-Received: by 2002:a17:902:f706:b0:2b2:5a5a:4f2f with SMTP id d9443c01a7336-2b25a5a526emr63772865ad.33.1774965929221;
        Tue, 31 Mar 2026 07:05:29 -0700 (PDT)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24264292asm118311945ad.4.2026.03.31.07.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:05:28 -0700 (PDT)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 19:34:47 +0530
Subject: [PATCH v12 2/3] of: Factor arguments passed to of_map_id() into a
 struct
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-parse_iommu_cells-v12-2-decfd305eea9@oss.qualcomm.com>
References: <20260331-parse_iommu_cells-v12-0-decfd305eea9@oss.qualcomm.com>
In-Reply-To: <20260331-parse_iommu_cells-v12-0-decfd305eea9@oss.qualcomm.com>
To: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
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
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774965896; l=16797;
 i=vijayanand.jitta@oss.qualcomm.com; s=20260301; h=from:subject:message-id;
 bh=96PMQ0CGK2KUwzmiEbJz9+FKLLeBn/ugSmvWBnHWEG4=;
 b=Sj9HdYruGYOK2x9lzG3NJLUJAImu1Am7r/V4VBBJaBUgTve/cVJ0R0t2vM3asrFtbNrcE4LvP
 tPy5lg1IeDFDU4bBafypwPwg+qNSVlG7PsSaaEMdZgOEyQTEPhZQrN8
X-Developer-Key: i=vijayanand.jitta@oss.qualcomm.com; a=ed25519;
 pk=Lpi7Cs3wHe8KZtqvyci7FTOLzsKpEHKGCaPNZw+1zRI=
X-Authority-Analysis: v=2.4 cv=Gb0aXAXL c=1 sm=1 tr=0 ts=69cbd4ab cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=lfH1aMGX5GUcQU68BDUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: qrYcBm_fZ65r3R7pVMD2BK1Qjs1YQfaL
X-Proofpoint-ORIG-GUID: qrYcBm_fZ65r3R7pVMD2BK1Qjs1YQfaL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEzNyBTYWx0ZWRfXxcgQ3IMEbz3c
 Rr2E1g1mtIbDLgjc3aYQloCZcdaN+OFHys/FKGNT8jXhRlvNjt7UO6X0irXWewtLNm/pQ/6HszK
 RNvLhdGYx5l/M+6Msdm7mk3OncS7fuTIu3daY09971f3TFL42jpTiD5fZ9UrgaB/z2chEn+ubhG
 V+TEhM9ZBp8A0zv1YjlwvwhXETC49ZxzdecnNtLyGMy5gTBIXMVCxhjRhZwz7lKx4BJ2QKgM0Kx
 yBJ1c2NjETsfNgEhCWvZZJYxBlhmODvbb8CG6gVMdIcxhUeuxHn6WLQ3daDqaobZi8tIjXdnLUs
 EwMClrqTiy/dsxcs1qUCCHM0H2bEH0uXYaBgDnBMXMaQyAiEOn8kP9XRq5O6afWZEENc/0xXwP3
 t3tmYZxDZkYNij7lvjKPlyY2YSkOWQMh5Y1FesZqyaRfarjH1jzyI4wv8tVQgObOO4Hl4uWTMew
 bYm81kGazpZYFlb09Ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310137

From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>

Change of_map_id() to take a pointer to struct of_phandle_args
instead of passing target device node and translated IDs separately.
Update all callers accordingly.

Add an explicit filter_np parameter to of_map_id() and of_map_msi_id()
to separate the filter input from the output. Previously, the target
parameter served dual purpose: as an input filter (if non-NULL, only
match entries targeting that node) and as an output (receiving the
matched node with a reference held). Now filter_np is the explicit
input filter and arg->np is the pure output.

Previously, of_map_id() would call of_node_put() on the matched node
when a filter was provided, making reference ownership inconsistent.
Remove this internal of_node_put() call so that of_map_id() now always
transfers ownership of the matched node reference to the caller via
arg->np. Callers are now consistently responsible for releasing this
reference with of_node_put(arg->np) when done.

Suggested-by: Rob Herring (Arm) <robh@kernel.org>
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
 drivers/cdx/cdx_msi.c                    |  7 ++--
 drivers/iommu/of_iommu.c                 |  4 +-
 drivers/irqchip/irq-gic-its-msi-parent.c | 11 ++++--
 drivers/of/base.c                        | 68 +++++++++++++++++---------------
 drivers/of/irq.c                         | 10 ++++-
 drivers/pci/controller/dwc/pci-imx6.c    | 32 +++++++--------
 drivers/pci/controller/pcie-apple.c      |  5 ++-
 drivers/xen/grant-dma-ops.c              |  4 +-
 include/linux/of.h                       | 14 ++++---
 9 files changed, 89 insertions(+), 66 deletions(-)

diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
index 63b3544ec997..6924e07c7528 100644
--- a/drivers/cdx/cdx_msi.c
+++ b/drivers/cdx/cdx_msi.c
@@ -121,22 +121,23 @@ static int cdx_msi_prepare(struct irq_domain *msi_domain,
 			   struct device *dev,
 			   int nvec, msi_alloc_info_t *info)
 {
+	struct of_phandle_args msi_spec = {};
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
 	struct device *parent = cdx_dev->cdx->dev;
 	struct msi_domain_info *msi_info;
-	u32 dev_id;
 	int ret;
 
 	/* Retrieve device ID from requestor ID using parent device */
-	ret = of_map_msi_id(parent->of_node, cdx_dev->msi_dev_id, NULL, &dev_id);
+	ret = of_map_msi_id(parent->of_node, cdx_dev->msi_dev_id, NULL, &msi_spec);
 	if (ret) {
 		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
 		return ret;
 	}
+	of_node_put(msi_spec.np);
 
 #ifdef GENERIC_MSI_DOMAIN_OPS
 	/* Set the device Id to be passed to the GIC-ITS */
-	info->scratchpad[0].ul = dev_id;
+	info->scratchpad[0].ul = msi_spec.args[0];
 #endif
 
 	msi_info = msi_get_domain_info(msi_domain->parent);
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a511ecf21fcd..a18bb60f6f3d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -45,10 +45,10 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 				     struct device *dev,
 				     const u32 *id)
 {
-	struct of_phandle_args iommu_spec = { .args_count = 1 };
+	struct of_phandle_args iommu_spec = {};
 	int err;
 
-	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args);
+	err = of_map_iommu_id(master_np, *id, &iommu_spec);
 	if (err)
 		return err;
 
diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
index b63343a227a9..dd5f84b6470a 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -152,6 +152,8 @@ static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u32 *dev_id,
 				phys_addr_t *pa)
 {
+	struct device_node *msi_ctrl __free(device_node) = NULL;
+	struct of_phandle_args msi_spec = {};
 	struct of_phandle_iterator it;
 	int ret;
 
@@ -178,9 +180,12 @@ static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u
 		}
 	}
 
-	struct device_node *msi_ctrl __free(device_node) = NULL;
-
-	return of_map_msi_id(dev->of_node, dev->id, &msi_ctrl, dev_id);
+	ret = of_map_msi_id(dev->of_node, dev->id, NULL, &msi_spec);
+	if (!ret) {
+		msi_ctrl = msi_spec.np;
+		*dev_id = msi_spec.args[0];
+	}
+	return ret;
 }
 
 static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
diff --git a/drivers/of/base.c b/drivers/of/base.c
index ae04487bd614..b3d002015192 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2102,36 +2102,37 @@ int of_find_last_cache_level(unsigned int cpu)
  * @id: device ID to map.
  * @map_name: property name of the map to use.
  * @map_mask_name: optional property name of the mask to use.
- * @target: optional pointer to a target device node.
- * @id_out: optional pointer to receive the translated ID.
+ * @filter_np: optional device node to filter matches by, or NULL to match any.
+ *	If non-NULL, only map entries targeting this node will be matched.
+ * @arg: pointer to a &struct of_phandle_args for the result. On success,
+ *	@arg->args[0] will contain the translated ID. If a map entry was
+ *	matched, @arg->np will be set to the target node with a reference
+ *	held that the caller must release with of_node_put().
  *
  * Given a device ID, look up the appropriate implementation-defined
  * platform ID and/or the target device which receives transactions on that
- * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
- * @id_out may be NULL if only the other is required. If @target points to
- * a non-NULL device node pointer, only entries targeting that node will be
- * matched; if it points to a NULL value, it will receive the device node of
- * the first matching target phandle, with a reference held.
+ * ID, as per the "iommu-map" and "msi-map" bindings.
  *
  * Return: 0 on success or a standard error code on failure.
  */
 int of_map_id(const struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
-	       struct device_node **target, u32 *id_out)
+	       const struct device_node *filter_np, struct of_phandle_args *arg)
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
+		if (filter_np)
 			return -ENODEV;
 		/* Otherwise, no map implies no translation */
-		*id_out = id;
+		arg->args[0] = id;
+		arg->args_count = 1;
 		return 0;
 	}
 
@@ -2173,18 +2174,14 @@ int of_map_id(const struct device_node *np, u32 id,
 		if (!phandle_node)
 			return -ENODEV;
 
-		if (target) {
-			if (*target)
-				of_node_put(phandle_node);
-			else
-				*target = phandle_node;
-
-			if (*target != phandle_node)
-				continue;
+		if (filter_np && filter_np != phandle_node) {
+			of_node_put(phandle_node);
+			continue;
 		}
 
-		if (id_out)
-			*id_out = masked_id - id_base + out_base;
+		arg->np = phandle_node;
+		arg->args[0] = masked_id - id_base + out_base;
+		arg->args_count = 1;
 
 		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
 			np, map_name, map_mask, id_base, out_base,
@@ -2193,11 +2190,11 @@ int of_map_id(const struct device_node *np, u32 id,
 	}
 
 	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
-		id, target && *target ? *target : NULL);
+		id, filter_np);
 
 	/* Bypasses translation */
-	if (id_out)
-		*id_out = id;
+	arg->args[0] = id;
+	arg->args_count = 1;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_map_id);
@@ -2207,17 +2204,19 @@ EXPORT_SYMBOL_GPL(of_map_id);
  * @np: root complex device node.
  * @id: Requester ID of the device (e.g. PCI RID/BDF or a platform
  *      stream/device ID) used as the lookup key in the iommu-map table.
- * @target: optional pointer to a target device node.
- * @id_out: optional pointer to receive the translated ID.
+ * @arg: pointer to a &struct of_phandle_args for the result. On success,
+ *	@arg->args[0] contains the translated ID. If a map entry was matched,
+ *	@arg->np holds a reference to the target node that the caller must
+ *	release with of_node_put().
  *
  * Convenience wrapper around of_map_id() using "iommu-map" and "iommu-map-mask".
  *
  * Return: 0 on success or a standard error code on failure.
  */
 int of_map_iommu_id(const struct device_node *np, u32 id,
-		    struct device_node **target, u32 *id_out)
+		    struct of_phandle_args *arg)
 {
-	return of_map_id(np, id, "iommu-map", "iommu-map-mask", target, id_out);
+	return of_map_id(np, id, "iommu-map", "iommu-map-mask", NULL, arg);
 }
 EXPORT_SYMBOL_GPL(of_map_iommu_id);
 
@@ -2226,16 +2225,21 @@ EXPORT_SYMBOL_GPL(of_map_iommu_id);
  * @np: root complex device node.
  * @id: Requester ID of the device (e.g. PCI RID/BDF or a platform
  *      stream/device ID) used as the lookup key in the msi-map table.
- * @target: optional pointer to a target device node.
- * @id_out: optional pointer to receive the translated ID.
+ * @filter_np: optional MSI controller node to filter matches by, or NULL
+ *	to match any. If non-NULL, only map entries targeting this node will
+ *	be matched.
+ * @arg: pointer to a &struct of_phandle_args for the result. On success,
+ *	@arg->args[0] contains the translated ID. If a map entry was matched,
+ *	@arg->np holds a reference to the target node that the caller must
+ *	release with of_node_put().
  *
  * Convenience wrapper around of_map_id() using "msi-map" and "msi-map-mask".
  *
  * Return: 0 on success or a standard error code on failure.
  */
 int of_map_msi_id(const struct device_node *np, u32 id,
-		  struct device_node **target, u32 *id_out)
+		  const struct device_node *filter_np, struct of_phandle_args *arg)
 {
-	return of_map_id(np, id, "msi-map", "msi-map-mask", target, id_out);
+	return of_map_id(np, id, "msi-map", "msi-map-mask", filter_np, arg);
 }
 EXPORT_SYMBOL_GPL(of_map_msi_id);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index e37c1b3f8736..f86a56bd81fc 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -817,8 +817,16 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
 	 * "msi-map" or an "msi-parent" property.
 	 */
 	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
-		if (!of_map_msi_id(parent_dev->of_node, id_in, msi_np, &id_out))
+		struct of_phandle_args msi_spec = {};
+
+		if (!of_map_msi_id(parent_dev->of_node, id_in, *msi_np, &msi_spec)) {
+			id_out = msi_spec.args[0];
+			if (!*msi_np)
+				*msi_np = msi_spec.np;
+			else
+				of_node_put(msi_spec.np);
 			break;
+		}
 		if (!of_check_msi_parent(parent_dev->of_node, msi_np))
 			break;
 	}
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index bff8289f804a..c0544d9c0921 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1137,30 +1137,32 @@ static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
 
 static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 {
+	struct of_phandle_args iommu_spec = {};
+	struct of_phandle_args msi_spec = {};
 	struct device *dev = imx_pcie->pci->dev;
-	struct device_node *target;
 	u32 sid_i, sid_m;
 	int err_i, err_m;
 	u32 sid = 0;
 
-	target = NULL;
-	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
-	if (target) {
-		of_node_put(target);
-	} else {
+	err_i = of_map_iommu_id(dev->of_node, rid, &iommu_spec);
+	if (!err_i)
+		sid_i = iommu_spec.args[0];
+	of_node_put(iommu_spec.np);
+	if (!err_i && !iommu_spec.np) {
 		/*
-		 * "target == NULL && err_i == 0" means RID out of map range.
-		 * Use 1:1 map RID to streamID. Hardware can't support this
-		 * because the streamID is only 6 bits
+		 * "iommu_spec.np == NULL && err_i == 0" means RID out of map
+		 * range. Use 1:1 map RID to streamID. Hardware can't support
+		 * this because the streamID is only 6 bits.
 		 */
 		err_i = -EINVAL;
 	}
 
-	target = NULL;
-	err_m = of_map_msi_id(dev->of_node, rid, &target, &sid_m);
-
+	err_m = of_map_msi_id(dev->of_node, rid, NULL, &msi_spec);
+	if (!err_m)
+		sid_m = msi_spec.args[0];
+	of_node_put(msi_spec.np);
 	/*
-	 *   err_m      target
+	 *   err_m      msi_spec.np
 	 *	0	NULL		RID out of range. Use 1:1 map RID to
 	 *				streamID, Current hardware can't
 	 *				support it, so return -EINVAL.
@@ -1168,10 +1170,8 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 	 *	0	!= NULL		Get correct streamID from RID
 	 *	!= 0	!= NULL		Invalid combination
 	 */
-	if (!err_m && !target)
+	if (!err_m && !msi_spec.np)
 		return -EINVAL;
-	else if (target)
-		of_node_put(target); /* Find streamID map entry for RID in msi-map */
 
 	/*
 	 * msi-map        iommu-map
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index a0937b7b3c4d..c2cffc0659f4 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -755,6 +755,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
 {
 	u32 sid, rid = pci_dev_id(pdev);
 	struct apple_pcie_port *port;
+	struct of_phandle_args iommu_spec = {};
 	int idx, err;
 
 	port = apple_pcie_get_port(pdev);
@@ -764,10 +765,12 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
 	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
 		pci_name(pdev->bus->self), port->idx);
 
-	err = of_map_iommu_id(port->pcie->dev->of_node, rid, NULL, &sid);
+	err = of_map_iommu_id(port->pcie->dev->of_node, rid, &iommu_spec);
 	if (err)
 		return err;
 
+	of_node_put(iommu_spec.np);
+	sid = iommu_spec.args[0];
 	mutex_lock(&port->pcie->lock);
 
 	idx = bitmap_find_free_region(port->sid_map, port->sid_map_sz, 0);
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 1b7696b2d762..2aa1a772a0ff 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -319,13 +319,13 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
 					   struct device_node *np,
 					   domid_t *backend_domid)
 {
-	struct of_phandle_args iommu_spec = { .args_count = 1 };
+	struct of_phandle_args iommu_spec = {};
 
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 		u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
 
-		if (of_map_iommu_id(np, rid, &iommu_spec.np, iommu_spec.args)) {
+		if (of_map_iommu_id(np, rid, &iommu_spec)) {
 			dev_dbg(dev, "Cannot translate ID\n");
 			return -ESRCH;
 		}
diff --git a/include/linux/of.h b/include/linux/of.h
index fe841f3cc747..8548cd9eb4f1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -463,13 +463,13 @@ bool of_console_check(const struct device_node *dn, char *name, int index);
 
 int of_map_id(const struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
-	       struct device_node **target, u32 *id_out);
+	       const struct device_node *filter_np, struct of_phandle_args *arg);
 
 int of_map_iommu_id(const struct device_node *np, u32 id,
-		    struct device_node **target, u32 *id_out);
+		    struct of_phandle_args *arg);
 
 int of_map_msi_id(const struct device_node *np, u32 id,
-		  struct device_node **target, u32 *id_out);
+		  const struct device_node *filter_np, struct of_phandle_args *arg);
 
 phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
 
@@ -935,19 +935,21 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
 
 static inline int of_map_id(const struct device_node *np, u32 id,
 			     const char *map_name, const char *map_mask_name,
-			     struct device_node **target, u32 *id_out)
+			     const struct device_node *filter_np,
+			     struct of_phandle_args *arg)
 {
 	return -EINVAL;
 }
 
 static inline int of_map_iommu_id(const struct device_node *np, u32 id,
-				  struct device_node **target, u32 *id_out)
+				  struct of_phandle_args *arg)
 {
 	return -EINVAL;
 }
 
 static inline int of_map_msi_id(const struct device_node *np, u32 id,
-				struct device_node **target, u32 *id_out)
+				const struct device_node *filter_np,
+				struct of_phandle_args *arg)
 {
 	return -EINVAL;
 }

-- 
2.34.1

