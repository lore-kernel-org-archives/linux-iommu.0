Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB021A2C39
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555637; cv=none; b=cFLFojSoBHG+VcFYv6ez5SqpNysFkgHyYCjwcmXwOJWRpurl4MhMxpSIXXslYgN0U2VOX0UMIb7KUsUWD0hZXYnMjfHOJmH6p26ANrDs9d9amjYqdbMMKsEQdOkHrjrXyucRrt0B0G1c3Ph5eD9CRC9yMZwQnlpUohqErD0Rpgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555637; c=relaxed/simple;
	bh=0xRWDki03sNCLRzgJ+q3t0ANUfhb4+r2+irubfO7wyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2gXnJ9A1lYpCbLcP5D0ou/ixuk23MbUn+NclzwCiFk5yGEe6PhFoT5gES6vKV6UXNQf8+tQ3QO6eQs47DWoR2+t2J3hXpUWXvcFkGHwBBSP9TIBzPd+WYXWJJfzsZh0l7Ha6bHSeX9eHZN8iAwU4uUzRtEeYsQ33x0IfmtcE0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLIoY9uF; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLIoY9uF"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39e6a1e0079so3985275ab.0
        for <iommu@lists.linux.dev>; Thu, 05 Sep 2024 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725555635; x=1726160435; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZV/Ct62i0SWe/eQOuu8hbmxJsUYcvz+0fB6177mZLk=;
        b=dLIoY9uFpWBsEAASX7VfvCglXAoeq4R3OXVqM6M5vQSn30+WyyKCZ0RwnoszPKhpRG
         ZstQs8edarA+Fj36tJz1ax8psYYszDSS890F8ZdrzjMtONds9OUyuEw0CxIVuaiWk+4U
         hWYxY7jF3bEgLXpMiQ3erxNY95ACWYUjKiJsfEXPaQObM/IeczO9OpU0iOhDP/KxGznF
         r2bu9cRyoj07lxZHPWvLjQT/ToRqum+ua58ELERpM2CpVFZLVJaIDaeo8dY3/Vp1kDZR
         FGo7fmP3UKiX0FAPGgKwR96JL8FAGczyiWjWK7q52wr3un3pvVr01gTt9vAJzxizopAa
         XgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725555635; x=1726160435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZV/Ct62i0SWe/eQOuu8hbmxJsUYcvz+0fB6177mZLk=;
        b=YuwVio+nGOQDAMXiBCucJ67uISfYbrm+pmAEBsoXRAqDxjS8GV+TFjOVa1+ZVlSjsM
         tgPMI/SsJi+J83ezjziE/HRxXwz+NHjgozkNruRw4AWAxSzBACv2ymQZHeR/ZpWCrKTA
         TvlXB4YFOuNnk4OHp7uWMa0/R0jFdu4gN97DZEmaSn4Y34nx4WbW7jSpZ8aUj8mKNvcd
         A7jM49o6lSM6lWp+e5wHd7JKLdVv/hKUOmUahENsdmLFu9a7FLLM21sVPpCMbA4UMyz7
         gz/xtkk1FlUCMK8lLl+JhQJ5ZXFMQkTFJFQk7yAEe8YeNRny6LyJdVp0dLkTi7Yp5LRR
         OEXw==
X-Forwarded-Encrypted: i=1; AJvYcCUO+BnyW53Ae9fmYfXp9sR8rj2PWbYX5mgNRqan/D/YGRERHINJKIzABQEv0KpbvV/+8cjilw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkXg6aLVzwosdMz+eZaFXgUeaCfDU5TMixseWY1iCllgoEUa6t
	e79lNR8roHPgHXvjU/DGAb7MTYGckt6z1FNjg0wULYk910pm6LwS1qSSV5OcdF3RPD86Ucuedyk
	BPOsqegWtm4NasJhLKgZazwmpvps=
