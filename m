Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D721B207A05
	for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428926; cv=none; b=oqWGKqo1waOmmoO8ThfnY5H+bqqhlDZc4hVR1jqQDEriD1r+lQeyxoxsF2dMIX/YKXEg68amsqHm3WyixtEdL02jnOccb4oaatB6fcG9dLZJ7hQq498pC0xNX2fdkv26dkU+ggJZghjUKjKEi3HEZ/4OG/jK7LLp6IdejMU08io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428926; c=relaxed/simple;
	bh=xN07ANbvxwpe18nAfOdhYb84OF63vJkSZm8SlmmgDJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUbvRnuz6Vv3JgZT+NZdqi72pOv0G8I3jfLRoOalDgwpXeCF13XJbj+ZqK/FsZEkt4Pnt84NLq2qyJY5KcoZ/jAUJc40P2MBIq+0qpU6qrth44ph+fqA2xMsViN0HiEI9gkXU0g+IEtUfojaPrt0+c8uH6aKDZ/F0/dgv83vCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy7h8iYc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy7h8iYc"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-308f32984bdso4890221fa.1
        for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 22:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739428923; x=1740033723; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4eySdz77/NciwV/XfatLFkuT5QLK3ZdBGLRjELf2wU=;
        b=Vy7h8iYc5TMCFqKcOEjq97b6bPPl5oDRADHNgG1AXbgViZFZhkEin5H/BbNBLRE5o9
         BkHaqH/kBQBoVz6G0ylGwaf8B0k1EJ3UCpk24mVRw6JqublLEcEkshjuJd+DerTm2+61
         Zriq2tbam62xhIcV/poePdthr24EOxc4648pGAlOUCnDCHLHy4PsSg7UaI5bpsOly89e
         KhJw2a22KiIcKcX11aEAYJ6SxL9zTUUZSrBzYDljP3puPMXQQYwXOoWKUkymDW2nf5WY
         GeEvaX2ff34qpeCmrVbZT3fWySy65/6PxaK2ANz602fJOIhNHvijsnGjmlPADSjAO2ng
         wPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739428923; x=1740033723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4eySdz77/NciwV/XfatLFkuT5QLK3ZdBGLRjELf2wU=;
        b=Ko9MXg1HjnFWt80XkMtDhD29U1cbXVMmSRTEjjsTd32w8Lx3cQ6gULwv+aiF0Pm+z2
         78ThjvyhdnWNiWiaKRxphvW6uIfZaYkox2Dp+ccwGlrGZdgFDCI8cuziD2mJKpFOYM/2
         uUGWiqair4pvNaV78oC3h8iiUZnHQmgE0gmskife78zMfdEn0vP4xqP8XIdodY6QyIg1
         d623/w6ak5wjlL1006m2PX+GUKE8yDfMiBNq2zMNVMXM2t68JM71WWoME0WEIwEX9wEc
         4NHPKZ9UFFpm/QiCo+RlnrbmSOsYBb95pPvWJ7N/1Q3o4aVd1bVfmB6tAs90SSiYOD+t
         lBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWILOFb7i9RcNfhlJW4Mm657h3HcUpkoXxrRDxPqN2w8ivr+74yLuzVGhtrjsDxdxBlp1YkJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEfEoJe31WDo+ONcrjcpnS+Zx5IBXcuCsyICUJIhfmvwTO6xo/
	AbpgaYeTojuZfDeRwuuikm3RDV6mp4rKRCV4pwU8ECkUzrCTRxdg
X-Gm-Gg: ASbGncvfQXaOTleXcF99sfbKGdHTeha7Ilpv1+++ej75tJwefQrCMd6bEGjHUzO9qx3
	1BvNiRQl96fcjvGyfidKRJNk4Nt1e1RW5N/b59j0xOle0uEjTnGY3u1d3pQCO1suUtBXN1EXWfj
	e2InSdiBXQuaR8jN4JjVUeGP1IqzVyCLh3iMvOHWLFmLIRAPWlRBvat4GKUiyHUp+7HTYmSUtj7
	J84W8/tT1WotPRTIZTMxXitYRQcaebeAot6FLDudipE2MZS2renrnJbkDEBx7yOvgRKkINViadt
	yR89lN0gzbq7RZzxuXLvw5b1igzl2H5yTcBFomya29m2T9BoLLqHmHB6xVJlSA==
X-Google-Smtp-Source: AGHT+IHafetPTUW53JV2MbUCuHv7yV8njco3PYIZ4cqAW9TRqirM7GIDFI9zVzpiiAPjubhOhjUIBA==
X-Received: by 2002:ac2:5695:0:b0:544:ca1:da41 with SMTP id 2adb3069b0e04-5451dde80b4mr620288e87.44.1739428922511;
        Wed, 12 Feb 2025 22:42:02 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f10c73bsm81423e87.172.2025.02.12.22.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 22:42:01 -0800 (PST)
Message-ID: <b0efde29-248f-43f2-97bf-ab16b55af63a@gmail.com>
Date: Thu, 13 Feb 2025 08:41:59 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
To: Icenowy Zheng <uwu@icenowy.me>, Danilo Krummrich <dakr@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Steven Rostedt <rostedt@goodmis.org>,
 "Dr. Greg" <greg@enjellic.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Airlie <airlied@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, phasta@kernel.org,
 Christoph Hellwig <hch@lst.de>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 daniel.almeida@collabora.com, aliceryhl@google.com, robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 DRI Development <dri-devel@lists.freedesktop.org>
References: <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
 <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
 <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>
 <CAHk-=wi=ZmP2=TmHsFSUGq8vUZAOWWSK1vrJarMaOhReDRQRYQ@mail.gmail.com>
 <20250207121638.GA7356@wind.enjellic.com> <Z6bdCrgGEq8Txd-s@home.goodmis.org>
 <1e8452ab-613a-4c85-adc0-0c4a293dbf50@marcan.st>
 <07c447b77bdac1f8ade1f93456f853f89d4842ee.camel@icenowy.me>
 <Z6nTxks3u-ErSalQ@cassiopeiae>
 <d7d1fb8af8857e7ebfdea48213849ea9ba446477.camel@icenowy.me>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <d7d1fb8af8857e7ebfdea48213849ea9ba446477.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 13/02/2025 05:49, Icenowy Zheng wrote:
> 
> Sorry, but I did a fact check on this, and I found that the only
> "reviewer" of DMA MAPPING HELPERS is Robin Murphy, he has only one
> reply in this thread, and the reply only says "Indeed, FWIW it seems
> like the appropriate level of abstraction to me,
> judging by the other wrappers living in rust/kernel/ already", he
> didn't offer to be a reviewer, 

Robin did offer:

https://lore.kernel.org/rust-for-linux/4956d01e-2d06-4edd-813b-9da94b482069@arm.com/
