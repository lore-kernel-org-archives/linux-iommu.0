Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF8279DB1
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782762678; cv=pass; b=ca8ozhzq6a4kBLbqWTIY63S/ON5XvOLUtn9+f6cB22si8XXG7tU4PYAMPTwEwvWjXDez9uAMnFoY1RsQPesHLaQYaYSS8aVfpOq/7Y2/hcrWLEHkaZ8mtmQ1UhJS8sJaXYBuLGs/+rYTNbDcgIqRQtNVEPt4WHKSF8l5WJDcwqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782762678; c=relaxed/simple;
	bh=GYvQZtHKiSZ9Cl/h8gn/k3hLFG3jFxoOR3EaXdOu6tA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4TPbRR2bR26m/yiq+bM3uBh2izBZhcQR8Gn3aG5qP5wc3+hoC8YMMj3TKS9tVl1Dgz2fAVNsGN+vC80yq0TDlfQF15Woufoj9S9TWKeCz+GiI1Ytof0UJnKuGIjOj7Y/cENIFqQE+GwKHqKCtCfAazKTMV/uN/HkP5InWySESY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFoWu06P; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFoWu06P"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30ecc2e02e7so96737eec.2
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 12:51:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782762677; cv=none;
        d=google.com; s=arc-20260327;
        b=G+GF/nzye9R5/wWjtNOdIH4kJFGS+v47g22/tmPwVUqFJHVJxoX9Cmiyv1BYX6hhF+
         rPeyZ+/0/FJwfZ4Z0G+9vIuK1uh5O4RWM1NBT+CxPEc7REod7rm+Emi7zOFZoviPc2L/
         K/XK4X2/0AhPM2xw7Rin8a9mDofIF2AtCqzpEp2JqwaEyy1PvC4TXZN++k/754cUqfMt
         H0qXcSFDATK4nkNmzJa64mRA5BDdD9lFEsTYS+tOMs6Lm9pwmjBv6hZVwY3U6DV0bzvo
         wYrYNN7owKaq/R6DUmOWu1DNmEJ5LDySJZm8rcYT/FCCop0fPhX1bETf7PcUxCS+WBTL
         gQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GYvQZtHKiSZ9Cl/h8gn/k3hLFG3jFxoOR3EaXdOu6tA=;
        fh=JHJbmup7GJ+9dP+AO9IYVNtRFUt2aLSARuiJx5H0SwI=;
        b=Zr1lpVVEve/STymZ6EXFvPvizonnuXBdy5YslaWBE4XoVTv9jE++dDiW+vyer8IT1Z
         hWMPiMCRq6fWmKcPM9f+lGuM36ucnk8bqEmClx8S+YHjeUoWQ5jB16FL3ANqg/1VwqZw
         7dEUp4zvppvhRiUeYbP4e5jJOT1A+OVCxoXMjjlXUt+eOOpPRcEodtGLAQLcTAuSzQfm
         hsZwI6F3tEPYjkszVh5+mc4A2o2H8JDB1yptmJMYAbVeau1iHA4nSEJXQUDGEFgl8K0Q
         4579AvVaW8CDQE+X5onl2NJ2Vk8ANTNpP7rbyhgCN3A+AUaUfskdCmvff4WDekSM45mB
         kPcA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782762677; x=1783367477; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GYvQZtHKiSZ9Cl/h8gn/k3hLFG3jFxoOR3EaXdOu6tA=;
        b=mFoWu06PCvo2hGrKM9+Q/QdkZIxoHGWvz7QR0gT3o4hV6im9mCGrqrNddc8zNPy2Ci
         Vb1Kw42kT5rzT5jaVNgyWlcwnaR8wgNl3/MGxQE9VKg2XC1alDrN9U+qJH3nKSUQhPCv
         6eBvgwJu+TLcabmHZt6S9fwrOZ9mHFxCcSRwu5dNJDbSilBh8G7heNfW91dYmyx3EjuC
         Q3zlNPB/DDHVsSAtmfTqUIMGSuPZTEb450DxCZCjNVWlXk3kw1z6K79jsQik42A95okf
         XeazRxLPHWnGi3uz807RHyJO/cxF9AE9xZIWeqVXpGCnZO+7ibeMxOUq6Sd9lbZl1i/m
         oV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782762677; x=1783367477;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GYvQZtHKiSZ9Cl/h8gn/k3hLFG3jFxoOR3EaXdOu6tA=;
        b=R7a2zdjBErLarL6cLPb+BdOOdHGSNiK+oX3k/IWj99j1NA/UKoV6NWE05RuE0dNW/q
         vjtHUrgHI/FMtvHlkh42U8RWPoXNCd+r/uEjyJY7R4CrSAuXg9QUvZbu3k2rqhg2XYwi
         tiDjPYQDeg+OU8R89GX4Veu5IwNqwVlD4rWbjQvlSkEoLOJdKKcJcAS/8qMqM+O19HDB
         rgo95JVhGQCbqhJi3l0STnOu4gvUz3oXOyBzSI5FQvhS4lhF4gowRN0o1D3Vf5nCPx/j
         u9Fo3zxQhy3a3YCgzGwpY+1UnRToFSN1y4A5dYJeyJERjOOIsJk9MUtaWX/4wWq+m02+
         PRiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqElZCdb232jHU52F50d59YY8KSJziA9cNOYSU7lxPLo1iu5b1pomQJo1oK5MkddWOhqNvJNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxB3WWYH0mKhKNbe1UnTGeEgF08qzQAbzrSGPE0G+66miq6+b2N
	I2y5gyHxUyFwzBnSLKVv9VpM+2dwh/eXynkARQNtCeG1MusqCQVuOpsfD9VSPxF7LNzCE1O2O1d
	/awSqZSMsPSU27sUn/QkBRWCJm1TbaQg=
