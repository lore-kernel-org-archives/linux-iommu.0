Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5BA1DFD8C
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508589; cv=none; b=XPuKNcvqN/KRwaLZjbGwGNlhqjrBFAmJ+CEh/0IFoWpFzte6lOj40K7b3wjORs1O9HCXDNkz8b9IEVb5VIN41hOsdQZpMir58BYoj4Dbyz+6A4NvRz5xi+ySMfAntiGQI1622Ai4PjJJNC6cH1FidFz/fbW4QNogaMZHmIy6fxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508589; c=relaxed/simple;
	bh=XwRDW7jTJnaLywO/huBDE03/EPCXyw05QNbK9s3IMWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frbiixpvFQU/izJA5YCyF0oD7nAzWOSOHLyN8gy34po1uefoXfvKXmzYlMK6R/YYSJPpjku+nBeKKSyF7N9EI1j4TVuGIRjoGy7gjhfUvAWdBFtcDJlIq48aEstAcyzj0IW3unHIyJA1dGQdzkpUgBY56goAM5ZX66vvErgbaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TECWaBjL; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TECWaBjL"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb51f39394so61634821fa.2
        for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 06:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731508586; x=1732113386; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwRDW7jTJnaLywO/huBDE03/EPCXyw05QNbK9s3IMWo=;
        b=TECWaBjLNvMJLtxilU5ms7i7kF/0WZU1Qgy27KaIZdGazbEyC8YnevcsQucSwZInyA
         RPR/VuakrN5ylWpp1MM1wz6YhZpATdCMcDSK5lPRyhogDTqA34YrfrzhoWyCpKI4Ru7w
         fyiwdU7W7aHnfpqmSDp01KDO5SMD0g8s7H0MF3VpJ+vusRE9oW/XezANLYEdUD0bHykD
         BbZZhdJ/BHdpNjIbSRr3x+TTCsJAsiV803t93vRtMow+8WM/nrM3hLjleRuPlIkOYVEm
         b7L4ltgrGuoJxXlXiUEyqic4JyivytS9rF+4iRUhQ8QhnXHKyKPq9sg3TWwqZQDVWtRN
         I42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731508586; x=1732113386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwRDW7jTJnaLywO/huBDE03/EPCXyw05QNbK9s3IMWo=;
        b=rxmSgBpYhs7+Hlzw/Y26cqoO5N8rXw8wZDTkx1buB7vsV0+WmLDXPljeslZK2rF/MZ
         CWUmfr02QRDASmMXEicw3SchJH8UP0MxlD0LbviR4xui0GX7ZzfxaYU6GQ6cXd/lXqkA
         bFzzn/2K9ociudJyDodFgRvay8OXtwsh490qqTDIysEkLkP7GizJ76LgDkDNZLF2qP2J
         dB41aQH6gZ/wRjnpK32QOSwFXQaNK40K2UTz3ibrIs5KnXaav+Lwf73B+poIWXgYBQMm
         u+jvS+9BUr23zNw+5acqBMI9ysgPTXFP70jAi7uhHyEL2v+BIzl2jhrIPXosrjrrYDdO
         KhJA==
X-Forwarded-Encrypted: i=1; AJvYcCWAvInTSg4936Xfqf90GhMOROdd7jKTs0m9vrIhBFOM4L9cpmwql2NNfx3uhEawahtYdbV/Ag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1CJTuUpSg/lFnoCBgmqI4iV99IwHF9zH1JcaOgsyt0QDlXDeM
	03QI4zduf27X87goW2gmX3G/dzrSV4ddAVU37PmW5LUodPFk2Yh3Fv0C7r7HVhWpEYBD/oCTI4y
	OGe3beSQOehS7/Yp+Ef8LF5oppVM=
X-Google-Smtp-Source: AGHT+IHL0uCSsyj7twvRVICsE2iNascjnWtDXWCLjSArZnwdWGQaJDvqGaAMHyNX1vtCfrj7Q5embfR9Vbkeb/9DEfI=
X-Received: by 2002:a05:651c:160c:b0:2fa:d25e:39e4 with SMTP id
 38308e7fff4ca-2ff20309255mr114185031fa.36.1731508585585; Wed, 13 Nov 2024
 06:36:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
 <20241113120327.5239-6-suravee.suthikulpanit@amd.com> <cac1ccd3-4b81-4374-a49d-9afad755b19c@app.fastmail.com>
 <20241113132031.GF35230@nvidia.com> <CAFULd4a1PHREX6ws9Gyu=TaaZvdgLfh6peoE5Tt010uGyY9Hgw@mail.gmail.com>
 <20241113140914.GI35230@nvidia.com> <CAFULd4aGDM5ySO-PeOH0+_U89mnqYqQ7v+U0ZsMode3bxs_X7w@mail.gmail.com>
 <20241113142807.GJ35230@nvidia.com>
In-Reply-To: <20241113142807.GJ35230@nvidia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 13 Nov 2024 15:36:14 +0100
Message-ID: <CAFULd4aFvGj=kz5Si9WpAr33KFtJDO5+sdNO=NBB+boS=E-E_Q@mail.gmail.com>
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

On Wed, Nov 13, 2024 at 3:28=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Nov 13, 2024 at 03:14:09PM +0100, Uros Bizjak wrote:
> > > > Even without atomicity guarantee, __READ_ONCE() still prevents the
> > > > compiler from performing unwanted optimizations (please see the fir=
st
> > > > comment in include/asm-generic/rwonce.h) and unwanted reordering of
> > > > reads and writes when this function is inlined. This macro does cas=
t
> > > > the read to volatile, but IMO it is much more readable to use
> > > > __READ_ONCE() than volatile qualifier.
> > >
> > > Yes it does, but please explain to me what "unwanted reordering" is
> > > allowed here?
> >
> > It is a static function that will be inlined by the compiler
> > somewhere, so "unwanted reordering" depends on where it will be
> > inlined. *IF* it will be called from safe code, then this limitation
> > for the compiler can be lifted.
>
> As long as the values are read within the spinlock the order does not
> matter. READ_ONCE() is not required to contain reads within spinlocks.

Indeed. But then why complicate things with cmpxchg, when we have
exclusive access to the shared memory? No other thread can access the
data, protected by spinlock; it won't change between invocations of
cmpxchg in the loop, and atomic access via cmpxchg is not needed.

Uros.
