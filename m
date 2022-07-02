Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446F31FA8
	for <iommu@lists.linux.dev>; Sat,  2 Jul 2022 21:37:28 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id d2so10096100ejy.1
        for <iommu@lists.linux.dev>; Sat, 02 Jul 2022 14:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aWfZE2YpB25R+rCMwVNZi2s9IwZn0JfO+IgsGnjhYqY=;
        b=wVSILGBGUjVOC+cfuxxbSMyxpvn6GttZQpREPJStje8Jo1kxV0hOiJBQjYgcMjnGO8
         HzrlHKacg6/F0WF0UTTYxmtVqmcttqofFOrJX6K+BP9MvvRdIR7qYrVcD7+DFCx3EKT0
         v7Hte9vIx/BKEL3aPNq1az2t5Nf5ERiriNAhe4KwSJOAyDfa58FaLw+AHHh0SnQeL6jn
         UMtj1LphcAYF+SCg6rTx11cw/9TDH61FUx3QLb2jvIAt9clvxCy6iYOFU5DZ9Kgf8G9u
         J/kArGjS3bdmqxj4yPJLCgNcdbkBX/TWXfqGZSQ3YUT28PeuTlKYSuvKmAr01wazLM4f
         ZKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWfZE2YpB25R+rCMwVNZi2s9IwZn0JfO+IgsGnjhYqY=;
        b=qoNti763WgGyjJ5IiE4tEKP/cca1eH/vbhMftgDBSlSQBPMmma4YbHew7d58hoW4UQ
         q5D+o+W+rBsSWr2pcl63UAtRHzflkEw6j1bFVh4DNvlZergFjXS7gEPB2TSQsoizMYfN
         Yv7fQUYDVpJ3IRM/NEEyk7fvKA8ThOuS7ekID3GpMSblzlyh35/LRWUwWEnm083nJR/5
         ntwWDoimsSO1OXj7zvCASl9PUEfPrftsLdzmj5PwRs0Ob8Fo7tYYG7dOWkORB7Nf6ukf
         6K6qN6GXGYlNhDTpoNeoEpcXK0gGzYC+TD+aKsty/9lDY4SGRvocDd2CsxPgVBSp6otn
         y5FQ==
X-Gm-Message-State: AJIora9vbamq+pLNuKr6NMm+WmO8Etbfyq7ndzO9IBpeFWvFhCWwj9J0
	LVokTlPKgX7Gusqs0bPJ9TnzjA==
X-Google-Smtp-Source: AGRyM1sjE5ZjIaY+GfCnbQmj6BkapC2AnzQE+mzuISXF0GaEPi7w7Vucxh56Irz739GXVnorjZvvIA==
X-Received: by 2002:a17:906:1018:b0:718:dd3f:f28c with SMTP id 24-20020a170906101800b00718dd3ff28cmr21490786ejm.55.1656797846558;
        Sat, 02 Jul 2022 14:37:26 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906671200b00718e4e64b7bsm12214247ejp.79.2022.07.02.14.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:37:26 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Janghyuck Kim <janghyuck.kim@samsung.com>,
	Cho KyongHo <pullip.cho@samsung.com>,
	Daniel Mentz <danielmentz@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iommu/exynos: Set correct dma mask for SysMMU v5+
Date: Sun,  3 Jul 2022 00:37:21 +0300
Message-ID: <20220702213724.3949-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220702213724.3949-1-semen.protsenko@linaro.org>
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220702213721.-dED2-Go_xUc2qlHoxCs7WJ1pndCoXyYDHzT8ULQp10@z>

SysMMU v5+ supports 36 bit physical address space. Set corresponding DMA
mask to avoid falling back to SWTLBIO usage in dma_map_single() because
of failed dma_capable() check.

The original code for this fix was suggested by Marek.

Originally-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 71f2018e23fe..28f8c8d93aa3 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -647,6 +647,14 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (MMU_MAJ_VER(data->version) >= 5) {
+		ret = dma_set_mask(dev, DMA_BIT_MASK(36));
+		if (ret) {
+			dev_err(dev, "Unable to set DMA mask: %d\n", ret);
+			return ret;
+		}
+	}
+
 	/*
 	 * use the first registered sysmmu device for performing
 	 * dma mapping operations on iommu page tables (cpu cache flush)
-- 
2.30.2

