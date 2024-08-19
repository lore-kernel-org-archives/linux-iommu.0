Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B713F9CC
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724104564; cv=none; b=e0cmZlDs0INaBv4MegmqICXMnWrbrQK2z29FoeTw1FXlL0dkJneUYoPBJzeXIhWY4OH+yG3FoNYBtiYcu2pSazBC75567H7AAJCxGOGcotiZnNpvbTN2emH2nWpY+Mzr9SKcG29mRGbIxzFsYhlZ3H8Ap95qsDHmugLorgqCDNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724104564; c=relaxed/simple;
	bh=1X0VUOplLuPN/8DfEdW1yJvcuyneDFiacXEDwO3poB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQqw+6wO0A4jZgi1j5ahIpmQYRW+ZHU4eX3oLC7xKBVzQGTrgktwmft2XeokMrtj1ry5vnIJyyIlvuvuB7Ae7TS01yj+yZ33egeHoV27jbY094QP7suwcv8ZaksIFlKolZ7zZCyRThWqI3J6i11LbyCsdIk/TlscOrC1Hzv5iV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBu9WkE2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBu9WkE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3F6C4AF12
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 21:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724104564;
	bh=1X0VUOplLuPN/8DfEdW1yJvcuyneDFiacXEDwO3poB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MBu9WkE25HFSrTKhkJGc+JdVwZwkZ/LCmhHM3nxBSykMyhiIuW51ucOtnoQ1QHK+P
	 akwE+TlHs8dZGKE4y6aA7rC3ZuNohPwPaDx/Zd7yWVO5aOg5pwSvzi3Zj2VsijLNH7
	 3DmmG6wfMUwvN/ystPOyjh3R9IzfI4k2y3go7r8y+3rRkhVK48XmlNuFBGrwL0qaGD
	 ua6EEB6m0Vg8f1mHiiJOjG4Y/MQ8ceoEoTUQIRJpd6gYFPLhr95Fd/62Cbb01aQQUY
	 H54iCclB9vRKnfhmeJ1wUEMCivU5yA2OBUbACMVXzxGD71bVLynDl3Dqh43ZMJXRlM
	 J7YKJLjcSQi+w==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f04c29588so6462754e87.3
        for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 14:56:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1wr2GCjUl5o9M+CtdHuVJdRHrK4UsKHSJHsDymp2egoBSJGwZiv+kFL3daPLRJvaRR7sKJhgv3RrownjSqkrnemhNbwc=
X-Gm-Message-State: AOJu0Ywauwx66zrgx4jx9aecHMuK+56gMlb4hdwZMKovd0/nlTuqH50O
	FKvPNv7ntgEneYofm/7l5cAO78hNWOWFYMyhJEUdWR2SWPi8/g7/37IvRn14ILRCU1lw9Emipdk
	7MTNI+DSeXIWhFa9WMOEDLsIYLg==
X-Google-Smtp-Source: AGHT+IGSVAiCrDCpQQ4BbeMOJ4jvC9P9IIbEvHnhtt+1sdAqf8OoulIvQ5RS9pGzlYKPQ9YpggOJmTJgQg1nux830T0=
X-Received: by 2002:a05:6512:3984:b0:52e:9d2c:1c56 with SMTP id
 2adb3069b0e04-5331c6b3fa9mr8104115e87.35.1724104562553; Mon, 19 Aug 2024
 14:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240809184814.2703050-1-quic_obabatun@quicinc.com> <ZsN_p9l8Pw2_X3j3@black.fi.intel.com>
In-Reply-To: <ZsN_p9l8Pw2_X3j3@black.fi.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 19 Aug 2024 16:55:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJHRoP40E2Wqk_Dsc8hmAdN-63ikR2BWqHeihM7F49ohQ@mail.gmail.com>
Message-ID: <CAL_JsqJHRoP40E2Wqk_Dsc8hmAdN-63ikR2BWqHeihM7F49ohQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Dynamic Allocation of the reserved_mem array
To: Andy Shevchenko <andy@black.fi.intel.com>
Cc: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, saravanak@google.com, klarasmodin@gmail.com, 
	aisheng.dong@nxp.com, hch@lst.de, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, will@kernel.org, 
	catalin.marinas@arm.com, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 12:23=E2=80=AFPM Andy Shevchenko
