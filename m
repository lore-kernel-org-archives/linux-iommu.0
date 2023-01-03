Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1236436E
	for <iommu@lists.linux.dev>; Tue,  3 Jan 2023 06:30:27 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id w203so3258774pfc.12
        for <iommu@lists.linux.dev>; Mon, 02 Jan 2023 22:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IH4BnFmj51xja43rQ2VjV2A7Vl5bq18SZUAgL2EcwnI=;
        b=TG8uvyWlWw/f/acMw9cbu5au61WMfhj8SQ7FwLvxR65sqsYZBrZeJ84HJaB1uTlkJL
         NjKW3hoU0GcIiCuaxhYad+YSh6y8IxPDZsTYtz7rjBw5PGyuCpsS6al8/MpbgN0ZcJLJ
         f88f2MFNLsumloslDC9abPso5qnjumuUgJm8gVlEsK/WS9uv28IZhOLXdwC54bcSLGsx
         PqxZZ1FK2Lacldkq5OtLbraJqwV9ht6pZiE6vLz7JKYvU0RMFEvhq/nSEVE+5hmPHNvl
         874ZBFtjftFatmgPEAof5bKW7H8DotegkmfFt/Hnwa6ydCivHzy46tLoyJTNJaFjfLWZ
         zGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH4BnFmj51xja43rQ2VjV2A7Vl5bq18SZUAgL2EcwnI=;
        b=xqMIgDP00PbPfcP3bYAqhLwD1/F41gxOw5JyHSjle04vEKW44RKFIIikI+RWdefbvp
         fC4f/2c9bu57zFqUc5WBZAHSYQvK4brFZToA0Y51vCaOPl601qNuKN94W4TV2Zm5t2Sg
         +1Sijaw6pveyoS6WTwLSCuUxLLr9l1YcsIk5I1knLDhupBx8MGXitv8eZck/bi97/0C7
         ZVfmo4/ylK9Hxl73ivrqG66wsTPwapeVkCY8HNZhB9U3OEuifnXy4AMA//x/t111CDv2
         EBfYdyxk4QgpolmzirIKQcmsrqL37z8y9fyNxnwgeJKgMnNmA1ICHb3C8w2+3qXGGBLT
         WEtA==
X-Gm-Message-State: AFqh2koEyOslzedaN/zqAQup+bb8wvZVQZ795I189sq+P6bZlnGcw6PW
	Ir7+bTiIBxz64p3BKgEAfDo=
X-Google-Smtp-Source: AMrXdXuB8TRSOt5N1YqvE+OSqTWyWFvhKTUMq1KEyXVklZBiK31z6i7whkRLrLYws9KRNGMhpo6u6Q==
X-Received: by 2002:a05:6a00:88a:b0:581:19ed:78b9 with SMTP id q10-20020a056a00088a00b0058119ed78b9mr38707011pfj.2.1672727427390;
        Mon, 02 Jan 2023 22:30:27 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id i127-20020a626d85000000b00581a156b920sm10418848pfc.132.2023.01.02.22.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 22:30:26 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] iommu: Fix refcount leak in iommu_device_claim_dma_owner
Date: Tue,  3 Jan 2023 10:30:17 +0400
Message-Id: <20230103063017.4022393-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_group_get() returns the group with the reference incremented.
Also an empty @owner is a more serious problem than refcount leak.
Move iommu_group_get() after owner check to fix the refcount leak.

Fixes: 89395ccedbc1 ("iommu: Add device-centric DMA ownership interfaces")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- Remove set NULL to group as suggested by Baolu Lu.
- Update commit message according to Lu's explanation.
---
 drivers/iommu/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index de91dd88705b..5f6a85aea501 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3185,14 +3185,16 @@ EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
  */
 int iommu_device_claim_dma_owner(struct device *dev, void *owner)
 {
-	struct iommu_group *group = iommu_group_get(dev);
+	struct iommu_group *group;
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

