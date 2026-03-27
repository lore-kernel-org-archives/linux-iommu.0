Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17B43CF045
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774598543; cv=pass; b=FPUVb254HXVN0f4fojHAqWp8LePQJ0s67XxNnXJ4y/6BIcjVGEg0OsP/9EJyijXe3JcL2a7QnI1TJV9bcv9vjCFa5bqv4hhOcoemaRmGIGDOkOFzNW/T4Zet3HFfvpVQTSpNsY44H2NEu1+ACxxS5fA6lxp/phYjluEDKiyIi+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774598543; c=relaxed/simple;
	bh=5ep9g2m9wnZ/qw5uP60q9XJwKT04QFSPHpz8SR3TFGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dv465YEwSkNTq6rTarMqiUk4TLzdp5w3AGeC6/ZsQSklQWSNr5j4DACk+Yh6RKYEOocl+gs84dUSW36tDdhzUMz1+D7s7YQ7u3Ljl9qnnwmD0BkZjlmxkMTjEaW+axHpYG2yKINjcvjhGnULYc4OgL+itBeEzqH8wlZq8M8XFT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cf7/pcJT; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cf7/pcJT"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12711867ca1so128404c88.3
        for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 01:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774598537; cv=none;
        d=google.com; s=arc-20240605;
        b=a5f1Ws9kDKYtcfGgUfpzDVKMaAyozpJaUT7k4Xf/zL/6k1GYIfxHM9UIRd21cAPxij
         eWiUMiiL/BRltz1uscCJ9o+WVPY3cIwma7vr18F5miH2wio4vL2yFgg0uGtVQ+G17daL
         eI+qq/ir1sbO73bfANq+5/LhRFuSelnry/v+qiIS8sl+FdxshAPUNuYfU9GpKYZeKE5k
         zLiJeKljdEBzq8IJF960RPO/kMshc4fXo87w1kJbyX1UW48WxMhM0IGm4WEcTfBgquXm
         2vvfpZB89pGMTtXKiOb0UYRAqyoibecJE+cXoY6o/zu/UOprF+sBjrtk5jMLrIucw0cn
         TsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ep9g2m9wnZ/qw5uP60q9XJwKT04QFSPHpz8SR3TFGU=;
        fh=8GS95InNjm8zK51FmA5MTBZiLaz3JKDwtzMg4nGRlcM=;
        b=fEGW0w4DliX2DTIqJ/HO7FRnBXA63qOAoGvHjRdDrd6YRg8BKOhFaJ4MLHch1tf+Bm
         omG+A3xl6Xm7bTh1TTcFOrmhZyfVjVq0aiJgyRMuxbeXopdVBwVSk9T5ztZaRpyZXDLb
         81UiS1ZsXNNbOPcb1Vwyb0fnU8UyKkBF9XFyrliB7EoayXydvSMq5R0wSojYb5Axu3pA
         zCL48fRr2A1XG9DkQv88LPxFj+5b8qwljEVsafPFRla2fOLANc53XCuaRVhRuzMdHX/D
         shTavjv+iVEyb90NSSRIt75wPcgaN2BVXqxOtWRnJtuVyGMKdtMgrvk45vPlHpz7HzEp
         clPA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774598537; x=1775203337; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ep9g2m9wnZ/qw5uP60q9XJwKT04QFSPHpz8SR3TFGU=;
        b=cf7/pcJTCRtxfUCm7mWEO/UTfux5dofKFj+84oo2oTmSWia0zNPMXFv9XZoX79IcK3
         wRCzafTxewp00sLKT4y24peNM/GL9kAnfj0H3NtANDadUeitx8yuKsBeLpSyHEEvcUIt
         ifytY0jeruEMhmUBuAIg9fZyAV8Gz1yzTJYzCUM4QMqXftBKCSHAL69KkKL5geFaKIyo
         6MKvdO1tRU7sKOPRtP3QySIiV/BAbs1h85bkCZPj0qP5+L0fx+H6YagmldP6OYwO/oTw
         bW/YbYZXV4TdcWXF2Prb8isnRbUf1kQPxtV7jQRDhV4uORqWBAY9/CfPkYwOmxB1jRlf
         +9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774598537; x=1775203337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ep9g2m9wnZ/qw5uP60q9XJwKT04QFSPHpz8SR3TFGU=;
        b=kPGpdJ82LX9Cp6H6KvDQfkQYmWe4BVVKS5MAGky4W+Sd0U65FCEW6LgIqLTblnlsxF
         nxON+tLqi2w3L6LbfV/o2SgHlAUbbrFyGV7VLz6a3FwpwieT8O68uu+O6iCSFX1jLFv9
         wbVkX3AkDl+c9y1VAU9V42cQ46VVFAWcnvXJZzyJm+zjB2fysL6CgiX3ysmgmuSQH1Nx
         Qm8MtaPY1fZZQxEmMuwZsS+NgotNqLUIFNYxRdYYA24Lgrv/8wD15pM8/EUDNJJHBYKs
         6TVl5KZQtU/lGgQbbq4S9r3X53q4cf5x3i3pG+6saO57E7vJJbeC7UYf8kPHxugZ4Tcv
         LIhg==
