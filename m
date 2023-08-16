Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D00710957
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 15:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692200234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gddoAvGyksjgJqPs42olcFMDb+drq435phagS0mbeiQ=;
	b=ZBgaWCfw6MF7v9vw+yMMXnzCUL8NNqpPEsmX+TbCUTMnxMJVXRvcu7inQyRaVFRSFTtDAq
	LkwnD0BVZuOiVrqHpfjaM3wTzFgjvfgWMjh7TKbdeQ7JECzXd+5fgnEn6qk0m61T/NGeWu
	suokmNfu0oBorMV2v4HQ4gM7HM3SZT4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-4bFNUJ_UMmKa1yXvzyZqkA-1; Wed, 16 Aug 2023 11:37:11 -0400
X-MC-Unique: 4bFNUJ_UMmKa1yXvzyZqkA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76c83aab2c7so852702185a.0
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 08:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200231; x=1692805031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gddoAvGyksjgJqPs42olcFMDb+drq435phagS0mbeiQ=;
        b=j+ZLGwe8lzaHU/5lTcn5tiTJKkwc71bW1tax1taDO1DovZi8VCO6m2YfXjp+KBLu5i
         Fz9wx6T7E0Io+VtKXRrWSUTdBphuLNKbqySIgWrRoIeKonVeISB85UFTBE2URO/5LTP0
         lUbNMbxq+0rDMAbqOTn9xvMEDKmjs2xO83AprUkO+7ytkKfgrwsqhDiQDC/GqhHfdwr/
         Es+26VM+zE3z1HeORC5ZlMTpddFikW9Szzvq0mv154HPUxd2l+CQ9rjEQcElOwrtbpfu
         9AupEQ/K3P3laRFeOpDjTD4gXWcd81uLJb4FkoSLQK5s14C7yNqxNXd9XM44ZG2ROQu3
         oo+A==
X-Gm-Message-State: AOJu0Yy/7bfdet9fk8sEJNQ/kqiKShW7z1KVhkF9LOBRifpNdNRSX0hU
	iPYzcmUNlQUzHop6No5mnYTnK+f05PjPj3jnIWD+RcTOSrWkTPfn1YKkdBNZIqmkSl0w8tIw9E0
	uU4E8DX5H9z4JVwc=
X-Received: by 2002:a05:620a:4148:b0:760:69ca:7a1a with SMTP id k8-20020a05620a414800b0076069ca7a1amr2806182qko.1.1692200231282;
        Wed, 16 Aug 2023 08:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxra45Ouh7hWpdhw00UbJnveCzyKw3T6DRZq+td3XeWs4wIzwHEoTdS8wnt5qagYPepZ/Mdw==
X-Received: by 2002:a05:620a:4148:b0:760:69ca:7a1a with SMTP id k8-20020a05620a414800b0076069ca7a1amr2806163qko.1.1692200231017;
        Wed, 16 Aug 2023 08:37:11 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id c10-20020a05620a164a00b0076d25b11b62sm4474581qko.38.2023.08.16.08.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:37:10 -0700 (PDT)
Date: Wed, 16 Aug 2023 08:37:08 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 01/14] iommu/amd: Remove unused amd_io_pgtable.pt_root
 variable
Message-ID: <y5l3yliqnht2al2wggrtqivmwhxmunejmstnsa2nw3b2c6kxw3@ruqxuvygvcev>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
 <20230815102202.565012-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230815102202.565012-2-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 15, 2023 at 10:21:49AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> It has been no longer used since the commit 6eedb59c18a3 ("iommu/amd:
> Remove amd_iommu_domain_get_pgtable").
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/amd_iommu.h       | 1 -
>  drivers/iommu/amd/amd_iommu_types.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index f23ad6043f04..6bf55de9fbeb 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -108,7 +108,6 @@ static inline void *iommu_phys_to_virt(unsigned long paddr)
>  static inline
>  void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
>  {
> -	atomic64_set(&domain->iop.pt_root, root);
>  	domain->iop.root = (u64 *)(root & PAGE_MASK);
>  	domain->iop.mode = root & 7; /* lowest 3 bits encode pgtable mode */
>  }
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 7dc30c2b56b3..081d8d0f29d5 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -544,7 +544,6 @@ struct amd_io_pgtable {
>  	struct io_pgtable	iop;
>  	int			mode;
>  	u64			*root;
> -	atomic64_t		pt_root;	/* pgtable root and pgtable mode */
>  	u64			*pgd;		/* v2 pgtable pgd pointer */
>  };
>  
> -- 
> 2.31.1
> 

