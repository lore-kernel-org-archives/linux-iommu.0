Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09DB160787
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095214; cv=none; b=l2kXHKam40Gc8TvKL7yNpRO8Fla02zQqPZQg0LrySoUMBo48LfISrAUWYONEu/lFNoH9kNerTvczBuKQ9LPfPWOfT0iX4/oIs9e4Y/5R6FVUiJc6CLoQTw7T5NjY3PSSkkxEpUJBv73CxhGz5oAr8C2uNDFsJ7/R5Ro6xTFYoqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095214; c=relaxed/simple;
	bh=7wzzu5+Dyb2zQQ/BBHzdLsyJSaQZyO4yWyaBmCt+pjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjVHRkrqCHxwXcR2/96E+yzi6PEXEKGtSmO0qu9+JHbzYm1fAqTrKA0pfii+YvMmW4UZ9l9lL9R6YpH4nkQmYXdTmfcUJNP7yNMp2aKDoMgYRRx7epdYfSiX/04M8WAiL6G6p8Hh1y57/hgi/0Thkw93w7ZLTUhc1E/MwDTD2r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=da3zwqC7; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="da3zwqC7"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7e180e2b288so42979839f.3
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715095211; x=1715700011; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3612MOIikzCEeo+mwv3X2VMyaMFpK5mgqqdWHRbusjg=;
        b=da3zwqC7vyYOFHrh9TwbEd4MCsmx9awpV83I3LS27+SorOSQbnN/WczIczUFZtjKq9
         2QV6gYBurLZtik0pYmQTWjHKSwO1XGuk7FrstaHOLwhRkJr6hRl57v9oSs+L17GlRGFX
         j7cdpWSewIn9N2vKVvpLb099htLZJs26YWPUOaWVY5kb50SEYA64fNKVV5zzbzj+tKSs
         uECc7laAtudyz+8wvolq7Q6P2xf9StrFmY5mjv+/8icwQR9iX7oikyM7woHwU38/2TJq
         2vRW61NCPiZkAvUYXNXRqt02Ig3JTrGrHGbJkvSKWflb5mZDO0wv1HVDQhk1sXAUE6jK
         3aPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715095211; x=1715700011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3612MOIikzCEeo+mwv3X2VMyaMFpK5mgqqdWHRbusjg=;
        b=c/Q6YtaWUAw7MQSgxS9qbdxnrAm5V3x3DmMwgUY6emYueNMZyFTFEv+SwAklwT5Sq9
         reilQeF1pZiZWzqLOaOxlFKV8q+/Hvg7z5k7IH8lagTG2EIYf06zHABWMgI0MTkLv301
         wY+fBBE4q/Ofrdl5qtSji7twITqJzcNMNXp1UKr5LKN9/lbOnHMNUJSGZyz1tTFmNemO
         9kQ3UwoZG1/FHQetn+qMtOjtdjp8fVqpWuXQHyY2vSwTgtYHZCOyWVCoE8WOjHg96s2L
         q5ZT6fgh1OHPAAbg+akZgvUrf3EWFCxR6HOrJHejBP30YhCO69ATkqzk5hd5uX31DHZJ
         +91w==
X-Forwarded-Encrypted: i=1; AJvYcCUHFlnF+edO+hkVSIt8xMEeD7PRz66WrV/5D29Bvgvqrx0zXvQ+EqjTxH2u+IPZkowMQAWhwq2qgS1EWopcQTkghBnHbs8=
X-Gm-Message-State: AOJu0YziDgBCAnVvN89mkSaioZKohR5nzy/IHdfYMRCQ6nMNpRiv8KS5
	EwyBS17yrFRT/FWEttEhB41QmMCKjpZkCrX5ZqOIIp1dz+It2TWP7wCN9rvqD/xeMHl4FZi7pXZ
	n5ZH9Is0gY3xVpRFEidn0Ixc72Pcd+4RBT3VTxw==
X-Google-Smtp-Source: AGHT+IFHKLBV5UyA+nE/FKsONZhELrkveEhHfV9QMKA63cqAy8XVSr7F4OwiQdsFr0lrM8BGsK3l5VTeIv2rndOqxu4=
X-Received: by 2002:a05:6602:f08:b0:7de:ac01:4224 with SMTP id
 hl8-20020a0566020f0800b007deac014224mr15044010iob.1.1715095210897; Tue, 07
 May 2024 08:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240507142600.23844-1-zong.li@sifive.com> <20240507142600.23844-5-zong.li@sifive.com>
 <20240507145456.GH901876@ziepe.ca>
In-Reply-To: <20240507145456.GH901876@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 7 May 2024 23:19:58 +0800
Message-ID: <CANXhq0ptCxyUc==oCG8MgLOCdF7Z=KRW4pct62BCSgsB_9hQkQ@mail.gmail.com>
Subject: Re: [PATCH RFC RESEND 4/6] iommu/riscv: support nested iommu for
 getting iommu hardware information
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 10:54=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, May 07, 2024 at 10:25:58PM +0800, Zong Li wrote:
> > +{
> > +     struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > +     struct iommu_hw_info_riscv_iommu *info;
> > +
> > +     if (!iommu)
> > +             return ERR_PTR(-ENODEV);
>
> This is not possible, don't include impossible checks like this.

Thanks for pointing this out, I will remove it in the next version.

>
> > +     info =3D kzalloc(sizeof(*info), GFP_KERNEL);
> > +     if (!info)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     info->capability =3D iommu->caps;
> > +     info->fctl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
> > +
> > +     *length =3D sizeof(*info);
> > +     *type =3D IOMMU_HW_INFO_TYPE_RISCV_IOMMU;
> > +
> > +     return info;
> > +}
> > +
> >  static int riscv_iommu_device_domain_type(struct device *dev)
> >  {
> >       return 0;
> > @@ -1560,6 +1582,7 @@ static void riscv_iommu_release_device(struct dev=
ice *dev)
> >  static const struct iommu_ops riscv_iommu_ops =3D {
> >       .pgsize_bitmap =3D SZ_4K,
> >       .of_xlate =3D riscv_iommu_of_xlate,
> > +     .hw_info =3D riscv_iommu_hw_info,
> >       .identity_domain =3D &riscv_iommu_identity_domain,
> >       .blocked_domain =3D &riscv_iommu_blocking_domain,
> >       .release_domain =3D &riscv_iommu_blocking_domain,
> > diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.=
h
> > index 1dfeaa2e649e..ec9aafd7d373 100644
> > --- a/include/uapi/linux/iommufd.h
> > +++ b/include/uapi/linux/iommufd.h
> > @@ -475,15 +475,28 @@ struct iommu_hw_info_vtd {
> >       __aligned_u64 ecap_reg;
> >  };
> >
> > +/**
> > + * struct iommu_hw_info_riscv_iommu - RISCV IOMMU hardware information
> > + *
> > + * @capability: Value of RISC-V IOMMU capability register
> > + * @fctl: Value of RISC-V IOMMU feature control register
> > + */
>
> Please call out explictly what spec these values come from.

Let me add the description for the section that defines them.

>
> > +struct iommu_hw_info_riscv_iommu {
> > +     __aligned_u64 capability;
> > +     __u32 fctl;
> > +};
>
> Add explicit padding here

Add a u32 reserve here in the next version. Thanks

>
> Jason
