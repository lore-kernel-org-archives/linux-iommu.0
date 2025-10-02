Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCB5148830
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433381; cv=none; b=fq1MCEu3iKjiWkgi0KQ+W7VUBUmFcMGynrY8cd15I2NaUlH3iwvCfPVx8Y+h27t+XK5LUAqNI4AEg1sXYiBciTcACN3dDph3aXU5c9NKEDI5u1JcAlCtt1hvFBfLDXHaTH51MJeqj7PpJOYaZrT+Z462aUN41vbVED31Xk7yPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433381; c=relaxed/simple;
	bh=L2u7PhG2hVg+yWSLzj+SP8+91k9j/TQra4RUm538Nhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiE91XoM7ZTlpdtikfu+8SjGpQwmeytEnfBd2IjrgQgG3ioOvqE1b+lGcRM3Om0WikTOHmmsCB5BD+S1ufVTMehYlc1GWjBi1jWKx//kT3z3fK6jSzIA33nlSE5wrWKTFGkA46LvedVDpFZNAZIuJBFUKHUOQ2aNUJQHVGUooOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d5jh/NIE; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5jh/NIE"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4e576fef9c6so39331cf.0
        for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 12:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759433379; x=1760038179; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2u7PhG2hVg+yWSLzj+SP8+91k9j/TQra4RUm538Nhw=;
        b=d5jh/NIEEcNOhDTRBvGfmBvAjmWg4N81L4Hqs/Q8p9e3zWvgi8dRaap7PIl20G2ptc
         ViSQNDVeSGkW3TGDkto9a6JilPs2m8OCW525DZy3r/jFtvPnqUoE+n17RXAs+p9XTHcO
         0WFauaQuPi55NQt/bhZqlM64m7sEwITvpKIRUJY/tFzBXtFuYvGXmCUzq73Ux6vxHSto
         cJN8455Qa1Xj/0fBTj77661ffemrkpBjokzYi48kDr4NUUNiOp8iWFrLSZDSrBVCIXKP
         cRgKw0eeqV139YYXhV8cSfqlUmH7jJaV/EkvlBAZg28PriR9wQbxuecS7UhyOqsi259J
         8w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759433379; x=1760038179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2u7PhG2hVg+yWSLzj+SP8+91k9j/TQra4RUm538Nhw=;
        b=A2uRDPDZrIxKalLuL5Cj9q5b+e1qxZYnW3lUuUoymJQNKEVA1lcOODrwouwIUrTcTR
         30tW+6ESPQLRD1n5uXkHnA8y3PSySOjiEsIPxxX2VYscL8S6SdgG3Hg8QH2N0+Ue7D/E
         nyQ5TUMG7N/xaN8Av9vmEdtsuc9+X3WLY2ZgLamZ/Qxv2jeEBfXE9AB2ObNlvNwPkUNL
         aQ7N/yKE3BoXRDp4INxdXDwlWqBX/Y5YE8RTFZGnj6RvCsYsclIIbSbKBabhPVyt14by
         oxgTKsrDIfPBSyuYuayQGDvJ8ZzJANIHpg2MyU/WFZV63njSmNfTYgGDaVpTOrua6b7k
         mFiw==
X-Forwarded-Encrypted: i=1; AJvYcCXtmKfvHa59E6oS0v2z+pNqiV6+kRuQION78ypc/DhQhZol8o4GP8HYFsy77LsqCDd3JHgB8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiFWcWrG5m+mIgIVtb76bMI79LmFGUf0FDzIFySzBN2z2ZzF2a
	2U2ewMRDnJedsBSdyWVDKTX/7RC8xHYafupJ/05FIMrKcL6X/e28LB/J1Bsl0LZEazvywwQLKvx
	YagRpKPgWzO7iTwX4LdJwtH7FeNpM8FYqxEB/sEOY
