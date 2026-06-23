Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A57137757A
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782255239; cv=none; b=ht6kG52l6RIU2NY5UPKfmpITTkGKiQNU37MSrlik//d/H1EVGW+dvRGezEt4z1DmDSeRJG4KKQtOmPLIsa9U1GkdspoFnOA5riIw/NrcK7JrXo5R2AGsQ47s7MOUJpKUOyIJ8+XEzgjbv0GV7F55OH92pNJktAxIOPYMy1sGUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782255239; c=relaxed/simple;
	bh=l5xGEwOU5Sa74WwoX1gAb4cWW9N59zGi3t963nAFy/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRQ2dtimlLglrgrVJkk9yF2oEZjsY1DUKlb442iv8hQ8MuDDZ7FfDkZm6d+BhdHeksld6GaeJerlZSvTJD8VBufe4ZrX8/b2rZ9xyeNUrdaUHPpgt9P0XFlBcL6eAnZS1JZ/GlNwVRyMQB3FPOm3kL5MEhnoo3DZD3WMPDEmNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CG0jUpGn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG0jUpGn"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so2935275e9.0
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782255236; x=1782860036; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl7+6G6mEg9f9+ckJBvnEW32MGFOl9Otf3/P0x9y5MY=;
        b=CG0jUpGnpCiimp1+35AHP7TTNzmVM0daARUK/GwD463OBM9FZajisQF3bHcWsDE6fm
         /MxNiVofHS9qFz2hshgGTWuM4qpyENKitG53bxo4mGLziJ4dxFSEWka3R86SN/22U4zd
         FVQ91uR/hek3APC9tSDk/M45t+G7ueFTroDuUPE5s9PqPE/D/DQXr0whY+A6iUbKIptB
         1Z9CRzPhFt5+fx2cO4sJWsX4/MLl9FDTZ8uEGmrjAe+nokg5uPx4ACc3QZ9wxw3goX62
         ngWEsh0KWxwzDhgG0fVOgoptQlcFgh9McSAoHEeG90FKFUb6pIiYkF6b4SHcnO8BObCG
         8dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782255236; x=1782860036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kl7+6G6mEg9f9+ckJBvnEW32MGFOl9Otf3/P0x9y5MY=;
        b=frk8n4hPL48318gh0TIvg37ZKqSjLqphqJpUo5DQLb0HV1vLRKSu8nc7edUupfv7Eb
         sD0l0XET7aXn5I44ygVW4kxF4id7JLKxJooh+8zkAD7FBPAU42l7nvu2WeqtNcf/O+Rr
         76cN0lzZ02eogL1NLX8eHHzQpawuYb/ea+p8cQ0OJw/sW40zoboiFo8KI8VQhveEEBTP
         y8KnHfj4mo4Wv3PCNYCpNSHkHIrcDaVDfcWCTuDW17SmrGFlSPjeVsvTHsZla2WL20oO
         uBeEwhhOvbGayhoYk6+SIGT9lUN+5VbVyqcy8z2JcpXMU78hLV6bk39NzdGQJO2FW7tA
         8l7w==
X-Forwarded-Encrypted: i=1; AFNElJ8XOXVX+0EIMZ3uz+QdusslIhPkfKGZNpYn/IaNRfMfRirD5nU20eiJ2kx8gMKTmpWnwJ0m7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvJRMGDuPxcCjv5a9cH8A4BQoDvaY/HCQ7bbS0lcyvTsRxXVvc
	OfGKadTDj5ogCm4hKySXAH9HSNCqmWdiRH+ForGZWgbxeOqsdZsq2K8d
X-Gm-Gg: AfdE7cnsNhma5j5DzNrNFQZ9kGwyXOXw8b9SfLlTN4gjIs2ekkGcjvtxKu8kjRytRbp
	P15FTlZE32IA3Cxj+d4mGiXbYPTBgN/Pr7RJ9+UWJICjAbCevpR970uT9RiwtiU6/24ex6Q1i07
	UE6iITjKlmGmRy4G+pBPm4iIpKnDhArXerrlJpUsdCZqaEqYsKIXkwS9LRttOEPJsNVln2+rKjC
	2sSfGNPfQEFU51AAz5h0Ni4B2ezW7bbxsSONU4quhFbywWLSG2IPkSV2rkL1A2mVbHtpJiJh0T/
	w3WgyMwriix8HV25F4HO2roqz2DJRl4gRGu0ekUCQPMlLYVXBpLaasnV1xiiz6FQVE54cKwQeC7
	AJYFc/e7w1AsIo8J4QWAFep43ALoUaEbEaJVbCgftNh4sLj/o0FKX0Qf+TR0Fl8K3He1CA9MQVZ
	8rYC5sAFXLU8owGBEXJCKn8feiFn3+UYgRpCYhhA3/+uow2dQXXQ==
