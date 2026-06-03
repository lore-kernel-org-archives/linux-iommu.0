Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81EE37C930
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470857; cv=none; b=Al+TPAfqDQZU/9yBYISKZ2Eg8fhT4TrvtSw/ls5ikyoMgSU3pIM7cnYXOlTtE6qCLGJdkU9sy/qYyfWXp44MrvGsP2R1WRzpTiPq7MNas4JbnvB7ztphD8JXAdCkz98bmxL7kY1uOON7II1I7Ii4XW794sCbe+5Iv5L9cart7s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470857; c=relaxed/simple;
	bh=ev1v5Koo83GvdSKBh6LfG5xqwoVu/Hy7SteBpEU3qsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P4hyTqm9HpxGcUspjBeL8pGQ7rUJcFZchuV2IIxBZNlHaa82Cg1G6cVFk/GqGUynbW/c7bg+tS3iz6xJMxYR1+yFhndYUny/3Bw5QsLkOgqYQe/hovmMLCEDOi8GAm2vzcR9qk6GF2TLHntXKCmzU8mg7ou0g0WFEoDz7q1QBE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H3scntiX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bKkjKKtU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H3scntiX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bKkjKKtU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RIfJ2076177
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 07:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vWOTiDUibzqekz7rYfayQWy2AJ39XhDr3pyUdTs3ags=; b=H3scntiXFhn/Zwn2
	M1oV3kxilwZLn1ptkcUSNog2VlGcoJEF0lf48yNjW1KxHv+j0UwGh3o7o1zEkvsw
	AO5vvXKimDfEItdcSzVru5lvEnquQtfF+FLnc8sL03m1BaF3NTtLWwdAsFVkEf8y
	9OZMYWwIxnR9Nh2Nx3N2nVhWqCdqNZMH3J9t7tOm8aAixuqqfiGKKzRfndj1QnlR
	O9yxcIqAug7d+5itW+u2BDAx30yvjD3J6C1ZccdECOhc54g4OrpcxC8wXdejZOV2
	FpmryMevMaOxNN/i0LdldRZ2eAPG4QPKOpvkT52jwFLfvAAl3zB9qAHyFLc0xbwV
	YRLUrA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev1882a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:14:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c32faa62so61512565ad.2
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 00:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780470853; x=1781075653; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWOTiDUibzqekz7rYfayQWy2AJ39XhDr3pyUdTs3ags=;
        b=bKkjKKtUTVAxcSkJVGv6TzEUVQFlsknJ8hKnrumDKcVCDdsxrO/OhHZ811EXSs+5ET
         P/JI05zXRoRXOuFMes4geYlmA2ijlRe3j6AlDYFOTYSZQ1bkC8/n0BEDZ+pmwc6x9Vhy
         0ZV4vYmfcJ/g+dcPWdP7MEPZ9qyrb6L69va4/q3GJAo1qqKTFPFSEuAAzBeSiYQFP5wv
         +0q+h9p3/LibVNs/2CevYdTqEDMAjxJHjt9XXWjRuc06jgLpT+Qraes9UpsLDk5QLLLj
         xp3uH38H7zCP/vPiXHnmXC1MjwSvYbWGOB61iZdJLEOTIy8BU7i3GJVI2uW+QhnGeP7E
         He6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780470853; x=1781075653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vWOTiDUibzqekz7rYfayQWy2AJ39XhDr3pyUdTs3ags=;
        b=Lse2Zfi5VRuIRzsxY+NQLe5nxgVJQVYGUUnzaJt82Wk/2C8RLCyG0e7fx+TAUoecon
         HAmHVtzQF1/m8/w6nk4W8+MEC7QnYZrBWXEIgljPmmkp+xImJihQQH8x2HxwhVQV9xeH
         AAnv5AbrujnLmb49oFO2uy7G5ynoIxFCU4fEfHfqf1V95iFG5xEKHl9sBPeevI7X9JVm
         86obXX3xtt8rmzGS7mhP2Sslp8GgMP6zBHzLpfnjw+nsAmfA+73VsT07w3hFflUpcuOo
         26pLXrOmGaRTzViJuFRHZeMwM5fZ5HrOkIGayAd88C1lKViKEdzkAcn0Ws96bQUBUklq
         nZng==