X-Google-Smtp-Source: AGHT+IG3fVJMj8X+QupsVk+lbXCJzCFrxGLdE4Y0iBpJXuWEfA4+fZ1P0PS+T7tA6d644LYLD2Q7k7jx/OI0IyXRgj8=
X-Received: by 2002:a05:6e02:1545:b0:3a0:4255:1912 with SMTP id
 e9e14a558f8ab-3a042551a3bmr75420225ab.10.1725555634840; Thu, 05 Sep 2024
 10:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240905124956.84932-1-robdclark@gmail.com> <20240905155330.GA15246@willie-the-truck>
 <53f13813-a515-475a-836d-0b6017a117eb@arm.com>
In-Reply-To: <53f13813-a515-475a-836d-0b6017a117eb@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 5 Sep 2024 10:00:22 -0700
Message-ID: <CAF6AEGs3aRXbnnhD84GBbz9wJmyNR=dA3hbGuMLcM22Vs8CU_g@mail.gmail.com>
Subject: Re: [PATCH] Revert "iommu/io-pgtable-arm: Optimise non-coherent unmap"
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Ashish Mhetre <amhetre@nvidia.com>, 
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 9:27=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 05/09/2024 4:53 pm, Will Deacon wrote:
> > Hi Rob,
> >
> > On Thu, Sep 05, 2024 at 05:49:56AM -0700, Rob Clark wrote:
> >> From: Rob Clark <robdclark@chromium.org>
> >>
> >> This reverts commit 85b715a334583488ad7fbd3001fe6fd617b7d4c0.
> >>
> >> It was causing gpu smmu faults on x1e80100.
> >>
> >> I _think_ what is causing this is the change in ordering of
> >> __arm_lpae_clear_pte() (dma_sync_single_for_device() on the pgtable
> >> memory) and io_pgtable_tlb_flush_walk().  I'm not entirely sure how
> >> this patch is supposed to work correctly in the face of other
> >> concurrent translations (to buffers unrelated to the one being
> >> unmapped(), because after the io_pgtable_tlb_flush_walk() we can have
> >> stale data read back into the tlb.
> >>
> >> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >> ---
> >>   drivers/iommu/io-pgtable-arm.c | 31 ++++++++++++++-----------------
> >>   1 file changed, 14 insertions(+), 17 deletions(-)
> >
> > Please can you try the diff below, instead?
>
> Given that the GPU driver's .tlb_add_page is a no-op, I can't see this
> making a difference. In fact, given that msm_iommu_pagetable_unmap()
> still does a brute-force iommu_flush_iotlb_all() after io-pgtable
> returns, and in fact only recently made .tlb_flush_walk start doing
> anything either for the sake of the map path, I'm now really wondering
> how this patch has had any effect at all... :/

Yeah..  and unfortunately the TBU code only supports two devices so
far, so I can't easily repro with TBU enabled atm.  Hmm..
__arm_lpae_unmap() is also called in the ->map() path, although not
sure how that changes things.

BR,
-R

> >
> > Will
> >
> > --->8
> >
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-=
arm.c
> > index 0e67f1721a3d..0a32e9499e2c 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -672,7 +672,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_p=
gtable *data,
> >                  /* Clear the remaining entries */
> >                  __arm_lpae_clear_pte(ptep, &iop->cfg, i);
> >
> > -               if (gather && !iommu_iotlb_gather_queued(gather))
> > +               if (!iommu_iotlb_gather_queued(gather))
>
> Note that this would reintroduce the latent issue which was present
> originally, wherein iommu_iotlb_gather_queued(NULL) is false, but if we
> actually allow a NULL gather to be passed to io_pgtable_tlb_add_page()
> it may end up being dereferenced (e.g. in arm-smmu-v3).
>
> Thanks,
> Robin.
>
> >                          for (int j =3D 0; j < i; j++)
> >                                  io_pgtable_tlb_add_page(iop, gather, i=
ova + j * size, size);
> >
