Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E820FBB
	for <iommu@lists.linux.dev>; Tue, 25 Jul 2023 14:16:14 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-686b9920362so130335b3a.1
        for <iommu@lists.linux.dev>; Tue, 25 Jul 2023 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690294573; x=1690899373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oFxuOTNi48idsZt2cpb80HlTb2Zev1a6Crwl3aXBH/I=;
        b=Vnvg+6kraoEV4R961SF/K60SkLscD6ltMXTv8foeY0JKks11+5r4lBp5ADRIJyrOGa
         d6n2xSvOx7v42sVgmO2CyW1JxwyEDLIUYxFU/u6LAykPSzMllz9OSI3L//5uBQazyOYr
         vCe6fhoGyES7upDBUZVVRCwUOzjt3V787cVK3tYVRXaVKTHb5X9DBhE+fA7x2cTnxfc2
         4zscfVQYnRGlBpSkRDrLDAgcweyQv4q18QGI9NHE9wJAnCnUm5VKiGGfIW/ELbLw51GG
         7zeRqRVYAQH19p4/3qTj+45e5XJS7pmB1NAopg+dGGPRH6LKSDZC2fUpsPpBulDZDDas
         mwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690294573; x=1690899373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFxuOTNi48idsZt2cpb80HlTb2Zev1a6Crwl3aXBH/I=;
        b=GhmzOLRqxSugKJYLJcjELbrWPwDfacXRhBzraqLuuMcBWCAy3TiksJUBlTyViHn1MO
         MciyDR2YV63vebVVCPScTUAcw/hy92eSrOMCScBMelkGEjHP77vyQ9cLP86VLe0E1uHB
         CA0F1TR98/wJ3DWMeDCxinRc+pnEdlB0lFys1loBMG2XyQDaC9vlLXv8b0XVAxiRw9Qf
         SbdL446ZyRpS0VZuhSvSrLOORRgVuGGhdEevkyZaZgeAFmPgpDxuVvP0bavBx6A8eOH0
         ZhXkmfoUfQwQtL72pbgECc5MPUV+ixHvouOQWse5J8qviz2jyxmGeP1ZHqZH3A5GcSqs
         dRSg==
X-Gm-Message-State: ABy/qLZKiCkdqCPRREYuNG44mhaTMpMLYI69l+uiRiUjDXCEHtKMSz0y
	PPc8XLPyfxqzVA4ky6S/coU=
X-Google-Smtp-Source: APBJJlHnwscllbyiMqyKzSni+zvMpZ7xsDOd2enSsYZDaaLi+YxRoadU3GPJJ4wXqwVYidJ2mvJSKQ==
X-Received: by 2002:a05:6a20:841a:b0:135:4858:681 with SMTP id c26-20020a056a20841a00b0013548580681mr12732107pzd.9.1690294573391;
        Tue, 25 Jul 2023 07:16:13 -0700 (PDT)
Received: from linux.. (static.111.40.78.5.clients.your-server.de. [5.78.40.111])
        by smtp.gmail.com with ESMTPSA id l24-20020a62be18000000b0064f7c56d8b7sm9601482pff.219.2023.07.25.07.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 07:16:12 -0700 (PDT)
From: Binglei Wang <l3b2w1@gmail.com>
X-Google-Original-From: Binglei Wang
To: hch@lst.de
Cc: m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	l3b2w1@gmail.com
Subject: [PATCH v2] cma: check for memory region overlapping
Date: Tue, 25 Jul 2023 22:16:02 +0800
Message-Id: <20230725141602.7759-1-l3b2w1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: l3b2w1 <l3b2w1@gmail.com>

Add a overlapping check in the program flow of paring dts.
Check if cma area overlaps with memblock-reserved areas
(kenrel code area for example)before calling 
early_init_fdt_scan_reserved_mem.

Signed-off-by: l3b2w1 <l3b2w1@gmail.com>
---

Notes:
    v2: delete the logic code for handling return EBUSY.
    
    v1: return EBUSY when detect overlapping and handle the return case.

 kernel/dma/contiguous.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 6ea80ae42..20ebbcefd 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -410,6 +410,11 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		return -EBUSY;
 	}
 
+	if (memblock_is_region_reserved(rmem->base, rmem->size)) {
+		pr_info("Reserved memory: overlap with other memblock reserved region\n",
+		return -EBUSY;
+	}
+
 	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
-- 
2.39.0

