Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F7C4C64
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 16:55:57 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id o8so1413951wms.2
        for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IZpjZAr4g1dpDBXrOrcfUkHPeUERh/JliRxp06JVucg=;
        b=W+Cm9cW/KqhsoUWLtK5lM2En6frOk3DnHTnfxJ1rLk8V1Yy7iqDT/XaD3KJvZtRB2s
         +wI1V2J9RGVol7di4+23oo12YHUhRPKldPKSV9YjJ5yjRhjrP2WaAN5WBs0dNPgnNpad
         HuJTHxC2yiT+rhVjRowuYazf0MbDsgo69VCsIM7HubxLF7kelLSkr0esfPhTrUxEUoAj
         qUDA/f2J+d74jP7aA8vMRl/XbZaIPTTn4CP/4jHqkfLZl09qcxuI9UEK/0ESchYUL1Bo
         wEKWTz5GNh1u+XnfmJpCtUYZJu5ERLefGE8Eh3Pylxz82X29Qo84Fi4d8pzdT2NYw5FK
         AGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZpjZAr4g1dpDBXrOrcfUkHPeUERh/JliRxp06JVucg=;
        b=kBUUfDJEKWt9hm2e4jtMqmqdx3ggS3G1aD8dxTsw+5eBXqtjmeLkNnqtPfwKyDom5Y
         5nLy5IkTinBOelFTl6eg1NGPl+6vY2BgzsEkMW9Kg5rexkv92ygqh+oFZlHzbH84+Veg
         leogNQ3cZ4CfAYwgEyp/6rhqwCYFI3BwvsTZ2La4L+TxA45ujN5CEgOtlGY6ZGZsdIiX
         LhC98dMelpU3QuWrNpMeMtwxWRrn5fA8CuBN8kpem4UqpMOCe0HvSKmPzJOnjJkv7cnP
         s09Lca1uGlornPtOXraOVl7GrSfmT94kjVoHRtJMuUHAgM3ukswWjkQfkAfYH74Dnikt
         pa9A==
X-Gm-Message-State: AJIora+r/9F5i+JOGd6+zF7eZU2cXbmnJe3T8Hi0Qqe4TAjLgH4dnz9B
	1f5ydJHBVstqu1xFVG+vebBi+g==
X-Google-Smtp-Source: AGRyM1s5SKEFz/1UdqSHlysek2UsdEyn9+B60Wl05LPjeSEpx2hr6sr3sPBM4eoFrT1tNuALszo/rg==
X-Received: by 2002:a05:600c:1e87:b0:3a2:fd16:5934 with SMTP id be7-20020a05600c1e8700b003a2fd165934mr9028538wmb.25.1657817756378;
        Thu, 14 Jul 2022 09:55:56 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c2ccd00b003a2f2bb72d5sm5516033wmc.45.2022.07.14.09.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:55:55 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Janghyuck Kim <janghyuck.kim@samsung.com>,
	Cho KyongHo <pullip.cho@samsung.com>,
	Daniel Mentz <danielmentz@google.com>,
	David Virag <virag.david003@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] iommu/exynos: Set correct dma mask for SysMMU v5+
Date: Thu, 14 Jul 2022 19:55:47 +0300
Message-Id: <20220714165550.8884-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220714165550.8884-1-semen.protsenko@linaro.org>
References: <20220714165550.8884-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SysMMU v5+ supports 36 bit physical address space. Set corresponding DMA
mask to avoid falling back to SWTLBIO usage in dma_map_single() because
of failed dma_capable() check.

The original code for this fix was suggested by Marek.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Co-developed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v3:
  - Added Krzysztof's Acked-by tag

Changes in v2:
  - Handled failed dma_set_mask() call
  - Replaced "Originally-by" tag by "Co-developed-by" + SoB tags

 drivers/iommu/exynos-iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index c85db9dab851..494f7d7aa9c5 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -646,6 +646,14 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (MMU_MAJ_VER(data->version) >= 5) {
+		ret = dma_set_mask(dev, DMA_BIT_MASK(36));
+		if (ret) {
+			dev_err(dev, "Unable to set DMA mask: %d\n", ret);
+			goto err_dma_set_mask;
+		}
+	}
+
 	/*
 	 * use the first registered sysmmu device for performing
 	 * dma mapping operations on iommu page tables (cpu cache flush)
@@ -657,6 +665,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_dma_set_mask:
+	iommu_device_unregister(&data->iommu);
 err_iommu_register:
 	iommu_device_sysfs_remove(&data->iommu);
 	return ret;
-- 
2.30.2

