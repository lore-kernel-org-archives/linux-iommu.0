Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98146B7
	for <iommu@lists.linux.dev>; Mon, 27 Jun 2022 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656357701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tC29q+aNgStWTf3T1gdIerdLoXO+91zXobwFBrVQGCE=;
	b=g6h6zz7DivkRaZXbia2POiltq/gMx+io7DSSOb1cabvfGHnebbnrh+YAjRODjVZOTGhdYN
	KwBuKGOcNr8EsE+DbphL3EmHR9Z9p2B+bFmedNJgs0jn+F3JTJs8TgOhEofd1/QUvvf5v8
	9C0ClaOnjZdlV1dRxLL9uPZjqCtQMI4=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-3PH3GUTKPXSrSeuHh98ESg-1; Mon, 27 Jun 2022 15:21:39 -0400
X-MC-Unique: 3PH3GUTKPXSrSeuHh98ESg-1
Received: by mail-il1-f198.google.com with SMTP id k8-20020a056e02156800b002d91998aef7so6129227ilu.0
        for <iommu@lists.linux.dev>; Mon, 27 Jun 2022 12:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=tC29q+aNgStWTf3T1gdIerdLoXO+91zXobwFBrVQGCE=;
        b=30oZgCYgCQcOIAnbpzOXDs3FgPPxqRXlMA+XO7ASGJtoqU8M9JGmw2MxArgJYngogV
         QMYuA43CYK9jJEzXSP8I/dYd2DlL8DChh7912JDgon7LIfAReWJO3GzeBWWWFSsPfJRA
         Ha63KyL2eooMY4Q38lYP7W576GYQPEF9ohfaKmtDkqA7UTKm7ev47Ipumf2OZawbOvoo
         A7fYdqKOKXs0ekJ8venMvKYoynA7r10PDju+LGpc8SeqhmcvjKc1NbPJ7CFQwoywEaDE
         vUXSLf3gTyDIeQtDTJYLLuI+FzQ0ZoKNYJa0vq5L4NgRCSJC5A8TDF6gtssUcPvpPz/d
         I0XA==
X-Gm-Message-State: AJIora9ZhDP0BUNCCWTbSBrQSKcJFJYhM2l+IsVK5t8zOtt+pkb1/dPr
	sr0Bcf/IOHksteP4u1JrBvMENrnDb5GNpxmpijbgAhpvakBWeGv2O3OfHgKAf+I6CGphE4cuHcl
	P+UwuXE1/3cpqXqw=
X-Received: by 2002:a5e:c016:0:b0:675:398:4713 with SMTP id u22-20020a5ec016000000b0067503984713mr7609127iol.149.1656357698908;
        Mon, 27 Jun 2022 12:21:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ugeHJeLAFVVzGHnn/nqnvt4TYEqjk+64UlN9WD7leHiuAGXnJQAVJhcrElur2pHlk/kXOBWA==
X-Received: by 2002:a5e:c016:0:b0:675:398:4713 with SMTP id u22-20020a5ec016000000b0067503984713mr7609111iol.149.1656357698650;
        Mon, 27 Jun 2022 12:21:38 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id k6-20020a02cb46000000b00331743a983asm3707166jap.179.2022.06.27.12.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:21:38 -0700 (PDT)
Date: Mon, 27 Jun 2022 13:21:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: cohuck@redhat.com, kvm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 jgg@nvidia.com, baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH v3 1/2] vfio/type1: Simplify bus_type determination
Message-ID: <20220627132136.2b902875.alex.williamson@redhat.com>
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
Message-ID: <20220627192136.IFZRlF74n2JNMQ5_5ueuQ2_IgksOwsf_xpSxbnVpBaQ@z>

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
> 
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

Any objection if I add the following comment:

/* Redundantly walks non-present capabilities to simplify caller */

Thanks,
Alex

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

