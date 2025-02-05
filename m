Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F71FE47E
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738787804; cv=none; b=YxWHUVA/jXReb+sBs+3nlcUa5gLYXF+cn+ZtTySaS63ApaGNqp7TI2WmPZsELb6eKxw+7HDovdgzmODq3vpST1dytX579CPdkJ39JrV79m373xlvpF7Z4eOmadlwlo6aIhOZSlRzEyne1PmpmrJakmH+iZw/ffF+NPmt0UbHycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738787804; c=relaxed/simple;
	bh=iuXh0TwQYZ/oRfuf6C74IO87n76azj0vyRXdJEtUi7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=PgyllChVAXn+yJkC+AaxLEfIH3Ako5owN6LVnM3s3XLYMPPLoHRwqCG0arXvVHjPHaR8lge5kwVulDfLi/3CoD6Cr1w1mN/5vxGsPJ9TI3o2saKEjkQbqz7UfFQXf4g9w4l0R3pUyLgbO5VUbUwlKdFo8yInmf58Kr/Vt6nheio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vj/mbHH1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj/mbHH1"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so440869a12.2
        for <iommu@lists.linux.dev>; Wed, 05 Feb 2025 12:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738787801; x=1739392601; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LaIHhUhM3MiwbNj642cr48xuyOAOk/UPtx3aLDwDwM=;
        b=Vj/mbHH1IW+Cse8vB4xotnoT3ZQm4SVTKyzvEmQl17KV3B8i9yYOpw4UUiVnbqqkOd
         0W2/AdeLLeudjxDJQEyWOC/y6RJQAK+YsYtFG58JUAC3OFyPN4oyToR7ZFMdu0k+wAo0
         CP01JIN2iwpBDUqc77WxJZf7lUJV7qg30/KcQHg5THycpyCG/cYtY6JdD1P0KOlZKmfE
         vIYBahRni51x08cGWBYVJarAI3yzaQ15Qs2Kb16C9A027ngE1jxM3klRVXXapuRM+9y0
         t6dOnsZrYP7nUlC1zx4JdUGH+VEuld6XDWVrTS2VWnD7d3YBOZeM37jmF+/7cj0fb4Lq
         rWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738787801; x=1739392601;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LaIHhUhM3MiwbNj642cr48xuyOAOk/UPtx3aLDwDwM=;
        b=Pz1ZUFqi3LcCCtQ4udT9/9C2ZCVDyTOOBlfy1r+CGrBNKI7TG8HrOy5UvABsp7jVe1
         LYqhlzx7CjbZVNg4/toHh+VqIdvP6a7LLvC3vgGOxU5WEGynNFkqzJ+Awa6jrdeiJWoy
         KtdSigJoCf000rXcCFJB5Qx52FL+3UBVlkSn6VSgnDD2VCt5VI4KhebWhSF3B4b8tGJY
         +/eIiRIXoWnJmK2+Cs9zh+E5VJftBC/vUBGnoXeyx6qhpe333ersTzx1SL4sN7lyv2mH
         ym+TB48UlkKZtPZ7vNUapgzAnINsP98fg+ynZC2n8qrGL4tO08ZU/uAIfM+6JZ8h6hz5
         g0IA==
X-Forwarded-Encrypted: i=1; AJvYcCWPRxWSvuneDdyuOHSTmpnyjkvkkJh5Nl7Gr7IkeAI+81eyoxXqmAQ8/2Uh47fyL9CqcVcTpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRut9M5oZwkMDIg++l/KsTWc16p5xuh76P+GyRuwfylTaL0Vhj
	aiYlUjKYPbQUMtBaFJRIXs9G9F/jEmNjllcSqJIKL4LBkEt9wZH854EjhcFDu0Hw6NhVDF1671F
	aOfoSDLsEHl43Qqv7GBRmLnnuipk=
X-Gm-Gg: ASbGncstEW9C+q0vYVC6cy89YpqsIcky+5mplA4xjC+6k41KlOS2ekXRAlvMv+PsIZZ
	kqFzUDsahYfWQg95UlOYkEFkwE4s3VzYc7HL7YIUggtzQ1IBZFoSI9cjZIaEGN3E0/j+X0GU=