<andy@black.fi.intel.com> wrote:
>
> On Fri, Aug 09, 2024 at 11:48:12AM -0700, Oreoluwa Babatunde wrote:
> > The reserved_mem array is used to store data for the different
> > reserved memory regions defined in the DT of a device.  The array
> > stores information such as region name, node reference, start-address,
> > and size of the different reserved memory regions.
> >
> > The array is currently statically allocated with a size of
> > MAX_RESERVED_REGIONS(64). This means that any system that specifies a
> > number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
> > will not have enough space to store the information for all the regions=
.
> >
> > This can be fixed by making the reserved_mem array a dynamically sized
> > array which is allocated using memblock_alloc() based on the exact
> > number of reserved memory regions defined in the DT.
> >
> > On architectures such as arm64, memblock allocated memory is not
> > writable until after the page tables have been setup.
> > This is an issue because the current implementation initializes the
> > reserved memory regions and stores their information in the array befor=
e
> > the page tables are setup. Hence, dynamically allocating the
> > reserved_mem array and attempting to write information to it at this
> > point will fail.
> >
> > Therefore, the allocation of the reserved_mem array will need to be don=
e
> > after the page tables have been setup, which means that the reserved
> > memory regions will also need to wait until after the page tables have
> > been setup to be stored in the array.
> >
> > When processing the reserved memory regions defined in the DT, these
> > regions are marked as reserved by calling memblock_reserve(base, size).
> > Where:  base =3D base address of the reserved region.
> >       size =3D the size of the reserved memory region.
> >
> > Depending on if that region is defined using the "no-map" property,
> > memblock_mark_nomap(base, size) is also called.
> >
> > The "no-map" property is used to indicate to the operating system that =
a
> > mapping of the specified region must NOT be created. This also means
> > that no access (including speculative accesses) is allowed on this
> > region of memory except when it is coming from the device driver that
> > this region of memory is being reserved for.[1]
> >
> > Therefore, it is important to call memblock_reserve() and
> > memblock_mark_nomap() on all the reserved memory regions before the
> > system sets up the page tables so that the system does not unknowingly
> > include any of the no-map reserved memory regions in the memory map.
> >
> > There are two ways to define how/where a reserved memory region is
> > placed in memory:
> > i) Statically-placed reserved memory regions
> > i.e. regions defined with a set start address and size using the
> >      "reg" property in the DT.
> > ii) Dynamically-placed reserved memory regions.
> > i.e. regions defined by specifying a range of addresses where they can
> >      be placed in memory using the "alloc_ranges" and "size" properties
> >      in the DT.
> >
> > The dynamically-placed reserved memory regions get assigned a start
> > address only at runtime. And this needs to  be done before the page
> > tables are setup so that memblock_reserve() and memblock_mark_nomap()
> > can be called on the allocated region as explained above.
> > Since the dynamically allocated reserved_mem array can only be
> > available after the page tables have been setup, the information for
> > the dynamically-placed reserved memory regions needs to be stored
> > somewhere temporarily until the reserved_mem array is available.
> >
> > Therefore, this series makes use of a temporary static array to store
> > the information of the dynamically-placed reserved memory regions until
> > the reserved_mem array is allocated.
> > Once the reserved_mem array is available, the information is copied ove=
r
> > from the temporary array into the reserved_mem array, and the memory fo=
r
> > the temporary array is freed back to the system.
> >
> > The information for the statically-placed reserved memory regions does
> > not need to be stored in a temporary array because their starting
> > address is already stored in the devicetree.
> > Once the reserved_mem array is allocated, the information for the
> > statically-placed reserved memory regions is added to the array.
> >
> > Note:
> > Because of the use of a temporary array to store the information of the
> > dynamically-placed reserved memory regions, there still exists a
> > limitation of 64 for this particular kind of reserved memory regions.
> > >From my observation, these regions are typically small in number and
> > hence I expect this to not be an issue for now.
>
>
> This series (in particular the first patch) broke boot on Intel Meteor
> Lake-P. Taking Linux next of 20240819 with these being reverted makes
> things work again.

Looks like this provides some detail:
https://lore.kernel.org/all/202408192157.8d8fe8a9-oliver.sang@intel.com/

I've dropped the patches for now.

> Taking into account bisectability issue (that's how I noticed the issue
> in the first place) I think it would be nice to have no such patches at
> all in the respective subsystem tree. On my side I may help with testing
> whatever solution or next version provides.

I don't follow what you are asking for? That the patches should be
bisectable? Well, yes, of course, but I don't verify that typically.
Patch 1 builds fine for m, so I'm not sure what issue you see.

Rob
