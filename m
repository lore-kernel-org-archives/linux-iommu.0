Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BE0328631
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011327; cv=none; b=X3+6Fget4iRiA/yT1XYkzhVOberb9Q1G3YIml+z1/XQA5lsQCWTEBE1nv3eXu7e4hEC1EvjpzQ1jLwfYeKdAVWAMP3gehlCv1TTbIRIjItU6DisNiSsNqhHJoYQ4NAzv3o8/mgGIIff+8SbWW2j6U4In6VatETHbqZb25tBduEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011327; c=relaxed/simple;
	bh=ALN3BZ1h37bw87fH1I2phtqMuOjkp7pNGMZRlYvqJKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBqcm6cg46U2/Khp+D68sD33dLRzqoKa2HHHp112lwW7easli3RzIHaLhUNJNXR5+g2yFo+EruR6Atto1rz37UNonix9srwuKyQ82cdwGxBMz5PGQdtzXhxeW567tzV+OzjufHX7oENcFAMGfXVwMfDpz0MEXjDJNt8MIXAwW1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BE4Ni8wB; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BE4Ni8wB"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-894724bc5cbso8692126d6.1
        for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769011321; x=1769616121; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xk50a3DJCYgVIrcCVz4YsPwnwCkWAaxm0jVyWa00IrY=;
        b=BE4Ni8wB0bzXIn/IGkhnHvKDdywG4G53zNoaqsVtTZ8DLqfNVQ/tIsbkZkZKFOGKnf
         EqKJaPCJJUeLRByZKRCNzh0oq4HaZevXEFyq1tEqAnLKbr5+QbiNcTyjZDzzg4YiQkSt
         HOzk/Pq2wKlkUW3jIY3dpjgRbD4ibCsytER8L/XCLs1A21HF5YltmzEHWlCgE5oxqDZ2
         t0uAlYelD1HAVZODTBi6/Wh5ZGrFZXo/YRoAHibiIY1Nru+d1/8jfRnaAnszlZbtznmE
         AiQ4vDWSNKoNNZfM6t0KgA+rfiPaUIA/oXva8+UkmynrR0qcPTWNpUw0wkJbESo8CkTn
         sZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769011321; x=1769616121;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xk50a3DJCYgVIrcCVz4YsPwnwCkWAaxm0jVyWa00IrY=;
        b=bE79xEOpqGMOliQRW+m8NgFb86QeL/mGiYukSfzTU6o8YmS5pZ8lUUjc2Kx57dRTc4
         wbbfEnlLhTjyVd8EwBYGthtjEFRGXylHVwe0sV6KC2yk7uDDJsR2+rZrp2pOW2BH/LPt
         x9BXt38ciTOOAU2v9oubLxV/WbHxL9cEGhXCgvFW92mNZefj0Bk0rnGhmUa17DCUaMP4
         r8XQ4NnqtKQ4+zrJ3LmE+ynmz04ZvHOh/7SX6k5V0h439G76NwcPVpVKWmN4GrrwuYMB
         Be4DuesjTqyR2Lz8HpdyVhHum1ydKbABnQI1qgCdmDlHYEw49pX4LToURc4r0WVu5kiB
         v70g==
X-Forwarded-Encrypted: i=1; AJvYcCVfXADVRYPixEHdPT9kOWqm5SCl/mny15619eg2GU4uapr5vjpVr8jCGqLpklKtiujdDt+7+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyL1sbL+3hjAw8GPIROJmPF8NKQGQ4ho8T/qF3g9AaNXccXoT5/
	dlIIclWTMjC440q3PDCKEwpygxbTy7s33PkylHuOkz2V9nP2PonK11J2Am5F8DOeW4A=
X-Gm-Gg: AZuq6aKCEwBZDF64cPJaYkDpqLkQeLBkM2B6BPY6vMH0QUrV9al0ExW1mJESAs3Hxfd
	MqmOZgeWxKLDSmRO23FBfSfULlGA2wtfdqtqtW/i1k2EaPMMJT25cvOICYkx0uJKORd0yjjF/4W
	gcxJ6I3VbYbcXL7k9AxpF3r3gYzP7C/eoQRsHzPQci5hP3h7i4d8NOBMsy5yUaCICxA7jOJ9nWM
	QbEzfZUo+j8/7JWokWSiFnWEGWBEHlmQoFOL9jo9nCKPFEztvJsiessLNcKZcgL9CHUNXQT3Qzj
	qWv30OSuEdCOjMw8to8qhMlV1y84N2If/DdxWY9h2/9lD83RLuWLNO4TWhMcuvY20ntR6N5/WOL
	7tDRF7RHOBCOfaEoK/ftbketA/aRNrCkJW7tXf76fFcneckISKJHLMkqJEBdUFKAB43VNt23jTy
	0Ua8xwpSgcCHOEJC9wxdm0NCc9TW0Fm2s/o4OWq+ekrtEhqLSkLXybJi4QQ8GKajaK56AuBNNkS
	fEYGw==
