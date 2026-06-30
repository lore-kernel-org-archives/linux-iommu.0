Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF34402BAA
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823133; cv=none; b=frSpEslOQKqo4LW83Lq3QXh1aD3OnIL0+/lhIGrzlBtOclT6TShiRo0vwOeo5hMM4BHcgIdOxhAM75FSnGtKYXqPJUrVUx69Om8pqK1xnxHhWF304EWeWxnIDxgBvB5IlBbCTtbNd+HTV91zKQUjZNjYSvzMS5sVKMbxXVI5NLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823133; c=relaxed/simple;
	bh=HWLewm9KCB7MjAKi5lfHa4PConKZEGpyeTggVQfUIHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1fcJPTsxM8r0edxr0nR0Y0CqPzjYlUJvLwKtIbZ8tuFPoDC9Q5u8Vk74h8Cn18nIAYqM0GU2msSd5+V3bKeGS6xdd1s0pG4ewkDyzsOWHTJt2swJf1kfB6iUbSa7+bw3bdA2uc3FuHxU9uGAPnLUaQVhxQPpfT6EVTfPgNrqis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fKm3tObq; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fKm3tObq"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ea70ca4fc8so5649696d6.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782823131; x=1783427931; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=usbOUHulcGkq5pslDcl5tYYUADM4pc66+J0xE33qcCE=;
        b=fKm3tObq89khAzqc2M5kWMZzWZUYHW6Gt6mBxVKv+iWw2IFdDS2xWodB8s8C2w1Ygy
         DDbRY93MxvaUczKk2PwghKzfZ73FvnPs3LW30OGkZToITQRKJFIrPMY7zLXDsrZXothX
         8NrRFShVW2EpE4KIK9pWyQJaCyAiq/C7zPn6sTQljaBwh9mgZ5JwYzlpL+af47gzWMjz
         r+23wzgMSECj4173tMraOup1IVAlKHOjNECKc9VJ2QuEYztXw+bizSTuBJ4RDIJEhj+t
         a0DAxTpMM0o90EuyuxbduvepulnYoFvMIjA/bM+8f6J/Mw77WPXrMgmVIGU98rXXuyGo
         wB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823131; x=1783427931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usbOUHulcGkq5pslDcl5tYYUADM4pc66+J0xE33qcCE=;
        b=qngs4X8H2WY1hS63CYPr7c3ds+UyG2Fd8F6qv19gCsnppyZjxVKfx5E2D3eyMUDoWr
         5c0v64rnrcbrtNo+bOodGUQUUVfMCh0Sd5m+0bnHpeLXvf7+u1RwHWAEt8N3akb6Ilh1
         tFQlVHqtsFO7XSBgYIaSTKekuqVxmYseHhIoEWeJH8mhdjbxa2xCCAHvgR8jlVD0Nz37
         zwdm1tg+2jFapyGUzztjaWLLutaqLMqfzNTBMJkO9nty36t7oJ5zhHOqH/09zbh7ssca
         HLkk11lH5PFwbNJGhUqUJQj2TB5zujpZkd9aJNnXkuliR4B/u5O5PGoPE+AU/y1TC5qz
         ryEw==
X-Forwarded-Encrypted: i=1; AHgh+RpbJm5n1gIB7f1MJNL7CtjGW/oT/erY3xv/I98a5wiQ55Vx/Z6bp83ZFDt5huUiB8gvopwTDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwadOXCjESphqyRuvRE6BPa9VWgG6uHnEaEUOouPlxQJRMhWDLW
	oDPbvlSJDXQfkxpFI8o4+2xsoSjpNDnl4Xh0oup9vRqo6tUX3bCDQq65LMNukS1BMHY=
X-Gm-Gg: AfdE7cmWWSn7/0ome8tZNU0V4ToskH6JaWEd10AXGJdhZJziGzOISZg9c6OcMeNry0I
	74WpJ9JgHXrKYsIcgfQWxuuIZ2UqW7XQT+3Uf6NezQqTtIDX8llnrgd2G807EpE1rZ+MMaXlPH6
	qMVtyEWDTzbB2vUiYBQcaZJ4Ryp8m8wgdbgV1X4rJ5/VCTE+6v6SRl14O/dOd7fRZj2QGV9JNRX
	VSAZizRHqWpEw3aBXUvkoacxYdZ01+FsmNWZWXFLP4zSAncmfgMbVF7sZhQlc2zLQg3yp7o7yV/
	+ZdDE5iYycZmHw00g+R3Sa9tomw/jpBuNu6FFhD3LDBvjhvdV/fTQVJuCBMat/d4QZgkSdWxFH0
	rZ2UIl2guxJTe6KrRe+pDaCvtmMql2u8II9S7XmDKD5Hd8NH8/W1GCYmuOVvqmsJPV2lJt5U3Z5
	W4cDe+S1BbwGar+rpSciJYWa0jxW0RrW95VqIEQbkt4rBYeGtjQIjH+zqN9qy86RGagX0=
X-Received: by 2002:a05:6214:448e:b0:8db:480e:6944 with SMTP id 6a1803df08f44-8f2549e5762mr17241226d6.26.1782823130931;
        Tue, 30 Jun 2026 05:38:50 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a7558676sm22067246d6.40.2026.06.30.05.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 05:38:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1weXjl-00000001qLK-2mow;
	Tue, 30 Jun 2026 09:38:49 -0300
Date: Tue, 30 Jun 2026 09:38:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Laight <david.laight.linux@gmail.com>
Cc: David Hu <xuehaohu@google.com>, Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	jmoroni@google.com, praan@google.com, kpberry@google.com,
	chriscli@google.com, sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <20260630123849.GC7525@ziepe.ca>
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623094446.4a8fc2ed@pumpkin>

On Tue, Jun 23, 2026 at 09:44:46AM +0100, David Laight wrote:
> On Tue, 23 Jun 2026 01:54:59 +0000
> David Hu <xuehaohu@google.com> wrote:
> 
> > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > first entry, resulting in non-page-aligned DMA addresses for all
> > subsequent entries.
> 
> There is a separate issue of whether this code is even needed at all.
> Where can transfers over 2G (never mind 4G) actually come from.

This is DMABUF land, you really can alocate DMABUFS of huge amounts of
physical memory, VFIO does this reliably and trivially for example. It
wouldn't come from the physical allocator.

So yes, these scenarios need to work in this code.

Jason
