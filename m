Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE12594BC
	for <iommu@lists.linux.dev>; Wed,  8 Jan 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349393; cv=none; b=WDYraElmiJpiuNQKbl46v7MlV+d4oTecDWvoEuxgHRB5PYy9/i+SmZ0kD04qsrw9wTAOO1IT+ZupPHmHGLggKq7/86G3/0iwWiGIaP+HghUxvwQblR04o475l/u5Jb+BW5L0aOiynwFFx3t9TClh+uYp0ZEovUfJwR7sK0Bx1SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349393; c=relaxed/simple;
	bh=/eiXBVHDTwGJJtJlHteOUmsq2tGFc2YykiondSQFJKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iI128EFnTzQGUzED0iaG7Cpu3ekH/M8sjkl4ICvAxmuubkKrUibIYe25cCkeSVj13rgLQTlNtyNJenf43ZTEgPOcfrDcKXtx4XOjNc8IV6M8vIKDM7LU8dC4Ys2BcNWr9czU6Y8I4KaPHpewpzEUxxTP39JrOVF0VL7R5amPJ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC4gGoof; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC4gGoof"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee9b1a2116so3445560a91.3
        for <iommu@lists.linux.dev>; Wed, 08 Jan 2025 07:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736349391; x=1736954191; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eiXBVHDTwGJJtJlHteOUmsq2tGFc2YykiondSQFJKg=;
        b=hC4gGoofad8ixNG8Yj9YU0QEpsq6hVLS6wibrl2gApl4NMW9vvTPlkYZTyf4Z+adKD
         NNIHNbXidyBbl9SSBBgNZb4x311oHH8hr+ck2vRoFDBxhB5QhyiSlM1kTfA+GZ+hcw84
         bxwibsKH6aXuh5pPXueiQcxlFolObpE29BRMAoRao+CvoaWiElVlf3htDh0N5QjZL4U9
         6lKg+rF7k0uFYMtsY/bU+Yoz1+Vx4iFLZcbL2DD2Iga1Y0ykeyt/x1ZcRuJlZfAuLnkE
         iW0vT9c/Urk/TOq/Cx67BAdwRphH7iaB+VeEgt5n5AUi7XzeU/q91n/oeFYlFEyriU+j
         IQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736349391; x=1736954191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eiXBVHDTwGJJtJlHteOUmsq2tGFc2YykiondSQFJKg=;
        b=V/jf5T8G2MsFYwI+EIYXlgNytd3jG82NWrohSIW7jMIl9xIy5e6mmSW5mmWLfgsf50
         3eCn2ims96sSoQYjA2WvJl6isRP8w9jNUrIthvK/GwU9OsTF/oAb1WOQ999mW3O11okq
         uTi/6ZaO+X5hj1UbE3kkpxclCmeyL7ITV2qYvzcovFjxJ2K+aPM3ES9u+Mf3Rh6AB5Zg
         7QAmY4miMKBZqBe7Q6r1qwAjuVKA+OqcXp5y2XnRbqZ1sT7c7KmNuR4/E55d5kcEWvKD
         X2hZWqttGWEB911QBXuE4/FYG9SduhL1+C61zTdc/Pg43+P0EqpBrNYr1VwOZDxsbBhE
         N5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVIqe4McCBN3sBuewccdTJjDxyGfHeh8Q5WiZiSWDi8VlsMK6EiSSeWBB1fY5BaKcJ+cWdh4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRp/WxGUEJC4WwfS1SPleGWJ4EoSK0Q+GCwvLtw0q8lksQU4Ct
	IOtf4prfrlYk1xg0jVBa/PCsloF3Va72Xm/qkrv9oygLiA92ylEUVSlJMYkGb0u84t9xbCdR5Xp
	astsm93ovNxV98PdkyCET557//Z4=
X-Gm-Gg: ASbGncuB/Xoef9qfpy1GIO8i0Ms9hvWGI1qUea1q3dpu9tcv5T5FfEjSSfzykTgprDS
	WUYycqvGBnTHISOx5XUh1Pe02YsGE+wSMYb600w==
X-Google-Smtp-Source: AGHT+IHYSKFeCNvilE4F1uTmI/sDWQgh4GcbgkQPlcT30Ii5QRvkif1y52wxlNJho0Z+03oQIwxSVCdYCMjwHnxiEcU=
X-Received: by 2002:a17:90b:2808:b0:2ea:bb3a:8f09 with SMTP id
 98e67ed59e1d1-2f548db69e5mr1674633a91.0.1736349390695; Wed, 08 Jan 2025
 07:16:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
 <20250108122825.136021-3-abdiel.janulgue@gmail.com> <20250108135951.GA18074@lst.de>
In-Reply-To: <20250108135951.GA18074@lst.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 8 Jan 2025 16:16:18 +0100
X-Gm-Features: AbW1kvZxuTppS-rhRq1TCeSvgDf9A3MtNpdv0SsX_92MLs1JDa4MriVw-bUoNAY
Message-ID: <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
To: Christoph Hellwig <hch@lst.de>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, daniel.almeida@collabora.com, 
	aliceryhl@google.com, robin.murphy@arm.com, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 3:00=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> No rust code in kernel/dma, please.

What do you suggest?

Thanks!

Cheers,
Miguel
