Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B17D1FDE18
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737977689; cv=none; b=mv44fd0P4d0GnHTJy/RznIobte0Y/1FsxnSQ//IOxtaQY0MeUDo/Vc6PkQxrf/y4Ohr1eflE/TMULquH8r8jmgyEf6bCSzQMMgNyo/wnAAbiorc7mS70DwOp81wlefR37/oJMUwubLv9t0gfVf+JSSscIvGZIodPtuA34LQPCHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737977689; c=relaxed/simple;
	bh=gNVtdgapZ5exCANsFWbc3cXypKKKyoCZB+fVUU/rAF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4qCsrkT7yJWOpONBn7GWZPzOxIURusWCy2xf+zQOhJjZJdlRd9A+23ozTE9fxnnZR1qeaugocyNr7iZKTOwWESSU9i/TckdJHHi6KpLT6iRXTIQgGUn32fn6VmduVtcbcZTIzsA63giXhFm+hf2vv2Y0JkklQPPQv9IVp9ElWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tiWWvLdU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tiWWvLdU"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862d6d5765so2538179f8f.3
        for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 03:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737977685; x=1738582485; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNVtdgapZ5exCANsFWbc3cXypKKKyoCZB+fVUU/rAF0=;
        b=tiWWvLdUwBrbUq3HylIVYdQGFyIzzYnRjftiXnEuXJ0E3imZ1cto5GpGmMj13GVFqp
         L6F3c6yHmjUvsff04gM2E6JJwNE+4J7Qi1o9mEnmGJpsLvprdFbphnaxZwQVIPVvKBao
         3irdbmHWsCmjTGHMYZ6HFOSoMv8MBTbBdc3Ami6g8YjBVuO7My993xWZBksw244BoZ6y
         ie70QZiXeqvbjHh8+EcoMeY3ADsoDZhjYnbyPMuKUyCP107nN4/saeC8w88dr+NQHkaB
         FEM67DxBabMQdSwnMoKpjwiRBGO9WsUzauK5tWbUqKy8n37RfKz3rHVRQAfsCbvnHQfP
         VW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737977685; x=1738582485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNVtdgapZ5exCANsFWbc3cXypKKKyoCZB+fVUU/rAF0=;
        b=RTPLn7j44UE94fn3ZDJNRSEd6ZcW9ET09GbGwuTcq7P5Ti5hSS2BNpD3XjM/AQ01sb
         iO+oB1wxlYfip4aSpjysXEU3whM+3voulsphCwdz/Mp3uqBAZCdhCFqn2qchpoBpCyrZ
         6ZjJRxxcOZTHSL0PjdJlxYhcLTRgbj7yXHk6Q/3tGTNakcYNDlVmDW6rKG6mCOsrFea6
         zhq8v27tly3y7mEJp6CCOfOPWVMIYGmY+GMYtw4Qyf7QAhKq622g8xic9MjrmZ12/4JI
         nX1MOwm3d0QYrX8PzfAfCpOG3qPozJFjcSIFGJVazZSbf54+pLax2XtL5PI1zn8ptqLb
         6uIA==
X-Forwarded-Encrypted: i=1; AJvYcCUsgMOzEl0T5sd4q1CGGKrtBFEgyoBIE2MKj7I6GALvDni/Gol21NNLUARS2GEMSo98/ycFJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvX7qS6oqR0qBgcygSvveoN7GjsvymTGyfXgh/mvBYAoh5WYzN
	W/dbB+VXcp1rOjIoQ/AZbvqQpXfMMesMIy0UZ5ndW3Td1X/2ARvkykJglP5xaccNePHImpYSMeh
	+g8/n/SSHYoY2TMOXTO0Jwx7v6g8GClKVLx9W
X-Gm-Gg: ASbGncsJCkfOzPYF0f1F3b+i8Qf88SSIb5OCE9Rkv2PW7a/N1grgNCSETlARhJiEdM7
	wIcB/QUoS5xUNlq9goaJ4mvMLyO1GHCKQuWcQ/b5ppYncFMFaUnvQR0jN05lLJpZ+3M6yis7XEX
	StBk1IQ/Rg5cKv6QCp
X-Google-Smtp-Source: AGHT+IG4AJoJm61Dd6qVn/iF2+n9hCNabmmWWcn00TPeCKQaskwq3/ly+i1XzqQhv/UobqvqO7pTQRQhGN4UhdDmYac=
X-Received: by 2002:a5d:614b:0:b0:385:f13c:570f with SMTP id
 ffacd0b85a97d-38bf57a1e51mr30959048f8f.33.1737977685523; Mon, 27 Jan 2025
 03:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com> <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <0E0FC88B-95C0-4DBE-B497-AF9101BACE70@collabora.com>
In-Reply-To: <0E0FC88B-95C0-4DBE-B497-AF9101BACE70@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 27 Jan 2025 12:34:33 +0100
X-Gm-Features: AWEUYZk_b7owRl7Iq6kR1FnsqMI4Ec-Hweda-DvvizWUthOSqWuwym5xDeFvFdg
Message-ID: <CAH5fLgiW6n82hMhbmJ-ynd6329mEDFX6TzxXQZaaoG47HAWWcA@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, rust-for-linux@vger.kernel.org, 
	dakr@kernel.org, robin.murphy@arm.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 12:00=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
>
> >
> > You were asked to rename this function because it returns a slice, but
> > I wonder if it's better to take an `&mut [T]` argument and to have
> > this function copy data into that argument. That way, we could make
> > the function itself safe. Perhaps the actual copy needs to be
> > volatile?
> >
> > Well ... I understand that we did this previously and that we want to
> > avoid it because it causes too much reading if T is a struct and we
> > just want to read one of its fields. How about an API like this?
> >
> > dma_read!(my_alloc[7].foo)
> >
> > which expands to something that reads the value of the foo field of
> > the 7th element, and
> >
> > dma_write!(my_alloc[7].foo =3D 13);
> >
> > That expands to something that writes 13 to field foo of the 7th elemen=
t.
> >
> > Thoughts? I'm proposing this to avoid going in circles between the
> > same solutions.
> >
> > Alice
> >
>
>
> I think I missed something here. How is this any different from the *safe=
*
> functions we currently have?
>
> Anything that involves a copy is basically what we have already, although
> your version seems to reduce the amount of data copied from sizeof(T) to
> sizeof(T.field)?

The difference is exactly that - you reduce the amount of data copied
to just the size of the field.

Alice
