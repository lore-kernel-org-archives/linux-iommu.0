Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B0221B90B
	for <iommu@lists.linux.dev>; Mon, 31 Mar 2025 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453839; cv=none; b=fVIoU1Qi8gJEg619DJlKBMPrbII9k5q/M2xoN59NH7MXg4xpRr4clkQx3QKC7iPakUpsy/afEKTaIekqkAk4VVPrXK1p9KQIrruz5KVj6RYsmLjSK1xzx3RWNcooeToAH5FT1P+7vN6CHNFDlW1KGDysn4GtxdWCmvXceYZbcWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453839; c=relaxed/simple;
	bh=NhmnlMAAlfE+UJZ4bK8dEFy6Cahb9IglOuPC0RLUf2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6bafgWBoKqtPJFaNJRxaT2giGnEfQb/PX+w++RU5DjciQeHbLYBAuASYml/EZc2vpUDqPk7Es9ZUZ87flWkhUeBiDd6OgjMX1Dc/NI0n0VwHumzBACWuZPgr1ymk26bOB90Chem4qoOMb1VEbDsA5g8Bqbs+KFN2+ZeWROS3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rfu0dnrU; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rfu0dnrU"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abf3d64849dso750180866b.3
        for <iommu@lists.linux.dev>; Mon, 31 Mar 2025 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743453835; x=1744058635; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhmnlMAAlfE+UJZ4bK8dEFy6Cahb9IglOuPC0RLUf2U=;
        b=Rfu0dnrU8hDAIx6YznWBt8sefiYtazKgEzYIMQr2eUDjkBTo7kfBUPwFgx0wzJt2mN
         6yfJJ0HVzMF1MqQlZ2KNmJPO4ylId+ScZuQI73huL56YOmtAqnX1rsyVr3pnEpUcriks
         suSE4zD1e9EIyN9Ee34gMx68VnMyJH55MVvz7lCPJk2LZPBBtWohBCO35wuUIhgx3Ujx
         DusluJ7BE3Nh1gc+pFCktZ3EMoiadVDLTWlnlEda5I6no/MjtAR1XNf89ktTk7gn17Qb
         Ffxg9acT6uE5MIDAS3l9+O3pAv6nB9ZXsS0EsJY4nj5iGWQueI5oH3HT+DPoxgRdfRjD
         u7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743453835; x=1744058635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhmnlMAAlfE+UJZ4bK8dEFy6Cahb9IglOuPC0RLUf2U=;
        b=wjcm3hnGtH/csLgZdeQuQQH5Uu4IFU5sqyatQrvpHBp32JbURzCXfPjTjayt+jNQnE
         e+hCZt4/Y9thOe/O9LRMa3CDfqomC+1iI6nYLznHagArtiPHOsncCJaZ5herx5t+J5Ho
         XU4h2aHIKGW27dXJgOlamVBisQHNYCBc458O+x4P20S05UH0d/Po1qZfrIuONPyFqegb
         WJOJmMBvwMVoabzxUPi6PgPykhcA8ukA0rGPdyr1q1d3qVn+xA42bBALjOny4IHaRVz0
         8HE3DsEr/LqIDEyOhfY/CQ5BP/L41QjzFCyEgGCcAwrq09pN3XkMZf9pHvAUGb6MVHBX
         9Mig==
X-Forwarded-Encrypted: i=1; AJvYcCUgBSDFRFDhY9UlGxy8t5KOwIDMu/78NkFdjY6S0z1Qtf7zwi5pqatfC6paUHEQteIc3SH2eQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxwjkf4/r4adySHVTvJ3tEHZ8CamnD226w/XB0tTwXisA8k6XFr
	P5GaUjSO59zhZB+lE23HvKWTIASantrYzaueJ47qNDEqZOaQalx1OxKuEdyRDNMnhOQkmFh2cP1
	vMVNx2peIWBgSvUEExBcMSL8Hcpg=
X-Gm-Gg: ASbGncuJFkYsXIhWAvEeBYHWkywxCzop8yOP9ErfA5QKfddSF4zh0Kc0sNF9fHwG+EB
	Dnap46UZgGBJgLsnDP9TP2FX4vVfVXJIcTsNCp/IZ2xLYct/gDRd03NHx5se7I+PBI3fUdQn7wv
	F2zHMHZxgLqFb9tVbvIyKOE7So
X-Google-Smtp-Source: AGHT+IGa2ATWEnPtBZKrovC/2tQXOIHQaYNh/KXGz4WWHKDhRqKyDzgdS0ONK7AXu9tKvknpMnQpqfeFIU5BV3Y+5xU=
X-Received: by 2002:a17:906:1718:b0:ac7:391b:e684 with SMTP id
 a640c23a62f3a-ac7391beac4mr794735366b.58.1743453835197; Mon, 31 Mar 2025
 13:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250310-dmem-cgroups-v1-0-2984c1bc9312@kernel.org>
 <f5fdc666-dd72-4a4f-9270-b539a3179382@amd.com> <20250310-eccentric-wonderful-puffin-ddbb26@houat>
In-Reply-To: <20250310-eccentric-wonderful-puffin-ddbb26@houat>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 1 Apr 2025 06:43:43 +1000
X-Gm-Features: AQ5f1Jo63dx6IuKsG5SoyFqmX486Pcaveqb15lGzyp5QvSc5pKKZ1U2dlNV04bE
Message-ID: <CAPM=9tzkLXOz=-3eujUbbjMHunR+_5JZ4oQaqNmbrWWF9WZJ0w@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] dma: Enable dmem cgroup tracking
To: Maxime Ripard <mripard@kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, Tomasz Figa <tfiga@chromium.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Ben Woodard <woodard@redhat.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Mar 2025 at 00:26, Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Mon, Mar 10, 2025 at 03:16:53PM +0100, Christian K=C3=B6nig wrote:
> > [Adding Ben since we are currently in the middle of a discussion
> > regarding exactly that problem]
> >
> > Just for my understanding before I deep dive into the code: This uses
> > a separate dmem cgroup and does not account against memcg, don't it?
>
> Yes. The main rationale being that it doesn't always make sense to
> register against memcg: a lot of devices are going to allocate from
> dedicated chunks of memory that are either carved out from the main
> memory allocator, or not under Linux supervision at all.
>
> And if there's no way to make it consistent across drivers, it's not the
> right tool.
>

While I agree on that, if a user can cause a device driver to allocate
memory that is also memory that memcg accounts, then we have to
interface with memcg to account that memory.

The pathological case would be a single application wanting to use 90%
of RAM for device allocations, freeing it all, then using 90% of RAM
for normal usage. How to create a policy that would allow that with
dmem and memcg is difficult, since if you say you can do 90% on both
then the user can easily OOM the system.

Dave.
> Maxime
