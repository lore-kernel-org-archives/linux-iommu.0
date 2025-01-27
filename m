Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CD19006B
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738002767; cv=none; b=erWNpXOWMqaDg5YNo0owBqf3nS6YzGBC2/zRYJ69T/zlZqz4Vlm1W85Sp0JAFFeFZh2W1FQFCd2CZRLeiyMto/kpPvQqVchXPdQRan6vxOjfwvn3iJD4ur12AIIJsUP/u1eJjN29RLndEFgxtOgU8WBrTBmcfACvuHbqfohh+Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738002767; c=relaxed/simple;
	bh=Qsoxsth/svjFCYoMhIU+TEzvY1Q+VtfvPtQKewuOLIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4F+hDcZxdDmwzQKAeCNcP7OM3KYjxKBmWtya7lEzU8nfXDmK8XXYijMLQHBElxfAQR4jFoeWqa+Cxmq7VHfzRSljZMe3rs/mpJpEJC8TRDeMPR1vabx9zpUNukHYOvoskpGn0v7pIbPMPxfax5W4vrZbwgOsw6RJYtzWUprKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJ7uXEo8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJ7uXEo8"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so9079674a91.0
        for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 10:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738002763; x=1738607563; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qp4rGn+6HD7c2OVDUaJKvlE+5lGg9vBU2JEHl8VIVRA=;
        b=OJ7uXEo80NO9wmhhh+WbNGm/IkaWqgKOb85LwN7EV6pBf3VlN9pwGMh6ac+o3kwxcZ
         +3Zj5vwjNbGidZNlBSiB092nFIO22lH0BkATkyYpKFEN0CBHhDJ1DNr2i1sQtxHler6/
         NIGhxGfg4QoRtMtTqlpj15o1II2MbGl3Uo7kLFx8vzHFe/ezrAJfaTF29yCw9+qx2dBE
         I42KtwpgiGeUFT2T/49pwLJF/MKo4ESdyIQXl4u10Bbun5mutrZuaCWSAVPRlQM1csqJ
         Quoi83RlxnpBcSvZwnWXBmyxkc5WJGYJDRIe+8oT5noUZDBHNzO/TsZZRijsAWNhRAhK
         gqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738002763; x=1738607563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qp4rGn+6HD7c2OVDUaJKvlE+5lGg9vBU2JEHl8VIVRA=;
        b=bDXzwz8fkgnSP50ACpWHL63alLcAcytnqKMeB+Oz9QBAqEHTeFUqWT5BltfNjCzA2s
         wXYauhMOA/Uu1FVLhIOLNSgaKhkPM2gSHqlBoLGW+C4/s5J8YrF6rNg44ua70dNMb3ZO
         rUNl71IYKRuZDTpEMt6uPoNl5brUglIjEdDCIfbG0gmcL5E3qxBQN6cWX4ILhLvlypVx
         nsfNWOmxWkpdzBWguRtio1pgLOhMUQNXIDHmEy8oywArtrpYwJbUnfYs5OsJ5nBPFuKH
         F5dWw2w6LRdEyCQTK9t4j/xcqZY+k0VGI6r/oAFLYhePlaDAmyPH/TN7B1x5icoUy6HY
         RjMw==
X-Forwarded-Encrypted: i=1; AJvYcCX5bQ9xDNAeCviK9I55lOlarTbFX2De3g/NkaID9j/vCb/J1P/EnPbz2crlRHJRpzhNvzmsgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8dHvIobPm0uEy2jY3EZO3WB1g9Cq55jiQRbTF4RgFa/ctcHF8
	A3vwKQsLblu7zp7QfRjH0t8vUjtYfaj4pLymGqr9Xz7iiAvRn600xmmQiPlHsdkNn2gHqq0QSse
	Vi+leNDeJ0PYu5IaMsZlLiXR+PPxh34m4jRg2
X-Gm-Gg: ASbGncvGf2Mkdq1RT3bPejyUuWY1uqrwrjSKMkNsMC585DldF0U8CCh7/g69EI3bAJw
	Er3J5W/1XqXJCJthoh86Dl6FlBTza8qkKqUZUOj+SlELPhuslMDsfYqI6kwL0rcM=
