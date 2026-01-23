Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3330B51B
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177504; cv=none; b=LRrG4WrEAlMFAsIQMmXuYxyOp2mMInRxX1dZOZoSYMAJyP+pWQ6191PODdgaXCZuDOGcCNaI4hZCdWCEAnOYkwnTUVOG/fN3DO1I9tUc+dm5QyPsvTU8C2EDjTZeaw0V1fCKPRRP9IeX8uLARYkOEsLhXtK8HMtPlRaP83yRmFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177504; c=relaxed/simple;
	bh=58had73B0AHtHiPbJGrC4Y2rRw/02IpIYPrJvcRhLO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCuGHbCUFhNELy9r/IEJxHa/eBprXci0fQPhRiic/PgDZdYZuGMI6sa5l/tQjPlG87BrVDAjAZVDam4knU9JSAvGghSnZAFV+upsQpMD+hIbx+BA2VwT+e+pjKZaPv6TMkEIWbMblVyK2Pd9kEcwSCmwGq4nwssmpsI49LFrQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mSnk0Ipf; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mSnk0Ipf"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8947e6ffd30so25947946d6.0
        for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 06:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769177502; x=1769782302; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A5PKpJ/4T6+3Viu0suTKGZFl50yyl7xVfieAULiIAgY=;
        b=mSnk0IpfOBBMuMUMPYt7tKy0WpZutBsRIKFWWmRnURMYE0Kgit5oONUF6FKeLZIHAb
         e/hgSrCNeUGS2vJimoiqEf+sISGUA8utcSoRkJacIutEquJRkrE0J4wUK6EVEoWk3o3G
         qs17+OT5RUGE096PMnjOqPJWnnHchvstALQTn0WpnyjoxWKVjB0EATaKpuhAYTkC2OzN
         XVdrs/6255bYyESOHfn7ttgvs+GOcjtmhRr0gSNQau1JOFFiR9xtXKK1Qs/Qv5JUUz+O
         oIL+45OphWLO3GTenkJAUUm5RVuet4piojS3E5fBTGLVgGiWZhrnT5B682Uki+9yAw4d
         6rDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769177502; x=1769782302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5PKpJ/4T6+3Viu0suTKGZFl50yyl7xVfieAULiIAgY=;
        b=wuDKKBrzk+5RhMd1SK2TJ6taAgVtKJsZe7XUQeQLUxOWrLhBLk5P407lCVBakuQWK9
         ARKdd/oTkZGd9I1lhPy/G+ErwBoKjkeOv3uuDIxk/wsUY3AMjqHQXsvPOGe55WKHnFd1
         RLD/BDn91dv4E25GljK5Zptm0naHHJwmmMURZEgfMb30RBbwQbBPrwTAbxVYQLmcH+Vs
         OdS3pTdHMhme/Z54epG+FZnX5+cP7R5x+X6p2Ev7aADcCgalFQWy+MG5F/z/Jia4FAm9
         UiX7xx6MrQNun4LNJ0L62xv9+u7JtroU/X40v/AM13uwylSXCOjj+q69KdR8nJUqLFEa
         02+w==
X-Forwarded-Encrypted: i=1; AJvYcCUVUxo0ZTw1r0xariqqZXvZL5Z6OTUz1an3aP/PfJDZxMdvJ8RuyPWLgQU1MKVCNspitaTwcA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyzw8SqP6Jak9V5ixNHgAyMAk6h61YNe9UPkMex1esNW1OXZNvk
	swv/nbnBxQ7ZMxxKKdPJN/BWT3UKLcfnI9UKJHpM+KCbrfjEpsducLk0nzR0tIahFFQ=
X-Gm-Gg: AZuq6aKNknevxf2FwzHRD1NUQygRkmPXO7CxYKaqjq9XOvmYA1efAFudYln7pPlMCMG
	ua4cb22IH7lpKxsMnBUsclVc//jK/MX535YnY/pkGxm918ccvgmZhHEV1o0MZ/qV9tFoO9GYL5W
	KiJuxdymPUwGmS0VersWjOiovWSiY0mlcF58W60ujynEWCH+xyXdWCfzGKnQRex6BYkh4+Fhdwb
	RslQLDora4ASX0YYOGAgpLO7BAlsu8Ijbb6RCTZnRNPhWSKEJsm7j28xhwAb82AeslfEqFztpMK
	L9RUDOLLVH7+48fdpnSZtjV+Gl2x9EYLUStD3EyLe51ks+DTBUnqb8CVFOOnSIp0yN4ey2b8K9Q
	f0QP/+YpE6tXe52A+KySdMp6SMMq604QNPmVJzpQrRFzkGUAxF0PApKjfMjdZccdtWmqlq3Vafa
	RUhSthDVabem3bpPlIQAg6RG9b8hFsjCzXKNrU7Ea3Lf7kdG91NaTOh2oAmdecMLFq537E2QDv3
	USc/w==
X-Received: by 2002:ad4:5c46:0:b0:88a:589b:5db5 with SMTP id 6a1803df08f44-894900d6bccmr42275406d6.0.1769177502022;
        Fri, 23 Jan 2026 06:11:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37c8fa6sm187731585a.4.2026.01.23.06.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 06:11:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vjHsy-00000006stw-3Bfb;
	Fri, 23 Jan 2026 10:11:40 -0400
Date: Fri, 23 Jan 2026 10:11:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v3 6/7] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260123141140.GC1589888@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com>
 <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>
 <20260121133146.GY961572@ziepe.ca>
 <b88b500c-bacc-483d-9d1a-725d4158302a@amd.com>
 <20260121160140.GF961572@ziepe.ca>
 <a1c55bd8-9891-4064-83fe-ac56141e586f@amd.com>
 <20260122234404.GB1589888@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122234404.GB1589888@ziepe.ca>

On Thu, Jan 22, 2026 at 07:44:04PM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 22, 2026 at 12:32:03PM +0100, Christian König wrote:
> > >> What roughly happens is that each DMA-buf mapping through a couple
> > >> of hoops keeps a reference on the device, so even after a hotplug
> > >> event the device can only fully go away after all housekeeping
> > >> structures are destroyed and buffers freed.
> > > 
> > > A simple reference on the device means nothing for these kinds of
> > > questions. It does not stop unloading and reloading a driver.
> > 
> > Well as far as I know it stops the PCIe address space from being re-used.
> > 
> > So when you do an "echo 1 > remove" and then an re-scan on the
> > upstream bridge that works, but you get different addresses for your
> > MMIO BARs!
> 
> That's pretty a niche scenario.. Most people don't rescan their PCI
> bus. If you just do rmmod/insmod then it will be re-used, there is no
> rescan to move the MMIO around on that case.

Ah I just remembered there is another important detail here.

It is illegal to call the DMA API after your driver is unprobed. The
kernel can oops. So if a driver is allowing remove() to complete
before all the dma_buf_unmaps have been called it is buggy and risks
an oops.

https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/#m0c7dda0fb5981240879c5ca489176987d688844c

As calling a dma_buf_unmap() -> dma_unma_sg() after remove() returns
is not allowed..

Jason
