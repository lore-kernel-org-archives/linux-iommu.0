Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C634B8DCE
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006861; cv=none; b=VrYKXHqwOL4+EA6qSmOlsOo9R3iPOzSwShZkK0F/iABWdIQs/l1Qt0xX2URJioI+wKZCp1rOm3detT/97wqmwI6iQYGW/GdERKWO6OZKWu0JxA7V7j8gkBr5RCRXdZQDDrl/V33F+yAtL6Rto77mDbT1tk2Al6hWavZLXSbXHvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006861; c=relaxed/simple;
	bh=ACESqUkTA5xhzkocxzu1Q/cYXSAEkWy1ze88m+Pg+BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLiZlobCXqFRyBvoEZJ02TUvknypFgDQ4nj2Cc2m9bnbLqVtQjTTdy+HoHWGU03ICloj8jTX8jzzrzJ4GAqNgwHHJs1fmOVx/uKq+cB14c8xI3MU7ldSBHBzBUhCoSvqBlMZ+RAYirKXKpD/M0LMJkGddE+51bbBED3tOcYKO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFc8jczZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFc8jczZ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a35ae38bdfso75475ad.1
        for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 06:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769006859; x=1769611659; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMkS4BFW7iikoL2BjP1nG2XKvn880JyWpxnGNG3+/cM=;
        b=ZFc8jczZf2Jcc5qasxHAubU2Wjsy1lZt1ACiNIwuDsgHuPVRnhdAyaC6ulXzQei3N/
         r0YFxL9QwUyQ6kfPLrhNbRM3NJv+XCt6P1rvM5fAYvbP1rbURfodZrWLYoHvv1kFk032
         K2NsX3neAFMtoLrajJhQagw31QWaVBHVU6t2pGSlyxqqLQ4FBnSWm962UNSnpgxPEHaW
         2M9w4fqEAxfDwjEhyh3RlVKEzh2LaqQFUSVz0ZkNtJtKkTc1HW0Ja2S2zYOpjXnp4n0w
         tN+MzgmWc9y7PqVhDX5P/pCHmJlpapYTRtmtztQ1yp7+ClKOD/bQjdV/S+ATc6FKIOfr
         pjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006859; x=1769611659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMkS4BFW7iikoL2BjP1nG2XKvn880JyWpxnGNG3+/cM=;
        b=DclLPEVuLwcpCqCwx91RO7hTSm5V+CGeovmtGpT1tWqsU/M0CAE9tF2sOuLj0H6d0r
         91w/TGGLPXc2qP8LwtmPaQIr6irBXFcmTwxAFdzuYgDlmC66Pl7S9Z1T+b1jQw//jAuy
         d46t8/o4ebp3DBiVQkydOXeq+T9eehdnyjEDWZNiFj8CKued828yZQdJyMas83z7Kc+N
         o8waDz10PbSfUrf3w7hOerZvHksTXPy/TBEJUzHS9UXAKh3BWTilg9n9wDQ/vGGKguPY
         TMG/P8fDBV24nWJ2qlEzC3rLMW4SxskgmqAzoFzpKuFFY+Sy4lXleq9vGFSTRmPwR/Zi
         PcTA==
X-Forwarded-Encrypted: i=1; AJvYcCUyeQFOc7tW5C+hD1An8NEreAUaiz814l0JJqoEbi7zU/lpLOVGS0d85HeZWPnbZWWnQmjrnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YznlrhpEU6UEcSfTF1nn+gUOi33pU1LfAfBieznQgqJjCjvNwMX
	N9fFe/ve6ixD3HvvOa74PQ3TiBqAo63v20erFtYMA1GigafPrNtgou/RyFoEIIVGeA==
