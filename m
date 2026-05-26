Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1802400E04;
	Tue, 26 May 2026 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807224; cv=none; b=JE/rcLwgMIgTb+yzzkcNY9dwSkV2us/VApOTde8BFF9QWmiicJ6rHF3YnhN1DStjv0eUtmpIoOstMccmEtHWhe5c6EXpF/9JSox5ygRJkPgjNeo946KRpDti1toQ6VvaDmKZ23jxkcG99tOT900mb4WIIdnV6aCIOeAu/dT4tRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807224; c=relaxed/simple;
	bh=mrdlOoKNFYSoZV05qStZtthKTUH+7JSmhh200dUELcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MBndJVX91G6TUg6PzxhNOHf+ca9K4MFRv4y3mS31r5iFtsIOkz0ozeQXZ8AdF2GCGM/BGQIkAfjuGIsR+zAcwoiUmXa7Lbb12tmC1wom2zjJAMK1ZmEw+zRQgNcCs6BQaSU4ZR1QyN8B/acvDCIb1asKwnXjc167Gz6w6WWfqu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VDJqhJKH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VDJqhJKH"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QDFiMb2437640;
	Tue, 26 May 2026 14:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=DtEI7WfC5+U62ltVi9RfCYz6d6BvUdBEhCw
	V0F2LcJ0=; b=VDJqhJKHNju8IKcn9t1qu43G/VBPuu9ARS2y2EHvztuTyMiyhFf
	rgfRLg3okTLGVE+M5WkAJO/YtpNKW3OSPPoBWDKXkfKpB8qm669C+M4QwHET92wt
	1twqVleeMF5w82rDDpTDX1fH2WvkAifaCtMhcAV4ZopkCPHBboXxR5oNoixkJdBX
	ZnHAgBFrJy85LCwpOCfPfg+2HxGCovmUyCfnadbgqUUsPdhxMVmWawVtAWO7rzWK
	g+PcqmqN/7R+p6P37XDhEgGVJKrKCp3drYp2/0qZ1CB/hXSz/zo6yD8f3g+FJiD8
	FWEhWjco2Me5GT3f9prBfmnZnd+qI+QVE8Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecnhs5ay0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 14:52:51 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QEqlWb017831;
	Tue, 26 May 2026 14:52:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4eb5aj97q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 14:52:47 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64QEqlkU017823;
	Tue, 26 May 2026 14:52:47 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 64QEql8L017820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 14:52:47 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 6A81F21A82; Tue, 26 May 2026 20:22:46 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Tomasz Jeznach <tomasz.jeznach@linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Saket Dumbre <saket.dumbre@intel.com>, Rahul Pathak <rahul@summations.net>,
        Atish Patra <atish.patra@linux.dev>, Anup Patel <anup@brainfault.org>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        driver-core@lists.linux.dev, iommu@lists.linux.dev,
        acpica-devel@lists.linux.dev, Anup Patel <anup.patel@oss.qualcomm.com>,
        Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [PATCH] driver core: platform: Setup device MSI domain just before driver probe
Date: Tue, 26 May 2026 20:22:40 +0530
Message-ID: <20260526145240.1627200-1-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=Vd3H+lp9 c=1 sm=1 tr=0 ts=6a15b3c3 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=XO0VMO9KiYcrIKbrk7YA:9
X-Proofpoint-GUID: lty04NSPDty1OQPPj3lse-ZDKCwr8rqX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNyBTYWx0ZWRfXybDV0cdVrn9a
 cW4JY0oYmLmSW9VtMnddMU+ogYKG7BxrIRKYvaGEdEC24+aqrpRRl4JBanv5SINeJSvLH8ll+5D
 yKrHOhKDhbIOnFw3o5jQLT6FqfoQDT/gWpPZV53pZu5IETVaw1dWVvSmPakzpBiVuYC6CuymSA6
 j0ZBjZuldEWEOyzxl7/Nlpje0izBxmun/cuDxVlI0kNkWfyO9uWU+o/yFxEuWijsDqn/o+ChRp6
 NwbALiSEe1r+goStmolCJFb3ib/JdXldKU2Uffx1j4/uyK4/UC5zq3dHlcUAMobJXwkawa/a5DF
 LL7PcUxQLWK2DWPChqb657ugZiqoxeldJBznayQzhdLvgITOr6/YcYOzyxkEPs7UphfEuHSV5G1
 l5aduVCwtbflDAT0VstEzFFmDbql4XqsoZ2nIuzq4f89BpdqazopkvOwqHYYU9xgpAqeNzfbk8p
 61D9FGO5KBYoXt5pYPQ==
