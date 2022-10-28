Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7739612287
	for <iommu@lists.linux.dev>; Fri, 28 Oct 2022 19:12:53 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id a5so9196977edb.11
        for <iommu@lists.linux.dev>; Fri, 28 Oct 2022 12:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ce4G8W5n1Lw9GJ2OPzfRvhL8Ar7JfIK4yfZO67gLs8o=;
        b=USP77o4Kj2PXkea5iju4USuaykmQfPyYjmvznDQakbS8TtPG6SAAgBqdEnSwNoevF2
         9/MX/qCCFNYzLoU8S55oAFU4v3FXisMLnhwxhZE34gQSNi7Nh5ffwJNiNHW+ZGnIwjdt
         5aVCxJdIEFHlacrIJJ0tIfaoOAbetXlbZmi9sRAWGTjVXLt7Az796qbPtToLaUDVkK0O
         uRUMhOePJ0xuK4nt1CshdgJXZHiYpRUWgiAI1FtQw+k/U4IGZD92SPs+gtu30naDO3hJ
         vk/pVENy7WDuEPyvq5+PPbKqwzI+wI0tCiZ76IYjhi46RsCLGdKsqCyoOTDVEdSPN7Sa
         HeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ce4G8W5n1Lw9GJ2OPzfRvhL8Ar7JfIK4yfZO67gLs8o=;
        b=zNfAK05k2mAakgfve12DPycCCRB52yySIIU1hBxOKCxudMPu+manfNpstQFox3cy75
         80thhYWnf33wKcpmdCxK0lsZ5EIBNWEk6oBSXBASrfkkm+oAuUkRkL7hrO8Z1SV9fNIn
         Ag3U6nN68OAdRZCcZJI32mCe5kPW8/0XOQC0Rk5yigOhSXy4AndbQfllQV41XTHyWcLE
         Bvmny2+wzWY0x3fSUV0d9dNb6gXQTOblOM8GE6UB9v0LKy2WJuxrD+ezLWC+KYTWAO8l
         POCGxveNKo1IOdiZ+9wk4R9fTmLZZhS4oqTv89fIJIiQOtAuhXy1AKCFY9PHuVwVYwM+
         Mbbw==
X-Gm-Message-State: ACrzQf0OUx855yNVyWY9L0fBKp+v3Jd72ZSJX2Gex4F8uYx9Nr7NMBem
	plI5BR85oXsIoAvaWJCdOSIJGA==
X-Google-Smtp-Source: AMsMyM6fQx72vUp95PoUjSyByIOuAe4YYAUh6ucP84vWfDBeUQfZYGHasjqdWI7uR1/gJ5ciL2E5Cw==
X-Received: by 2002:a05:6402:448c:b0:457:52eb:b57e with SMTP id er12-20020a056402448c00b0045752ebb57emr948141edb.178.1666984371738;
        Fri, 28 Oct 2022 12:12:51 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id fx1-20020a170906b74100b007a7f9b6318asm2569764ejb.50.2022.10.28.12.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:12:51 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Janghyuck Kim <janghyuck.kim@samsung.com>,
	Cho KyongHo <pullip.cho@samsung.com>,
	Daniel Mentz <danielmentz@google.com>,
	David Virag <virag.david003@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 3/4] iommu/exynos: Modularize the driver
Date: Fri, 28 Oct 2022 21:12:42 +0200
Message-Id: <20221028191243.31721-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221028191243.31721-1-semen.protsenko@linaro.org>
References: <20221028191243.31721-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework the driver so it can be built as a loadable module. That can be
useful as not all ARM64 platforms need it. And that's ok for it to be a
module because it's not a critical driver (platform can work when it's
disabled).

Also add the shutdown driver method, while at it. That was inspired by
other IOMMU drivers, and can be useful e.g. for performing a kexec. See
commit 1a4e90f25b2c ("iommu/rockchip: Perform a reset on shutdown") for
example.

Remove method and module exit function are not implemented, as the
removal of IOMMUs cannot be done reliably. As Robin Murphy mentioned in
[1]:

    ...it's better not to even pretend that removing an IOMMU's driver
    while other drivers are using it (usually via DMA ops without even
    realising) is going to have anything other than catastrophic
    results.

[1] https://lore.kernel.org/lkml/20220702213724.3949-2-semen.protsenko@linaro.org/T/#md7e1e3f5b2c9e7fa5bc28fe33e818b6aa4a7237c

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/Kconfig        |  2 +-
 drivers/iommu/exynos-iommu.c | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dc5f7a156ff5..6f7055606679 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -259,7 +259,7 @@ config TEGRA_IOMMU_SMMU
 	  SoCs (Tegra30 up to Tegra210).
 
 config EXYNOS_IOMMU
-	bool "Exynos IOMMU Support"
+	tristate "Exynos IOMMU Support"
 	depends on ARCH_EXYNOS || COMPILE_TEST
 	depends on !CPU_BIG_ENDIAN # revisit driver if we can enable big-endian ptes
 	select IOMMU_API
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 0d150b383d04..57492db877e2 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/kmemleak.h>
 #include <linux/list.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -752,6 +753,16 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void exynos_sysmmu_shutdown(struct platform_device *pdev)
+{
+	struct sysmmu_drvdata *data = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	int irq = platform_get_irq(pdev, 0);
+
+	devm_free_irq(dev, irq, data);
+	pm_runtime_force_suspend(dev);
+}
+
 static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
 {
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
@@ -799,8 +810,9 @@ static const struct of_device_id sysmmu_of_match[] = {
 	{ },
 };
 
-static struct platform_driver exynos_sysmmu_driver __refdata = {
+static struct platform_driver exynos_sysmmu_driver = {
 	.probe	= exynos_sysmmu_probe,
+	.shutdown = exynos_sysmmu_shutdown,
 	.driver	= {
 		.name		= "exynos-sysmmu",
 		.of_match_table	= sysmmu_of_match,
@@ -1404,6 +1416,7 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.release_device = exynos_iommu_release_device,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
 	.of_xlate = exynos_iommu_of_xlate,
+	.owner = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= exynos_iommu_attach_device,
 		.detach_dev	= exynos_iommu_detach_device,
@@ -1454,3 +1467,6 @@ static int __init exynos_iommu_init(void)
 	return ret;
 }
 core_initcall(exynos_iommu_init);
+
+MODULE_DESCRIPTION("IOMMU driver for Exynos SoCs");
+MODULE_LICENSE("GPL");
-- 
2.35.1

