Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2995913B791
	for <iommu@lists.linux.dev>; Tue, 27 Feb 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041186; cv=none; b=owQwn/V8b5yqZFtRsfkiaXOExfO9CZQrS5rNThNvrlppCxHOnu07jvGvocJAu4EtceN1B1KHXJGXlqcApRh+tOOD2IIHENLksPOnkuMFf+npfyjXnR343nkMvy72VPjAwZETSZ6eFWRvt7+AoJh4nw0BfRmGvx0j4G43NIr4ojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041186; c=relaxed/simple;
	bh=8iPufcibBCJKG0q1/qGL+A/Ni1lovHs1ZR0Ajl86BBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7LLe05tdZmfIBkAjCn/p3wvJIZJIaX3eqnb39Ej6wu43nEKqPXAVAxUSNnWZCPAHNGzwHmzaAAgdV/Z3nfekgdKVJl3As1+FiiWVIXg7KMG1LAZcLEWEX/+m3nAzgCdzU/giKhT45V4ytOD4Jsnx3rhNlbc9a3Yzx6J506pW4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JZ84TmBj; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JZ84TmBj"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-db3a09e96daso3259483276.3
        for <iommu@lists.linux.dev>; Tue, 27 Feb 2024 05:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709041184; x=1709645984; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOWeidPv0GTdG2qvAOJJXPCS/uUkxL4qtXAn43lMC7g=;
        b=JZ84TmBjWppi0H5dpueGacNYsqqPoGPjTQFjWHugmVRcJ8WMQCJgjyGCkHezzsT02f
         3jFyC6y/ozpH7w0bLFNUYpXxTOfIsSCowWZP58KXz1Su+cHMRlLXga55/aqAJXQDlDio
         mo5PA73ECCV4XiJrGePpwpLlvHQFkmk/BY3GvqHLjV/hqxF925+htxM6Z9BrqBYHm+Ey
         lC8dxd/dS4ExkNk3E+Jj3yZOItUVUQaYTyn2wTZF4HiunKc/JnvgwLq94RN7wh45x8Wj
         KPXVyzasOCtRcd8CS1Qg5KyvE5cn1Zp1A32IhZtL6y23CPRFLZAHeuHJdPbAxCvnyr7+
         gzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709041184; x=1709645984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOWeidPv0GTdG2qvAOJJXPCS/uUkxL4qtXAn43lMC7g=;
        b=VdHZ+qd0Xl2bUzAunqjZpJlWJVQSr6pLCR/mD740UEUqWkfBrHS74gFH5A8sk/p24j
         lrLuXIcPFPetMxTRlGZATS+vji3wzch41BxLrELiO/rygbCdMCn5NtY047EjhU+3eKex
         uoGdk4Ttk0zf5Eut+iTKU7LCgMgxxE/7ghjkLOZG86bZcqjoO6K1V53rmr9shBJAb0H2
         g74PEawnMZCk+4je+XLLCL+btym8kuO66Ga53BcodnFHqHv+2aPaAcTKYJnPSNCOveb+
         hKOq83krJ6idmxTlAF64nLf2ehMWslDbE8MvzFIXizR9ggw0iJRcFDkgxzlEQdh5IBfF
         /nZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW951l3lgwQEmtK8WHRU6J7dcEv4D1jbqPP1lejKCQ8hLEhFtSDyf+Kj85MWEdFs5a5Fs6cr/5fIF2wGn2MSsheMpvjSBA=
X-Gm-Message-State: AOJu0YxFDAVX5Br3zWt+SqLE0JSFy1cOUyhM1kFCfqY8S4gcWBQDIc+O
	PhXfaZDaZh8JBNEjBJfqYG1kIB2P83CN0TTGcMWK+kuTX4e38XFk/2NH887D11yIeXcT12LZoNA
	u24ZTu+AcEs7GZyL01zNwSeRlhYvdo82hH6wz
X-Google-Smtp-Source: AGHT+IFK/VVwUhiGT2OlyOZOTeeMQ2mEbLEw6tyIu3zG0QccGmUrTQRKql4uWibkgraBEtRrXBYGwjqLNKKTY1ZiYWM=
X-Received: by 2002:a25:d8d3:0:b0:dbf:23cd:c05c with SMTP id
 p202-20020a25d8d3000000b00dbf23cdc05cmr2126143ybg.13.1709041183917; Tue, 27
 Feb 2024 05:39:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240208152808.3712149-1-howardyen@google.com>
 <20240213055426.GA22451@lst.de> <CAJDAHvZGnzKPLaovRcq_Os1Fcixp2o1kY9GFV8VXztrmKahejQ@mail.gmail.com>
 <20240220055241.GA7554@lst.de> <CAJDAHvbOnAvW5f6oJUnuy2_5-vS7uJc13GQSNX_Nc25GJXSp-Q@mail.gmail.com>
 <20240223063723.GB11004@lst.de>
In-Reply-To: <20240223063723.GB11004@lst.de>
From: Howard Yen <howardyen@google.com>
Date: Tue, 27 Feb 2024 21:39:07 +0800
Message-ID: <CAJDAHvZ4-mh8uMyq0NiPgWKGt=pS3teoJ0=ofCKZmLeqLXUVgA@mail.gmail.com>
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems per dev
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org, 
	andriy.shevchenko@linux.intel.com, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:37=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Feb 21, 2024 at 05:27:58PM +0800, Howard Yen wrote:
> > The reason why I tried to propose this patch is that in the system I'm
> > working on, where the driver utilizes the coherent reserved memory in
> > the subsystem for DMA, which has limited memory space as its primary
> > usage. During the execution of the driver, there is a possibility of
> > encountering memory depletion scenarios with the primary one.
> >
> > To address this issue, I tried to create a patch that enables the
> > coherent reserved memory driver to support multiple coherent reserved
> > memory regions per device. This modification aims to provide the
> > driver with the ability to search for memory from a secondary region
> > if the primary memory is exhausted, and so on.
>
> This all seems pretty vague.  Can you point to your driver submission
> and explain why it can't just use a larger region instead of multiple
> smaller ones?
>

The reason why it needs multiple regions is that in my system there is
an always-on subsystem which includes a small size memory, and several
functions need to run and occupy the memory from the small memory if
they need to run on the always-on subsystem. These functions must
allocate the memory from the small memory region, so that they can get
benefit from the always-on subsystem. So the small memory is split for
multiple functions which are satisfied with their generic use cases.
But in specific use cases, they required more memory than their
pre-allocated memory region, so I tried to propose this patch to give
it the ability to get the memory from another larger memory to solve
the issue.

I'll upload the next version to show the modification in the driver.

---
Best Regards,

Howard