X-Proofpoint-ORIG-GUID: lty04NSPDty1OQPPj3lse-ZDKCwr8rqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260127

On RISC-V, the MSI controller (aka RISC-V IMSIC) is probed as a regular
platform device and MSI client drivers are always probed after the MSI
controller driver using fw_devlink. Unfortunately, this is not sufficient
to ensure device MSI domain is set for MSI client devices before driver
probe because OF framework sets device MSI domain at the time of platform
device creation whereas ACPI framework expects arch specific code to set
the device MSI domain at the time of platform device creation.

Currently, to work-around the problem of missing device MSI domain,
various RISC-V MSI client drivers explicitly set device MSI domain
in the driver probe function using below code pattern:

	/*
	 * The device MSI domain for platform devices on RISC-V architecture
	 * is only available after the MSI controller driver is probed so,
	 * explicitly configure here.
	 */
	if (!dev_get_msi_domain(dev)) {
		/*
		 * The device MSI domain for OF devices is only set at the
		 * time of populating/creating OF device. If the device MSI
		 * domain is discovered later after the OF device is created
		 * then we need to set it explicitly before using any platform
		 * MSI functions.
		 */
		if (is_of_node(fwnode)) {
			of_msi_configure(dev, dev_of_node(dev));
		} else if (is_acpi_device_node(fwnode)) {
			struct irq_domain *msi_domain;
			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
							      DOMAIN_BUS_PLATFORM_MSI);
			dev_set_msi_domain(dev, msi_domain);
		}

		if (!dev_get_msi_domain(dev))
			return -EPROBE_DEFER;
	}

Instead of the above approach, extend the platform_dma_configure() to set
device MSI domain for both OF and ACPI based platform devices before driver
probe and remove the duplicate code pattern from RISC-V MSI client drivers.

Co-developed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 drivers/acpi/riscv/irq.c                | 13 +++++++++++
 drivers/acpi/scan.c                     | 10 +++++++++
 drivers/base/platform.c                 |  4 ++++
 drivers/iommu/riscv/iommu-platform.c    |  9 --------
 drivers/irqchip/irq-riscv-aplic-msi.c   | 27 -----------------------
 drivers/irqchip/irq-riscv-rpmi-sysmsi.c | 29 -------------------------
 drivers/mailbox/riscv-sbi-mpxy-mbox.c   | 29 -------------------------
 include/acpi/acpi_bus.h                 |  1 +
 include/linux/acpi.h                    | 10 +++++++++
 9 files changed, 38 insertions(+), 94 deletions(-)

diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index 9b88d0993e88..17fa5dcdd2c0 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -5,8 +5,11 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/device.h>
 #include <linux/sort.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/riscv-imsic.h>
 
 #include "init.h"
 
@@ -397,6 +400,16 @@ static u32 riscv_acpi_add_irq_dep(acpi_handle handle)
 	return count;
 }
 
