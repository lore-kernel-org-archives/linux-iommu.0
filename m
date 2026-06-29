Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9EB25B0A5
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782762362; cv=none; b=SuWkXEmJooetV/h08Zl5ORu5kw3NHW72sjDD8Vq6W/4OPCj/2H1Uq8WHqHUtjXCgklFHXMlpR8o5C4gacK4FP98snRgnZy+vuaEldy6C3X//ZWsZvwwDg407grPheBpjOw2KkAuUru53NUyplRpGtCnFyNmDaHnwEhvjxf8oBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782762362; c=relaxed/simple;
	bh=hY4JgavGrEWhCJWnwiRyUiQPfJQ1CdLm+cvupsbV5M4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Eb1E9Sw+ASbxZvfPL4EViSJFQR//QN2zz7k344e+PsgssuQcZKSmM9ENXf054tOB2i4PXDpyM6x3u0m5hoZmMKs3Ede5GhbNP/082h6vuFAd380pukya2WUnctiRwTRUQ15+IqmOvQnI2Z2M8dAFuVwWOE4bHNGUxHeCig1V/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU/O5H3/; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU/O5H3/"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13986d61b4fso5192388c88.0
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782762360; x=1783367160; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY4JgavGrEWhCJWnwiRyUiQPfJQ1CdLm+cvupsbV5M4=;
        b=YU/O5H3/FZWiCtQJIPoBjPF98Yf770fcZudk133B1o39MOqg+olBwDAhDaXZtnkH4L
         N+O1Wvb2zubZBaQE6ZLt+AOMyRZpAznQq+8/xyMINrQzFyUZH4S1PBQ0xw8ieA61KWW3
         /5XaNXzNXtjKljz76h2vHm/vYpuFB1qd8RkZGCAaHFPI8GLafhBcgxA0Zc62YdGUpKDS
         3xZ2MhY/wL0mUAUeUaFuSbkwbaY8BVg/85l5kh4mpwIwclNiOtEwjvk/h+fmLL1JXTZe
         Sqf6Eou7s/ru91DrmpudTPgeAuC0RLjoxIuDUiWjAzgbnVUeNvnG2OahSVnFz+yHsNuq
         sLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782762360; x=1783367160;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hY4JgavGrEWhCJWnwiRyUiQPfJQ1CdLm+cvupsbV5M4=;
        b=HB6rDhfwqSUFRmDnkXM8tQfhJ4QXrowfxxwBzWfQ3GZTMWJzyjYJrZ68ykPc9f6Fpa
         Ee+CJ1FK5Hke4dne/ykpstYiSc1FljhS0c/Egfor/vLqExA5gqdppkSQ/6tz2LrQj81A
         RAbbiu15/ziiIS5tczdM0q/v6wrjLxkT/07y04tolwXKW0qk5evN+cYwljUaRp19gJ2I
         WeC0mUbCj0nP3pQiGMw1DT88mAjHX4DK0fn2jbq68KsIUe2p/WQwtWbEjy5zx9YnEXua
         OjmXpdjtRjtikZvGaRrDfFIA4/PAio+hri7642LxsO7nwZc3RvihRwJjkaR79RueGeGW
         6UCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wTqDimX81oFpJjU6vw3KezSaXdTEjpwCZGoqD6Qe+7//JQIazocJQdhrdGymp7fR5zLrMhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhuNWVORY03oUjRIIur9xRKWjBQhvaKWfmV56wtN7u+8mjT0h5
	ycavzb6+hNjFTPyXZXxscZaiRkm9ya6o6GL/epZNk949TWK8TKWh2BI=
X-Gm-Gg: AfdE7cmtCxALS4flaNMj0P1XrlplnNBpGN729R6JcZmEssOzFAgDCgWILyLD+qj/Pg6
	Vv4mGV7BEfzrcyMSOJqlKnAP883+kaFudAMv2QEouAR92G56yJQq/82JILuiY/EAJdzWaOhws8i
	V1PhU65+35i0EuNk3AppJDAyfR6Pz+hsDy2s1XHUJ8O+WtIlNX2WBHpgZvYe3HlEFG4U+0wFQ3Q
	IyNawbHwHhDSRe6+8CIxsGf/ajTULZOvj2ZwP/0lyAoCerLAXQkaQyoPNxvF2RYEbbtHA7MjIep
	LR9W6sgfp8G34zPiQWsdT/BTEpdcEhFwxFSk9s/YVgul0dOx4xTcJ2QVko1OY31CoGGz9n9R5Iu
	S0XAYmuV6Xp31jrvHXFEAmfX1tAXTGgd5YfiKKR3S+j9kFh9yVzTfUo/hpmwMNR3ICehkw4ZIkt
	updAoNy8UyX3YhVKSG+V64wRMGLiuk+wajr4Xlf8xk9aq/zu/1
X-Received: by 2002:a05:7022:41a6:b0:136:e639:9c05 with SMTP id a92af1059eb24-13b2a1af5cemr407270c88.31.1782762360212;
        Mon, 29 Jun 2026 12:46:00 -0700 (PDT)
Received: from localhost ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2ab30047sm571436c88.8.2026.06.29.12.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 12:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 16:45:53 -0300
Message-Id: <DJLSIEZ5OBYX.APFOKYYKPU5C@gmail.com>
Cc: "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Boqun Feng" <boqun@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda"
 <ojeda@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Robin Murphy" <robin.murphy@arm.com>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Tamir Duberstein" <tamird@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-kernel-mentees@lists.linux.dev>
Subject: Re: [PATCH] rust: iommu: replace core::mem::zeroed with
 pin_init::zeroed
From: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260626203122.713317-1-nico.antinori.7@gmail.com>
 <DJJOZNFW51LZ.IKTXQ8ZIVO55@nvidia.com>
 <CANiq72kdCAyRUmXFcqQfkHpk1miG8Gagsn0_5U8p4WpKxv9d_g@mail.gmail.com>
In-Reply-To: <CANiq72kdCAyRUmXFcqQfkHpk1miG8Gagsn0_5U8p4WpKxv9d_g@mail.gmail.com>

On Sun Jun 28, 2026 at 7:31 AM -03, Miguel Ojeda wrote:
> On Sat, Jun 27, 2026 at 10:35=E2=80=AFAM Alexandre Courbot <acourbot@nvid=
ia.com> wrote:
>>
>> Note that you can also use `..Zeroable::zeroed()` here since we are not
>> in const context. Not sure which one we prefer in this case, but I'd
>> personally err on the side of not referring to `pin_init` unless we are
>> dealing with a pinned object or need to because of a const requirement.
>
> That sounds reasonable -- Benno/Gary, any comments?
>
> By the way, speaking of that: the docs of `zeroed()` (both of them)
> could mention the existence of the other (and the `const fn`
> difference).

If it is ok, I can send a patch modifying the doc comments to link both=20
functions, noting that the const version should be used in const=20
contexts/pinned objects and that `Zeroable::zeroed()` should be=20
preferred when possible (as Gary commented in [1]).

I'll send a v2 with `..Zeroable::zeroed()` shortly.

Thank you all for the comments!

[1] https://lore.kernel.org/rust-for-linux/DJKV3IQ0SXA1.30T5Y71AL6KV7@garyg=
uo.net/
