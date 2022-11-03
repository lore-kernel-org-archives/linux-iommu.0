Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B163D3
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 19:52:00 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id f7so4690564edc.6
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C88yKCopssymOAMe7KHFSlCl2Lylr4sF9uZV7UHC95E=;
        b=JNnSWiaLPu25KnAyCNpaAD7Ly2+4NcVx1V6Eugxf+ijwsUjrFE9ecgyeuEgPFSEyxz
         FKf4DWokPxTymvXIRFJCPn0ZpWILr52tu/S0yEzdyMAff5tTSxtHw8Z8xhoPjTDU9tfD
         bBq9y1xE4YfD8UQu5ZFgRhYzuUzOytWCb9pbu4MovgFkctkLmV/L9dBwQ8vu1/YzszeC
         qDTCvEwTaxg5dBDp0D1xq8KrSAN8FLdNejgZRNeJu2qKXC7eNNhAdG7mQpbpyk3hnWKF
         BkgxrumY+6mwjvxtqef2jQAZ7+SHEv/MoZgYdsJWgK7ZznhFuWS87Nv3WmzoQd6o3Z4b
         Nx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C88yKCopssymOAMe7KHFSlCl2Lylr4sF9uZV7UHC95E=;
        b=60qeofLXOUyLI9Uj5Vl4GXkmO607xNaux/TKTOXOyxBJrBL/AhVwSZBiawgnKo8iaB
         dkSLeHaO2ANNXK/jZGFAwGcWxvfa8Yj/iQmOgrhO7IeHGibNbV9IJwmnsEKe+gnOz8NC
         R/g7fGmJ3o0QHzYlWztOEL/+u3t4Ka+cbChnLrQkITqCK9dNy5/IbZszvlyp6XNeFiUR
         4PxmqkBZqeH3ZKAp0l98uv1ClJVxvg3Gdu25Q0tJGRye5rW/+0lyGCoH0Fb5Lud++DjH
         vA+kAsRwROda4gYBwISdT9aikWk0nTwcN7W6pK/qbE6XPjhYb/6UvY70aY4M3DImVrMR
         p/tA==
X-Gm-Message-State: ACrzQf0XpabGhRq3/Z5mxHmZ9S/i6kvKoKitxhHImCbAPoScfODezxnH
	v5sr+NntnyksJb/fbBYxy4qr2A88eiD8tU54URU=
X-Google-Smtp-Source: AMsMyM6Y55R2EylxgpVkhefZzzu5RD8DbeFh1wK3GdXxJzvb2ejuoWCID5I4EuKnM999UShBLermFA==
X-Received: by 2002:aa7:de0a:0:b0:462:d2a0:93a with SMTP id h10-20020aa7de0a000000b00462d2a0093amr30786059edv.275.1667505119162;
        Thu, 03 Nov 2022 12:51:59 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id tz14-20020a170907c78e00b0078ddb518a90sm834227ejc.223.2022.11.03.12.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:51:58 -0700 (PDT)
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
Subject: [PATCH v2 2/6] iommu/exynos: Fix retval on getting clocks in probe
Date: Thu,  3 Nov 2022 20:51:50 +0100
Message-Id: <20221103195154.21495-3-semen.protsenko@linaro.org>
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

checkpatch reports next warning for clock getting code in probe
function:

    WARNING: ENOSYS means 'invalid syscall nr' and nothing else

Replace it with -ENOINT to make checkpatch happy.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - (none)

 drivers/iommu/exynos-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 45fd4850bacb..0d150b383d04 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -689,7 +689,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	if (!data->clk && (!data->aclk || !data->pclk)) {
 		dev_err(dev, "Failed to get device clock(s)!\n");
-		return -ENOSYS;
+		return -ENOENT;
 	}
 
 	data->clk_master = devm_clk_get(dev, "master");
-- 
2.35.1