+void acpi_arch_msi_configure(struct device *dev)
+{
+	struct irq_domain *msi_domain;
+
+	msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
+					      DOMAIN_BUS_PLATFORM_MSI);
+	if (msi_domain)
+		dev_set_msi_domain(dev, msi_domain);
+}
+
 u32 arch_acpi_add_auto_dep(acpi_handle handle)
 {
 	if (acpi_has_method(handle, "_PRT"))
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 530547cda8b2..e50e5d246a54 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1648,6 +1648,16 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 
 #endif /* !CONFIG_IOMMU_API */
 
+/**
+ * acpi_msi_configure - Set-up MSI domain for the device.
+ * @dev: The pointer to the device
+ */
+void acpi_msi_configure(struct device *dev)
+{
+	acpi_arch_msi_configure(dev);
+}
+EXPORT_SYMBOL_GPL(acpi_msi_configure);
+
 /**
  * acpi_dma_configure_id - Set-up DMA configuration for the device.
  * @dev: The pointer to the device
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index a19dd22deef2..225e33080bc6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1470,8 +1470,12 @@ static int platform_dma_configure(struct device *dev)
 	int ret = 0;
 
 	if (is_of_node(fwnode)) {
+		if (!dev_get_msi_domain(dev))
+			of_msi_configure(dev, dev->of_node);
 		ret = of_dma_configure(dev, to_of_node(fwnode), true);
 	} else if (is_acpi_device_node(fwnode)) {
+		if (!dev_get_msi_domain(dev))
+			acpi_msi_configure(dev);
 		attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
 		ret = acpi_dma_configure(dev, attr);
 	}
diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index 399ba8fe1b3e..ddc6370b96b0 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -48,7 +48,6 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	enum riscv_iommu_igs_settings igs;
 	struct device *dev = &pdev->dev;
 	struct riscv_iommu_device *iommu = NULL;
-	struct irq_domain *msi_domain;
 	struct resource *res = NULL;
 	int vec, ret;
 
@@ -74,14 +73,6 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	switch (igs) {
 	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
 	case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
-		if (is_of_node(dev_fwnode(dev))) {
-			of_msi_configure(dev, to_of_node(dev->fwnode));
-		} else {
-			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
-							      DOMAIN_BUS_PLATFORM_MSI);
-			dev_set_msi_domain(dev, msi_domain);
-		}
-
 		if (!dev_get_msi_domain(dev)) {
 			dev_warn(dev, "failed to find an MSI domain\n");
 			goto msi_fail;
diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index fb8d1838609f..2cf5d42cd66a 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -175,7 +175,6 @@ static const struct msi_domain_template aplic_msi_template = {
 int aplic_msi_setup(struct device *dev, void __iomem *regs)
 {
 	const struct imsic_global_config *imsic_global;
-	struct irq_domain *msi_domain;
 	struct aplic_priv *priv;
 	struct aplic_msicfg *mc;
 	phys_addr_t pa;
@@ -245,32 +244,6 @@ int aplic_msi_setup(struct device *dev, void __iomem *regs)
 	/* Setup global config and interrupt delivery */
 	aplic_init_hw_global(priv, true);
 
-	/* Set the APLIC device MSI domain if not available */
-	if (!dev_get_msi_domain(dev)) {
-		/*
-		 * The device MSI domain for OF devices is only set at the
-		 * time of populating/creating OF device. If the device MSI
-		 * domain is discovered later after the OF device is created
-		 * then we need to set it explicitly before using any platform
-		 * MSI functions.
-		 *
-		 * In case of APLIC device, the parent MSI domain is always
-		 * IMSIC and the IMSIC MSI domains are created later through
-		 * the platform driver probing so we set it explicitly here.
-		 */
-		if (is_of_node(dev->fwnode)) {
-			of_msi_configure(dev, to_of_node(dev->fwnode));
-		} else {
-			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
-							      DOMAIN_BUS_PLATFORM_MSI);
-			if (msi_domain)
-				dev_set_msi_domain(dev, msi_domain);
-		}
-
-		if (!dev_get_msi_domain(dev))
-			return -EPROBE_DEFER;
-	}
-
 	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, &aplic_msi_template,
 					  priv->nr_irqs + 1, priv, priv)) {
 		dev_err(dev, "failed to create MSI irq domain\n");
diff --git a/drivers/irqchip/irq-riscv-rpmi-sysmsi.c b/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
index 612f3972f7af..e6cdb4b635a6 100644
--- a/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
+++ b/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
@@ -260,35 +260,6 @@ static int rpmi_sysmsi_probe(struct platform_device *pdev)
 			riscv_acpi_update_gsi_range(priv->gsi_base, priv->nr_irqs);
 	}
 
