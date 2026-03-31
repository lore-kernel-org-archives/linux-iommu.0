Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB53FA5E6
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965926; cv=none; b=SUhhqNh/LT/41xnXylIAWPdU8BPV5QnacEcxccjX0vhTIj7hPRjBimCQ6NV51kn+cw2fx21sZfaOn7c8KxwjdcDDzkjlIBPMXTZty6srbIzC9kH2PnQ5URRT+Vdyo2swRIQ5hoU60WLcE67kNd48xj5DIvIVNsDZ/5Iw1Yx9Hvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965926; c=relaxed/simple;
	bh=bmn9oR4CHseVq+Q1yzNkzndMq0RHssJSS9rv7b6NSno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lkEsoESVzd9cWxzxK9Fhvv3pIL0XR9oxNcJu/iOC7pmt6FLZDpvKMVXsTzsKUx7CWKnaLWKCrnGIMYqn0D+E86SRo2tE0Z+QUQ3dvPYWzzWOQvxdL1Fa1yXfgCTNvNcnWcAT35qOP8vLNfMhiWM7anQrtwtZhl7l9MRwkAPG6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RgiUSu9g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KsO7Q4WL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RgiUSu9g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KsO7Q4WL"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V8jw6K2049480
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 14:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QkYW84mNfsxJu25KdM9HhqHWqHHn7yyj15gOr+bOnfo=; b=RgiUSu9g7AoFyfvs
	ptTYIVlwTLWC9JMVG87FjWuMJhT3X+bdqzD2zspSf8TGK2V23VRlvI2vJdP1tOBc
	HGYsn6U138NuT08zss8A6YtH5ke9KV2LT3db8OARBEvAN+gXMg3+rwGDIRiGjv3G
	qGy85z/wQ5RuHNOOBCE7VFgPS/aUfBoqz+e6VGzzcz/MmhsV5z30sAxrVwZmj8Uk
	GOo/L9byvX/voIrGGQKM+31zAnE5mUY8jykPmvbdxjT8DkakS0FYfgqReU4pbA8V
	drCd4Ldw5qP3KsSuZCDenW+gQWo400PINJ6i6nGUOOTmOrCePDsCGLdqMS9rffHz
	kuplrw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8b1ys9ey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 14:05:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b242b9359aso33191135ad.0
        for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774965919; x=1775570719; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkYW84mNfsxJu25KdM9HhqHWqHHn7yyj15gOr+bOnfo=;
        b=KsO7Q4WL+yZ//22tG9GNNQ4UWKfgcJjvSKwXsos4sv2RiQYxqytOkD3Xy2k3EL5zdY
         myITjzh9hQlfCq/VtaaA6AZIE4FNo9GUaz5C9lZCH5lfbG0/B0YidHdKhfUjD9sFpVeu
         nvY4eFEtsyB2OxuhyCPj2zIgQmsmyATIQf1whUJo02Dbi49UZY8CUZibQlwXCGA5DA1g
         54eeeujF714yCGN6AJlNsfHVveB3/Y9jgnQOmin6TBjPVeuJLk2F7snwPsUc8z9wCD9S
         I3AbApccP6e8OeUY6gd8/wxSqsWMfycIU2BwdyNS9YOhij4TyVq/gv3KRy0Zh7qQjWzV
         Ax5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774965919; x=1775570719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QkYW84mNfsxJu25KdM9HhqHWqHHn7yyj15gOr+bOnfo=;
        b=FU1QL16RiscLHOtOCucq/B9mGW7IaLc7HEESB0RpcI3RlqMS+3llHea73ujgoWdG8A
         rIB4g5u3fCutrZlfs2b2sMhv0VODRpV41PGapwbqnG2NIrO1D0bPBnKmm//ZY+5Opp8J
         9zkvGbAwamt4N6ctHvimZgbDzPKI1uzqUcAO6upAHgepPa8oeDjGb2OCkmAChhMjDhL5
         vih7WZI6jXyDghARGtUZ6QwZU1nI30RJQxYiOnp383z7lwBsQtnu9HvhUJbrqWn8YLf/
         c9AxnmVE4MmwMGpmD//dtDb1tIdVqQh4Zaz8r7bGOlZD8IdBjYEwy4+MhHSDrkKhLifF
         m4Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWUAeGPtysUa3wlQZnNI4445WzaBFuKxkTopZeHQYBNUqxLHw+48Dubbsi/QzMANqxzeOs13A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9vwma2/WHc6OLymzFpjo/fqUcyBNE0cugp40EhiSurap23mrc
	B4vK9Kw7KnAWtU5axkoRuMmJISPTACFRqn3kD+fSdeUZfdi7XBmztHSA4m4c7bb5/fIgybkIu/r
	yHmPxXc/y7EMfXY+jkqD+ZpLN28ch9w8yuayKeRH/SFG+p4Rhe/eQmnjibQ==
