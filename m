Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410F033AD8C;
	Mon, 27 Jul 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141630; cv=none; b=Ixo4pS2ODSCL6ZQtBy1KZq0eVWcul2d9SXN8IHeT/sYq1DhDTR04wBQc/Wlxwa3OR31J4tq/oGhqTfuv0J0eaaYyNEeqjk/W0VG+oLBLKvYWfohMalfGtF+tVMVcninFb3xVKAe1wSjLXthlLesN3RzLd4sUITctgWyhRj3OcpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141630; c=relaxed/simple;
	bh=e3pXrklnpSkdALlTzewLJvaK5W5IV+jdWX2xwQTKxcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mpsVU5Ju4xr72+YHdupIGVcFGw+KDx1vixpmcnPkY8+k0uOTLULUxD+8nix6vJsM+MYpBnAQ9KJFDXIMLCq72dgsI362HNQnAu4Q4MiplM958ZsOGh6Br5BT4FfnAJIcRxV8qvlyFBwojNSAQq6bcWKV7cmpR6otvgVK0Lck2rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jBtJLYVm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jBtJLYVm"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R7Rx3v3231861;
	Mon, 27 Jul 2026 08:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=BCz3enYp6zRAqUAUH0SuByolAoHm9aMlfJs
	V8H/Hb/o=; b=jBtJLYVmwMqeAc5dHxxC27gppk/kl2Uahkb77yqmSZIu8ntS/oR
	XxmTZ4P0qjzgpA7Oro7Mg8nQOMEiH6+jwZwWETukTVdWnKRtGGtmvlNkSEOdPbCu
	vLQWLWvf402rmQOn+K2g0gPelLTxO0JejKtFLCisRyMBBZs+Q820Dmz516uvrw2V
	5jHrpSI53PVbJQF79vvQ/+s3CMceyeIt+bdK/Oh5wYzoI8LuyVznurOysp7w+EmW
	adhZ04LvzNvA4I5GdQbQifEpmvGyJVYysu4ascN1fkOjT2w7iGL6qDdh1yFiSjej
	Glm/JhbFSs9sWMGPjAVAdSCDza/pnflBnyg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm575jxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 08:40:09 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R8e5na011473;
	Mon, 27 Jul 2026 08:40:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4fmp7j9yut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 08:40:04 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66R8d6AL009446;
	Mon, 27 Jul 2026 08:40:04 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 66R8e4Ba011446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 08:40:04 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 34A492295E; Mon, 27 Jul 2026 14:10:04 +0530 (+0530)
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
Subject: [PATCH v2] driver core: platform: Setup device MSI domain just before driver probe
Date: Mon, 27 Jul 2026 14:10:03 +0530
Message-ID: <20260727084003.1951324-1-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA4NSBTYWx0ZWRfX+wEenmhQ0um2
 M6Yf0KFkd/EgTZLZatlFrGaufJG+1G0RhcXSXR4j0Y+MrvpSAzf19vjlD1to3x/4qj36kGMlXaW
 sDU2fzZFBFKgDTiXsJlsK3z1686rSwk=
X-Proofpoint-GUID: 9e1UbbMZSVLk2bIHGJs2hlf1ZWAtflMO
X-Authority-Analysis: v=2.4 cv=FOErAeos c=1 sm=1 tr=0 ts=6a67196a cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=XO0VMO9KiYcrIKbrk7YA:9
X-Proofpoint-ORIG-GUID: 9e1UbbMZSVLk2bIHGJs2hlf1ZWAtflMO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA4NSBTYWx0ZWRfX1OcuxOEuCXbf
 rR9RWra1K4o8KjMFsbAJFIkLkJT4GkJdOtOXQfDMhUeWPRTMv+9MwWmf5lMo4+dNGOBjXWYdqC+
 T675DISXn2S/iy5Y6iq0dyWGP4jex0mWRMbjCHJC6soKp/yyyRIgAtGwVZovMmul2SOQbBv7Scj
 DjFMaP4r4VCi5htqoNYeFaa2hCq5h6N4UQI+LZn+XOJi1taaTUXQYBqVtB8imaZsGHgopvjDSGv
 VuEUTzOnLpjuQ8elLcmPVSQiTFdkkcUqjSGyyEazjQR4J+3axeduaWEgHPW3+Vm2ioCoeES/XJd
 erBLy1mzKJeIR5jEoYD5A25sVkDqV7BeN2nCJmAEaU+XVVfOq5cdZ955zkHlkuVW4jRjbdX88u3
 P87h4saUjXXrln3sb5NtKLtV8raPjJxqshJBt3j+pCl89B9HMWg0ANlP38oZI7F5/nnC4Ita7Q/
 svg5LyrTTRBRm5uuyrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270085

On RISC-V, the MSI controller (aka RISC-V IMSIC) is probed as a regular
platform device and MSI client drivers are always probed after the MSI
controller driver using fw_devlink. Unfortunately, this is not sufficient
to ensure device MSI domain is set for MSI client devices before driver
probe because OF framework sets device MSI domain at the time of platform
device creation whereas ACPI framework expects arch specific code to set
the device MSI domain at the time of platform device creation.

Currently, to address the problem of device MSI domain being not set
correctly, various RISC-V MSI client drivers explicitly set device
MSI domain in the driver probe function using below code pattern:

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
Changes since v1:
 - Rebased on Linux-7.2-rc5
 - Minor improvement to commit description
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
index 9a7ac2eb9ce0..75c52f6bbbe8 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1650,6 +1650,16 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 
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
index fb9120b0bcfe..965ed6ae5bb5 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1477,8 +1477,12 @@ static int platform_dma_configure(struct device *dev)
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
index 714d111d8053..d971d6bc14d7 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -750,6 +750,7 @@ bool acpi_dma_supported(const struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
 int acpi_iommu_fwspec_init(struct device *dev, u32 id,
 			   struct fwnode_handle *fwnode);
+void acpi_msi_configure(struct device *dev);
 int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
 int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 			   const u32 *input_id);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 60ab50cb8930..5e2e377c48b4 100644
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
@@ -1060,6 +1066,10 @@ static inline int acpi_dma_get_range(struct device *dev, const struct bus_dma_re
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

