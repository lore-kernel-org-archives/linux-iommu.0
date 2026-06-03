Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185F23FE675
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470847; cv=none; b=lwokBbAuv5nBHsxd7QJruQ94LdAgu5P1f/17Jf0t6cZnkhR1fmwuWThaYsF4f/LTKQK4SluTw6Gtnz21qRFLtRalREjoDoApYOva4S0k5uts4JMxTtnuZjxgLbiXiAyUD3jpt2mgMboQIeIjRaXDq67uCaPot4dm2fkNdl/Zmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470847; c=relaxed/simple;
	bh=phzhKGxsD8t3YkGlCEmeP10wiLTAREuNp3sc6yMT+Ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MMHmyRKZPp0Vpm5WGYyFit6bjF4q2j+1CPJOYNYcSGFbwRQdKTAMvRlkHBbmN4VYbCrBa/5IquZqlZGgp6rTheBthUfj4ONyTAwBvlkYv/ZWzdDwHmiP+8WURBORQ9q4QfzDtP84t7wBQBXqj3EbO/b0ofYOV2CTU78FLMUHICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GXbIxEvx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bWHYrsv4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GXbIxEvx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bWHYrsv4"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536vC7O1755426
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 07:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FIwRGbihw9ibmdw2sFBiy3DnC7QkudGEzjZgfV2uv2w=; b=GXbIxEvxJZ3R2frZ
	6stlexO8WRGPESZ0wsEi2i2X1lAQ3qFn/DMuvCS9B239Q9oTVr9wk2A5V0qOTGWj
	ylLZebYRpx19HKGx86cn5+onAL3CDJ2OopNBk8MliW+jR89283TVCo9tLu74gMEm
	RHzU2JYyHcowHchYTFgn4MDv28ef2r2JjAAKONNESS65l7NKcmN3uO9A1AnhRK4R
	xZWQxRufYYatXtNKaeF+Gh/W0yjQsQQ8QWpbLQLExIR+RNH+IrIZt+4Xaq+D5ieV
	7qoAmGitTLFT/Ht5EQGwqZgD2ADb+Ut9Q1zaAvMNY1ctEAJGl/ylXsOXEsCEmBWJ
	v3qagg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejff002ae-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:14:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0c32faa62so61508965ad.2
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 00:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780470843; x=1781075643; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIwRGbihw9ibmdw2sFBiy3DnC7QkudGEzjZgfV2uv2w=;
        b=bWHYrsv4gjaBaPcsNmEnUpFgfgjel1R0bJ26omJ13ms/aCkkHE5QrptLNKa0az1jsR
         Ll48UMFoclXRodBl1BiHiOJvZD7AqC+YTdyDOHSQfB7ePHcB4gWO2sTkUfx1UAd3wC9l
         miV5OyzQ40EnZmWwNegCa0tj8uJYk9/rBaGV5qWfDOAbpEzyWFkQpeBS9vRE3+w3IvLf
         Ft2ZAlP67ZyK8D9isnxalbtzXLv/usSpYPgqt6OrWNGzjQ3ZDcI0HPMka5BtNF1+1vk0
         wSe2zlpQIHXUoHMwwPEFGoS3jiNYufSzxikktyHCbv5r6m5oCEZN9vRBrpnVfSpLyEd9
         BpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780470843; x=1781075643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FIwRGbihw9ibmdw2sFBiy3DnC7QkudGEzjZgfV2uv2w=;
        b=luiVod85SU3S8g+EynpD2El7BrtazxKBPRpRu3I8VsFkj+A9fBsOfA9zI5j2PMek24
         QBSGv6WcHY5QCPpSLy0EK08nozHQzzNVyT7sYQFxLsg1AazXs5lw5hA3sNOpinJs4Doa
         kVJvj+5BAjYMDuP2MhNpVWmDeGsOkMRl6Etv4rnJIiOUpmuDT5z2X1Hxv6FvUoRiYf+Z
         +xR8aKsQ9vIWZupm24/2+mYzHKwy1VMzNt2s6wZbk2k/SOg8NGfFHkzevZUZil9ytGKo
         fgQCQQzav0lZ9LrV9lhVKlF13AUP36edMjNYe7sFmcvBU9fSmnnvQahsBrVGikj4vDj4
         hzkg==
X-Forwarded-Encrypted: i=1; AFNElJ/nYcg1CDviU+FiaUSGoC4aqqrQloFKSAMycaTXLmAaV/pjHnATBrCrP4qbupc7Nyd9uzDaaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuTaT+nQB98l5IxirflRVhO6PXgjB6a9sVfP0kuw1uv63PuHGt
	W5jbwd/Zl49BctQj/4aWkgeioZiU70CAyM3PH7S4XfQXD7XgWCuFSr44zQ9YSMs6y7LpP+Tp+R2
	pLF+OS90sKk26VTQswB0JuIb+G023C4mQf544b4V57eyxURXb49W/Kq7FSQ==
X-Gm-Gg: Acq92OE3JJIDAgRRDXq2jL3jnfVPzfDZIOiiLeQkllwbHDfnqPF887s/ZVxweqnzRMy
	7RWMQOAj0tAKasTA4IlK+sBoq+2oGpZZPaNgfCZSUSsj31NUQ43dfSWH+DT9C1pvXeurH0wmPqB
	MX7SwbxUY8qGBYE40Ja8/bnAaEIQzbyozMlxhU88feJOfckfpQcsndhHdrqoODyPuWQiGT8EH7n
	2Ihm7S1Nm7YfEn9IDrc7+4b6Y3fqTjXzjGLZVwNx0nVwLwSaXnUjJdRkfrjxCHOoL4nJKgdCxdn
	de9UakLOdbCddlwOzQSubnZb7PIUO0R/7pfZbHNSEkshkVU6StWjYe+V2hA8OFNl9vh8Y0bUAr8
	62N/+iJlJ5b+RrUHFqNtImM8l3EscjCRN/wHBk+S/T6z8hYlmOm1wEU+k4gJUTQrtF1Q=