X-Gm-Gg: ATEYQzzh0PNse7kNGHXpxLqp2uGf6owwxgtOVBSyKn3FKibulav3hhbUHsRTCT+LQVa
	Z92UvscVGL5d9ITmgPa6CphujNmMy2Es8jbm5jeLx3Avp95fcSjcaLAPMElmMekQylnyfwcM9jo
	SwUTeeQ9c0mbz18tiw5hE4X25DZxsbLoOt0T0BrypwgeSYAN6SiGyElE77f2qHc+41SP8SrcrIa
	y3dyEJK7scBKDVrhDTB+6cIGrcucc7MTIuP/wh8ABBhF/bg//xUvfHJpwm/12DXLWRzcIfQwEb0
	qPB5kipDKxpLvdFsUZzk11neU938NQPDd+38dzKdP0eikc+quRqIWE0T3BKDDqMK7oDuLIoqnbE
	OPCDT9cdRa0naev4N132KVNOp6uhTwMmq+PtU7VD7LrWxHTWMK+CDPeV9
X-Received: by 2002:a17:902:db08:b0:2ae:cb0e:fd59 with SMTP id d9443c01a7336-2b0cdc0fc5emr165601545ad.8.1774965918962;
        Tue, 31 Mar 2026 07:05:18 -0700 (PDT)
X-Received: by 2002:a17:902:db08:b0:2ae:cb0e:fd59 with SMTP id d9443c01a7336-2b0cdc0fc5emr165600885ad.8.1774965918166;
        Tue, 31 Mar 2026 07:05:18 -0700 (PDT)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24264292asm118311945ad.4.2026.03.31.07.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:05:17 -0700 (PDT)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 19:34:46 +0530
Subject: [PATCH v12 1/3] of: Add convenience wrappers for of_map_id()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-parse_iommu_cells-v12-1-decfd305eea9@oss.qualcomm.com>
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
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774965896; l=8620;
 i=vijayanand.jitta@oss.qualcomm.com; s=20260301; h=from:subject:message-id;
 bh=Bsp9hT6sgzNh1NrIZ0uduUy4Yj5U0gq9szC+ECoPqVA=;
 b=tsEE+RQ7gWHQGS4XxDdkilLUkkMXlbqEzvoPUXNHXZ53+KX3OuKmN7j4DXkq1ONE/QupEszbc
 gIFNjHgeJiVBTFUAyAwqSBUYHZeIsBYMofr3AlrciWtlyxmdcakIFGy
X-Developer-Key: i=vijayanand.jitta@oss.qualcomm.com; a=ed25519;
 pk=Lpi7Cs3wHe8KZtqvyci7FTOLzsKpEHKGCaPNZw+1zRI=
X-Proofpoint-GUID: gmnWYHObXRUPp3TTxugC2DuwiTz3WqcA
X-Proofpoint-ORIG-GUID: gmnWYHObXRUPp3TTxugC2DuwiTz3WqcA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEzNyBTYWx0ZWRfX4bgirDhKunGj
 8n1OUtBDTuxQ9CNweyFB01r/aBf15s6n249uvW6C8tz3ksCA+HEmn6v9vAfM7cFLPg+IW4rGvB2
 D+nsjQyA2CM4uBEkuJzwkL3PBpPYMfFB9ohVmfLeIhIbI3jErrF1u+FHDF7pctfbK4KGQMebLBk
 Sw2Lrb4nrk3I3xvo1frZ4d0HP4OsJTti7JqxQrF0Zu1fZTgAU1kx9kNXjwA9bGj3W9REPI7OkkL
 f1Lxa2moG4JAVbbVC+H7qU6mdK7w484ZIK0uYFDKagyHvg+NZBiuK7HkBO1ET/tFqnKJNHYoqkQ
 quLJz3XnZIIaYCG0PGuMgmp3ufTsmSfr1KM8Ym/DrN9dD1+lhHhMFSBkcM/TBT7echDDH6aWjm5
 rwKXYqFsyheJqlDDdfVjpPiO54C7du8GvBFE4/RE3+Ertfr+DwJSoEACVuHDSAc0uO1Sf5DvW2U
 QjV9VW/Nn1YqxjAUgUg==