X-Gm-Gg: ASbGncuxfWt3BvKBPzy89NuFrsmbyKDgZi9qzqYJftH/8PNYDbFxIxzRgO5c1bNg1br
	cNBAbfHfjQ7W8IhhZO8ejAby0JUG1oMCA/RuVwrFMw+aSE3pGzUcn7jtLsnCmq/6A13JQppQlma
	zhQcEm8AEZhSczYl1P5zQXM3qQMKYIKmTOsr9oPVpiP8PdO1Zna8Uf9PmiYork6swpzs4nNeOUT
	ySy/uRa2+jVYFpEs5th64vPGPNY7uy18eNTl2Y4knrN45MJSM8847LvVIVpZrROmkV5954=
X-Google-Smtp-Source: AGHT+IG1VtoYtqefc+SKzvRAMV/hvnzBHVa3U0eqUwJo+ikfv5tW8uurQLIa4ePuZX9TNIvh3Ut/XEDLHo5Y7YPwcVU=
X-Received: by 2002:a05:622a:2b06:b0:4b3:7533:c1dd with SMTP id
 d75a77b69052e-4e576b9436emr898881cf.1.1759433378465; Thu, 02 Oct 2025
 12:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca> <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca> <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
 <20251002151012.GF3195829@ziepe.ca>
In-Reply-To: <20251002151012.GF3195829@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 2 Oct 2025 12:29:25 -0700
X-Gm-Features: AS18NWCLvUocYb1YrfwQdo0SU6N_bDWtnj2kplIrYTjYsks3r_IoDR6SzwlPV88
Message-ID: <CAAywjhQGQx2_2X8r0rf3AgMDbJj-9C=9_1a3xgiLwuzKLAvXCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 8:10=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, Oct 02, 2025 at 10:43:45AM -0400, Pasha Tatashin wrote:
> > > Finish on resume shouldn't indicate anything specific beyond the luo
> > > should be empty and everything should have been restored. It isn't
> > > like finish on pre-kexec.
> > >
> > > Userspace decides how it sequences things and what steps it takes
> > > before ending blackout and resuming the VM.
> >
> > This is a fair statement: userspace knows when vCPUs are resumed and
> > can decide when to do the HWPT swap. Following that logic, what if we
> > provide a specific ioctl() to perform the swap?
>
> Yeah, that is what I've been talking about. The ioctl already exists
> in iommufd..

Yes, I agree. We can use the existing ioctl and the hotswap happens
when userspace attaches the new HWPT to the device. That has been my
understanding as well.

Userspace should indeed have full autonomy to perform the hotswap
whenever the VMM (and HWPT) is ready.
>
> > What do we do if the user reclaimed iommufd but did not swap HWPT or
> > did not perform some other ioctl() before finish(), simply print a
> > kernel warnings and let it be, or force swapping during finish before
> > going into normal mode?
>
> The problem we haven't discussed how to solve is the linkage between
> the iommu_domain and the memfd.
>
> Since the preserved iommu_domain is referring to memory owned by the
> memfd and the pins don't get restored until the iommufd starts and
> generates new pins. Thus we need to keep the memfd in a frozen state.

Yes, there are dependencies between preserved FDs, and we need to
consider them during LUO PREPARE (preservation). We can use an LUO
helper in the can_preserve callback to check if a dependency is also
going to be preserved. I discuss the restore part below.
>
> Maybe that is the real use case for finish - things like memfd remain
> frozen until finish concludes.

Yes, for memfd LUO file_handler, maybe that is the purpose of FINISH.

But that gets us into the discussion of whether a dependency is
ready/allowed to mutate and FINISH. How would LUO file_handler of a
dependency know that it is safe to mutate/finish? Maybe LUO calls the
iommufd FINISH first and if it fails the dependencies don't get a
FINISH call.

I had a quick discussion with Pasha to see how LUO can help with FD
dependencies and FINISH order. Perhaps we need a new LUO API that
iommufd can call before live update, explicitly telling LUO that it
depends on an FD that is going to be preserved.

>
> However, keeping with the keep it simple theme, finish can just not
> succeed if there are stray objects that userspace has not cleaned up
> floating around. Eg a simple refcount and iommu_domain decrs it when
> it is destroyed.
>
> Jason
