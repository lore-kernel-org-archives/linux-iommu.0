Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C593444C68
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813729; cv=none; b=J2b4ILn6gLIkZqbYE29MLB6idud7lPrO2zrdVl61jXi6F+++7EUYhJv7Us+bwJHWurw5jyyn0Jigihc43yVi/ueNO7e5YhXzrP8gYayFcWBwu0IDi8JmLaLPbSrwWAVDlhxGClg/yRV0ePckhH/LZa21lommlCHHgW1k6jJhzpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813729; c=relaxed/simple;
	bh=pJEgJeTQwVs5vx66mBxar+N9b1m9N3pdSmF9ogkPcWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6y3rS7AxgNMLS+5efyo/IXLcon8EhplZkdZ1i/MFUvNJj9ZxuAY/AbQ57wxdEl3nZSL/CTXEedvlVDcnWS6mRCoz50oOQkASJ5Aa4X/ihDxn41Y3W3UTJEHGpdIF6IBfuRZF3TaCtGRPuhdXpsTmA+vnJrdR5c8eY8Kt0j49Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNbKujPl; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNbKujPl"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39d3ad05f8eso60185ab.1
        for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 19:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724813727; x=1725418527; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fLdemAYHyaRjrEjX/PyMbIb7irsWTXj+jd0WtbNIYg=;
        b=iNbKujPlojIQMYlnJmLZcSdRtDt/e8/6DMGVIvxRQ/gbUYN/9ElW506YWPniAhZepx
         8Ai1QUQlXaS/VmnmLvakCVnTzI0dm2muQIkbHs/LPxyduS/JOWlJfZVQ+n0LlHiSSoR4
         kfGZXgNTT/wPGTtCN4ZceVs5uW/PT/NXjIqL0qf7SKJ48Dq7nGqQXk7jfxmk2JqRJGVH
         BrO2EpEBfcvA07lis13I2HR1FF2lAZMNcljyIJyjLzb5xemfjLmIoChTC3C74GR3NPnN
         eRyE6M3F5NMH8guz0uoy+MRgwURZiWPb+iN8gWtAOHwLhJ/OEeeoCDags8s2LoHmBXQN
         3r9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724813727; x=1725418527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fLdemAYHyaRjrEjX/PyMbIb7irsWTXj+jd0WtbNIYg=;
        b=LGb1e1Dp9DG+jFCqubN9o3xdSfrWaAQ01P/NYUX3rBQgpaglwH+x3j771Eo1hEEkvz
         U0SP6dqx3YwTTiedDMh2LtJQrN4T3OjzvrSGCkpSl9GSsxZzk/+W6QBPqBjl2oderXnk
         Gua8Y3K8l/LN5V/EsiBInrMulb3NqcjIGipVJYqWIaIWF99QrlnzsrewuYsTNj6bpP7q
         M3b9njPUgAduS2coqOBYtzNEG1MycPJN5p0GH4yOk8971VA2JpFM13ibmMfHFSrhtabv
         YzPhflmwD2ywCN3rI814m6EbwBaLxeoQxbKTNi0qoF/Pgv2uNGWaqMLTW2Z5NevhhqkM
         XMGw==
X-Forwarded-Encrypted: i=1; AJvYcCXu+MPqKnWPZfswOmxoea55oUGjus2ZWBKG9qXD/ce62sAdEGuJJcYHUxaD4jbnmRmV9yq3jg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3siJcoZBPg9UKnKtbKBJ8OvPg46ppTfhJxLvsS5HkJzmGwTcf
	CN313i7LKM0gaHJdqOABldpKgc1X9K8ByYsOkbWZoXlon/s880KKajxoJ5CD3J5EwpMk5FyYCI1
	WXgw3ikoBAm2JYy1cpm6mWpyzGrY7q7d8OshR
