Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9B6242D7C
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047715; cv=none; b=lI123cYl11z6Endv5DPlysWo2zHJt8FVmSicBrRMlNQP7zt6wwH+kZaExv5mE2Jrr9vxU8kTOuwZUYEoq2dQ71Es/NmYtlDwekHQZicXOAfxAzZUWh1jmOox4tLo19quKbfXd7V8BlG0YWj14xWJL3/Up0YxaTJEoT/pjqchzWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047715; c=relaxed/simple;
	bh=kGopxFZIlz3MVRgBeMLykRwwSqchomFgyOoC00zrG+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF7ix6upieFXOQ+YIR6ZEL2WI+Md76boFVdrkQqxeZUKn1uH+ZfWL9WIbtBT0S34nYKsTeZWfB3RDXJjy0KTX+qqNKs1igWb4eZU0q2yDklAJaczvolX00mQzuO8BB/lMprJx+tnVxxef+13ZhynPiZ71N2FuyDcre3NTBULA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ebsv6aKA; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ebsv6aKA"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-505d872f90fso28873631cf.3
        for <iommu@lists.linux.dev>; Mon, 02 Feb 2026 07:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770047713; x=1770652513; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ALEv89D4GoCyBIrWNO6jRp/YUrS6bKKk+NOOQflmefI=;
        b=ebsv6aKA5I95pRpilZ2kl9neu2jRU6KQp323uoomVjuawIhfJIrVhOu8I4p2kW0kBk
         INsDho4d219/ydEH3YlWsnrRXHQ/Xp7eQtrNjNdChGWMz9fYR9E9zKIrnRNRQHK7QZgL
         zDRU+CGHKtqAwTeHT54kPmSnXBkgyNmpD1sKeF3aE12aQzCbCtOpm2v1Pu4Ujz29+xiv
         785VfdkMIxFblI16F49MBaLtZdFyAtiSXKWBHx+LLmke1XK+rIkYm9QHVo+SaSQbMPWb
         KVi8q706aJ80zP2/GPLd1yF4SU7kbLvVofsSQF1S4Iq8qrloiHR0IZb6DhBDaPyQgLII
         8nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770047713; x=1770652513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALEv89D4GoCyBIrWNO6jRp/YUrS6bKKk+NOOQflmefI=;
        b=l/HJbCXZPtYJB8/sXBWajxWycnk84OCYJES/BTXD0NiCOtD2oWDHT6yM8UmiaIxuRs
         dQqH1nMwwRxQ4P8a9Ds15Mngb1FTS4UNceOq6H6VHKXNkPQ/bt8c9WPUDcPAddqiI24g
         jTPssgjuXIWub0s846PWeriFyzcf1x6fx8H1s6qWp+6GlQg7EmvfC9lGwBWJi0cexpyx
         6CDLCfOR/pG79NkG0jlmCzTaFNLkCyJAL8yaRAM7yN/7s2Odi0HfxkiPZEWqPgeWrmVA
         nsw5wT2R4Pcs3gecWSGvztLjWnqPtxEb2pj1ZyeXN9hbVTeiAsoC1kSW1GeetXvmvIvn
         flAw==
X-Forwarded-Encrypted: i=1; AJvYcCUM9Ld1cxqPj4+GLcjkiOB34Np/boSjotWZz6lm738D+GJVQn/I5WV976OMTs+4ouqIZ5njFA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd/CGFfi+3xtw7VBi2EQGN8OGmhGocNntsIWEuFCgc85jaNR/K
	qX55brD4bFYAJtwhhtEVKQUhgIqtLi63VLRGAm80ZdFwXNOH/Hphm+qRW3mhv7sYHAU=
