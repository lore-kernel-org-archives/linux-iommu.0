Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF220409A
	for <iommu@lists.linux.dev>; Thu,  9 Jan 2025 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422344; cv=none; b=DLyFGTJj6v4bXuStMRyzUNYVDcWpVSzsiWTqj9eYEW/EqJQaAq5gvy8MmDHeKlS2UmUhC7soKeReImk02HZS5Ui+RzzZ8RCmpkj7ShFCZs9HFGS0j9HPaSgxCrTIrP4hYo1vKEdHPhMC4aMtDCUmJuEny7cmF2DS7efE4+XpctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422344; c=relaxed/simple;
	bh=nVhkBZokGKDkSukiiHPqu63FG+a4/Wbt8yVDBCJ26cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHu4qDDOjI7U+bEI1OLC+gcYpBO/GbLZUbhf7Nguuym5u4UYcScI0U8+7668WCwTpQBbPtGx+WlcSyETmD+Ol6yv2noQsbEWyi3QhHTd9ccqaT9zpcrzx14p0J+CDN9ou1umTRKwT+HMcIYRxF1lWWsSqzhg6igQc3IIzvzMuic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLt8GHpJ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLt8GHpJ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef7733a1dcso158244a91.3
        for <iommu@lists.linux.dev>; Thu, 09 Jan 2025 03:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736422342; x=1737027142; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVhkBZokGKDkSukiiHPqu63FG+a4/Wbt8yVDBCJ26cI=;
        b=LLt8GHpJqd3/Pdwm6GREC0xDKaQVnCZ8DS6GmdSLr9GhkNrwcRPEMH6D6vP2E56aIs
         Sm0ksvmTSEs0AO4/v9Ua68GZvcuS7UdAKpGKGAIPYPqkThuZPqv0HnMTYPSlnxrBamEg
         hNjYNhrg3p19P9+egS4WeBILPolNvc513OJclKRE1TiPht4nMp4lTjGRaTiMUcmvWh7+
         MmRv2zGRZPEME1MwvxlNT+modC/oswqVjFOoo3X6umeV/LEUUJxVrmH/6cG+0akgmP1M
         lRuzrroPZob9B2HJT00yA5VVLhOBuXS+mI1KzsK+dH3NDmanS+Bs2Etf2NxBWyK33aCX
         v8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736422342; x=1737027142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVhkBZokGKDkSukiiHPqu63FG+a4/Wbt8yVDBCJ26cI=;
        b=lEHMcoDEeuCvTVjrl0cIENlLxgV97j6w2JthCmlZIWGHgiA649s4k+S4Nkv9/Uc70F
         erXut5IDmr12ikeeeWqegMUEPR/8pdOBgfVqNxXLW17saN7g62XXLB919fmmbt0I0CPJ
         /d4qf3p8spcCcX/+4JTC78qtY+uJcmuREJz2lxhj4coFBIkIGINJLB0rZZn9+BrCjkIL
         GUi+x3oGNiGlEaFPYztLDGIIx5H5v/rVPHnXgu6URABopPqlwx44ya61Be48KRp5CfUo
         IRItU/iyb9OYFlDHaydP2J1OgNO7NE1ENq7I35Q+Dh5cGUoQhcxr34gBvP+jA+6FokJU
         B4XA==
X-Forwarded-Encrypted: i=1; AJvYcCWgnv8mNb4ynOW7LsrIyZ1TumwhkoTJikaRB+jBal9VUhhqhVoEzmjX1r0VP0OWo9HOdSzohw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9pDlG0TsqiUgc2W+4MOC30vKmGQ57HALb/rMk8ml1i6CSjC5e
	qCyfdMCFG6cSPc1bm0YGp7ifvHAyDwxfF/ME/xO3renU7jCkgaGaYGvF0Ibuc9DfiakBOHbfbzJ
	9L2uxhEkSYl0BrtgUYILBK0AcAGY=
X-Gm-Gg: ASbGnctLP21Q7sbaZnefRU5cyrWixZwrzzFBaYMk9QEk11WwsxqqujFCRiOYAsZVSiq
	d2+nw2jWcywX0twUtD58rg7ESXh/N78LeO0xCUQ==
X-Google-Smtp-Source: AGHT+IE/shgJQEWMwnSAOgDSXVBxBG6LnQBacs5OWR+gigi7A35ykUDDRKUNFZPY66UaplbSCcDRwhj3/GEPQrz+gbA=
X-Received: by 2002:a17:90b:5184:b0:2ea:853a:99e0 with SMTP id
 98e67ed59e1d1-2f5490aa11cmr3740159a91.5.1736422342257; Thu, 09 Jan 2025
 03:32:22 -0800 (PST)
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
Date: Thu, 9 Jan 2025 12:32:10 +0100
X-Gm-Features: AbW1kvZ0K55Hob8738u03bkFDU6-UV7p1gf2oIH6wNoo6iiosiSizzpCSCtIql0
Message-ID: <CANiq72kiUgLacBf9i3Dt+OPLZEyksc3s==HRp5R3EB74VuZu9A@mail.gmail.com>
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
> using usize as suggested by the compiler. Maybe we should stick to
> ffi::c_ulong return type for Attrs::as_raw() to be in sync the
> bindgen-generated interface?

In the past, `bindgen` also generated code using the `core::ffi::`
mapping, but now uses it uses the `ffi` (the crate) instead (starting
with commit d072acda4862 ("rust: use custom FFI integer types") in
mainline).

Note that in mainline, `ffi` (the crate) still redirects to
`core::ffi`, since we split the change in 2 kernel cycles to make it
easier to migrate. But in `rust-next`, `ffi` (the crate) already uses
the new mapping.

The idea is that you can already use `ffi` (the crate) -- so please use tha=
t.

I hope that helps!

Cheers,
Miguel
