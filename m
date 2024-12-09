Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7C7080B
	for <iommu@lists.linux.dev>; Mon,  9 Dec 2024 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733769124; cv=none; b=Xb58E91Hfh00IWH9QjAFbeGanvJDzIln3netWFr67M46Wr40kYNnjTvo2CmgzOJIRA0iJHjAN/AbjmiNm4Be6e8IOZUZRcdErWATC9qx8mCTk+UtAhMIQyTvBsNQ4jViFk4tj6O/WsMzyKO7oyEwc06TT1lI0NsdDZLJAj1eE8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733769124; c=relaxed/simple;
	bh=Nfz9raYey/M397MrbNec+MnVN2czs4w1vB21GrOle6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ajp3QcZrkfHWVltjYEVVVIPvHAaF3b5i+6EOua5WM3AIyVVWvotIqDhDYUtnGebobJoF9V856oW8mOYAspRr5u2e4Ab/5ngRXRNq9t1epifppxo473ON8AajqxbZHNkPlxZIJfBW7AfZnZVHBnGMZcyEBxY7OWjYnOMKLccPLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XfR7awPu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XfR7awPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733769121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0pY765j5ehy1Z2Ke7p4xF1e0nHxYzj+nGUqdqssuX0=;
	b=XfR7awPuO+oldIaowxTh4Z+KtGVMlBK1y/5PUbDUkkchrY2yRzCbPQmg8Rnii32YUX/Fzt
	R9kP3KXZqXwpb7ZFQ9l+b7omEr0+WAmoR3ZP381aj+oM/zglQI6yjJLTacMU74KegPOP1/
	C1vlqHiN3+UA3yAG+K+QBMzp/RikgQY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-EvqRRxa6PHyzGw05gDILNg-1; Mon, 09 Dec 2024 13:31:58 -0500
X-MC-Unique: EvqRRxa6PHyzGw05gDILNg-1
X-Mimecast-MFC-AGG-ID: EvqRRxa6PHyzGw05gDILNg
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8e6046f0fso51469756d6.2
        for <iommu@lists.linux.dev>; Mon, 09 Dec 2024 10:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733769117; x=1734373917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0pY765j5ehy1Z2Ke7p4xF1e0nHxYzj+nGUqdqssuX0=;
        b=bHMk2ADmp0zRCMdukhu61qV7mFLkSfM2mrfPA/Sdvp6LxFgaLwRp7mevbxeckvFcL1
         wWP/qrOVQSSqsd6JSo7hI4Rzgh7YoxvWL/L3qZsUqRlevH1iL29BaXxCUHB6Uk5SnZMH
         bv4db5qyu5WcDsVAQtF+2AqAYWa8K+Hnss1wzzwpuM2/QUVj4bU77y52WKlUG3hHWgf5
         COtiGb81rwBv9YO61cWV722guzZI1YEZkcKhBQNZaIqkUpj0j5oC8VPKotBGZaX+eqNu
         +8Ah9/TEFcPL5O2y1MYVJkUKid7PptY91K3vivHZUBa0EzfuRb14X7FattCmagc6UiYR
         +Gzg==
X-Forwarded-Encrypted: i=1; AJvYcCUGdK8DkNktoqBPvrIXsvHneKmmeGBduGOMyQkkTXigx8VceXZthagftBSZMAhBwE46HC6ksw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyd/MGtbr50gDe9w+A+/jdlh15O4M+UyPxgrO+bxY9nbLp8TAsg
	clKUVd0/mnYMC+6gHz/dL0FMQZWk4tAT02wUtAp9yd4bm402HBgkkEdUPhcQ5tv6u5BsTbtQlsW
	bPtEzb3IjXXG6f3XE2Cvw3sETJGfH9JPJNLQ9LrktRPKUomTUBbQE
X-Gm-Gg: ASbGncsKstiruXPJwFpkq78qa5lo6a5ARTUb1INUYXgt0xZhgu4cYg91Yxz7Fd2GtNr
	H4xRIctXQpI5jPf4QExOxZwLMZnbCWVLKDEHV83v0pS0yXhXHVBXRvlydvPnOMW35JdZt5KhWsK
	FyYWsaQ4MaS2pb0CUu9uNOUWCNcsmSj9DaovGfRa84KAr2hzbgHIvC4MgugCWuMCKcuUvtJRIpj
	FDiG6cE/eGYNGNcd+k6puzSOygErDhprO+Mi4HxyDKHgLZGFs4vA7/pZZVkq6X41wf3IHxAHl/y
X-Received: by 2002:ad4:5ae2:0:b0:6d4:287d:b8d6 with SMTP id 6a1803df08f44-6d8e70d5e28mr297131706d6.18.1733769117723;
        Mon, 09 Dec 2024 10:31:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKJblYHP5q2pIDOUn6eT6/NeUfap9kBzGaLS8smRgro3ONIGkFqmWmTdriNB4IZZFFqqyzDg==
X-Received: by 2002:ad4:5ae2:0:b0:6d4:287d:b8d6 with SMTP id 6a1803df08f44-6d8e70d5e28mr297131466d6.18.1733769117458;
        Mon, 09 Dec 2024 10:31:57 -0800 (PST)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da675214sm51471676d6.11.2024.12.09.10.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 10:31:56 -0800 (PST)
Date: Mon, 9 Dec 2024 11:31:55 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, patches@lists.linux.dev
Subject: Re: [PATCH] iommu/vt-d: Remove domain_alloc_paging()
Message-ID: <yfbshn4muaytd7nt3o74xguxxi6sncgv7yrocbnal5m4kzixsn@kqgx3ez4s2cp>
References: <0-v1-b101d00c5ee5+17645-vtd_paging_flags_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0-v1-b101d00c5ee5+17645-vtd_paging_flags_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lUvqnR0mT3CA1HIHjWRqefTIpNTD7hLlq55DNLvbESA_1733769117
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2024 at 04:14:58PM -0400, Jason Gunthorpe wrote:
> This is duplicated by intel_iommu_domain_alloc_paging_flags(), just remove
> it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/intel/iommu.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 7d0acb74d5a543..88e4e867012cba 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4443,21 +4443,6 @@ static struct iommu_domain identity_domain = {
>  	},
>  };
>  
> -static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
> -{
> -	struct device_domain_info *info = dev_iommu_priv_get(dev);
> -	struct intel_iommu *iommu = info->iommu;
> -	struct dmar_domain *dmar_domain;
> -	bool first_stage;
> -
> -	first_stage = first_level_by_default(iommu);
> -	dmar_domain = paging_domain_alloc(dev, first_stage);
> -	if (IS_ERR(dmar_domain))
> -		return ERR_CAST(dmar_domain);
> -
> -	return &dmar_domain->domain;
> -}
> -
>  const struct iommu_ops intel_iommu_ops = {
>  	.blocked_domain		= &blocking_domain,
>  	.release_domain		= &blocking_domain,
> @@ -4466,7 +4451,6 @@ const struct iommu_ops intel_iommu_ops = {
>  	.hw_info		= intel_iommu_hw_info,
>  	.domain_alloc_paging_flags = intel_iommu_domain_alloc_paging_flags,
>  	.domain_alloc_sva	= intel_svm_domain_alloc,
> -	.domain_alloc_paging	= intel_iommu_domain_alloc_paging,
>  	.domain_alloc_nested	= intel_iommu_domain_alloc_nested,
>  	.probe_device		= intel_iommu_probe_device,
>  	.release_device		= intel_iommu_release_device,
> 
> base-commit: f6ba64bc6669cb5152a31a474734308dcccb3ed8
> -- 
> 2.43.0
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