X-Gm-Gg: AZuq6aK3MrvYQXpi5e7Ss4rPNYoHjufSJ/yG70g+1tpKBJxvwBtK/02zc/p1nTmcSw9
	0dkHWRJ+oX5dBIbdsBeBf6L/k2a5mPdy12d1tNs7cHnRuYzO+IgfPczhePUcdFjf0uC+kCZZzER
	Z5Dv+20uRI+ShR8C0RZwfCHItdSAZY+MvZUqntRDyJa+iDfdqVH61fG7VGkoosefbo+KptHslAi
	IzlnqPEdkI096IK7hLH8l2/kyzP3/aL+FERT4Xi50YRRHK/QtxyJ/ej7xjekT2mnXP/6OJkeEmj
	DmojroYlgUVlGG+ek9cH/N4XpG13f7MIg74YN2nOWK2mnr8Q3fmEAmKbPQBwoKUJ4272NTm8Qmy
	cnLWoWkHtcwRh/6ERCzcailk2ckSECSEzsycoH9nSGsQAiCqVRGWgL9ZpnyzyXH0W4QqPWnDgFs
	R3XDNWCRGMiDVYFgr17iGIOPKiWT6fywe5J8RQExs9w+tqPVKfx2qIc3IHgfOdBFdMxm4=
X-Received: by 2002:a05:622a:1a82:b0:4f1:dfc8:50b with SMTP id d75a77b69052e-505d22b2818mr153088161cf.76.1770047712810;
        Mon, 02 Feb 2026 07:55:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337ba3997sm107174411cf.17.2026.02.02.07.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 07:55:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vmwGd-0000000FWiw-2z4k;
	Mon, 02 Feb 2026 11:55:11 -0400
Date: Mon, 2 Feb 2026 11:55:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
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
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v5 4/8] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260202155511.GI2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <31872c87-5cba-4081-8196-72cc839c6122@amd.com>
 <20260130130131.GO10992@unreal>
 <d25bead8-8372-4791-a741-3371342f4698@amd.com>
 <20260130135618.GC2328995@ziepe.ca>
 <d1dce6c1-9a89-4ae4-90eb-7b6d8cdcdd91@amd.com>
 <20260130144415.GE2328995@ziepe.ca>
 <c976c33c-4fa7-4350-8dcc-a5c218d1b0d6@amd.com>
 <20260202151221.GH2328995@ziepe.ca>
 <44ec9689-045e-401b-b9cc-17abdd938bc7@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44ec9689-045e-401b-b9cc-17abdd938bc7@amd.com>

On Mon, Feb 02, 2026 at 04:21:50PM +0100, Christian König wrote:
> > I admit I don't know a lot about VFIO PM support.. Though I thought in
> > the VFIO case PM was actually under userspace control as generally the
> > PM control is delegated to the VM.
> > 
> > Through that lens, what is happening here is correct. If the VM
> > requests to shut down VFIO PM (through a hypervisor vfio ioctl) then
> > we do want to revoke the DMABUF so that the VM can't trigger a AER/etc
> > by trying to access the sleeping PCI device.
> > 
> > I don't think VFIO uses automatic PM on a timer, that doesn't make
> > sense for it's programming model.
> 
> From your description I agree that this doesn't make sense, but from
> the code it looks like exactly that is done.
> 
> Grep for pm_runtime_* on drivers/vfio/pci, but could be that I
> misunderstood the functionality, e.g. didn't spend to much time on
> it.
> 
> Just keep it in the back of your mind and maybe double check if that
> is actually the desired behavior.

I had a small conversation with AlexW and we think VFIO is OK (bugs
excluded).

The use of the PM timer is still under userspace control, even though
a timer is still involved.

Basically there are a series of IOCTL defined in VFIO, like
LOW_POWER_ENTRY that all isolate the PCI device from userspace. The
mmap is blocked with SIBGUS and the DMABUFs are revoked.

The VFIO uAPI contract requries userspace to stop touching the device
immediately when using these IOCTLs. The PM timer may still be
involved, but is an implementation detail.

Effectively VFIO has a device state "isolated" meaning that userspace
cannot access the MMIO, and it enters this state based on various
IOCTLs from userspace. It ties mmap and DMABUF together so that if
mmap SIGBUS's the DMABUF is unmapped.

I understand your remarks, and this use of PM is certainly nothing
that any other driver should copy, but it does make sense for VFIO. If
there are bugs/issues we would continue to keep the overall property
that SGIBUS==DMABUF unmapped and only adjust when that happens.

TBH, I don't think people use the VFIO PM feature very much.

Jason
