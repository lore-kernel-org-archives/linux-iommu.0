Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA51E3DFE
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730332212; cv=none; b=mri2veToVrwzYM8a/f2EvdYL2oUe2HlZ+1kDNzbXYhQn8UW9wpZ+VZpPT0ldQwU1yqxAbQmkTgxA6IPVGWAd9dqzEa7YlcAn/O9ZcztlxcxmnYLCIWeE/UP+gV5JTNtMrIuvYQ7lK26Q97ld25kW16q2W94KRp+sJ8IHgMxSOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730332212; c=relaxed/simple;
	bh=g2Gr6BSJI30hLHHrUt4HEWLZS4G2MgGxc9n66A9DdH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYqrgcYD5XtMGHWkPI5ZQ6JmR0r27BNzfIl9kx8ffuHUnBAqcAmGcc7CrHit/ThVXKViymIJoQG7IsIGN/ETyq4ssCEaKzRzvR1vDCwD/VY/fXVIqVM1jt5pVDtOMnVFMRioHHGEtIclBgjdk4wJ/yVxfVH+103WNI0KxVY8W4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4VCbZFq; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4VCbZFq"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so342212a12.1
        for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 16:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730332209; x=1730937009; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xITKeeCQTPMHTwhjLrB4rhB00Y72QJELP5T2ItEbVI=;
        b=W4VCbZFqNXxaLCYisImGTR5sy92QdRYwFqC8dog6qjBeb4Qfa8eJEfvoqKfcyTqVSR
         Esx5cYRNjvXfHs+K/SpucKDU6s6RmVPvAUk7p1Djgmoilq5O9twz1zgILfhLwxjYbwGq
         n0SwqPzBrSzfm7RADBjieuBjG157+0VTYOED7w5T9bYYXZDTcTC6AvcHuFEFsTe/zwxh
         zTQlYfO4yNmelkqIwHyeNl/rtsmVwjn75P04O1kSnFu6rcPF0kiD8fU/klZg6Opaj9Dp
         N/nABkkc/HYyJN9toHI64XFAtKJuF2ZfBYysx36efsDeSzkLa/NpBKc4oiEzSIs/TDe5
         uKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730332209; x=1730937009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xITKeeCQTPMHTwhjLrB4rhB00Y72QJELP5T2ItEbVI=;
        b=oPmquyqPOEns5YLvExWLsmP3lZhcK1ZB6irwMk+I/VGSAC5UNWPDBKGjwFlJtjkEiT
         4eODggZnS2dJqwEO6FsB1YgO0KY7Ofi5elDCIQ0mRujjEjlBRKdlK16bZerEcj2BH9mx
         myYPc1OINnQgTLNjmuANk6CWRMjvgvzgzcO9XOkMin+QUshh0cOvUL5LoMkv/SHZk4Ae
         wQUVfguj/BRFRFzoiZL2NTvclDglYZtKStnTykuVQ7fr6xGfUGwywm08GlLBtQjkn3FM
         /dmaLXniXe4vHtimUec9IHQCvIysk8VTG4uwdXuzmgANACJ44ZYPinJ7/7C0IWiaWm15
         mYtA==
X-Forwarded-Encrypted: i=1; AJvYcCUGiuXDwBgLkDr0asYxLVyk/uECqgXhKl/GQ+R3JYk4ZkHKr63oeBycgSXNpqAqg4hgHM5+BQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxC44i7gQINfjDaPNCgtDZ71M0KkEsQ6gHurNLBHT/d2gatsKBc
	RzoO3mWSR7h3cVF86j8lbfqhLBab+iyc0KGUYkkMR+H4QtZVJsvxqXifdAcojBkhLBGal0cpY7D
	K0fsCnrDl7Ql1/+Op83RENtbleJY=
X-Google-Smtp-Source: AGHT+IEGZomZ5kJjb+R1NLfXagX6H4tJArwRpGGFHsIJUp3TX6AYCJgn71SzvrzS+RXVFHlSMLywNa+CNyNDqhllWuo=
X-Received: by 2002:a05:6a20:c854:b0:1d9:c615:944f with SMTP id
 adf61e73a8af0-1d9c615a145mr12413848637.11.1730332209274; Wed, 30 Oct 2024
 16:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1730136799.git.robin.murphy@arm.com> <ZyIClriScBy4s6LX@8bytes.org>
 <515D7932-3939-4C3E-BA3E-CC3152E64749@goldelico.com> <ZyIos2Gm1nf5rejI@8bytes.org>
 <ZyI0baBMPHVZ29-k@tp440p.steeds.sam>
In-Reply-To: <ZyI0baBMPHVZ29-k@tp440p.steeds.sam>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 30 Oct 2024 18:49:58 -0500
Message-ID: <CAHCN7x+M1tfmJYhp0+qovhedMiMG=fdyaf-CnPz_hUi7abuDCQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix omap-iommu bitrot
To: Sicelo <absicsz@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, 
	Robin Murphy <robin.murphy@arm.com>, will@kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, mchehab@kernel.org, 
	andersson@kernel.org, mathieu.poirier@linaro.org, 
	Beleswar Padhi <b-padhi@ti.com>, Andreas Kemnade <andreas@kemnade.info>, iommu@lists.linux.dev, 
	arm-soc <linux-arm-kernel@lists.infradead.org>, 
	Linux-OMAP <linux-omap@vger.kernel.org>, linux-media@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:28=E2=80=AFAM Sicelo <absicsz@gmail.com> wrote:
>
> Hi
>
> On Wed, Oct 30, 2024 at 01:38:11PM +0100, Joerg Roedel wrote:
> > On Wed, Oct 30, 2024 at 12:20:31PM +0100, H. Nikolaus Schaller wrote:
> > > Why that? There was a discussion and everyone agreed to remove omap2,
> > > but not omap3 and later.
> >
> > I raised this question to make sure the things we maintain are still
> > relevant. Developer and maintainers time is limited and we should not
> > spend it on stuff that nobody uses.
> >
> > > There are some devices besides the PandaBoard. I am aware of these wh=
ere
> > > this is relevant: Epson BT200, Samsung Galaxy Tab 2, Pyra Handheld
> > > (in production) and we are currently thinking about producing a tiny =
series
> > > of the DM3730 based GTA04A5 with spare parts.
> > >
> > > And of course we want to participate from the latest and greatest ups=
tream changes.
> >
> > Okay, if there are still real users for latest mainline kernels on this
> > hardware, then the effort is justified.
> >
> > Regards,
> >
> >       Joerg
>
> There is also the Nokia N900 phone (OMAP3) still seeing mainline
> activity, as well as the Motorola Droid 4 (OMAP4), to name a few. I will
> also be testing on the N900 around the weekend.

The Beacon Embedded / LogicPD Torpedo and SOM-LV families (OMA35 and
DM37) are still being sold and I still run various tests on them
periodically. There is also an AM3517 that I still periodically test.

Once Micron kills off the RAM and they run out of supply and Beacon
cannot sell them anymore, I'll submit a patch to remove the
unsupported / EOL boards.

>
> Thanks to everyone for the amazing work.

Thank you for all this.  I haven't been as active lately, but I have
been following this.

adam
>
> Sincerely
> Sicelo
>
