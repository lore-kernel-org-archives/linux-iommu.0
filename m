Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0BB202C43
	for <iommu@lists.linux.dev>; Thu,  9 Jan 2025 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736421571; cv=none; b=kG17tcBzqUaqhiKXqni2ObwMCZQUGI3Lcfs42Q3HNlqf/+4HiytC0W/RBcRr3kv97lVLx8AM5oW9A8NG5AIHaZdnF73piJsF/DyFxvWAUGgVOL3sbcPdsk2KBg0r8+kXDhGAQyv/Cvbzrju50VQMjqftlw3c9ZmMAyhoQ/gVJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736421571; c=relaxed/simple;
	bh=k/DfcA6z5g5FTGXpM1+l4rX0cbAydG9yBg51pwdwSmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hipOGeOiFLx5AjTy/9zvm2e/ydEGVJb81mXh4/jPFa+v5YEyzU5qQJ0FX/0IjqEeuZR1mFS3JGmhiGQ6vS3346w9sA0WsxAIKSA6xlRMp9beFhxB3z8n4e/VQvC2U6OcUFqtZxZQD5l27TZoSZiTRn27SVScHHv8415V8CaI4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG6Za0Mh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG6Za0Mh"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-215464b0432so1440605ad.0
        for <iommu@lists.linux.dev>; Thu, 09 Jan 2025 03:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736421570; x=1737026370; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aY2UMuBv8sJzTFh7RfbXt8aZXqQ1c9aLbAqpoKARsw=;
        b=dG6Za0MhpSwi8QjrTU3LAesOqq/BkzmSjJimRLm0GrlUv1VoQJ2SUuO1OdPbML1LUD
         nB8hgVzJTlM/mZh8loIXk5bZZ7geb0v9ADZu1ERDpVH7ct7Nm+9mHqGgSshemi3isPae
         EcvfRPskL0AHgeOTdessw6moEv7XaF5k//aXWJHF0vT7i0cKKhIqqjhTdRPsYwZeftKA
         G7YEnbLw/GCDP51l2D3Iertb103Bpoi9gtdxKLfgHZKckXZrujfJXxRNQ8svSUKbRgst
         4TNGWhagyEf/X+a6yLGpcBWg0TJ6sVKZjYxP12ORjkMiocH4LKS24SeSy+7XBIaOnxlC
         TCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736421570; x=1737026370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aY2UMuBv8sJzTFh7RfbXt8aZXqQ1c9aLbAqpoKARsw=;
        b=mzDV2kqdYSAEzSlVCiEizYwfi2DUAMFuezp3jKUVuqtHNkrkXl5cRNypjlx3g3FnCY
         ozXgKMlN5qaRk5RzzmybHNTJZnw0aJoMxgXC9EUf6L2PXkmjIX2jgdGB86Uu9o9jM/wr
         LaPHrYpezJhn1ZXX1hwdTgrXVcaP1uPqqTHE9KyvMQbtPFwoeNycMFwNNBwa2ydEhlsj
         IJJnb1NyI65e4+n7MeWK3hX9sUcEH94W4AqCelb39keecKI1cNZO2+dLYR7sXQnpCfNx
         y+6QNN8y7s1y+z3iR6UTPNekRppwRd9sJ9XS2ywZOVqOMCD3+atK2krHHuvw4xDZDqHc
         WWuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLKeTfHeAC/Mds9p8m8ugk20Xm9oObzAlQi3wa9W7o3NYXXnjGtrkS7gbz1aUXxZufA2YuQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeasvsqbFuPnjLrtrmswrisAbPLq9AWkTSujv/0kS8tqWPPjKx
	mZwY8fcZHNOMmhDkUzElipatDs5pOFHMSohplnOvORXgfMIXaEVmQYzaoUv2VKv6PVp/Souv2dm
	hTZfkQqVTLHmvPq1xtrq3zUBeCp4=
X-Gm-Gg: ASbGnct0ouFO/HrPVas4fAovIro9zRhUcshBLJRZTLALgOc0Ol/sA5LeaTpCbBb+3Io
	6F8bQ8BgArJgzj2gvlgsv+iSCE2HFLvij8iXnbQ==
X-Google-Smtp-Source: AGHT+IHrcgYUBLMmlYxylpm95UITqP4dQZzRkvbslAA/EC4z4z4X9/gABkt8qJaM0TQSOjIN8MWqpTEz0GWOn4EaHEc=
X-Received: by 2002:a17:902:da82:b0:212:52b9:156a with SMTP id
 d9443c01a7336-21a83f4bf8emr35587555ad.6.1736421569622; Thu, 09 Jan 2025
 03:19:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
 <20250108122825.136021-3-abdiel.janulgue@gmail.com> <588af6c5-02cf-437a-a909-c22744a6df1c@sedlak.dev>
 <EFC67281-5CE1-44BC-92A5-7B0E4A7FB6AD@collabora.com> <ba95a574-2dba-4299-9ec4-bb776a228d98@gmail.com>
In-Reply-To: <ba95a574-2dba-4299-9ec4-bb776a228d98@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 9 Jan 2025 12:19:17 +0100
X-Gm-Features: AbW1kva68zZFGlXmw9UihK6c1-7vnS-T1tp728Bb7_Az1w-2EAb1zsHdt_OFhDo
Message-ID: <CANiq72m7NrKB3MhKT2gS7TwdL=Ug5LbLm1Z35NvApgYz=cuCiw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Daniel Sedlak <daniel@sedlak.dev>, 
	aliceryhl@google.com, robin.murphy@arm.com, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 12:14=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> We are interested in the last argument 'attrs'. For some reason it seems
> ffi::c_ulong is defined as usize at least on top of `rust-next` commit
> 0c5928deada15a8d075516e6e0d9ee19011bb000.

We are moving to a custom mapping instead of using `core::ffi`
directly. Please see commit 1bae8729e50a ("rust: map `long` to `isize`
and `char` to `u8`"):

    The following FFI types are replaced compared to `core::ffi`:

    1. `char` type is now always mapped to `u8`, since kernel uses
       `-funsigned-char` on the C code. `core::ffi` maps it to platform
       default ABI, which can be either signed or unsigned.

    2. `long` is now always mapped to `isize`. It's very common in the
       kernel to use `long` to represent a pointer-sized integer, and in
       fact `intptr_t` is a typedef of `long` in the kernel. Enforce this
       mapping rather than mapping to `i32/i64` depending on platform can
       save us a lot of unnecessary casts.

    +    // In the kernel, `intptr_t` is defined to be `long` in
         all platforms, so we can map the type to
    +    // `isize`.
    +    c_long =3D isize;
    +    c_ulong =3D usize;

Cheers,
Miguel
