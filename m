Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318F1DAC9F
	for <iommu@lists.linux.dev>; Fri, 24 Jan 2025 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737703673; cv=none; b=ssFi4WzS8eyt6peUHGc+y5JY9R7sn/+9W9WeTY/YXuOMtxzp2hZoI/KvRPFzWuZTL+5gw4Fp1kJB/1hJ9AhHCcuxuhcj10V5K0AOpAdQVu8fBXiVcDeweKwE9fDsxuc213ZODg8V3TOp/L8nQxzyUY+iZGNK7K3ExyMpTn8As9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737703673; c=relaxed/simple;
	bh=MmWXvcHs0YEqeWGlJjI3ga9PmxYBdLE+gEIiTKedKTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqEq3jiZAy/tAK4TRO53KTha/SkLLX1b4/b2Lt15avqpTGsoDra/jPqrh1YGJzg0s0P+OFDTOVRbZhRcuD8PQYlz1/p8xrND3PJuTWqTmS9A9GZOJcG0viWZ+uGmxcDHWskbbzNX/xRuI20wxG165tixSQbpnDBHd7jNu5sI380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2dca+htF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2dca+htF"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385deda28b3so1259632f8f.0
        for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 23:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737703669; x=1738308469; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dm7wAbTYwcUBhvi1fiJ3y0ouhlvLY0mrXCVDx5XKuA=;
        b=2dca+htFNjwvr8dV+G3gXiYhVf/J2vohZaO+o6VMPm3yCip5wWnzaSoX7NT1YK+MPs
         7RO4vkzkmEbVIdMybqdp/FmA6dhpS+y4KnmV2MMSX1sR6vPmnA7VCbR3PziwACmw+yWq
         GK52vsKkVaZIN8ImnSE3TzsDoxcKmaufKrTPL38RtA8XG442N/Ut7uNKKuj7B99VaWfh
         p/RfPmYflPbvdwzd9Fhtak/seG081UOxbDjaFbgG6xp4RKZH1ae/QkdjvqCaqefL3g/G
         ELKeWfn42QBTejFsSpLMtyxHUBeXmU0YfSSCR7tTuQ2OjgZwUmSqBMeuq9TxZpwsRQ4w
         NIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737703669; x=1738308469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dm7wAbTYwcUBhvi1fiJ3y0ouhlvLY0mrXCVDx5XKuA=;
        b=NQoH5awoHejhv9bLTMcpIuYWs7UaUP2kaKV+p7cmrlHPr9E52FXybUBXxybEeNywfj
         nnGAaPGLg9o63DlFTU7GKohB8D5GqzcLrw8QvvhCp0AiupvaPBqnInzsu9Vzxaot122x
         2F/LpkIvwes4S0XDj602Bo1n7Ts1vTvCe7+Z37BSJ7Qh3aCi9Y5Zsnxnv0CNkvdIzPrP
         myiAeDIzltmp6ERXSUPY+Hkfuv2XVx8ofWW4ta+5dEBPBC5eJCt1HWihrz90iXFpSpg0
         LE38HAGZ3pDpPHDOFCw8EYx+FxSzlXLNvYG+jYIfCo8t/BZp2vUFz0KpIYV+l1YlLZAc
         pghQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOnJfDxjZ1FnW/vWs3tZ2XMZhnq00DsbXqCL6PV+wXKr9VmJy8xk6qi4Xdk8s+KrVhrr11qg==@lists.linux.dev
X-Gm-Message-State: AOJu0YytoUACyN0tX6cqfJWpahneeGUdw7qNSNqpD3eLqaV9UciYq73M
	qcinY+c1ymT66FE28tl/n74qZiejiChPY0Xxl71+U58t3332Wk7Mi1CeM8e/ggStDmpH0BsV+oM
	1V5lnpdbUHsS9IxBG35jyocZl/xnjiHch/0gE
X-Gm-Gg: ASbGncskOu7xo0nlzpntf/gOADA4Yw39flQOF8UrhC+IY+ZVqgvbZDVBquJN9siqAaU
	+nb/ReJ14HnTy85jXCz4MpxAjRdHAxyuNSQ1L8K/tBDZEkTI/ipPB6VSodtE7hHg=
