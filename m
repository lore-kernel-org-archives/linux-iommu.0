Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420C49EC78
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463946; cv=none; b=SwQsknVNoYbfLAr88T0NcVL0L0pwsmZG42qau0u/71QweqqL3hRFpAoIkst+aBTu/jGY7pdQL0vNkK0Sv3Bj8xqBLE59AggFtamhvHh3exzfPNZk2EfK/zryDkCce/TTdNBf4Lz+JG3GxJ7SuUMlv3yBmoiE80QuxtPj0rgx4eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463946; c=relaxed/simple;
	bh=InKd0aGfeFCx3LdYyd/roSH5k1JSRlrS3BGElWrnj1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qov9jhFpPVVLi0eDD9skY9awZdKjdXmR8QWlswQ6Mte1Z9UEikXzLROqFiguv9g7q25cE0k5FJri7wE7d35MPM5nkrWbZqOl79f6Ivc6xiBA8YwWfMlugBULEqLYuVYDdru9ZyoXXq+RAr7kEbNHjSfVsbQVMc0VI3YgcTK5o3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sDrslYJV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDrslYJV"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so21436895e9.0
        for <iommu@lists.linux.dev>; Thu, 08 Oct 2026 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791463943; x=1792068743; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vFDGRaN1e/ydGZumamNoz8kHvK8qVk3vu4oV3GD+iPM=;
        b=sDrslYJVCK0K12f/Kpo6rTXqStNZhDDpdwQ/qpw94HkQIZG0LoDqjq0cSi+JHBIHqT
         Rp3krfqA2mOXVvvrLlFtVuRtWEvHLJJhvQUlvtUadaoZ0wwK1glnb4nixhumZarFzk0E
         8JMAoqQrbkxu2jJ7HBZUmC1/VP6P5VcLAbAqFaAPABSaFRirt9BaqrHLp+06sn0a77ss
         YatlyHmR+RFz90+B49kAH4lQRy5JVFihHdbvI9LkB56DAlTF1eUBsD82jCHPN51FsvZs
         wMJhBdw24l4MbZsgKzRBiuq9w3R0n9UZY6/i8HU53FEzcMV66xL8ETlNWgqC8R/NAncq
         31/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463943; x=1792068743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vFDGRaN1e/ydGZumamNoz8kHvK8qVk3vu4oV3GD+iPM=;
        b=HKSCN80Gqh/Y5OBiSFGfmepqBJ1sfsGVI8T3mVJbGC+fARzohhjA/6rRPliRFyQhRG
         jzZz92feFqLPhfvWUHdEF3rmRffPrC6gMVA4RjFx/GvvN9w9iFaeD3ggHsS7y2qxlT4k
         G4akFa+TaZQcrI+Vw/S6v8ZaZLzHSJa44uUVVZbHQ927XHb7Wx7FAsNKInxrpFgoy71m
         G81AWBUAmFCMiWqxqyJHPIcDUi2hgY/aT2fi1t6A3HaMq6hq8XRbpvDFaDn4GqHZTkcw
         5T5MsVep+mtLnG6wqHCYHt5pDFdDFe3YSJLnODVNz6zQhkBkJjKhTnQyGZNGPjHjgJOX
         51QA==
X-Forwarded-Encrypted: i=1; AKwUvBwHc/KJuHJ1SHAtB30L9/UWZSA+x/DND7OCQd9GDcV3TPqsw+rKZviGUO6UGVJGCgtFJ4CAow==@lists.linux.dev
X-Gm-Message-State: AFuF++kZeMuvWAAFWXE02iiNQDZl8PttE+Zq+ZDDAx2VPSPImSL37cIV
	QR6ykEHMBJRGxo2VwZj1k5Ej01kgsF7tp+pZk3HCLrkXrKsHS3SgTbq0
