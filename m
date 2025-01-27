Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF28A1FCCEA
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737971122; cv=none; b=rCyV4CSJUWyVZNVXVsN+zhpYZBQ1esELoQEhya+d5kCv6FFkdOWuhkR8hCpC8cNMSG3aZ23CfVl1BD+bDV4I7qPbopyUtltwMhaqJvKMzSwWUf2qbRDbwmDqw4Yhm8Er1nnzsPrWnmcnl2TnNa7bp1Hp7PHyq1SIa/4FkbKh3H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737971122; c=relaxed/simple;
	bh=vQ3gmIZqaNW1g/LT+/j4YlDwXHe3djbAtV5fO8bABQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W80abQN32M7B3xHsbqgDMQYnwrg7+Bh6I2bv+HeaWjsAjnnMt7tBrVFd7EZ1B4d59jWFGCcYpCY+vkvySGcHnaMWtPoAZ1dGPNVQNgxv9EkBU4mUZBMgY3XafCgYtlQH0UzuV0IuWgoB7eHLMhiy9Y5CKF1ujWR5j6RnRShGVXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fUqG2/ol; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fUqG2/ol"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso27480275e9.0
        for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 01:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737971119; x=1738575919; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWfgF91HXh+KWhnSvXw9sos0v6cTulWAKwLbp0WnDlU=;
        b=fUqG2/ollIvHMcBHvq0fvDA7aASRleZY1nfq02PAtXwIN9rjiIFWo861DGj2IvSRLC
         OfatsU2JAWEo1vATWMClSASEuX51Moi23RIGfly3K5AURCmY9uxNjCzynMbp83eWQeIb
         fnsvsYc0SwU0kszr1EGENb79xwdf+V9oanhBdY43WwQZ4pxfybgTu8PQkAHU4TiJV62B
         g+xACHVht9clE4Xwf5k1j9F5fdsoUVkH0q6ZymlMiE8YJxmhAM/mOL5u8H9rEuejIonV
         I7SI6rsvLMYeaSW9x3mwX/Q52xn7Jl06cbQ3wwSUTNRMz95JfrF62GMh+2pbv1kMPT16
         cOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737971119; x=1738575919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWfgF91HXh+KWhnSvXw9sos0v6cTulWAKwLbp0WnDlU=;
        b=cfF2hfoBWHLMLZLALPi2X6r2GhvMH8JtH6FNDDDI4ufFgrJnCFb4yHr0qow6yowo/9
         /HmvT6ivLWqKMwW8Osde2AdilNyLWc0FBIoMImaGYDwrTwhetZJEA8UO+PDd7x7GLfeK
         wx9MSVyEGOD2XWM2EpjheyOocdAu2bWtW2Wnt140uGqO7l1EWaDoaaAlZ/OuQ4Fn2xAh
         Rjs6VDvMC1KjJTNB3DFP3tNabIb0WOZvPmYduTrntKi9rAyQPs9TsOhGxRaS0hK03MYk
         ba6fBJPI2KH+066ivGtnZVfj1qgr5P5vlg4LJDgZ+goJq7EaYUKQoVeisc+FU3DZqjX+
         /SYA==
X-Forwarded-Encrypted: i=1; AJvYcCU32/4WEHk2Olf6xhlIFg/4rcxgET11JujuUYdkP006Ddg5Ca4JVZ2sCywejejx0pbtzQUbiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzL4vAAuqOc6ygme9J2/RPSu5GQv6RphE1sMcWv0eB/VGnNkfOY
	u9gczdYHUBmtc6STcDj/1RIOJrqH43doOxznoYryGbEXc0K82eICHa2xiXt2Dr1QUnNYNeQGOge
	YcJJyllSTLO5i/gsCHlHcnFoisy9VflpgVZeN
X-Gm-Gg: ASbGncuJsHoapDt7Y5pXS1vTkNg79fRckKNh9PQQstdRxVNUKzbVrGp9Ll5WQr/X2XW
	VTqo/nJ79+lRlwLcTXe1A9JkICHejvPv3623q5SA5PWfDxL+yXRcb4bJ7Qqr0fSwp73+cRXqlG7
	kF/M+ACwpf6ylnelIX