X-Gm-Gg: AfdE7ckWNB3oxKJGGQqK0J04A87RfvzDfw5OJLq3HVn/8vZ3bfVRpJkkpcTGYkpS7Fl
	CmNCp3gJYeHFR7Fc+3vJH2vVtqIb7k3ZSLgWZ7rvhwSZ+V9Zz/uc5bZZ3AxDuNTRwTT1FFjzi5E
	5nzhaKT7oN4cm0p8h4Fl9cCOmXtjcwFqDqXZyLYEBWZeheUqUkO/6jkKmLhdFFDIvPFZnf/N8go
	C0eTAoLaOa6XZZyyIoX94Kd4c8gYzWASw3xK7HUNTkBOOXE+38THBab63ygcTv07hiOPqVqfQrh
	noFEKDyGBecUaN7RCXlu5pH2m4RA1QZ0v0YIrIWcqcg5KvM9nPAejAKXYKoApnlivxiexLhK46j
	YYzYGF31M/KlcVG+bnnWflBY=
X-Received: by 2002:a05:7300:3f27:b0:30c:6a54:3fe6 with SMTP id
 5a478bee46e88-30ee147fc23mr224426eec.8.1782762676955; Mon, 29 Jun 2026
 12:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260626203122.713317-1-nico.antinori.7@gmail.com>
 <DJJOZNFW51LZ.IKTXQ8ZIVO55@nvidia.com> <CANiq72kdCAyRUmXFcqQfkHpk1miG8Gagsn0_5U8p4WpKxv9d_g@mail.gmail.com>
 <DJLSIEZ5OBYX.APFOKYYKPU5C@gmail.com>
In-Reply-To: <DJLSIEZ5OBYX.APFOKYYKPU5C@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Jun 2026 21:51:02 +0200
X-Gm-Features: AVVi8CdBhkO1DZcCDL2isjLxHOFx3Y1StSa9vQ4O39-R9Hyrw-U-_JqScw702ps
Message-ID: <CANiq72m80vip+hz5RngvgH4VxU30amzS-ePr6KVKwKvhf3=Ycg@mail.gmail.com>
Subject: Re: [PATCH] rust: iommu: replace core::mem::zeroed with pin_init::zeroed
To: =?UTF-8?Q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>, Gary Guo <gary@kernel.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Tamir Duberstein <tamird@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 9:46=E2=80=AFPM Nicol=C3=A1s Antinori
<nico.antinori.7@gmail.com> wrote:
>
> If it is ok, I can send a patch modifying the doc comments to link both
> functions, noting that the const version should be used in const
> contexts/pinned objects and that `Zeroable::zeroed()` should be
> preferred when possible (as Gary commented in [1]).

Of course, please always feel free to send a patch (it depends if the
maintainers end up accepting it, in this case Benno/Gary, but sending
is OK :)

You can also send it as a PR to the pin-init repository -- I think
they still accept both patches here and PRs there, but a PR there may
be easier for them.

Thanks!

Cheers,
Miguel
