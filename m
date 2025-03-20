Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B31EDA05
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514908; cv=none; b=aRa9NPItLFASQoFFN/NwMAG/qdlJCmXxyNi5wJHn1LffAPmajgFGiR8FYuNEPsMfwQiLeAw0Grk0/o+zRArjTB6UyGNNItN3OkxABW7DfiVQ6FQvpMfypVk/GgDK6KM/VcoH+lGAfaNoeqlX3Mzkq2mNwpsJLrIFK8OCwWZ16ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514908; c=relaxed/simple;
	bh=AxZkezrGAMX+pdr5euJkjZ4La2uvoa+PlC/XIA5YGqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmVBwu9OJbIUYEgVwIPM5Hv9Szr94QU9K6RddIr7xWjnLNdF5AL+mImN65SDi2hIvfg5RD58XC7+HbUHNyGuii4p9zJ4KhuL9VIECduqlc1Aq+A9CGw4+Nk7bui+5VXz/21y8iIpshc4BucCUS2yE0QnvlyuEchz2T5+2e3xMCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7Zs97tS; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7Zs97tS"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so374441a91.1
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 16:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742514906; x=1743119706; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIVIdC5d/C5Rmy+h10dq/y0QQVGBAirXrpPQsEqFxPU=;
        b=B7Zs97tSqrBO/hgB8eUQkL+mNfx4bNyHo7RT5NclT+ppoORvmKvhGbQ7K85tgs8LsN
         ukwRmK84ATrh/hHg+2dl6hvJ/+0TWT9Qea30ri11Vazb8Ir+L84h9vPkg1bhgRoJIBTE
         0l5wMPDuRp4L/hc9GQKRcAYbfrMV1p2lCZCMUW2I44wcURzCpRPqGJA+AStLHSvgyq0I
         sZV44Og11Wh2vmr/w0DB16e2VFsyHmo7bq4yj7ip8KK5kiGlNRlV3thqIEVflqV1OngZ
         +iPXfGWv1xvOOiJGTiUhH5PLcerw7v8EmRGriCxEq0IQIesdgQEc+z972jJWRJTGz5cm
         U0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742514906; x=1743119706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIVIdC5d/C5Rmy+h10dq/y0QQVGBAirXrpPQsEqFxPU=;
        b=B0fXYdU85ofTeqjrVsjZ4m3ue4cQyueeH69cJvEDfGm2iqI0ui/MYGf6zVpxM+m78n
         dWYFdOrHuS9vc0q+ZVNcE7dmWl6Dhz76BvY0quuxLKmnUyVmXtbMQilZiidzaZeH90zq
         CjJRkNcOOS0TL1wA+3AVVDTNZ7ekOrW2YB9AbOVuJIIUV03leEXX6Eks4vCa9wUb44Td
         pQ5GQ+66/Wu5WKMbUKGGNU2AFUrAMhDvnd/VCqKpygnlEDFc+MyMuI/EQKQn0dBsSJbd
         /DXl0+gVFF9BLH7mNvwn3c1WJCfi36dJzC8wRsjqrEEYA8bsxt6u3IiAumiGTI/6/ElU
         pkmg==
X-Forwarded-Encrypted: i=1; AJvYcCV3uaykGELhyd6KR6+U4RR3cZ/54npz3eqX81jJUnVGAo9xY4h2AIAUkcpdlpGRv0N1MVz72A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXJdosqMYTBn9M1PAksfOa275uONERB4hJrzovR14dJsoF4UDe
	EREa4KJhGbxueqwwa2VbZIfphpw+i09dNY+5y5kDjPE4gvZ56TtvWeLh5OCjfadxCMJl4yigXGf
	np0rj76BqeCiUqSOxA8jKAo+B+H8=
X-Gm-Gg: ASbGncs9L9+FxMmL/7JNXn5lx/EBz4cI8S43nUJ233eHyLkGCm5K8C933OuyqNx9SWt
	94onEv7XRmf5T0mHbKEVduA1mh+RualVFmYAkFni4so4lxrUIPQRGfe+WBaEQdG/hWPDcVtxZA+
	KB+Lu/2e+1/Kf4+SVOGkY5qaXvRA==
X-Google-Smtp-Source: AGHT+IGfdHlnzRHYSIHYYgHMKPdlv2H/Ji4j0FUvm66nHeooeYNFFQ89NWgA6dQ0Gwrv9F54A+bz7TOyVntbxcbywHU=
X-Received: by 2002:a17:90b:1647:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-3030fb1fbc7mr718879a91.0.1742514905986; Thu, 20 Mar 2025
 16:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
 <UiefwZ9WcVV7q7YyERsbNIYqOxTWUWEO9aZNxThH7uRFkjE4LDSUtaVdiLeShk_JYe5RJLD5MgFC9IxGUuzTEw==@protonmail.internalid>
 <20250317185345.2608976-3-abdiel.janulgue@gmail.com> <87senajxlv.fsf@kernel.org>
In-Reply-To: <87senajxlv.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Mar 2025 00:54:52 +0100
X-Gm-Features: AQ5f1Jq1ThF_jw6pT2v6peIUaC8tVEOnl1vZNqKRtE1gyTKcmgG-a1i82J0xr94
Message-ID: <CANiq72k_2dknw9CWj=yxMeBBrvMjPp5mhu=H++BP_wTVCHtnew@mail.gmail.com>
Subject: Re: [PATCH v15 02/11] rust: add dma coherent allocator abstraction.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, rust-for-linux@vger.kernel.org, 
	daniel.almeida@collabora.com, dakr@kernel.org, robin.murphy@arm.com, 
	aliceryhl@google.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:13=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> The wording of in the other doc comments is different than this one and
> the two next ones. Consider aligning them:
>
>   Hints the DMA-mapping subsystem that ...
>
>   Tells the DMA-mapping subsystem ...
>
>   Indicates that the buffer ...

These come from the C side and are copy-pasted, so I suspect that was
the reason -- they may want to have them in sync, so I didn't touch
them.

> I think it would be nice to have a description of what a coherent DMA
> region is here. From Documentation/core-api/dma-api.rst:
>
>   Consistent memory is memory for which a write by either the device or
>   the processor can immediately be read by the processor or device
>   without having to worry about caching effects.  (You may however need
>   to make sure to flush the processor's write buffers before telling
>   devices to read that memory.)
>
> I think consistent and coherent are used interchangeably in the kernel.
> If so, can we settle on just one of the terms in the rust code?

Abdiel has the diff ready for this, so he may send the patch (or you),
but for the moment I decided to minimize changes -- up to the
maintainers/reviewers now :)

> > +// DMA allocations potentially carry device resources (e.g.IOMMU mappi=
ngs), hence for soundness

Nit: I think this should have a space after e.g. or a comma -- I
didn't touch it, and it is a TODO anyway, but before I forget I
mention it here.

Thanks!

Cheers,
Miguel