X-Received: by 2002:ad4:5c4d:0:b0:88a:3861:9131 with SMTP id 6a1803df08f44-893982737e8mr294508076d6.34.1769011302558;
        Wed, 21 Jan 2026 08:01:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8946e3aee12sm27692726d6.39.2026.01.21.08.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 08:01:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viaeK-00000006Es6-2jLq;
	Wed, 21 Jan 2026 12:01:40 -0400
Date: Wed, 21 Jan 2026 12:01:40 -0400
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
Message-ID: <20260121160140.GF961572@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com>
 <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>
 <20260121133146.GY961572@ziepe.ca>
 <b88b500c-bacc-483d-9d1a-725d4158302a@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b88b500c-bacc-483d-9d1a-725d4158302a@amd.com>

On Wed, Jan 21, 2026 at 04:28:17PM +0100, Christian König wrote:
> On 1/21/26 14:31, Jason Gunthorpe wrote:
> > On Wed, Jan 21, 2026 at 10:20:51AM +0100, Christian König wrote:
> >> On 1/20/26 15:07, Leon Romanovsky wrote:
> >>> From: Leon Romanovsky <leonro@nvidia.com>
> >>>
> >>> dma-buf invalidation is performed asynchronously by hardware, so VFIO must
> >>> wait until all affected objects have been fully invalidated.
> >>>
> >>> Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
> >>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >>
> >> Reviewed-by: Christian König <christian.koenig@amd.com>
> >>
> >> Please also keep in mind that the while this wait for all fences for
> >> correctness you also need to keep the mapping valid until
> >> dma_buf_unmap_attachment() was called.
> > 
> > Can you elaborate on this more?
> > 
> > I think what we want for dma_buf_attach_revocable() is the strong
> > guarentee that the importer stops doing all access to the memory once
> > this sequence is completed and the exporter can rely on it. I don't
> > think this works any other way.
> > 
> > This is already true for dynamic move capable importers, right?
> 
> Not quite, no.

:(

It is kind of shocking to hear these APIs work like this with such a
loose lifetime definition. Leon can you include some of these detail
in the new comments?

> >> In other words you can only redirect the DMA-addresses previously
> >> given out into nirvana (or a dummy memory or similar), but you still
> >> need to avoid re-using them for something else.
> > 
> > Does any driver do this? If you unload/reload a GPU driver it is
> > going to re-use the addresses handed out?
> 
> I never fully read through all the source code, but if I'm not
> completely mistaken that is enforced for all GPU drivers through the
> DMA-buf and DRM layer lifetime handling and I think even in other in
> kernel frameworks like V4L, alsa etc...

> What roughly happens is that each DMA-buf mapping through a couple
> of hoops keeps a reference on the device, so even after a hotplug
> event the device can only fully go away after all housekeeping
> structures are destroyed and buffers freed.

A simple reference on the device means nothing for these kinds of
questions. It does not stop unloading and reloading a driver.

Obviously if the driver is loaded fresh it will reallocate.

To do what you are saying the DRM drivers would have to block during
driver remove until all unmaps happen.

> Background is that a lot of device still make reads even after you
> have invalidated a mapping, but then discard the result.

And they also don't insert fences to conclude that?

> So when you don't have same grace period you end up with PCI AER,
> warnings from IOMMU, random accesses to PCI BARs which just happen
> to be in the old location of something etc...

Yes, definitely. It is very important to have a definitive point in
the API where all accesses stop. While "read but discard" seems
harmless on the surface, there are corner cases where it is not OK.

Am I understanding right that these devices must finish their reads
before doing unmap?

> I would rather like to keep that semantics even for forcefully
> shootdowns since it proved to be rather reliable.

We can investigate making unmap the barrier point if this is the case.

Jason
