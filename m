Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2E363C61
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007521; cv=none; b=BPQ+xq7W1XubABr0OL8Of0yxzcT9yrLBV0WTiKFuMdHKPoeTevV/hkCorkXyWRD+QqzZZ1MwoP7DE5MSqhcPychjxc8+aDZnSu/spK72qYgD/YcFTVwkUdCNp13iM0oUty0tdl/EEb4rqNKcFV9qWhAikg+kgnzyivy587PqCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007521; c=relaxed/simple;
	bh=0yNCf/FZmVdH7OxyVcTRK0azQYedr/GytLYxP6I0HHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OwRSKoy2YDMAObX5y+Fb/EZX7WOFXaonz4W2sEn7vnSmn77TUIGyr5YV72xbwxpjCV6AMsrIMR4jFIVuHysDwwQZyaC698dTqjyVtg9BcoiXQi1wW1r3itoYMrnIu+7vSveBA8KpE0xFXbjNLkM3nUBKlSRU9QjgSSS9HIfsH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UehXJjzz; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UehXJjzz"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-135f2aa4742so3728851c88.1
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 15:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780007519; x=1780612319; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnJY90lzCZa7sp51vCdlrsdl5wBeEKPOKUYIM3PKwp4=;
        b=UehXJjzzNBYSXL4qOZbrAF6Hf4dVFAxJVGL8E33wIpYXHQEqS2Vv2jxMbZd0fqVomv
         M80BS/QxOGHZQvCdanF/LaEDJEEV0Eti8TLdEEjuVpBXGtVMzvfminJ0ePvvDbDyDOMm
         Zwh+vB7hk/Xc5wZvlhpWEMfNpsWzIVWgIqAhxJl6QosBjK+DormrE/vntBeSN47BHf6N
         ffSQ+DN9S6BEXuRoy7jXAnO7VySaFiosnGzKd24zcqw8IKCPd3H3Yet1uFku5e5MoAhy
         mi+O4W25qWIaz6OedyrNszBqS8BA/UrnIPEsNXJ/lf+gvl7f7f/OvrmEbyZSXzl5vdJT
         S42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780007519; x=1780612319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnJY90lzCZa7sp51vCdlrsdl5wBeEKPOKUYIM3PKwp4=;
        b=DmUqy9WJAt/ugbQB+sgibUpWjR4B6WQyQb+E5/lLWVQgxKuvt8MmMjO5e1QIbQR0yo
         0ZbXvyjnndCxe8P15mkf1p+H1V4yy2lHUW4V4T/p09pirwcX6ISnjmHIhyOfEW4p1Iwm
         H1WfCqv3QOB5SMn+2vIKAs/mE19+Qo0E+KsaBjV/gIDqMOEqI9eVjfBh7dxAybJb5+QM
         UaDlOC7mYzxBYHNoGNfW44H4jNjKmk7WRrg+70ny6SeV13gD33Ralrk4aOJzHiDEynZY
         EH73MJdymqlNZYWoaLcyJ+/JxYHsa3XR28mImdtJuYnTV673fstX7i9TZgHcANHsJu0i
         MwUA==
X-Gm-Message-State: AOJu0YxOiDHIZqgdHCvDJUcra3Cy7yV8MHfyHqPC2FQ6+Nk3hEbtzXTU
	FFQVrTrT2CBWir7+9gLEIT9aVc3yP8hqJU0YcHFiWp7Z/kGDwEFb+4yilc7acBwnu3hfYsWaEQT
	LNjQ3V5sYt6PBR0eW0eNyDqmBsZVoi5Sveojd42hMC6yDSYHNf4FNyohOoSwHXYXnniNl7WTgKw
	ksGGAZfNIkl55I2p2nemd0AxjMnN0JuQ==
X-Received: from dlbrl13.prod.google.com ([2002:a05:7022:f50d:b0:136:f9e9:6d7a])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ebc5:b0:12c:856:ddcc
 with SMTP id a92af1059eb24-137aeff8d97mr118590c88.27.1780007518036; Thu, 28
 May 2026 15:31:58 -0700 (PDT)
Date: Thu, 28 May 2026 22:31:47 +0000
In-Reply-To: <20260528223147.750229-1-wnliu@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260528223147.750229-1-wnliu@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528223147.750229-2-wnliu@google.com>
Subject: [PATCH v2 1/1] iommu/amd: Don't split flush for amd_iommu_domain_flush_all()
From: Weinan Liu <wnliu@google.com>
To: iommu@lists.linux.dev, jgg@nvidia.com, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com
Cc: will@kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	robin.murphy@arm.com, vasant.hegde@amd.com, santosh.shukla@amd.com, 
	chrisl@kernel.org, josef@toxicpanda.com, Weinan Liu <wnliu@google.com>, 
	Wei Wang <wei.w.wang@hotmail.com>, Samiullah Khawaja <skhawaja@google.com>
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

Cc: stable@vger.kernel.org
Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM")
Suggested-by: Josef Bacik <josef@toxicpanda.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Weinan Liu <wnliu@google.com>
Reviewed-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 57dc8fabc7d9..15ffc4742183 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1774,7 +1774,8 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 {
 	lockdep_assert_held(&domain->lock);
 
-	if (likely(!amd_iommu_np_cache)) {
+	if (likely(!amd_iommu_np_cache) ||
+		size >= (1ULL<<52)) {
 		__domain_flush_pages(domain, address, size);
 
 		/* Wait until IOMMU TLB and all device IOTLB flushes are complete */
-- 
2.54.0.823.g6e5bcc1fc9-goog