X-Forwarded-Encrypted: i=1; AFNElJ9NAdjAiV4tUFHY1Xt6yK0RZ8Ip7ewB+TAC0ipxAzS7o792ay3e3qsj5WsdOtAJnPkp7rhjeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVRyfeQ2GcN1RBEy/0R8EUVkyIDdwWcH49srZg+NOLktkXkxt7
	FnI6QEJGEM1PbgUXb/uJG6t1m46Me/ysSx67DUNce+xcTFn+APFgqgEsgIIthRT/E4HOOrNsnap
	jhaeiXH6GlpuY4sPwUx8loTXCTIPSip2H4TYqnIyRd8voHbK9DUPPsoYboA==
X-Gm-Gg: Acq92OFVgQHmqYyxAd01mmMUsOXfw/VI1FZpC2LfJYE9VPllQBEHzg8LJSowbzkmOi9
	DjcNfHM6oqUHwqNFES2VSGdftKq/4jKy8E79UdUK6GDXCx94pH6V+PTMxd2N03ewJG+JW3J5ubH
	3N2bWWLBRmH3PCGWVwd9SOD1trhkAYN5bKLSPh0NfxfvXHj/ffrR5EfhkNnrsfv4bDIM90P6ZWf
	KMOaukczZw4YBWuUSk89BDF2eMOJukdhMy1ureLe7qr6KFOcIaeUX1GJ0ig7sXpS2VTKuDQNQlX
	T/N9KhAxZMq6pxQPt/9UFG3MTpRhgC36fK/tfxBpW1ZSLW77BfA/epL6JHobiXJhT89zfExCa15
	NwHpgYqVhafcF6iFXhnXRRz5CK3BxCGxUTxUPWYuwZImaq1GxUG4qqbHQIYZ0z2G67pc=
X-Received: by 2002:a17:902:d48d:b0:2c0:e158:1dfa with SMTP id d9443c01a7336-2c163fa480cmr21450495ad.21.1780470852445;
        Wed, 03 Jun 2026 00:14:12 -0700 (PDT)
X-Received: by 2002:a17:902:d48d:b0:2c0:e158:1dfa with SMTP id d9443c01a7336-2c163fa480cmr21449815ad.21.1780470851846;
        Wed, 03 Jun 2026 00:14:11 -0700 (PDT)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8429fsm17249725ad.18.2026.06.03.00.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 00:14:11 -0700 (PDT)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 12:43:13 +0530
Subject: [PATCH v16 2/3] of: Factor arguments passed to of_map_id() into a
 struct
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260603-parse_iommu_cells-v16-2-dc509dacb19a@oss.qualcomm.com>
References: <20260603-parse_iommu_cells-v16-0-dc509dacb19a@oss.qualcomm.com>
In-Reply-To: <20260603-parse_iommu_cells-v16-0-dc509dacb19a@oss.qualcomm.com>
To: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        imx@lists.linux.dev, xen-devel@lists.xenproject.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780470825; l=19290;
 i=vijayanand.jitta@oss.qualcomm.com; s=20260301; h=from:subject:message-id;
 bh=YiZjwxHFmgOTQ3MYzgU/NvAq2Xi8EN05+apizd5wwmk=;
 b=I3GdCPp+x6ge6k1jyOA5PCHKcLLXuNe+TCFT5XeIaSElRQZx+dEblDkXZ+AiE972ZbgFT31Pd
 /TY2LTvxlPWDZpJrrcL6Hq2haJC+KYF4OjW8pbfMvTHH73CalUCTfUi
X-Developer-Key: i=vijayanand.jitta@oss.qualcomm.com; a=ed25519;
 pk=Lpi7Cs3wHe8KZtqvyci7FTOLzsKpEHKGCaPNZw+1zRI=
