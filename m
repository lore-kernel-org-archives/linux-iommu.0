Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA299493D33
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817372; cv=pass; b=nuBuHXAP7XwQppqRTqCTUc7wH7sgVyHnTFwPpjuOwrpoqAEilkJ3OtcH3hfmyA0X6CvFAxaCGk1z8MI31ygNS0pxCqpXKf5VW96eIaIlkpfEPbORyM2pcz6IXlvfVBK+uQxu1FLPjYNFb48Qf+x988Wdn7mOd1LlgbN7YJW1adU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817372; c=relaxed/simple;
	bh=9p0AqvEckCKKmioWpbl9ub4ZG0q2KitJ6iNWSAzwTY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/nv6Hy7/KF95jRz6IaDuFcXHpKKVas16SjEwAAUYFHkShwbE4XUoEvR+8HGHihpXsRrXjb1r4OUxM5L+gPFB4NGRabgey0nRxU7+9OnwxxhbXA7Pn8vkbcFC6ePuQzHCUQ1X/XWoFe/f2bI8x6Ap+tn5+cJnOIiok9B+L2BoXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQHeddiA; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQHeddiA"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab9268d90eso809466a91.3
        for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 08:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791817370; cv=none;
        d=google.com; s=arc-20260327;
        b=O8dAjrpeTsGyh1nuaslOhAOch68McZZvmnrQhm/rM7T9GJmoWwMMPjCx0iPznHwyZ4
         hrryf4Nx8wHGiVQ5btuF8XXz9xeJN/N+1peqWoDWtfthdPFcXTXIomfHRsIiJNqaLPi6
         SOeYV5vN+AgxXySNlOPaZZcSMV43z1eNdMwqF22RxZhG9msW7onnnaFleIa+zYXbFYdH
         Mq0fi+eQ/NSn1xIRw5G5wpfNnuk3T9Wbaoj8p9hMkf9vab+svhuLhHOUanaWMRgzfP+N
         m6752zH47gaEUaGL0yFk9XO8w9jZ7/7kBwtNdIwXNHB+GTxIONH/6FWSvVzc9jhC4yTb
         ZtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rhIDuBLHbJsBmFiUrtUWW1GlGqZnHdg0lmt6NThkZTI=;
        fh=gs6znEN3Fj7JyJ5Y9cH1jTx2IuoWYGUXoea1C4pomd8=;
        b=QByJIVh1OxASJZQU0uTINwVvIWwLhvWHhfTIHjDTIbiQax1o1GSXksCCLs2QcKMLTv
         NOdXIXzN5Ddaf1+p+a2eR8JZ8deEbMj0UFnszPaEp9vScMpuZa600cw89+pmCoZnxODq
         LrGf4/MU6bhLush6EBAKDx0ROS17sKjjdbdc4oyVeIlqO5XJnq3UoMdHdXt0gbXnF25P
         qsBv4OikBtXCtOCNwp+qe1ImiNd7Ru7GtHCO3dJxnXdMklTZARDWJxcePGYXbSdO+dD8
         nmFtcNpXw0c7VaqbUQatuL5HqpgHcKHT/8Ej8J/3dwCPoGm1rA2bN09oNM3PaUQLCeHi
         TwjA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791817370; x=1792422170; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rhIDuBLHbJsBmFiUrtUWW1GlGqZnHdg0lmt6NThkZTI=;
        b=VQHeddiACrL6U0jCOmEj2AhlzmDnMkDQgTNgIrB8vfn862YH3wlU9LuKbFzzpZFY9z
         mQ2Ve94ULcAdZwJ3362saTQfMdyjgnnZsW/2ZBOh7+m9mgURhmlFbGYTc6Eo/tdyiZZ/
         kKvqVrtX1F534jEyexw01syb7WQojIf+r2mHfLlZwurApFvui8vbGK79BQ2XImyPCHr4
         MKJW8tBArx7Od5J4iDoWX5j3Od9d8kJr1bfkT8+3KF6ciZNCXA5ks1owqFBdyJx8v5jl
         ujJNuiDIPkSONfVZPzExM5M3JsPt9Z/je9BMh0yaaxukfDzLNMOIuBw2dmY7dCHBC/3a
         OzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791817370; x=1792422170;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rhIDuBLHbJsBmFiUrtUWW1GlGqZnHdg0lmt6NThkZTI=;
        b=LC4quHbnj9SjJyGtQxOwe43obmeUlBcw2iEptdujsnYVtUmnJLDvYiJWsJRpamKKXq
         XE8uvFNSc39yCSjIcJMYEuRlnpvaNUMsVQAi2fAbkwoIDK+ambs/W4BI6fwybwJyLEcR
         0d3cETNl3KXQBsGaCkMctIV65OrukwwAP3G5iNsXqPGjdA9xjXYYnAQIAtgGx1StgIgM
         kmsDVJv2JHG/ZU5NSkPFZocJJmj3Qxw6vGi0hlz8bUmDR0KN3wPNNCJp9TTlUByXyqq1
         GcrN4mitTyLPbUb18P/XRYhPyYhwJLZncWUtUlNw2sTvbcXEmcUv8fvxpOuipzidme1p
         zrFw==
