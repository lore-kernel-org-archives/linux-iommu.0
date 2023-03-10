Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6748821
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 14:47:40 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id g6-20020a056830308600b0068d4b30536aso3025480ots.9
        for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 06:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0H5Wu4JK6lQArjMSAowLoAG+26f+c1LrnbxEzmAS4U=;
        b=q2HXnZamplihOQUsmFNj88i5ypFKlO794GGyW8KKehsT7/GVgFDyvHk+Gxf2+nY9sf
         WHMhSgAI9+0jqSxI8pLCxLp1S1veep5D4/6nYV7t+MPOFCnvoIKHIXT4MPAsswAzrM3+
         /0pzWqrGG3RlRh+rjfF7CYPeQW6ftkig53vqhJXu1xZvQXizuebkTxPFZQ0Tkh+MX97K
         IQTZiWkaBgMdrAjCyBDr3c9hgOqqTYf3bDOWebSY2TCBSfVd95xT2AqChfz218W8u5oY
         PthomjJX4WEGWZ9gDGjv2n/7gRAdIqRsxfb4ac9407NYliS8/ZmmFLj/Yh3dVOEfkIGu
         SGvw==
X-Gm-Message-State: AO0yUKW+Hw9eus7v44xE8xnefsdtuokm6yED9paovK3dbyMaxOi1xWQP
	NmtgGEcIfmpVVnJ3YYDILkE7ODDTNA==
X-Google-Smtp-Source: AK7set+1v0Oy317O/GgYXBQ/6eEBO/u3ew/d9R+Nk1dh3yQXWhHfEHApW3jqyFaoPyN4Vuj/ZB6org==
X-Received: by 2002:a05:6830:807:b0:694:39e5:fdc8 with SMTP id r7-20020a056830080700b0069439e5fdc8mr12074773ots.32.1678459659397;
        Fri, 10 Mar 2023 06:47:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a26-20020a9d725a000000b00684c5211c58sm107392otk.60.2023.03.10.06.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:38 -0800 (PST)
Received: (nullmailer pid 1542936 invoked by uid 1000);
	Fri, 10 Mar 2023 14:47:09 -0000
From: Rob Herring <robh@kernel.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: Use of_property_present() for testing DT property presence
Date: Fri, 10 Mar 2023 08:47:09 -0600
Message-Id: <20230310144709.1542910-1-robh@kernel.org>
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
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
 drivers/iommu/ipmmu-vmsa.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 2ff7a72cf377..d0843caf8760 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -139,7 +139,7 @@ static int arm_smmu_register_legacy_master(struct device *dev,
 	int err;
 
 	np = dev_get_dev_node(dev);
-	if (!np || !of_find_property(np, "#stream-id-cells", NULL)) {
+	if (!np || !of_property_present(np, "#stream-id-cells")) {
 		of_node_put(np);
 		return -ENODEV;
 	}
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index bdf1a4e5eae0..f4470303d906 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1014,7 +1014,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 	 * the lack of has_cache_leaf_nodes flag or renesas,ipmmu-main property.
 	 */
 	if (!mmu->features->has_cache_leaf_nodes ||
-	    !of_find_property(pdev->dev.of_node, "renesas,ipmmu-main", NULL))
+	    !of_property_present(pdev->dev.of_node, "renesas,ipmmu-main"))
 		mmu->root = mmu;
 	else
 		mmu->root = ipmmu_find_root();
-- 
2.39.2

