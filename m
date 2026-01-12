Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750F3612E9
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232107; cv=none; b=iqt+pNW/fj5/D5ElZsTvL6AFgTms9cXZY4tKOOH5MZ3Z0ESxoWjaF5Q6UcfpEiIXAvsJM/qCwpnnQlTwrL9BycLNrxAoHPAa+fSAaTFS2ky4RMqxh4iuR9fefQRWa1uMncBoBaCND/3c2rWy/80qEA7wOxpYGgzU+JTyVfsZH7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232107; c=relaxed/simple;
	bh=2+ptEh+o740cfHiY7Soe2/6xEyrL9rhhMehdOO2NfTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4hHm3p0/n5u2LaoqPKXoRvbrqESJdtLw4kkhT+nSEW7GzxFrnrWuy6TOInpJptm1tUM6/sy9YAeuk2Z8h/+8bG3wAlmg15Q6IFFWU2c/aQ4SOc5TERJhX3tIisc76DPmcGQX1K9VNeYoeAoa5PzgJxXse8QEZz6vH9kzhpq/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GFUfawBp; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GFUfawBp"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88fdac49a85so69693986d6.0
        for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 07:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768232104; x=1768836904; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YhowijaztWf/3gTanh1QGKmo9pcuIvisiulcfP4DQN8=;
        b=GFUfawBpJMhFn87XCUzujsgLteo1UP+jTkrHYDYupEXZOU83Ohglj8AvFskCuG5/a2
         CF8yu629AXvkbcqPVkwhH6CxFD6zSz1Gn16XmI3hPPeU7O3+2hrpWya4Kn7ZR24Xa4WM
         uCNZb21K96x5yukR3EBQCd1MiMQMTBf/hL9aQUG84b7Wu51DS/u8usvy59pSBgnazI8g
         KcENAOfEfqx4DBnPNaUNC217Vdrc7mojWkLLSuma0iHz7tl0SL4k2XsMEFt10WakIBUp
         891EN+zoIOW74vTyvBwVJ5Dxjp8FHgh0bVNNz4UG8zWIe1gmbYo4yb4XnjrBt6Q6Iny6
         LOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232104; x=1768836904;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhowijaztWf/3gTanh1QGKmo9pcuIvisiulcfP4DQN8=;
        b=bB5PZ7gqjiNEfGeuJwyAtNTNKVACXTXvgEzYNVjEQoyYGFfecWkMwqdkOrvifqlc4Y
         7Wk2W+bvd1gAiIpkB0+7efmDr9cksuJzg5YMnE9frnSd7FdLhzd9eJuZDQCii2xy9gYI
         CyHnhDdiQB3X+YnP44DOQ9C4MIq4Bme4MHfkqo7AiquceiRpdJ6qvcv4jE8l9E5BaXLF
         mgerCkslFsvQdjYK2Kze70gwPwMRZRrKnvPs51WcRvWurlGr69VtV46p/ylgNbQClY1K
         vegArE4a2WT94PdR4N8PPQ1bIjB/a2mVDVlHwiB+kE7sZj4840KXzBn1czs4jlKsMkDi
         0CHg==
X-Forwarded-Encrypted: i=1; AJvYcCXfZpDl2UO8MiRhsygrlImEyHBAVGEJ3SGmVK9NYuV9jyX7f0cb7dkvA1NdrwulZ4PmPzDhzw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeC9V6U5N+W1M33vSBsSowdmY4LYH048F54hVvDKvBzZpkd102
	DL4pvHYWgDcT34Y8sxTwZQLX55WQXUnKxHDuVszSzbaY+qA5HrmY7vSxvIUKM7xlXno=
