Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC419BA1
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 16:07:43 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-666ecf9a081so821958b3a.2
        for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689869262; x=1690474062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FDlR75jCTWnutj2GqCkt5kjAmLZ3uaWEFiEojxMDrOA=;
        b=GXaEZu3t4pzn71mFp69Of/QYBFraIdZR0yIlR4e3y+CSg61eWb/C+JUWIXDIW/WQQi
         w1YGEi/ir6nGvTDCNLj7//wk2OXaUurXP3D8Ysiu55KxtOWlj3L4J6WN9S3GjBjCfzua
         IXBLb7Q1ekV7FrKpMtRwxFQosIaReUr+x9bjvv1s5EJGi5Hy6QxqUlupVdk/qhnxh4L9
         D2Y7HH/JdF7yX5GYscgv9IpSoGszQe7i5O2tD5wleYgLJzXgxukdDbTotFB1CCxoh9lD
         TfjJjfEPuuDlcCjasdJBmtcMNgVbl7WlS8vxM3MfT0vuJ5F4w+ILpNlwDEj72ab/y47g
         ulPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689869262; x=1690474062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDlR75jCTWnutj2GqCkt5kjAmLZ3uaWEFiEojxMDrOA=;
        b=XeeAeErXDk1aXHkgJNFnw1zyGcEzwvw5qog4M/0RqPWAMs/vZD3PJepAx6lLP7gQWq
         iHcWIRIdsBEd4mTWFplPO2COEtfwkwH1OeBsZbREqwgQlVyiKsF/Gj9N1PLwXIHdZ5i+
         C63ZGaqhHceKJTBGyC8Mn43Pw9dc7e8YaC8pIzJkJ/vXj+OLN4SngtjtXkphlLJVamb7
         9IB3jIF7SeeH4R7Vm3hUnfanglkw1Lrc9YzVodC9gLKCGZ9KI/InDLhNgYbOh+fx4qjJ
         hXS9qRc6H3SHhkBSCdBoEFKNcpeM8zhJWhf3EPYpVgP+geEqsDxrXcXsWzHkZqTM3F97
         JqGQ==
X-Gm-Message-State: ABy/qLZSotpiz0Zh1hYYDCqon8epSDsqPySpntgbES7MADbdxzG+BkW7
	3xxagiS0/mfl+mnHCLnZ2SQ=
X-Google-Smtp-Source: APBJJlGsiSzauWOSKd4n1ByDIDYS8P/EIAsQheqzHj4aeeJVZn12STbjIByZE7ft/dmtqsa6x71MsA==
X-Received: by 2002:a05:6a20:9383:b0:134:76f6:e9e2 with SMTP id x3-20020a056a20938300b0013476f6e9e2mr17240293pzh.58.1689869262478;
        Thu, 20 Jul 2023 09:07:42 -0700 (PDT)
Received: from linux.. (static.111.40.78.5.clients.your-server.de. [5.78.40.111])
        by smtp.gmail.com with ESMTPSA id c21-20020aa781d5000000b006687b4f2044sm1348010pfn.164.2023.07.20.09.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:07:42 -0700 (PDT)
From: Binglei Wang <l3b2w1@gmail.com>
X-Google-Original-From: Binglei Wang
To: robh+dt@kernel.org
Cc: frowand.list@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	l3b2w1@gmail.com
Subject: [PATCH] cma: check for memory region overlapping
Date: Fri, 21 Jul 2023 00:07:29 +0800
Message-Id: <20230720160729.39324-1-l3b2w1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Binglei Wang <l3b2w1@gmail.com>

Cma memory region editted carelessly in dts may overlap
with kernel code/data memory region which is reserved by memblock
during the early phase of system memory initialization.

Without checking overlap and cma area setup done,
this region will be released to buddy system later.

When memory usage under pressure, memory allocated from
this region will collide with kernel code which is read-only.
And the following writing to this region will trigger the panic
of writing to read-only memory.

So when rmem_cma_setup returns EBUSY, do not phys-free this region
to memblock or else we end up with free the kernel code memory
to buddy system.

Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
---
 drivers/of/of_reserved_mem.c | 3 ---
 kernel/dma/contiguous.c      | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 7ec94cfcb..d62cc76ef 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -338,9 +338,6 @@ void __init fdt_init_reserved_mem(void)
 					rmem->name);
 				if (nomap)
 					memblock_clear_nomap(rmem->base, rmem->size);
-				else
-					memblock_phys_free(rmem->base,
-							   rmem->size);
 			} else {
 				phys_addr_t end = rmem->base + rmem->size - 1;
 				bool reusable =
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 6ea80ae42..a349f3e97 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -410,6 +410,11 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		return -EBUSY;
 	}
 
+	if (memblock_is_region_reserved(rmem->base, rmem->size)) {
+		pr_info("Reserved memory: overlap with exsiting one\n");
+		return -EBUSY;
+	}
+
 	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
-- 
2.34.1

