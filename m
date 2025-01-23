Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFC613212A
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737641960; cv=none; b=ppQWpePq1pgAOG433qSSXtyj6WyjrmC5XwLIcMiYtVUA7u9KmxcQt9M3qe1HBKY7GWSlOm52DBA7knMfj22gonrAueniysL2nWnhqNnUfTbmjzS7oQ77a//0ocmskPBJ17lvOAwUzPzQmfM/QBOEzQpzmk8D/FvwSq7AFcMT6Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737641960; c=relaxed/simple;
	bh=ji4tTEhSLgmSBgEcBwTGc8IM9lJoFcK7anuf12T/Zmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmRsyFT4mdyojGi5k+DGzGdIOrhYlzTo6ZeIXTkZQfmehToiJa5kdU76ZdS8S41DyujFRy9hGuEbF3FZyC/I9dse/j1ETvhP6nPqnMotGE0MlDeVZTY2oaij2opz5zd41ZvkaZv6quLPE8gTJOKUHn8h2qEilDakXwyz5Kx8+u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VykGUylI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VykGUylI"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef05d0ef18so241990a91.0
        for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 06:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737641957; x=1738246757; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ji4tTEhSLgmSBgEcBwTGc8IM9lJoFcK7anuf12T/Zmc=;
        b=VykGUylIVyhepmJsPerJdIrcgokyd1/kDJgxww5cLNQmtPRsoiRcr39VTc/U9XkDwJ
         awXRIq4PbzlMHh2xp93gDQVDgQHE3DOgUHp/oFffHjBzK0o7fabnlyp6BIHGm8Xouc9K
         1+41pu6x0JegmngcrJBqFP8TI0Jt34YAZXRo9VCjDAZyR3XpxKaMClLwcbGglNSjKsGt
         dydlzltp+KsNTFpqfT5eYCCXWYUflLAHWtJwKTdUa8Dq+/wwkc8PCTBygZT6D0MrxJpu
         yUIwj1Xl5Fi4NxPS8EkH+ra6VlFHom4rSuKG2j8H2vQ0v5MlndyYTF4+9q3RGwEitUog
         cvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737641957; x=1738246757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ji4tTEhSLgmSBgEcBwTGc8IM9lJoFcK7anuf12T/Zmc=;
        b=ZWFDSspunuRWyKbTgMm4ps6XQ8A1H0XHAzD67IQubAtz3PFk97dWcJAtuWKgYrGJJ7
         Qn9VuBdCoU1OL5QT7IQwE1hkQ/QX3qsrSFoyMic1mYWNhwlk6FAG/a93zIvRfmcBWbRK
         JT/Z1iOlm3dDYGg5L6DnZOZKG2rcTyARhmJ4SReemaSvcRC7ne2mVadpyNwogwhiCotO
         UvhI/jmnaDMkaClkvkJ5Opjzj9OkGwYzbFN69FRb0btrpmZ6FD8VTTwTHbVHoUNPU2wg
         tgEs54LaOeEutC4x2TOIsNYLue2WUpdTsWf7rQKY0qbauYF2h841f/59VA5yZViIGm/E
         kZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdPhTH4rIg89OXv7cmyBYROqWUTJ6du0aaAwlrY3cVGdBgaXMCHklgE7TxRoiWC/MKgU4cKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzMClCGA2ylyelRfUvxNflCIbcyJYSTVrc1MXSSwm5MOrHfdGi
	x7r/fIPaaz1vWSMR/3Wlx4RhvGHSuid7gshX4XMwV8VrmD/44Rw2Ax6fW97FD63+0qm3ZSKaTPt
	B/CW4SS9HT3Y83WqAS25vkxXvOKY=
X-Gm-Gg: ASbGncsioqExdbRt9ljfRRmWxldUGxtwzxFUKHszHga9D59qkUnX77hJePBIhSLDhbX
	phBQ7JBblfPc01Nq+VXxDapoulY7KZiQM+O3JBa0Op5bJejh/piJyQMg6yCHHXA==
X-Google-Smtp-Source: AGHT+IEiX3B+fiUvSiB2OtH24g7/Gu7iV4fyzLSr7O4UcXxuypjzs50iGZdIGgKom1U0urfBGCq8zf6E3bu2aDzD0PQ=
X-Received: by 2002:a17:90b:6c4:b0:2ee:cbc9:d50b with SMTP id
 98e67ed59e1d1-2f782d35946mr14250865a91.4.1737641957557; Thu, 23 Jan 2025
 06:19:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121191432.1178734-1-abdiel.janulgue@gmail.com>
 <20250121191432.1178734-4-abdiel.janulgue@gmail.com> <CANiq72n4cgutTCcVa+Ee4jnsELxfmCrvotZQCVO8aQ1J3ppTNA@mail.gmail.com>
In-Reply-To: <CANiq72n4cgutTCcVa+Ee4jnsELxfmCrvotZQCVO8aQ1J3ppTNA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 23 Jan 2025 15:19:04 +0100
X-Gm-Features: AWEUYZli8zMh6ToryzCH5GpzVr81ucB_RtvG5XoQ05bjOveUYIBPzvNwGZvo6I4
Message-ID: <CANiq72=tDyTtonTxb5j4xK++0XSNtdvo6vkKzhPNDn7orW4c-A@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] MAINTAINERS: add entry for Rust dma mapping
 helpers device driver API
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, 
	dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com, 
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

On Thu, Jan 23, 2025 at 3:16=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>

To clarify: in case DMA MAPPING HELPERS decided to pick this initial one.

Cheers,
Miguel
