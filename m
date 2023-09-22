Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F548656
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 14:42:24 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59bbdb435bfso26083507b3.3
        for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695393743; x=1695998543; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JlcUHfBjvDv/+8kmxymQCbCEugELBDLa0lrBy4oxtDc=;
        b=e7o/bayGPDJc/TEbX1siUkdAQvWgNjwGCCKTuDntPMerTujKp7c4SMcYVWxR2czVtr
         WTwogNMSiOZNaxdv3VXFB5WssmIzPiJWiUsq02mnM9oYpldaYE59/695kIFRwrf0kuvX
         9oQnoSVo0O/vUgSklVZ6m1P5mFSCjKq72+aip7lbvyAnMvVa79ykufMcStJMhotQEcv5
         d63CI8BWziuDcNinYlJEWy0WetbkNFRJZcuqTa/JRgRWgOoqx2l/wlx6fDpndUGA8QrO
         pMbk225s3YUPF7OtWPmyIfiqEku1hQd2eRUTSCw4t4j7/h0Pr5cBpG/VFnLt45IDV276
         y4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695393743; x=1695998543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlcUHfBjvDv/+8kmxymQCbCEugELBDLa0lrBy4oxtDc=;
        b=JSp59dwkP2Bgjuts+Ojwibu0y+O7z+AbP/uAHng0rOFDV5W0vrx6ezBoaHmmG3k35/
         2SW+AmI7gxh9IZVhgYsYUUU1pFD670Xy8YzqZyFxbYVbIALSgoy7N3RhGTS6gm9dpzTJ
         zd0y2c0Q6ox+W3VStbFcqvC2Zz+Bh/gu19COgjKG2WA8anS68eLBxcDrw7SyvrlS2TNS
         j4DNoVEFg8QR+RrD0AJWm29CI7Yidw81LFdng8CT4c0B13gQlKBG2asTa4yq/6QtdeHN
         uh8gL4cZmGtZ1FuDEBZ9hovpIo/TDtKCAtPRWD00aidKCuOdHtj6xpD5oiahoEkEA90w
         hkHA==
X-Gm-Message-State: AOJu0YzCC0dWQ6Z7mYhQO/HL2PSZk4ZB+gnkn9XwXxVEj3m5pexs3xi0
	p4ZrgabjGNIgiizVq10mqNnZ1Q==
X-Google-Smtp-Source: AGHT+IEIruOEpifrm1oS0n3df3jP1SIS1yx5cEIbpMqLOWOUy3gIHUmXlub4hrYEyo8SfNoLg5tF8w==
X-Received: by 2002:a25:5c9:0:b0:d7b:8d9a:4ec5 with SMTP id 192-20020a2505c9000000b00d7b8d9a4ec5mr8517791ybf.41.1695393743267;
        Fri, 22 Sep 2023 07:42:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id a11-20020a0cca8b000000b0063f88855ef2sm1462282qvk.101.2023.09.22.07.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 07:42:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qjhMM-000Ybv-7d;
	Fri, 22 Sep 2023 11:42:22 -0300
Date: Fri, 22 Sep 2023 11:42:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Joerg Roedel <jroedel@suse.de>, Neal Gompa <neal@gompa.dev>,
	"Justin M. Forbes" <jforbes@fedoraproject.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH REGRESSION] iommu: Only allocate FQ domains for IOMMUs
 that support them
Message-ID: <20230922144222.GF13795@ziepe.ca>
References: <20230922-iommu-type-regression-v1-1-1ed3825b2c38@marcan.st>
 <2ea199a1-d20d-2fde-d1bd-76ecad14a68d@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea199a1-d20d-2fde-d1bd-76ecad14a68d@arm.com>

On Fri, Sep 22, 2023 at 03:21:17PM +0100, Robin Murphy wrote:
> On 22/09/2023 2:40 pm, Hector Martin wrote:
> > Commit a4fdd9762272 ("iommu: Use flush queue capability") hid the
> > IOMMU_DOMAIN_DMA_FQ domain type from domain allocation. A check was
> > introduced in iommu_dma_init_domain() to fall back if not supported, but
> > this check runs too late: by that point, devices have been attached to
> > the IOMMU, and the IOMMU driver might not expect FQ domains at
> > ops->attach_dev() time.
> > 
> > Ensure that we immediately clamp FQ domains to plain DMA if not
> > supported by the driver at device attach time, not later.
> > 
> > This regressed apple-dart in v6.5.
> 
> Apologies, I missed that apple-dart was doing something unusual here.
> However, could we just fix that directly instead?
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 2082081402d3..0b8927508427 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -671,8 +671,7 @@ static int apple_dart_attach_dev(struct iommu_domain
> *domain,
>  		return ret;
> 
>  	switch (domain->type) {
> -	case IOMMU_DOMAIN_DMA:
> -	case IOMMU_DOMAIN_UNMANAGED:
> +	default:
>  		ret = apple_dart_domain_add_streams(dart_domain, cfg);
>  		if (ret)
>  			return ret;

Yes, I much prefer this to the original patch please. Drivers should
not be testing DMA_FQ at all.

I already wrote a series to convert DART to domain_alloc_paging() that
fixes this inadvertantly.

Robin's suggestion is good for a temporary -rc fix.

Removing the switch is slightly more robust:

if (domain->type & domain->type & __IOMMU_DOMAIN_PAGING) {
  [..]
  return 0
}

if (domain->type == IOMMU_DOMAIN_BLOCKED) {
  ..
}

return -EOPNOTSUPP;

But not so worthwhile since I deleted all this anyhow...

I'll send out the dart series, it can't go to -rc, so a patch is still needed.

Thanks,
Jason
