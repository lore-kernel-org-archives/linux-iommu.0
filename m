Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5EE63D3
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 19:52:04 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id r14so4683094edc.7
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 12:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GteW77xtmVFSxJeOH5lkPz2xCnVHhXZ4689sF4PXr4=;
        b=XS+nYmWGxVzp8b3+Ikv2y44FFDaFheYgYIbiPVlgn49mfTqtgEsOyaHPJ3r/p5B3tt
         Nt5dBpQKml2iwalKxnRphnFIG/LSj40LX/DzeEwbsW5Dg19uBCqt/dPpJ2mM/QlxNP0t
         ViMsoPF0uR0Y3DKOyO063X/SvB/Y+eaqBrfHolnwX/6pjNtDDh3k1wIWEqvSHb7fE5B7
         BIhEjckfBLuXmH/TBcTQHGLPIYq+oavrnSOxXg6z7utaTTQs+wYLNmcNTZ/7g3YeuT0q
         LHdaXBVv5HYmGiczZ9CUEcLy03QRnuty4MISIWcoLtHL7iaGIIQ20TYEJGlpEADAFiA4
         Gw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GteW77xtmVFSxJeOH5lkPz2xCnVHhXZ4689sF4PXr4=;
        b=UidHximMz+bVJnJFlzp1uTeCb3P9lj0w6W3DXr+T8fC+AEVMdQHBSv2VKs3yIqapXA
         4/Xg9ZtOHo9CERq2ozX4n1r1AabXScBi7/GYHJFTfPuc1kVah/nddbce9g2YLMpXRXM4
         w/HCoqUD7ioMp24dNZXR1YV/3gWER6os/sqQ0UPN6l+RTPDMKgZeePjsSptzjE81G834
         j0g1+Ak6wXHf9sxzynMt/TX61iYQ3qRckFeXkPWOpx6Gadz0JoPDfv8Q5SgL2DAUJUO3
         a9Elfrz1b7hI0PDZOPX/XlvleZRo1ZM3mAAKmHzqflfQ3ifWrINjOicm8T5Fa7/fvcBz
         GR2g==
X-Gm-Message-State: ACrzQf0pFHC9/HXje9mqfiiCSGMXthpQpw1rArke6C5CFFwGjoOiVLul
	9qWRxNDDUhefGTJQvx5M1EbhGQ==
X-Google-Smtp-Source: AMsMyM4DNEi7YFpsAkwoRPewFN1jOqD6yNDTR6Aqxrw0T9uOy1Ku99Cu3zusUZikSVaqJSi9fToi2A==
X-Received: by 2002:a05:6402:1f06:b0:457:149d:beaa with SMTP id b6-20020a0564021f0600b00457149dbeaamr31567406edb.238.1667505122589;
        Thu, 03 Nov 2022 12:52:02 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id m4-20020a1709062b8400b0078c213ad441sm864087ejg.101.2022.11.03.12.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:52:02 -0700 (PDT)
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
Subject: [PATCH v2 4/6] iommu/exynos: Implement shutdown driver method
Date: Thu,  3 Nov 2022 20:51:52 +0100
Message-Id: <20221103195154.21495-5-semen.protsenko@linaro.org>
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

While remove method shouldn't be implemented, as it can't be done
reliably, the shutdown method can be useful for performing a kexec.
That was inspired by other IOMMU drivers, see commit 1a4e90f25b2c
("iommu/rockchip: Perform a reset on shutdown") for example.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - New patch

 drivers/iommu/exynos-iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index aad845677bda..cd3f74e638f0 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -753,6 +753,16 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
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
@@ -803,6 +813,7 @@ MODULE_DEVICE_TABLE(of, sysmmu_of_match);
 
 static struct platform_driver exynos_sysmmu_driver = {
 	.probe	= exynos_sysmmu_probe,
+	.shutdown = exynos_sysmmu_shutdown,
 	.driver	= {
 		.name		= "exynos-sysmmu",
 		.of_match_table	= sysmmu_of_match,
-- 
2.35.1

