Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4F35CEA7
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808831; cv=none; b=V/nMMkOxRfzx3iNezVWrItfvFRQZNMT89vygheVl6E/5m40Ll9+LpykkiixWmHtkJbEY0TD4x1mLT9/DirMpsrJ/ok/uJ1kClGh99XKMf8b2ZE3G/U0lNAeuQo/6w6/d+DgkASgEieB/KjlDGb6TMau586JtIDIYwHlcSInn8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808831; c=relaxed/simple;
	bh=1qrCIxXCctxTGv3WrCi51BAahcEwkBdshUsK554eypo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ll+Mn3H/GUbb1T4/bk3v29Req8JB+kVLi0j+wCnipoHaNYt6Vz7kak9DZA7ma6kWUWDy2R6jg6qtLcaetTWsRKbIgSusx8ny5rlrvbacuaKZ/IrZWSskOxLCiaog3zhuNZkm6T2lzu+VKD/NO32JGN9ZK7bjaILo2wTGCNJGHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=baOD0nke; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="baOD0nke"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e93cc7c64faso1509375276.0
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755808826; x=1756413626; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHa4LrampbSXQx1Wyi9Bh9OjrywcR0PvG9lus2xsnNw=;
        b=baOD0nke3Yj8DczkLdom4asNlAxHc1+nH3GtOxImr5daLKsQD+AfAVFYjasnY3fDKF
         fgBTGf2vT7gQTLCKihgT+1nl8XVa1CwyxWoXHjtFgmxc2fYE6BtGiaVDyH3dooG1fQ83
         Vr998W9gOYQGTbFjY7mq2+FWz5hRoCMjuqyYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808826; x=1756413626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHa4LrampbSXQx1Wyi9Bh9OjrywcR0PvG9lus2xsnNw=;
        b=SqrgtmwJTkkgGFLHwAh7GHfmiAug1IXtu0OTv1EY7zgkhtuRNCeN9aRADUwwvyTkDJ
         bZbmnZt0GW7195EaLBlaUm1Xoj4KMFcfjUJxgCDgR2CGfJBTm516gjHXeg81/T2AvHYa
         IjB+48GMdupnODoDF43iutcd+pBm0GTBz5IZuOHNp25jI/Z3LecUiBJrnBTBa53mOdoG
         1uAWVyIMu27PLy0dWzoOJzkpxUcgaSUlIPOTe/OwyEUNOWrVjvbyGIBwG7baZFZwYZwP
         MCFSM3deKj3BpBgEYfgScJPfD4Fncr3LWPsY6thErfqpQ+uvMuhaQPYyFWZ9qRyZaaVP
         jFOw==
X-Forwarded-Encrypted: i=1; AJvYcCUfERwuNlWigRUR8NDRs6RwSZ063P3P5MqaT89UX1od/CMD7HVrCjtiuuO9ZVNofAzb8BaJHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7l083WKEkOsG/Z7QohspO8edeNB2Wm97bz4cZr2EFjI40AJBM
	vG0I8WRmQv9QGVeCGxWsVIWSqI3hcr33RwBquGb4CdFWxdXBROif4wL8ulFw3RFIL+nMIdofIrO
	cvL33MleuUyC8Kb7zqAVeiHhaZXPnaQUACqr9JxzevA==
X-Gm-Gg: ASbGncsy5MQ+le9ypsuM9EJKz/PLLeqKp5USue5d3Hv7ERZik8PxDLCHz3NDxsPq1gv
	HNnqfWFzc26I2ln3qOrsj2OQVOOtBxBWe7RmYjU73OjUe9IkJEcvsUVzqNnJVdM4JWpjrSz4n2J
	c3OzI1ce/ed6sKr+m5yTtvp++ftBaO7c81O1QcqryIFHcAOlRezNTUpG0NlKdFCKmuQOofQvP+0
	9pwS3xtC7nNgYr4
X-Google-Smtp-Source: AGHT+IEDbX/Imr3oMuC/SvPpVgA4gK54+Q+BCEwHjysz7tgNECdpdXbU462KLrYXAP4tYmTYkQFLOtkp14xdKE7/w+U=
X-Received: by 2002:a05:6902:c12:b0:e93:457a:37b0 with SMTP id
 3f1490d57ef6-e951c33ee1bmr998901276.20.1755808826442; Thu, 21 Aug 2025
 13:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-32-david@redhat.com>
 <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com> <2926d7d9-b44e-40c0-b05d-8c42e99c511d@redhat.com>
In-Reply-To: <2926d7d9-b44e-40c0-b05d-8c42e99c511d@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Aug 2025 16:40:13 -0400
X-Gm-Features: Ac12FXw_AatpwCNNPCEiMwiwdQxQbayKDzVf5K7yc3iQ5tLY7APrv3zl2U8Z_SA
Message-ID: <CAADWXX_5AJxTsk5m_RvP58d=quRMqT4-XbnQQx=obBTKjHr1Og@mail.gmail.com>
Subject: Re: [PATCH RFC 31/35] crypto: remove nth_page() usage within SG entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Potapenko <glider@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brendan Jackman <jackmanb@google.com>, 
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	iommu@lists.linux.dev, io-uring@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
	John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com, kvm@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-arm-kernel@axis.com, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, 
	x86@kernel.org, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 4:29=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> > Because doing a 64-bit shift on x86-32 is like three cycles. Doing a
> > 64-bit signed division by a simple constant is something like ten
> > strange instructions even if the end result is only 32-bit.
>
> I would have thought that the compiler is smart enough to optimize that?
> PAGE_SIZE is a constant.

Oh, the compiler optimizes things. But dividing a 64-bit signed value
with a constant is still quite complicated.

It doesn't generate a 'div' instruction, but it generates something like th=
is:

    movl %ebx, %edx
    sarl $31, %edx
    movl %edx, %eax
    xorl %edx, %edx
    andl $4095, %eax
    addl %ecx, %eax
    adcl %ebx, %edx

and that's certainly a lot faster than an actual 64-bit divide would be.

An unsigned divide - or a shift - results in just

    shrdl $12, %ecx, %eax

which is still not the fastest instruction (I think shrld gets split
into two uops), but it's certainly simpler and easier to read.

           Linus