X-Proofpoint-ORIG-GUID: IlmhweV_Zsg2gAJVc2kfUorS6Z8gqtdl
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a1fd445 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=YNKo5iN9BcXwmsqDYIQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: IlmhweV_Zsg2gAJVc2kfUorS6Z8gqtdl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NiBTYWx0ZWRfX22E5RxHkKV96
 b7f6rYRMhHwO5KL/PmERpoCwzsi2egt1PlyAxgpExH1PqEmuaIc/cg7QBnniCCvxKjrQc1OUI+q
 nuPOpD17eleK6lPCm9AaYbycWV4H8XpFCRbna8uhOjgeGKAPet1xGR1Rn8xo9BKgGf8Sv5urt2o
 XKVE6A+BOa6L2oiDC4x4Iut/N3iLjcR48BERWdbShmJ1V7MV7UZCANf2+he8+M0GK3EuG1H5+qE
 PfqP+/hu8UIGuA17f3Yaw5m1+zCdsECsffOP+PEoSMAzaF7Yx0dHcFWK8Y0EUbor72mM9np1sNW
 hB598a3waWFMoGR35CWqLZkZ56qIfVsyPa1ROVA5nl79iTVRDanD2oLvM5eoKz9L/Tydr/+HnsB
 sS8HU3lylCLAcyv5SlOBRURv6zIzZdvtpWr2JgsDfz8jecNQat1wkInfXVBHF4fMpb1VvM6Dm9h
 9s4fb+ZiUGcCLzGEP1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030066

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

Acked-by: Frank Li <Frank.Li@nxp.com>
Suggested-by: Rob Herring (Arm) <robh@kernel.org>
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
 drivers/cdx/cdx_msi.c                    |  7 ++--
 drivers/iommu/of_iommu.c                 |  4 +-
 drivers/irqchip/irq-gic-its-msi-parent.c | 10 +++--
 drivers/of/base.c                        | 71 ++++++++++++++++++--------------
 drivers/of/irq.c                         | 31 ++++++++++----
 drivers/pci/controller/dwc/pci-imx6.c    | 53 ++++++++++++------------
 drivers/pci/controller/pcie-apple.c      |  5 ++-
 drivers/xen/grant-dma-ops.c              |  4 +-
 include/linux/of.h                       | 16 ++++---
 9 files changed, 119 insertions(+), 82 deletions(-)

diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
index 78edb7308856..c8d832b0b1f5 100644
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
 		dev_err(dev, "of_map_msi_id failed for MSI: %d\n", ret);
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
index b63343a227a9..b9257103a999 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -152,6 +152,8 @@ static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u32 *dev_id,
 				phys_addr_t *pa)
 {
+	struct device_node *msi_ctrl = NULL;
+	struct of_phandle_args msi_spec = {};
 	struct of_phandle_iterator it;
 	int ret;
 
@@ -178,9 +180,11 @@ static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u
 		}
 	}
 
-	struct device_node *msi_ctrl __free(device_node) = NULL;
-
-	return of_map_msi_id(dev->of_node, dev->id, &msi_ctrl, dev_id);
+	ret = of_map_msi_id(dev->of_node, dev->id, &msi_ctrl, &msi_spec);
+	if (!ret)
+		*dev_id = msi_spec.args[0];
+	of_node_put(msi_spec.np);
+	return ret;
 }
 
 static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 1e9b9692c0d9..d658c2620135 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2122,36 +2122,40 @@ int of_find_last_cache_level(unsigned int cpu)
  * @id: device ID to map.
  * @map_name: property name of the map to use.
  * @map_mask_name: optional property name of the mask to use.
