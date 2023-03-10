Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794AA8820
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 14:47:46 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id p8-20020a4a3c48000000b0052527a9d5f0so819118oof.1
        for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 06:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaG0TuJkSsZEq6KyR2Pw2svGg0iIophmgifd7AAJgZA=;
        b=ZT/CvKxSBhgiC7NEOHVyq4ToCzgVVZCOiKVyXoeTlQje6JtJvi4KCJTZLY0QtDF1Il
         kvs9MeGIpntVu+XCWHvVWIlSUWrmYgD0LKgDTgp8ZwBTDr5XcVwlGuMHzig5l+W3Az4f
         Zec60/0Cr73jRjC5Zmk+1EuocU+xKAatpjo532smZdYKBc7fzQONt8dOEihnG2f3d984
         JuTGEyxzaWsmkxOItAxdrwe59nE16VPH8sz6VvklfTnI9/ov+8aqPSOD2kyMtvccWr48
         iISewZNA/NjW9udzqrNmHLfLzR/atSJdrrkNQBb2wWokhVu29+g1tEZgkGs1zSvzn9kQ
         VRSA==
X-Gm-Message-State: AO0yUKW3Id4E06D86+Ay9lKuDwiDUVGE2485wAAuAZHq1PJ1L9LFf/eN
	nFpnZ4+cV/QjIYKMWnc7XA==
X-Google-Smtp-Source: AK7set8+gWXMSTtGEYuxYj+rHrEgRcQwcPQPrVXthx8wns6wXVi81jocwA/15crUkZWCDQp+pYVWYQ==
X-Received: by 2002:a05:6820:174:b0:51a:ac9:775 with SMTP id k20-20020a056820017400b0051a0ac90775mr12553434ood.6.1678459665482;
        Fri, 10 Mar 2023 06:47:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 63-20020a9d0845000000b00690f6d9a737sm134796oty.8.2023.03.10.06.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:44 -0800 (PST)
Received: (nullmailer pid 1543027 invoked by uid 1000);
	Fri, 10 Mar 2023 14:47:09 -0000
From: Rob Herring <robh@kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: devicetree@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: omap: Use of_property_read_bool() for boolean properties
Date: Fri, 10 Mar 2023 08:47:09 -0600
Message-Id: <20230310144709.1542980-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 3ab078112a7c..baafd6211ac4 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1191,7 +1191,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
 		return err;
 	if (obj->nr_tlb_entries != 32 && obj->nr_tlb_entries != 8)
 		return -EINVAL;
-	if (of_find_property(of, "ti,iommu-bus-err-back", NULL))
+	if (of_property_read_bool(of, "ti,iommu-bus-err-back"))
 		obj->has_bus_err_back = MMU_GP_REG_BUS_ERR_BACK_EN;
 
 	obj->dev = &pdev->dev;
-- 
2.39.2

