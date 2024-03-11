Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD438DD8
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151886; cv=none; b=G+LrX7iS3d6vp+BgqhDNnX1+iDXwLt8WTxJk33ULGMVOie1DIWls0ozUpr5IdM+ytYatRsvYRja/wwPbFmm+VRVUAPt4gedWl70HFgaKjU+qkeLS+zeth8C/dBTfbOv/umtA83fsQX8GwNJZvfrizWzFtVC8iFePEJ8i00XW3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151886; c=relaxed/simple;
	bh=90wxFtc2yl7pC0/MOznw1zbBPujem0U2+kENHa16YIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0wYOlVdFrunvTddVwpvyEPITbQHeO39ucanEoXdIicu2ecKrJpqzbKEvTNIL3BGft32QwfwC+LmM50NQqgSaxHl1c4I+WSicA+z143f4JSpzaeGfg/CwIbsCthHF2jPO07E82wb1U9KeTkHSCqiMY3B0vRSj6P20V0ZsOYjyuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oSm+At52; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oSm+At52"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-609eb87a9e3so27679627b3.0
        for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 03:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710151884; x=1710756684; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OW00I9htwoAsj3xBJZrkbzrUKhGDr0/+mmT+snWwiXg=;
        b=oSm+At52cTnQnY11VzIk4aTbC36E2d+bpJJIzkrJfqN4VocnBUR5ox4MB9abfuyfgG
         jX8lTkrEPkRFjeKfIiqqfteu/GtKZ32UiM1ylWvLfe1bl8kqt30W6J9NP8qd5BSRS0hl
         0E0GIAbYor4lasCgBZprdy99mxDVriedeeFKRpOEx174O1pnsrJaHaNxbxujY2qVO4qw
         ITohBXzYSx9i9m7JgnN7Q79sAgKjk5+qoiFZBdaS7MJqiFp88eOppMDt34eMrbctht1T
         Sv3lSKPuZ/fqPFRxJtskAtNS1/seyKRRh/v+jrhbbc4CdNp/xg8R4SZTR1OOJL1gJRe2
         zIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710151884; x=1710756684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OW00I9htwoAsj3xBJZrkbzrUKhGDr0/+mmT+snWwiXg=;
        b=r4FqC1q0jGM6gp0qkrXPfCYZ7Uscznt7K1WDHjjXSEL8tG9Lf1jEjXUM4+Y2dibeN3
         QdKzgB3JbH7N6IwZ0KvYeRfOKYuxQAurf8I+77QC3i4JMlB06E3lAiuUQ9IW0FDk1F5u
         VSnmm9W6Zv+TW/L4HMt56nC9q3IFFj7cNVr8b5EoNHJwJldEywhHP3/0lvGfxSWzqdg0
         xHTRP/KWoE5h77zSXC6GfXGt7/Nlb5+knJDlqUAnQDs7y0GUoOUF3qzOfjbN3+NKyXhn
         GkTfaZ9kd4T9rZa0iB4tAj+pZ7FQSjl70kXIWOGw15N0d88bDoW5k/5H/+sUMwWw9Qxb
         LRrw==
X-Forwarded-Encrypted: i=1; AJvYcCUg/4oOXXwlN8YIm67CrH7AwwTeKvmfVOwzLIndY6mRMWt0ach/CAGpPwVvZCEq0kHywmOPiK02Suyhf8Rx6yztoTIkFCM=
X-Gm-Message-State: AOJu0Yw8Cg2cKxVQoQ1G/4dKRoBqGBtRa/oV7aDLky+jMCgxLUfnnekU
	Bx9/hVaA56e1IWTcPwZZVmk7Ac0oKPEQAj7aqUuByS4o42v7rUuMxe/Gj+EfW7DDd8f1TUq1234
	YNvJXzVtuXywQHQpOcRaW633YAMiK9gcNif0P
X-Google-Smtp-Source: AGHT+IHeMf2I6e7HKYzUshIicVdYM485nxp+wOAn6CZ5eXC/DS89xt9vl9QxYES8bm7T9Wf6yE9ct4Shlv7P6VhvUsU=
X-Received: by 2002:a25:28a:0:b0:dc6:ca3a:31da with SMTP id
 132-20020a25028a000000b00dc6ca3a31damr5135139ybc.16.1710151884041; Mon, 11
 Mar 2024 03:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240311094947.3738200-1-howardyen@google.com> <Ze7W3o67JLTKlLzR@smile.fi.intel.com>
In-Reply-To: <Ze7W3o67JLTKlLzR@smile.fi.intel.com>
From: Howard Yen <howardyen@google.com>
Date: Mon, 11 Mar 2024 18:10:47 +0800
Message-ID: <CAJDAHvbRSm_UYgx0fE7o2dJqcBfBbcFR4DrnVydkwfxGo0O4Rg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add support for multiple coherent memory regions
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mathias.nyman@intel.com, 
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	petr.tesarik.ext@huawei.com, broonie@kernel.org, james@equiv.tech, 
	james.clark@arm.com, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 6:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Mar 11, 2024 at 09:49:45AM +0000, Howard Yen wrote:
> > In the system I'm working on, there is an always-on subsystem which
> > includes a small size memory, and several functions need to run and
> > occupy the memory from the small memory if they need to run on the
> > always-on subsystem. These functions must allocate the memory from the
> > small memory region, so that they can get benefit from the always-on
> > subsystem. So the small memory is split for multiple functions which ar=
e
> > satisfied with their generic use cases. But in specific use cases, like
> > USB3 devices which support the stream trasnsfer or multiple devices
> > connect to the host, they required more memory than their pre-allocated
> > memory region. I tried to implement it in a generic way and propose thi=
s
> > patch to give it the ability to get the memory from the other larger
> > memory to solve the issue.
>
> > Changelog
> > --------------------------------------------
> > Changes in v5:
> > - Fix build break.
> > - Use of_property_count_u32_elems() instead of
> >   of_property_count_elems_of_size().
>
> Have you tried to use --histogram diff algo?

Yes, I used the below command to create the patch v5.
`git format-patch --cover-letter --histogram -v5 51b70ff55`

>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Best Regards,

Howard
