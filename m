Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E481EDA26
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236263; cv=none; b=isKx2G6vlnr7QkUD3lNPPFtS+FnxzoPvhfo7s9GKAmn4LETs/2k/UoSV8HXorHix3PSHBTcKT2l+Kw4RYOekOBWy9AwcRQigMkao7jbEAkAMOkdAjH0g8rgPpk59vB/EcmasprOHFEEkPKeH0ll85EDSXJ8c9bDGaUD3r7+hGCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236263; c=relaxed/simple;
	bh=EnAugjJKGS9kNcH0KPK8H8jgbanYL7rHbRk1ja9LOTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwqY5AWIK1QHTtJwlvLwUtlr9PZMX+sF+Jg4ARL/yVZVHPYdfWkWTl+3kvEitxGXOhAFEu5X5GAZhzV/6u8/ybsCcOtF5/nNZDQFUSfYkXjXHP4D11cCF/rdm2HbNJFs7YjBiSAVQWxiP1hhKvmEbFiOQTw7e7aCRjveaTUQDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lLaMVbiq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lLaMVbiq"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2698e4795ebso12265925ad.0
        for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 15:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758236261; x=1758841061; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v83WXTTHBivSkvwG/ZEkQECpEw+P202t/WrSkYtNyqY=;
        b=lLaMVbiqCe9c+esTZam5fUo7nH/dwRH+L+bmES0nKtwo3MJ0KVWhX1zS9YMsPoNIPA
         dBanCNIrk/5L3hPfAO9GheHqZ7zli1kGzaZ1Y8EUDYti7iHdMQM8pbLF/3yS4vLR8ZiA
         YWzc67XKDXFJINbb9QKCPUoZ4mzQZu387Xow01L/nxam6o2hHyufcClE8cSrtaQj9bQ6
         A0DfjfZx/1S74gLhK9XIVyteLQOcZHUPxnP8xSTI7bp92d7E6z/fs4K6B78fuzFU8wbF
         h5fEyvrkHawT213i3rUTTH41MIzHpO27nf3cDHP+TK4J9qa+e8+IjvlH1soOxN7BEP3h
         K8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758236261; x=1758841061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v83WXTTHBivSkvwG/ZEkQECpEw+P202t/WrSkYtNyqY=;
        b=HTovsY0H4BtYpGsB9TLEVigP85NKETyRL+OlR/uYpnyuO8tcuNi4x372DNMMbe2Wyg
         ROBbEeoEttBFlRTzFA5if2QULH9BUjmpCPeomfCe3q0ENjzAumDwxHQIYppwGVvgoeAm
         EDyoydYeHwiM5DVWiNfcts9Jxr8U3Dt/3pwD197XJC06h5xxb9PNoUmc27OjRXDX/GJb
         PXEKqYRuX7uHqW6IY+UyCc7EkrThxk8WKZW1vMBBTpsTQtb1XnG5mRQVO/wikkTnTHsi
         evEjhn9QCOF2iI1u+oFchfcVPX9vvoKKei1UTegeiVgaM7/XF70a7MP0wyva7PHt7cL3
         DXQw==
X-Forwarded-Encrypted: i=1; AJvYcCXM49aVLoYvsppGU7nJJvPYrAQw20jLpJ8Upe6JPacGU/YNsf6MlmA2F6ml4mgjITA139lvFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzrJrJQhHX6w/e7GTtjCTdTtn9cZOktzfnxD01l75i6nrpDAm4
	ZtSFVfiv8Hmpt+An5MRj3SdklkwscaxVljukAsu1WAxwS1BB5iWrywOQ1JQ/6EFtkeU=
X-Gm-Gg: ASbGncvoX8LZKSqU9NizEywUL3WC8chVy9A37PqXT/h6YpfOCNHq0G3hYS1Gzf7N1eY
	mjxbK81W4c+4xdVA7Xs05gux9GyDzxonoxyu/xjzDVFJ1MJsJT1sJSsc2CngNAz3NRR3WX9lIDu
	LMD+5keYlR7zZM/Y+fEzBEbGVjvP2PVoFXic07DuRAOUt9LiqmYSVS7AUNyo6SZXx27yOzqHcu2
	XnT8IHbQCDxwHfxiepjhH4y7NgyB/3/Rw4+1S8XrLhBJ1CdKoPI8oYSR+ro7ZrxR1g3TtvX2Dh7
	RlcUU/+iULv2xlaiYLnNfQ5boVEqchKYw75xREFRr2b5/yezRxKuQ5Jy3U5qmB0MSvaROd+06yv
	9hRvPQS7zZH34UU0=
