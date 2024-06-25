Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C70143882
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719344322; cv=none; b=ioSQt11diV3XuviOjJeSTAGvaeD+FY5xBaDaPvdTj32AZl9adg59CYlheokEa8EupKbV1ZIB2zSex+shTDH+0ooH7xa6Yc3XGzJDf0FMYAlYVJ2kZK/2u6LuFkx12mXDfMBSwh9q1qBUx4SZHDsBpQWE7pa/MRX5BkI6bpjIq0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719344322; c=relaxed/simple;
	bh=smp2ik4sesowoeHGePGZp0A/nv0cfx+I0/bHtSoSzAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dhdCZfIKwuNi0LDMIyVn7TBAFiajinO9GWfM+3XRPUq/7jbSuV6N3OSzEzg19aTKWSVpswvicpwxcgq29qGKtmiBCqfLqFZjJOl+4Uq+FaTlC3br3FB9YSKFfzKG3Z67qzf8ExAfphzO3daOIUYndkT5z6PFO6WG+xo4PdM19yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvDXNm+E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvDXNm+E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719344319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tiicmrxufpLWZOOT5mOAzPnOHjW2mk2qIKhjgTBOntI=;
	b=RvDXNm+ERoma6JtiTAIq0gPfruh1BU9KhlqyMtq02icl2oBV1cCVu1NwrwQ7y7h9pKoR4N
	JpbsWDzCDV86niacPDFnz6tUbfnAEFCKabpi3eFZkpWVjktMMwbf4XG/PlDA7jBtOz1Bjf
	CzYd7wAc0LrS6C+eW/oWM/g2/iRw55A=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-XnqNHcSbPhyKjUyyU5m54Q-1; Tue, 25 Jun 2024 15:38:37 -0400
X-MC-Unique: XnqNHcSbPhyKjUyyU5m54Q-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-dfa73db88dcso11750460276.0
        for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 12:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719344317; x=1719949117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiicmrxufpLWZOOT5mOAzPnOHjW2mk2qIKhjgTBOntI=;
        b=psoTExCiaDlHnHfQqCdVeUWt5RWCRLacvVspP1H9/br3oBbEmF+vZUUcbX5K6YRrV+
         xHGY0doJD8Fb1qjgOUuZBhLOhtzfMHR7lTPSLZJSwm6cxz3mxGVef4yBDloSEpo7PL+U
         ahg3SYP8qwM53/7p1OBwDVMrhx4cd645RJf/HEx1BL5Fa5mOokVycyOQakjJJXd/Wm/a
         msmVB2HdBzr1766ti/WYro10pcihSNcKlDnlWNt0LsySve8XPwdQG8X8ydJSs8q8tYaH
         Tr3Mec8nQw4jzha+GyiXWoqDNFg9iodOo2KeC/4zNFdpAFWh111RCOJiR28RdGZ70/EA
         0gTg==
X-Gm-Message-State: AOJu0YyQ9LSLHUA2/vKVrylupc7G6lMGihnqMT3+fEpEe1C0GXWPDFQY
	C7CV58hGpyN3CpwLE0XtsPMg4jk0ehBupu9ZWOtxJ2ZwAPK6jDAXx1593kTzP2Wuw846v4uc1G5
	Y6QgP82MWfFFBZ6eytLykb2pjD1+B11UzSSN3WEhaIsis+it7GWdI
X-Received: by 2002:a5b:dc1:0:b0:de6:71e:584c with SMTP id 3f1490d57ef6-e03040089aamr7772914276.47.1719344317171;
        Tue, 25 Jun 2024 12:38:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd059eejdNurR6TjJ/TEp0aAEmUIIY3hTlR0AE0F1DBiGo7iSDwo37Q7OBL9R09KaFyvcQAQ==
X-Received: by 2002:a5b:dc1:0:b0:de6:71e:584c with SMTP id 3f1490d57ef6-e03040089aamr7772896276.47.1719344316832;
        Tue, 25 Jun 2024 12:38:36 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2ba38edsm58990901cf.53.2024.06.25.12.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 12:38:36 -0700 (PDT)
Date: Tue, 25 Jun 2024 12:38:35 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	FahHean Lee <fahhean.lee@amd.com>, Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>, 
	Sairaj Arun Kodilkar <sairaj.arunkodilkar@amd.com>
Subject: Re: [PATCH rc] iommu/amd: Invalidate cache before removing device
 from domain list
Message-ID: <w4naumqh46gy7pt3etuhgycsvh5tukdphmugm545xpcbeunb5g@spjqujks4hux>
References: <20240620060552.13984-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240620060552.13984-1-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2024 at 06:05:52AM GMT, Vasant Hegde wrote:
> Commit 87a6f1f22c97 ("iommu/amd: Introduce per-device domain ID to fix
> potential TLB aliasing issue") introduced per device domain ID when
> domain is configured with v2 page table. And in invalidation path, it
> uses per device structure (dev_data->gcr3_info.domid) to get the domain ID.
> 
> In detach_device() path, current code tries to invalidate IOMMU cache
> after removing dev_data from domain device list. This means when domain
> is configured with v2 page table, amd_iommu_domain_flush_all() will not be
> able to invalidate cache as device is already removed from domain device
> list.
> 
> This is causing change domain tests (changing domain type from identity to DMA)
> to fail with IO_PAGE_FAULT issue.
> 
> Hence invalidate cache and update DTE before updating data structures.
> 
> Reported-by: FahHean Lee <fahhean.lee@amd.com>
> Reported-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Fixes: 87a6f1f22c97 ("iommu/amd: Introduce per-device domain ID to fix potential TLB aliasing issue")
> Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Tested-by: Sairaj Arun Kodilkar <sairaj.arunkodilkar@amd.com>
> Tested-by: FahHean Lee <fahhean.lee@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/iommu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index c2703599bb16..b19e8c0f48fa 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2061,6 +2061,12 @@ static void do_detach(struct iommu_dev_data *dev_data)
>  	struct protection_domain *domain = dev_data->domain;
>  	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
>  
> +	/* Clear DTE and flush the entry */
> +	amd_iommu_dev_update_dte(dev_data, false);
> +
> +	/* Flush IOTLB and wait for the flushes to finish */
> +	amd_iommu_domain_flush_all(domain);
> +
>  	/* Clear GCR3 table */
>  	if (pdom_is_sva_capable(domain))
>  		destroy_gcr3_table(dev_data, domain);
> @@ -2069,12 +2075,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
>  	dev_data->domain = NULL;
>  	list_del(&dev_data->list);
>  
> -	/* Clear DTE and flush the entry */
> -	amd_iommu_dev_update_dte(dev_data, false);
> -
> -	/* Flush IOTLB and wait for the flushes to finish */
> -	amd_iommu_domain_flush_all(domain);
> -
>  	/* decrease reference counters - needs to happen after the flushes */
>  	domain->dev_iommu[iommu->index] -= 1;
>  	domain->dev_cnt                 -= 1;
> -- 
> 2.31.1
> 

