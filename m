Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536077E
	for <iommu@lists.linux.dev>; Fri, 30 Dec 2022 08:31:32 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id h192so8963487pgc.7
        for <iommu@lists.linux.dev>; Fri, 30 Dec 2022 00:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPSc5CLczFof6Az09YQrNvJzlEU7+w21O5dXtl4mqyk=;
        b=lMGhHsMvJXqUL1WfSWtNrtoqQ6vbQ8zSMbNi4ZfLr6yGd+iI9hh2xm4OY8u6H0Go1a
         CRiG/cfzwsPXQBIKH0SNonLyEto/TmbUZtxEFKTtqIYL66ODBGy0t4WXObCEICe3kDGR
         8YRC4yRX/fhYyCflh9NNuUvujL/14pnsIISl0GQerrQRob8bRGlyVcutFiYh9C8KUjdL
         VbiLNF1sse3ZJoGI/Wvw+ZNu4HUap0FfEfHaBX1uNsAkyuEZSVgQ80sj1Q3YLo7rgnLo
         xZ2pxM4v2cGvbNPgTPF/11XWj/vW70W8z/kP3EnBjVJB+hw4e4VGS+OM3TbIkUvvuOIF
         EvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPSc5CLczFof6Az09YQrNvJzlEU7+w21O5dXtl4mqyk=;
        b=Ct99gSMbKXEJh11E9mmaTncLlmIHEjJjUG/Oz4NtshXLRNsUTNJIq8oa02Jn887uLV
         N1NhWzGJxfQTyoQVAi78CjZ88e0B9aNzpVaVQ4xBjoA8zowapv04VYF4IxcPkDWg8CIu
         DCkMJZIRqSa0BG9x6CZXr+H+f6zHEou0KxXATSNrxO6ePTN1JNFo22OGKnzaOHJVvjir
         Rj8uIc4lxwv7kXtnYvFzT+bXBwaF8/7Wvg3ORgYVOpKu+LxsQPsvq5qq1tP+xNn1Nc0e
         XdfqFO2mdJYRw9SARnan9/k3d11Q150pVtB3NQTKMJO4VOrqRP+/lNqlH8hGcXdXkvcX
         Xjsg==
X-Gm-Message-State: AFqh2kpBJ3c6Cu/bzd2YuGVD6oH8VnfU+N4FFzaCACcVbXmYgoJjDHay
	LBfzfDTX5MH0wGZwaBA6aSI=
X-Google-Smtp-Source: AMrXdXtJsKuFq/yA8finz6BSFXjWdGZhmxoS70wa6aAQdiMsdDW7v9DTz++wMC4LjcQsJ/9B8bgXLg==
X-Received: by 2002:a62:404:0:b0:581:91d1:3cc4 with SMTP id 4-20020a620404000000b0058191d13cc4mr8260380pfe.7.1672389091733;
        Fri, 30 Dec 2022 00:31:31 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id 68-20020a621947000000b00580e679dcf2sm10182227pfz.157.2022.12.30.00.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 00:31:31 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] iommu: Fix refcount leak in iommu_device_claim_dma_owner
Date: Fri, 30 Dec 2022 12:31:00 +0400
Message-Id: <20221230083100.1489569-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_group_get() returns the group with the reference incremented.
Move iommu_group_get() after owner check to fix the refcount leak.

Fixes: 89395ccedbc1 ("iommu: Add device-centric DMA ownership interfaces")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iommu/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index de91dd88705b..3a7dd8b61fab 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3185,14 +3185,16 @@ EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
  */
 int iommu_device_claim_dma_owner(struct device *dev, void *owner)
 {
-	struct iommu_group *group = iommu_group_get(dev);
+	struct iommu_group *group = NULL;
 	int ret = 0;
 
-	if (!group)
-		return -ENODEV;
 	if (WARN_ON(!owner))
 		return -EINVAL;
 
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt) {
 		if (group->owner != owner) {
-- 
2.25.1