X-Gm-Gg: AYBFou2rPKEsOQ8D1VLByqKzKSoTi6zkgGJkNJp94Yvm3Htg4Gr6g1rcOQArIEr80to
	y+Hpz51y3jgwWHAFIUbJSFex7URJCmA4ikLUHlaKgxy0UNGJ8QETSThWDrcdq1XHOeSG9BMxFXd
	W4gQad3KglOh+0sLX2aJEmMpKZwPblIlZ2vcjomc7K6c2eJp6z8jFPyWmTT+zdXCL2se10Y/2rb
	wdTgXV9e+9YKtfi8nXUAK9Gu5HoUVNwMVt2QnbYXMJ1GkXEW16Ib7Txxo3/Mmw+UMcLC0iPqpXL
	sExXruvWwqq7A6wI66rZQGeFYd5vx7gj6I0QjqwKxx/gj8m52SWKtWMwibrWdoSXcaKD0P3ie7z
	+iKcHprVKcAB4TUTxGdir+wtQc97dZN6WsIY+N4yQnoWGDBMn20++bED5hyACebcSEJ9nmdJ0cx
	dVxxVtSNrtzLEg9qNTrccg1ifQrUs6FvhXobCRw1b85SHz+ArpgbFbr7F6+QJaL9r5y977JzlW6
	oUWQ/YzlYcEX+4pu1Qxm5+ECjKGoXan/sfqCzyLPXUb
X-Received: by 2002:a05:600c:524c:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-4a1802f632bmr93922995e9.14.1791463943266;
        Thu, 08 Oct 2026 05:52:23 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.41.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3032csm10584338f8f.45.2026.10.08.05.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:52:22 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] iommufd: Keep dmabuf PFNs MMIO when filling another domain
Date: Thu,  8 Oct 2026 14:52:03 +0200
Message-ID: <20261008125206.11990-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008125206.11990-1-parri.andrea@gmail.com>
References: <20261008125206.11990-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A VFIO PCI dmabuf mapped into an IOAS is mapped with IOMMU_MMIO only in
the domains present when it is mapped. A domain added later, or a copy
of the area into another IOAS, maps the same BAR as cacheable CPU
memory: IOMMU_CACHE set and IOMMU_MMIO clear.

Once the area is in pages->domains_itree, pfn_reader_fill_span() reads
its PFNs back from the storage domain through batch_from_domain(), which
adds them with batch_add_pfn() as BATCH_CPU_MEMORY. Only a hole in the
span reaches pfn_reader_fill_dmabuf() and gets BATCH_MMIO, so
batch_to_domain() programs the later domain with the wrong prot.

The effect depends on the page table format. io-pgtable-arm maps the BAR
as Normal cacheable instead of Device memory, the AMDv1 and x86_64
generic_pt formats set the SME C-bit on it when the tables are encrypted,
and the RISC-V format with Svpbmt maps it as normal memory instead of IO.

Read dmabuf PFNs from the recorded phys for every span, before the
xarray and domain paths. The phys range is always available, and the
read-back from a domain only serves to avoid re-pinning user pages.

Sashiko pointed this out while reviewing an RFC that plumbs the dma-buf
memory type through pfn_reader_fill_dmabuf().

Fixes: 74014a4b55f5 ("iommufd: Have pfn_reader process DMABUF iopt_pages")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260716154123.32DC01F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/iommu/iommufd/pages.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 404f31d8f7291..2f6153108add7 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1178,6 +1178,15 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 	    WARN_ON(span->last_used < start_index))
 		return -EINVAL;
 
+	/*
+	 * Always read a dmabuf from its phys, even where a domain already
+	 * maps it: a domain can only report CPU memory PFNs, losing
+	 * BATCH_MMIO. last_hole aliases last_used, so this covers any span.
+	 */
+	if (iopt_is_dmabuf(pfns->pages))
+		return pfn_reader_fill_dmabuf(&pfns->dmabuf, &pfns->batch,
+					      start_index, span->last_hole);
+
 	if (span->is_used == 1) {
 		batch_from_xarray(&pfns->batch, &pfns->pages->pinned_pfns,
 				  start_index, span->last_used);
@@ -1201,10 +1210,6 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 		return 0;
 	}
 
-	if (iopt_is_dmabuf(pfns->pages))
-		return pfn_reader_fill_dmabuf(&pfns->dmabuf, &pfns->batch,
-					      start_index, span->last_hole);
-
 	user = &pfns->user;
 	if (start_index >= user->upages_end) {
 		rc = pfn_reader_user_pin(user, pfns->pages, start_index,
-- 
2.53.0

