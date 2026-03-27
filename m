Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A15A38E126
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640629; cv=pass; b=bOl51FumSF46mizQYJQTeJMxA4HMZVy1JNURmwRUVX6DVwYC5xJRVMqeUNT/FnGDg/5I3sZkm5knsjuywJClEJrPb6PbyKu3ttrwM7++4DaiRK7RopQxEI5lgm1hOBi2hZMXfL/BJGy9GTlpTZKLolzKgU7eFw0xtl8FmFEsEfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640629; c=relaxed/simple;
	bh=bp8Rzg51lEDwzJFZ6phUlxNkzebzC2DJpAPYxDIaxlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gbjdg2JbKZtd4FGwZi97sBaCM8hZQoTuvttTPdziXM0nbXU4i+6hqGYqhEKAqBd157OXTMagUAxhaaMZ5KWn8pwTa2xUXFKHfuIxrvhQZBbZelMOcc6OjxZRG0Zx3IaHQX84D1OJ6mfjyRYY5LzJ/f3cPY1IUlqIjxxXGarIME0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cMzWvZhO; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cMzWvZhO"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852ef20fe8so2655e9.1
        for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 12:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774640621; cv=none;
        d=google.com; s=arc-20240605;
        b=Kfz+w5mxkRQXUPfGHOOdpB4wFB2rnfIIFvSsX6IOJox77Y4RB2DflwZBniSzPcib9o
         MdTKhQZDRY1h4lOiE7Q1vRDYFPXvK8hOgEIhPd657VVIZgyXl2pTX4+kC5G7kbr6YdKT
         wGn3lXuKFLGvTgy9NcdTr6Slxzm5ZpDYAyMn9rRWc6DWBUTRoB8yH1nXIHa5y9Nz0OtV
         ZC7iGwdKzBGCOu/T9IsCY3T/LKte3T7A5S/ciamyvg1AaIDsCA2j29aq8V2BWWy8Q0MO
         I8MWMhpY8OVDtTU6szDBlgkXeB5lo9gT9WJlCFdREheKzIhGVdoiYMr1Gb+HMd+AJy53
         lYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bp8Rzg51lEDwzJFZ6phUlxNkzebzC2DJpAPYxDIaxlM=;
        fh=jCD67+0H36QG098glZ+JyBedXBYHYKPeZylvxmW5W9I=;
        b=Il8xLkSwVwGpfCytDfSeZd7VqupslSSCsqxzVi2baYD4+UNG9FHeZ1qhOZrdA8rHSR
         x68IkJivxZtHYI/81EPyYCizoT5hielUjJ+l/1pX233ooR6c0DdjHV4z+wHiFyyPOWzA
         SUfAqcx4e/G4iggvvSaKKkDA75XrWYFoTrx9iFc+kKd7FT662Py73hj4IbHhHdYvIqEe
         1s3zSnBuZrnUYDUyuILj6cc4cf8nYeLB4OqSfIHlqOb7zUnWHeTPn0Pgdb9tAZwWoAe5
         9rpBL1ItIU097/d4HdWG3OcmeKYMta59wyZgtTamtVP1Jq+lG43KNudyfnKiftMSB8Zp
         P1pQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774640621; x=1775245421; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bp8Rzg51lEDwzJFZ6phUlxNkzebzC2DJpAPYxDIaxlM=;
        b=cMzWvZhO2iRjI/GiO69hMhoeJDpc4OAcBCYZ3GkrwwjeG5g+OGki+YzfI9n296Awsx
         JtwOen95Zomh2HFhpOdLKosjaMAgIWunQHqvVtZgSjnU45moO6FPTYBUk5gAfDhmlJ2A
         mCey8ZktUbIs4lrleCY7UsdPeAMbmL3rcjPFtL5WPCLmzaALWn9+VzFxS6pSYxuiRnEz
         PR3O2ENw3Mn6S3PuH1+2HnOA8p8Tx8FX8akP74//iYqCyEhypMShKvSfGVkHEzcu/uv5
         rsCanj7Qo+yUkil2tKCIWJT342d+ZzhTQXEMIklroQB5aEy/oov9r0dXJ6udkL2OuGR0
         SCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774640621; x=1775245421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bp8Rzg51lEDwzJFZ6phUlxNkzebzC2DJpAPYxDIaxlM=;
        b=Ub2TIbwFIG4VuJd0XErtjCmtWZ9+cYwohWFUApRnpv4KlOD6iS+xxo5/ZiyXUxcFy1
         DRvW8GKKSbJdV60a2+uZ5RhGkySwJ0tj4EmCHxo/6S6fiNdC9ObCu0TCKfS/U+RRBnWu
         gHxTfOHQoXwdg0N/D7G+9qiB4EiwotFV8lkE93R1VU66R0QexaEmyhUQ0tbF6ogsOr07
         +ihKML+LrUMk2+/4E71hmNgQukpDD3ykdMYFMPlWuPp55CvsR9Mq4v/MYebUsUOVPGug
         iVufriy9RTE6ZUEpGDqq8pBiy6WXVHfZtGZKGJEC7j1rb8e1GssE4yT4v3tqaskhzrRc
         hSJw==
