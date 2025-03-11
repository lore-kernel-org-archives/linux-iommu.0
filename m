Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6FC25DCFE
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718163; cv=none; b=bI1pJdPJl6ShA8KlsdLAl/NNs87E/nn4DzrChD4JI9z/YNZQJvRjj5WRigNdD5OM1tmfMsbqLdbR+D1cVOQAcnuCoGp8Z64M5FUY9p+rwM+TBFPVDTOPFvH/tCjKqg5n3umNkOEE2GQUC91l2WRh4nZfvuYGLUR3yh+UCesJLSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718163; c=relaxed/simple;
	bh=mbgW0kUEsZezmUj5Gi6W94Hy08T0mYNvtx4ZiLvWeKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fB4w14iO1vhtw38x4e/R35HQpmXhQi0aYL7JVQzkB7hIAtQSy/TaBIeljl2hg1+U1cI+Br3HyLREVOjQ+SaVpiEt5Eu9gtynQLwvt2V5keZ5+3Yie3fOX9A9SR0EP6xOXbq8q1W8g26MtPKY8VJ0DrMe4N5DeHNM2xq6jrsdnHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KStS5CJH; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KStS5CJH"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso1524511a91.2
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741718161; x=1742322961; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbgW0kUEsZezmUj5Gi6W94Hy08T0mYNvtx4ZiLvWeKc=;
        b=KStS5CJHAj/Q14hF8LVfxOD9xrQDY4OANPTCMg7sjWN2Yd4LCqLt5DOsv+TlhOZzht
         LWtvs5P10QRQb3vvxD6oLMbWuNZjs4ToLHG+kCAQnJ2LaC0yuNkn7HeActwnrZ6h2bEh
         FGuxXiQc2q1XavrDuPV254I098QGSYJuGRj4vqzoAHRq7HbKK9B2VCjDOnJckVe8kEgV
         s12TTNUcclx8VjKczVSZUqb19HrCHjsQz7JMpL3kZ56ijuJKlAEjIfpmmJcen72olTeu
         AHpgFKm83FscBck2vz8jd8XYKZ9wWdhJZHIW2yMw7xn9S9i4rRzl7JWJ9mF4RL0SoIsd
         TAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741718161; x=1742322961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbgW0kUEsZezmUj5Gi6W94Hy08T0mYNvtx4ZiLvWeKc=;
        b=PrxK8OubDfjfOxnoqi45k5jAhaUjwlkDizaXhtz33QqJTKgOS6HX/AwVvcs93GqZKx
         +PpB1l/S7wdIwgDMSZpK1nTDxa33nckUJfLQC7F9/2AhbFNFXYBknMsf3nrKFYzzGW/v
         M2Q/SoxL8nKowqDjmmsPch7NMfiwJXt8fDN2dH0wJDX3mFBvYTk4vV28XoynC/WA0zKs
         IVgEl28GfEhjFOCbkhBcpTsiVAOT93Oyzp6S9WCm2Uk4P9YSL/frHCZoKF2F0jVh24q6
         WKdp8CfZ0mT8gTfOhPZwilT9mcu96NiEGW0MA9cA37zeTZW0pWzhgghtcgt7JqEoQ89s
         YN3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW//gJ/ZiFDN9j8j5+ROSZ99/9uLZvlRunhVbRRDAH9X6geEenznbOIpuQpOUrX/VGZhpIaZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUvm6MueB4r52sHOrfRGwYqvAeEXqzQDc1yFbTzjE8tLZwcBhC
	jbiI5xPUp+IgwQOIHCfb4Y34WpOIxt13/w+RL67e2Kj+bajJq/EgqA5tNioB3DEfGsTX2i/l9qr
	AkYDYLvN4ke9FdQZMUkHzXiqrG2g=
X-Gm-Gg: ASbGncvGJx+oS1Hf54ETzY7iwlUBVy/PFs+POmZ9wvZVckq8RNcIRQI5wKJKjKTTxyt
	iHNg/kQs6HPuG8wdgKZs/9jfus8swqMhe7n58GEPrOqaQ3bp9R3DL6e15jjUqd7Tgjb6XjykgEv
	mvy1oIurKuWnKqkqxyAibY6P3G3Q==
X-Google-Smtp-Source: AGHT+IH2cmOQn/pJuzKnwPkPIwdfjpLEtIQAgPQbajD24xzlPRIR8bojQrzEWciYOytCML/zIjTHthACjDXzOuP0bg4=
X-Received: by 2002:a17:90b:224d:b0:2ff:4e90:3c47 with SMTP id
 98e67ed59e1d1-300ff897fd9mr2311534a91.4.1741718160973; Tue, 11 Mar 2025
 11:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
 <nxaaNW1XIbhf7dSf8aRLVF5Se-0maF6BhX8GaUXlsOL-QOste8OMQxtmhYe_BYI6FYFEMeHEzy1s4OEy7PdGKw==@protonmail.internalid>
 <20250307110821.1703422-5-abdiel.janulgue@gmail.com> <877c5038i1.fsf@kernel.org>
 <902d6f21-a6c9-4776-9e55-26f089acd0da@gmail.com>
In-Reply-To: <902d6f21-a6c9-4776-9e55-26f089acd0da@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Mar 2025 19:35:48 +0100
X-Gm-Features: AQ5f1Jr5sFbT-pH3JLPyk4NOyAg6b8WWNgBaCLmj8KNaO5CgUCk4fq4OzPnifXc
Message-ID: <CANiq72njoQbMrBioohDQaUHixLa4u+1PKpQCoDPWTw0X5EhmAw@mail.gmail.com>
Subject: Re: [PATCH v13 4/7] rust: device: add dma addressing capabilities
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, rust-for-linux@vger.kernel.org, 
	daniel.almeida@collabora.com, dakr@kernel.org, robin.murphy@arm.com, 
	aliceryhl@google.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 6:45=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> This already uses `Error::from_errno`?

Maybe Andreas meant `to_result`?

Cheers,
Miguel
