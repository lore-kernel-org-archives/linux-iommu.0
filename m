Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FF35F5F3
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562632; cv=none; b=BroFMVJnB/Ak4COpUlkQXpXRbYOwP69TRNTZ4eLETzsjaxuCYbutFfreAJ75P4/sYj1rMSFT0MXjeN1pvv+1m/ZiQIZeraiSEKFwef9MxWgbW1CY1D4sJw10bkRnbvj8kW7A09OqUU73Bq5wq062IyIH5MQ7AxyOHmz04wosNJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562632; c=relaxed/simple;
	bh=XW0MM9Qb0l7ek0D6rjJBMdfOtLG2Js4WUdcnE1GL9zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mxu6IabfmFJ60NOonFqDZE7r13Bp8h/n+xAoDL2h3o0r295QfkvRbY9W0n6/VE1CNpLSVorBhqSC5xg6UevvENB/igH5r/oU+mp8fFEzRuFcUWDeh+0YQDdvnfqTT3BP50ccmSpsJ+DaKkFqNMpq9MBBFCag10YNbqiGmSvZKp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e+/5VJ+V; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+/5VJ+V"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae49120e97so91015ad.0
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 10:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772562631; x=1773167431; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZwVdnEFy1OqWo7KkJ5/mQriJgyzWARTRDxGrzurnM4=;
        b=e+/5VJ+VLmBNumDS28v1axxUnNnjaoChxyWFuhTnYJiqslIAKtQDTYlIT/AkHCkGo9
         Y1ZYwBmB0HmYDwiKt9feyevPyjEjTfy7UfsigBcOSJtNPpa9lLeIoxrWjWuUT+rxqAHA
         ozL9Y7Ix/2vdrlbT9baw83Dkxp+EUf+d1EaAk8TBHAK3WpwZHHSK/j7fIovlZTxJg0VC
         47TmF93LoLGl05tZap2pPq0e7vBapMQYMIM4WF7iABvJ6sN/Ax1yb4q10+lrsbEZ+TJE
         lDtPP09YnCa1fmeFHXfw6hesrBBSflrQcXDcHZcsfaaJRh+5HQfjmyV1NLd5KIiSacji
         pRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772562631; x=1773167431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZwVdnEFy1OqWo7KkJ5/mQriJgyzWARTRDxGrzurnM4=;
        b=ryBtyYtDdPUO+ORK+HIsuJfefYQ9NgRz52JOo1g4Xwi/KXWDXlGyYxoSOQfwoPJDtO
         0O2jTl6d3c4Y7dnIFG7unBGLnZHbmj+YrMrtZQdrNc7vhe6x7wqVe8JpU9QqPXKJa9DI
         R1QzhD59yfCtRtz4MjcFdxhLI4Cj2Gm5x3O8TJtF87aGjZuFRVbcfiwsEuFOr4SuVUTA
         EDrmmfYEPHT9MfQo/2jd2609kx10FBrLrE6h6jZtTCIQCGaykp55sXXV9ozYRuWF62YJ
         fg3JSdzJDb8Pb5hol2Qe9xX/+dFSUQ3Osk4xEdwRKXLDDz+RpjUrUrNfHy+ctxLjgAff
         5v2Q==
X-Gm-Message-State: AOJu0Yyqx9tZwwl1l8LFy2VtpxLNfP7MyPb43rBE2JBJMmCV6c6Efoh7
	R51cYEV/YiT8prGpXu3W3KWh4tf+3VHmfje2ohaWIIhL6hBVCdOiJ/M2LqouciJniO7Occvksn9
	ZaVhAKg==
X-Gm-Gg: ATEYQzzZ3NpgOGV5Mxc2kukQ0UItec06dckLP5u+4aVEUkZWdhz+uJGnRBXhON8fi4u
	NJWCSuR8ZB7e2la3T8QhnsJBN5dOjIM+z0RUyiWkmisLhEUzZyD7ApgP/bK2ANTuJMTWqahTqDV
	agYmhvCNisQObH5J40KxSONx7BwO34JJyt8K8Ne5nF4H+pD8jcFszNfS2AyAqUVG0r7p+mLkABC
	asb+V7uEaKrME76CrrpqAURP7LIKNjNKVeSrA+wWV807sK9c61/CpcpgvfBXMFgut87a6XZqGPh
	63YQfRyh+8heJffYlDH9+/UXHpFGzyv6VNmlKyqAqadp4AkJem54CaLs4OrkVG3jqFOasXk0+Ss
	jKZVFCDjnjZ2emC7yZWLFM6DkVYWgGbepzp69LP1kiBJa8yEALeirphJb1zPKUv0NMdksTaYYPJ
	e4kEJM/s70I07m5DTNvBgxDwpJpGzcbHSwfdkFJCms9WBHan64QKTCAapJVGSduw==
X-Received: by 2002:a17:903:3c23:b0:2a8:fe50:2933 with SMTP id d9443c01a7336-2ae3949de2dmr1433415ad.0.1772562630134;
        Tue, 03 Mar 2026 10:30:30 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599bb43e28sm1884837a91.1.2026.03.03.10.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:30:29 -0800 (PST)
Date: Tue, 3 Mar 2026 18:30:24 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH rc 1/2] iommu: Do not call drivers for empty gathers
Message-ID: <pvnu5d23x6bk5cs6wbf2nf7v4m3ietrgumeq7rn43twsadns5l@pa4jvd62bmgq>
References: <0-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
 <1-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>

On Mon, Mar 02, 2026 at 06:22:52PM -0400, Jason Gunthorpe wrote:
>An empty gather is coded with start=U64_MAX, end=0 and several drivers go
>on to convert that to a size with:
>
> end - start + 1
>
>Which gives 2 for an empty gather. This then causes Weird Stuff to
>happen (for example an UBSAN splat in VT-d) that is hopefully harmless,
>but maybe not.
>
>Prevent drivers from being called right in iommu_iotlb_sync().
>
>Auditing shows that AMD, Intel, Mediatek and RSIC-V drivers all do things
>on these empty gathers.
>
>Further, there are several callers that can trigger empty gathers,
>especially in unusual conditions. For example iommu_map_nosync() will call
>a 0 size unmap on some error paths. Also in VFIO, iommupt and other
>places.
>
>Cc: stable@vger.kernel.org
>Reported-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
>Closes: https://lore.kernel.org/r/11145826.aFP6jjVeTY@jkrzyszt-mobl2.ger.corp.intel.com
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> include/linux/iommu.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>index 54b8b48c762e88..555597b54083cd 100644
>--- a/include/linux/iommu.h
>+++ b/include/linux/iommu.h
>@@ -980,7 +980,8 @@ static inline void iommu_flush_iotlb_all(struct iommu_domain *domain)
> static inline void iommu_iotlb_sync(struct iommu_domain *domain,
> 				  struct iommu_iotlb_gather *iotlb_gather)
> {
>-	if (domain->ops->iotlb_sync)
>+	if (domain->ops->iotlb_sync &&
>+	    likely(iotlb_gather->start < iotlb_gather->end))
> 		domain->ops->iotlb_sync(domain, iotlb_gather);
>
> 	iommu_iotlb_gather_init(iotlb_gather);
>-- 
>2.43.0
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
