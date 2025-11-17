Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938CA32A3D7
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405325; cv=none; b=tZtd19LmzynXCD+pH/3VpDiKue1bEfSFfQPz9jUNBpfCBViasDt3zXzeuowTJVXwZB0xj4ZQSzde0q5WblSxRgFpqKbe+QxEt9dUtIRZkNR9HUZA1bnIL8ei5ZGrUp0zN9GLL+6ESYup4iIG7fD9GGg9vtkcMsi2xaTYu6Dc3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405325; c=relaxed/simple;
	bh=Tcqv38/05N/B44jMwcSYWvtznjIegtRBbmE71X1CBgw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fmnc57a/B53TIr5TtF14Wg3dZz4JEU4A29iVK8g+8DStbJdmgW4GN/oy81p90Y0dlTzlmRLPO8KeK3m5CUKFK4Sml2p9+xts8jOjVp31x94QscmOxITR1R7T7cTUgO8nL1x2ooCVn7C1Kt1z/hE4kbBnypKLuWkSasDnjdr1gNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a54Y7uCa; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a54Y7uCa"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429cbed2b8fso1878833f8f.1
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 10:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763405319; x=1764010119; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8whZ0pZrNIRwagAm0ORPy5mFVOpkEuU2Ow6ExYwaLg=;
        b=a54Y7uCabUp1rNe7/eiZrae8RVCO0ULqvubVoV/sFwK9PdlnEpjU01ISfmSDwxtcTz
         9dPN5ci4LD4L2on8QI2DfPyhmSKph4t0/iIBrikB2j/KqVhUOhlV4UE732wiVNieLx8L
         EWL/zJ3kYtEqTzNIsnpEVtsFKQxJvjTC4oYne3oYT69Jw38or6JvPDBPo7I3mC0hC7F5
         HcUdAg4g21mFU/0e0U2ix6ZpL4okw+XhZyxX3etl7YXAmeyhcbLI/KdBGmi8WSZA9Iih
         F9CfOjBwErqNbGvsE71VSXinTzID4/rpfJlVtZD5r6LbpvCgBdAfuVL9eC/1lqaselbd
         mjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763405319; x=1764010119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8whZ0pZrNIRwagAm0ORPy5mFVOpkEuU2Ow6ExYwaLg=;
        b=u1gPAcHz34K5lIaGwCEIOWfB4FQB6z2aHD6JBRExqAEDiRQJwn5RJUH9qJmP5t8TtV
         qITQQ83afSdKURB5x1jbCCUs3ZB2y4wi8kpJiDymarEeBb7pTtTV6YaygM/r1LtUW8GE
         JQ2FXQ8dUJ7mLLP6lOiJqZCMRgcOuMQBHzJZOgxrD0fd/B7YDDBJpsPssxMzho3kNXHz
         g37PuUmQf9kzW4h5tzJIUeKn7W8+Ub93Q5NixRGK9BqO0KLmaFwR4BXSJawELe8m6skI
         J8a68s3GKsOyZCq8lkDpFWHkOsrKjz1W2CXeY2hNhKawRzEGbSKbE/fDD6iEWzLKEYKf
         ycYg==
X-Forwarded-Encrypted: i=1; AJvYcCUfWxfklk1pp/0/+cFB48XftAycWZWRtNBV/K7yCOfIhSy5F/Yi/CUMnFBW9tfWzaMFW0zMgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwuZGknRNtgaFgEo8SWFe/wULn4RmCEDx0DCKRipCNh3Qv2obi
	7wgXRFRB4/LjCXvhGI2H+D/b6LmLIPUlGll4k4kjSJ22uSzb9HkBVOo2W1TKuH+j4VUgeAdxFvf
	cVfHdvQKXtQ+JaA==
X-Google-Smtp-Source: AGHT+IGsLY0ihnfe+d9VivrIlxJpw79fEdNZ7d3k+PXAdZb1HiZsb1oiiqepnVn54b8AHulaH6k3LpFgrXdMyA==
X-Received: from wrmf14.prod.google.com ([2002:adf:e90e:0:b0:42b:b28a:6748])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c0c:b0:42b:3806:2bb4 with SMTP id ffacd0b85a97d-42b59342e50mr13284074f8f.27.1763405319568;
 Mon, 17 Nov 2025 10:48:39 -0800 (PST)