X-Google-Smtp-Source: AGHT+IG+WJCZ6niBCr2ea9lao8jjYwLocNBSdvhoj1Oe9+nJg4phuC6TJqJ0ndgB8EHxTfuMjJPksaAZ7SW0A582Bhg=
X-Received: by 2002:a5d:648a:0:b0:385:f349:fffb with SMTP id
 ffacd0b85a97d-38bf57bfba2mr28100153f8f.45.1737703668899; Thu, 23 Jan 2025
 23:27:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com> <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
In-Reply-To: <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 24 Jan 2025 08:27:36 +0100
X-Gm-Features: AWEUYZl4ycPNE5J1IbzWwGCXCrtkHoG7zC_s-8WEd41UYdMj8CbvYSClW0Zuoc8
Message-ID: <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, 
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

On Thu, Jan 23, 2025 at 11:43=E2=80=AFAM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

Overall I think it looks pretty good, but a follow-up from our
discussion the other day.

> +    /// Returns the device, base address, dma handle, attributes and the=
 size of the
> +    /// allocated region.
> +    ///
> +    /// The caller takes ownership of the returned resources, i.e., will=
 have the responsibility
> +    /// in calling `bindings::dma_free_attrs`. The allocated region is v=
alid as long as
> +    /// the returned device exists.
> +    pub fn into_parts(
> +        self,
> +    ) -> (
> +        ARef<Device>,
> +        *mut T,
> +        bindings::dma_addr_t,
> +        crate::ffi::c_ulong,
> +        usize,
> +    ) {
> +        let size =3D self.count * core::mem::size_of::<T>();
> +        let ret =3D (
> +            // SAFETY: `&self.dev` is valid for reads.
> +            unsafe { core::ptr::read(&self.dev) },

This safety comment should explain why this will not lead to
decrementing the refcount too many times. Which is because this
doesn't actually duplicate the ARef due to the use of mem::forget.

That said, I think wrapping self in ManuallyDrop is slightly easier to
read than using mem::forget. I refer you to this pattern from Tokio
that solves a similar problem:
https://github.com/tokio-rs/tokio/blob/ee19b0ed7371b069112b9c9ef9280b81f343=
8d26/tokio/src/sync/rwlock/owned_write_guard.rs#L38-L51

> +            self.cpu_addr,
> +            self.dma_handle,
> +            self.dma_attrs.as_raw(),

Why not return the Attrs type instead of an integer?

> +            size,
> +        );
> +        core::mem::forget(self);
> +        ret
> +    }

> +    /// Reads data from the region starting from `offset` as a slice.
> +    /// `offset` and `count` are in units of `T`, not the number of byte=
s.
> +    ///
> +    /// Due to the safety requirements of slice, the data returned shoul=
d be regarded by the
> +    /// caller as a snapshot of the region when this function is called,=
 as the region could
> +    /// be modified by the device at anytime. For ringbuffer type of r/w=
 access or use-cases
> +    /// where the pointer to the live data is needed, `start_ptr()` or `=
start_ptr_mut()`
> +    /// could be used instead.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that no hardware operations that involve the=
 buffer are currently
> +    /// taking place while the returned slice is live.
> +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result=
<&[T]> {

You were asked to rename this function because it returns a slice, but
I wonder if it's better to take an `&mut [T]` argument and to have
this function copy data into that argument. That way, we could make
the function itself safe. Perhaps the actual copy needs to be
volatile?

Well ... I understand that we did this previously and that we want to
avoid it because it causes too much reading if T is a struct and we
just want to read one of its fields. How about an API like this?

dma_read!(my_alloc[7].foo)

which expands to something that reads the value of the foo field of
the 7th element, and

dma_write!(my_alloc[7].foo =3D 13);

That expands to something that writes 13 to field foo of the 7th element.

Thoughts? I'm proposing this to avoid going in circles between the
same solutions.

Alice
