Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AA23C0A
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 20:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680122907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pTS1PgCw3AEBHZ51sajDeoL2CJG7P5WUpkR+jLf6yMc=;
	b=NFWmTnEWabJFK1NriDXbku9usgKz7wb1ReUvTbbbCam06eOA0WA6iuZqger8FQ93ZF3sj5
	aAqY+PDx+jfdZNbwzVNKUaFlzNphx3DwdkvcCMwQVdfUU98x6z8kOMStoEwfoWaJ/0Urc+
	/QHe7i+A/TPPEUcfEZp+iiPYGPT54Ok=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-uSnWu0JpOumuuS0LbvdTmA-1; Wed, 29 Mar 2023 16:48:26 -0400
X-MC-Unique: uSnWu0JpOumuuS0LbvdTmA-1
Received: by mail-qt1-f198.google.com with SMTP id a11-20020ac85b8b000000b003e3979be6abso10969779qta.12
        for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 13:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680122906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTS1PgCw3AEBHZ51sajDeoL2CJG7P5WUpkR+jLf6yMc=;
        b=UNNF0IX5T72v2qdT4HDipyUHMeF8vvhLGbT/Lrt/m5FwhPwkaOyaHXfqPBKR8KdKju
         GXdFtgWjT0M9N42KMzHZ29ymO1HibC05w6vZ9KkefalobPS8jrjusnGbfm0dP6Hy52vJ
         MBzK8kCFVMARdqWG10Go47TQ7pHJqHeE0ssSQAgPMwPXNFSzxtSWrvVGomQmAg1xDM+2
         uDCnNHLtD+uhJUlGffwqVMdrLwpFHMPGDXam6eBSikpUG1mgqd2T5F0s7Xj+aE5PaMjs
         aMQtyUehcfNATaSpN/BS9mZrennf8KGYO1f8iO1nilsK4S+uTFZI0cB9aV6AdEJgi+uh
         B0Uw==
X-Gm-Message-State: AAQBX9fdJW25aUqrsE09ZRrXuXYSTva8BaAGEmJ5lKD7WWiRbzLGk2Qq
	CMGGqrxNylJROnGwTpv1nxuUdLoZpymhpRzHVyia7SjolDH6dimf0Dfr1LP/b/dba1TJWkjCl/v
	hdFaWPO7YJUS7Dik=
X-Received: by 2002:a05:6214:501a:b0:56b:fb30:49c6 with SMTP id jo26-20020a056214501a00b0056bfb3049c6mr32493896qvb.50.1680122906076;
        Wed, 29 Mar 2023 13:48:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350atvrZoX6/zWeUgawmQce0yPgQp/AwmhDWCKoYiWNU4xPCWYtOIv8Gz3iTS7A0TC2UImicC3A==
X-Received: by 2002:a05:6214:501a:b0:56b:fb30:49c6 with SMTP id jo26-20020a056214501a00b0056bfb3049c6mr32493875qvb.50.1680122905793;
        Wed, 29 Mar 2023 13:48:25 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id r80-20020a374453000000b007465ee178a3sm17631570qka.96.2023.03.29.13.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 13:48:25 -0700 (PDT)
Date: Wed, 29 Mar 2023 13:48:23 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Reserved Memory Regions (was: AMD v2 page tables)
Message-ID: <6zanf6rxogeyaiavva2e5z2b3vdjod4bzyddy2o73xpuhf3lym@zwag664axipl>
References: <bfugskdi4oawsiqobmarhifwh2iy55av6unl2yuvbjyludy7cn@lw3pgvhuk52a>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <bfugskdi4oawsiqobmarhifwh2iy55av6unl2yuvbjyludy7cn@lw3pgvhuk52a>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 27, 2023 at 11:33:12PM -0700, Jerry Snitselaar wrote:
> I was looking at this the other day, and by chance booted it up on a
> system with a megaraid_sas controller in it. So it had an IVMD block
> for the scratchpad or whatever it is they do. During probing
> iommu_create_device_direct_mappings() gets called, and pgsize_bitmap
> for the iommu_domain is set to the V1 bitmap because that is the
> amd_iommu_ops default. So iommu_pgsize() uses that to figure out what
> page size to use for the mapping. Then when it gets into the amd
> mapping code it checks that page size against the io_pgtable_cfg
> pgsize_bitmap, which is set to the V2 bitmap, sees that it isn't
> a supported page size, and bails out of iommu_v2_map_pages().
> 
> The following worked, but I'm not sure it is the right answer.
> 
> Regards,
> Jerry
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5a505ba5467e..040199ac8546 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2048,6 +2048,8 @@ static int protection_domain_init_v2(struct protection_domain *domain)
>  
>  	domain->flags |= PD_GIOV_MASK;
>  
> +	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
> +
>  	if (domain_enable_v2(domain, 1)) {
>  		domain_id_free(domain->id);
>  		return -ENOMEM;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 10db680acaed..e70e5cbec8cc 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1964,8 +1964,13 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>  		return NULL;
>  
>  	domain->type = type;
> -	/* Assume all sizes by default; the driver may override this later */
> -	domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
> +	/*
> +	 * Assume all sizes by default if not already set;
> +	 * the driver may override this later
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

Hi Will and Robin,

Is this a potential issue for arm with the recent RMR changes, and the default page size bitmap being -1UL?
Where I ran into this for the AMD code was in the loop in bus_iommu_probe():

		/* Try to allocate default domain */
		probe_alloc_default_domain(bus, group);

		if (!group->default_domain) {
			mutex_unlock(&group->mutex);
			continue;
		}

		iommu_group_create_direct_mappings(group);

		ret = __iommu_group_dma_first_attach(group);



IIUC, arm will set the domain bitmap with the attach after the call to iommu_group_create_direct_mappings()?

Regards,
Jerry

