Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AAA1CA82
	for <iommu@lists.linux.dev>; Thu,  2 May 2024 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714624781; cv=none; b=U2WW4ybhSSVu27rZ9AQbaaa5s/m28OC+jGDOLLHiwyp5mQiTX4etOMw4eYN8K/I5Jy7g0l77EHBDqURo03Rccwz65Q2QzPMyn/U2RjG04pLNmesPzO5n70EuM1ukmwuAI3yGFaabnWv3n3rGleaUqdh9TOB0W45UnJ0E1Q7rEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714624781; c=relaxed/simple;
	bh=NKq8vrxCem9objWV3C+MOFnpbo85KhNs4PiXk/R07Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqRi0Lwk9yC7wxnuxxPbSyrS81T7qo9ZZACxvRNHPOpCALChhjee/84G/yN6agWgj5BskVshO9KsRtnIny936CUMBfrCVVugXAlDGVl3Xh0B5lCGvAAurboNImp+ElmpVSGLn+wvLbSbLhO7JCWvuLeNCtSp8JeVldZ59AxqH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CudFLu2P; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CudFLu2P"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so6346243b3a.3
        for <iommu@lists.linux.dev>; Wed, 01 May 2024 21:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714624779; x=1715229579; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYwMNtU5ISKi/pHw0Eotzjxo72T7kdIEeid7s5bFFZU=;
        b=CudFLu2PuLAb62IJ/ZhSZibBQiCXZTwt6EdNaZADiMXV29rIjIFwiu9o16+mMEba0I
         unJc/0b+bE6QPUvnNHAfE7v0Q8WWF+Id8D6jH6NLxPCVXhKc44BGMXLrrl0kgj03CAr3
         p3tm1EmBZxuC33KW69d9vrLWS1cSiG+mbvCKpcw0dGlisE5EcUES7YDhHQnjwlI+DfI0
         d/xsc+BsWSoxmdD9Apg7yJv22FQQPfaZPg1Acqn+BvQgmeSrYKca6bu/5vzlrJaAnsUy
         HRsibGH6RTw7oxYT432JtlgLPqdC2COtFdjyod5EVwiMAnRjYxjdI8/65qApEc/5n5js
         D1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714624779; x=1715229579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYwMNtU5ISKi/pHw0Eotzjxo72T7kdIEeid7s5bFFZU=;
        b=aJLY9F7nXOh76ohdHamKvIzT5bWtz1iDJ5dgvtoTRsexULBJ5Sf6UphhFejO7oxAfK
         X7DZFGCqjPescMpcgw3ZmCKZfG+l9AcSCbzFdPpe5PoUM85k9lve5yF7k6WIEuTU0R0c
         C0SptjnvAwTkyi4xWfhJbi1rqs7gBz0uhdWJXybX9IdoXLjF/MzSFGZBbrKWFKBy0CcC
         EfxzVEOgfOaCPWNp5h95Y8M0QnhyPDX3/QhvTzm6Mc7oW+NtalZPh3rxHqhD1sIBkdQl
         TOqlgSzJie2wyLY+TB2npFDQXOOtcCOD7aXSxNReyJWmzLQ3zTrww7CyLi5TKEfOR1kx
         AXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUORM+ChfTJCgwf2JmxD0+AaTQopmxRlcignxYTFvPvvZ7hSgiQlvf9P5rhHPyYRt49JqwolHubzHALBNI1Lzx1s3LyJws=
X-Gm-Message-State: AOJu0YyBEvhcInh2TSkRNoG7/4Mlbi3EVW8SWAQsu81247lxRqsTEUmC
	fubOwXTFW3RkwKoXJjjJ8NN/3rWl/KCW305kVRQvfp7YYyJmQpW5wCk0QdGK51JCzwxL/wroYx8
	e1RzmqAoBgDljQWNLVQMTY0yL2XEnfNMei+DCbg==