X-Google-Smtp-Source: AGHT+IGCNARq/S6flKBk1hsdDpgzC0mJGccw8CN73wZw3M31xCCPOI69qccB2KG7dZGEukQGOPb+n7mn03YtMGHd1pw=
X-Received: by 2002:a17:906:f593:b0:aaf:c27e:12e8 with SMTP id
 a640c23a62f3a-ab75e35dbc2mr567563366b.37.1738787801129; Wed, 05 Feb 2025
 12:36:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Z4D5a5NYrAbNxUL6@pollux> <Z4kG5AcVeQKegLnb@pollux>
 <20250128092334.GA28548@lst.de> <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com> <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com> <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com> <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
In-Reply-To: <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 6 Feb 2025 06:36:28 +1000
X-Gm-Features: AWEUYZl4PgDWEAOqJs8geanKYzm8-RmxJs8QL-ZQeTHW_IM3hse2lK_-6T3WYCA
Message-ID: <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
To: Hector Martin <marcan@marcan.st>, Jason Gunthorpe <jgg@nvidia.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	phasta@kernel.org, Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, daniel.almeida@collabora.com, 
	aliceryhl@google.com, robin.murphy@arm.com, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	airlied@redhat.com, "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, 
	DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Feb 2025 at 04:52, Simona Vetter <simona.vetter@ffwll.ch> wrote:
>
> On Tue, Feb 04, 2025 at 03:46:14AM +0900, Hector Martin wrote:
> > Adding Linus
> >
> > My 2c: If Linus doesn't pipe up with an authoritative answer to this
> > thread, Miguel and the other Rust folks should just merge this series
> > once it is reviewed and ready, ignoring Christoph's overt attempt at
> > sabotaging the project. If Linus pulls it, what Christoph says doesn't
> > matter. If Linus doesn't pull it, the R4L project is essentially dead
> > until either Linus or Christoph make a move. Everything else is beating
> > around the bush.
> >
> > Rust folks: Please don't waste your time and mental cycles on drama like
> > this. It's not worth your time. Either Linus likes it, or he doesn't.
> > Everything else is distractions orchestrated by a subset of saboteur
> > maintainers who are trying to demoralize you until you give up, because
> > they know they're going to be on the losing side of history sooner or
> > later. No amount of sabotage from old entrenched maintainers is going to
> > stop the world from moving forward towards memory-safe languages.
> >
> > FWIW, in my opinion, the "cancer" comment from Christoph would be enough
> > to qualify for Code-of-Conduct action, but I doubt anything of the sort
> > will happen.
>
> Yeah no.
>
> https://chaos.social/@sima/113942119012147959
>
> This was about you, because typing a proper answer takes a bit longer. It
> was also about your toots on fedi, like this:
>
> https://social.treehouse.systems/@marcan/113941468353031993
>
> And "haha it's only a joke" does not work with your public profile and following.
>
> I do understand the frustration and temptation to just burn it all to the
> ground, head the call of the sirens, or maybe for me more pick up goat
> farming in the Swiss Alps. But you can't have it both and expect to also
> be part of and contribute to the same community. And personally I don't
> appreciate getting drenched in gasoline while I'm trying to quench flames
> on the ground.
>
> And this isn't the first time or the second, by now it's a pretty clear
> pattern over some years. And with the first I could explain why you react
> like that and you had my full understanding, but eventually that runs a
> bit thin as an excuse.  Now I'm left with the unlikely explanation that
> you just like thundering in as the cavalry, fashionably late, maximally
> destructive, because it entertains the masses on fedi or reddit or
> wherever. I have no idea what you're trying to achieve here, I really
> don't get it, but I am for sure fed up dealing with the fallout.
>

To back up Sima here, we don't need grandstanding, brigading, playing
to the crowd, streamer drama creation or any of that in discussions
around this.

The r4l team and drm maintainer team have this sort of thing in hand,
it's not like we don't understand the community of the Linux kernel,
and having this first reaction to blow shit up and dramatise it just
isn't helpful.

Being toxic on the right side of an argument is still toxic, please
try and be better, and maybe take a step back and consider is what you
are posting going to help the discussion or just adding pointless
drama to it.

Dave.
