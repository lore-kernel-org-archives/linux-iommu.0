Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3CF37268B
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482099; cv=none; b=cAH9AYJCo9RXib5iOBWrGDFRl6KTQp/+U7wEHFAcLBk7F35Ds+AwHgVyfY1+jZFjqGzT+k+kG5ue1imz4FsHlKCktNbh+xOhEHoXjMQUIaHpIAiXYQThEqXKoKyy0oJLeWEPhYV3FlTwl4d/l8DztMQWm9+EjrlxubdMrTyDvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482099; c=relaxed/simple;
	bh=0aKwn57zHW1C3XwBvRm9o/Gi5cM0dakJ3Hj23+FmirI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pl6bW9V5VZAMUlEacka8R2TVEaJj5E+aslDxPYbx7k2WYHYThIK9fThPtF9+cv0T9c1GMMVerdDnHbZpE08lQl+8YR5UbysbfWI4NS7lwUKZeKPxEaLowJe7FeVxbBCAdVNCmn5Lqkv50GGVYpFADDmoSlEJ6Sls1OQoQ79XMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ME/bLZJI; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ME/bLZJI"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb38e86cf2so394639585a.1
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 06:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775482096; x=1776086896; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGXtWNQcZAWlKCGWFuHcliYSpbgFBFU8ITIHo5Az/9o=;
        b=ME/bLZJINeXWJ7GKXGw5QM9TKsDK4dKKqDRZ8addDc0Eo0qbwElsug/hW4CXVOT2Aj
         73XHnr7KpdXWOq9OFK+/TBKInivia6UDY0GFeWKC1CDQlmQC2yUaXnZuH4aYn94LvLOm
         sVJy13GDE7yyjB3RjMXFF1zLsNGlMuxfAE1bAnVdZAD0m8yUT1CU3+F0tC8QTyuqSMMt
         yFr3KsGQqR2BxOV/ksStDit99GHyxtleKQt4h4C+u4yq7dX8G4ht6xGV5pDq4AYr0CQf
         nCnjPihvb22km/D/GcGYgUckOMxLKKBmfL6lA+YlY5cOGwQUudjc6zOSJlpXLqq4EwHL
         IvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775482096; x=1776086896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGXtWNQcZAWlKCGWFuHcliYSpbgFBFU8ITIHo5Az/9o=;
        b=PdLegKCr5vV8ubM2A7xSmVA2iVLniv6VwrqQHIAAbuCjLRxzGJ8aIaH3hpkHZMel/c
         3X4lyABXkAEoxDOAj5xEmgzH6HSS6pbcr2ambDbNjnjrIvOe+dGugCefPyPRfHH3NhSJ
         MgjFslO3UShB1/pkWl7bVPYXwffzyoib/zmbqkUf7ZH4Bg4iUwjrmsf5I4mF/EtLKgEx
         IMRiIqk5QVc4QkoRDNliqzTbjkXD4tteZF8ikw3b1/rTYu/Tw63CJnMLtsSPB1wa+pD2
         XcJUPriiNilM0dZGXq2wNUTCLD5AdkKm+w61rDxhLXRq1bN5/gr1+cf+Q2aSlvzWKRxw
         BDWQ==
X-Gm-Message-State: AOJu0Ywmw9M/dop6JXUsJODmd5sbazpZ7pR9aIELRUPq+djmVLOWnhr9
	IeTrs3uqGKPOlOBl3rLmi3dxCQRCS5AksOotvmIiNEQBY6nYHpuBA9Z/SG5uhyLYY9RgDrdZKom
	FZv2T
X-Gm-Gg: AeBDievSt0PBvvYN07YLtigbAuE77RWlBGklDwuObW9AdirbVm3ezo4A4AupUnCa5aZ
	G0Si8VF037va8fLkkmNQeBzg0n+QNfLVHdmgUEiZymTOobHHQBcGAlar5I+kQqKXifwNkyQk/yO
	a/Cb9+8vUDuTSOWyj7ho+cTjORA+n7Ueug5UzJ+QIscTBObjWfXFOjD+q95t+hAWSdQNXvnUtaq
	khPOil/m2gfjIUVZ6XvdM90YNGkEYPTfG0iKKNqu98zIddEW8aCNO/egvtFLjHY0dIOT85TPpHF
	zsXVGmaAkBipAEHyaI6+q/U4JhgzU5Os26BBcUB4yhZemjmvf9SaTjJBbEOK5tSxOKU5efdNajk
	8HW9jgEzBDI3EaT6Xh+CUGsx1/AWnhQp1bf33xtQMyqTlMjC/XHqKB4+0wIM1SaP7ZUgTzZboF/
	9PoCnsLmvN882WvFfREcJfp5ZKMJZX2/HHvupKJSYvx5bch9mJnESwabJfoElIoV93JwcTYg==
X-Received: by 2002:a05:620a:1729:b0:8cf:cee2:e3ef with SMTP id af79cd13be357-8d41c6ac2b6mr1756812685a.17.1775482095655;
        Mon, 06 Apr 2026 06:28:15 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d588d13fe2sm539926785a.17.2026.04.06.06.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 06:28:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w9jzw-0000000DTri-3m3g;
	Mon, 06 Apr 2026 10:28:12 -0300
