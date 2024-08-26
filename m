Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9074C198E69
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693834; cv=none; b=S7FdFKohu8f8qhMB6ilYQ0JtLK5quw2h3a+OiuEYJ/cZGUcon5d5cfzNHVL29h+LXqyiORnnJKQS+y4Xo+o3ZUnl+dYd8k2mO7TG7HzOxvJo1witsC2PiEgY8rkZeLxeOXrvD5TKOX1IYdaEa9i3YK29j7rvP/qKoh0kXvZp9d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693834; c=relaxed/simple;
	bh=xHmiRNhRRt9eYiRt79QCeyN/h+W2Ra8rJ3ocE5z49V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLHDdHP8BNWhOZ3fkdRIm5EwKSCGAZu3XGA8PUaNw0DTP3ovcc+s6zetvLUPjH/x+dAwywGyPhR+yrABPbNF8f/mYtxlierfP+Qt3xTN4R1/ziCC50hbtqXzZGtCf2ck0CgZ13Q9BpbasGISgDYe1OhQm7TwAIfJE8UFh4HdqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Chni/H5k; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Chni/H5k"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39d2a107aebso15995ab.0
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724693832; x=1725298632; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oh0j8JVhDYlydZMkUx8RVg1JAsfs2sLF6/GwVKf9xvs=;
        b=Chni/H5ktkAKk2UfDENXq33gEBODldCn4eCaXW7sslKldhbGWbXmpL9zJEZylkuGJk
         ZZBlL9cU021dmSMUBIMrOTGt90LVAqA/aNCTBJvjpsI9YmNWWiSA/ys8xoNVdTWFeYum
         a8+feOqFE6nAp7T2WIaTED8oubd3aFpcPffWr44uEs427BoUJHRVGpNQRQ9poVZ/rNxW
         qw6F+ap3V86+S0sYM9WLHf4Z0LUDGS1KR/6I9h1WEjaLqnDmionW/fj07wlgGPm/2XbF
         YXnE0NJR9BrjLHYD5fnlNUzGXHzVsRPhX5ea3rk2+RJ8o5bs547tnK1W5Siufv0CQaHC
         aZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724693832; x=1725298632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oh0j8JVhDYlydZMkUx8RVg1JAsfs2sLF6/GwVKf9xvs=;
        b=jDLJKd0UTosSoOh0aM6nEw/pWcttXyYsFx5z6GZXFMvuyS0WTiCYDTgjO+CO7UgkHL
         rPFX/3Uov5qTXBu/gpoD1kZrdXLW7tOYLqm/lk0QyF3WASo/r7QB8q5eE/TjyosVd7QU
         ka68vaHAWf5pb3vTOKwGtXwTZcqn5+Qs2JNPvP7FwIxuKk6BdROw9fRzZeWCpwQyS+Mk
         Z3WAQZIGzBU1ghlcxpd3HvAXqkk2xQ6WZwp35+sPGUbmZg8kArXMu2Yp12zj6bfgjmDN
         KxzGJQY/6vFKBOfhbu9iJZqhnkAc7/0i5R9BL/2pO9xd5GhPaS3Lz7VA7QjZnLjk0Lsz
         dq7g==
X-Forwarded-Encrypted: i=1; AJvYcCWSsWKbj3PYFNzIZ0fY8UCaLX1Tk2PML5kDAeQtUivTMe+CF8do9vRKrJle8SrMCR8OjiNHbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLWpTntR9CSVfXMkrWpO2I8Y0pLScjN945fkLqWzRepziIX76g
	bs7d5WvBqZUOK8JTWRvEqn4Kbo1KsbgtMivqkImolBxQxv300veAj8xeE8ChNQwuyyo/cjgPZod
	kDJgkGBXLhzucxEs74xIVkw9RizLm5SgRkUWg
X-Google-Smtp-Source: AGHT+IHDJn2W5sA7BZSuEiAztVMwpsekZ9JYmxVAxVceAMBd/f24sCJ4Q/dzJtDHxuQfgyQ6VwJ8096tyWLH+0vkxGw=
X-Received: by 2002:a92:c24d:0:b0:39a:f2f4:7ec1 with SMTP id
 e9e14a558f8ab-39e64de00d4mr36645ab.20.1724693831406; Mon, 26 Aug 2024
 10:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240826071641.2691374-1-manojvishy@google.com> <20240826110447.6522e0a7.alex.williamson@redhat.com>
