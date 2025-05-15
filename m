Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E00A18BC3B
	for <iommu@lists.linux.dev>; Thu, 15 May 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320534; cv=none; b=mqbJ6F9WalfzMHpf3kjBbbfRS+Q7Dh0bKmAQC/uXBB1/UBCeUb8cmLfp3UmwOMzn7BpvNmpdWD5ZUpxMivbIsbsbZmLYAPEllcGGl5bILq8Rgl3eaakVP0zLwrpKBrsmksYsZLWNApjpbdXwbvis4ZoDNq9amaJvb6t91bB2dv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320534; c=relaxed/simple;
	bh=sHAOrLfoP9W72YbPlypXyXEkxapheQXBsW9OcIkElqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grJxC1TKkDUthXbYS3GpowcjC1KW1miV3nZPxEFZnWOC6rcEEGtpU2TFQRRkVpgooy51kw5ji7tPIf5/668KLCDymN8e7izhMdJ7+W5gXLl+LHEjbqOWREJHggSxH6MLJxA5B31Az0SCywY0sFPdZSQX7hB0GQqOwNZ8JkGyT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFYAILQC; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFYAILQC"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85e1b1f08a5so28039439f.2
        for <iommu@lists.linux.dev>; Thu, 15 May 2025 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747320531; x=1747925331; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UcpEFBY6ddNvtG+RJyIJB7SfDGpOmaoMi5EF4Kq9Vk=;
        b=NFYAILQCfr2vddpT5VdU2HIiPP9vOULGuikhsNHlCA7nKMPkRSWJtmvhlB+R6XwkPQ
         59mOr+8cE1uIHrma0n4ABSH3Y/ipidXmLmHNvoR5c0SZrz4b42kl4ftY5FuJAjaJxbfA
         8S+t+p9gKD1tEm2kD0jXAadVr8OxaQQjQRIzXApVTY9YhNksAW3w1iCg/YHY98HKbtWp
         CYr2oq6QU6lIfI5esmRzt3VmQD81VuqILQJA1r6kLfeJxUY+CAHoVXHmeGJriXJn42hJ
         FgWqpgwoqrmB9IFj443yv1HfugbIN0Z3NRqpsMa1/MNhYoyHrF2NBOfR4lMTqbSXiPbr
         +GKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747320531; x=1747925331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UcpEFBY6ddNvtG+RJyIJB7SfDGpOmaoMi5EF4Kq9Vk=;
        b=IfDJL8DgJR3k+lDCZcByhUF1Oyso2V/YJeFGFLf6CZnw7tXst6p7xlUa6bBPxMTYDT
         F2yuSkZX5W2DI4q8j1jxcYnzaywsYKVFcHEbR2TcBhgy4Jcx0bahDjw7QThooWXbH49G
         /WLIAJkgnFZUOJA6sOonRpQqT/gtnsxHmK+dJtOirrp5D9vqOazASenbB/1wTbBTytum
         nkObGnpkBfuU00eSDhSl9Ke6j9Vr/aMEGUbArgSc1VGwNkBeRsWKpKEsSM949j6XFOn6
         EAejZPZN3snH1MAxLAz8+Yp79WU0T9eHyjbDd4KRP56z17LE8HpkBNeJ7f86KXLWeUr6
         XN/g==
X-Forwarded-Encrypted: i=1; AJvYcCWkpG4ZK4LZM8HI9SfSvPYN2CNhuHZq/I4Hjzsxtb56m3FfnLfkvybqXaATnvgJympLStyvMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyt5OrvIiiGAAqt2iqOXTkXShSJufz42XDfrzsH1zgvHqYTUpOM
	lEa+a/EYZYYHzSAcR183IgjUoxWT3Ldtq2qqOwAy1iVcJO+zuNHaASTlngDBzvxndBAWpE2y5Ve
	DUd0I+TnVq+fcDG1Bncb5eDpy56E=
X-Gm-Gg: ASbGnct7e+fYb9nlrLT358n58VVChVC6/07+DCAfWG4H2j1E2t4LwwdNNKibYeRTbym
	oOIzzSe9uauIT7mx4LuMmYLOl4QososkIyrlAxNDp2TbMhKGamSYD5mh0nx3r2gKZ7Z8N/Gcr/Y
	uxasJZd4/ZomzTp/IhH7HD+AIuoI4Qg5O//EW3A30nOzC5OZDNYDey7Fqo857pEw==
