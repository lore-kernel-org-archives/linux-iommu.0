Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E4C141
	for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 14:28:34 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1b8ad8383faso51726915ad.0
        for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690381713; x=1690986513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iCvX+WYhj5dekGw4g3WHkvBAMFYYr8sXX+D13FHMfqA=;
        b=f3dsw2E2l/B/cUFrODAkpl1M5OV5n27zUh0TtgO7ZVOPLJBKhFVIHjs+5JB8zmB1sy
         suMKD2y9b0K4Ha7tTHZvAiIupK8FK/ggWg/Y/T30voOfQE9nbUOygUDJCgwPnd9DaIW0
         rhc9Adfd7VRJR1ip84y2Y9F6pTcDx/3FbWxuI328R3IufSOP7emgXXaTsXCpvClztO8N
         aRpojkWDoGwkSrT36kghgwaJJfpZGLPkmeYyuHoXHAUu5yuqOu0HgxFmePOJ4EqIWhZz
         Vhs8N0aW0sG9/G/EVh3bo2AgKnFWIkcRjAzq950BlbibwDQSRCzGe3ZTXQMRBGglcWzq
         pD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381713; x=1690986513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCvX+WYhj5dekGw4g3WHkvBAMFYYr8sXX+D13FHMfqA=;
        b=jPY1vphmeCJKEraFfsym6HrGbnxwO+zbM8kVhUJrpcdh7ZhC7G0HYHGGPybEraWfK1
         5cf90ZiTTnM5vGlDx4Tj/kCEOaZ5czIWb7J9xo480HpKkergqflTuKEUEczQJqUEwByj
         VOdDi+T53+ct0l9ep78NvXThquRZ5/a1bu2FC8ZK4wPkKcNIKuABVizYLDQrvf0wDO9E
         vQrN6pdayqOVtz70Hw2TgrV5yvTfFlRs7bVdUURTEgH4ysnVk1Z71Bk83Rl81VlTDFt6
         0BcHdwRCy6Gqb4Ak9fcXdiYc4FWssxjEwF3csE+TQjrn9kU8bH1xfPL3dGHfUXBqtOd7
         KGzQ==
X-Gm-Message-State: ABy/qLZNtUYllqlQ63EAttaZa9yE/Ytr3wt/Y9i85LQQooEUavXajaxp
	x2xBKFOLO2O1ONGnWh3P6i4=
X-Google-Smtp-Source: APBJJlFgRurokiGu50ZcGdSRGZbbIAEsnfEeD56NX7ND2XmLmc3XeMtiBfQo2ah3ofMPQZ4U2bnpoQ==
X-Received: by 2002:a17:902:ec8c:b0:1ab:11c8:777a with SMTP id x12-20020a170902ec8c00b001ab11c8777amr2739116plg.13.1690381713404;
        Wed, 26 Jul 2023 07:28:33 -0700 (PDT)
Received: from linux.. (static.111.40.78.5.clients.your-server.de. [5.78.40.111])
        by smtp.gmail.com with ESMTPSA id g4-20020a170902c38400b001b8b26fa6a9sm2189312plg.19.2023.07.26.07.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:28:32 -0700 (PDT)
From: Binglei Wang <l3b2w1@gmail.com>
X-Google-Original-From: Binglei Wang
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	l3b2w1@gmail.com
Subject: [PATCH v3] cma: check for memory region overlapping
Date: Wed, 26 Jul 2023 22:28:23 +0800
Message-Id: <20230726142823.6356-1-l3b2w1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Binglei Wang <l3b2w1@gmail.com>

In the process of parsing the DTS, checks
whether the memory region specified by the DTS CMA node area
overlaps with the kernel text memory space reserved by memblock
before calling early_init_fdt_scan_reserved_mem.
Maybe it's better to have some warning prompts printed.

Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
---

Notes:
    v3: fix compile error.
    v2: delete the logic code for handling return -EBUSY.
    v1: return -EBUSY when detect overlapping and handle the return case.

 kernel/dma/contiguous.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 6ea80ae42..dc6d2af1e 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -410,6 +410,11 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		return -EBUSY;
 	}
 
+	if (memblock_is_region_reserved(rmem->base, rmem->size)) {
+		pr_info("Reserved memory: overlap with other memblock reserved region\n");
+		return -EBUSY;
+	}
+
 	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
-- 
2.34.1

