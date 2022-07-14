Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB4184
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 13:00:44 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so1162103wmb.5
        for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oyGofj7adAy+ioh++szahjgmRi11ejZPUA5+K3Ca9do=;
        b=T5QWHjEb9MFsZO+WOG3HyJouzePFH2fVUtERQ1Z26Mdd0hzbEEn3VCFHxMx7vUtCkw
         HaN/I5LldKr3T8rl8Ferjwk6MscqJWzTveaSRTucHeeOX/cmy6dP1rTL8qDStnVyvSQf
         NxhgmlLOPZ854HzLMRZ5fPndUMDBMN3ahstr0Cnm5Ele2Ztp8fNZgv0AC0DuIFqt5QFt
         Y8wKZS8t1jelVB5RGEXUAaaw0nJESG+rWiqmE7a76W8sp7zw1by9Ns6uToFjxD7lmBNo
         Ub+1TkCcc1VzB1IA87jzfEZ6a81gTn0nVb8VSeUVPnfYHaYx/4TCpDd4GDKAHQCqm09Z
         QROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oyGofj7adAy+ioh++szahjgmRi11ejZPUA5+K3Ca9do=;
        b=aMQnjsMd9Zjy2k+Xk8y5AC4yLzktFYSDVlQRWhbfrugQm0nCjAzxG73Z+xcUQ4Vjuv
         3JaF3/3ijCWyRvOXhwJcqHAt0WP2uO3MZMQb63YzuW32hWfbiMzG+GMF6Pz4GZDV32bo
         ry9Y6k+MUa4I0506uPX6+JReJbvIUgZ83fmqnhgf8kl2Ido9pKTeRHLpwPyDOlOUUKu8
         upEAW431J3u33Bxw4cusRfUvgKqd54MnOiINQJvtq67XwSzG1QwYXVLOIVO+PIhnvtRU
         jsDF8yUZLePBL9JiuQ3MF1ClQGhBeOvCW/k6PXA1Q5kFYFBw7BTfszSSlFYZ7CmLx2Gd
         ktDQ==
X-Gm-Message-State: AJIora/dYAzFlINKyXBBdMGRPKErbN5gJWMRjd5Dg0Asnn6IH71N3jBS
	EdGWF18PBWabzACKKfNqp92lmQ==
X-Google-Smtp-Source: AGRyM1uDVqWiyBJuqbvSTtI0Tvld6fOuVDXwdAwFgrDQUlfh95fa39o2B8aN5yyqyPM452sqvizX2w==
X-Received: by 2002:a1c:ed05:0:b0:3a2:ebae:c5e7 with SMTP id l5-20020a1ced05000000b003a2ebaec5e7mr8847103wmh.78.1657803642657;
        Thu, 14 Jul 2022 06:00:42 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id m65-20020a1ca344000000b0039c5a765388sm1873497wme.28.2022.07.14.06.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:00:42 -0700 (PDT)
Date: Thu, 14 Jul 2022 14:00:17 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	eric.auger@redhat.com
Subject: Re: [PATCH] iommu/virtio: Advertise IOMMU_CAP_CACHE_COHERENCY
Message-ID: <YtATYaBOz5UnTNC6@myrica>
References: <20220714111059.708735-1-jean-philippe@linaro.org>
 <f701a947-3b93-d47e-f806-fd47d281d371@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f701a947-3b93-d47e-f806-fd47d281d371@arm.com>

On Thu, Jul 14, 2022 at 01:01:37PM +0100, Robin Murphy wrote:
> On 2022-07-14 12:11, Jean-Philippe Brucker wrote:
> > Fix virtio-iommu interaction with VFIO, as VFIO now requires
> > IOMMU_CAP_CACHE_COHERENCY. virtio-iommu does not support non-cacheable
> > mappings, and always expects to be called with IOMMU_CACHE.
> 
> Can we know this is actually true though? What if the virtio-iommu
> implementation is backed by something other than VFIO, and the underlying
> hardware isn't coherent? AFAICS the spec doesn't disallow that.

Right, I should add a note about that. If someone does actually want to
support non-coherent device, I assume we'll add a per-device property, a
'non-cacheable' mapping flag, and IOMMU_CAP_CACHE_COHERENCY will hold.
I'm also planning to add a check on (IOMMU_CACHE && !IOMMU_NOEXEC) in
viommu_map(), but not as a fix.

In the meantime we do need to restore VFIO support under virtio-iommu,
since userspace still expects that to work, and the existing use-cases are
coherent devices.

Thanks,
Jean

> 
> Thanks,
> Robin.
> 
> > Fixes: e8ae0e140c05 ("vfio: Require that devices support DMA cache coherence")
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >   drivers/iommu/virtio-iommu.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index 25be4b822aa0..bf340d779c10 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -1006,7 +1006,18 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
> >   	return iommu_fwspec_add_ids(dev, args->args, 1);
> >   }
> > +static bool viommu_capable(enum iommu_cap cap)
> > +{
> > +	switch (cap) {
> > +	case IOMMU_CAP_CACHE_COHERENCY:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> >   static struct iommu_ops viommu_ops = {
> > +	.capable		= viommu_capable,
> >   	.domain_alloc		= viommu_domain_alloc,
> >   	.probe_device		= viommu_probe_device,
> >   	.probe_finalize		= viommu_probe_finalize,