In-Reply-To: <20240826110447.6522e0a7.alex.williamson@redhat.com>
From: Manoj Vishwanathan <manojvishy@google.com>
Date: Mon, 26 Aug 2024 10:36:58 -0700
Message-ID: <CA+M8utOvUr3LrWhTNtcBhRAsOB-ST8kKWJN4u_0eNCcWLihH4w@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] vfio/iommu: Flag to allow userspace to set DMA
 buffers system cacheable
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	David Dillow <dillow@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 10:04=E2=80=AFAM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Mon, 26 Aug 2024 07:16:37 +0000
> Manoj Vishwanathan <manojvishy@google.com> wrote:
>
> > Hi maintainers,
> >
> > This RFC patch introduces the ability for userspace to control whether
> > device (DMA) buffers are marked as cacheable, enabling them to utilize
> > the system-level cache.
> >
> > The specific changes made in this patch are:
> >
> > * Introduce a new flag in `include/linux/iommu.h`:
> >     * `IOMMU_SYS_CACHE` -  Indicates if the associated page should be c=
ached in the system's cache hierarchy.
> > * Add `VFIO_DMA_MAP_FLAG_SYS_CACHE` to `include/uapi/linux/vfio.h`:
> >     * Allows userspace to set the cacheable attribute to PTE when mappi=
ng DMA regions using the VFIO interface.
> > * Update `vfio_iommu_type1.c`:
> >     * Handle the `VFIO_DMA_MAP_FLAG_SYS_CACHE` flag during DMA mapping =
operations.
> >     * Set the `IOMMU_SYS_CACHE` flag in the IOMMU page table entry if
> > the `VFIO_DMA_MAP_FLAG_SYS_CACHE` is set.
>
> We intend to eventually drop vfio type1 in favor of using IOMMUFD,
> therefore all new type1 features need to first be available in IOMMUFD.
> Once there we may consider use cases for providing the feature in the
> legacy type1 interface and the IOMMUFD compatibility interface.  Thanks,
>
> Alex
Thank You, Alex! I will redirect this patch to iommufd in the next version.
> > * arm/smmu/io-pgtable-arm: Set the MAIR for SYS_CACHE
> >
> > The reasoning behind these changes is to provide userspace with
> > finer-grained control over memory access patterns for devices,
> > potentially improving performance in scenarios where caching is
> > beneficial. We saw in some of the use cases where the buffers were
> > for transient data ( in and out without processing).
> >
> > I have tested this patch on certain arm64 machines and observed the
> > following:
> >
> > * There is 14-21% improvement in jitter measurements, where the
> > buffer on System Level Cache vs DDR buffers
> > * There was not much of an improvement in latency in the diration of
> > the tests that I have tried.
> >
> > I am open to feedback and suggestions for further improvements.
> > Please let me know if you have any questions or concerns. Also, I am
> > working on adding a check in the VFIO layer to ensure that if there
> > is no architecture supported implementation for sys cache, if should
> > not apply them.
> >
> > Thanks,
> > Manoj Vishwanathan
> >
> > Manoj Vishwanathan (4):
> >   iommu: Add IOMMU_SYS_CACHE flag for system cache control
> >   iommu/io-pgtable-arm: Force outer cache for page-level MAIR via user
> >     flag
> >   vfio: Add VFIO_DMA_MAP_FLAG_SYS_CACHE to control device access to
> >     system cache
> >   vfio/type1: Add support for VFIO_DMA_MAP_FLAG_SYS_CACHE
> >
> >  drivers/iommu/io-pgtable-arm.c  | 3 +++
> >  drivers/vfio/vfio_iommu_type1.c | 5 +++--
> >  include/linux/iommu.h           | 6 ++++++
> >  include/uapi/linux/vfio.h       | 1 +
> >  4 files changed, 13 insertions(+), 2 deletions(-)
> >
>
