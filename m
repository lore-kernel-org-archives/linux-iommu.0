Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBD61857
	for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 10:51:53 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id r17so31165041eja.7
        for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8s/NenqR0ahFt82BntWKaJG1O8nHl/K2hei9L3ruCZ8=;
        b=KGAw/QW0PiTZ9+Ardgq7VdZhJxcUoB7pyfxIUirEukeTz4vqWLS6WoOuIxHLfsQw7F
         +JR9LpunPF8g6P8uiWo65OH3j695YMWeG6Ax9w83fVCVOSqK2dl8+hdyHL5uvn+n8384
         qU5sJ+PvjmOLN7pgPqG6gHyT15bDniMt8fyUz4NPtQdPkGC6I0C45zIINxrR7c6ghK+S
         kWW075BUXclIIlpsq1qgAfHI9Ty72JnOoOhgefYro0GI78I2+wHrAwSng/AUqRmWLp34
         EwfTfKxG1ZA4pYdECeH267F2FoiyTw7POhy0x027w8wWYbsVoaZ+lMLKBhmbqsWByVV6
         ZeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8s/NenqR0ahFt82BntWKaJG1O8nHl/K2hei9L3ruCZ8=;
        b=z4DZYKkgPS5wuFYj4cb+T3Va73XZEx8H3XgdlC73D16e2Jq/qSiwasRtlJ7fZO1Saw
         N2bkp8gRzXQPJVMJ4Cw2G858/q4ZpTmaeyiwEvE16rAK3UOtpxNWwxw9uYVkXpH5cEfT
         OfKRN8Ge1y0gOHcwnKtFjPO9hgAcD64T6Q6KAHqgAqGKWQNYAaHOYrS1UbISofLl7q5q
         A/qc+atwimRAliP/xqDQUv3M2Zeqn3jWvuk3kg8lClUz7d+klXy1KqvVWIJu+Xwdff3A
         qBqsbriovYAjSH5No0OA5n7Kvs19EKjlqXO1rL+qFSSlK17OL8Xeij/dm1ndshKQY+XH
         8Pxg==
X-Gm-Message-State: ACrzQf3PbUcbMih5CLputdrOVjV23/tX2bS/oCRxjegRJIyu4KV0pCyB
	WFeumMVO2gvr5P+8x9dvH/o=
X-Google-Smtp-Source: AMsMyM7NYsVfYI5dAQa0D48MTMmaoDeXayNele7ewEzKiTK8cWeiczz9UX17n1oLButztQG5ptcs5Q==
X-Received: by 2002:a17:907:847:b0:77f:f489:cc25 with SMTP id ww7-20020a170907084700b0077ff489cc25mr1873073ejb.80.1666090311689;
        Tue, 18 Oct 2022 03:51:51 -0700 (PDT)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id e14-20020a170906314e00b0073d84a321c8sm7459550eje.166.2022.10.18.03.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:51:50 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	iommu@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: Always define struct iommu_fwspec
Date: Tue, 18 Oct 2022 12:51:49 +0200
Message-Id: <20221018105149.820062-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

In order to fully make use of the !IOMMU_API stub functions, make the
struct iommu_fwspec always available so that users of the stubs can keep
using the structure's internals without causing compile failures.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Hi Joerg,

this is a rebased patch extracted from an ancient series that never
ended up getting applied:

	https://lore.kernel.org/all/20191209120005.2254786-3-thierry.reding@gmail.com/

You had already acked this particular patch, so maybe you can pick this
up. I've seen at least two discussions where this was brought up again,
so I figured it'd be worth sending this out again because it can help
remove a number of #ifdef blocks throughout the kernel.

 include/linux/iommu.h | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a325532aeab5..e3295c45d18f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -173,6 +173,25 @@ enum iommu_dev_features {
 
 #define IOMMU_PASID_INVALID	(-1U)
 
+/**
+ * struct iommu_fwspec - per-device IOMMU instance data
+ * @ops: ops for this device's IOMMU
+ * @iommu_fwnode: firmware handle for this device's IOMMU
+ * @flags: IOMMU_FWSPEC_* flags
+ * @num_ids: number of associated device IDs
+ * @ids: IDs which this device may present to the IOMMU
+ */
+struct iommu_fwspec {
+	const struct iommu_ops	*ops;
+	struct fwnode_handle	*iommu_fwnode;
+	u32			flags;
+	unsigned int		num_ids;
+	u32			ids[];
+};
+
+/* ATS is supported */
+#define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
+
 #ifdef CONFIG_IOMMU_API
 
 /**
@@ -598,25 +617,6 @@ extern struct iommu_group *generic_device_group(struct device *dev);
 /* FSL-MC device grouping function */
 struct iommu_group *fsl_mc_device_group(struct device *dev);
 
-/**
- * struct iommu_fwspec - per-device IOMMU instance data
- * @ops: ops for this device's IOMMU
- * @iommu_fwnode: firmware handle for this device's IOMMU
- * @flags: IOMMU_FWSPEC_* flags
- * @num_ids: number of associated device IDs
- * @ids: IDs which this device may present to the IOMMU
- */
-struct iommu_fwspec {
-	const struct iommu_ops	*ops;
-	struct fwnode_handle	*iommu_fwnode;
-	u32			flags;
-	unsigned int		num_ids;
-	u32			ids[];
-};
-
-/* ATS is supported */
-#define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
-
 /**
  * struct iommu_sva - handle to a device-mm bond
  */
@@ -680,7 +680,6 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
 struct iommu_ops {};
 struct iommu_group {};
-struct iommu_fwspec {};
 struct iommu_device {};
 struct iommu_fault_param {};
 struct iommu_iotlb_gather {};
-- 
2.37.3