X-Forwarded-Encrypted: i=1; AKwUvBwQGThUOKl1Q2fIpTt54Ez093HLc3KQZ2Zj5DarPzS6GSF2JiEMxTsPOJFbZmy244TcOLKqNw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJyILkDeKWFXb58ZyeFpkixq89siW/NLIyk7oPQKh6pqf9ecGs8
	k9UXnb57Erx2KI2f/V9qZFqDTQpxoJsjyvfObRsHFjy+DLjuC5krPze+01ZuX5TTZ1jueNKezNK
	zuhhcW4ips7mZhN84a0/QR4CYyiNcxqM=
X-Gm-Gg: AYBFou1H9c3l958dK/Jznjb2dIT32684MqDWiJXbAWD8V+Qa6fIctHUlm70DiDBPejE
	jdJkFdeXAVUjN/U0++kaZgwfscqQ6rpe04cq7qTLk3UBbviUPGxjtdFhU2epfkI0ovmlHQefAy5
	z+/IuOg7cLPcS9lR+7GeHjOWLA0KKUVTpLAPUNbgGW6n3ePbR6d/DjrpObX/86QwA8NVBlwX7XT
	DHQUZGYrUiw1SFlWQE187R8SCmx3fAWlLus6JyPHiwssyOfXZYIIs5afrZoZahheNFRWU/hpDpX
	MWu8HCnYT4pdGWa6sHjapxEapb8TSJYTlU+iTYF3BeiwkAGyxys8monrxA==
X-Received: by 2002:a17:90b:1d4f:b0:3a8:c0cd:57f3 with SMTP id
 98e67ed59e1d1-3ab3a94ff23mr7233060a91.18.1791817370093; Mon, 12 Oct 2026
 08:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <aszzcpW6fJWGcQCZ@google.com>
In-Reply-To: <aszzcpW6fJWGcQCZ@google.com>
From: Luigi Rizzo <rizzo.unipi@gmail.com>
Date: Mon, 12 Oct 2026 17:02:38 +0200
X-Gm-Features: AclHuK_RuYPmfWCEef8B345PmPnIk-csUIxQogHwwsigc85_8kdg-6GHSEnG77s
Message-ID: <CA+hQ2+gMGJH7J0yAx0ooTpWYfC50FnDXvCRRwRaJ_8bJ4b=QDQ@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Mostafa Saleh <smostafa@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <lrizzo@google.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:49=E2=80=AFPM Mostafa Saleh <smostafa@google.com>=
 wrote:
>
> On Mon, Oct 12, 2026 at 03:51:39PM +0200, David Hildenbrand (Arm) wrote:
> > On 10/3/26 23:22, Luigi Rizzo wrote:
> > > Here is a subsystem called DMA_PMD on which I would like feedback on
> > > architecture, possible enhancements, or kernel components that could =
be
> > > reused to avoid duplication.
> >
> > Here is a feedback to a subsystem called DMA_PMD ;)
> >
> > Why is basing this on PMDs (and embedding it in the name) the right app=
roach?
> >
> > On architctures with large PMDs (512 MiB on arm64 with 64k), would we r=
eally
> > want to use 512 MiB pages, or rather something smaller (e.g., 2 MiB) th=
at might
> > possibly also have TLB benefits (cont-pte)?
>
> +1 I raised the same point in the LPC talk.

See my other reply, he code makes it clear that the target is
reasonably-sized chunks (2M being the obvious choice with 4K PTE/2M PMD,
for other cases we need hw support, and it is relatively simple to
decouple page size and chunk size.

> AFAIK, this series tries to solve both IOTLB pressure and CoCo bouncing
> at the same time which might be too strict; as for CoCo there is no
> actual IOMMU, so there is no sizing constraint.
>
> Also to reduce bouncing, I think it is sufficient to use the SWIOTLB
> instead of having a new pool + recycling, the tricky part is how to
> abstract that to client drivers as this would be needed beyond SKB.

I did have another series to build buffers out of the swiotlb pool
https://lore.kernel.org/all/20260824152932.1583506-1-lrizzo@google.com/
but I found it does not scale well under pressure: the existing swiotlb
pools use linear search to find an empty region of suitable size,
linear scanning when one pool is full, which quickly degrades to
O(N) on each allocation.
I had some other (not posted) changes to build a buddy allocator
on top of the pool (so searching for a slot becomes O(1)) and
to spread the search order when a pool is full (avoiding O(N)
locking conflicts), but there is a bit of extra overhead in the
light-load case. Also it felt like reimplementing the wheel.

Overall I think DMA_[NOT_JUST_]PMD is cleaner and superior.

cheers
luigi
> Thanks,
> Mostafa
>
> >
> > --
> > Cheers,
> >
> > David
> >



--=20
-----------------------------------------
Luigi RIZZO, rizzo.unipi@gmail.com
 http://www.iet.unipi.it/~luigi/
 Mobile   +39-338-6809875
-----------------------------------------
