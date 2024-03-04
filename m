Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C15322099
	for <iommu@lists.linux.dev>; Mon,  4 Mar 2024 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545677; cv=none; b=G5D4zGRRkJCZBBWiHSYroVHaBQIBR/JUeftuozWrvi3p3KJhZfNlkb3f0ARP9CUvwQHU9HmGrHcUMy0mMyN3Z638Spd1hWK4FhWHlKisorHccXzoO0+19xCMpSWV8LFLcYLbf28jl3mc6yvX2zMjbIUUbd+Ewb2wiQ6cW22LQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545677; c=relaxed/simple;
	bh=ZtdvcX/E3Mi9kbZrfMUEg6nRfIoROdD5wqIV9+hHHtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PueWWfvEC5slcbQ/99Hfs9zZqQwM982xf3orSUBUdWq6JG3u7tb1ZGAOPeuHHp1civy4Exu4ptWWTUulMm8SeaC1kmZKBTANvr82KygePsWciD8jA5b/9Cy4ogS0FZTU80MSu8iDIcKYZO7z4i0TWawMGolEiARbU+khj51aEE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hCAyL36j; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hCAyL36j"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso4463814276.1
        for <iommu@lists.linux.dev>; Mon, 04 Mar 2024 01:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709545675; x=1710150475; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtTAWlcolDm95CcOT0+kG8RlO6Oklc2LqcK+9/CqwVk=;
        b=hCAyL36j5+LbFvBymuYqqYgJiy9GdxtcY4KNUh9Do5kjd5bYbP5WoVFGUgEFt01F3h
         6xrP5X23or4+o8enl/Dff/w5UPxR3qXFAyZJwPviEMgo+b+8xqsYatlyTraGz88OHo9D
         SA875dk7FnsRuh04u/fxeI99knYeEltBnJjjGysWC7pInxGU/yF66jseH3E2L7bFMOSC
         R/UVKhzgBrnDD6zZ9nWCV2XsnayEjtibiJRGV7jTRkl4k0g6nnaD1C7j0H319sQPq6YZ
         SKHE5OZCF/e6C2Fz88QyIkSTWZK98/qNHuqyzAYf2ZCi+EWww3NVeyY/w6JeBATi4kN5
         WyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545675; x=1710150475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtTAWlcolDm95CcOT0+kG8RlO6Oklc2LqcK+9/CqwVk=;
        b=XybYDs5Y0bfYwe1rmFoC7eZEFQNrouyQOPF+aHeG8RBDL0lfsSPiU49VI4pUNqOlgT
         CzCHOpJ8hgodsoja1pJdmTSyL+y2qieEK42oguODUN1pmULcGD93Nrw0DJbl1n+6VF0r
         XoQlIs8ZHzTDVWPwbKZQpKbYYtrgIXF1c6ZFOIoDvKk5wXYX8dt6c371IlgLGRLQ5Syw
         GQU6ekHj8NR4j2o4F5YvjOHZT2uxhUvlfEYYBq3AFJgAHu6z2MQ6hTSrtstjtyg7k6py
         4XKMgeiyRF7t3GzqCCmjjhPlaOYlC+HjkBkthAAJ+CFLSp8fZ3nKvcfhyJFma/khLGew
         Xwkg==
X-Forwarded-Encrypted: i=1; AJvYcCXd6gPVz0M+7WrV5TMYTneNaejDVCTC5oijLy9WX9nsShvxZGcRZHiuNakDaugCNJi8yywgoOsAYhiu5VrL4KU5NpMqeic=
X-Gm-Message-State: AOJu0YxcJ0Cf1toySrnHQlkbLeoZj0To3kfSLBEIE5LVWSoZgcejTqTX
	yv4k/2D5ftbNnkz3+EpKv9plxhCdTTp3OFxvPDPjNIcEl8+TaortLzFSJ/+ZUhRVI1oWoCnEiHi
	DY1FqKozAc/LKsbBjspmoQ/qpM4PcaHdPUWRE