-	/*
-	 * The device MSI domain for platform devices on RISC-V architecture
-	 * is only available after the MSI controller driver is probed so,
-	 * explicitly configure here.
-	 */
-	if (!dev_get_msi_domain(dev)) {
-		/*
-		 * The device MSI domain for OF devices is only set at the
-		 * time of populating/creating OF device. If the device MSI
-		 * domain is discovered later after the OF device is created
-		 * then we need to set it explicitly before using any platform
-		 * MSI functions.
-		 */
-		if (is_of_node(fwnode)) {
-			of_msi_configure(dev, dev_of_node(dev));
-		} else if (is_acpi_device_node(fwnode)) {
-			struct irq_domain *msi_domain;
-
-			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
-							      DOMAIN_BUS_PLATFORM_MSI);
-			dev_set_msi_domain(dev, msi_domain);
-		}
-
-		if (!dev_get_msi_domain(dev)) {
-			mbox_free_channel(priv->chan);
-			return -EPROBE_DEFER;
-		}
-	}
-
 	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
 					  &rpmi_sysmsi_template,
 					  priv->nr_irqs, priv, priv)) {
diff --git a/drivers/mailbox/riscv-sbi-mpxy-mbox.c b/drivers/mailbox/riscv-sbi-mpxy-mbox.c
index 7c9c006b7244..759512aba19f 100644
--- a/drivers/mailbox/riscv-sbi-mpxy-mbox.c
+++ b/drivers/mailbox/riscv-sbi-mpxy-mbox.c
@@ -902,35 +902,6 @@ static int mpxy_mbox_probe(struct platform_device *pdev)
 
 	/* Setup MSIs for mailbox (if required) */
 	if (mbox->msi_count) {
-		/*
-		 * The device MSI domain for platform devices on RISC-V architecture
-		 * is only available after the MSI controller driver is probed so,
-		 * explicitly configure here.
-		 */
-		if (!dev_get_msi_domain(dev)) {
-			struct fwnode_handle *fwnode = dev_fwnode(dev);
-
-			/*
-			 * The device MSI domain for OF devices is only set at the
-			 * time of populating/creating OF device. If the device MSI
-			 * domain is discovered later after the OF device is created
-			 * then we need to set it explicitly before using any platform
-			 * MSI functions.
-			 */
-			if (is_of_node(fwnode)) {
-				of_msi_configure(dev, dev_of_node(dev));
-			} else if (is_acpi_device_node(fwnode)) {
-				struct irq_domain *msi_domain;
-
-				msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
-								      DOMAIN_BUS_PLATFORM_MSI);
-				dev_set_msi_domain(dev, msi_domain);
-			}
-
-			if (!dev_get_msi_domain(dev))
-				return -EPROBE_DEFER;
-		}
-
 		mbox->msi_index_to_channel = devm_kcalloc(dev, mbox->msi_count,
 							  sizeof(*mbox->msi_index_to_channel),
 							  GFP_KERNEL);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c41d9a7565cf..b31ba661245e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -744,6 +744,7 @@ bool acpi_dma_supported(const struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
 int acpi_iommu_fwspec_init(struct device *dev, u32 id,
 			   struct fwnode_handle *fwnode);
+void acpi_msi_configure(struct device *dev);
 int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
 int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 			   const u32 *input_id);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 67effb91fa98..e8829be3ca55 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -260,6 +260,12 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa) { }
 
 void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
 
+#if defined(CONFIG_RISCV)
+void acpi_arch_msi_configure(struct device *dev);
+#else
+static inline void acpi_arch_msi_configure(struct device *dev) { }
+#endif
+
 #if defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
 void acpi_arch_dma_setup(struct device *dev);
 #else
@@ -1058,6 +1064,10 @@ static inline int acpi_dma_get_range(struct device *dev, const struct bus_dma_re
 	return -ENODEV;
 }
 
+static inline void acpi_msi_configure(struct device *dev)
+{
+}
+
 static inline int acpi_dma_configure(struct device *dev,
 				     enum dev_dma_attr attr)
 {
-- 
2.43.0