X-Google-Smtp-Source: AGHT+IFtWg4FcpaQcpwpTvAAxNygeksmyF1l4sqwxDFcYvvnKFT5/XBtYVHhM71RjDfHHRY+SZGmXPFPj2VfnOhCfgs=
X-Received: by 2002:a05:6e02:5e08:b0:3d8:2023:d048 with SMTP id
 e9e14a558f8ab-3db6f7fa0c1mr68163045ab.22.1747320531316; Thu, 15 May 2025
 07:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250514175527.42488-1-robdclark@gmail.com> <20250514175527.42488-6-robdclark@gmail.com>
 <20250515143309.GA12165@willie-the-truck>
In-Reply-To: <20250515143309.GA12165@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 15 May 2025 07:48:39 -0700
X-Gm-Features: AX0GCFtBF3BgAWnijILzbnLfQ8NIY_C-HxQIavKJnQ_xQacCvqpfSyafYx2RZYo
Message-ID: <CAF6AEGsnOD8fZmTXAEZZNrdK-NXdUJF51s51EhYQ6Ed7dCFM0A@mail.gmail.com>
Subject: Re: [PATCH v4 05/40] iommu/io-pgtable-arm: Add quirk to quiet WARN_ON()
To: Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, Connor Abbott <cwabbott0@gmail.com>, 
	Rob Clark <robdclark@chromium.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
	Kevin Tian <kevin.tian@intel.com>, Joao Martins <joao.m.martins@oracle.com>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 7:33=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Wed, May 14, 2025 at 10:53:19AM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > In situations where mapping/unmapping sequence can be controlled by
> > userspace, attempting to map over a region that has not yet been
> > unmapped is an error.  But not something that should spam dmesg.
> >
> > Now that there is a quirk, we can also drop the selftest_running
> > flag, and use the quirk instead for selftests.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > Acked-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/iommu/io-pgtable-arm.c | 27 ++++++++++++++-------------
> >  include/linux/io-pgtable.h     |  8 ++++++++
> >  2 files changed, 22 insertions(+), 13 deletions(-)
>
> [...]
>
> > diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> > index bba2a51c87d2..639b8f4fb87d 100644
> > --- a/include/linux/io-pgtable.h
> > +++ b/include/linux/io-pgtable.h
> > @@ -88,6 +88,13 @@ struct io_pgtable_cfg {
> >        *
> >        * IO_PGTABLE_QUIRK_ARM_HD: Enables dirty tracking in stage 1 pag=
etable.
> >        * IO_PGTABLE_QUIRK_ARM_S2FWB: Use the FWB format for the MemAttr=
s bits
> > +      *
> > +      * IO_PGTABLE_QUIRK_NO_WARN_ON: Do not WARN_ON() on conflicting
> > +      *      mappings, but silently return -EEXISTS.  Normally an atte=
mpt
> > +      *      to map over an existing mapping would indicate some sort =
of
> > +      *      kernel bug, which would justify the WARN_ON().  But for G=
PU
> > +      *      drivers, this could be under control of userspace.  Which
> > +      *      deserves an error return, but not to spam dmesg.
> >        */
> >       #define IO_PGTABLE_QUIRK_ARM_NS                 BIT(0)
> >       #define IO_PGTABLE_QUIRK_NO_PERMS               BIT(1)
> > @@ -97,6 +104,7 @@ struct io_pgtable_cfg {
> >       #define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA         BIT(6)
> >       #define IO_PGTABLE_QUIRK_ARM_HD                 BIT(7)
> >       #define IO_PGTABLE_QUIRK_ARM_S2FWB              BIT(8)
> > +     #define IO_PGTABLE_QUIRK_NO_WARN_ON             BIT(9)
>
> This feels a bit fragile to me:
>   * IOMMU-API users of io-pgtable shouldn't be passing this quirk
>     but might end up doing so to paper over driver bugs.
>
>   * Low-level users of io-pgtable who expose page-table operations to
>     userspace need to pass the quirk, but might well not bother because
>     well-behaved userspace doesn't trigger the warning.
>
> So overall, it's all a bit unsatisfactory. Is there a way we could have
> the warnings only when invoked via the IOMMU API?

iommu drivers _not_ setting this flag seems like a good way to achieve that=
 ;-)

The alternative is to move the warns to the iommu driver... but they
could just as easily remove the WARN_ON()s as they could set the
NO_WARN_ON quirk, so :shrug:?

BR,
-R