X-Received: by 2002:a05:600c:699b:b0:492:6113:d4fc with SMTP id 5b1f17b1804b1-4926113d5camr183865e9.17.1782255236221;
        Tue, 23 Jun 2026 15:53:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249207dabsm583674705e9.0.2026.06.23.15.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 15:53:54 -0700 (PDT)
Date: Tue, 23 Jun 2026 23:53:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Hu <xuehaohu@google.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, jmoroni@google.com, kpberry@google.com,
 chriscli@google.com, sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <20260623235350.6540eaa2@pumpkin>
In-Reply-To: <ajryxMaT5evDUxaq@google.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
	<20260623015459.1153884-1-xuehaohu@google.com>
	<20260623094446.4a8fc2ed@pumpkin>
	<ajryxMaT5evDUxaq@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 20:55:32 +0000
Pranjal Shrivastava <praan@google.com> wrote:

> On Tue, Jun 23, 2026 at 09:44:46AM +0100, David Laight wrote:
> 
> Hi David,
> 
> > On Tue, 23 Jun 2026 01:54:59 +0000
> > David Hu <xuehaohu@google.com> wrote:
> >   
> > > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > > first entry, resulting in non-page-aligned DMA addresses for all
> > > subsequent entries.  
> > 
> > There is a separate issue of whether this code is even needed at all.
> > Where can transfers over 2G (never mind 4G) actually come from.
> > 
> > The read, write and similar system calls limit transfers to INT_MAX
> > (even on 64bit) and a lot of driver code will need fixing it longer
> > lengths are allowed though.
> > io_uring better enforce the same limits.
> > So the transfers can come directly from userspace.
> > 
> > Not only that but you also need a single physically contiguous buffer.
> > Good luck allocating that!
> > 
> > Now maybe there are some peer-to-peer places where the large buffer
> > is device memory, but they will be unusual and probably need
> > special treatment anyway.
> >   
> 
> I agree that traditional VFS read/write face the MAX_RW_COUNT limit 
> (~2GB), and io_uring has its limits, but I'm a little confused by the
> push to enforce these limits here in the SGL code?
> 
> File I/O seems to be only one side of the picture. In my view, this fix
> is necessary and certainly has a use-case:
> 
> For example, the RDMA subsystem has the capability to import dmabufs [1],
> which gives rise to use cases for dmabuf beyond standard file ops 
> (via VFS/io_uring). 
> 
> In these scenarios, GPU HBM can be exported as dmabufs. With recent GPUs,
> HBM capacity can be in the order of hundreds of GBs [2]. RDMA can employ
> infrastructure like the vfio-dmabuf-exporter [3] or similar dmabuf 
> exporters to frequently move huge blocks of data via P2PDMA.

Ok, that explains where big buffers can come from.
I just wasn't sure.

> If we restrict incoming dmabuf transfers to fit within VFS-centric 
> limits (2GB), we impose unnecessary overhead on the RDMA stack, forcing
> it to manage a significantly higher number of memory registrations. By 
> cleanly splitting these massive contiguous device buffers into 
> page-aligned SGL entries, we directly improve the efficiency of P2P 
> transfers and memory registration.

But a divide by '4G - PAGE_SIZE' is also non-trivial and (I think affects
a lot of io) when the quotient is always 1.
Splitting into 2G chunks is a lot cheaper.

> Since this change doesn't seem to have a negative impact on standard file
> I/O or break existing VFS constraints, I'm curious why we shouldn't 
> support splitting these >4GB P2P transfers? Am I missing something?

I was only wondering whether it was needed...
It does bring up the question of why the >4GB transfers even need splitting.
But that is another question.

If you want to split large transfers into 4G-PAGE_SIZE blocks
it is probably worth having a quick test that returns 1 for 'small' buffers.

	David

> 
> Thanks,
> Praan
> 
> [1] https://elixir.bootlin.com/linux/v7.1.1/source/drivers/infiniband/core/umem_dmabuf.c#L174 
> [2] https://nvdam.widen.net/s/fdvdqvfvj2/hopper-h200-nvl-product-brief (Table 2-2)
> [3] https://elixir.bootlin.com/linux/v7.1.1/source/drivers/vfio/pci/vfio_pci_dmabuf.c#L297
> 