X-Forwarded-Encrypted: i=1; AJvYcCXIKAAFlsYPZ8TTC7pbVs6LrA4ZjDQN0st2HlO7UOr/LJj6pFKIg67lvmzwjgICTbNo0TizIg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzdv0O02NvvMj3xxYV4wsIySCdLhLmrF5kOsq+ETcqM7InwwJxS
	+2GJqfNd5lC9GNnXUTXi8a/8eCDP05kVkcf2k6syfNYShEFUog+Xb/l4wonERW9BVVMe1OMQLte
	nGcDFlY3ZS386/3JEzhN/+rfpiAE8gFfZeDSH0xYq
X-Gm-Gg: ATEYQzzOjdvRbAtzA3akhIXe8eq/ennwzECZubYaXR1+ubI2bMnEJsuCaZWOmo41PZy
	lN+n6sVbUT6KBBvt0fErdq+DtQL9pI42c/LDd+zqsLDTVCa9fEs+HM+TNuuNGqHXTOi0R/8kHWo
	qLug3jivsjj38CyNFELj95blC2kSGV3D7o5XoBNYBIsjx/OGY9Tyf3BX56Tm8/FSq97ieIRv2yn
	524KQiDfVB3owvXGYNhx8XB6ydCnVt+jCcIj1slwwC7p3QSTl7kNC2vQGBzsqUxZoyVHl2qgN/3
	8OV6To5KYr6C48PkmwPQet1asOi0ge6ohx8ZXgzbMlZznPfBgAym8Ao0fKsMRy7EuWub
X-Received: by 2002:a05:600c:474a:b0:47e:de1d:ce99 with SMTP id
 5b1f17b1804b1-4872fb2db92mr169905e9.12.1774640620548; Fri, 27 Mar 2026
 12:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20260325192400eucas1p2ae38ff4c2b3ab35a7047cfd680d9fda3@eucas1p2.samsung.com>
 <20260325192352.437608-1-jiri@resnulli.us> <f2047cd7-91a8-4f6a-b6b9-0e4f143f6854@samsung.com>
 <20260327121021.GB246076@ziepe.ca>
In-Reply-To: <20260327121021.GB246076@ziepe.ca>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 27 Mar 2026 12:43:28 -0700
X-Gm-Features: AQROBzCEcKgPP9gV3lvkFItmqoWSRLzeH8nf-BLcIkZAnZ3bjMQA_OWXnQtSUH4
Message-ID: <CABdmKX0HYg_HQAb44QGcO-frCTu+0h=uqS70CTcYtRs-Y=y21g@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] dma-buf: heaps: system: add an option to allocate
 explicitly shared/decrypted memory
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Jiri Pirko <jiri@resnulli.us>, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
	christian.koenig@amd.com, robin.murphy@arm.com, leon@kernel.org, 
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com, 
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com, 
	thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com, 
	suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 5:10=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Mar 27, 2026 at 10:38:10AM +0100, Marek Szyprowski wrote:
> > On 25.03.2026 20:23, Jiri Pirko wrote:
> > > From: Jiri Pirko <jiri@nvidia.com>
> > >
> > > Confidential computing (CoCo) VMs/guests, such as AMD SEV and Intel T=
DX,
> > > run with private/encrypted memory which creates a challenge
> > > for devices that do not support DMA to it (no TDISP support).
> > >
> > > For kernel-only DMA operations, swiotlb bounce buffering provides a
> > > transparent solution by copying data through shared memory.
> > > However, the only way to get this memory into userspace is via the DM=
A
> > > API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
> > > the use of the memory to a single DMA device, and is incompatible wit=
h
> > > pin_user_pages().
> > >
> > > These limitations are particularly problematic for the RDMA subsystem
> > > which makes heavy use of pin_user_pages() and expects flexible memory
> > > usage between many different DMA devices.
> > >
> > > This patch series enables userspace to explicitly request shared
> > > (decrypted) memory allocations from new dma-buf system_cc_shared heap=
.
> > > Userspace can mmap this memory and pass the dma-buf fd to other
> > > existing importers such as RDMA or DRM devices to access the
> > > memory. The DMA API is improved to allow the dma heap exporter to DMA
> > > map the shared memory to each importing device.
> > >
> > > Based on dma-mapping-for-next e7442a68cd1ee797b585f045d348781e9c0dde0=
d
> >
> > I would like to merge this to dma-mapping-next, but I feel a bit
> > uncomfortable with my lack of knowledge about CoCo and friends. Could
> > those who know a bit more about it provide some Reviewed-by tags?
>
> I'm confident in the CC stuff, I was hoping to see someone from dmabuf
> heap land ack that the uAPI design is OK.. TJ?
>
> Jason

Hi, yes LGTM. From a uAPI perspective it's just another dma-buf heap.