X-Gm-Gg: AY/fxX5luTKq3zjh+QZ8G4mdYNuA8RRAL/J9ROwXcdmuNypB8xbRqLW66vSv/ANpEWp
	RDro/cPUjHduchYw3HKfz3QIw9V4t9gFA48y7W5cAmrp4J6QYIjp3ysrQk25goMb/2pDmGtKpxH
	KxzdN+DneLmSpgOXfQM/rTGAE+SdllkKI8FM/jlGm4pRM+uP67cNQD04QR8ZwmT8iKlOsGAbRYQ
	V2Ub+S+Xm619juyJ/oKs9w0LZzmIKaGoi+jxbK0TIIRb+akYLhh6DfJA/5FcSS+V8pJdxGvFxRf
	8HbgMtSl3GKT8D6DFT/jBT+36j4GsE5EXeyKLpSYYObdRiylQzgpmqgO7/Y395GOLtUYGo1Ry57
	WWjTwazJmtzRDB3ZjiLelbuAtypldw3EfWjWPHeIbgq2xcfXTzAr/KhZwd0CXIFhvuEifvQYyqI
	Sl6E9e8NPTiLvSJocZiDmvevNbW+fp2ZcFopYiYw4zPehFkqYX+gLnFGFvEommaiUlhuw=
X-Google-Smtp-Source: AGHT+IHFUDshOX5YDXPelpZvfCAVTGi9FjIy10Hnlj/GEw1ZiF/o5tF46ZaUyCruFsiUwzfjzfL6tA==
X-Received: by 2002:a05:6214:458e:b0:888:6fa6:782b with SMTP id 6a1803df08f44-890841d596amr270142346d6.30.1768232104214;
        Mon, 12 Jan 2026 07:35:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077280fd3sm137593066d6.55.2026.01.12.07.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:35:03 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfJwd-00000003R6K-0Swy;
	Mon, 12 Jan 2026 11:35:03 -0400
Date: Mon, 12 Jan 2026 11:35:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 0/4] dma-buf: add revoke mechanism to invalidate shared
 buffers
Message-ID: <20260112153503.GF745888@ziepe.ca>
References: <20260111-dmabuf-revoke-v1-0-fb4bcc8c259b@nvidia.com>
 <eed9fd4c-ca36-4f6a-af10-56d6e0997d8c@amd.com>
 <20260112121956.GE14378@unreal>
 <2db90323-9ddc-4408-9074-b44d9178bc68@amd.com>
 <20260112141440.GE745888@ziepe.ca>
 <f7f1856a-44fa-44af-b496-eb1267a05d11@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7f1856a-44fa-44af-b496-eb1267a05d11@amd.com>

On Mon, Jan 12, 2026 at 03:56:32PM +0100, Christian König wrote:
> > The problem revoke is designed to solve is that many importers have
> > hardware that can either be DMA'ing or failing. There is no fault
> > mechanims that can be used to implement the full "move around for no
> > reason" semantics that are implied by move_notify.
> 
> In this case just call dma_buf_pin(). We already support that
> approach for RDMA devices which can't do ODP.

That alone isn't good enough - the patch adding the non-ODP support
also contained this:

static void
ib_umem_dmabuf_unsupported_move_notify(struct dma_buf_attachment *attach)
{
	struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;

	ibdev_warn_ratelimited(umem_dmabuf->umem.ibdev,
			       "Invalidate callback should not be called when memory is pinned\n");
}

static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_ops = {
	.allow_peer2peer = true,
	.move_notify = ib_umem_dmabuf_unsupported_move_notify,
};

So we can't just allow it to attach to exporters that are going to
start calling move_notify while pinned.

Looking around I don't see anyone else doing something like this, and
reading your remarks I think EFA guys got it wrong. So I'm wondering
if this should not have been allowed. Unfortunately 5 years later I'm
pretty sure it is being used in places where we don't have HW support
to invalidate at all, and it is now well established uAPI that we
can't just break.

Which is why we are coming to negotiation because at least the above
isn't going to work if move_notify is called for revoke reasons, and
we'd like to block attaching exporters that need revoke for the above.

So, would you be happier with this if we documented that move_notify
can be called for pinned importers for revoke purposes and figure out
something to mark the above as special so exporters can fail pin if
they are going to call move_notify?

Then this series would transform into documentation, making VFIO
accept pin and continue to call move_notify as it does right now, and
some logic to reject the RDMA non-ODP importer.

Jason
