Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB633ACA74
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782248188; cv=none; b=Dz5EzL5sBIuaeNhLSLokgqwLhw37Vn+LAdrzpEM35bAW6MYyAwl5u+ijYrFh8GLmoG9hxKlmcvHduCAgNnVmGrGoaIoMDGzOexhfPvpNqQ0A1iSYjUx41c3sWh91PRhkmu3KXe1jRLEisx/Wu89lFoHIzTKdgpCcKdnLcogxxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782248188; c=relaxed/simple;
	bh=G82PIGobVIM5hrjzCuF1CpVGWo8L2z/ATglE9QG7wqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHJZf3lkkRQoGh6ZQNpy7QRSEMXroWOssoRBDVn3MucERMWc8j6ZQ+CQAUExpGn4q/JlKEj2cm6hpjiEAMrqdzdMklNv3xUnHmvIEVQkxhSQIGsYkTmseKipKSBevpY9gkfmo4E/eBQ+FcJNZhszU+hdOO5mGWvXQackXse82dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V8dKMGXB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V8dKMGXB"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso13995ad.0
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 13:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782248186; x=1782852986; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tDNBIwJuw+D53Ki5EAv9tDfTFhNZX4Fj7K/EJveLoSA=;
        b=V8dKMGXBICi7iwRItaZX7AlwMek1ZEG0MEUMqcPIDQz8RKIOwoJ/5ReaDN6FDxJxW+
         OS+Va7pkHAn83dyi5haGPaTaUCgelaH5lrwtcnfhLEd3CaM5MfTKRKE7mbIk/22+I37j
         ZIm/q5ut9sJ0hPnBTYecXyg3azwS/yetQ7L78/OTAIXevceN7xAQGL2bn8wXPRZNXMJZ
         28INKxtUbi1U+Qwkb26R6ROePxFcbpgpxwO0NVyrPTnNYPceJOzIQsXEBzYC3MQKbCQ6
         NKsEQr3jZ5LCuYy9OXryH1LrAZv5822lhX0RCtoluPjaWRipYia8KuuBDoj/YsNNAJ5X
         /CTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782248186; x=1782852986;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDNBIwJuw+D53Ki5EAv9tDfTFhNZX4Fj7K/EJveLoSA=;
        b=DLr+6AeV1Ay+1S0TQl+ncB9M5lZ3/7ldSV92EOOhO5SBRKcpQod+hMDbpftxlFVC1i
         p1cmRlUb0ByLh9ke4VUJ4hc55YmAdIgJJY2aMoC00Ttx+iCmP5Oxcj+5mDDOucfovG+q
         cKcQQQ8J0iMgmBGZISQzbdy2HeUo0X7WDRKSXoB3I7IC+Hy79fRCgkhH/LAxPG1r0Ro+
         JXRVpAU3Dy0OQMX4QlGEt7AwMyaywksUGPqH+huGZ1bp1/QDcg8oYaH2Hr9ekGoFxaCT
         qvtibZwwLIqxo69elGJKsQEYHilIaGVDvOWYsKQTiS2XvgSMB/vV0nnI73obgrtrTO0R
         IHSg==
X-Forwarded-Encrypted: i=1; AHgh+RouG5LNGAd9kW52pjhkaEyCVfZcRrexBLuAQjqv7dhb9Y9nA2zVBCZ4PRAxqo/dsvIhpG+mIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPUXCEVMa2tXw/GXIz5hwkmQaDM67FEY8xuoFEQw1XkQZ8Pzyu
	Taqh9CXk4PLnL4apX29KpOX9hPm7EmZVdbDeMD/LtXnYA7Sm9SCXDI2Iy84yTz4RsQ==
X-Gm-Gg: AfdE7ckUh3spJuS0XXE6Ps6KAX5AScO9iPGVYbzDN7iBFttYfTrlh5ZwlvO5rw4WBIb
	kuGTQAz3MR79i08hc6Pq+EEdEoS+eqqpJPdoW6KEkgtu6A63yy0CXki002d5cWnwpcLghXtFRUD
	xeUKFc/o7S78BR2KW/BrguMO0Ma6w9TKKddHxTTy2CQxOvpAUN6Xx7kB3xsYSWVHEHef+owgVHC
	+B49DR3blfVLk4cM+4gU+nE7edGDw/iYzZxMdZ0Z8Qs8Rfx7G+uwWLkB9OAR2nDvI908/UTB6ja
	ytR5S6WSk1eFyAEzLqiee39ZgX1joTSyPbhN8XmeJ1Zs1Bbb6r4iAV6/Og/8hN73SlUk7OvbJ10
	nLhvtvIlpPb+f5JNDGW5UT65bSoqT6zozmi+EP3jcf0Q2oHdG7IyMcoru2STBAJd6Xu5DaR+giH
	zIa5UspllhQZ7IGR2Ce4J7rVZcqU2z5X7GRvtiVc8l3D6GFIubYA==
X-Received: by 2002:a17:902:f689:b0:2bf:3741:5b76 with SMTP id d9443c01a7336-2c7e26b7724mr203255ad.3.1782248140960;
        Tue, 23 Jun 2026 13:55:40 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d1b0fsm54433b3a.28.2026.06.23.13.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:55:40 -0700 (PDT)
Date: Tue, 23 Jun 2026 20:55:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: David Hu <xuehaohu@google.com>, Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	jmoroni@google.com, kpberry@google.com, chriscli@google.com,
	sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <ajryxMaT5evDUxaq@google.com>
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

Hi David,

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
> 
> The read, write and similar system calls limit transfers to INT_MAX
> (even on 64bit) and a lot of driver code will need fixing it longer
> lengths are allowed though.
> io_uring better enforce the same limits.
> So the transfers can come directly from userspace.
> 
> Not only that but you also need a single physically contiguous buffer.
> Good luck allocating that!
> 
> Now maybe there are some peer-to-peer places where the large buffer
> is device memory, but they will be unusual and probably need
> special treatment anyway.
> 

I agree that traditional VFS read/write face the MAX_RW_COUNT limit 
(~2GB), and io_uring has its limits, but I'm a little confused by the
push to enforce these limits here in the SGL code?

File I/O seems to be only one side of the picture. In my view, this fix
is necessary and certainly has a use-case:

For example, the RDMA subsystem has the capability to import dmabufs [1],
which gives rise to use cases for dmabuf beyond standard file ops 
(via VFS/io_uring). 

In these scenarios, GPU HBM can be exported as dmabufs. With recent GPUs,
HBM capacity can be in the order of hundreds of GBs [2]. RDMA can employ
infrastructure like the vfio-dmabuf-exporter [3] or similar dmabuf 
exporters to frequently move huge blocks of data via P2PDMA.

If we restrict incoming dmabuf transfers to fit within VFS-centric 
limits (2GB), we impose unnecessary overhead on the RDMA stack, forcing
it to manage a significantly higher number of memory registrations. By 
cleanly splitting these massive contiguous device buffers into 
page-aligned SGL entries, we directly improve the efficiency of P2P 
transfers and memory registration.

Since this change doesn't seem to have a negative impact on standard file
I/O or break existing VFS constraints, I'm curious why we shouldn't 
support splitting these >4GB P2P transfers? Am I missing something?

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1.1/source/drivers/infiniband/core/umem_dmabuf.c#L174 
[2] https://nvdam.widen.net/s/fdvdqvfvj2/hopper-h200-nvl-product-brief (Table 2-2)
[3] https://elixir.bootlin.com/linux/v7.1.1/source/drivers/vfio/pci/vfio_pci_dmabuf.c#L297
