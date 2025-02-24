Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A87469D
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433229; cv=none; b=XiHrXuesj7CIRdaos4793vGjDkNcJ4n+Z8Z/fJU1FrIdZf4xrUEpKNxvIzhQJ2c7VgehG/i3svhKqT5DAJWs064OvOFwBgFpX4B91iyaQsDLToN+iVMqgzYG7OlSnKroegQPQ5jFf1wIifYL1vfjPpds0ES4uZ/cWl3GhfyA8nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433229; c=relaxed/simple;
	bh=j4TJr5pgfQZCXoZ395gNyQ2FKYY1YCKyx0JpsbK9COw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/LdsVe0X72siOLWHbZOscOhoDiy+XR2ZbfDVddmPLcDTe7ZdM9kG0170Tu2p8fujmsE24XUKA3WAYN+ldPUZ9VYMNR7UJYhM9+tGcSCNU/6a7yVq2Rr3JxkZOYAftiibrKAJF/doWZPynVtH2llnTizE3kgIkRd4lbIZU8GqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dX9vxFqO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX9vxFqO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216513f8104so11737665ad.2
        for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 13:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740433227; x=1741038027; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4TJr5pgfQZCXoZ395gNyQ2FKYY1YCKyx0JpsbK9COw=;
        b=dX9vxFqOGCz7NqZr5+lXO5cM0JjmPvKqH8iaPjgn9yxIiZXtDnJyh2wJLBo4gGRdyM
         8qj3YhlHGC81cWvlXJ7WNSwo8UDzBr7BDgIWobwcTFcd3cp/5bJs9KcumoA1FKesQe3e
         7WQFsGG+9mQ4aNLuJY0/k79yuHFzNvMYxAHSWcfDy3ghELiQ8Ehss167UiQUOfMDIYTn
         tRC8IYKXdQNMZvrVt3pfUk9cuUAqgtAoR8zvaX3SjiK3lKJXJ27N1EddML45HgOUUW7p
         nenb9MAc0HxHMqUCWHnSYJ2g4rTGHe/weDbiB+L5THwOa3dSQwxtAJ0B62fKVsdAF7N+
         3dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433227; x=1741038027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4TJr5pgfQZCXoZ395gNyQ2FKYY1YCKyx0JpsbK9COw=;
        b=ZHhBFG8rXB8CduvIzBIYvSDtBpJXyppjsxSYEfn9qPrJ/MUalwd6c6a8qh1ai2BKoY
         lvqeIvNntVuXo3RMc5+R464HPQkozlgkbmkU4VR6dYehbED9Mia7NngoRn3rEkQTAaNn
         +nmtS2arSWjD8j3SfsGC2G4Z/sn7DYLGgSvsMQ0L6eOb1QhrFP/WN7PEV0qEeVtJR7JS
         JbqKqnx1usoT1haoO+G8w4T59qRDc1xFD5pWcPnHng9jVAaymcLVjKrfKlqql2/zix5h
         aX+nVrOq+5ZevKMW/GmEyHnfb2Q7C50Mcm69gHFLQ/42Ed66YyJTx84Ndi5ETQ26ILnI
         RReQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo0fMDJAeFT+tLTHR1BbFGgaSf6mKUo7tvYDLC/g2ryH1pPDyqOzn5ll6WYLr+rbE+ubMpqw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyn/aoGu6rUAFxCe/SlZMdIBmPYbgKqAE8u3TRVFR8mhx1LJoxx
	ftLkgaybFy5U++GOLoDudHZsYSjySL+x8YSYNi7LwKhYzYcYTvaCRWxliNkcYx3hh0xnCzdi+Vz
	2zSZqlhU3lY07Tq9UmGL6Znx9h90=
X-Gm-Gg: ASbGncvsfUSYzeGWKfb8exx86bOjHu0yX7FFWLFOsc/h4nCYvYZVmyw9PgDTpcpFViW
	MYwWS53rjCSf8xODwa/RDRdUAIv75A4K2qS9zqbnG9JrPelDy1BrphSe2MHM073ltiIdo5EVI6E
	l1PvwsVFs=
X-Google-Smtp-Source: AGHT+IHKDKiWOu9mfM3EVB8u36Wl3Xtr59WcmIKE2AHgqhD/LAO8Qf2aJ9d3eAU1EfdN4ESJVQm8a1hvFMfytorfMdg=
X-Received: by 2002:a17:90b:3848:b0:2ee:cbc9:d50b with SMTP id
 98e67ed59e1d1-2fce7aef973mr9796954a91.4.1740433226744; Mon, 24 Feb 2025
 13:40:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com> <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
In-Reply-To: <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Feb 2025 22:40:14 +0100
X-Gm-Features: AWEUYZnNdDuBJ43hafoBhgYQAc3j-7xzFPpaDmZnJug_jBLZKCQgmTEDfn3yz6k
Message-ID: <CANiq72k07kN+x1MV=isMm-WUYrYd4O=6Zc3uACPp_r4JE63t8w@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Benno Lossin <benno.lossin@proton.me>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com, dakr@kernel.org, 
	robin.murphy@arm.com, daniel.almeida@collabora.com, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:07=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> I don't think this is good documentation style. I think copy-pasting the
> first line and second paragraph is better.

Yeah, sometimes a bit of duplication is OK.

Now, even if we wanted to do something like this, then at the very
least intra-doc links should be used properly so that people can
actually jump to the right place in the generated ones.

Abdiel: in general, please use intra-doc links everywhere where they
may work -- the patch is missing almost all of them. It helps not just
readers, but also to keep docs in sync with each other, since you will
get diagnostics if `rustdoc` finds broken links.

Thanks!

Cheers,
Miguel
