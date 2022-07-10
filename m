Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DEA3C2B
	for <iommu@lists.linux.dev>; Sun, 10 Jul 2022 23:06:07 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id n185so2123244wmn.4
        for <iommu@lists.linux.dev>; Sun, 10 Jul 2022 16:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t3ZTmvONYAL3UmGbG2MULEJQEOXDk4bgL9Jsh2UKHR0=;
        b=shjCmOtmTJr3WRbag5oJo/fGtuTm1xqY1Edpx4CJaaiZU343eW60a+82utSz3xgQ6p
         aWRh/+ep3FFT5CK/PAucz0i721CP1Tv8cjbvbTE+AhRlyVXwHm1otNklh+FMTNdiFjGu
         55b4myBFjVznKA/z4iJAZwDdSIxXuSi6gp/LWCCvEsbgcxfUZ4MfqtLHHpblqvIri1yB
         4RSYvjtpzs5XMxP29a/xlpF8IaGDvpGJYFFUEVEiNzzzu5RYpUG3VKKrJ5x5b4C4v8W/
         VUvCmv7rG2tPfBge19Ypz0vXdpnvffjH4V94S0rjZ2GonwrfU21td/QHNbZRnyGdBDo1
         n0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t3ZTmvONYAL3UmGbG2MULEJQEOXDk4bgL9Jsh2UKHR0=;
        b=jIrP9EsLeeRsmssm+zjzayIyOTQ9g3SxQ8rGZ/zFUGOwnUkYgLhdPEue/Gn4CnaNu9
         McoRuuquIfpR7YxNUCbFWd4J8oezmgGyvLy7zQLzhFNUsUirxBQjSCdnTgJeS3la0iAD
         p4JMdaJk+uVslNeyiZsVjfEPGA/uzW5UF34fawal5jvl0KVBMIrlj8OA6fNWb7feIiFf
         LKdu1dPRGjmfqqhdCXmTd7/3TJmXAps9AmVi9NaKME/8MekcFy0q6XdtgLWkSExEAWyp
         ctMkOkUbNdggWtMrhX4X7v9Zh/N9QlFaFUtyGnuBy1c6sG7Lbz4TALjud9mM7f5tUfCD
         anyg==
X-Gm-Message-State: AJIora8rhrBtWWojj2aCuxRXTO8BqxRw86NJmdkU7sys2BJkNCcmsqUK
	EJG7ebQtoZeP+J7gQrAMIH7weQ==
X-Google-Smtp-Source: AGRyM1u43KlHkERt90c0V0mKxMDOvNBrf0leawFGzCy7FxHSo4Rkj7KffUTXFcFXeKS8Uks57TmrnA==
X-Received: by 2002:a05:600c:6024:b0:3a0:4ea4:cfa4 with SMTP id az36-20020a05600c602400b003a04ea4cfa4mr12564968wmb.119.1657494365850;
        Sun, 10 Jul 2022 16:06:05 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d6604000000b0021d650e4df4sm4436047wru.87.2022.07.10.16.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 16:06:05 -0700 (PDT)
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
Subject: [PATCH v2 1/7] iommu/exynos: Reuse SysMMU constants for page size and order
Date: Mon, 11 Jul 2022 02:05:57 +0300
Message-Id: <20220710230603.13526-2-semen.protsenko@linaro.org>
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

Using SZ_4K in context of SysMMU driver is better than using PAGE_SIZE,
as PAGE_SIZE might have different value on different platforms. Though
it would be even better to use more specific constants, already existing
in SysMMU driver. Make the code more strict by using SPAGE_ORDER and
SPAGE_SIZE constants.

It also makes sense, as __sysmmu_tlb_invalidate_entry() also uses
SPAGE_* constants for further calculations with num_inv param, so it's
logical that num_inv should be previously calculated using also SPAGE_*
values.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - (none) This patch is new and added in v2

 drivers/iommu/exynos-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 79729892eb48..8f80aaa35092 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -340,7 +340,7 @@ static void __sysmmu_set_ptbase(struct sysmmu_drvdata *data, phys_addr_t pgd)
 	if (MMU_MAJ_VER(data->version) < 5)
 		writel(pgd, data->sfrbase + REG_PT_BASE_ADDR);
 	else
-		writel(pgd / SZ_4K, data->sfrbase + REG_V5_PT_BASE_PFN);
+		writel(pgd >> SPAGE_ORDER, data->sfrbase + REG_V5_PT_BASE_PFN);
 
 	__sysmmu_tlb_invalidate(data);
 }
@@ -550,7 +550,7 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 		 * 64KB page can be one of 16 consecutive sets.
 		 */
 		if (MMU_MAJ_VER(data->version) == 2)
-			num_inv = min_t(unsigned int, size / SZ_4K, 64);
+			num_inv = min_t(unsigned int, size / SPAGE_SIZE, 64);
 
 		if (sysmmu_block(data)) {
 			__sysmmu_tlb_invalidate_entry(data, iova, num_inv);
-- 
2.30.2

