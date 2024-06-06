Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771E7196C89
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688041; cv=none; b=rm7NRc91W+hB29XTh+ICS55ns64uNclf4DUJjXyuAs85lWP5bTrQ04dYnHEyGGjLSYFEqCqHqjI3LuJIkCvOiglsn7WKjKBnGjld64wL6HVnCSj4sYEYqrxcxyxzsELjKrJ6Dx4xNADsjtro3498e5yTUGm6cIwH9Fe41DBwf7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688041; c=relaxed/simple;
	bh=0K8GBFSkW4AN3/Sl0e8hqJEwYUcj7GhL4o9uYrZuMNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QP3vXxR40+M9dbt7hJbeX2fgaAztjnVpMESxqbHqtRmiDjX92g25pevIebmELxvj36qNwxC3JUPe9zajD2KLnlz67PVlDtDEW6R6Q0I805fTCZYh3lpMSgwAyjlkJ+ghwK0pxgQY/vTeXgZfRNE4F0J3h7+ZR+pGaYCRLeM+FiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+m0m/hD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+m0m/hD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEDFC2BD10
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 15:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717688041;
	bh=0K8GBFSkW4AN3/Sl0e8hqJEwYUcj7GhL4o9uYrZuMNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q+m0m/hDap6Q+Gvf79W9TSJ5BxkxcLyOWQHEjNJfzm0i/KUM0Fa9rpBxNiC8hEaIO
	 TbhCC0MbAyvOG9XcO7O0LaxQxoGhDnu4LkwSLIVxQ9JJO/ACBsRukMJTftGc48vH1E
	 +suwv7DsuARGwdxanEvDdFI+8mBEV4OX3SugRnGOVgPqXCrLBLHJsSQ11TtVB4w7DG
	 fRJp9Ei3m2o95YbkgZhtFUS+mlYtY+ybykj5Ycyhla0/+5gRXmJEl+ZkkGuND30WhR
	 itcVrJBfR/D2E7xqsKbeEXZqpHMVE8UzSCL+rvgqjdCDlZm2RlPdNRFj+oOjIEiO06
	 Z9t6nfwptzMew==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eacd7e7ad7so14056441fa.3
        for <iommu@lists.linux.dev>; Thu, 06 Jun 2024 08:34:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQ+4UZrP9wGAMdAGUz2Hd5D8IC+flvbJsuzNXDFAD5LYedMERtxWuUR8kiC3lUB5EnnQIy8RyHDNyxTS2cZzvCYvL4Ju4=
X-Gm-Message-State: AOJu0YzonB4uWke+wrz4dlCqndiY40FqryZbrr5/Gv/PbggGskoS9MVz
	9G/MBQZPNr8tr+A53Z0tMXgj6fNvOh4uyJX1u9k51hFHcJ1cEYfLIwMqsxaesAn88aU5XyGOLVm
	D0zIlE+/C51ETOwwW0cka3Hn5Gg==
X-Google-Smtp-Source: AGHT+IFXwVRydGZ8W00wKskR1TtWyhH2bfTYh82RbfdTsMpPc96OSXgYmnPF7JWcJPPSEUu5kMdOQoxjLugRZuW1lHo=
X-Received: by 2002:a05:651c:1502:b0:2ea:c450:ac2 with SMTP id
 38308e7fff4ca-2eadce3714dmr429241fa.23.1717688039491; Thu, 06 Jun 2024
 08:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240528223650.619532-1-quic_obabatun@quicinc.com>
