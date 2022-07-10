Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E43C2B
	for <iommu@lists.linux.dev>; Sun, 10 Jul 2022 23:06:09 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id bu1so3746299wrb.9
        for <iommu@lists.linux.dev>; Sun, 10 Jul 2022 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R103erxeCCHS3ZUMewsB5C1yy+zcGyX5sa9sukmtQlA=;
        b=fLuyUwyFBhuSKQzea4YKfooN5u8vLxajhzZfJiUNNmT6fjM23kiTCm6Z5yIImksVh5
         lKbtLFd24T7ayF/oB0abItkwp0lNCG0ghAJzPh4G3postibpTtFBBvM4Fntt1BEaOWvP
         zEyhX4ho27fL4YtKz90nx849VrALn9l90CFJEKmyU41u4qcCLTP9evbyTEfAuyaBC3gN
         oKvStT4nSnB10aKgpJ29VmiNuHp8pccko5rT27B8qfz9szXra3l/v4EVewqKj/SdJbRR
         JtuV3zuxQesh8+7sU7ZHpouewD8sn/EUwkU8oDubw4Og8ir0KQ+5xlNDJ61h99y991xI
         72cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R103erxeCCHS3ZUMewsB5C1yy+zcGyX5sa9sukmtQlA=;
        b=mdj8v9CVuNP3FIAmPoSCEzrLtt123FoXrgIdChbE4C68ctotvbKN06kM2f3My1Oobs
         JID2dmPZHDZn7dYrELoykQ7S2zgMB5FemUzV/SdaI5QKKiuX8Bnn3D60UwiXm4fUd2ac
         puzQu9PqWq2w60rDiJl9jKeamqiT1QIaR6i5i9Ytthgv5Ev5BmtKnDjPjxfWCgbXnEUD
         HM6t0sNX0ttPFIEnO0voxfpRAd5+5sU+8lPtxv6lxgtV54JtgLxWf3tDd9itCX3ts6kl
         ej9eIInTFSyL6AJfiquVX9V7sTVZSORvVq09qTwtmH7VmoEB3YhAXGcg7DrdM0L2DvGa
         S9VQ==
X-Gm-Message-State: AJIora/xbLOEu5tXqjB/9kUiLHqRzA5q3XYq+tx17OSdNK6KZajrx/ND
	kGoHxd012qOE2WZX9cdkM693+w==
X-Google-Smtp-Source: AGRyM1vww+/EwQUG5ItTSVzcGPkgSaNRCtATWrYEb+Z/Gu6CFwsngTsI375t0lfeO503K1T635bVCg==
X-Received: by 2002:a5d:4402:0:b0:21d:8093:138c with SMTP id z2-20020a5d4402000000b0021d8093138cmr13985720wrq.535.1657494368329;
        Sun, 10 Jul 2022 16:06:08 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d6244000000b0021d6e917442sm5383041wrv.72.2022.07.10.16.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 16:06:07 -0700 (PDT)
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
Subject: [PATCH v2 3/7] iommu/exynos: Set correct dma mask for SysMMU v5+
Date: Mon, 11 Jul 2022 02:05:59 +0300
Message-Id: <20220710230603.13526-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220710230603.13526-1-semen.protsenko@linaro.org>
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
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
---
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

