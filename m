Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C02054F0
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739517100; cv=none; b=RMyJRGyOT07I8EZNu0CjO3WcS8eeN+ut9uc4wegvsCzvsotxzgI8Gp8Bdy1Ehb9sGkC75tHeYN672CREO+h2GSuHAV0/xPGvkiX7jBo8Jf3UnwMXgbuV3NpeNOVxBMnQx9W1JyikDIzKg15C/J8kRqhHVqftj7WBSRhoXjM18H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739517100; c=relaxed/simple;
	bh=qW5K0tff0Kwu/5nGT44PYcGWfbsMK2Z152X5t4YLm+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2/Am3Jo+tRF4L4ffKGUjswnNn6MK2GWSuHN25u5kuBub+voayMlWI0plVW0pDiZUStROUkalzzp3lqxlcXgfM4nLPLunNOk8DEGwVPRLVto4vV7HOkHBApnC5NEqqGfQB6yHxeCBCX6Du1mHEXapi8rCSUGWeDyoqMmNkDNq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5deb0ea1129so2697058a12.3
        for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 23:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739517096; x=1740121896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBZbTGwwpOGkfmC2S2B/ns3VS+A0GE9103R09GlmDb0=;
        b=uKA47183UDIvduxaRxT3rfH6Bi0kXBZnoL7WNJLlxZhM0wXRKbH6Ywbi6MJ7Acd5+G
         pGnV9YFh5eM8/jF3suj+zraqlPsgX4yBznCqtl6C1RLWIRKfjdVrazYSpzzR8sx7Ug+t
         f3xsJ1v6dqmNj0/Qb9xDJdDAX4+iTU1L9pgfm1lHz7qyKSfItx0uUQjvoyK2JZylUcvp
         iZ4yFjPMgn5+YSrvbNWFHoHtRyL+Dg1QG1W0kaYg59dpz8Zw/isWXz2jzfiQagt/CsZo
         GMSS1E/6PjeegviTEfM/WgXYLjiQWQ39ksOzw32QWWPutX3jNL6OSsRGfdDvQ5GuOLuV
         m9gg==
X-Forwarded-Encrypted: i=1; AJvYcCVrkAuh5tEHsRQeVJl9ZH0S8J8pArULYwCnCxdOR885iYHuMI/6LKReS9t8/9LKkY2+d6cvSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAAKhlKzkgi6t50XRKXic0Mja/pNdRYz9RLhY2svyheE7jQfXa
	lty2r0vTfLeGNDR42ESC4FHPlJ1ansOcoJKIfpUsUG2RAJnnbFq3/FGM32lc07E=
X-Gm-Gg: ASbGnctnmc2RmO9mI4NwF8jTf79V4L+TscqZ5EtvOzg6wrrolehNWIJKBHlojbhuh+3
	aGpxx4RvFn8S8ENFHfE1ctD/tdNJxwIaXp9kvEDbOMEOi8wiGHseIXD0lpP57iMwSBxBpy7bnn3
	i6spyEkzS8tgS1Dnix9HEzpvKebHVE+lGc9Vffl0q/OAXkSWxcvf7N8EJASMkMJxN3aKYYveIq7
	ydeqnI/RpyrH0zonmc3fjmd7ZUm9j93A5UjaCQpuhR/dUdyBuH7FypkYfojq2+rqD4JPlaWX8W1
	xVUM/ZGL/yVmPrOhnpCCHCm2RpzVkwLtIRqQzetYb42ALw==
X-Google-Smtp-Source: AGHT+IF3ta94dAA2xEUh5k6v45//2Gtf/jTCPFKr4ile+ji2ytipFaK8CK0zzd2ccacDWPgK6RH5Zw==
X-Received: by 2002:a05:6402:280a:b0:5e0:13da:1713 with SMTP id 4fb4d7f45d1cf-5e013da1a64mr268027a12.2.1739517096199;
        Thu, 13 Feb 2025 23:11:36 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4e70sm2444516a12.8.2025.02.13.23.11.34
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 23:11:35 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7d58aa674so258027966b.0
        for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 23:11:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5vHNFKoJIejl0oImwPLohRxUmUyTPzwYSOlXH9BSJzXbQwjoc4PklPAMOZXfC029v3YrCKA==@lists.linux.dev
X-Received: by 2002:a17:907:c22:b0:ab7:c94f:af87 with SMTP id
 a640c23a62f3a-ab7f33c0897mr1109151066b.16.1739517094400; Thu, 13 Feb 2025
 23:11:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2025013148-reversal-pessimism-1515@gregkh> <1bbdf8b7-a70b-4994-865e-7fcb8d53ebef@marcan.st>
 <20250207-prehistoric-married-dormouse-3e1aa7@lemur> <7742420.9J7NaK4W3v@skuld-framework>
 <d6cae188-28e5-409f-86ed-7ddf374fd354@sirena.org.uk>
In-Reply-To: <d6cae188-28e5-409f-86ed-7ddf374fd354@sirena.org.uk>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 14 Feb 2025 02:10:57 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9BiTsTmaadVz7S0=Mj3PgKZSu4EnFixf+65bcbuu7+WA@mail.gmail.com>
X-Gm-Features: AWEUYZkDpaaCrtdHfh-vNgOgzQjACZNx_DnEFz8ZiojUP1KiLrlWIyNShKVYrqs
Message-ID: <CAEg-Je9BiTsTmaadVz7S0=Mj3PgKZSu4EnFixf+65bcbuu7+WA@mail.gmail.com>
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
To: Mark Brown <broonie@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	phasta@kernel.org, Christoph Hellwig <hch@lst.de>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, daniel.almeida@collabora.com, 
	aliceryhl@google.com, robin.murphy@arm.com, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	David Airlie <airlied@redhat.com>, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 12:28=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Sun, Feb 09, 2025 at 03:25:26AM -0500, Neal Gompa wrote:
> > On Friday, February 7, 2025 1:16:11=E2=80=AFPM Eastern Standard Time Ko=
nstantin
> > Ryabitsev wrote:
>
> > > It is my goal to be able to give subsystems a way to use forges witho=
ut it
> > > impacting how they interact with upstream or handle tree-wide changes=
. That
> > > is, once I'm done moving things from one Benevolent Company to anothe=
r.
>
> > Honestly, this is probably not possible. If a subsystem moves to a forg=
e
> > workflow, it pretty much means tree-wide changes need to work partially=
 that
> > way too.
>
> We do actually have some people using forges already, for example the
> SOF people do a bunch of their review on github and then turn that into
> patch serieses which they send via the normal email route when they're
> happy with them.  I think tree wide stuff flows in via back merges or
> rebases, one of the benefits of delegation is that it's not my problem.
> This all works perfectly well from my side, as far as I know it's fine
> for the SOF people too.  It certainly doesn't seem insurmountable.

It might be working as long as a subsystem continues to allow
receiving patches via email. As soon as a subsystem decides to stop
doing that (which is absolutely their right given the model of
subsystem maintenance that the Linux project has), I think this will
break down very quickly.

I wonder which team will be the first one to do it. It's not a
question of if, but when.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