X-Google-Smtp-Source: AGHT+IEXkLLN3S3MMw4xRiFR1Y8MHCtfk58zMT4UAb6q3UkIxnbgrIDMMRrud/wsyj6Dp4vZezgOZE+N4vP5xJk59zI=
X-Received: by 2002:a05:6000:1864:b0:386:3328:6106 with SMTP id
 ffacd0b85a97d-38bf59e199cmr43026813f8f.35.1737971119189; Mon, 27 Jan 2025
 01:45:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com> <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <20250127071625.1882afa4@meshulam.tesarici.cz>
In-Reply-To: <20250127071625.1882afa4@meshulam.tesarici.cz>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 27 Jan 2025 10:45:06 +0100
X-Gm-Features: AWEUYZlHQHrC2gBJEuAbWTkeobjQJsyNv5yQQrQaI_rFXqTf4MZLW4pDDd9H1bE
Message-ID: <CAH5fLgic6kdOQyw+=S49p4rVnA7x6maKPVakd1uqA5fkGxZiXA@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, rust-for-linux@vger.kernel.org, 
	daniel.almeida@collabora.com, dakr@kernel.org, robin.murphy@arm.com, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 7:16=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr@tesari=
ci.cz> wrote:
>
> On Fri, 24 Jan 2025 08:27:36 +0100
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > On Thu, Jan 23, 2025 at 11:43=E2=80=AFAM Abdiel Janulgue
> > <abdiel.janulgue@gmail.com> wrote:
> > >
> > > Add a simple dma coherent allocator rust abstraction. Based on
> > > Andreas Hindborg's dma abstractions from the rnvme driver, which
> > > was also based on earlier work by Wedson Almeida Filho.
> > >
> > > Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> >
> > Overall I think it looks pretty good, but a follow-up from our
> > discussion the other day.
> >
> > > +    /// Returns the device, base address, dma handle, attributes and=
 the size of the
> > > +    /// allocated region.
> > > +    ///
> > > +    /// The caller takes ownership of the returned resources, i.e., =
will have the responsibility
> > > +    /// in calling `bindings::dma_free_attrs`. The allocated region =
is valid as long as
> > > +    /// the returned device exists.
> > > +    pub fn into_parts(
> > > +        self,
> > > +    ) -> (
> > > +        ARef<Device>,
> > > +        *mut T,
> > > +        bindings::dma_addr_t,
> > > +        crate::ffi::c_ulong,
> > > +        usize,
> > > +    ) {
> > > +        let size =3D self.count * core::mem::size_of::<T>();
> > > +        let ret =3D (
> > > +            // SAFETY: `&self.dev` is valid for reads.
> > > +            unsafe { core::ptr::read(&self.dev) },
> >
> > This safety comment should explain why this will not lead to
> > decrementing the refcount too many times. Which is because this
> > doesn't actually duplicate the ARef due to the use of mem::forget.
> >
> > That said, I think wrapping self in ManuallyDrop is slightly easier to
> > read than using mem::forget. I refer you to this pattern from Tokio
> > that solves a similar problem:
> > https://github.com/tokio-rs/tokio/blob/ee19b0ed7371b069112b9c9ef9280b81=
f3438d26/tokio/src/sync/rwlock/owned_write_guard.rs#L38-L51
> >
> > > +            self.cpu_addr,
> > > +            self.dma_handle,
> > > +            self.dma_attrs.as_raw(),
> >
> > Why not return the Attrs type instead of an integer?
> >
> > > +            size,
> > > +        );
> > > +        core::mem::forget(self);
> > > +        ret
> > > +    }
> >
> > > +    /// Reads data from the region starting from `offset` as a slice=
.
> > > +    /// `offset` and `count` are in units of `T`, not the number of =
bytes.
> > > +    ///
> > > +    /// Due to the safety requirements of slice, the data returned s=
hould be regarded by the
> > > +    /// caller as a snapshot of the region when this function is cal=
led, as the region could
> > > +    /// be modified by the device at anytime. For ringbuffer type of=
 r/w access or use-cases
> > > +    /// where the pointer to the live data is needed, `start_ptr()` =
or `start_ptr_mut()`
> > > +    /// could be used instead.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// Callers must ensure that no hardware operations that involve=
 the buffer are currently
> > > +    /// taking place while the returned slice is live.
> > > +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Re=
sult<&[T]> {
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
>
> I don't have a strong opinion, but maybe you could elaborate a bit on
> what exactly you dislike about as_slice() / as_slice_mut().

The as_slice() method is unsafe as currently defined. The purpose of
this proposal is so we can have a method that is not unsafe.

Alice
