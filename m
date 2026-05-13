Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C247AF42
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687315; cv=pass; b=jGmdrZ1T6KJRnAXXXM4NCGI1V1sGjlTAbNF5WNjh3VUI0jwZcc5m8UeLoZl7Q+PVSvii2FhBI7J6nqDa1lJ9QWzYYPlVLCAojpk44x40maXoOvCYTkWi9Wgo3NLu1uxgOWbO4ZD8jw3w1WcyC6WyuSrqIZac7d3qySbURK9o4ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687315; c=relaxed/simple;
	bh=9ViwzoXBatv2NUYDSl5OrZXZ1uGAyyzF2HcYq0vGdLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzU/KOiAeH3+BAxYCvLor9ZMN5AoFi56tUqPpPV8Q+OGOI925QKp9lPPTNPjtSEMN5WECsXZdjU7BxPC3Uw+STrBWk8hHIDzYLVfGeT6t1eg6CdbfyVrvtQpL0c3V9zQX3dFajS6xZ530y+fNMNHKMXfXHUTz7k4K6IhXbq/jlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXNOhnby; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXNOhnby"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f5879d63ffso373166eec.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 08:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778687314; cv=none;
        d=google.com; s=arc-20240605;
        b=NSiYVx/nk/1Te4SskJ3UA89ci1RHlANF1Rc07SolY08L5/9CgxQNr2t6V4bFLye9n/
         Am9nSprtNPNJRhNycH/xFOBL8AnFW1CIX6G9xkdLIFAzjOd3owE4gjTOqN2Y8kJ2pZbv
         xmGdH1//kU1pXkvArwr8pDQRG8yzPJjRCE2kzV+vDowc4mq5D4eLIStysXeO2xPcfDnj
         GBrR4yGV1xaUVTTqbjsDVlSFXibVVFooGoHTPiOU7W7HGbdSwVyRtTkok+Vb3/FHWeHg
         09hfGTe6wWX5l2j7tXXlrtK+ZFei/1/WHHAIZoVcNItfejREUEZR08Ea2m0jlL+ViEk9
         10HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ViwzoXBatv2NUYDSl5OrZXZ1uGAyyzF2HcYq0vGdLg=;
        fh=gdA3YXsj70KxDQUqMEfwWIG89XIQipofm4mLfViC5G8=;
        b=V4k/up8YfwOVCAbW+HJBcqjpons2z81XMtbt5obDGUmgtXLhbGJ1Jr6LJ1ywFOCytD
         R3kCjzppGLjdIIE9l/z+jji3yVLQHyvsODB4q/saN2s3VSCaRiCXxgIPT8ZPj8JHG6zJ
         5OeDPhR696w5KlX71BI4crLv5KyXEVKHpJt+/sMCigFRVPnz43atz04VrcLqcwJO7MwG
         oBnAHbPC8QU5knKZQ8PVGY+3Cu3d5LnnI4+Offhn+wFm2EHX/jm7+xRKI+q5Z/aF82ll
         SZslckhyJelZdXFwZHjlWQGjgQ7ij79VrZ+MZZ0dXjQ7/KIwxgSPFJAFv2OTaKoeu1Uj
         f1ZQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778687314; x=1779292114; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ViwzoXBatv2NUYDSl5OrZXZ1uGAyyzF2HcYq0vGdLg=;
        b=cXNOhnbywh+2E7NgAf2BzDI7xTJiegMPoKOiYhsj71s/CHwr6FOXwt3u44t05pdcTJ
         BNI2kGw446ryFq8Q13RTLO4X/CAi0hIwDmM2Mt1jEw5aJ24U+sHgveckHlGln8p645m2
         O1Lg3VjsBRwWngAu8LxY5hfNVNuloAcnN4tLtJxLXIyE/1jTyGcSukDf7oy2Jq2roCaS
         pBQmHDuJjYygZbg4fo6n0TSththAi+r0GU3kPOFvtxVExyyH2KnsB07PUi1cbQsEl6lL
         z5ityHKhC0menAWPV4+b48NQ47CA0T1A3f8k3lPIkPx4jUq7M2d+ClvMRP0DudxU5adD
         1l8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778687314; x=1779292114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ViwzoXBatv2NUYDSl5OrZXZ1uGAyyzF2HcYq0vGdLg=;
        b=h8qWL6dLHZPIIJGempmyEUpYyTnpdRji8kBGtrGgEwSEi6PTPsQxeXsW/Vr04JI5to
         nXElRaepclKi5vUlJqGxzjijgaNFI5irj0vLHZUfGA4JGm61ZBP7WXaIcazqDxjZu67e
         oZELehkDi/LkRSyDj3FgYYC4R1X2YkTs06dGR8RDlSVUzAYdmeu+nyFIvgYZlobN7bKO
         juVHbYbrdPglFluMEQ2h5aWlu/7ylplvzzJWD6ozIUoQeED6vBq/lPqChUD/xcxmcAwa
         9Z1yacIAZGKNfqgf2wqofxxFBorxEfdFQQhzdpKwAVb1UAk3V2Yj4yyQrrd/s8pI1yzt
         Aenw==
