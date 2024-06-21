Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0616B3B0
	for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955259; cv=none; b=mPTrZLkYqoKUc63X3DL45SU7fhWCk6zgqlf8uAhJRugFoCKl8BrHOSsBVxq6Z+TiQax1Dn6NQn7K6PCJmfvlgAC50cdPpcy6kkZktxndk0hQ7liAGEqzIQmi+ZCGStZOs8etR3BtowK/238Cc+hoiJJOsvTAs0PljZNxBKzTt44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955259; c=relaxed/simple;
	bh=TJ/fM4/Bdi4zpe5sQdT9e9LS7r9y4uTQdY+a7ddRtPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ariqXBfTqIsz+ZbbbgPJNFeGtTjJTk6JsjxN4R6CpWjNAPRqXXZmYfnJkf3K7DMsIvG4uKLq7VnYQzxZWPtQw/fuYoMLhIxCkrY312edUq07Tflr33PLphHmornjHiP3AV8bkFTLz8XighkpQ6/QW3EYVqxOwG8lXe9d3Z12TMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SbNZ0avC; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SbNZ0avC"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7ec07f4170bso66263239f.0
        for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 00:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718955257; x=1719560057; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YJB5WMsYvwJwIsrILucvgKQ+tYLfCsBglnam11pazM=;
        b=SbNZ0avCOhi57iP68pgp3H+x7Eu+BPniuTFVPUe5XbVNiN4Yr9ESgUTSTS4mb7c8EK
         lTXdX6adJam6YHUaEFMgeC8c/fGD/hdGtvC5PjjX/To1/DEwrMim/bomhueK91L+epEg
         a8U+YDgIyH9q0truxuroEY1OUKpNjGK/T6N8AQDNekVy0uaoDbvD6Jk1KbaV36TryZHq
         K1kyrzp1gniihH/avexYykSu7EZ0Orfn2clrNB17MpDUM9aWigKyz3qb4V++PcItz5Vp
         dJaPOU3ajRMh8yuOUQUgFk41Ao3CfwV5NGYtkvzZc2Itkf89TLvbJB56afVgxbX647Xr
         VK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718955257; x=1719560057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YJB5WMsYvwJwIsrILucvgKQ+tYLfCsBglnam11pazM=;
        b=jeiY5uxyd5AjxkidQvBZU95RmRmZ31JJoT/c7wQUUklg/apUOR9VjCN37Bpw56VSVS
         L7U9RRP+wmiKJ3bn7f4VDKYZQzLiR+TU/Obb6QBC+unFZK46dp3UsN9kbQDEEWhyPjbV
         ixx6DM53qXN3+kAsYjDGlVKuTE8VSt8emCm5eONelC+3Hbg/SFXLAMM0zaWux3S8gDLm
         OdSAXEbdHazfwkhoiqh7+NSnayWPB1RyOiItEYeaRAxmNgZ6+8zv8ehzFwbZY1RyKD5U
         8HDiB/487qA0l5O7lCsQR+FwYmVyERjR20L/LKR/Vmyfwpq4tKmi53dGNDLOhE9I71gy
         1POw==
X-Forwarded-Encrypted: i=1; AJvYcCUNcRp3x6bLZu96VhOCZiHN7KV28vLaIKzcYT7NzKbQIAi+Ea+6j+5/vwtjSJxLCi3kXcR/McL7DKmB0fabEfJajpXeyKw=
X-Gm-Message-State: AOJu0YyyHF/tuO7dnDywK7BfH/6fKLqYtKpIRwwy1fVnD+xJqvEU9SFq
	ET7uzLdbEA4zi4SoxXcpoDs3c2wthcJJAtk283c0d6gh39SMpNQdH1mCaeTkQsGCrLCRUg0WxUQ
	lVDBJ9L3RcRL1zM+xoQAQMcYhmBimshh5G/Isfg==
X-Google-Smtp-Source: AGHT+IH2z2ENNh/7avn9eIUE25VrvT6mYZ65u1+C3Qlt1wQc1RVUMHzbx3/IqLBD6fvxFHk4VEe0NCBvO94Vf6OBfD8=
X-Received: by 2002:a05:6602:2c86:b0:7eb:85f7:5f5 with SMTP id
 ca18e2360f4ac-7f13ee7bca3mr913038139f.14.1718955257262; Fri, 21 Jun 2024
 00:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-8-zong.li@sifive.com>
 <d003f916-28ca-451a-a2e1-e58c66fc3459@oracle.com>
In-Reply-To: <d003f916-28ca-451a-a2e1-e58c66fc3459@oracle.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 21 Jun 2024 15:34:06 +0800
Message-ID: <CANXhq0q8P+n52PhOc5Uu+oTBSY9bukMPXz=n909TcoXooXS8PA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/10] iommu/riscv: support nested iommu for
 creating domains owned by userspace
To: Joao Martins <joao.m.martins@oracle.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 12:34=E2=80=AFAM Joao Martins <joao.m.martins@oracl=
e.com> wrote:
>
> On 14/06/2024 15:21, Zong Li wrote:
> > +static struct iommu_domain *
> > +riscv_iommu_domain_alloc_user(struct device *dev, u32 flags,
> > +                           struct iommu_domain *parent,
> > +                           const struct iommu_user_data *user_data)
> > +{
> > +     struct iommu_domain *domain;
> > +     struct riscv_iommu_domain *riscv_domain;
> > +
> > +     /* Allocate stage-1 domain if it has stage-2 parent domain */
> > +     if (parent)
> > +             return riscv_iommu_domain_alloc_nested(dev, parent, user_=
data);
> > +
> > +     if (flags & ~((IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DI=
RTY_TRACKING)))
> > +             return ERR_PTR(-EOPNOTSUPP);
> > +
>
> IOMMU_HWPT_ALLOC_DIRTY_TRACKING flag check should be dropped if it's not
> supported in code (which looks to be the case in your series) e.g.

Thanks for your tips, I will remove it in the next version.

>
>         if (flags & ~((IOMMU_HWPT_ALLOC_NEST_PARENT)))
>                 return ERR_PTR(-EOPNOTSUPP);
