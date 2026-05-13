Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0962C4A13A4
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691403; cv=none; b=u50LP102QdHqROn9HBFlhr1jxyvxRnAQjd522xqNibiaygUi2rybOiTOqQQ6fXCey9a05cGtTZE79nTED8MJAfb0uaYQ6v0fT8cq50pfiWQOl/brOGqplQwUEimIF954W6/1tjJ+saQ5a+IgsRPZOUNmdoFT9gj8C28KLLYzhx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691403; c=relaxed/simple;
	bh=Ut5l11CKVrSjVJL/SXBTdKTB+m65fhYWOTIJs46hZ4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ9dXs3U8CVMo3aE3e5OP9oU9Zm9dtdInO1+Ecdvi/E9ingx1a/juGSIVf3VriYPV1Rxa4XWWAV3JZoRnnxDYdn8ZstNMy6FoH4We0U8OyCTEO1C9MOfhLQPytXYLldLYOu6ls5+YI+ZXhe/IWENF7v6yqgiD5I4P+VMnMlgFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSrErUg2; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSrErUg2"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-133362c30cfso1490c88.0
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778691399; x=1779296199; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3lVfNFiffp+uU+9DlG1DEynuXNArzY2ybDWxR4v/kU=;
        b=MSrErUg2lm0x5R6LbBmZxeIk2ObTUA1rFQ1KrkXyaDPbxMyJ0vplGmwSPmgxfXORUp
         /Y5YtN1OVe4i1XqtGouL7+LrTed6lBxKsch+bTETjHrHzJQd9fzyImw8cOz2dOZT5GCt
         lGCTQn1qc6mtHlcHDlItIUng+3iK4peyjFbVXa2SgYuGIeOxLLzxAe0aaQn6rjcnKItx
         680I7NzEUsguOjfh41R9ZoOxBiCiKTl31qkUu2vifXVZiVc/enC9RdunPZa9QHWExLwz
         LASzCshSsmx/DP2rfYGyzRiBmTL2bx8zOrDFOCcz9E4ursL2iJgL/AyRkvYKGVwqKVvV
         ZvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778691399; x=1779296199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3lVfNFiffp+uU+9DlG1DEynuXNArzY2ybDWxR4v/kU=;
        b=MDCReJVtpkJ2Qnsqr4Kq6LtTtQQ78TF0hl+bgk5rumgkQXTlqs7UlmDAwZ6mEYGWfm
         zlGA9s0Jxbu4rkGGF3L7DSUnajXWEG3du8hA4Jnpu36EDKyN6ioV2qR1Uo1QPBItb1/a
         fF0KJu/83oWY68ynKVGkL0BIWjUU/CG+l8VXdeZdoGXDloOJBViRsq5jULUta7BVUXny
         8ppw12NRT7ZHtdcyknmQmCNuIQQ2lIxXXR46U8nNkBCLNAVtmyzAguj/CsVL5E3bnmnx
         NhCGxz5YPFrmTvsKHVykjZ03aej8YlxqY72zemPJ3Pe0idftNgjDA2YGkHkOUa581+Eb
         t6rA==
X-Gm-Message-State: AOJu0YyIGPW4GgehOFlgs4Ztf+j2W9Z8DIb1gdhOF2JZ/2cMjP1FOf7+
	r2iT1EXlpvXIAuiGxkzpfmxB0l2GO7Qvcl1ef7cnfbSZqeHaUpRtB+blU1L0EaTrLQ==
X-Gm-Gg: Acq92OFjmUKVy32WwT1ZKz/e9R0EbBl8jboYeSlgE/5/Ph9zXX9LhlSXj2MHeZOkumB
	pfzqcy5Emkvu3Rinb+TumOvYFQQX4H9jjM+6Abz1mM/cuZPO0sm7vT0IHkvvhOjc5phizOLu3wm
	PinzDN1DWq/wY/XarPzXPHcFvri+g3PEmFV7M//bpOSic33BssLUhNP/qDc6PMgoxXH7yDJdkfe
	WRHwwa43ZGMqgji6KqjhSglL/hwLg/F96mRhV7pT+Gnl3QPc5GdQr6XZJE9/4AWn+W8OHcg082D
	1r5p40qB7+IhQqPf2/YqEVfAvlW7AQFtoLUthjsHXCuzJlgvUQK4A1c0ZzVEAff1hDwEi034qys
	tG8jgRiU+hMIMeUHTXbvnXiN3J4UzRsLAnxIam/vFJ+tzeZDuQdUAivkHPmaLXbh/O/Y11er8ke
	6StYBvpTcp4FnuOInnXjUVOnDdAgKaS75tS1dryAKaIYqTQF25tKLgSQM+zTXXUoCSSxmVQw==