X-Google-Smtp-Source: AGHT+IHyI3J6k4eVmUR3urNDzX7uOe4AwYGVJpNt69xG/KOAwgukPr8ufI5DMeIiUV+tYwd8ZhYffQ==
X-Received: by 2002:a17:903:b48:b0:24b:e55:334 with SMTP id d9443c01a7336-269ba3ec96cmr14255435ad.8.1758236260768;
        Thu, 18 Sep 2025 15:57:40 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803163a1sm35312695ad.117.2025.09.18.15.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:57:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uzNZL-0000000926U-19Ay;
	Thu, 18 Sep 2025 19:57:39 -0300
Date: Thu, 18 Sep 2025 19:57:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, David Reiss <dreiss@meta.com>,
	Joerg Roedel <joro@8bytes.org>, Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Li Zhe <lizhe.67@bytedance.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Will Deacon <will@kernel.org>, Yunxiang Li <Yunxiang.Li@amd.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [TECH TOPIC] vfio, iommufd: Enabling user space drivers to vend
 more granular access to client processes
Message-ID: <20250918225739.GS1326709@ziepe.ca>
References: <20250918214425.2677057-1-amastro@fb.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918214425.2677057-1-amastro@fb.com>

On Thu, Sep 18, 2025 at 02:44:07PM -0700, Alex Mastro wrote:

> We anticipate a growing need to provide more granular access to device resources
> beyond what the kernel currently affords to user space drivers similar to our
> model.

I'm having a somewhat hard time wrapping my head around the security
model that says your trust your related processes not use DMA in a way
that is hostile their peers, but you don't trust them not to issue
hostile ioctls..

> To achieve (a), the USD sends the VFIO device fd to the client over Unix domain
> sockets using SCM_RIGHTS, along with descriptions of which device regions are
> for what. While this allows the client to mmap BARs into its address space,
> it comes at the cost of exposing more access to device BAR regions than is
> necessary or appropriate. 

IIRC VFIO should allow partial BAR mappings, so the client process can
robustly have a subset mapped if you trust it to perform the unix
SCM_RIGHTS/mapping ioctl/close() sequence.

> Instead of vending the VFIO device fd to the client process, the USD could bind
> the necessary BAR regions to a dma-buf fd and share that with the client. If
> VFIO supported dma_buf_ops.mmap, the client could mmap those into its address
> space.

I wouldn't object to this, I think it is not too complicated at all.

And the idea to add some 'use writecombining' to the create dmabuf ioctl is
certainly a novel and simple way to solve that problem.

> We are interested in the following incremental capabilities:
> - We want the USD to be able to create and vend fds which provide restricted
>   mapping access to the device's IOAS to the client, while preserving
>   the ability of the USD to revoke device access to client memory via
>   VFIO_IOMMU_UNMAP_DMA (or IOMMUFD_CMD_IOAS_UNMAP for IOMMUFD). Alternatively,
>   to forcefully invalidate the entire restricted IOMMU fd, including mappings.

I've had similarish requests for fwctl.. 

What I've been thinking is if the vending process could "dup" the FD
and permanently attach a BPF program to the new FD that sits right
after ioctl. The BPF program would inspect each ioctl when it is
issued and enforce whatever policy the vending process wants.

Sort of like seccomp.

iommufd and fwctl have a similar ioctl design, so I would have no
issue with something that could be easily reused for both.

What would give me alot of pause is your proposal where we effectively
have the kernel enforce some arbitary policy, and I know from
experience there will be endless asks for more and more policy
options.

> - It would be nice if mappings created with the restricted IOMMU fd were
>   automatically freed when the underlying kernel object was freed (if the client
>   process were to exit ungracefully without explicitly performing unmap cleanup
>   after itself).

Maybe the BPF could trigger an eventfd or something when the FD closes?

> Some of those things sound very similar to the direction of vIOMMU, but it is
> difficult to tell if that could meet our needs exactly. The kinds of features
> I think we want should be achievable purely in software without any dedicated
> hardware support.

I don't think viommu is really related to this, viommu is more about
multiple physical devices.

Jason