X-Google-Smtp-Source: AGHT+IFGOZPSbOG+7q08BpoKEAwkSMY5N4r9BG/M6xWabJ6xt9Bfuyl68UiysrvQmviAyEuWdMP6+zF6WYqEShpC7Aw=
X-Received: by 2002:a05:6a21:150b:b0:1a9:a31a:1b67 with SMTP id
 nq11-20020a056a21150b00b001a9a31a1b67mr1221119pzb.47.1714624779299; Wed, 01
 May 2024 21:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1714494653.git.tjeznach@rivosinc.com> <b83f81c04d1f3885d860b1eec03761fe63a33183.1714494653.git.tjeznach@rivosinc.com>
 <7c3fc511-6a3b-44d8-94fa-e4fff54f93b9@linux.intel.com>
In-Reply-To: <7c3fc511-6a3b-44d8-94fa-e4fff54f93b9@linux.intel.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 1 May 2024 21:39:28 -0700
Message-ID: <CAH2o1u6Vh55E=jn7ytp7s6VSQaZ+BqKLY1adz2AA0=OsLm21dw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] iommu/riscv: Paging domain support
To: Baolu Lu <baolu.lu@linux.intel.com>
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

On Wed, May 1, 2024 at 8:52=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com> =
wrote:
>
> On 5/1/24 4:01 AM, Tomasz Jeznach wrote:
> > +/*
> > + * Send IOTLB.INVAL for whole address space for ranges larger than 2MB=
.
> > + * This limit will be replaced with range invalidations, if supported =
by
> > + * the hardware, when RISC-V IOMMU architecture specification update f=
or
> > + * range invalidations update will be available.
> > + */
> > +#define RISCV_IOMMU_IOTLB_INVAL_LIMIT        (2 << 20)
> > +
> > +static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
> > +                                 unsigned long start, unsigned long en=
d)
> > +{
> > +     struct riscv_iommu_bond *bond;
> > +     struct riscv_iommu_device *iommu, *prev;
> > +     struct riscv_iommu_command cmd;
> > +     unsigned long len =3D end - start + 1;
> > +     unsigned long iova;
> > +
> > +     rcu_read_lock();
> > +
> > +     prev =3D NULL;
> > +     list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > +             iommu =3D dev_to_iommu(bond->dev);
> > +
> > +             riscv_iommu_cmd_inval_vma(&cmd);
> > +             riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> > +             if (len && len >=3D RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
> > +                     for (iova =3D start; iova < end; iova +=3D PAGE_S=
IZE) {
> > +                             riscv_iommu_cmd_inval_set_addr(&cmd, iova=
);
> > +                             riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +                     }
> > +             } else {
> > +                     riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +             }
> > +
> > +             /*
> > +              * IOTLB invalidation request can be safely omitted if al=
ready sent
> > +              * to the IOMMU for the same PSCID, and with domain->bond=
s list
> > +              * arranged based on the device's IOMMU, it's sufficient =
to check
> > +              * last device the invalidation was sent to.
> > +              */
> > +             if (iommu =3D=3D prev)
> > +                     continue;
> > +
> > +             prev =3D iommu;
> > +             riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +     }
>
> I don't quite follow why not moving "if (iommu =3D=3D prev)" check to the
> top and removing the last riscv_iommu_cmd_send(). My understanding is
> that we could make it simply like below:
>
>         prev =3D NULL;
>         list_for_each_entry_rcu(bond, &domain->bonds, list) {
>                 iommu =3D dev_to_iommu(bond->dev);
>                 if (iommu =3D=3D prev)
>                         continue;
>
>                 /*
>                  * Send an invalidation request to the request queue
>                  * without wait.
>                  */
>                 ... ...
>
>                 prev =3D iommu;
>         }
>

Oh. Thanks for spotting that.
Code section reordered very likely during rebasing patches...

> > +
> > +     prev =3D NULL;
> > +     list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > +             iommu =3D dev_to_iommu(bond->dev);
> > +             if (iommu =3D=3D prev)
> > +                     continue;
> > +
> > +             prev =3D iommu;
> > +             riscv_iommu_cmd_iofence(&cmd);
> > +             riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEO=
UT);
> > +     }
> > +     rcu_read_unlock();
> > +}
>
> Best regards,
> baolu

Best regards,
- Tomasz