X-Authority-Analysis: v=2.4 cv=aJT9aL9m c=1 sm=1 tr=0 ts=69cbd4a0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=f4O9XJQV64orvU1ydW8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310137

From: Robin Murphy <robin.murphy@arm.com>

Since we now have quite a few users parsing "iommu-map" and "msi-map"
properties, give them some wrappers to conveniently encapsulate the
appropriate sets of property names. This will also make it easier to
then change of_map_id() to correctly account for specifier cells.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
 drivers/cdx/cdx_msi.c                    |  3 +--
 drivers/iommu/of_iommu.c                 |  4 +---
 drivers/irqchip/irq-gic-its-msi-parent.c |  2 +-
 drivers/of/base.c                        | 38 ++++++++++++++++++++++++++++++++
 drivers/of/irq.c                         |  3 +--
 drivers/pci/controller/dwc/pci-imx6.c    |  6 ++---
 drivers/pci/controller/pcie-apple.c      |  3 +--
 drivers/xen/grant-dma-ops.c              |  3 +--
 include/linux/of.h                       | 18 +++++++++++++++
 9 files changed, 64 insertions(+), 16 deletions(-)

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
index d36b278ae66c..b63343a227a9 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -180,7 +180,7 @@ static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u
 
 	struct device_node *msi_ctrl __free(device_node) = NULL;
 
-	return of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &msi_ctrl, dev_id);
+	return of_map_msi_id(dev->of_node, dev->id, &msi_ctrl, dev_id);
 }
 
 static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 57420806c1a2..ae04487bd614 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2201,3 +2201,41 @@ int of_map_id(const struct device_node *np, u32 id,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_map_id);
+
+/**
+ * of_map_iommu_id - Translate an ID using "iommu-map" bindings.
+ * @np: root complex device node.
+ * @id: Requester ID of the device (e.g. PCI RID/BDF or a platform
+ *      stream/device ID) used as the lookup key in the iommu-map table.
+ * @target: optional pointer to a target device node.
+ * @id_out: optional pointer to receive the translated ID.
+ *
+ * Convenience wrapper around of_map_id() using "iommu-map" and "iommu-map-mask".
+ *
+ * Return: 0 on success or a standard error code on failure.
+ */
+int of_map_iommu_id(const struct device_node *np, u32 id,
+		    struct device_node **target, u32 *id_out)
+{
+	return of_map_id(np, id, "iommu-map", "iommu-map-mask", target, id_out);
+}
+EXPORT_SYMBOL_GPL(of_map_iommu_id);
+
+/**
+ * of_map_msi_id - Translate an ID using "msi-map" bindings.
+ * @np: root complex device node.
+ * @id: Requester ID of the device (e.g. PCI RID/BDF or a platform
+ *      stream/device ID) used as the lookup key in the msi-map table.
+ * @target: optional pointer to a target device node.
+ * @id_out: optional pointer to receive the translated ID.
+ *
+ * Convenience wrapper around of_map_id() using "msi-map" and "msi-map-mask".
+ *
+ * Return: 0 on success or a standard error code on failure.
+ */
+int of_map_msi_id(const struct device_node *np, u32 id,
+		  struct device_node **target, u32 *id_out)
+{
+	return of_map_id(np, id, "msi-map", "msi-map-mask", target, id_out);
+}
+EXPORT_SYMBOL_GPL(of_map_msi_id);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 6367c67732d2..e37c1b3f8736 100644
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
index be6ec4916adf..fe841f3cc747 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -465,6 +465,12 @@ int of_map_id(const struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out);
 
+int of_map_iommu_id(const struct device_node *np, u32 id,
+		    struct device_node **target, u32 *id_out);
+
+int of_map_msi_id(const struct device_node *np, u32 id,
+		  struct device_node **target, u32 *id_out);
+
 phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
 
 struct kimage;
@@ -934,6 +940,18 @@ static inline int of_map_id(const struct device_node *np, u32 id,
 	return -EINVAL;
 }
 
+static inline int of_map_iommu_id(const struct device_node *np, u32 id,
+				  struct device_node **target, u32 *id_out)
+{
+	return -EINVAL;
+}
+
+static inline int of_map_msi_id(const struct device_node *np, u32 id,
+				struct device_node **target, u32 *id_out)
+{
+	return -EINVAL;
+}
+
 static inline phys_addr_t of_dma_get_max_cpu_address(struct device_node *np)
 {
 	return PHYS_ADDR_MAX;

-- 
2.34.1

