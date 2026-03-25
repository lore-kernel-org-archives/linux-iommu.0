Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C884239C639
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432003; cv=none; b=JiEgbJmhoc3VxMj6ZktJq0X/kPa6Xo9vKEvorp+VKVrRfIIwfzEB9G7lP35PwtBw35TvfXTYRacQaNfY2M0fkR+Dgl3fiKh/9vZNPUKHaKDZdeguSeUEIavE5lLkutVVdEQL6AJhW4PbQuoUuW14tqzo+xHz0kO7IBIQSYi45Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432003; c=relaxed/simple;
	bh=D30eCIvb3AS2mp3TMuS0c5ImF0yyZaJDzpl1i3+bvlk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lq9pJdbf1caJxn7pHXhUTd6960S4Y9VQDGMVguPv4YOrw2aGXBFVfmfwHq+afFeWdiVaj6O3mFxFa8SoWlUdi4NMXJxEUG62xyBwg7JSFuGtKbVlBO+MW78+1C+GD+jfaW/bghBHlEvUROf9iwc31ghkojb8QkUvQy1QCtZKdlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rocB1i/h; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rocB1i/h"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35c12a3bbb9so338125a91.3
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 02:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774432001; x=1775036801; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X59hae4gwcORy2r2X7MtKkGBLxk4A/gTQPYlJei+R6M=;
        b=rocB1i/hJk8azxytTKfQiIXVXxHja279E1S5aAruoxutt9OaGBTJB0RBmW+H/Nwx/8
         YybZTxyIHD6WyEhE1vmLnqrjJt62wCem3KZNxat3NUnvVd31OHBCO6buu/LsW/estzEP
         xDz6vWthhq9YOPTTIBxQ5f2eK6rCIt1WF47i+J7/wN4plqinylm32UpcwvOLUKA6uxWK
         mTEef+7xEgbAdAMpvCaKixtw6LaEyWHSbpXZCi08wmvdaFoWFrFaIczKonyLJ80hp4h2
         /2kLuTAJEdu4s/x9+fqQzOyF8fLd3o6ghl5eWL+PRrPHrbpaXLP2K0RVgStfXOtEqu8U
         cc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774432001; x=1775036801;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X59hae4gwcORy2r2X7MtKkGBLxk4A/gTQPYlJei+R6M=;
        b=AbgJMmws7i3x5u5wDOf5JfaMzrBS13wfvRMXsUgGcHAGYFEsTQaIfwHtd07T4LbF7J
         IatYgncPTHC4x7wLIswMjKo965svdpH8c5glHw42miRlhB8h+y9DhOJ1c//IQdR/GNKc
         szg7Sc2OiCnyEFvlqBrZYAxyCjJB5vp1D0hG2lix4P1ybTq8GkD6eOzrRhtHXGAVWlFJ
         bLBU9XdtenQAGTQRLiSM0rhdMtmJzfm4luRsmAc6c2B33p1RXIpwBOSp/CYizJj6q/ST
         TCixCDXWm2F+jTWmlIYVVJ9LCsUZs+PrzdkOgz5sPQKOZZlL9+oGl7n/urDCdo3Ro1ji
         mKrQ==
X-Gm-Message-State: AOJu0YwiFNHJJtvuLX+deGHVF9+Qk7FDvaxvPQNflj1aFuNIHY2U/lTR
	sOnoHeZ+IYFR6DWFXUO0LB+VPEs79mT7pm7a++oy7FICB1fSiuY8piHeYuaCE2JeVeq+pEte19h
	wBHgPkKUaqwcKazpz4GF3M9DFThbbNbwXVCaAE5ue8wBOD+U0rMr+V/K01FSos5eCdmE8fqrozT
	+grfJHhoUPzx8m4CDnGtMIC94m79KQ5g==
X-Received: from pgdf11.prod.google.com ([2002:a05:6a02:514b:b0:c76:6b47:4204])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e705:b0:35a:24f3:2c8e
 with SMTP id 98e67ed59e1d1-35c0dd01ee3mr2622725a91.9.1774432000840; Wed, 25
 Mar 2026 02:46:40 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:46:15 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325094615.2420522-1-praan@google.com>
Subject: [PATCH] iommufd/selftest: Add missing driver_ops for AMDV1 mock domain
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Soni <Ankit.Soni@amd.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>, syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot found that allocating a mock domain with AMDV1 format could
cause a WARN_ON because the selftest enabled DYNAMIC_TOP without
providing the required driver_ops.

Initialize a spinlock (top_lock) and dummy callbacks in the mock
driver to satisfy the generic PT requirements.

Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
Reported-by: syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69c1d50b.a70a0220.3cae05.0001.GAE@google.com/
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/iommufd/selftest.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 9607416f8069..960c5aee4a09 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -119,6 +119,7 @@ struct mock_iommu_domain {
 		struct pt_iommu_amdv1 amdv1;
 	};
 	unsigned long flags;
+	spinlock_t top_lock;
 };
 PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, iommu, domain);
 PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, amdv1.iommu, domain);
@@ -129,6 +130,26 @@ to_mock_domain(struct iommu_domain *domain)
 	return container_of(domain, struct mock_iommu_domain, domain);
 }
 
+static void mock_domain_change_top(struct pt_iommu *iommu_table,
+				   phys_addr_t top_paddr,
+				   unsigned int top_level)
+{
+	/* The selftest doesn't have real hardware */
+}
+
+static spinlock_t *mock_domain_get_top_lock(struct pt_iommu *iommu_table)
+{
+	struct mock_iommu_domain *mock =
+		container_of(iommu_table, struct mock_iommu_domain, iommu);
+
+	return &mock->top_lock;
+}
+
+static const struct pt_iommu_driver_ops mock_driver_ops = {
+	.change_top = &mock_domain_change_top,
+	.get_top_lock = &mock_domain_get_top_lock,
+};
+
 struct mock_iommu_domain_nested {
 	struct iommu_domain domain;
 	struct mock_viommu *mock_viommu;
@@ -445,6 +466,8 @@ mock_domain_alloc_pgtable(struct device *dev,
 	if (!mock)
 		return ERR_PTR(-ENOMEM);
 	mock->domain.type = IOMMU_DOMAIN_UNMANAGED;
+	spin_lock_init(&mock->top_lock);
+	mock->amdv1.iommu.driver_ops = &mock_driver_ops;
 
 	mock->amdv1.iommu.nid = NUMA_NO_NODE;
 
-- 
2.53.0.1018.g2bb0e51243-goog