Date: Mon, 6 Apr 2026 10:28:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iommu_pt: support small VA for AMDv1
Message-ID: <20260406132812.GE2551565@ziepe.ca>
References: <cover.1775045213.git.Ankit.Soni@amd.com>
 <62cb55fdc5e08dceeb6d740cb73f75c6bce36226.1775045213.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62cb55fdc5e08dceeb6d740cb73f75c6bce36226.1775045213.git.Ankit.Soni@amd.com>

On Wed, Apr 01, 2026 at 02:43:55PM +0000, Ankit Soni wrote:
> When hardware/VM request a small VA limit, the generic page table code
> clears PT_FEAT_DYNAMIC_TOP. This later causes domain initialization to 
> fail with -EOPNOTSUPP.
> To properly enforce the domain VA limit, clamp amdv1pt_possible_sizes
> using the requested max_vasz_lg2.
> 
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> ---
>  drivers/iommu/generic_pt/fmt/amdv1.h | 4 +++-
>  drivers/iommu/generic_pt/iommu_pt.h  | 4 ----
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
> index 3b2c41d9654d..bc04d482c12f 100644
> --- a/drivers/iommu/generic_pt/fmt/amdv1.h
> +++ b/drivers/iommu/generic_pt/fmt/amdv1.h
> @@ -156,6 +156,7 @@ static inline unsigned int amdv1pt_num_items_lg2(const struct pt_state *pts)
>  static inline pt_vaddr_t amdv1pt_possible_sizes(const struct pt_state *pts)
>  {
>  	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
> +	pt_vaddr_t raw;
>  
>  	if (!amdv1pt_can_have_leaf(pts))
>  		return 0;
> @@ -168,8 +169,9 @@ static inline pt_vaddr_t amdv1pt_possible_sizes(const struct pt_state *pts)
>  	 * 512GB Pages are not supported due to a hardware bug.
>  	 * Otherwise every power of two size is supported.
>  	 */
> -	return GENMASK_ULL(min(51, isz_lg2 + amdv1pt_num_items_lg2(pts) - 1),
> +	raw = GENMASK_ULL(min(51, isz_lg2 + amdv1pt_num_items_lg2(pts) - 1),
>  			   isz_lg2) & ~SZ_512G;
> +	return fvalog2_mod(raw, pts->range->common->max_vasz_lg2);
>  }
>  #define pt_possible_sizes amdv1pt_possible_sizes

This is a generic issue, I think it should be fixed like this instead:

@@ -1153,8 +1153,12 @@ static void NS(get_info)(struct pt_iommu *iommu_table,
                        pgsize_bitmap |= pt_possible_sizes(&pts);
        }
 
-       /* Hide page sizes larger than the maximum OA */
-       info->pgsize_bitmap = oalog2_mod(pgsize_bitmap, common->max_oasz_lg2);
+       /*
+        * Hide page sizes larger than the maximum. -1 because a whole table
+        * pgsize is not allowed
+        */
+       info->pgsize_bitmap = log2_mod(pgsize_bitmap, common->max_vasz_lg2 - 1);
+       info->pgsize_bitmap = oalog2_mod(info->pgsize_bitmap, common->max_oasz_lg2);
 }
 
pt_possible_sizes() always has to be masked with the pgsize_bitmap, so
fixing it here is enough to remove those sizes from all the other
places..

Then one of the tests isn't following that rule, so it needs a fix too:

@@ -438,6 +440,9 @@ static void test_lvl_possible_sizes(struct kunit *test, struct pt_state *pts,
 {
        unsigned int num_items_lg2 = safe_pt_num_items_lg2(pts);
        pt_vaddr_t pgsize_bitmap = pt_possible_sizes(pts);
+       /* Matches get_info() */
+       pt_vaddr_t limited_pgsize_bitmap =
+               log2_mod(pgsize_bitmap, pts->range->common->max_vasz_lg2 - 1);
        unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
 
        if (!pt_can_have_leaf(pts)) {
@@ -448,7 +453,8 @@ static void test_lvl_possible_sizes(struct kunit *test, struct pt_state *pts,
        /* No bits for sizes that would be outside this table */
        KUNIT_ASSERT_EQ(test, log2_mod(pgsize_bitmap, isz_lg2), 0);
        KUNIT_ASSERT_EQ(
-               test, fvalog2_div(pgsize_bitmap, num_items_lg2 + isz_lg2), 0);
+               test,
+               fvalog2_div(limited_pgsize_bitmap, num_items_lg2 + isz_lg2), 0);
 
        /*
         * Non contiguous must be supported. AMDv1 has a HW bug where it does
@@ -463,8 +469,8 @@ static void test_lvl_possible_sizes(struct kunit *test, struct pt_state *pts,
        /* A contiguous entry should not span the whole table */
        if (num_items_lg2 + isz_lg2 != PT_VADDR_MAX_LG2)
                KUNIT_ASSERT_FALSE(
-                       test,
-                       pgsize_bitmap & log2_to_int(num_items_lg2 + isz_lg2));
+                       test, limited_pgsize_bitmap &
+                                     log2_to_int(num_items_lg2 + isz_lg2));
 }

And it should go in its own patch: "fix pgsize_bitmap calculation in
get_info for smaller vasz's"

Jason
