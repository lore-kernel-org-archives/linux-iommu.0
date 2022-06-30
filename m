Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD6EC43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 19:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 34A2C40B07;
	Thu, 30 Jun 2022 19:52:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34A2C40B07
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UG48SxDL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BNaviqEHcTF9; Thu, 30 Jun 2022 19:52:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D9C3B40A2A;
	Thu, 30 Jun 2022 19:52:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D9C3B40A2A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A949FC002D;
	Thu, 30 Jun 2022 19:52:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D28A8C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 19:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9885440AFD
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 19:52:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9885440AFD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b1ACamg_LMZA for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 19:52:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AEB5F40A2A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AEB5F40A2A
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 19:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656618752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iiVi3fBF+mPpX5wbqqQkr9ugeLmDT4STERjx4L3diUc=;
 b=UG48SxDLle4MxmARti090+wA17C6PFzVluevoeelUu4WQ6hYvRKuMkJHujOwFgcsCf2A2I
 iiao/C1ckPFT/mwOUmlx5GVJx3Ve2O3+SEPm8kOLNm4t5PCagKkox3WsrI9nkD8A52qYC4
 k23fhGIZSo0IrZhIVDYAqD/BuPfTyQU=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-JMMUtaAwOzaRpseKcXCK9g-1; Thu, 30 Jun 2022 15:52:28 -0400
X-MC-Unique: JMMUtaAwOzaRpseKcXCK9g-1
Received: by mail-il1-f199.google.com with SMTP id
 l4-20020a056e021aa400b002dab8f7402dso30998ilv.18
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 12:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=iiVi3fBF+mPpX5wbqqQkr9ugeLmDT4STERjx4L3diUc=;
 b=JuRomDOlQ41X5iMbVG01xh8ZHbtwMBK2IXBtXPqdXreNlRLiGdGLUzj7c3LZLrcK48
 gNU9Qj6H8QyRDyZbZE6EhhkovNYwNuef6YU55zIsOEHBo9Jei53n1gn7/M/uE/kq2pMm
 7J5cKjYhUcNy+MW3MwNG3pXRfAQBxGwt3UyNLyjZVqq1ktAk1T2eaRW7L+gt/tcxpEHG
 bWeDS5aBIKbfhXUBymev6dX0Z2qXqUZvvdcFtpaL2SEufBGyqmOHGjqVbLf+8GiFnDeU
 3fsKE6tgPeGTVtPJHoUniF84ebcMGjwpgxJmL1LpuZSPOB7n3OqKQOoUqMLE6HiBstRF
 U/1w==
X-Gm-Message-State: AJIora8y2Poo8YTnvfKp4e9OC+e+BwtkIc8hhDup8y/2g0Mg1DXGz9yE
 zK/q1HmhRyPMRt9/8yYkj16PzxIqxROMcsUnI7tqvsohlihvvC1/XwmejWpzgOMafhAFFok2FB4
 IeDRUwPuANE8rL/yQLYdwudBgdHZ4aA==
X-Received: by 2002:a05:6e02:801:b0:2da:7df7:e7c3 with SMTP id
 u1-20020a056e02080100b002da7df7e7c3mr6525100ilm.105.1656618748077; 
 Thu, 30 Jun 2022 12:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vkcx78ZXPwxRMS/yFesIoGgG1FqqC2U1FIf/UNHUpZkOUixKiDM+yOoVa7ZRUViTNNlMeFDg==
X-Received: by 2002:a05:6e02:801:b0:2da:7df7:e7c3 with SMTP id
 u1-20020a056e02080100b002da7df7e7c3mr6525083ilm.105.1656618747724; 
 Thu, 30 Jun 2022 12:52:27 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 x42-20020a0294ad000000b00330c5581c03sm8880286jah.1.2022.06.30.12.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 12:52:26 -0700 (PDT)
Date: Thu, 30 Jun 2022 13:51:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/2] vfio/type1: Simplify bus_type determination
Message-ID: <20220630135145.30fd18d1.alex.williamson@redhat.com>
In-Reply-To: <194a12d3434d7b38f84fa96503c7664451c8c395.1656092606.git.robin.murphy@arm.com>
References: <194a12d3434d7b38f84fa96503c7664451c8c395.1656092606.git.robin.murphy@arm.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jgg@nvidia.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

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

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
