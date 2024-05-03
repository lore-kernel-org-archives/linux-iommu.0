Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF8158A07
	for <iommu@lists.linux.dev>; Fri,  3 May 2024 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765463; cv=none; b=jwNKPqTjangfsDF5UKWEiMRKPMRm/+eYurQDBa+ppVuiwRIMuXln7Cdk+3IgSib86i1sApET/mW08DNM3sgOT2qxfw2ZXnJbPjfNmi9YU1L6QaD5KCs7XvsbHJxQ4hrCzCRMNrkdgVtDICdJkTgDlFrIJuqxRzN4EXCkCvo9E78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765463; c=relaxed/simple;
	bh=0NLlSbUWjtfkSNMe90tPQL2xSqgQxt8SNfb42yWTU8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGj43Y6+nDU1qy33hFRLD2Of3T72dwraw/orhwU09mSf/av9toxro38+OrwZNVGxWunUbBJfBMwOPvaR063NwRN+7okHzUuDz+ZFF978sU3Od/CBF2qrwe0cPnHWL/iuuoKZzQoRsdB36l9luXSTIdEU8gOr7JPswoydqfi+/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=P5yr2amL; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="P5yr2amL"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-61c4ebd0c99so21030a12.0
        for <iommu@lists.linux.dev>; Fri, 03 May 2024 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714765461; x=1715370261; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGjDpzqhZQyAQMKyqH+Z7WQdcPMW4kVzNIgeNLfdaAY=;
        b=P5yr2amL4q2MYPZyK0A7H7rzzT48u4/cYvwxet/V6bVvtdxFau8tdsQl72VbNYH6dJ
         zGlGUoe9nyjPBzUbqIGijwy6kpPB2cIv1wjHI6qcWIRUdzGph5QZKBE8GyUiBLjo0z4F
         nVZOk+qBc9/qyfj5qZwnx3qjlT3DarouZynxM7b/Sx3RGpVdJkoBGVKBr468zv1uzM4r
         jsB+wqNjDWv9yMVHEV6pEn+qmrYcai/0yW5/ZF6j3SW0wYlLyFIym8W+OrxQqjZn6t4E
         94MvnP6q7iGhOi1S252HLYYiB7zmrM8d/Pwqa3NSTYDALs0CoD5RUZ87eNfiw37DxS4g
         AAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714765461; x=1715370261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGjDpzqhZQyAQMKyqH+Z7WQdcPMW4kVzNIgeNLfdaAY=;
        b=LrhWDt78vPGnpmZ8NzJm+AgBIFNzUZTmxu1xoFFGUlZniMvjLUT/19EwOe75LqulW0
         2NnOugsbqKwhzmutXjaymQ3Z4ahL2MXCPKazx/AwyPMlj/p45j89gXTO8F2TITLhbf+6
         cV7MzY1lwsE10TYrWqfsmEeM+Ajf321O9iy3UusF1i4AY/uxMS7MPLUxXO0IeBAopEkw
         36Qifj/ZjQpdroeR4A0xHlujsds4476jzbNqNbjm3Mh+KTRWS5zD2I8UvLiWTieI6Mmo
         UHSz/WXXLYp+/SOwFSDfb7CtLyjimo0QpY0wsST/lrFba4GR0iDpWQWp5zjbxRwsFibP
         YgvA==
X-Forwarded-Encrypted: i=1; AJvYcCVoLCbiZZhU+ilCwyUaB7v8O2le9IOMROLWEy4BuQgxF60WsA52RXQXaVJtwRKF+vA1Kb5wIkNXMlcqI8GjnUoxRGBjPdY=
X-Gm-Message-State: AOJu0Yy/MtFod3p1ep7g4X8ppD8jl9VFFfMuFh/zOiEzKMK/wVTkCuYC
	r+nPNWBn2UlcNlR2+GrLX0oQ2jY5+mSrK/jhJcGaeRvmQHvW/lDzOYEuW/+H7toVgVDX1N1BcUL
	wjnGewYqRmtWV2XDKSphw2JaFbVb9KCnTZNdiGg==
X-Google-Smtp-Source: AGHT+IHresXDj8zjJo2L5u68znPjhx0ovrbhxu+59NRfgJ//aE/UKF6ubHAqLADqE7qY9hVfIpPoveM7rHNL5OQZ3Ao=
X-Received: by 2002:a17:90b:354e:b0:2b4:33ee:25a1 with SMTP id
 lt14-20020a17090b354e00b002b433ee25a1mr3442632pjb.26.1714765460928; Fri, 03
 May 2024 12:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1714494653.git.tjeznach@rivosinc.com> <b83f81c04d1f3885d860b1eec03761fe63a33183.1714494653.git.tjeznach@rivosinc.com>
 <20240501145621.GD1723318@ziepe.ca> <CAH2o1u63GjMnYrfa8W-c1hdp+TAA0R-FyxXM4dEiFF+KEGWwbA@mail.gmail.com>
 <20240503181059.GC901876@ziepe.ca>