X-Google-Smtp-Source: AGHT+IHbi8lv349DxaEsx6V1URTrBpwfMZ5Ln33K8IMtN0FmEZ9Nl2SMQIh6q8W51hc6Y8Dl804/bDcXZOMDi0vIsp8=
X-Received: by 2002:a17:90b:3d43:b0:2f5:63a:44f8 with SMTP id
 98e67ed59e1d1-2f82bff716emr557652a91.8.1738002763272; Mon, 27 Jan 2025
 10:32:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com> <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <Z5dh6cSnNxwbefJX@pollux> <CAH5fLggMSiHZwHJ3md0eH7smyDNVL3L=Sre7F0SXSSnPrJiO-A@mail.gmail.com>
 <Z5e7Xv4Y9007Ia0a@tardis.local>
In-Reply-To: <Z5e7Xv4Y9007Ia0a@tardis.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 27 Jan 2025 19:32:29 +0100
X-Gm-Features: AWEUYZm0Jv7rZ45EVsaPnB7OgSsxrCPuqDUBezjrKd8oPaeN5APSDIbyTiY68BI
Message-ID: <CAH5fLgh6_+yT36KQTML6wZTiKXO10HsueCDM5LvEbsD-8Wo6Jg@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, 
	robin.murphy@arm.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 5:59=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Jan 27, 2025 at 11:43:39AM +0100, Alice Ryhl wrote:
> > On Mon, Jan 27, 2025 at 11:37=E2=80=AFAM Danilo Krummrich <dakr@kernel.=
org> wrote:
> > >
> > > On Fri, Jan 24, 2025 at 08:27:36AM +0100, Alice Ryhl wrote:
> > > > On Thu, Jan 23, 2025 at 11:43=E2=80=AFAM Abdiel Janulgue
> > > > <abdiel.janulgue@gmail.com> wrote:
> > > > > +    /// Reads data from the region starting from `offset` as a s=
lice.
> > > > > +    /// `offset` and `count` are in units of `T`, not the number=
 of bytes.
> > > > > +    ///
> > > > > +    /// Due to the safety requirements of slice, the data return=
ed should be regarded by the
> > > > > +    /// caller as a snapshot of the region when this function is=
 called, as the region could
> > > > > +    /// be modified by the device at anytime. For ringbuffer typ=
e of r/w access or use-cases
> > > > > +    /// where the pointer to the live data is needed, `start_ptr=
()` or `start_ptr_mut()`
> > > > > +    /// could be used instead.
> > > > > +    ///
> > > > > +    /// # Safety
> > > > > +    ///
> > > > > +    /// Callers must ensure that no hardware operations that inv=
olve the buffer are currently
> > > > > +    /// taking place while the returned slice is live.
> > > > > +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -=
> Result<&[T]> {
> > > >
> > > > You were asked to rename this function because it returns a slice, =
but
> > > > I wonder if it's better to take an `&mut [T]` argument and to have
> > > > this function copy data into that argument. That way, we could make
> > > > the function itself safe. Perhaps the actual copy needs to be
> > > > volatile?
> > >
> > > Why do we consider the existing one unsafe?
> > >
> > > Surely, it's not desirable that the contents of the buffer are modifi=
ed by the
> > > HW unexpectedly, but is this a concern in terms of Rust safety requir=
ements?
> > >
> > > And if so, how does this go away with the proposed approach?
> >
> > In Rust, it is undefined behavior if the value behind an immutable
> > reference changes (unless the type uses UnsafeCell / Opaque or
> > similar). That is, any two consecutive reads of the same immutable
> > reference must return the same byte value no matter what happened in
> > between those reads.
> >
> > If we manually perform the read as a volatile read, then it is
> > arguably allowed for the value to be modified by the hardware while we
> > read the value.
> >
>
> Do you also assume that volatile read/write provide some sort of
> atomicity? Because otherwise even though the read/write may not be
> considered as UB, then results can be load/store teared.
>
> I asked because I think in case that we need atomicity, we should just
> use atomic APIs.

No, I'm not assuming that. I think it's like uaccess. Under normal
cases, it's not going to be concurrently modified, but it shouldn't
trigger UB if it is.

Alice
