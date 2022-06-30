Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD817462
	for <iommu@lists.linux.dev>; Thu, 30 Jun 2022 19:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656618751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iiVi3fBF+mPpX5wbqqQkr9ugeLmDT4STERjx4L3diUc=;
	b=QnN4ciRtlpqQhOlOu/iXdHUXqA4cHtc7QGTV5Hsd6nooZVh2n7j9eoRfN9mwT6mnjwgOBU
	IZxgUmm7RB/6mJ66ZTn5mSgHuG7YxeEgVIeq7VhxCBsYAXQPwbpoz5ugIQ9fKtK+GoNO8i
	38fxsdn2wNXZYSEyQKSWaq5K+anvPak=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-s09bmHpIPf6G9oALgWLD1w-1; Thu, 30 Jun 2022 15:52:28 -0400
X-MC-Unique: s09bmHpIPf6G9oALgWLD1w-1
Received: by mail-io1-f71.google.com with SMTP id y22-20020a056602215600b00673b11a9cd5so107593ioy.7
        for <iommu@lists.linux.dev>; Thu, 30 Jun 2022 12:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=iiVi3fBF+mPpX5wbqqQkr9ugeLmDT4STERjx4L3diUc=;
        b=t7kF464pMCvW6PRxPZ+hfAq6vCdz5eRQYEEgjvPHfnenIvZJnYOrMQ6DadsaGHuqHo
         DxA3VsLJG+RKXqY/kyoBpJi0mysX6GXDmummzASLvYgjG7Fk9V137y7V28a9GqTUm+Dp
         sUokfay1e2FcH2FDd8IQsqD50XxiSqUag/o3Wwrm2Y28OdkxMCfJssWFchBFKOZXqp6c
         GO1S0qlVEsrYPyOW3JdHRKeLbmuWdnvuSCJpLBIaOpo+iXvzhCSYUEN2ty8wvlEMANaa
         R0bq40lK+7l94qit1S1S2T7BZ+ad0QIyo4ufpDOuvNeY8eptBcpHWOucF/5c5AWPR0ls
         vSfw==
X-Gm-Message-State: AJIora9be9xCmXRfJO+vqkDP3Rmui+XfdXFt9PY+N6stbC2jPuyo0CVL
	9NV4y6bRFSs2oCtNgS8Ng/nW7jQm/9VnVIe6CZBXk4rsn6O7yvNqxvtXtSHqYl8d6gVFZO/bHQh
	z54EujC2xMxipeZ8=
X-Received: by 2002:a05:6e02:801:b0:2da:7df7:e7c3 with SMTP id u1-20020a056e02080100b002da7df7e7c3mr6525096ilm.105.1656618748076;
        Thu, 30 Jun 2022 12:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vkcx78ZXPwxRMS/yFesIoGgG1FqqC2U1FIf/UNHUpZkOUixKiDM+yOoVa7ZRUViTNNlMeFDg==
X-Received: by 2002:a05:6e02:801:b0:2da:7df7:e7c3 with SMTP id u1-20020a056e02080100b002da7df7e7c3mr6525083ilm.105.1656618747724;
        Thu, 30 Jun 2022 12:52:27 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x42-20020a0294ad000000b00330c5581c03sm8880286jah.1.2022.06.30.12.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:52:26 -0700 (PDT)
Date: Thu, 30 Jun 2022 13:51:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: cohuck@redhat.com, kvm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 jgg@nvidia.com, baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH v3 1/2] vfio/type1: Simplify bus_type determination
Message-ID: <20220630135145.30fd18d1.alex.williamson@redhat.com>
In-Reply-To: <194a12d3434d7b38f84fa96503c7664451c8c395.1656092606.git.robin.murphy@arm.com>
References: <194a12d3434d7b38f84fa96503c7664451c8c395.1656092606.git.robin.murphy@arm.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <20220630195145.AvDWcHP73NPN-Rk_FBd8eomWDBrE9J6W2C4sS-1yWEM@z>

