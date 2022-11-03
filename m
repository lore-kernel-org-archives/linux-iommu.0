Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F129A8
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 19:52:02 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id v27so4717942eda.1
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 12:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXCO9a7x2xoJr3hX2LIdzuSb2rVW3qJQzBsWlbB8ZK0=;
        b=nQGsSI60wh19jmS5rh2BuaBTcb5URMCprPZR1Qt20h8IGzb8IM4pplEyq6DQ3Q+n0C
         h5qaEV3zI/t4vLs0Je8PEyDomt+aBsAELhfOyIdRwQBWKObdhTH3xshRT9xXWpIwrTjW
         l5TryGbITzNYIzK155TRxE63/dj/a/V9XNmyzurtcNFQs5g6emh1Mp2+GdixLYxcuJNU
         hrOdEkVQM6OG83HiAUYRvmpIgGmU8Msf9q5a6Kti8Fnah1eeJ5JWaQgmgO+n2dgM1PIP
         Uq2NJ6bEBBQFVVXElJ10vvwkVK4BE96g5CeDj+Ro58KWu7BsrOA/CqM/hHL9mbNNkYTP
         cJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXCO9a7x2xoJr3hX2LIdzuSb2rVW3qJQzBsWlbB8ZK0=;
        b=d9GFPJqqswQElj+MXzybETizhdzgvS5f4MPS5v+YbTZWGuyXnZ68vmatlMRiAkhuf2
         OaAfQZ5D7Ir8UYMHWnSdMfLeZBRESgnHBl6BYBax+g56BqM+YEk3Jw1qnVlAkzyfe05x
         ShN8pBeZc0FBesFrfKzCwM9DYxX9g4yNvoePhIbtwbhtfRPOFsOlm0IxqdNiwYotixiN
         PGblU5ahJs8vTqWtHAJVD6soXzevwIUqT5pMNVz8ie1ZfSZQYbLHaYV2e1AIfzLv70NG
         AdosBOOLz7kU/eq0uZOVgB2gWk6Rc6qxC+oPzW7jnTeh0fuo2Y+Nz83+qiue612MXozS
         /m3w==
X-Gm-Message-State: ACrzQf2sAa8DLtBg4nYkM30xCi88KGzMrmiFWTCPUKloWVRHY0MYvPWi
	+F+Lb3UdW5Fk9U/45IKigHcDqQ==
X-Google-Smtp-Source: AMsMyM6GuGLXLDhRmMnsQt0YiPv3zTLETFhVFIZP2Bap/XDV65f5mB5C1KHbKH7MNTJRJt+lwpbmlA==
X-Received: by 2002:a05:6402:440f:b0:45d:297b:c70a with SMTP id y15-20020a056402440f00b0045d297bc70amr31990965eda.187.1667505121017;
        Thu, 03 Nov 2022 12:52:01 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b007ad98918743sm880137ejo.1.2022.11.03.12.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:52:00 -0700 (PDT)
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
Subject: [PATCH v2 3/6] iommu/exynos: Modularize the driver
Date: Thu,  3 Nov 2022 20:51:51 +0100
Message-Id: <20221103195154.21495-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221103195154.21495-1-semen.protsenko@linaro.org>
References: <20221103195154.21495-1-semen.protsenko@linaro.org>
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
Changes in v2:
  - Add MODULE_DEVICE_TABLE(of, ...) to support hot-plug loading
  - Add MODULE_ALIAS() line
  - Extracted "shutdown" driver method adding into a separate patch

 drivers/iommu/Kconfig        | 2 +-
 drivers/iommu/exynos-iommu.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

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
index 0d150b383d04..aad845677bda 100644
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
@@ -798,8 +799,9 @@ static const struct of_device_id sysmmu_of_match[] = {
 	{ .compatible	= "samsung,exynos-sysmmu", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, sysmmu_of_match);
 
-static struct platform_driver exynos_sysmmu_driver __refdata = {
+static struct platform_driver exynos_sysmmu_driver = {
 	.probe	= exynos_sysmmu_probe,
 	.driver	= {
 		.name		= "exynos-sysmmu",
@@ -1404,6 +1406,7 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.release_device = exynos_iommu_release_device,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
 	.of_xlate = exynos_iommu_of_xlate,
+	.owner = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= exynos_iommu_attach_device,
 		.detach_dev	= exynos_iommu_detach_device,
@@ -1454,3 +1457,7 @@ static int __init exynos_iommu_init(void)
 	return ret;
 }
 core_initcall(exynos_iommu_init);
+
+MODULE_DESCRIPTION("IOMMU driver for Exynos SoCs");
+MODULE_ALIAS("platform:exynos-sysmmu");
+MODULE_LICENSE("GPL");
-- 
2.35.1

