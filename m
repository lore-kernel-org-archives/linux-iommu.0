Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ADD3E9598
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005365; cv=none; b=G5xdq6S1VIn2MJeA5ASiTkYv+3gS8qnco/AcXAWrGFOavkAAxXzUaqnfNCC5GRHfDc3lZKre3st1PQZAjn3fDEXiITZv8Zji1bdcbfUSDqMrEalv+JDb8T/5mF6hNTvtkdrsEQT0yVJzV2UaFHUIT1DKRx+Kobc5Svkx4LCsZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005365; c=relaxed/simple;
	bh=go5t4J2oCqftUfdoUso726J9QdhgF091WBBQZFq2rJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGgEK39y2IH8iBzUUhPFKVoYKvQbilvLzFt7hL5hC3df3JuWdioE7UrSgX4EgoGYtV9xPS0Hp9SKy7o5ckn8Ci5OYDCXgQLLJYKTN9fg6P1KLlwR3s+5kd0JHZK8IYJ2OMlhbmlbFAI+WOXBRaaQxAunYXoDQFkoqy+V2vr1wnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imMP9pgM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imMP9pgM"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a1462573caso88625ad.0
        for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 06:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769005361; x=1769610161; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Df9DnST7C0sPqC8cKGnMiT7cxfRi0XBTWHY9JjLQ7zk=;
        b=imMP9pgMw3An003kzIKUIZ2p5C1YpTti8hNMZYl735lUCQHEBp2hwvfPNJ5dDF9z11
         LLpXyJOAiABW29XhO4DRJntWqxf8uWaDQ1l5ck98UCp6nV+MZWw9pgAaPcUkWv/VWc4g
         KmJLtEmK26sduHIgbdgEPjTGNVAD1wJdvQ07G8NcSCZqB0fqARHLQqxfXo06Z9KgWOg4
         Mgwe9rDlLZPj8LDjjCwyNzeoWHqOIvorod2tWhqEm7qBxFFDlvb0OQa3FvXvASF9EQsb
         dXaV8JyLDoCyJ0ILTGjLGkpaw92pDPvJy0Vj4zbr2HrRPG8Be6w7leETcgaztiBoB1KQ
         xVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769005361; x=1769610161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Df9DnST7C0sPqC8cKGnMiT7cxfRi0XBTWHY9JjLQ7zk=;
        b=jkmDWoHrK2hyJpSrkhvzs3119rYela+8J3BYx2vvat0w0EqKUTugFkFUd2ZYPqEekY
         H4mfSo1rCue2W/qcvPGFRN2uY5kOJ3/p3ALZH6hOogp+/2ndOfdO8DpZ01QZYAvd7ML6
         sz8rmSFZc0JBnqkEFiHFkJHwhvZ8Hxibr8qfMZ1k7j4CVQ7e7KfavQIv51uGpSXi09H2
         sAC39pk/ElzQ9yq56l9o4hvJaHdLnOOp2Y72z6Vw2CFtiluqzsFond5VVMe8seVrt3wE
         6YBlJMZF2iD/WMxKzltMmDfzRAeX6eDVrlTeANNVhV6KxN+n3D19mX8UuKfjX5NwMcAU
         bVoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ1mE3AXAbM6bXE+BWGkVtboChvM9dTc4xv8vhxAQsA51xtZYy4vGmX7+glwPUOQSVqBB+Dg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8XU0XDTzMG1Mq7EPgVOKBG+3dnVKNqvzOmYNfu1FwWNpEWOPZ
	CUekqSRab6Ldm8TSNFnQ8WiDm1M+ZRGSzX4n7FZgcRgHWfkMghc6OVIxQd0sXOdglg==
X-Gm-Gg: AZuq6aKlfJpjqyDei5LlsqAXmc5xARuwVbKXCEpHtYGtSX9QKg2ZD0e5BRcddvOx9yb
	XGC9yunWpppXIJHaeZEMx09Tre+PhwSOOFsYijAZvh/ZS4IF7WfdZT9K3lFUIpcIrR52d2Xn1Zy
	vLiMTdOafy9lKts7laso6xnlEEBEnMGIkDuEgWUYR7Tv7lKyMCYLb8OAplV8kfk09zVKlpZJ0wy
	lm7sv57C1Z6IkYnY901PVZAVXri/5M521luixuPJFG0LVbrBfctlZHLhtCxEEdeIFA7dQNe8LdP
	SWlsGPmJhnzqPq5X0n4Q58pBGaOIBbSh7e8EzFh7j8rydtfd6H97VRRDutvfHHxqoDzQZ5LUOc1
	sSRHLZmBFKO20MA8n8Hmzv5cLMmaRMMu/jqoOQ8piNkFtUo07e4HtxtZnr5uCxl2rqz1JCExV0C
	h2tCUJ1EcP5BtBxexE37WtPJP0hhvtVIKQoSYjeW44SVt+aIIW
X-Received: by 2002:a17:903:1c8:b0:295:5405:46be with SMTP id d9443c01a7336-2a7a23cc8f3mr2519245ad.1.1769005361111;
        Wed, 21 Jan 2026 06:22:41 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce6a9sm159451235ad.34.2026.01.21.06.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:22:40 -0800 (PST)
Date: Wed, 21 Jan 2026 14:22:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
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
Message-ID: <aXDhJ89Yru577jeY@google.com>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
 <20260121134712.GZ961572@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121134712.GZ961572@ziepe.ca>

On Wed, Jan 21, 2026 at 09:47:12AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 21, 2026 at 02:59:16PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Use the new dma_buf_attach_revocable() helper to restrict attachments to
> > importers that support mapping invalidation.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index 5fceefc40e27..85056a5a3faf 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -31,6 +31,9 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> >  	if (priv->revoked)
> >  		return -ENODEV;
> >  
> > +	if (!dma_buf_attach_revocable(attachment))
> > +		return -EOPNOTSUPP;
> > +
> >  	return 0;
> >  }
> 
> We need to push an urgent -rc fix to implement a pin function here
> that always fails. That was missed and it means things like rdma can
> import vfio when the intention was to block that. It would be bad for
> that uAPI mistake to reach a released kernel.
> 
> It's tricky that NULL pin ops means "I support pin" :|
> 

I've been wondering about this for a while now, I've been sitting on the
following:

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index a4d8f2ff94e4..962bce959366 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1133,6 +1133,8 @@ int dma_buf_pin(struct dma_buf_attachment *attach)

        if (dmabuf->ops->pin)
                ret = dmabuf->ops->pin(attach);
+       else
+               ret = -EOPNOTSUPP;

        return ret;
 }

But didn't get a chance to dive in the history yet. I thought there's a
good reason we didn't have it? Would it break exisitng dmabuf users?

Praan