X-Gm-Gg: AZuq6aLh7tLgjuRRWAAjKtEKP5xQ7GTJD8MbfZUa+mAGyxQUF/sZfnajTlm2/ifxK6Z
	6PD2m/5CUJEPWjLMwgUA+1Zdm/Y42mIsqg1FKPSVSYv/zLyED+aD+wup1FaAaESkJ6sbVtEi2CG
	x5fZ9hToffg0rR3w8ss8ilASCNunejf/Euj+vrKcmZvzauHYJ0FOfFF6awMpCFOFExoRPMdal2Y
	lKCWD7nRorohKMSFeEgaud13wzHunACtCwlhlW8gLR5tM2UDpfOIqtpZjNVve/dKUTAjHEFCpsZ
	yigyfRHz/5M6ndzlVT3/BnHTdRs8Iyo1lReQSd9IfncM3oNtT123NOraAzqfm4Ba9n+Rkdq+gRE
	mPyyzw6U6pD1aEC0cLDUuqVYsnlIcceO0uW7dMwCNpAXPgmmgNjzxuUHyqsFMq1IIn5pi0BUXhd
	rLnViTE1WKTcX8ZnVBV5cab7XaWMw+UqklGqUliuGY7IRhZFBz
X-Received: by 2002:a17:902:dac8:b0:2a7:87c2:fcde with SMTP id d9443c01a7336-2a7a245b58cmr2655545ad.15.1769006858836;
        Wed, 21 Jan 2026 06:47:38 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa108b21fsm15434806b3a.13.2026.01.21.06.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:47:38 -0800 (PST)
Date: Wed, 21 Jan 2026 14:47:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v4 8/8] vfio: Validate dma-buf revocation semantics
Message-ID: <aXDnAVzTuCSZHxgF@google.com>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
 <20260121134712.GZ961572@ziepe.ca>
 <aXDhJ89Yru577jeY@google.com>
 <20260121142528.GC13201@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121142528.GC13201@unreal>

On Wed, Jan 21, 2026 at 04:25:28PM +0200, Leon Romanovsky wrote:
> On Wed, Jan 21, 2026 at 02:22:31PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Jan 21, 2026 at 09:47:12AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Jan 21, 2026 at 02:59:16PM +0200, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > Use the new dma_buf_attach_revocable() helper to restrict attachments to
> > > > importers that support mapping invalidation.
> > > > 
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > ---
> > > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > > index 5fceefc40e27..85056a5a3faf 100644
> > > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > > @@ -31,6 +31,9 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> > > >  	if (priv->revoked)
> > > >  		return -ENODEV;
> > > >  
> > > > +	if (!dma_buf_attach_revocable(attachment))
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > >  	return 0;
> > > >  }
> > > 
> > > We need to push an urgent -rc fix to implement a pin function here
> > > that always fails. That was missed and it means things like rdma can
> > > import vfio when the intention was to block that. It would be bad for
> > > that uAPI mistake to reach a released kernel.
> > > 
> > > It's tricky that NULL pin ops means "I support pin" :|
> > > 
> > 
> > I've been wondering about this for a while now, I've been sitting on the
> > following:
> > 
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index a4d8f2ff94e4..962bce959366 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1133,6 +1133,8 @@ int dma_buf_pin(struct dma_buf_attachment *attach)
> > 
> >         if (dmabuf->ops->pin)
> >                 ret = dmabuf->ops->pin(attach);
> > +       else
> > +               ret = -EOPNOTSUPP;
> > 
> >         return ret;
> >  }
> > 
> > But didn't get a chance to dive in the history yet. I thought there's a
> > good reason we didn't have it? Would it break exisitng dmabuf users?
> 
> Probably every importer which called to dma_buf_pin() while connecting
> to existing exporters as many in tree implementation don't have ->pin()
> implemented.

Fair point. I agree with Jason that we cannot leave this open for VFIO
and we can have a pin op that always fails.

But at the same time, I'd like to discuss if we should think about
changing the dmabuf core, NULL op == success feels like relying on a bug
I agree that it means the exporter has no mm, but I believe there should
be some way for the importer to know that.. the importer can still
decide to use the exported dmabuf while being aware.

Thanks,
Praan