On Fri, 24 Jun 2022 18:51:44 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> Since IOMMU groups are mandatory for drivers to support, it stands to
> reason that any device which has been successfully added to a group
> must be on a bus supported by that IOMMU driver, and therefore a domain
> viable for any device in the group must be viable for all devices in
> the group. This already has to be the case for the IOMMU API's internal
> default domain, for instance. Thus even if the group contains devices on
> different buses, that can only mean that the IOMMU driver actually
> supports such an odd topology, and so without loss of generality we can
> expect the bus type of any device in a group to be suitable for IOMMU
> API calls.
> 
> Furthermore, scrutiny reveals a lack of protection for the bus being
> removed while vfio_iommu_type1_attach_group() is using it; the reference
> that VFIO holds on the iommu_group ensures that data remains valid, but
> does not prevent the group's membership changing underfoot.
> 
> We can address both concerns by recycling vfio_bus_type() into some
> superficially similar logic to indirect the IOMMU API calls themselves.
> Each call is thus protected from races by the IOMMU group's own locking,
> and we no longer need to hold group-derived pointers beyond that scope.
> It also gives us an easy path for the IOMMU API's migration of bus-based
> interfaces to device-based, of which we can already take the first step
> with device_iommu_capable(). As with domains, any capability must in
> practice be consistent for devices in a given group - and after all it's
> still the same capability which was expected to be consistent across an
> entire bus! - so there's no need for any complicated validation.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---

Applied series to vfio next branch for v5.20.  Thanks,

Alex


> v3: Complete rewrite yet again, and finally it doesn't feel like we're
> stretching any abstraction boundaries the wrong way, and the diffstat
> looks right too. I did think about embedding IOMMU_CAP_INTR_REMAP
> directly in the callback, but decided I like the consistency of minimal
> generic wrappers. And yes, if the capability isn't supported then it
> does end up getting tested for the whole group, but meh, it's harmless.
> 
>  drivers/vfio/vfio_iommu_type1.c | 42 +++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c13b9290e357..a77ff00c677b 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1679,18 +1679,6 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> -static int vfio_bus_type(struct device *dev, void *data)
> -{
> -	struct bus_type **bus = data;
> -
> -	if (*bus && *bus != dev->bus)
> -		return -EINVAL;
> -
> -	*bus = dev->bus;
> -
> -	return 0;
> -}
> -
>  static int vfio_iommu_replay(struct vfio_iommu *iommu,
>  			     struct vfio_domain *domain)
>  {
> @@ -2153,13 +2141,25 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
>  	list_splice_tail(iova_copy, iova);
>  }
>  
> +static int vfio_iommu_device_capable(struct device *dev, void *data)
> +{
> +	return device_iommu_capable(dev, (enum iommu_cap)data);
> +}
> +
> +static int vfio_iommu_domain_alloc(struct device *dev, void *data)
> +{
> +	struct iommu_domain **domain = data;
> +
> +	*domain = iommu_domain_alloc(dev->bus);
> +	return 1; /* Don't iterate */
> +}
> +
>  static int vfio_iommu_type1_attach_group(void *iommu_data,
>  		struct iommu_group *iommu_group, enum vfio_group_type type)
>  {
>  	struct vfio_iommu *iommu = iommu_data;
>  	struct vfio_iommu_group *group;
>  	struct vfio_domain *domain, *d;
> -	struct bus_type *bus = NULL;
>  	bool resv_msi, msi_remap;
>  	phys_addr_t resv_msi_base = 0;
>  	struct iommu_domain_geometry *geo;
> @@ -2192,18 +2192,19 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  		goto out_unlock;
>  	}
>  
> -	/* Determine bus_type in order to allocate a domain */
> -	ret = iommu_group_for_each_dev(iommu_group, &bus, vfio_bus_type);
> -	if (ret)
> -		goto out_free_group;
> -
>  	ret = -ENOMEM;
>  	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>  	if (!domain)
>  		goto out_free_group;
>  
> +	/*
> +	 * Going via the iommu_group iterator avoids races, and trivially gives
> +	 * us a representative device for the IOMMU API call. We don't actually
> +	 * want to iterate beyond the first device (if any).
> +	 */
>  	ret = -EIO;
> -	domain->domain = iommu_domain_alloc(bus);
> +	iommu_group_for_each_dev(iommu_group, &domain->domain,
> +				 vfio_iommu_domain_alloc);
>  	if (!domain->domain)
>  		goto out_free_domain;
>  
> @@ -2258,7 +2259,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	list_add(&group->next, &domain->group_list);
>  
>  	msi_remap = irq_domain_check_msi_remap() ||
> -		    iommu_capable(bus, IOMMU_CAP_INTR_REMAP);
> +		    iommu_group_for_each_dev(iommu_group, (void *)IOMMU_CAP_INTR_REMAP,
> +					     vfio_iommu_device_capable);
>  
>  	if (!allow_unsafe_interrupts && !msi_remap) {
>  		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",