- * @target: optional pointer to a target device node.
- * @id_out: optional pointer to receive the translated ID.
+ * @filter_np: pointer to an optional filter node, or NULL to allow bypass.
+ *	If non-NULL, the map property must exist (-ENODEV if absent). If
+ *	*filter_np is also non-NULL, only entries targeting that node match.
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
+	       struct device_node * const *filter_np, struct of_phandle_args *arg)
 {
 	u32 map_mask, masked_id;
 	int map_len;
 	const __be32 *map = NULL;
 
-	if (!np || !map_name || (!target && !id_out))
+	if (!np || !map_name || !arg)
 		return -EINVAL;
+	/* Ensure bypass/no-match success never returns a stale target node. */
+	arg->np = NULL;
 
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
 
@@ -2193,18 +2197,14 @@ int of_map_id(const struct device_node *np, u32 id,
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
+		if (filter_np && *filter_np && *filter_np != phandle_node) {
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
@@ -2213,11 +2213,11 @@ int of_map_id(const struct device_node *np, u32 id,
 	}
 
 	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
-		id, target && *target ? *target : NULL);
+		id, filter_np && *filter_np ? *filter_np : NULL);
 
 	/* Bypasses translation */
-	if (id_out)
-		*id_out = id;
+	arg->args[0] = id;
+	arg->args_count = 1;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_map_id);
@@ -2227,17 +2227,19 @@ EXPORT_SYMBOL_GPL(of_map_id);
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
 
@@ -2246,16 +2248,21 @@ EXPORT_SYMBOL_GPL(of_map_iommu_id);
  * @np: root complex device node.
  * @id: Requester ID of the device (e.g. PCI RID/BDF or a platform
  *      stream/device ID) used as the lookup key in the msi-map table.
- * @target: optional pointer to a target device node.
- * @id_out: optional pointer to receive the translated ID.
+ * @filter_np: pointer to an optional filter node, or NULL to allow bypass.
+ *	If non-NULL, the map property must exist (-ENODEV if absent). If
+ *	*filter_np is also non-NULL, only entries targeting that node match.
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
+		  struct device_node * const *filter_np, struct of_phandle_args *arg)
 {
-	return of_map_id(np, id, "msi-map", "msi-map-mask", target, id_out);
+	return of_map_id(np, id, "msi-map", "msi-map-mask", filter_np, arg);
 }
 EXPORT_SYMBOL_GPL(of_map_msi_id);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index e37c1b3f8736..967c19100879 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -796,14 +796,15 @@ static int of_check_msi_parent(struct device_node *dev_node, struct device_node
 /**
  * of_msi_xlate - map a MSI ID and find relevant MSI controller node
  * @dev: device for which the mapping is to be done.
- * @msi_np: Pointer to target MSI controller node
+ * @msi_np: Pointer to target MSI controller node, or NULL if the caller
+ *           only needs the translated ID without receiving the controller node.
+ *           If non-NULL and pointing to a non-NULL node, only entries targeting
+ *           that node will be matched. If non-NULL and pointing to NULL, it will
+ *           receive the first matching target node with a reference held.
  * @id_in: Device ID.
  *
  * Walk up the device hierarchy looking for devices with a "msi-map"
  * or "msi-parent" property. If found, apply the mapping to @id_in.
- * If @msi_np points to a non-NULL device node pointer, only entries targeting
- * that node will be matched; if it points to a NULL value, it will receive the
- * device node of the first matching target phandle, with a reference held.
  *
  * Returns: The mapped MSI id.
  */
@@ -817,9 +818,22 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
 	 * "msi-map" or an "msi-parent" property.
 	 */
 	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
-		if (!of_map_msi_id(parent_dev->of_node, id_in, msi_np, &id_out))
+		struct of_phandle_args msi_spec = {};
+
+		if (!of_map_msi_id(parent_dev->of_node, id_in, msi_np, &msi_spec)) {
+			if (msi_spec.np) {
+				/* msi-map matched: use the translated ID and target node */
+				if (msi_spec.args_count > 0)
+					id_out = msi_spec.args[0];
+				if (msi_np && !*msi_np)
+					*msi_np = of_node_get(msi_spec.np);
+				of_node_put(msi_spec.np);
+			}
+			/* msi-map present but no match → stop walking */
 			break;
-		if (!of_check_msi_parent(parent_dev->of_node, msi_np))
+		}
+		/* -ENODEV: msi-map absent → check for msi-parent */
+		if (msi_np && !of_check_msi_parent(parent_dev->of_node, msi_np))
 			break;
 	}
 	return id_out;
