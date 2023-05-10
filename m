Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A41F64F
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 16:20:45 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f42c865535so21161365e9.1
        for <iommu@lists.linux.dev>; Wed, 10 May 2023 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683735644; x=1686327644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Obt8pVoKfz1tH1SqzwUaz8mcp0zUYaijmYQeIqh31d0=;
        b=xQhhCDipjC0f0UqWuzN265VPFF8YOekzAEDhbBPlCrQomMsy6nQOEcAH9GQipyo2Af
         3AKt5rhNWfyuHm4wiTbygvVCyRK+eFVelkvq9YI+Pgocnu0/G52koiBX+Dy+LG04UPLl
         8Z1IGWZx3wxr+FZ2+zMD2V85UMGdtDqpxP0FOOOdS3iskdzGS6bxS2pnY6wofeuxiPmz
         oqYmHIH5dO6ZNxIYXD55A+uI3kXeUSDUfkBIjc/EtWy4YCGYlFK2kMzkEDyX5Hk6yRhp
         fKTKtVEh+U3EUYvyfFNny7xhgFxK4P8NlXKpup/3WuG7yMpAnk+DCFBVLTIq+fK/9JOY
         oxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683735644; x=1686327644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Obt8pVoKfz1tH1SqzwUaz8mcp0zUYaijmYQeIqh31d0=;
        b=LcFl52/DstxMwIw//2SgcD8j9vwpSv/gTwbDx9k/3AUW01p87oI1211mr9tVz7/C7L
         OrWok0dnMMtHDUfZaXG3rfjXPZ7qEJvb2+mz9oeOzKegxrgMgt6HXhekgjTYNfu7hp3V
         XA/lizM9VCeb7H37QPPxwfq7fdCg92U0VAdx2yVqY2Ee64vy95JxoB8slVyy538ZjV+v
         eLcSeua56wmg0xKEY4qRgavhfydshaD/f8hiAdRWRQ/qj9coWtw+pzTW7KjKhtZDtjT3
         PYrkqK3MpiFTOPUmdeU07TQDbCuf239h/1W1HgeLYTAQVSC4rjeCfSXqMCd0ugGBTpSV
         79xg==
X-Gm-Message-State: AC+VfDzCZD8mXeJ9k6vD5R7T3GsbFetNp+pDhv1QY/UfguwIiz5j57ag
	G6nljE5MNG/EH9Lxh/0d4GfGLbFVDGvELfWSx0ES8A==
X-Google-Smtp-Source: ACHHUZ5fATrqXEHKAu4umZysP4EZQVdpN9F4L+0yZryOi2EdhCPvsVeCsvyhDKqUSUhwrZ3qx+QjfQ==
X-Received: by 2002:a05:600c:2201:b0:3f4:253b:92ae with SMTP id z1-20020a05600c220100b003f4253b92aemr7317004wml.0.1683735644170;
        Wed, 10 May 2023 09:20:44 -0700 (PDT)
Received: from myrica (5750a5b3.skybroadband.com. [87.80.165.179])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bc5d7000000b003ee74c25f12sm23222570wmk.35.2023.05.10.09.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 09:20:43 -0700 (PDT)
Date: Wed, 10 May 2023 17:20:34 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	akihiko.odaki@daynix.com
Subject: Re: [PATCH] iommu/virtio: Detach domain on endpoint release
Message-ID: <20230510162034.GA3390634@myrica>
References: <20230414150744.562456-1-jean-philippe@linaro.org>
 <e58c48e0-6339-41ec-e65b-e3104c65bb81@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e58c48e0-6339-41ec-e65b-e3104c65bb81@redhat.com>

On Wed, May 10, 2023 at 05:37:22PM +0200, Eric Auger wrote:
> Hi Jean,
> 
> On 4/14/23 17:07, Jean-Philippe Brucker wrote:
> > When an endpoint is released, for example a PCIe VF is disabled or a
> > function hot-unplugged, it should be detached from its domain. Send a
> > DETACH request.
> >
> > Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> > Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Link: https://lore.kernel.org/all/15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com/
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  drivers/iommu/virtio-iommu.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index 5b8fe9bfa9a5..3d3d4462359e 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -788,6 +788,28 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >  	return 0;
> >  }
> >  
> > +static void viommu_detach_dev(struct viommu_endpoint *vdev)
> > +{
> > +	int i;
> > +	struct virtio_iommu_req_detach req;
> > +	struct viommu_domain *vdomain = vdev->vdomain;
> > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
> > +
> > +	if (!vdomain)
> > +		return;
> > +
> > +	req = (struct virtio_iommu_req_detach) {
> > +		.head.type	= VIRTIO_IOMMU_T_DETACH,
> > +		.domain		= cpu_to_le32(vdomain->id),
> > +	};
> > +
> > +	for (i = 0; i < fwspec->num_ids; i++) {
> > +		req.endpoint = cpu_to_le32(fwspec->ids[i]);
> > +		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
> > +	}
> just a late question: don't you need to decrement vdomain's nr_endpoints?
> 

Ah yes, I'll fix that, thank you. I think attach() could use some cleanup
as well: if the request fails then we should keep the nr_endpoints
reference on the previous domain. But that's less urgent.

Thanks,
Jean

