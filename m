Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F44DC54B
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694389; cv=none; b=J8FtogIECqvx/rdHfzLk1KI1oy8nBtBP31OiKdeJqz5jtDG0ZKExhNWMafpGja6OXgAPGTErvH2nmOt7UASVrWyEnUH+oHsjUVNWpAAzBNUq1sSnRGbdC/eMr1Wkq6s/cCFMduuWyZz733ADKxI010HROJWBHLX4V6cTC+b9B9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694389; c=relaxed/simple;
	bh=RJSvlSo8b3eU3kArKQ0tDZIFebTEAfI2/bt/cNgtTGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZ8n8a6KmPUbsmNN5AH/lN+WEy/qYx0rpexSp73a2exDd9aPo3VgxvYm4tJbvZhefXq3/RPBmXSbwO0MJILVcfoY78IyWNYfV26GIrYtkD3rO1YflupxBAz+lZ+pTF89MDOKyRjSScyfhesF0PRe+9kJMGAECmM0XVceKGnoX0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKpngkg6; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKpngkg6"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-133362c30cfso313c88.0
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778694388; x=1779299188; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XeNgdwwD024w74BNPer9lil+jH8BVZwrPlFbFGxZTFc=;
        b=fKpngkg6rBN/SDQrFRUJaC9to8jByeL/RZLdLqn8x65Wtsi7HRE/LmkQsXuv2LB5ND
         bgABCuH04jDIiCkWnZp2jHY5lPRSGNL21ML0D3NPe8CCTq1LSLSS0O09F7XG6kfGrYow
         XPF4KIRCdTfIqPTI0e8P45tosruykxxFCjTmEN0/RXh62xoNuYdRVuy5Rhd+r5AB382K
         K1bXOcy2EGf97C5bKc/TdPZo7T6pGZH8A8ghInrp4x21LbC58vo6zK81HSlkA+LmHAPF
         rCMlS0PlrwQ8YUHwL61ZJxWebUUKxRRXIqnOKwOekOqaL4Ogx2roT1VaLwIz/CqwsOgF
         uiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694388; x=1779299188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeNgdwwD024w74BNPer9lil+jH8BVZwrPlFbFGxZTFc=;
        b=XWRwCYhGBbY5F+EAu9SWrb5wn4iJbFMDggC0Dez1O9uE4yB/gi2Ic4LcY12ceQzZfD
         HytV/rX3Gh2XJ16aFmrreQl8vluJQS5CamcoypNBuKIw1d3c6t5d3y4mlj5WLc3Kt7YU
         TjKYOtHCK7Vwk3FiykPnAHoH9ykXaJf1+49wM6vZOq9ssmUWmS4Ps1oe43Pr9YbPaI+w
         bRQeBJXT48u3wtP7yn4V2Fv6aHoiQrSCIFT9dHnIzlumCxq4tsf923hC0TZCD1Hg8G3u
         kQJqvLNLNlxn7IniyEwQfLlhXWe3bwlRB/rLiFO73CCct5rIcDHJaQrED9k1/Es7eY7K
         Oz3Q==
X-Gm-Message-State: AOJu0YxBdqNtFmAala5OnA5T2SKtqLaWenWtunL39Sx94VFE5WECuatj
	mUWooNWyASTkIl6PJkPd1G64AYFM/ANLo104UwaSEoT/2RRyG8Beryjq3+60Dis+Xg==
X-Gm-Gg: Acq92OFlYCTvtC4tYs5el2w6KYANUTA0zmZDy1bzAgIz/fhYqB+bKg7D/3b3ibchtPn
	0yH9AJg+e1UuvIH994zkfEYquytJr+/Za2omk6/rSqa1FI6AnETQQaIICaNcffJCnDFwCncKl3d
	Fa/aJPnqrxcKZv60GOexTan7alC6SR0s7jIX7O/wdqaifXQ4R0qkCJo/ihYc05ULgP7ya7zwFgt
	Vmq/mvzx7Q7SXOE5zLv+MAO0pj5hIHD9za9t/wOSRdl7nlewlpte+4U+pQXOHnoP7gqtLlS3b/t
	DLzRO5LW2mtLQmExTL0y8KUA7JLE1Liie8Qkbm2vVIb+29oz8oEbNYj0BwYKCW+KtcghxZnePiH
	jqfXVpUxTHS6eY+x68HGN8nGnW/YvCgYw03UPv7Ry25C+r1ysBdKStYuy3dkRVhtiWLKO8W5/BN
	h6sXeYfWv7uajhgtVDZpZDyoU7/csp4jS2uzNVsUQQMJr3gq1vba7DVL5D4UoeKihE2KGyqA==
X-Received: by 2002:a05:7022:69a5:b0:12c:8f55:cd0d with SMTP id a92af1059eb24-134cb46941fmr20666c88.8.1778694386986;
        Wed, 13 May 2026 10:46:26 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafc2sm29059095eec.4.2026.05.13.10.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:46:26 -0700 (PDT)
Date: Wed, 13 May 2026 17:46:22 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Josua Mayer <josua@solid-run.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 4/5] iommupt: Check for missing PAGE_SIZE in the
 pgsize_bitmap
Message-ID: <agS04F8UmZwWZNao@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <4-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>

On Tue, May 12, 2026 at 01:46:16PM -0300, Jason Gunthorpe wrote:
>Sashiko pointed out that the driver could drop PAGE_SIZE from the
>pgsize_bitmap. That is technically allowed but nothing does it, and
>such an iommu_domain would not be used with the DMA API today.
>
>Still, it is against the design and it is trivial to fix up. Lift
>the PT_WARN_ON to the if branch and just skip the fast path.
>
>Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> drivers/iommu/generic_pt/iommu_pt.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
>index 19b6daf88f2ab1..4877b05291c9d4 100644
>--- a/drivers/iommu/generic_pt/iommu_pt.h
>+++ b/drivers/iommu/generic_pt/iommu_pt.h
>@@ -920,8 +920,8 @@ static int NS(map_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
> 		return ret;
>
> 	/* Calculate target page size and level for the leaves */
>-	if (pt_has_system_page_size(common) && len == PAGE_SIZE) {
>-		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
>+	if (pt_has_system_page_size(common) && len == PAGE_SIZE &&
>+		likely(pgsize_bitmap & PAGE_SIZE)) {
> 		if (log2_mod(iova | paddr, PAGE_SHIFT))
> 			return -ENXIO;
> 		map.leaf_pgsize_lg2 = PAGE_SHIFT;
>-- 
>2.43.0
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
