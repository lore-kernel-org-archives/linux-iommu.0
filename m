Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A0214A8F
	for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020345; cv=none; b=mz32CMYgbKJnZfr8EyMtp0Tq5tz7tQi5BVzMXmAoFWcnPGIqnEKB9akWsiwCoaQ+pzJlKNSKXOa4EoJwDCVUHmtxs5T3VaF17pU6VlQg5UK4xFE1qkZiqHoaiBwOGIFxqVyP1/x44Xs4VmpSXS7zDgYyjR/sSc3BkzpcuL/Ckw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020345; c=relaxed/simple;
	bh=S185myDo2AMGn9S4RJqk3PaBowolTa8UZ4RJKBp7e/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/6+j0dnvp8zDNrE0JPcjUlL87Y+Q2YWaxF8n8uwDUv2NJgxbJu3xurhYV5xPqn3eFK34vMX6TdbAGX1RvzmNCOB3BN6KMEOxlN/23JGhQN3kp07Ik62THByzdzxAwWe+x6j5u4/KvdSXGOrVttO6FsULCyjzsGr5B2mwFRRGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/OqUJ/f; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/OqUJ/f"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff53b26af2so47561a91.0
        for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743020343; x=1743625143; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S185myDo2AMGn9S4RJqk3PaBowolTa8UZ4RJKBp7e/w=;
        b=F/OqUJ/fvtMZmvLhsfe+zeJzTKV1eVX6H3ZFsvklBn7WXUk9YRL7876TQSeJx+ybnX
         356tHTGGYTMFQa5VVMIY+hIf+DEPWkrw314pcKc9IdArBDVtZruBdBLIsVJbIYdNC0fn
         HDq9YvgkQ8R6kIG5bTKE31PqjRMp6X48Uw3jSZ2bMdG1U0ya91pBhouKvAPlUqfn6uH7
         RDnDFYHqbgdezas2+UWVIAMrgXnhzLA68vA/s86TJ91cpth1jAK4tP00jEvlQMeTuvvL
         athT5ze4au30dwXomw+oDwp0eCdcO3zTcAcW50qrR1RrQxHwDwJn+Kf9aUigV2qalDxl
         Sl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743020343; x=1743625143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S185myDo2AMGn9S4RJqk3PaBowolTa8UZ4RJKBp7e/w=;
        b=gj5p1xcHhYAF9XNhd9ZuLG/FJ/+Cj14xYpHQBSXj01ptdXE1JD4w4VSH/KTYLQrB0u
         d6uANnpEXGBSBa/5JFjw6Jz7Lj1h0xtgRy73XNkOFybGhr+7CIVy+rq8+Lr03QjnnA5U
         bMsuT1SKsWhokEi2ck3lrLCRe5zADskJ10+Ydkuqd93U5FQe7kRCR9zROzIJ5o5YrqVm
         sp0Jn5FfpYomW2KokAqdS+hdZohsUyHkElAVm29g7vIfTYJpyQRL82kF3TaScYdNzbTS
         1PzUqJTASvG0+3kXHq354AGJqGMSQRCVtaL4XAsBamrmAgsBnHO5hO28Bx45To5DcpSe
         AH+A==
X-Forwarded-Encrypted: i=1; AJvYcCUQcTf/yiFUQuH6aeRr3oCtto/NQn1HzWM9Pv2yXenUr/j4T9Hl1wiV0nfNyOC++fWx6Of4ag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5gRN98lYKByF+Lx0VPyHt0uJxPAS0jRL4nVvjTXd/35dtnHCT
	I4IE8CJh2vshnDPj3/lf6lw6wSJ4eiViV5P6hV8a7QlPKq6stuvSJyDK2e9/FwPXvgJjUft7uMr
	BctVx/FCiHFE7BRV264fg4R4B8A8=
X-Gm-Gg: ASbGncv3DO6wPHf31ndmcvoVPQmYXSw6l7tM/YzkqpaUXrgs9T2Cv5+vAWgr7ZpaQck
	FrOhcmbCg4c77wjsYOeJVF2psgKVkrlElRkHl8iImTG8fAom4IPj9vRF760mACWrsIcQ8udQuIq
	19q3SilT0A3c18vBXxe7oZSAD1
X-Google-Smtp-Source: AGHT+IHooNIynvJ/u943r00EGtqP4V2TwxeklN98jKqPYPqS7Za6Xmz46LG4M8HzNRlfKabY+1aCpifJDwM5TkiPtdY=
X-Received: by 2002:a17:90b:3849:b0:2ff:6bcf:5411 with SMTP id
 98e67ed59e1d1-303b2111d26mr123943a91.1.1743020343400; Wed, 26 Mar 2025
 13:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
In-Reply-To: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Mar 2025 21:18:49 +0100
X-Gm-Features: AQ5f1Jr0Cr_g3Pyv5XL8DJRNCZ-jSVUqzmD7hSO9jXMUy3NigbrO3BofcVRIj6g
Message-ID: <CANiq72n6X5gV2rGB=TEw0jPdiw7mT79bdEOXHP30j=mRk92_NQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Additional fixes for dma coherent allocator
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: a.hindborg@kernel.org, ojeda@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, 
	"open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]" <rust-for-linux@vger.kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 9:13=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Additional fixups to improve the documentation and make the read/write
> macros return Result as suggested by Andreas Hindborg as well as support
> for reading and writing large blocks of data.

As far as I can tell, these seem improvements more than fixes -- so
can they go through the normal process for the next cycle?

Thanks!

Cheers,
Miguel
