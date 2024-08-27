Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C501CE6EF
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777689; cv=none; b=UXro2LMmngsF9udsv32hraQkPSrPceBTPsYKQskn3f7nE2V7hYmL4ro+k2Sj7dLTAJ2YTwEBZ6jHXNou17ilMtUoUMo5BLt/5tsSdEwKk1fxousXsRPVpTwC1hi82xpXu+N+PddVDOb4m4oRk6eFZspahC+B7NcQktbAVD0VX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777689; c=relaxed/simple;
	bh=Kh5uwhThs9nwoOn3AOzyE5Y4+zLLyobYmzrOmotESss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRWY+QWc6USl/oLOv9xUvC2vs3W/9DQEF3BOfPShABJQ57IW85ibTkinEJtiOU+znXC3QzM03d0b9VETfuArBu/qL6kl2uZRZAOZOAqcuG4UUAglFlcRsrsLcQnFp5iWcybQgqpF8NX+mmZnZg4LUilb5v+oP+hTMEDgC9KTw4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ld8CEAYH; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ld8CEAYH"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f3f0a31ab2so63919741fa.0
        for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724777685; x=1725382485; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eb2QWgFjgHyzTInDHeCmDGITmXg3uxSmkR/8gVOEr4=;
        b=Ld8CEAYHuKsifMkLDlY/tU1/xbdGO3FaWnKQBuqEppROTqsG9pBJwV4Y/QFGi+US2e
         JSapcS/5vZx2pAoWU8/7Xx5XaSzu7u8qYp13o0eBol6R38EYqj3NiLJveXrwd751qkvP
         ZueZupxjGpycvBK8zJezOSVc1Xqq+YeZ9wNWUsXlxPIvMO8EiK0QpUFO2hrLQWt4bGqw
         kCm0jCEV/GNZKy2//xcb+3fYTenOzLuUl5WGR2sEFa6VmkLaJEHEICce+5BOvweOHKRS
         NzDu0GlNEnD3Z5JXpSxxa3YzowlOGA8Gem3EwNZ3Znl4SFzbsLcKWAwCa+QkRcH3j4GO
         SUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724777685; x=1725382485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eb2QWgFjgHyzTInDHeCmDGITmXg3uxSmkR/8gVOEr4=;
        b=nZ1etho5o1mhqPK+ffdv78fZ+ljQ779c0sr7ojG9IZ0YQh9b14f7m5HlY7cSVJgkWK
         2xYHylmVjQKxm7GAN0gR7v4CXusIhQvuRvGoKi926sguTQ10lTBrJPa10fwQyTjQiUOO
         nb0/TaEtk8dLCbMkQDPrOu6wqkt4k2keTSiwPhXJFisiJD4lEzEf/5wgT01QlVTULeMu
         Xy1AxxIJ7OvinZ0zR6oKqj9dzD4dVn0xjcvMoBXzMTYxsofeb0ynBL76xvQIU8etuGsV
         taoq1Aet6BJ9zJ3c3BI1osNJx6AfPChSWy87qZAoV8iEDIWJa5LvGfE11lhvIBabHWmZ
         2GLQ==
X-Gm-Message-State: AOJu0YwJurQyeOIbhaKbto7IB61ZDIEX48agrVyDSmPCCsv9QSCcpPVm
	sfCsyeCRxOjk8eN3MfvtheKpaXPNEP5UqZJVa5dpx3/9575cB37eidHzbiI53odk8WxWoALnFBY
	zDwGegN3pr4+7GZB8l1btY7PLF8I=
X-Google-Smtp-Source: AGHT+IEWmSkDqqcpudL+qeabHRRdGN73leKg2ewiSqympFDcYlaA6AXEBVN2n5bPd3N7145iXT4Kma+Sh0sbZxXVllg=
X-Received: by 2002:a05:651c:545:b0:2f3:e2f0:fa8 with SMTP id
 38308e7fff4ca-2f4f5728ec9mr94339371fa.9.1724777684568; Tue, 27 Aug 2024
 09:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240826171546.6777-1-robdclark@gmail.com> <20240826171546.6777-3-robdclark@gmail.com>
 <20240827120205.GA4647@willie-the-truck>
In-Reply-To: <20240827120205.GA4647@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 27 Aug 2024 09:54:29 -0700
Message-ID: <CAF6AEGtFg2D=4RVQC=YT9OsqdNwwsuJCyi=hu8Box0A6psecQA@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, 
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 5:02=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, Aug 26, 2024 at 10:15:39AM -0700, Rob Clark wrote:
> > @@ -776,7 +775,7 @@ static int io_pgtable_visit(struct arm_lpae_io_pgta=
ble *data,
> >               return 0;
> >       }
> >
> > -     if (WARN_ON(!iopte_table(pte, lvl)))
> > +     if (WARN_ON(!iopte_table(pte, lvl) && !selftest_running))
> >               return -EINVAL;
> >
> >       ptep =3D iopte_deref(pte, data);
>
> I still don't grok this hunk. If the selftest is running, we want to
> return -EINVAL here rather than dereference something that isn't a
> table, right?
>
> Suppressing the warning is one thing, but this seems to do more than
> that.

oh, that should be

   if (!iopte_table(...)) {
      WARN_ON(!selftest_running);
      return -EINVAL;
   }

I did boot with selftests enabled, and it didn't _seem_ to complain
about anything, so I overlooked that

BR,
-R

>
> Will