X-Received: by 2002:a17:903:1209:b0:2c0:dd75:e834 with SMTP id d9443c01a7336-2c163a242e3mr21686775ad.5.1780470842890;
        Wed, 03 Jun 2026 00:14:02 -0700 (PDT)
X-Received: by 2002:a17:903:1209:b0:2c0:dd75:e834 with SMTP id d9443c01a7336-2c163a242e3mr21686495ad.5.1780470842370;
        Wed, 03 Jun 2026 00:14:02 -0700 (PDT)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8429fsm17249725ad.18.2026.06.03.00.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 00:14:01 -0700 (PDT)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 12:43:12 +0530
Subject: [PATCH v16 1/3] of: Add convenience wrappers for of_map_id()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-parse_iommu_cells-v16-1-dc509dacb19a@oss.qualcomm.com>
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
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780470825; l=8692;
 i=vijayanand.jitta@oss.qualcomm.com; s=20260301; h=from:subject:message-id;
 bh=6WwVJdgDC+Pm2Sux0Nsas8KIvED10B5HRfeqtTU/lhc=;
 b=NUPQpvQ7RA71Z0dDCaP8zprJ7zJ8CDz9jnCa1HrYhXvHAGE5W9jsr9K5BqrnxQzWJcs6EHugw
 ySdvNc2zYrwD35BUEPlG8BE8sURF+1SDFW7O+5k/3NMbvz7+/hD+trF
X-Developer-Key: i=vijayanand.jitta@oss.qualcomm.com; a=ed25519;
 pk=Lpi7Cs3wHe8KZtqvyci7FTOLzsKpEHKGCaPNZw+1zRI=
X-Proofpoint-GUID: WmtNhZzxjoN4_6Al22nkkXLPH3lm9RF4
X-Proofpoint-ORIG-GUID: WmtNhZzxjoN4_6Al22nkkXLPH3lm9RF4
X-Authority-Analysis: v=2.4 cv=LYwMLDfi c=1 sm=1 tr=0 ts=6a1fd43c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=f4O9XJQV64orvU1ydW8A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NiBTYWx0ZWRfXxhDHT38VDsSM
 RDfxaLuoQgOY7AtzVUZcOHVg/z3ua9JN0DNW3Wzbc/gTbqOmcxrOnwiHyIYE8FFIH63t3ANmCV/
 0BOfsemc1nO3Rb1fssl4GIZ779dvuNZKAWxTwRqebJjeDQ7KUXGFmn8YEvpdKCOG5LxVOxLRFJC
 9/c1/NiKisvZoa2j+D+sFrvwnaiGCqlpdFusFLYmo0GK090WDqOrr6vwIRnjb4D59rsW/6enRnX
 ZUPB6PIzLuM8DApgWcksbXDG1PVh0yL07KN89Iq3qfUdPPG9ZNAAPFjLqDaYglIzKlaROJjT11I
 LjdOfLO+60EncuhrFiMrszeGhCzqukMWcMH9bevfgZByT3aidnjkOCptYaZBVQtJyr+8eVVt9ao
 frUsI+DcDGpzN29ZO/9NKsHbjg6OztlR3PguA1/Y6Zeu7iFywG94L6p+ZzUgrz3qd0DhljouItJ
 Tz7nBx8uj1EYwJAhplQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030066

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
 drivers/cdx/cdx_msi.c                    |  5 ++---
 drivers/iommu/of_iommu.c                 |  4 +---
 drivers/irqchip/irq-gic-its-msi-parent.c |  2 +-
 drivers/of/base.c                        | 38 ++++++++++++++++++++++++++++++++
 drivers/of/irq.c                         |  3 +--
 drivers/pci/controller/dwc/pci-imx6.c    |  6 ++---
 drivers/pci/controller/pcie-apple.c      |  3 +--
 drivers/xen/grant-dma-ops.c              |  3 +--
 include/linux/of.h                       | 18 +++++++++++++++
 9 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
index 91b95422b263..78edb7308856 100644
--- a/drivers/cdx/cdx_msi.c
+++ b/drivers/cdx/cdx_msi.c
@@ -128,10 +128,9 @@ static int cdx_msi_prepare(struct irq_domain *msi_domain,
 	int ret;
 
 	/* Retrieve device ID from requestor ID using parent device */
-	ret = of_map_id(parent->of_node, cdx_dev->msi_dev_id, "msi-map", "msi-map-mask",
-			NULL, &dev_id);
+	ret = of_map_msi_id(parent->of_node, cdx_dev->msi_dev_id, NULL, &dev_id);
 	if (ret) {
-		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
+		dev_err(dev, "of_map_msi_id failed for MSI: %d\n", ret);
 		return ret;
 	}
 
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
index a650c91897cc..1e9b9692c0d9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2221,3 +2221,41 @@ int of_map_id(const struct device_node *np, u32 id,
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
index 1034ac5c5f5c..c863c7b02289 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1128,8 +1128,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 	u32 sid = 0;
 
 	target = NULL;
-	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask",
-			  &target, &sid_i);
+	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
 	if (target) {
 		of_node_put(target);
 	} else {
@@ -1142,8 +1141,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
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
index 959786f8f196..721525334b4b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -468,6 +468,12 @@ int of_map_id(const struct device_node *np, u32 id,
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
@@ -948,6 +954,18 @@ static inline int of_map_id(const struct device_node *np, u32 id,
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