X-Received: by 2002:a05:7022:ef05:b0:12c:7ec:b96 with SMTP id a92af1059eb24-1347dbc6465mr209272c88.1.1778691397968;
        Wed, 13 May 2026 09:56:37 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888c3b301sm29447066eec.23.2026.05.13.09.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:56:37 -0700 (PDT)
Date: Wed, 13 May 2026 16:56:33 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Josua Mayer <josua@solid-run.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 3/5] iommu: Handle unmap error when iommu_debug is
 enabled
Message-ID: <agSswSq8bTYiI6Uv@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <3-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>

On Tue, May 12, 2026 at 01:46:15PM -0300, Jason Gunthorpe wrote:
>Sashiko noticed a latent bug where the map error flow called iommu_unmap()
>which calls iommu_debug_unmap_begin()/iommu_debug_unmap_end() however
>since this is an error path the map flow never actually established the
>original iommu_debug_map() it will malfunction.
>
>Lift the unmap error handling into iommu_map_nosync() and reorder it so
>the trace_map()/iommu_debug_map() records the partial mapping and then
>immediately unmaps it. This avoid creating the unbalanced tracking and
>provides saner tracing instead of a unmap unmatched to any map.
>
>Fixes: ccc21213f013 ("iommu: Add calls for IOMMU_DEBUG_PAGEALLOC")
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> drivers/iommu/iommu.c | 49 +++++++++++++++++--------------------------
> 1 file changed, 19 insertions(+), 30 deletions(-)
>
>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>index e334588a2476b4..e5fa9875900228 100644
>--- a/drivers/iommu/iommu.c
>+++ b/drivers/iommu/iommu.c
>@@ -2575,12 +2575,11 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
>
> static int __iommu_map_domain_pgtbl(struct iommu_domain *domain,
> 				    unsigned long iova, phys_addr_t paddr,
>-				    size_t size, int prot, gfp_t gfp)
>+				    size_t size, int prot, gfp_t gfp,
>+				    size_t *mapped)
> {
> 	const struct iommu_domain_ops *ops = domain->ops;
>-	unsigned long orig_iova = iova;
> 	unsigned int min_pagesz;
>-	size_t orig_size = size;
> 	int ret = 0;
>
> 	if (WARN_ON(!ops->map_pages))
>@@ -2603,31 +2602,25 @@ static int __iommu_map_domain_pgtbl(struct iommu_domain *domain,
> 	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
>
> 	while (size) {
>-		size_t pgsize, count, mapped = 0;
>+		size_t pgsize, count, op_mapped = 0;
>
> 		pgsize = iommu_pgsize(domain, iova, paddr, size, &count);
>
> 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx count %zu\n",
> 			 iova, &paddr, pgsize, count);
> 		ret = ops->map_pages(domain, iova, paddr, pgsize, count, prot,
>-				     gfp, &mapped);
>+				     gfp, &op_mapped);
> 		/*
> 		 * Some pages may have been mapped, even if an error occurred,
> 		 * so we should account for those so they can be unmapped.
> 		 */
>-		size -= mapped;
>-
>+		*mapped += op_mapped;
> 		if (ret)
>-			break;
>+			return ret;
>
>-		iova += mapped;
>-		paddr += mapped;
>-	}
>-
>-	/* unroll mapping in case something went wrong */
>-	if (ret) {
>-		iommu_unmap(domain, orig_iova, orig_size - size);
>-		return ret;
>+		size -= op_mapped;
>+		iova += op_mapped;
>+		paddr += op_mapped;
> 	}
> 	return 0;
> }
>@@ -2645,6 +2638,7 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
> 		phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> {
> 	struct pt_iommu *pt = iommupt_from_domain(domain);
>+	size_t mapped = 0;
> 	int ret;
>
> 	might_sleep_if(gfpflags_allow_blocking(gfp));
>@@ -2656,24 +2650,19 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
> 				 __GFP_HIGHMEM))))
> 		return -EINVAL;
>
>-	if (pt) {
>-		size_t mapped = 0;
>-
>+	if (pt)
> 		ret = pt->ops->map_range(pt, iova, paddr, size, prot, gfp,
> 					 &mapped);
>-		if (ret) {
>-			iommu_unmap(domain, iova, mapped);
>-			return ret;
>-		}
>-	} else {
>+	else
> 		ret = __iommu_map_domain_pgtbl(domain, iova, paddr, size, prot,
>-					       gfp);
>-		if (ret)
>-			return ret;
>-	}
>+					       gfp, &mapped);
>
>-	trace_map(iova, paddr, size);
>-	iommu_debug_map(domain, paddr, size);
>+	trace_map(iova, paddr, mapped);
>+	iommu_debug_map(domain, paddr, mapped);
>+	if (ret) {
>+		iommu_unmap(domain, iova, mapped);
>+		return ret;
>+	}
> 	return 0;
> }
>
>-- 
>2.43.0
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