Date: Mon, 17 Nov 2025 18:48:01 +0000
In-Reply-To: <20251117184815.1027271-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251117184815.1027271-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117184815.1027271-15-smostafa@google.com>
Subject: [PATCH v5 14/27] iommu/arm-smmu-v3: Support probing KVM emulated devices
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org, jgg@ziepe.ca, 
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com, 
	qperret@google.com, tabba@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

When KVM runs in protected mode, and CONFIG_ARM_SMMU_V3_PKVM
is enabled, it will manage the SMMUv3 HW using trap and emulate
and present emulated SMMUs to the host kernel.

In that case, those SMMUs will be on the aux bus, so make it
possibly to the driver to probe those devices.
Otherwise, everything else is the same as the KVM emulation
complies with the architecutre, so the driver doesn't need
to be modified.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 58 +++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7b1bd0658910..851d47bedae6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -11,6 +11,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/bitops.h>
 #include <linux/crash_dump.h>
 #include <linux/delay.h>
@@ -4604,6 +4605,63 @@ static struct platform_driver arm_smmu_driver = {
 module_driver(arm_smmu_driver, platform_driver_register,
 	      arm_smmu_driver_unregister);
 
+#ifdef CONFIG_ARM_SMMU_V3_PKVM
+/*
+ * Now we have 2 devices, the aux device bound to this driver, and pdev
+ * which is the physical platform device.
+ * This part is a bit hairy but it works due to the fact that
+ * CONFIG_ARM_SMMU_V3_PKVM forces both drivers to be built in.
+ * The struct device for the SMMU is used in the following cases:
+ * 1) Printing using dev_*()
+ * 2) DMA memory alloc (dmam_alloc_coherent, devm_*)
+ * 3) Requesting resources (iomem, sysfs)
+ * 4) Probing firmware info (of_node, fwnode...)
+ * 5) Dealing with abstracted HW resources (irqs, MSIs, RPM)
+ * 6) Saving/reading driver data
+ * For point 4) and 5) we must use the platform device.
+ * For, 1) pdev is better for debuggability.
+ * For 2), 3), 6) it's better to use the bound device.
+ * However that doesn't really work:
+ * For 2) The DMA allocation using the aux device will fail, as
+ * we need to setup some device DMA attrs (mask), to match the
+ * platform.
+ * For 6) Some contexts from the pdev as MSI, it needs to use the
+ * drvdata.
+ * Based on the following:
+ * 1- Both drivers must be built-in to enable this (enforced by Kconfig),
+ *    which means that none of them can be removed.
+ * 2- The KVM driver doesn't do anythng at runtime and doesn't use drvdata.
+ * We can keep the driver simple and to claim the platform device in all cases.
+ */
+static int arm_smmu_device_probe_emu(struct auxiliary_device *auxdev,
+				     const struct auxiliary_device_id *id)
+{
+	struct device *parent = auxdev->dev.parent;
+
+	dev_info(&auxdev->dev, "Probing from %s\n", dev_name(parent));
+	return arm_smmu_device_probe(to_platform_device(parent));
+}
+
+static void arm_smmu_device_shutdown_emu(struct auxiliary_device *auxdev)
+{
+	arm_smmu_device_shutdown(to_platform_device(auxdev->dev.parent));
+}
+
+const struct auxiliary_device_id arm_smmu_aux_table[] = {
+	{ .name = "protected_kvm.smmu_v3_emu" },
+	{ },
+};
+
+struct auxiliary_driver arm_smmu_driver_emu = {
+	.name = "arm-smmu-v3-emu",
+	.id_table = arm_smmu_aux_table,
+	.probe = arm_smmu_device_probe_emu,
+	.shutdown = arm_smmu_device_shutdown_emu,
+};
+
+module_auxiliary_driver(arm_smmu_driver_emu);
+#endif
+
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will@kernel.org>");
 MODULE_ALIAS("platform:arm-smmu-v3");
-- 
2.52.0.rc1.455.g30608eb744-goog

