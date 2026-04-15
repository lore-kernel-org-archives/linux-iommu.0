Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568C27380A
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776213051; cv=none; b=P3XGeNguFflDfo4oI0O9cQuB02dvF0i9Ju629fVC2ga+8uJzjT94Gk0KQx/A+cUnUgf6PiSnnN8t3GrXc0ts1vaGtbTsz29/vZfslCocydRn7brA7auizjuIOH8bXFPTlDODGdWMsr6SKCwQOWkxiU8USNgQ2rr5KPKk/dceACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776213051; c=relaxed/simple;
	bh=4QIHhaYvQeqd4SCqWbcn2NXcFstxy0WpPz+e0WHFqm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cMfiateNpOVo9h9HeFh8hmFB9sq+Hmurx4EuQ/1QWHa8HhR7qg6dmD4DmOFSLwdupTl4Bkk7y2tJSawl/K/VzKBgczHDwRuvkeeifLd5+L4yW9tVudQzZaeZvRp0j7RyZSJs9G+TgnblYiJxqI/nz2FT088XQGuqv3AwlzHgPtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFQ0Mk4v; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFQ0Mk4v"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so7473071eec.0
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 17:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776213050; x=1776817850; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YMLgHyiyy1osxN91w+mnNI6INa3KW+6aqAREmJjXk/w=;
        b=AFQ0Mk4vbLkk6y5dBp1O8i1SdFZXSZgYFgCR8XThOVbHxEJQuWT2g6rOCKuh21MoHJ
         UEFVbE5A7qoxfiSTFskWm2101kUo8HjgHvcmT0WVhMEWZLgFh326YGHRlQjiOS1268UA
         GdCLvW2mBEbjaCdDO6GDwNDhPgVDz67Dh3uT/9i0iHlf+k81dJuv6zKza3uDEnvIABcE
         2msIUcfjCDvAbxmvTG64QP3dYr8FCQ2nKTD7lJvTyY94EK5wzhWNgkm7/JEpep4ofBXk
         mV0vGJLWzyDrXmtGHz7eL/GT7257U6LL0cWXGa2CTp1CaabalYBG3JXWZkACoDtkzNyE
         W/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776213050; x=1776817850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMLgHyiyy1osxN91w+mnNI6INa3KW+6aqAREmJjXk/w=;
        b=VtLXwrNQY+sQAcmnQyZhqZ1/5FZpb294vSzxFJeOByhMdUc168HBvNnG44aBGQYa2g
         khybOWuOFtqVcEeUL2BCKxFGbB45HcBX3zVbYP2+gtaszInYEx12Q0ry05Yp/AprPQ7L
         Li+FsQRHVInOps1lQ0ZJl+CVVMKZ5qeKC+IGxfuF+ApWmBh6Em2bu68bMkkwGQhVsw8t
         AxOz08qXCRZZibcd+D+B1epmtTMopWKnbRACt+Bt6WWyjwhZ+KBsiDmZiaoI68jhG4ED
         VPJtSZ3s0fsMI9MZxxfyS2WFi96M7PTa5SSRBnOVD+8Yjd0541STjZCgwlvfC/+KKoz9
         cpvg==
X-Gm-Message-State: AOJu0Yzh1wwyiVbXmS8U2jciamHoid/Unc0hR72Rr7u6gH5BM7Svjg54
	+kve0UsJojUCdKL2vuzmnQcwHUvbwsb+9GxHYG7iSAIaFSIszPn2dj8fU1tGQgJ0Zm6mJ4SK6Y3
	X5w==
X-Received: from dybor13.prod.google.com ([2002:a05:7301:1f0d:b0:2d8:4599:1d20])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:72ce:b0:2d8:71c2:255d
 with SMTP id 5a478bee46e88-2d871c22a7cmr7184966eec.14.1776213049366; Tue, 14
 Apr 2026 17:30:49 -0700 (PDT)
Date: Wed, 15 Apr 2026 00:30:46 +0000
In-Reply-To: <20260414233607.GK2588311@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260414233607.GK2588311@nvidia.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260415003046.2275802-1-wnliu@google.com>
Subject: [PATCH v1 1/1] iommu/amd: Don't split flush for amd_iommu_domain_flush_all()
From: Weinan Liu <wnliu@google.com>
To: jgg@nvidia.com
Cc: iommu@lists.linux.dev, joro@8bytes.org, josef@toxicpanda.com, 
	kpsingh@kernel.org, patches@lists.linux.dev, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com, wei.w.wang@hotmail.com, will@kernel.org, 
	wnliu@google.com
Content-Type: text/plain; charset="UTF-8"

We have observed multiple full invalidations occurring during device
detach when we are done using the vfio-device.

blocked_domain_attach_device()
  -> detach_device()
    -> amd_iommu_domain_flush_all()
      -> amd_iommu_domain_flush_pages(..., CMD_INV_IOMMU_ALL_PAGES_ADDRESS)

      	while (size != 0) {

          -> __domain_flush_pages( flush_size /* power of 2 flush_size */)
            -> domain_flush_pages_v1()
              -> build_inv_iommu_pages()
                -> build_inv_address()

         }

build_inv_address() will trigger a full invalidation  if the chunk
size > (1 << 51). Consequently, the guest will issue multiple full
invalidations for a single call to  amd_iommu_domain_flush_all()

Without this patch, we will see 10 time instead of 1 time full
invalidations for every amd_iommu_domain_flush_all().

Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM")

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Weinan Liu <wnliu@google.com>
---
 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 760d5f4623b5..59650a44ab50 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1769,7 +1769,8 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 {
 	lockdep_assert_held(&domain->lock);
 
-	if (likely(!amd_iommu_np_cache)) {
+	if (likely(!amd_iommu_np_cache) ||
+		size >= (1ULL<<52)) {
 		__domain_flush_pages(domain, address, size);
 
 		/* Wait until IOMMU TLB and all device IOTLB flushes are complete */
-- 
2.54.0.rc0.605.g598a273b03-goog

