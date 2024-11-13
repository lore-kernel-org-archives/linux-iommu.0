Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B181F1301
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507264; cv=none; b=eb8jsQPmpgH2LoFNqQ5DF/ZrS79x8srx7ehESciRsJaGu/Zi+GMxeqk+gmQ/9uKe8RXfUIdNokGandI+MjkVKiPcgrPTlxs5FYMvzdlRlXZ9PpH5FDUd3dQsK/sDRm2DX8zc59R6Io9IPXlvna/GNNsqB4VPek3bMQtidu8lLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507264; c=relaxed/simple;
	bh=7g2Ed0PYp+K0iYwFBDYBR4GjiywhMaNDISFPqQ44g+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MifOu5J454tjwF+xlBFf1nzRx9Zb/bkZZE/kqgJGpTVHQ4ArvpKXGXs/bXiccTLHixU2tDhW2BO03ByI9VV+lYl+NfQx3R2ywci92VZL0Z97EEcIq5iGf+ZS7klVcW4iS7WNQST+XK8/Aw+vA/fm6d0Gj9aAy74QC0dj0WM80lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdvxuPdU; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdvxuPdU"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ff3232ee75so36911511fa.0
        for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 06:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731507261; x=1732112061; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTw8XVVZqvuIy+eG9N2qUdD1lL/ZI+OWgwR1mXqgbFc=;
        b=jdvxuPdU3MkSSjdCdRy9qGPnzmzDInMvtZcwJOMAR6zKBrlAFj59MDL5zEFaov8fCJ
         9GxtiXhwVebUlN0IQL0TqTVzoetWXeA4kA4psV5Poup0icONMj4IV4O7Dvokth2tNJmp
         zzo4YufnKCehcpYxVBJWdJo2PBCWjWeMf8q/zacLzrDnTVhYwYSOyL4MJaVxhMW5DYI8
         rbIDBTRyYqZP5eoLBuYW3Cn9rXo603CSwEZGCNr34tpZDhKH23Zq2bi++q3ke4g4PygI
         pg47zb8263MHi+7gkk70+K8a3xeSX9oBW2gqUwC6OLG6iTO2QoWlZd+qqIu1EANX9laf
         bFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731507261; x=1732112061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTw8XVVZqvuIy+eG9N2qUdD1lL/ZI+OWgwR1mXqgbFc=;
        b=gY8cewSrGMHy1LNUyXMoTkqbfCXaVFyLtfszsPcTC5v0OpljXOtoFVSr3b6HW4VWWU
         hXoCeCDZSxwJbNHmSi4bSAUoQ6DYUeJmz3dWh6fW/jQwMcKs+Bp9qp0WhGpY82BnE9TX
         9fwGSH4HGvdf9UbnYDeV0nY+f9BpxALx9Aox/7108yMDk6HfKhZIyJnwtOQ0NvlK1Xh4
         LVOE9T4tXR5cb3xEg42hqsoxp0MvuOy52tB9SN010vGdkm1dkRyPTXXElGwmbP8BQJki
         e4ZjWdnp7xqyeUuG3NPltAMO5Lf1MDOtTfVSsPHDUJXKa9kBUUHbXpFFWcZ2SbpuKQGd
         olPA==
X-Forwarded-Encrypted: i=1; AJvYcCVw4DKU6cN6ZJJM9HERhKsUyi0AvZjfwnvGldwIze9X0FMv9j0O7Z/2bqPJ8O1xl11mXscwOA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1Vs9Mbs4DKSYhRtDfAu5fGTQj1acwNLmnb4P46M5O1YyAFtho
	AMVqQbxgwesxnuDmImAe8wo5q7BISu5wVCoR7bE3eQfM7VrKXDa0EoVks03OCT9ZqsO672b7Vi8
	MgOff2njHK67OX8C4LDjhZzWXy1M=
X-Google-Smtp-Source: AGHT+IFDKxAOYm3EOXefvysmb5JnL355O1Aw5kCi8XExQERUSlxwkKMaf5nbPuUd7LqEnd4KJ0hhtkDjm62cdd+AbBY=
X-Received: by 2002:a05:651c:1989:b0:2fa:bf53:1dad with SMTP id
 38308e7fff4ca-2ff20271906mr111102251fa.31.1731507261106; Wed, 13 Nov 2024
 06:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
 <20241113120327.5239-6-suravee.suthikulpanit@amd.com> <cac1ccd3-4b81-4374-a49d-9afad755b19c@app.fastmail.com>
 <20241113132031.GF35230@nvidia.com> <CAFULd4a1PHREX6ws9Gyu=TaaZvdgLfh6peoE5Tt010uGyY9Hgw@mail.gmail.com>
 <20241113140914.GI35230@nvidia.com>
In-Reply-To: <20241113140914.GI35230@nvidia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 13 Nov 2024 15:14:09 +0100
Message-ID: <CAFULd4aGDM5ySO-PeOH0+_U89mnqYqQ7v+U0ZsMode3bxs_X7w@mail.gmail.com>
Subject: Re: [PATCH v10 05/10] iommu/amd: Introduce helper function to update
 256-bit DTE
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, vasant.hegde@amd.com, 
	Linux-Arch <linux-arch@vger.kernel.org>, Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com, 
	santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 3:09=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Nov 13, 2024 at 03:06:05PM +0100, Uros Bizjak wrote:
> > On Wed, Nov 13, 2024 at 2:20=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
> > >
> > > On Wed, Nov 13, 2024 at 01:50:14PM +0100, Arnd Bergmann wrote:
> > > > On Wed, Nov 13, 2024, at 13:03, Suravee Suthikulpanit wrote:
> > > > >
> > > > > +static void write_dte_upper128(struct dev_table_entry *ptr, stru=
ct
> > > > > dev_table_entry *new)
> > > > > +{
> > > > > +   struct dev_table_entry old =3D {};
> > > > > +
> > > > > +   old.data128[1] =3D __READ_ONCE(ptr->data128[1]);
> > > >
> > > > The __READ_ONCE() in place of READ_ONCE() does make this a
> > > > lot simpler. After seeing how it is used though, I wonder if
> > > > this should just be an open-coded volatile pointer access
> > > > to avoid complicating __unqual_scalar_typeof() further.
> > >
> > > I've been skeptical we even need the READ_ONCE. This is all under a
> > > lock, what is READ_ONCE even protecting against? It is safe to double
> > > read.
> >
> > Even without atomicity guarantee, __READ_ONCE() still prevents the
> > compiler from performing unwanted optimizations (please see the first
> > comment in include/asm-generic/rwonce.h) and unwanted reordering of
> > reads and writes when this function is inlined. This macro does cast
> > the read to volatile, but IMO it is much more readable to use
> > __READ_ONCE() than volatile qualifier.
>
> Yes it does, but please explain to me what "unwanted reordering" is
> allowed here?

It is a static function that will be inlined by the compiler
somewhere, so "unwanted reordering" depends on where it will be
inlined. *IF* it will be called from safe code, then this limitation
for the compiler can be lifted.

Uros.
