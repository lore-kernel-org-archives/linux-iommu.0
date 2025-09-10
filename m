Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9225340DA3
	for <iommu@lists.linux.dev>; Wed, 10 Sep 2025 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537101; cv=none; b=pcUbP+wlNI+IWtoLBBREq4w6oiJvMTpBajH60K6enLUQGz1JYO+QvAz+xdEoIB7UNfAApscy2/+sou6pjHXxpufbLWYq4I8y2oQR5GcyS2h42ekjnLR1hChXXZA2R8EBMAX8RSw91bQ6Hc8pq50lHDsT/9z5zJfwTWvERFTZEcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537101; c=relaxed/simple;
	bh=zdj+uOiXuiIXzM1Vn3fcDOOxGOrxrCVtY7jUVpK65ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MeNME6KZIKtwIm+eoDOcz9QOE37oTOmmnTbOpo8OXjSuFRe6FdS1AoaOH/9WrSEYkX7NScIa4Nkoku8stEKy73FCdIUdM33NkYFEBIuBzbvgq/SKoRYN1qKlDjkq/k5ylza6e9QNmP3MXr2DJHeWrK5JYyVZfOHuv4xyqWIqHTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yPs5K8yN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yPs5K8yN"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dd9d72f61so26695e9.0
        for <iommu@lists.linux.dev>; Wed, 10 Sep 2025 13:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757537098; x=1758141898; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdj+uOiXuiIXzM1Vn3fcDOOxGOrxrCVtY7jUVpK65ZI=;
        b=yPs5K8yNvY+baGKGRbVUt4rYCkMCM/Z0D+j9av+6Jm6XLmBC3V6f0Ov8Yq76MIOFRx
         DA+CfuN4BjseA8n/oDySVHW/qKes1jbVFjVpnJrbhZeo38Z1rIB9fchgjvYeaTDbdOnY
         dkwQYaZAgir9qwhGRTIFIsU0JRG2+UX2M7Mi0quAJ4slHEaS7MmNPicaRjJFSJLazGFc
         56McfiTUF8AdF4rljBOKcmdbAOl+k/8deYOLr02LvCZk35ZuMR/dDY2f0gm4MnFXFUpw
         fxfz/OowLrucZdm4EadqoLNwIexB37eAYUaCUpJfUxSN936HuM1qOdrP8Y9RicntGiWR
         1pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537098; x=1758141898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdj+uOiXuiIXzM1Vn3fcDOOxGOrxrCVtY7jUVpK65ZI=;
        b=NhG0SVnLHiTl6mTErT4jHCromHzU/Vp5TZypQf8p6FnRuHn8F6oXfL0mR781PPGeVD
         LQlJg4uXAnJVsufRYXwDYXEzP55YZ8URLl/QXvPyAPxuxRS8MLoHUateYr++LvYK6Ci1
         dSXVVxFfFtzSjvlIwQsJMi7ZZPWXEEzGLsVEOxftq2s8MH8g0K/GAfbBKsxXRisigThI
         Ng0D4DU7pNToTAv0D60xlg2nGDupoYkEQzbBm6hb0/eCdjX7WbrmdSfJxPHlfkU5psMX
         qzwsAJrMB/fJzjqQ7WVYh7JrYkwqWLOcU4tmLKtuffwvna6j8Jomx3dvJ6N/MVg0x5j1
         baWw==
X-Forwarded-Encrypted: i=1; AJvYcCUFGfaBos6F8jLK90DKL5EA2ntdJb+n82yqBFSJB7nrzzUcxWjSjapHNh0eSKgmT8VLkizqDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxT41/TN8cPrd7gd3A9EGNCKhXA0IQVxoBIZNWQusBiefIdjyRO
	Jqzll7fo9LWu0Ec/f/yBLte5o4ZiW6JM9EWH0jAduZKRE7pTXxxI2TyZHdJiGLUXKsH1RHYO+0w
	+OaqdRFsHlAoOA1WzDMfg3i9BflLfXfdsC/n5H5Ua
X-Gm-Gg: ASbGncticiSu/xgVD/PJGwrJagphy3laAs0T/Ch5qA5dnA5u/BygDGvwZZwjXX3g8cx
	2QCUXf4YXQ8jUZL6GVf61eGNseEzTgbaXrJ+3JgU3IPJQKvVISu94ojKuhVFDjRvoRlVtKOOLNL
	MrCsl8du7UqUosMeWdN7WHzHVqan2D6YQKkx7Z1+dUy2SAKqwVa+fgagVEuVuVPLPCEp1XIKAX7
	GBXW0h7SsHpF4a8M6ydENLgJusTWja593Y9fnwRqPnZSt3tcIGnLMU=