X-Forwarded-Encrypted: i=1; AFNElJ8m0o9Sy6wgxxJBiEU4YuWbRHahdYh3BrgP/IzOfyn/D7cfr4l17SU52EeibKlH4Rw+dlwb6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxhRsK63P3a8p2y4WK0OCCZ+0idJxpD5CRQRA3s3I6mQ7m7AOa
	xoBlFdxhQfjsizORe8getwrh2eu2uEDPZw184jyXfqYmrgk0+3Vv2qYDXcAIA4Tqw6AEJqURtx4
	kvEHFnaqlH1B7IWKdqcmUX0VLIyddhMFr1dgeEhU=
X-Gm-Gg: Acq92OGnVdYKGjRDFRw1ConcVFcR/GH3u02VBHTGnlrSjBDCH7YyBOoLgEsJXISuvL+
	jt75xN8dSLg3FdYznEpF82KhDrvGdOZpyRrqO93kcwSkAiLc6QTfeIEEXJe6YNWcY5pXfZEbkvu
	EWUI5IOPXGTBThCxg/PkXIdDtlNo/plIvlan1GCn+cNfPHuQG8wmuZcDeoFR9iwoLAdI3BS4qQ9
	0dwCqiwVhf1hcYjVBT+fOC+VP9C8BXwywxgZ6D7OeRUiJTyul9BnEfVMQK0XuAOkKYpqbC6mCpb
	kn2eEeSQHJ5vNGGazJrA6Fi7J3RWMsuLwB6kqoNpUx16mUPKtDEZ1v7sVR10teZRAu0C2Gckl64
	DiyZlhGQvcgfkKlzkPhMvJ3U=
X-Received: by 2002:a05:7300:e425:b0:2f3:3835:2005 with SMTP id
 5a478bee46e88-301198748bamr1226522eec.6.1778687313541; Wed, 13 May 2026
 08:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260513145425.1579430-1-arnd@kernel.org>
In-Reply-To: <20260513145425.1579430-1-arnd@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 13 May 2026 17:48:20 +0200
X-Gm-Features: AVHnY4LbTrmrS9TyU9LR4vM776F1M6zVZyBYrHuDnEqo4hrsMhud8cQe5uMH7DA
Message-ID: <CANiq72nbRw14wdZA4GH17K22Krh4ujB_wtuv9u5RQTGtidpq0g@mail.gmail.com>
Subject: Re: [PATCH] [v2] iommu, debugobjects: avoid gcc-16.1 section mismatch warnings
To: Arnd Bergmann <arnd@kernel.org>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 4:54=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> With some more experimenting, I found that marking these functions as
> __attribute__((noipa)) is both logical and reliable.
>
> In order to keep the syntax readable, add a custom macro for this in
> include/linux/compiler_attributes.h next to other related macros and
> use it to annotate both files.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

I double-checked that GCC 8.1 implemented the attribute in commit
036ea39917b0 ("attribs.c (decl_attributes): Imply noinline, noclone
and no_icf attributes for noipa attribute."), which also happens to be
our minimum in Linux; and that Clang indeed does not seem to support
it (not even a mention of it in their repository).

If you don't mind, please add underscores (i.e. `((__noipa__))`) and
place it after `__noinline__` to keep it sorted (the file is meant to
be sorted by actual attribute name, though some entries were added
that break that, but I will clean that and a couple other things up at
some point).

Thanks!

Cheers,
Miguel
