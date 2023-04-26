Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C9C2CC
	for <iommu@lists.linux.dev>; Wed, 26 Apr 2023 20:33:00 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5560116959fso68051747b3.1
        for <iommu@lists.linux.dev>; Wed, 26 Apr 2023 13:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682541179; x=1685133179;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MsgPsrUA7pZr2poVzmEsLw5CPMy5beCZQnaEI4bsMpM=;
        b=7ktCRMMXoavpPo+oNTHeDKKUE2nqiLnaUL0Jez61kvhTdEzPAgY8c1dYCLPFVJtNRi
         o1DulXO9gD+Xp0GRoZUnkFK0T7HZ/WfLMpHP3P54mLE7Zmh7a7IjFshrDUqbWrHPC4UY
         cYKUojkhCq07wF45ihjARmMr2sp+yrq/CgxnZsU9rBoHVGmbia8wHhq+W7NxaIbTxd7T
         ARNxmVD2aVEJm4OQJG3ycIGd/vDp965VXtQPCWTR/5urg1B6JByEbdsUctVLFB906sri
         RZofaQPIYN0eZo9ETpL5eBauFErEy5zTs/eji8Edo2r/ykhhSUtXqr8tKcAAa5p6yEcK
         Cl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682541179; x=1685133179;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MsgPsrUA7pZr2poVzmEsLw5CPMy5beCZQnaEI4bsMpM=;
        b=TxkJYPCsGYBuSBRsPYKZ0nGJUnXjcq4iUPUW4ZXopJAbI5ELELluF61pWigoJ3NseW
         XD3oivVO0hFzFD64YW5dnLDjb7pSco5k23VyN1SZKhOjON+gNceYCiMazgNgMtV6biyA
         1ACGFcnaj/0U48mlXU8wt2E8HFVO1zqSkI5FGbX+JEeP2f25vvKrTaJvgQtCyqa7p1Bm
         jsmYhka+ZnbXH2NQnoHCHXQyMMNf8oPEfuhHshl07pHgUPNKcfGRzv2C7nYVy5QDzXlj
         a3/C+Ax0817k3VYVh6mR1dMqQnk0Hek9zj3Bs8qIgxBAuHiqfykGbCPQ1Gu6MlyxLdZJ
         K6RA==
X-Gm-Message-State: AAQBX9cyD+RL1DyGGSmmLjOuUHw8WB+upHlx1YyKszmLUxAhuaegEDsv
	ftfscVfw6lGPLRQ8UkuBc2arpyT0VSY=
X-Google-Smtp-Source: AKy350aDwcz+0RCf2miA99jakkRJFi3cWpYYZ10pS+QEGUbpo1c7VFj4UdHoxewp/Jy2APK3HEbhinMt4+s=
X-Received: from pandoh.svl.corp.google.com ([2620:15c:2c5:11:cf46:dfd0:d5c4:864c])
 (user=pandoh job=sendgmr) by 2002:a81:450c:0:b0:545:883a:544d with SMTP id
 s12-20020a81450c000000b00545883a544dmr10795000ywa.9.1682541179541; Wed, 26
 Apr 2023 13:32:59 -0700 (PDT)
Date: Wed, 26 Apr 2023 13:32:56 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230426203256.237116-1-pandoh@google.com>
Subject: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
From: Jon Pan-Doh <pandoh@google.com>
To: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Nadav Amit <namit@vmware.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jon Pan-Doh <pandoh@google.com>, Sudheer Dantuluri <dantuluris@google.com>, 
	Gary Zibrat <gzibrat@google.com>
Content-Type: text/plain; charset="UTF-8"

When running on an AMD vIOMMU, we observed multiple invalidations (of
decreasing power of 2 aligned sizes) when unmapping a single page.

Domain flush takes gather bounds (end-start) as size param. However,
gather->end is defined as the last inclusive address (start + size - 1).
This leads to an off by 1 error.

With this patch, verified that 1 invalidation occurs when unmapping a
single page.

Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM")
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Tested-by: Sudheer Dantuluri <dantuluris@google.com>
Suggested-by: Gary Zibrat <gzibrat@google.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5a505ba5467e..da45b1ab042d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2378,7 +2378,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
+	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1, 1);
 	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
-- 
2.40.0.634.g4ca3ef3211-goog

