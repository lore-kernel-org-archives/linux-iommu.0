Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876551ADFFE
	for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540953; cv=none; b=eXUpQPjkRIsUeWb8po1FdBNzq6ORgcpvA288E+BSYS01W6xbJrOt4uI+5hNBypCN2681/A1VKiOgsxkf+4VM2/JSBex/okhO1be1Y4HF8vRcqUZDGXbOZU91FUnLK4ERoIlMMpRGV6hzHn5eTl3lyy6GCW78NNVUpNEou/ktMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540953; c=relaxed/simple;
	bh=UBlzD8MynP4wtJMH3FouuoxGPAoh+UjXszE4ZLZb9PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ix5860vB7ZcC3t1W8RfQKYJMX8il0bvQc+bgbe/DyBBQFZ7zRMrgLUswbPjz+8sfnHdiUK9JHVUMVubVn2MaX1l8tJTTSCSRlXbrkcp2mLbJnGE2KWFDqZccL3Is7XKYW08j0SRqzTKo5ZrIdpECrE2Tr5gsg/Sf1j4LfvMma7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b48bLO92; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b48bLO92"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385df53e559so5070751f8f.3
        for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 02:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737540950; x=1738145750; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=We/e78Nv3R6LaJg7Byr6yv9XSyWPTTNeoplZz3yEeWg=;
        b=b48bLO922vQhm+tWA0oWpJu9aSumDjwADTIp/JwzVUihNTcrGjeg1YfTZB9JJEBF2W
         6YVBdYXHfRFOr0VMaCFukrVQ8GmVcyOOuACNB09VZCbaWGgOqpewfCGfHNE5AccvKgsJ
         uAr6phKTtGTzGTeB+k07TFfoCTCNEh/k2+lwpCfTcSUGxw1iMVMM6WF9ajiz34rIy2Qh
         sDrRG/50CaOVKaq5NCsRNRkfdYzj+wVxzj1vukOoh+pU5xvIW12pAGt2CqxYxQQonNcV
         2wJSLh0nDjaSQVyjDU0TTF5PaCrpeNLuXUPQzUfE2W37vI/Ql/71WqTSGPXgcqrdShXU
         bgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737540950; x=1738145750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=We/e78Nv3R6LaJg7Byr6yv9XSyWPTTNeoplZz3yEeWg=;
        b=H0jVuFAJgCTCNNwHNadpZn9JmNOcQ3NV7VT9c698xSyErd8agBSyTj7UQy0tCFz0zw
         bWpb3cIbEYNEnH3PREkDIh/NIDuuaEtWn1Z1DUj6TpRG/7WmFjPT8FTpwYoganjmwt9e
         dcrFd+asny37swrr3dGZjHAznR03n06K5C6EEBH/yGfQjEPy1s2dyiqFJMefbxBH2cwn
         ANMOTxQhrNuk6LMiGQDIduJqXiKSnMXlkISZ97Ntg68/QBJyW6SqexzSqr1IKmRjLt4I
         iOSUSyr4boZR3sIvJGCs4ewTUhqR0bKhtXHpBh5l4UHdr1FpMLHyIqgbw8Q5MeY45nHF
         cjDg==
X-Forwarded-Encrypted: i=1; AJvYcCXSGMt7oSj2+S8YFzrg1jtb1NiJbKnefJdZQEQ7K9D9KCH/3M+WHCbX0/erU2Ke4XuHnlwbaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7b5U93Vi9fAsDrTXlD8aZT4KYv+p2E+sfEFO31i7yMUrIusJP
	Jl13lbOhIjGWV7CiQ0Ycq785hgnumbtkV2oLBs9+qcZuw3gOfoOdbcA1eysp3F9dTWyGGsDHcuM
	EmMiZbky5xBlVV2tL9Kqw0CwVOE7WSoaxIKyr
X-Gm-Gg: ASbGncusHvfAPXcgIw9op5GnZkf+MWC0NBOg+zBZ/0xJ4eD/3nBbsITEsgN2nl/L7cX
	BVO3mlbGO2RVc8RWE1Gb04O6vRYiJF3cIhSLHl4iIGPzu7YIFnJV1N46GJptL7oYUNPdz1Vu2Sb
	ZdZZaS
X-Google-Smtp-Source: AGHT+IHFzm4euUAacp6gvYxVizLBMwIg5oDbxoAH60HayNsSmT+3Q7l6UofaUmQpPsbKH7EPaW0Rk6q0dXkawUrfJmw=
X-Received: by 2002:a5d:6d83:0:b0:385:efc7:932d with SMTP id
 ffacd0b85a97d-38bf57d2a39mr18199014f8f.46.1737540949669; Wed, 22 Jan 2025
 02:15:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121191432.1178734-1-abdiel.janulgue@gmail.com>
 <20250121191432.1178734-3-abdiel.janulgue@gmail.com> <CAH5fLgjVjAVwR+osD4ajKfyewdWPpkSyV+oy=ppaCULUdPqB7w@mail.gmail.com>
 <fb2216a4-306b-4635-bc13-10647e7cdb93@gmail.com>
In-Reply-To: <fb2216a4-306b-4635-bc13-10647e7cdb93@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 22 Jan 2025 11:15:37 +0100
X-Gm-Features: AbW1kvYHOBRoQQbvT-ruGTUBikUWtGUaNvOBrtbEBcj6jH7COvdJOr5ZaYwH_yE
Message-ID: <CAH5fLghO3eh4VWjSiwX4bqORBMC8JF6RyDQM2eCPg6On5Ti9WQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] rust: add dma coherent allocator abstraction.
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

On Wed, Jan 22, 2025 at 11:14=E2=80=AFAM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
> >> +    /// Returns the device, base address, dma handle, attributes and =
the size of the
> >> +    /// allocated region.
> >> +    ///
> >> +    /// The caller takes ownership of the returned resources, i.e., w=
ill have the responsibility
> >> +    /// in calling `bindings::dma_free_attrs`. The allocated region i=
s valid as long as
> >> +    /// the returned device exists.
> >> +    pub fn into_parts(
> >> +        self,
> >> +    ) -> (
> >> +        ARef<Device>,
> >> +        *mut T,
> >> +        bindings::dma_addr_t,
> >> +        crate::ffi::c_ulong,
> >> +        usize,
> >> +    ) {
> >> +        let size =3D self.count * core::mem::size_of::<T>();
> >> +        let ret =3D (
> >> +            self.dev.clone(),
> >
> > Calling clone here increments the refcount, but you don't want to do
> > that since it leaks a count.
> >
>
> You mean return the raw *mut bindings::device instead of ARef<Device>.
> Otherwise the compiler complains not being able to move out ARef<Device>
> because it doesn't implement Copy.

What I mean is that you should return an ARef<Device> without
incrementing the refcount. I acknowledge that this requires unsafe,
but it's the correct semantics and the unsafe is a consequence of
using mem::forget.

You can write `core::ptr::read(&self.dev)`.

Alice