@@ -841,9 +855,12 @@ struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
 						u32 bus_token)
 {
 	struct device_node *np = NULL;
+	struct irq_domain *d;
 
 	of_msi_xlate(dev, &np, id);
-	return irq_find_matching_host(np, bus_token);
+	d = irq_find_matching_host(np, bus_token);
+	of_node_put(np);
+	return d;
 }
 
 /**
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c863c7b02289..105038c15aa8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1121,41 +1121,42 @@ static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
 
 static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 {
+	struct of_phandle_args iommu_spec = {};
+	struct of_phandle_args msi_spec = {};
 	struct device *dev = imx_pcie->pci->dev;
-	struct device_node *target;
+	struct device_node *msi_filter = NULL;
 	u32 sid_i, sid_m;
 	int err_i, err_m;
 	u32 sid = 0;
 
-	target = NULL;
-	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
-	if (target) {
-		of_node_put(target);
-	} else {
-		/*
-		 * "target == NULL && err_i == 0" means RID out of map range.
-		 * Use 1:1 map RID to streamID. Hardware can't support this
-		 * because the streamID is only 6 bits
-		 */
-		err_i = -EINVAL;
+	err_i = of_map_iommu_id(dev->of_node, rid, &iommu_spec);
+	if (!err_i) {
+		if (!iommu_spec.np)
+			/*
+			 * "iommu_spec.np == NULL && err_i == 0" means RID out of map
+			 * range. Use 1:1 map RID to streamID. Hardware can't support
+			 * this because the streamID is only 6 bits.
+			 */
+			err_i = -EINVAL;
+		else
+			sid_i = iommu_spec.args[0];
 	}
+	of_node_put(iommu_spec.np);
 
-	target = NULL;
-	err_m = of_map_msi_id(dev->of_node, rid, &target, &sid_m);
-
+	err_m = of_map_msi_id(dev->of_node, rid, &msi_filter, &msi_spec);
 	/*
-	 *   err_m      target
-	 *	0	NULL		RID out of range. Use 1:1 map RID to
-	 *				streamID, Current hardware can't
-	 *				support it, so return -EINVAL.
-	 *      != 0    NULL		msi-map does not exist, use built-in MSI
-	 *	0	!= NULL		Get correct streamID from RID
-	 *	!= 0	!= NULL		Invalid combination
+	 *   err_m      msi_spec.np
+	 *	0	!= NULL		Got correct streamID from RID via msi-map
+	 *	0	NULL		msi-map present but RID out of range
+	 *	-ENODEV	NULL		msi-map absent, use built-in MSI controller
 	 */
-	if (!err_m && !target)
-		return -EINVAL;
-	else if (target)
-		of_node_put(target); /* Find streamID map entry for RID in msi-map */
+	if (!err_m) {
+		if (!msi_spec.np)
+			/* msi-map present but RID out of range */
+			return -EINVAL;
+		sid_m = msi_spec.args[0];
+	}
+	of_node_put(msi_spec.np);
 
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
index 721525334b4b..ea50b45d9ff7 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -466,13 +466,15 @@ bool of_console_check(const struct device_node *dn, char *name, int index);
 
 int of_map_id(const struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
-	       struct device_node **target, u32 *id_out);
+	       struct device_node * const *filter_np,
+	       struct of_phandle_args *arg);
 
 int of_map_iommu_id(const struct device_node *np, u32 id,
-		    struct device_node **target, u32 *id_out);
+		    struct of_phandle_args *arg);
 
 int of_map_msi_id(const struct device_node *np, u32 id,
-		  struct device_node **target, u32 *id_out);
+		  struct device_node * const *filter_np,
+		  struct of_phandle_args *arg);
 
 phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
 
@@ -949,19 +951,21 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
 
 static inline int of_map_id(const struct device_node *np, u32 id,
 			     const char *map_name, const char *map_mask_name,
-			     struct device_node **target, u32 *id_out)
+			     struct device_node * const *filter_np,
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
+				struct device_node * const *filter_np,
+				struct of_phandle_args *arg)
 {
 	return -EINVAL;
 }

-- 
2.34.1

