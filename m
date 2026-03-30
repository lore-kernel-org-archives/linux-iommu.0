Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AAE40DFD9
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774862790; cv=none; b=YviOH4YBk5h1c/+TfxJU99mRIfx2wMntC0kyHvSdVeprjjFtH/E8buCt6wCZ/5hzV82kfyVtHZvviKDLq4pdDBp+gxHzmQdyWiLDZHTqNqlJYYafplxiV96BJzOQ2GFp4kM4ch5cO5CVM643O6xJwyZ59+u4DWV4Qp9WmZCEoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774862790; c=relaxed/simple;
	bh=WyayJ7lBs4A0AjgHfkB/hEea4VKcZyW1i6Ewy3RCz3o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JijBJfgfZqWyZsIVv9mSIXh6B8H/4Buhps/dqyAcdLgb0KaFWrT9chZ0FtlDf41vkekhrO76UpmKvyuWZyYbnFtXt7bpx812va2KKIDQxuLodKaeO504UBaVXeif+lqOjXYMDsiR5owzOvrIQ7I8rna5AzXUAHapV+t1lAZLqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bktBgS3y; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bktBgS3y"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35842aa350fso13460805a91.0
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 02:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774862787; x=1775467587; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0j5FctnpxecX0fL9t2t6bwZdIzsk36KDPfQXwQnaIg8=;
        b=bktBgS3ynYeNaD5NTokWI5Wzdft7ADx6kD5F6M/75vepUiFrAC/whGn+sGEh814H28
         Gv2Kfoe9IIeuKUIAQStBs04rUtRpIX+BlPvhKReXkX+oWuAqV3oAKG+KnCc4jjF8iTFQ
         c+gqkQyS43UKd8uVV2UJQtveFdS5tX9P1imPqNDLOyyXP29ds1OlwBQ/wYHXff7nHqMB
         +z/gcz0I3k9/kQKuBWaSScdOArbDZInNGULESVj3GoQiVL9ubplgkpFVZV48+pZbOMbO
         zI9FL4t4VrKL0rFj9kGtPJCO2eYu56Jtv93bvRk7BTHUbAk9kDW5KGMQT/HfFXJsGH8Q
         hTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774862787; x=1775467587;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0j5FctnpxecX0fL9t2t6bwZdIzsk36KDPfQXwQnaIg8=;
        b=QeWsedFNzw4aHXQOe96OWx5sQ8xDV+mUinzESurs/+1++Yxf+d+oWF6/+W1QG81k9k
         d2sxTxqyYzwK8aPIGLf1ekkfutb8SXXH7qf+RJVv77l61hXUWwPnJvfjIO22AwbaRIKP
         +avxA78glDgj9Okmdre7WmsbQtD6jeCsKX/fmFb97kYuo4TmOp6n8HbJSfmV3sHuBpuo
         I1f9cNdEnggC7sGkRzoa2aBYbI85b5SOV1DLpMj4Bk7j5CbQSZEgGOvC9Pf2Td9divqS
         LOi6rR36TKPP/hM4Ffd7jVwMNG48m+0KUQH1cV5T/IQ0wAH5RxMmXfqNFS206dvK0OtA
         ME7g==
X-Gm-Message-State: AOJu0YzgFI07hi50mxBhturhTTkVYJKCq4rM23C0LwpGSGtXicJF6XC2
	y6e1tlh0pDq5FYtJFyX8pLJ/T69NjCr98TYTryvz53D/YimM8b6wgI+9FymjJn2VTtXAYNy+SSr
	0MZd9NJ3ny8HbXyMrgqjmhXGwMiJEnScjAH5aSisEUcXM/9K4TMG1wQCjIbhg88485PhyTF1UoL
	jtY8dhkdEjyvgztvGdaXRQo3/IfAfgEQ==
X-Received: from pjbmv13.prod.google.com ([2002:a17:90b:198d:b0:35c:222d:ee46])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e53:b0:35c:8ac:ef74
 with SMTP id 98e67ed59e1d1-35c2ffafe42mr11665027a91.6.1774862787202; Mon, 30
 Mar 2026 02:26:27 -0700 (PDT)
Date: Mon, 30 Mar 2026 09:26:09 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260330092609.2659235-1-praan@google.com>
Subject: [PATCH v2] iommufd/selftest: Remove MOCK_IOMMUPT_AMDV1 format
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

The AMDV1 format in the selftest was a placeholder and was not actually
used by any of the existing selftests. Instead of adding dummy
driver_ops to satisfy the requirements of a format we don't currently
test, remove the AMDV1 format option from the selftest.

The MOCK_IOMMUPT_DEFAULT and MOCK_IOMMUPT_HUGE formats are unaffected as
they use the amdv1_mock variant which does not enable DYNAMIC_TOP.

Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
Reported-by: syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69c1d50b.a70a0220.3cae05.0001.GAE@google.com/
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  1 -
 drivers/iommu/iommufd/selftest.c     | 31 ----------------------------
 2 files changed, 32 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 73e73e1ec158..52b78cbcc920 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -36,7 +36,6 @@ enum {
 enum {
 	MOCK_IOMMUPT_DEFAULT = 0,
 	MOCK_IOMMUPT_HUGE,
-	MOCK_IOMMUPT_AMDV1,
 };
 
 /* These values are true for MOCK_IOMMUPT_DEFAULT */
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 9607416f8069..af07c642a526 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -421,19 +421,6 @@ static const struct iommu_dirty_ops amdv1_mock_dirty_ops = {
 	.set_dirty_tracking = mock_domain_set_dirty_tracking,
 };
 
-static const struct iommu_domain_ops amdv1_ops = {
-	IOMMU_PT_DOMAIN_OPS(amdv1),
-	.free = mock_domain_free,
-	.attach_dev = mock_domain_nop_attach,
-	.set_dev_pasid = mock_domain_set_dev_pasid_nop,
-	.iotlb_sync = &mock_iotlb_sync,
-};
-
-static const struct iommu_dirty_ops amdv1_dirty_ops = {
-	IOMMU_PT_DIRTY_OPS(amdv1),
-	.set_dirty_tracking = mock_domain_set_dirty_tracking,
-};
-
 static struct mock_iommu_domain *
 mock_domain_alloc_pgtable(struct device *dev,
 			  const struct iommu_hwpt_selftest *user_cfg, u32 flags)
@@ -477,24 +464,6 @@ mock_domain_alloc_pgtable(struct device *dev,
 			mock->domain.dirty_ops = &amdv1_mock_dirty_ops;
 		break;
 	}
-
-	case MOCK_IOMMUPT_AMDV1: {
-		struct pt_iommu_amdv1_cfg cfg = {};
-
-		cfg.common.hw_max_vasz_lg2 = 64;
-		cfg.common.hw_max_oasz_lg2 = 52;
-		cfg.common.features = BIT(PT_FEAT_DYNAMIC_TOP) |
-				      BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
-				      BIT(PT_FEAT_AMDV1_FORCE_COHERENCE);
-		cfg.starting_level = 2;
-		mock->domain.ops = &amdv1_ops;
-		rc = pt_iommu_amdv1_init(&mock->amdv1, &cfg, GFP_KERNEL);
-		if (rc)
-			goto err_free;
-		if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
-			mock->domain.dirty_ops = &amdv1_dirty_ops;
-		break;
-	}
 	default:
 		rc = -EOPNOTSUPP;
 		goto err_free;
-- 
2.53.0.1018.g2bb0e51243-goog

