Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9823C8A
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 13:56:37 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b425so13512455e9.2
        for <iommu@lists.linux.dev>; Thu, 18 May 2023 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684418195; x=1687010195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPzdKdRGQGElWUYovOVhZT8DMwrnx0aSVXCHunf9t6E=;
        b=As/izmzGYSC0uCCOTiNEMEWQHttyHnw/qT5g27C1MUAraum18e9vbbIcd1uBWgx6vC
         cO4wX5OzcnWDndLe9aLvteTZlEcVRzSaBWfOBfjKJfXCaNsbz/9zq7jBbMgnfadwAgGg
         qT2dOdGDo2r3+fmCM5Y6rYMdWd2JrFAZcfOUzNENAGmpnB7yaKulsK3dHXZn+GSSIRim
         Hl4qgHSj7jRacXc9ZvmoDC2ciE0DvQA80mdVGQTyLNjgx3W8Losc8znXsUCxzTfYMK4E
         71BtjV124+dqVQ5yO1QXKPPVW/5Pvyif9WNzbXPsRArmCwsFaQYsM8C3BxAD9ep22EXT
         Ow0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684418195; x=1687010195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPzdKdRGQGElWUYovOVhZT8DMwrnx0aSVXCHunf9t6E=;
        b=X5rXVXQVujnbdRkiCrzkQupCilVnZZqKcS3xX+LZYiHRJmp0k3UZEqDcRc0H9+oL0y
         ahltD80y0TX3dSDhKtD/XWlEAgcNEXbmxp1bfL2O5rr+pew24B7kaEhFGLME5m7GQI7s
         9OIOcBdu6b8ud/IZqhl8WETHgLVYiWuCnwOxEC6F+CZb6xNVdVs4oQmDUIAwp/3XlPdt
         eJSEsK2zlN2NVLP/HuPrHoGUq/t0vreO9oJz7FyvhyCB49FheMT/I0PlWd+vVM8LsXp7
         wxvBblzDOCm+zs7W574Zz3mLhrYMtPa5omcFRqH4CO1W5EJA9uo00TlBlnVuMIdQsa3G
         U3Fw==
X-Gm-Message-State: AC+VfDyFfNSEpEOxVL09w6sYZT5JkQm4iNlatYVZaBM6ESqvBBDiudcN
	kmuCI2iB16Cb3cqYDT4tgfvCTg==
X-Google-Smtp-Source: ACHHUZ4KO5bq7EE1YgvTlu5at/kRF7zYw/DEuhR+gKplRgcp8q22BfKN7YzXPz82nsxzB+jpDTJn0w==
X-Received: by 2002:a05:600c:364c:b0:3f4:2267:10cf with SMTP id y12-20020a05600c364c00b003f4226710cfmr1548896wmq.32.1684418195586;
        Thu, 18 May 2023 06:56:35 -0700 (PDT)
Received: from myrica (5750a5b3.skybroadband.com. [87.80.165.179])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c204400b003f0aefcc457sm5554965wmg.45.2023.05.18.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 06:56:35 -0700 (PDT)
Date: Thu, 18 May 2023 14:56:38 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	eric.auger@redhat.com, virtualization@lists.linux-foundation.org,
	iommu@lists.linux.dev, akihiko.odaki@daynix.com
Subject: Re: [PATCH] iommu/virtio: Detach domain on endpoint release
Message-ID: <20230518135638.GB2587493@myrica>
References: <20230414150744.562456-1-jean-philippe@linaro.org>
 <20230510081157.GA3326511@myrica>
 <ZGT+44a6RYZ999kz@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGT+44a6RYZ999kz@nvidia.com>

On Wed, May 17, 2023 at 01:20:51PM -0300, Jason Gunthorpe wrote:
> On Wed, May 10, 2023 at 09:11:57AM +0100, Jean-Philippe Brucker wrote:
> 
> > > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > > index 5b8fe9bfa9a5..3d3d4462359e 100644
> > > --- a/drivers/iommu/virtio-iommu.c
> > > +++ b/drivers/iommu/virtio-iommu.c
> > > @@ -788,6 +788,28 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > >  	return 0;
> > >  }
> > >  
> > > +static void viommu_detach_dev(struct viommu_endpoint *vdev)
> > > +{
> > > +	int i;
> > > +	struct virtio_iommu_req_detach req;
> > > +	struct viommu_domain *vdomain = vdev->vdomain;
> > > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
> > > +
> > > +	if (!vdomain)
> > > +		return;
> > > +
> > > +	req = (struct virtio_iommu_req_detach) {
> > > +		.head.type	= VIRTIO_IOMMU_T_DETACH,
> > > +		.domain		= cpu_to_le32(vdomain->id),
> > > +	};
> > > +
> > > +	for (i = 0; i < fwspec->num_ids; i++) {
> > > +		req.endpoint = cpu_to_le32(fwspec->ids[i]);
> > > +		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
> > > +	}
> > > +	vdev->vdomain = NULL;
> 
> Not for this patch, but something to work on..
> 
> I assume detach disconnects the container on the VFIO side and puts it
> into a BLOCKED state?

At the moment that depends on the VMM boot-bypass policy: if virtio-iommu
is booted with global-bypass set, then detaching will go back to an
identity-mapped container, not a BLOCKED state. If the global-bypass bit
is clear, then it does go back to a BLOCKED state. However QEMU has a
default policy of boot-bypass (because that allows booting a firmware or
OS that doesn't have the IOMMU drivers).

The driver can clear the global-bypass bit to change this behavior, but at
the moment we just follow the VMM boot policy.

> 
> Can you wrapper this into a BLOCKED domain like we are moving drivers
> toward, and then attach the blocked domain instead of introducing this
> special case?

Yes, I think the way the virtio-iommu driver should implement BLOCKED
domains is initially clearing the global-bypass bit, and then issuing
DETACH requests when the core asks to attach a BLOCKED domain. This has
the same effect as issuing an ATTACH request with an empty domain, but
requires fewer resources in the VMM.

Thanks,
Jean

> 
> I've been thinking about having some core code support to do fairly
> common pattern of 'parking' the iommu at some well defined translation
> mode, BLOCKED in this case.
> 
> Thanks,
> Jason
