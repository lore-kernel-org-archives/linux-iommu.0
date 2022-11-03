Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E69263D3
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 19:52:07 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id v17so4678006edc.8
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 12:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVK/kV0R0vkenb2LDbscFxA0X0dByuia1tz97ff80yM=;
        b=yjqdzBc5QkyWO8tIOpyy1HtXjyZWn0cIpOjMTkb96S3bxh24aATJ8xyBB1R/B77CcN
         NObHEXqX95u/z65/XPcAc2WpVxQKcNaxILUDOynzEmr1ML60iu9C07+LqmPtznkychUZ
         U9kL90pOsziktU0wt5b2868dOA9QSFgj2X/BX+G6yE/NYEQYIYBP/r/DhrDopUiHidb2
         c39d5XT8elagWGepDKVNz/nymSi2onmOLUbPW85gTrTHZd6MnqlK+lVA2WT/cxSGl82j
         l9XHJYIoXhBrnlmf27/QcKjQSI8RtSLMN87uzifXjW670JH8PGoZxwEFBkTmWPyXeMLy
         F8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVK/kV0R0vkenb2LDbscFxA0X0dByuia1tz97ff80yM=;
        b=0K+SylKrSmrkjj181xU+KL3KC7i+yTj2ozBVltiW+s1X6dikYa++RC9KF9eXcjPgh3
         yQsFtDX7kFLcna80YUqyTgVCOO+rVrByCNF6HpsD0tlln1KtwwMKRYipkAL3jSGHKrxd
         4x1mWosq0KqDfMu/5oe2/1O5svbSyxQDNawXhJfj3U2uzGCiaMabof0LwpV5f8/LUOng
         6OGbDtGa8I1uTDc0WZCj5Wu5gcViwmROm0bMn4xhQTaPTW6Ug0wPF38tLB1EgKwEsMwl
         4paBWaVw16nDpQr0qVMzRUKWQRi10BeILvby/TeK6B2bT9U7oxyTwTNge6hkRbUbpuPV
         0/3g==
X-Gm-Message-State: ACrzQf2ytXsGgqCrr5lJPctjK64TylO33kiwCigr4anm5cNdRXvYIMhX
	JQP2jjcdirqaBdTm5J1s1z5mUQ==
X-Google-Smtp-Source: AMsMyM7ofQ+KeORNK7Xlf3qp7IJQwgQUB3P6e82hsOfsUmArPfMzYSqz5U1Wsk/ERagunutF5X6Uqg==
X-Received: by 2002:a05:6402:1c0a:b0:463:3cda:3750 with SMTP id ck10-20020a0564021c0a00b004633cda3750mr26374259edb.341.1667505125822;
        Thu, 03 Nov 2022 12:52:05 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906165300b0078907275a44sm863484ejd.42.2022.11.03.12.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:52:05 -0700 (PDT)
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
Subject: [PATCH v2 6/6] media: platform: Use IS_ENABLED() to check EXYNOS_IOMMU in s5p_mfc
Date: Thu,  3 Nov 2022 20:51:54 +0100
Message-Id: <20221103195154.21495-7-semen.protsenko@linaro.org>
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

Now that CONFIG_EXYNOS_IOMMU can be built as a module, it's not correct
anymore to check whether it's enabled or not just with #ifdef. Use
proper IS_ENABLED() macro to handle both built-in and module cases.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - New patch

 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_iommu.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_iommu.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_iommu.h
index 1a32266b7ddc..a8b48692d128 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_iommu.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_iommu.h
@@ -7,7 +7,9 @@
 #ifndef S5P_MFC_IOMMU_H_
 #define S5P_MFC_IOMMU_H_
 
-#if defined(CONFIG_EXYNOS_IOMMU)
+#include <linux/kconfig.h>
+
+#if IS_ENABLED(CONFIG_EXYNOS_IOMMU)
 
 #include <linux/iommu.h>
 
-- 
2.35.1

