Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E1478E52
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003238; cv=none; b=NwB/m7iJ/RXvvqvGhMnH91kBXC2VuhZsERIa0jKC4rY77XCx7lZkphBpKEygMmx/QkCZ0WrgFUTiYG5THzJ7bNG7oU98mR2YyeO5b5mg5KVEcwTLdN35ALpGbsJHjBy435a2WrWg8pw+ko8rWAmXGXCqacXDz0cmO5lcMNREpDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003238; c=relaxed/simple;
	bh=fn6QDJCmTOKiiaWIAjab6bH+PZ+yr8u3rj/vi81/cYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpV+qW7AyBh/9ZIOXRHbPXFOLg4XIfVKil4DhbWSlMmAglf98++0oPlikEaBFHYufW6HRme7IzL1VJ77RzGrHzjUFhY3Ti7Bd3MzOHe4kkJIVfghjO/TzRgCASWXGgxCy7G3s6sFnZLr1IguYLzN8jYsFYMin9cjT0/GK5dnYTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YQck//9b; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YQck//9b"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c5389c3cd2so692938485a.0
        for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 05:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769003234; x=1769608034; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPFd5kAX+x+JPapHwkry8xE9pec/AtWEm0UrVlklyxQ=;
        b=YQck//9bZuljCeuLjIv8mlmPsYXFZXNrrU3qmpnBcvrwrgeijSs+H2hvFZ115LiSwf
         ZAJJ+OvI9H8qm2oPfcz8PWFipDAN+V6T6yUDhebTOODHdZYne8k0JMBqFeh9j0uxgOO5
         0LjRJW0HxCgzSIGq04dp/gcJrJnQbLOkZsDWOum15TeuYcFuOFbamGTDxvF94Ha8HOlU
         egcWk+bcswrFsfTuVww+5BMLuI6EhcaYtWwOFot4tQz1SJc1M3bQe5yPgZmaOD7A9AEZ
         iFBix2ezjn76Vfa0522vaOo/SL0bUuBVbt/b8uGqiQgpCvUNQGnMxXLL3oxCET4Je+Fq
         q8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003234; x=1769608034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPFd5kAX+x+JPapHwkry8xE9pec/AtWEm0UrVlklyxQ=;
        b=gnbQcIqLMVHWn0tsopwFHpiNuRnerpOOsukIndSPfW6HGleX5nb03vyqUapxVFOBAn
         UGl2XYeDgUcZdbLFhEv8ZTNZ747Wbjsptz0b7EdmisqRTn8awNOGKnKwx2U3XDW1DQ+S
         2atZ4lienwbTYmTUO3V4Pv9Py0M39+Okw/bPnsaEpmghFJI4OMdl9k+w5WakgJGcBBYm
         cBiITsP/aGyLF3AYn1PmJR6qtMYZz2X/VPau4yt9Vw/sKihxA5mZoH/Y5Usolhz7wD6n
         WnuHLASqSQ9krY2ArAadTT1SlPV2flMTAzwgeS770ysSNZcyeTIgFy2KNGHncizJGm60
         1BWw==
X-Forwarded-Encrypted: i=1; AJvYcCVDCYcpekdu+h2p1rxoJDVrGpJKqK5I+QrIVnHrdrHIyTKeRSoS4uuy5SJ+mTOsm5k3EaITAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBf5KG/O0tay590GGeIdiQS5m5100woddNp8GNIH0eG7C+rJ3q
	xnnbBWgkxD36sc2y18cj4KwMEXcMeBCScjrZFHbq9egvltWQ4rBwk2C6K4tk4mbEGoo=
X-Gm-Gg: AZuq6aLUbXUa/ptKPtoYrbmsXEvONbPC0Fr/CGCnR7LtHi0vwB3EGcRQaJzNz0IfDgm
	RBG6chrNSJP5C+lEf0VwqTz7zfHWsDZglCZR/rJHen1lBGb+hHoc++1oKF+8/Q8yhhQa+nYfWNs
	F2VniOQMj+D0tK8bShlK20imGsYDHWrztnIzOAbSlPkyNLUkiWeUwtfkUZt1i3gm2ic8F9VRc6W
	jiae3b7QkvzMLmcHtwaHsiDUYJQsmRMkL7muN68wPqVEYvQSr3xccbmIXzyzPittY/F0gzyEaSe
	i/YakQ4TQcOCgLKESeot04WFB4kSrPRPH2uiSC3wv5yHsJq41cSkUcPF2kBBUh3h2/GZjx27GN8
	rcykCQNi5YS2G3I3jWs3DEiwa2citkXe4LqacBF5Wd27s8YopyL0nZ1dwb2WPgD18TPNIBqnAi8
	Vfn1LoxD6hTYZqosPvERkPDqR7UTm7t7pFzVK3d6gugJLd9Rpd9ltAfCaaEO9QiXQmnwTS0ozHw
	tWdDw==
X-Received: by 2002:a05:620a:4003:b0:8b2:f090:b167 with SMTP id af79cd13be357-8c6ccdbf81fmr639187685a.24.1769003233554;
        Wed, 21 Jan 2026 05:47:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab288sm1307247385a.6.2026.01.21.05.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:47:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viYYC-00000006Dum-1GTZ;
	Wed, 21 Jan 2026 09:47:12 -0400
Date: Wed, 21 Jan 2026 09:47:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
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
Message-ID: <20260121134712.GZ961572@ziepe.ca>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>

On Wed, Jan 21, 2026 at 02:59:16PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Use the new dma_buf_attach_revocable() helper to restrict attachments to
> importers that support mapping invalidation.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 5fceefc40e27..85056a5a3faf 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -31,6 +31,9 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>  	if (priv->revoked)
>  		return -ENODEV;
>  
> +	if (!dma_buf_attach_revocable(attachment))
> +		return -EOPNOTSUPP;
> +
>  	return 0;
>  }

We need to push an urgent -rc fix to implement a pin function here
that always fails. That was missed and it means things like rdma can
import vfio when the intention was to block that. It would be bad for
that uAPI mistake to reach a released kernel.

It's tricky that NULL pin ops means "I support pin" :|

Jason
