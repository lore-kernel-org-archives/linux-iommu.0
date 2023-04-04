Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52613C07
	for <iommu@lists.linux.dev>; Tue,  4 Apr 2023 16:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680625716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MTYy0H3bhj8cXxdZNgO3n4Jj7YX7R1xpNobN78N/Po=;
	b=fPJb+GgrB2MQblxaKaLDmHPNTFAQRsnrgIBv1LieLvppTNoHUaE0x5PEqrIjKtZDwz/+V9
	rzfcauy3CACEPhLizdmVpGs2nswAcn0QU223fJWNBHAnk0V6A5cNUubXhvkfc2shzDVyhQ
	mRO9HjfzbvWs9hwrQokKFweAq9Sss+E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-koCAXrJuOVuqfj5UcSPr3A-1; Tue, 04 Apr 2023 12:28:35 -0400
X-MC-Unique: koCAXrJuOVuqfj5UcSPr3A-1
Received: by mail-qv1-f72.google.com with SMTP id p14-20020a0cc3ce000000b005e14204a86bso6784876qvi.10
        for <iommu@lists.linux.dev>; Tue, 04 Apr 2023 09:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625715; x=1683217715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MTYy0H3bhj8cXxdZNgO3n4Jj7YX7R1xpNobN78N/Po=;
        b=o1mN1wUwzg5pM091kUjAxLMcU2Qir+fMZuSqygAzzTXOHaVK9i6ihAb63O/n9up0/e
         odJwFtDscB6ndzHBOfRkXSOeghTkrxGtwx7wTEpo2ZNGaYsaCbwaLTHCED4rnKO1T4C0
         JdJiZBbBmdclQvMJ1aWLc5VOVv6g9VkMIWtqeNncpvnZisP7m5+4WdmKSmGvigkmMzLT
         6DH8sts4THCszHYUTC+6PyAkgDaFRiyjyXSsF//KQ8jqdLZvx15o++Kqy1ZxP95k0gpG
         1k2VtqNofLn5xyqo9H5r4qTOuRyF1urd02VNKYhDynL+00hEpC15EvmQCcQCGtCGDXCI
         KSJg==
X-Gm-Message-State: AAQBX9cEAsUCDp61xiSo61kLAQVtMr2Vd/Zp3d5PaCulk+bjYAIMWTgb
	mVcyPazwZObkDGPPGYWcnc4iiZOtezbl2mcFwklYiDIWu7bU+rvqQObRlMl9xQeUtPnOrI5dLMD
	JEpfLE9/1WO6Kz3XS3LEO6q0=
X-Received: by 2002:a05:6214:e42:b0:5a3:fffa:f600 with SMTP id o2-20020a0562140e4200b005a3fffaf600mr4643133qvc.26.1680625714982;
        Tue, 04 Apr 2023 09:28:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yl4PWkJnFX/sblOhO4WDEageQOvt507SZMvRViAiNgF6myvnabeEcN/5+GN7gyUrDylxWaNw==
X-Received: by 2002:a05:6214:e42:b0:5a3:fffa:f600 with SMTP id o2-20020a0562140e4200b005a3fffaf600mr4643108qvc.26.1680625714699;
        Tue, 04 Apr 2023 09:28:34 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id 73-20020a37074c000000b0074672975d5csm3732410qkh.91.2023.04.04.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:28:34 -0700 (PDT)
Date: Tue, 4 Apr 2023 09:28:32 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: Vasant Hegde <vasant.hegde@amd.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: amd: Set page size bitmap during V2 domain
 allocation
Message-ID: <k6cz5w66mfse7ztgtfy6ux4bjasg64dhbjnliybybcvmoywrs3@gehaolzeh3ph>
References: <20230404072742.1895252-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230404072742.1895252-1-jsnitsel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 04, 2023 at 12:27:42AM -0700, Jerry Snitselaar wrote:
> With the addition of the V2 page table support, the domain page size
> bitmap needs to be set prior to iommu core setting up direct mappings
> for reserved regions. When reserved regions are mapped, if this is not
> done, it will be looking at the V1 page size bitmap when determining
> the page size to use in iommu_pgsize(). When it gets into the actual
> amd mapping code, a check of see if the page size is supported can
> fail, because at that point it is checking it against the V2 page size
> bitmap which only supports 4K, 2M, and 1G.
> 
> Add a check to __iommu_domain_alloc() to not override the
> bitmap if it was already set by the iommu ops domain_alloc() code path.
> 
> Cc: Vasant Hegde <vasant.hegde@amd.com>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Fixes: 4db6c41f0946 ("iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API")
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>



I'm still not sure this is the best solution. Feels odd with adding a
check to core code to handle something one of the drivers has
done. Another thought was something like arm does, with amd_iommu_ops
dropping the const and setting the default page size bitmap in
iommu_init_pci(), but I think that would still require adding
something in the protection domain/init code to deal with it forcing
v1, so it would still require a check in the core code.

Would adding an op make more sense, with a generic op doing what the
core code currently does for setting the default? Or am I overthinking
this?

snits

> ---
>  drivers/iommu/amd/iommu.c | 6 ++----
>  drivers/iommu/iommu.c     | 9 +++++++--
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5a505ba5467e..167da5b1a5e3 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1666,10 +1666,6 @@ static void do_attach(struct iommu_dev_data *dev_data,
>  	domain->dev_iommu[iommu->index] += 1;
>  	domain->dev_cnt                 += 1;
>  
> -	/* Override supported page sizes */
> -	if (domain->flags & PD_GIOV_MASK)
> -		domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
> -
>  	/* Update device table */
>  	set_dte_entry(iommu, dev_data->devid, domain,
>  		      ats, dev_data->iommu_v2);
> @@ -2048,6 +2044,8 @@ static int protection_domain_init_v2(struct protection_domain *domain)
>  
>  	domain->flags |= PD_GIOV_MASK;
>  
> +	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
> +
>  	if (domain_enable_v2(domain, 1)) {
>  		domain_id_free(domain->id);
>  		return -ENOMEM;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 10db680acaed..256a38371120 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1964,8 +1964,13 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>  		return NULL;
>  
>  	domain->type = type;
> -	/* Assume all sizes by default; the driver may override this later */
> -	domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
> +	/*
> +	 * If not already set, assume all sizes by default; the driver
> +	 * may override this later
> +	 */
> +	if (!domain->pgsize_bitmap)
> +		domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
> +
>  	if (!domain->ops)
>  		domain->ops = bus->iommu_ops->default_domain_ops;
>  
> -- 
> 2.38.1
> 