In-Reply-To: <20240528223650.619532-1-quic_obabatun@quicinc.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 6 Jun 2024 09:33:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLPznMbqiLXrugB1Qbj3MhMdN9mtbRQFx+94f1F0-JPNA@mail.gmail.com>
Message-ID: <CAL_JsqLPznMbqiLXrugB1Qbj3MhMdN9mtbRQFx+94f1F0-JPNA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Dynamic Allocation of the reserved_mem array
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: saravanak@google.com, hch@lst.de, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, will@kernel.org, catalin.marinas@arm.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 4:37=E2=80=AFPM Oreoluwa Babatunde
<quic_obabatun@quicinc.com> wrote:
>
> The reserved_mem array is used to store data for the different
> reserved memory regions defined in the DT of a device.  The array
> stores information such as region name, node reference, start-address,
> and size of the different reserved memory regions.
>
> The array is currently statically allocated with a size of
> MAX_RESERVED_REGIONS(64). This means that any system that specifies a
> number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
> will not have enough space to store the information for all the regions.
>
> This can be fixed by making the reserved_mem array a dynamically sized
> array which is allocated using memblock_alloc() based on the exact
> number of reserved memory regions defined in the DT.
>
> On architectures such as arm64, memblock allocated memory is not
> writable until after the page tables have been setup.
> This is an issue because the current implementation initializes the
> reserved memory regions and stores their information in the array before
> the page tables are setup. Hence, dynamically allocating the
> reserved_mem array and attempting to write information to it at this
> point will fail.
>
> Therefore, the allocation of the reserved_mem array will need to be done
> after the page tables have been setup, which means that the reserved
> memory regions will also need to wait until after the page tables have
> been setup to be stored in the array.
>
> When processing the reserved memory regions defined in the DT, these
> regions are marked as reserved by calling memblock_reserve(base, size).
> Where:  base =3D base address of the reserved region.
>         size =3D the size of the reserved memory region.
>
> Depending on if that region is defined using the "no-map" property,
> memblock_mark_nomap(base, size) is also called.
>
> The "no-map" property is used to indicate to the operating system that a
> mapping of the specified region must NOT be created. This also means
> that no access (including speculative accesses) is allowed on this
> region of memory except when it is coming from the device driver that
> this region of memory is being reserved for.[1]
>
> Therefore, it is important to call memblock_reserve() and
> memblock_mark_nomap() on all the reserved memory regions before the
> system sets up the page tables so that the system does not unknowingly
> include any of the no-map reserved memory regions in the memory map.
>
> There are two ways to define how/where a reserved memory region is
> placed in memory:
> i) Statically-placed reserved memory regions
> i.e. regions defined with a set start address and size using the
>      "reg" property in the DT.
> ii) Dynamically-placed reserved memory regions.
> i.e. regions defined by specifying a range of addresses where they can
>      be placed in memory using the "alloc_ranges" and "size" properties
>      in the DT.
>
> The dynamically-placed reserved memory regions get assigned a start
> address only at runtime. And this needs to  be done before the page
> tables are setup so that memblock_reserve() and memblock_mark_nomap()
> can be called on the allocated region as explained above.
> Since the dynamically allocated reserved_mem array can only available
> after the page tables have been setup, the information for the
> dynamically-placed reserved memory regions needs to be stored somewhere
> temporarily until the reserved_mem array is available.
>
> Therefore, this series makes use of a temporary static array to store
> the information of the dynamically-placed reserved memory regions until
> the reserved_mem array is allocated.
> Once the reserved_mem array is available, the information is copied over
> from the temporary array into the reserved_mem array, and the memory for
> the temporary array is freed back to the system.
>
> The information for the statically-placed reserved memory regions does
> not need to be stored in a temporary array because their starting
> address is already stored in the devicetree.
> Hence, the only thing that needs to be done for these regions before the
> page tables are setup is to call memblock_reserve() and
> memblock_mark_nomap().
> Once the reserved_mem array is allocated, the information for the
> statically-placed reserved memory regions is added to the array.
>
> Note:
> Because of the use of a temporary array to store the information of the
> dynamically-placed reserved memory regions, there still exists a
> limitation of 64 for this particular kind of reserved memory regions.
> From my observation, these regions are typically small in number and
> hence I expect this to not be an issue for now.
>
> Dependency:
> This series is dependent on the below patchset for proper behavior on
> the sh architecture. The patch is currently being reviewed by the
> relevant architecture maintainer and will hopefully be merged soon.
> https://lore.kernel.org/all/20240520175802.2002183-1-quic_obabatun@quicin=
c.com/

Is it really dependent? This series just adds one additional
allocation before all the reservations are done.

I've applied this series and ran it thru kernelCI. I'm going to add it
to next to get some more testing.

I made one change dropping of_reserved_mem_check_root(). That's done
still with FDT function, so no need to do it twice. Plus, the
unflattened function doesn't have the restriction. (We could fix the
FDT version pretty easily because we have a translation function.)

Rob