X-Google-Smtp-Source: AGHT+IHL15XlGsEqhMGIf1JQplfo0RmMQX3BCz1GHbz7gpTbQgXwyDmwg6jmYWyvdoTcYHLQdIu3AoU06gJbvuyEn60=
X-Received: by 2002:a05:6902:1345:b0:dcc:84ae:9469 with SMTP id
 g5-20020a056902134500b00dcc84ae9469mr5836261ybu.64.1709545674900; Mon, 04 Mar
 2024 01:47:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240208152808.3712149-1-howardyen@google.com>
 <20240213055426.GA22451@lst.de> <CAJDAHvZGnzKPLaovRcq_Os1Fcixp2o1kY9GFV8VXztrmKahejQ@mail.gmail.com>
 <20240220055241.GA7554@lst.de> <CAJDAHvbOnAvW5f6oJUnuy2_5-vS7uJc13GQSNX_Nc25GJXSp-Q@mail.gmail.com>
 <20240223063723.GB11004@lst.de> <CAJDAHvZ4-mh8uMyq0NiPgWKGt=pS3teoJ0=ofCKZmLeqLXUVgA@mail.gmail.com>
 <602448f1-60a9-41a1-85d2-1205250985d3@arm.com>
In-Reply-To: <602448f1-60a9-41a1-85d2-1205250985d3@arm.com>
From: Howard Yen <howardyen@google.com>
Date: Mon, 4 Mar 2024 17:47:18 +0800
Message-ID: <CAJDAHvZte_566hLgoQSXKK9FhS1HTFpbHVd_0dFKN0i0n_+FMA@mail.gmail.com>
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems per dev
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com, gregkh@linuxfoundation.org, 
	andriy.shevchenko@linux.intel.com, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:31=E2=80=AFPM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> On 27/02/2024 1:39 pm, Howard Yen wrote:
> > On Fri, Feb 23, 2024 at 2:37=E2=80=AFPM Christoph Hellwig <hch@lst.de> =
wrote:
> >>
> >> On Wed, Feb 21, 2024 at 05:27:58PM +0800, Howard Yen wrote:
> >>> The reason why I tried to propose this patch is that in the system I'=
m
> >>> working on, where the driver utilizes the coherent reserved memory in
> >>> the subsystem for DMA, which has limited memory space as its primary
> >>> usage. During the execution of the driver, there is a possibility of
> >>> encountering memory depletion scenarios with the primary one.
> >>>
> >>> To address this issue, I tried to create a patch that enables the
> >>> coherent reserved memory driver to support multiple coherent reserved
> >>> memory regions per device. This modification aims to provide the
> >>> driver with the ability to search for memory from a secondary region
> >>> if the primary memory is exhausted, and so on.
> >>
> >> This all seems pretty vague.  Can you point to your driver submission
> >> and explain why it can't just use a larger region instead of multiple
> >> smaller ones?
> >>
> >
> > The reason why it needs multiple regions is that in my system there is
> > an always-on subsystem which includes a small size memory, and several
> > functions need to run and occupy the memory from the small memory if
> > they need to run on the always-on subsystem. These functions must
> > allocate the memory from the small memory region, so that they can get
> > benefit from the always-on subsystem. So the small memory is split for
> > multiple functions which are satisfied with their generic use cases.
>
> I don't really see how that aligns with what you've implemented, though.
> The coherent allocator doesn't have any notion of the caller's use-case,
> it's just going to allocate from wherever it happens to find space
> first. Thus even the calls which would somehow benefit from allocating
> from the "primary" region will have no way to guarantee that they will
> actually allocate from there if it's already been consumed by callers
> who didn't need that benefit but just happened to get there first.
>
> Really that sounds like a case for having specific named memory-regions
> and managing them directly from the relevant driver, rather than trying
> to convince the generic dma-coherent abstraction to do things that don't
> really fit it. Otherwise I'd be slightly concerned that you're expecting
> to bake secret undocumented ABI into DMA API implementations where some
> particular order of allocations must guarantee a particular
> deterministic behaviour, which is really not something we want.

Thanks for the response.

The original problem I tried to resolve is the use-case explained in
the previous reply, and I was thinking of implementing it in a generic
way. Then I tried to submit this patch. As you mentioned here, it
provides the benefit that if somehow the "primary" region has no way
to guarantee for the callers. And my use-case is one of its uses.


---
Best Regards,

Howard

>
> Thanks,
> Robin.
>
> > But in specific use cases, they required more memory than their
> > pre-allocated memory region, so I tried to propose this patch to give
> > it the ability to get the memory from another larger memory to solve
> > the issue.
> >
> > I'll upload the next version to show the modification in the driver.
> >
> > ---
> > Best Regards,
> >
> > Howard



--=20
Best Regards,

Howard