X-Google-Smtp-Source: AGHT+IHxQMCM8ygBU1B/o9noyTf8DTeb1f+v9mIev+ysxWN/9s4XOVSoquTlsvNsVPNlXOyOwHBmh6KJiTTKZW7YvPA=
X-Received: by 2002:a92:cd8b:0:b0:39d:24d4:708c with SMTP id
 e9e14a558f8ab-39f320a721emr1116765ab.7.1724813726715; Tue, 27 Aug 2024
 19:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240826071641.2691374-1-manojvishy@google.com>
 <20240826110447.6522e0a7.alex.williamson@redhat.com> <20240826231749.GM3773488@nvidia.com>
 <a0cfcbe4-cab4-48b2-bcba-0bc28d97e996@arm.com>
In-Reply-To: <a0cfcbe4-cab4-48b2-bcba-0bc28d97e996@arm.com>
From: Manoj Vishwanathan <manojvishy@google.com>
Date: Tue, 27 Aug 2024 19:55:15 -0700
Message-ID: <CA+M8utNVshFNJyrw1PcrVSJbFbDqPRkM_PjpF8CGy7Nf8pJRjQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] vfio/iommu: Flag to allow userspace to set DMA
 buffers system cacheable
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	David Dillow <dillow@google.com>, David Decotigny <decot@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 10:31=E2=80=AFAM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> On 27/08/2024 12:17 am, Jason Gunthorpe wrote:
> > On Mon, Aug 26, 2024 at 11:04:47AM -0600, Alex Williamson wrote:
> >> On Mon, 26 Aug 2024 07:16:37 +0000
> >> Manoj Vishwanathan <manojvishy@google.com> wrote:
> >>
> >>> Hi maintainers,
> >>>
> >>> This RFC patch introduces the ability for userspace to control whethe=
r
> >>> device (DMA) buffers are marked as cacheable, enabling them to utiliz=
e
> >>> the system-level cache.
> >>>
> >>> The specific changes made in this patch are:
> >>>
> >>> * Introduce a new flag in `include/linux/iommu.h`:
> >>>      * `IOMMU_SYS_CACHE` -  Indicates if the associated page should b=
e cached in the system's cache hierarchy.
> >>> * Add `VFIO_DMA_MAP_FLAG_SYS_CACHE` to `include/uapi/linux/vfio.h`:
> >
> > You'll need a much better description of what this is supposed to do
> > when you resend it.
> >
Thanks Jason, I will add more information before re-sending the patch.
> > IOMMU_CACHE already largely means that pages should be cached.
> >
> > So I don't know what ARM's "INC_OCACHE" actually is doing. Causing
> > writes to land in a cache somewhere in hierarchy? Something platform
> > specific?
>
> Kinda both - the Inner Non-Cacheable attribute means it's still
> fundamentally non-snooping and non-coherent with CPU caches, but the
> Outer Write-back Write-allocate attribute can still control allocation
> in a system cache downstream of the point of coherency if the platform
> is built with such a thing (it's not overly common).
>
> However, as you point out, this is in direct conflict with the Inner
> Write-back Write-allocate attribute implied by the IOMMU_CACHE which
> VFIO adds in further down in vfio_iommu_map(). Plus the way it's
> actually implemented in patch #2, IOMMU_CACHE still takes precedence and
> would lead to this new value being completely ignored, so there's a lot
> which smells suspicious here...
>
Thanks for your quick feedback.
I tested this with a 5.15-based kernel and applied the patch to get
early results.
I see the issue with IOMMU_CACHE overriding IOMMU_SYS_CACHE in patch #2.
This would likely be a problem on 5.15 as well, and I need to
investigate further
to understand how we observed better performance in our tests
while trying to exercise the system cache.
Let me do some more testing and get back.
Thanks,
Manoj
> Thanks,
> Robin.
>
> > I have no idea. By your description it sounds similar to the
> > x86 data placement stuff, whatever that was called, and the more
> > modern TPH approach.
> >
> > Jason
