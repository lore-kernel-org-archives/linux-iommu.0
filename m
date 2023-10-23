Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C81848
	for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHceUgXI"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso5502374a12.0
        for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 14:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698094943; x=1698699743; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jj1E6TzCn9t7Su9/nQwwpOKfIunnrJP+FkU0HWrJ4dI=;
        b=lHceUgXI6tOFwFLMeHSzDzQiosf3DfOui7JXsZHRurg2UCaNWMXpEzWQEU5JI/WGbg
         SefQ3ENIWy4UjMwT2eKh/HTWWR1KanGcBJ6YoCcQy33onCMmV8/TNRPc8Kkw1SNONCeX
         eUb6BKdvhVXi4fcSjGzeHR7BsA/jIIZBUauEFzURKE3alO+6Sl0Au3kUFMA2aZs9byfF
         eULfSSTpk2lbeKOzk8CQHQxQfAD+8nZlTSffzWRwFjyChThBroDk6+HyJ2bD0Hr3APo9
         leMLD9FwaldH0Z+TNSRq0n3AxjheHWFc0u07LaxYi7ulMsRty6iELBCUyjk9kZriv2Zc
         JUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698094943; x=1698699743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jj1E6TzCn9t7Su9/nQwwpOKfIunnrJP+FkU0HWrJ4dI=;
        b=csf8zONR6vJOwn+rADlITnvX8ECeilopExUyMQkmckWwhKjU0lOgMs5t+WRclP2fQT
         Ulsc+P/AeP+i+hgoP0Sl4ZlLdrEQRE7r5ly6cUkcaZFUxq08ECSY9S7GG7GwmTkoIMJw
         QJUY/MWMCYM5ETHQkfhOMG0rLfpCX7wBQC0/gJ7L1cJAWZAqxGBSHVwiK9T07//1psy5
         Q7S7xnM66XyNW1vSOe4wxhTWUl9TOAtkC9bmb3oFt9a2i3xCyMWDihAtmveUmE9EkImX
         DBgZo4+U66D31ofp15apLkmWFSNUrSFjrDwKvBPvTb6pQ7UT+U1Kd6fVLyiN1S6BI/28
         w3Yw==
X-Gm-Message-State: AOJu0YzQbzH073Ku0UZq2w/X6jsLgu4I2QoQ15fvhHDyVxvq5E/kL4tq
	Hyhu+1MSAkLlyROK2cLxAkcXrkSHMGmVfF4SPtU=
X-Google-Smtp-Source: AGHT+IH405qcpzKntvIJMALx8csXWxmeMQ6uyb1ooS0jV3W3xYrxAzZvOjFOGr0UJPV66m7kQfqWyGBG3j9sOasyLyk=
X-Received: by 2002:a05:6402:524a:b0:53e:2c49:8041 with SMTP id
 t10-20020a056402524a00b0053e2c498041mr8167491edd.8.1698094942651; Mon, 23 Oct
 2023 14:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230809121744.2341454-1-boris.brezillon@collabora.com> <f72e5ab1-c6f2-ec03-68d6-1686145f3a4d@arm.com>
In-Reply-To: <f72e5ab1-c6f2-ec03-68d6-1686145f3a4d@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 23 Oct 2023 14:02:10 -0700
Message-ID: <CAF6AEGtDxkiiM5NNT7Y9-sY5eCQX15ij=RzU-NX2Mvf6kNk2nA@mail.gmail.com>
Subject: Re: [PATCH 0/2] iommu: Allow passing custom allocators to pgtable drivers
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Joerg Roedel <joro@8bytes.org>, 
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 6:12=E2=80=AFAM Steven Price <steven.price@arm.com>=
 wrote:
>
> On 09/08/2023 13:17, Boris Brezillon wrote:
> > Hello,
> >
> > This patchset is an attempt at making page table allocation
> > customizable. This is useful to some GPU drivers for various reasons:
> >
> > - speed-up upcoming page table allocations by managing a pool of free
> >   pages
> > - batch page table allocation instead of allocating one page at a time
> > - pre-reserve pages for page tables needed for map/unmap operations and
> >   return the unused page tables to some pool
> >
> > The first and last reasons are particularly important for GPU drivers
> > wanting to implement asynchronous VM_BIND. Asynchronous VM_BIND require=
s
> > that any page table needed for a map/unmap operation to succeed be
> > allocated at VM_BIND job creation time. At the time of the job creation=
,
> > we don't know what the VM will look like when we get to execute the
> > map/unmap, and can't guess how many page tables we will need. Because
> > of that, we have to over-provision page tables for the worst case
> > scenario (page table tree is empty), which means we will allocate/free
> > a lot. Having pool a pool of free pages is crucial if we want to
> > speed-up VM_BIND requests.
> >
> > A real example of how such custom allocators can be used is available
> > here[1]. v2 of the Panthor driver is approaching submission, and I
> > figured I'd try to upstream the dependencies separately, which is
> > why I submit this series now, even though the user of this new API
> > will come afterwards. If you'd prefer to have those patches submitted
> > along with the Panthor driver, let me know.
> >
> > This approach has been discussed with Robin, and is hopefully not too
> > far from what he had in mind.
>
> The alternative would be to embed a cache of pages into the IOMMU
> framework, however kmem_cache sadly doesn't seem to support the
> 'reserve' of pages concept that we need. mempools could be a solution
> but the mempool would need to be created by the IOMMU framework as the
> alloc/free functions are specified when creating the pool. So it would
> be a much bigger change (to drivers/iommu).
>
> So, given that so far it's just Panthor this seems like the right
> approach for now - when/if other drivers want the same functionality
> then it might make sense to revisit the idea of doing the caching within
> the IOMMU framework.

I have some plans to use this as well for drm/msm.. but the reasons
and requirements are basically the same as for panthor.  I think I
prefer the custom allocator approach, rather than tying this to IOMMU
framework.  (But ofc custom allocators, I guess, does not prevent the
iommu driver from doing it's own caching.)

BR,
-R

> Robin: Does this approach sound sensible?
>
> FWIW:
>
> Reviewed-by: Steven Price <steven.price@arm.com>
>
> Steve
>
> > Regards,
> >
> > Boris
> >
> > [1]https://gitlab.freedesktop.org/panfrost/linux/-/blob/panthor/drivers=
/gpu/drm/panthor/panthor_mmu.c#L441
> >
> > Boris Brezillon (2):
> >   iommu: Allow passing custom allocators to pgtable drivers
> >   iommu: Extend LPAE page table format to support custom allocators
> >
> >  drivers/iommu/io-pgtable-arm.c | 50 +++++++++++++++++++++++-----------
> >  drivers/iommu/io-pgtable.c     | 31 +++++++++++++++++++++
> >  include/linux/io-pgtable.h     | 21 ++++++++++++++
> >  3 files changed, 86 insertions(+), 16 deletions(-)
> >
>