In-Reply-To: <20240503181059.GC901876@ziepe.ca>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Fri, 3 May 2024 12:44:09 -0700
Message-ID: <CAH2o1u7av8zMucB2sKxBOZtd1eqEC4Qmgin=8VQ03pWbQdZUUg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] iommu/riscv: Paging domain support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:11=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, May 03, 2024 at 10:44:14AM -0700, Tomasz Jeznach wrote:
> > > > +     list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > > > +             if (bond->dev =3D=3D dev) {
> > > > +                     list_del_rcu(&bond->list);
> > > > +                     found =3D bond;
> > > > +             }
> > > > +     }
> > > > +     spin_unlock_irqrestore(&domain->lock, flags);
> > > > +
> > > > +     /* Release and wait for all read-rcu critical sections have c=
ompleted. */
> > > > +     kfree_rcu(found, rcu);
> > > > +     synchronize_rcu();
> > >
> > > Please no, synchronize_rcu() on a path like this is not so
> > > reasonable.. Also you don't need kfree_rcu() if you write it like thi=
s.
> > >
> > > This still looks better to do what I said before, put the iommu not
> > > the dev in the bond struct.
> > >
> > >
> >
> > I was trying not to duplicate data in bond struct and use whatever is
> > available to be referenced from dev pointer (eg iommu / ids / private
> > iommu dev data).
>
> I'm not sure that is a valuable goal considering the RCU
> complexity.. But I suppose it would be a bit of a hassle to replicate
> the ids list into bond structurs. Maybe something to do when you get
> to ATS since you'll probably want to replicate the ATS RIDs. (see what
> Intel did, which I think is pretty good)
>
> > If I'm reading core iommu code correctly, device pointer and iommu
> > pointers should be valid between _probe_device and _release_device
> > calls. I've moved synchronize_rcu out of the domain attach path to
> > _release_device, LMK if that would be ok for now.  I'll have a
> > second another to rework other patches to avoid storing dev pointers
> > at all.
>
> Yes, that seems better.. I'm happier to see device hot-unplug be slow
> than un attach
>
> There is another issue with the RCU that I haven't wrapped my head
> around..
>
> Technically we can have concurrent map/unmap/invalidation along side
> device attach/detach. Does the invalidation under RCU work correctly?
>
> For detach I think yes:
>
>    Inv CPU                                   Detach CPU
>
>   write io_pte                               Update device descriptor
>   rcu_read_lock
>     list_for_each
>       <make invalidation command>            <make description inv cmd>
>       dma_wmb()                              dma_wmb()
>       <doorbell>                             <cmd doorbell>
>   rcu_read_unlock
>                                              list_del_rcu()
>                                              <wipe ASID>
>
> In this case I think we never miss an invalidation, the list_del is
> always after the HW has been fully fenced, so I don't think we can
> have any issue. Maybe a suprious invalidation if the ASID gets
> re-used, but who cares.
>
> Attach is different..
>
>    Inv CPU                                   Attach CPU
>
>   write io_pte
>   rcu_read_lock
>     list_for_each // empty
>                                              list_add_rcu()
>                                              Update device descriptor
>                                              <make description inv cmd>
>                                              dma_wmb()
>                                              <cmd doorbell>
>   rcu_read_unlock
>
> As above shows we can "miss" an invalidation. The issue is narrow, the
> io_pte could still be sitting in write buffers in "Inv CPU" and not
> yet globally visiable. "Attach CPU" could get the device descriptor
> installed in the IOMMU and the IOMMU could walk an io_pte that is in
> the old state. Effectively this is because there is no release/acquire
> barrier passing the io_pte store from the Inv CPU to the Attach CPU to th=
e
> IOMMU.
>
> It seems like it should be solvable somehow:
>  1) Inv CPU releases all the io ptes
>  2) Attach CPU acquires the io ptes before updating the DDT
>  3) Inv CPU acquires the RCU list in such a way that either attach
>     CPU will acquire the io_pte or inv CPU will acquire the RCU list.
>  4) Either invalidation works or we release the new iopte to the SMMU
>     and don't need it.
>
> But #3 is a really weird statement. smb_mb() on both sides may do the
> job??
>

Actual attach sequence is slightly different.

 Inv CPU                            Attach CPU

 write io_pte
  rcu_read_lock
    list_for_each // empty
                                    list_add_rcu()
                                    IOTLB.INVAL(PSCID)
                                    <make description inv cmd>
                                    dma_wmb()
                                    <cmd doorbell>
 rcu_read_unlock

I've tried to cover this case with riscv_iommu_iotlb_inval() called
before the attached domain is visible to the device. This is something
to optimize to avoid invalidating the whole PSCID if the domain was
already attached to the same IOMMU, but I'd leave it for a separate
patch series.

> > > The number of radix levels is a tunable alot of iommus have that we
> > > haven't really exposed to anything else yet.
> >
> > Makes sense. I've left an option to pick mode from MMU for cases where
> > dev/iommu is not known at allocation time (with iommu_domain_alloc()).
> > I'd guess it's reasonable to assume IOMMU supported page modes will
> > match MMU.
>
> Reasonable, but for this case you'd be best to have a global static
> that unifies the capability of all the iommu instances. Then you can
> pick the right thing from the installed iommus, and arguably, that is
> the right thing to do in all cases as we'd slightly prefer domains
> that work everywhere in that edge case.
>

That is a viable option. If you're ok I'll address this as a separate patch=
.
I've been trying to avoid adding more global variables, but it might
not be avoidable.

> Jason

Best,
- Tomasz