X-Forwarded-Encrypted: i=1; AJvYcCVj+uLk1wFdhZNtEI3DpeLodiTLfP6w4fneB/7AJtUl4xMXmYRe1i8lbSWQ52EYquuBXWR2lg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxz/tOZuIXULDpEiEONQpOaZ70CpQ3+Xo6guPzDtzlFKGpYU1PD
	HZBit5WYQd7vwJYCrl8Q25RBDZEMe855QhFKbGHn0XrqgYQ9+GRs9OajmymN+IAdFMvYvnbqGiw
	TZLwBM/qu6oyqkLyn1dOsyl4qtQHrcw4=
X-Gm-Gg: ATEYQzzK8+zhPIvi935jw/j80KVgULSxMwT1WR+YTRTHIdW1TGNLQIhOh1NCL8uJHW8
	NNpe6WCTjTn7q80Zuccph3Xxjw+xjJYO69+eI4uP9s2m2TvZk78EY8eZaUNRbYTEAMDIhVT9RPx
	6Bc6hDuTnli7oHQvXZ8wHxPscAi3yBhSb2cy6gMo34CxZp1eZswEGJflMJQbvD14qSjFqaXHhUp
	a5iTojz4r5j7Or87kH8DibFOz4DeaWaTzQ1NCp5FSc25+6rICxFcc7lgfLscpruupZ+sgmQMrOI
	NS1cVMRaoLFNkYsZ0NDBTLdSu82uptKTgxZCdaS89bf4wmxPY7pSomvEg6wH84CeQW7FuoDCzm7
	K64nmc5e2dRQjeI/IIasBW2Q=
X-Received: by 2002:a05:7022:618a:b0:12a:6cde:fd0c with SMTP id
 a92af1059eb24-12ab2906c98mr371178c88.7.1774598537022; Fri, 27 Mar 2026
 01:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <20260322194616.89847-1-ojeda@kernel.org>
 <7ad8bdf9-5eff-4443-ad15-c05355d793d1@app.fastmail.com>
In-Reply-To: <7ad8bdf9-5eff-4443-ad15-c05355d793d1@app.fastmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Mar 2026 09:02:04 +0100
X-Gm-Features: AQROBzCrGdIlIe2CkDWKMkYFmP8XiqVc047zlhYRt_gjOqAGZtEWFJuOGnDO47I
Message-ID: <CANiq72nz6zB0jGahw4Eh-i-Rew1kQ0g_qcZ68Whw==MyjhYaJw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Arnd Bergmann <arnd@arndb.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Danilo Krummrich <dakr@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, 
	driver-core@lists.linux.dev, acourbot@nvidia.com, 
	Andrew Morton <akpm@linux-foundation.org>, Alice Ryhl <aliceryhl@google.com>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, David Gow <david@davidgow.net>, Gary Guo <gary@garyguo.net>, 
	Johannes Berg <johannes@sipsolutions.net>, Justin Stitt <justinstitt@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>, llvm@lists.linux.dev, 
	Benno Lossin <lossin@kernel.org>, Mark Rutland <mark.rutland@arm.com>, mmaurer@google.com, 
	Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Nicolas Schier <nsc@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, rust-for-linux@vger.kernel.org, 
	Trevor Gross <tmgross@umich.edu>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, Will Deacon <will@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 10:13=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> I have an older patch to drop CONFIG_NO_DMA entirely, which
> may be better here, since we know that nobody cares about the
> empty stubs.

In case it helps / for future reference: the patch I sent to Marek is
already in mainline: commit 2cdaff22ed26 ("dma-mapping: add missing
`inline` for `dma_free_attrs`").

Cheers,
Miguel
