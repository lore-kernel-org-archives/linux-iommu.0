Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF943CB2EF
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990386; cv=none; b=tQmwbv2B/XXadQaoU/J+4rEn8SZPi8FGkSWWyfF4iYr7EiIi+nPrl+dZD/+Tew/9dyu9hzIMCMEqUzONqFOM84/D3IyJlrwGlkVQ+Jzji4vt5eMB9qAZcF0UPQGW+RmppaLjPP/yXckKhszl03pyWFm0rU/dewPh79Id1n56CJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990386; c=relaxed/simple;
	bh=hEjKsLw6JbLkC66BSkq1CjuR6SFo/HJNCc8wlFrl71g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PZg3ijmf2x3FN74Hvmtdg6MIln1C62cjZfbUPAGn3tC9mdhRDYE8IFUYWFrXg4qUBbBzA8S7cxmRCSLGVaAqIL5CIflZFzTyRiEB4z561IuunwDe0SccIEWRdtWSQLyecW+dd5Gmx9sTmZe/gIdWpfzNZrouUwYArZx3h4iubrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T1IpeGV0; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T1IpeGV0"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-493b21b1fe8so13162975e9.0
        for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782990383; x=1783595183; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hEjKsLw6JbLkC66BSkq1CjuR6SFo/HJNCc8wlFrl71g=;
        b=T1IpeGV0ZonrH2krw6LFk51tZVy2v42a1o4yxihdTwORlrx7zwohCqd6kjdPdYyP9I
         dAU9HC3pOUKlrlCHGJD+Z7McArU2AuN6U0u978suU+SdRGWe1Q0nFixPdbzpsMrNcxIf
         Xr75FAL0gx1GO1Qb9PQFM6lpw0kpQEdkowMbI6cK4LW4QZkm1gLzXw89XLsXQWdF+HXC
         cTKBC5WvQsWAKXXvb/4PPeva0EYymVmRbCW9syZl/ibpHhuZDUkOmuNKr1XuQw5gOmFr
         DGy7dI1xlcwJlhZO/ElpkQNGNLGegsANyOjY6pL9p0JyGKLXjvtxqhDE8ccTBziI4pj+
         lD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782990383; x=1783595183;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hEjKsLw6JbLkC66BSkq1CjuR6SFo/HJNCc8wlFrl71g=;
        b=ePKdnjaE84Mu7496MbpI3zJ0wo4KfF8bb9n4s052e9pzdxrsdSqKHtZ12ms+1RNtgw
         4ct7CoaPAM1y0t9TVrCY5nTwn1BiNQrUA78T1d16FmveQQ/pvnX5+4n71g462MM44lLk
         7/U+JzmiICsWpZo6D3qLNjdxi2sfMFoOySJlMdl06q5qS3jA3EpevFSYSPsF4MCClNEj
         tQyy8ltHRLvkJrF0ngB/ED4hcRYoVxLz9LXzmaHo8JR/FYMnivKq8rhaNB5AQ7S5VSt5
         76IooR3X3vf8kpw90abk5VaEsgj1YFyxKJy2N+oWO9T/2o5RrrTrCnxLaif/koEx2mTB
         wRMw==
X-Forwarded-Encrypted: i=1; AFNElJ+oMd7H4UyFzDujcyvY4TmPa7FmyNVEQFLjvXb659R9O/x4ddAgHMZR9hzmYTKRnv4EkFM/Aw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyACJmI1o4J2irV2sTXGmagOMfpqrVP8RKY/EdSV884HF66TrmF
	byRuXOBj9TmlHAt0Cvtb+7augqYalHEibPark/kOg3CY9i3LZvFSLYvWycf+qlXES5A+PoFghWh
	Nv1ingbSA/GmcsA2aDQ==
X-Received: from wmsm38.prod.google.com ([2002:a05:600c:3b26:b0:492:49e7:fff3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:26d2:b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-493c3cedeb1mr40482955e9.25.1782990383098;
 Thu, 02 Jul 2026 04:06:23 -0700 (PDT)
Date: Thu, 2 Jul 2026 11:06:21 +0000
In-Reply-To: <20260629201046.423464-1-nico.antinori.7@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260629201046.423464-1-nico.antinori.7@gmail.com>
Message-ID: <akZGLXnmUaF0XPtL@google.com>
Subject: Re: [PATCH v2] rust: iommu: replace core::mem::zeroed with Zeroable::zeroed
From: Alice Ryhl <aliceryhl@google.com>
To: "=?utf-8?Q?Nicol=C3=A1s?= Antinori" <nico.antinori.7@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Boqun Feng <boqun@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Danilo Krummrich <dakr@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	"Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, Robin Murphy <robin.murphy@arm.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Tamir Duberstein <tamird@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 05:10:41PM -0300, Nicol=C3=A1s Antinori wrote:
> All types in `bindings` implement `Zeroable` if they can. This enables
> using `Zeroable::zeroed` for `io_pgtable_cfg` initialization instead
> of relying on `..unsafe { core::mem::zeroed() }`.
>=20
> This change improves readability and removes an unnecessary unsafe
> block.
>=20
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Joerg, is this cleanup you can pick up? Thanks!
