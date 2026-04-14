Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E335E921
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776200800; cv=none; b=jrmefgBsLXwAeA7Y5F2uzMGQQ0mbwF2BmXMmxcAhX6bn/cr9D3pWXVtwcVvD7Nf/j9m1aqx6ITOtptOAilXPl8mngiPsGv4M7bcXBbgJFKrrvDS3ScNk5EkfrxbAT/JgBGMnBEMq8WZu7p3QAX7bPJ1eDeN2Cs4FMwUE08eV6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776200800; c=relaxed/simple;
	bh=LsvN4Iwj4LpN4c4Tw/gYuHJNYBRDPuQyJDiYk349by4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q9i7uX9wF8ww9Q4EwA8jBbLR0bZ/ZLkjDbEET5097Cwc+KlxznyzrjXcFVKf+h05PYDcCglEbTkrKYsnJ5hIykOtUU5sgrRic6nNn2SISpxzQub5DNEB2kNXrUtoDlnSqyXrJArfHDLZUO6yqWhID0J06KOk+0IENnrvclxUt7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wSHx2Wzj; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSHx2Wzj"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ddd8ef5343so1056803eec.1
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 14:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776200798; x=1776805598; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIiB47+xae8QQS2k1R5QxVK+78ZtZ1GfH0fOqq7eBOY=;
        b=wSHx2Wzjcc4O7l7h4o1bTDbaha3d5tPl+bXZo3OZDN4wd+CcLZfrNE076QfFFNS5w/
         CDyGYWyYMOz5BGXDFFx2OFEp8OQJMTbFW8np13VSCrEkjfwtSOIQoTnl/f/wakRVukjY
         TYFiPe27QmPV/1SdpnK6SsxyTQJL3HldldN+50/7CHRqDeW5F9y+T67oRpgcjS4I5rd5
         PJa47iMChWI2QJhmJg1TMgjYkhoANkbUk1vHubM/LE2ghXy/jtJhiJO3Qrs/D14Z0Lp/
         Su2CWy5EALQhlrXxHtYtdxcFvTfoosBaLUqvuseH4psEP4LcNwd6oZKdtHE4rPMgN1IB
         lcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776200798; x=1776805598;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIiB47+xae8QQS2k1R5QxVK+78ZtZ1GfH0fOqq7eBOY=;
        b=flhoSGCrEWtkmAZvlBvw7p6uu9AWyGGtgClrkAdrWo2aFDOFkDOzSwKca16nBvrV3T
         MDXsWlpojclIOvPLVVQpFmI/jEi8kT7l2g9FUztK+xnOUIN0mz/ZDB5l6eXiGlaqwebf
         03LuPB//SOA0qJOQVqMZdKOCBB+5as/HDn6yj82qv+cqGjDYnDu8DVYzfoJySv8ysIWQ
         G93N8NQpvXO3s8mYRft1LBSezs+Xfj0bL2+HpWlHi76Orn7Po7K1IyN/bFLcc2ABZA+y
         XDmon/oLNzJab2NCI9SMvt/cz7iZpvSgOxAVLY9pWgGuF291kqV1ZHCBhotVi43OoWd6
         NKQA==
X-Gm-Message-State: AOJu0YwqlOIVBp54a0KBOL22B6EMVLDeq636lJ7aSUsGELwcBtv1Woc/
	GHCyu5MfHR5Rrim+dd5kOpxwD2rQoCbzo+KTZ40A3wmY4OSTo+IrqqMrNTXDPBIIZGJvzCmG8+Z
	5wggqITKK6VMZoN0YxAKr/to3VYM9u9ISJxQHTltElbCZgZ8jeGw3am75xFJ2Sc1V/GOOjULaR+
	sTYpfa0G8wrMcwbrn6FNepJoBgBzYYOA==
X-Received: from dycnm7.prod.google.com ([2002:a05:7300:d187:b0:2d8:fc66:cd7b])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5787:b0:2da:10f0:a8df
 with SMTP id 5a478bee46e88-2da10f0b2e4mr4603827eec.12.1776200797666; Tue, 14
 Apr 2026 14:06:37 -0700 (PDT)
Date: Tue, 14 Apr 2026 21:06:26 +0000
In-Reply-To: <20260414210626.2097722-1-wnliu@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260414210626.2097722-1-wnliu@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414210626.2097722-2-wnliu@google.com>
Subject: [PATCH v1 1/1] iommu/amd: Don't split flush for amd_iommu_domain_flush_all()
From: Weinan Liu <wnliu@google.com>
To: iommu@lists.linux.dev, jgg@nvidia.com
Cc: joro@8bytes.org, patches@lists.linux.dev, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com, wei.w.wang@hotmail.com, will@kernel.org, 
	kpsingh@kernel.org, josef@toxicpanda.com, Weinan Liu <wnliu@google.com>
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
index 760d5f4623b5..bcec8721d228 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1769,7 +1769,8 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 {
 	lockdep_assert_held(&domain->lock);
 
-	if (likely(!amd_iommu_np_cache)) {
+	if (likely(!amd_iommu_np_cache) ||
+		size == CMD_INV_IOMMU_ALL_PAGES_ADDRESS) {
 		__domain_flush_pages(domain, address, size);
 
 		/* Wait until IOMMU TLB and all device IOTLB flushes are complete */
-- 
2.54.0.rc0.605.g598a273b03-goog