X-Google-Smtp-Source: AGHT+IF/Fz2Y5nk02badGqITxY1/tzo4lRqGZ2Zao4nfkcXFZyjJgtYYuI6B/Fj3L639UAHyqOxbIJ21cF9JPLUpaI8=
X-Received: by 2002:a05:600c:1502:b0:45b:7d8f:4bd4 with SMTP id
 5b1f17b1804b1-45df74f81cemr1873365e9.4.1757537098041; Wed, 10 Sep 2025
 13:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721-dma-buf-ecc-heap-v7-0-031836e1a942@kernel.org>
 <20250826-vagabond-catfish-of-courtesy-cbfa76@houat> <20250910-vigorous-attractive-gorilla-af6fec@houat>
In-Reply-To: <20250910-vigorous-attractive-gorilla-af6fec@houat>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 10 Sep 2025 13:44:45 -0700
X-Gm-Features: AS18NWDgBu3edPeSCZERO8HncQFGrRuZvzuC8yXw-tqKPcuIWCidg2bFxSYLb0U
Message-ID: <CABdmKX29ftpNro+d=Ce6JGoMaG0UQeBbzL7DXiBkGkC0nwacTQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] dma-buf: heaps: Create a CMA heap for each CMA
 reserved region
To: Maxime Ripard <mripard@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Davis <afd@ti.com>, Jared Kangas <jkangas@redhat.com>, 
	Mattijs Korpershoek <mkorpershoek@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 12:33=E2=80=AFAM Maxime Ripard <mripard@kernel.org>=
 wrote:
>
> On Tue, Aug 26, 2025 at 09:36:03AM +0200, Maxime Ripard wrote:
> > Hi,
> >
> > On Mon, Jul 21, 2025 at 01:17:29PM +0200, Maxime Ripard wrote:
> > > Here's another attempt at supporting user-space allocations from a
> > > specific carved-out reserved memory region.
> > >
> > > The initial problem we were discussing was that I'm currently working=
 on
> > > a platform which has a memory layout with ECC enabled. However, enabl=
ing
> > > the ECC has a number of drawbacks on that platform: lower performance=
,
> > > increased memory usage, etc. So for things like framebuffers, the
> > > trade-off isn't great and thus there's a memory region with ECC disab=
led
> > > to allocate from for such use cases.
> > >
> > > After a suggestion from John, I chose to first start using heap
> > > allocations flags to allow for userspace to ask for a particular ECC
> > > setup. This is then backed by a new heap type that runs from reserved
> > > memory chunks flagged as such, and the existing DT properties to spec=
ify
> > > the ECC properties.
> > >
> > > After further discussion, it was considered that flags were not the
> > > right solution, and relying on the names of the heaps would be enough=
 to
> > > let userspace know the kind of buffer it deals with.
> > >
> > > Thus, even though the uAPI part of it had been dropped in this second
> > > version, we still needed a driver to create heaps out of carved-out m=
emory
> > > regions. In addition to the original usecase, a similar driver can be
> > > found in BSPs from most vendors, so I believe it would be a useful
> > > addition to the kernel.
> > >
> > > Some extra discussion with Rob Herring [1] came to the conclusion tha=
t
> > > some specific compatible for this is not great either, and as such an
> > > new driver probably isn't called for either.
> > >
> > > Some other discussions we had with John [2] also dropped some hints t=
hat
> > > multiple CMA heaps might be a good idea, and some vendors seem to do
> > > that too.
> > >
> > > So here's another attempt that doesn't affect the device tree at all =
and
> > > will just create a heap for every CMA reserved memory region.
> > >
> > > It also falls nicely into the current plan we have to support cgroups=
 in
> > > DRM/KMS and v4l2, which is an additional benefit.
> > >
> > > Let me know what you think,
> > > Maxime
> >
> > Any chance we can get this merged?
>
> Guys, can we move forward on this?
>
> Maxime

Hi Maxime,

Sorry I've been MIA the last couple of months.

The docs for the "reusable" property say, "device driver(s) owning the
region need to be able to reclaim it back", but how can a driver
reclaim memory backing a dmabuf, since pages allocated for a dmabuf
aren't necessarily movable. Couldn't a user allocate all of it, and
refuse to close those dmabufs?

I backported this to 6.6 and ran it on a Pixel. While there are
already similar out-of-tree dmabuf heap drivers that expose heaps for
these reserved regions, they do more than just cma_alloc (multiple
flavors of buffer securing, use case specific alignment and padding,
and slightly different allocation strategies) so I don't think this
series would allow us to completely drop the custom heap code, but
it's a nice start. Does the cgroup part come in because the plan is to
add charging in cma_heap.c?

Thanks,
T.J.
