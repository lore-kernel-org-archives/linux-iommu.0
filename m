Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A4C12BF24
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119268; cv=none; b=LS3+73/9ylAsQEnnJHoIJz748mtS1sHO2hDBs2pDrZTiP3QinZfbKAQbvR6lg1KKNw1j2q/m2PtWiIrop6B3ZYbOu64KD7fhNR7E5swe0bd4Rznlh3dPUiPLOF5Sp/8gxB1uPHX2r4jv5RodrJFQpdbOrUn04IRy3lWDAPopgDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119268; c=relaxed/simple;
	bh=411Ez4gUf+PPQ0Wkm6N8Om+ZijBspEASwlNOO8RTqbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHvGlDUAIUaKxp0zW6dexPhBje55yOxTV0115ZXnfeKaNl3hECbw0MhqoBLgrRaT8LAGhdiFEugji+Y6dmWfApQe2bFmlYlSjg8SJ04o93NKdJE9A4Qx//L/SKETsCvqyALFGuizld3Iad3N6TvnJs+qKr+vCvlhgPu9r3ypxt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Af5yCz8P; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af5yCz8P"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff67f44fcaso1041389a91.3
        for <iommu@lists.linux.dev>; Tue, 08 Apr 2025 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744119266; x=1744724066; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX26Qk5SatOtBLsQoeTiKbsjY4GKTg7m3OAXobasiiA=;
        b=Af5yCz8P3l+cMtlnZIqbhruol6LhpCEaS43HY0Su5LcJqp5Yi9o+Ai44U4/2sDp71d
         muNlGjxg8BOfI6VSzazCrGao6yBkxeaxCX3/9PBxcTl0s3mS/NRLqadiry+4IQctOBIE
         Wlzg7/HCJxJ1ozMlZMFDt/UigSImQYNbdtZRFMRBN0sU1TIF36kwLnb4l41rMrqdcAAE
         w5GG9xepNmYW7M7HDKHfRdol3dFaoFvSHhO4oI0CHqYl16CHhUYXWjk9MFfUmAnXyt/P
         WiAQdhzNODi670FA2p/c1SctUjex0bxVS5cl9czLp06G+Fw5O//b4YpMNDwsx2yjgkoI
         KjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744119266; x=1744724066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zX26Qk5SatOtBLsQoeTiKbsjY4GKTg7m3OAXobasiiA=;
        b=cYHwNUacn8jW1/bZZJkqIv+Y6Z66IGXS7UdqYVgPo0UhlP+WmgAm8lErqKHCUmXBBZ
         1xAzdq5kpE4WEnoTbOCTMk2dLPKM6jFljWAbXMUuun2ghqVRwjFoI0JMFUqbtagAinpo
         vKknApkGLkPQNJKFwgpxdvF99GAJ7O7lsUWPB/XP7Lf80VcYnWV2ybsbtGyIbOKEzgap
         VhKiZsZ5tF4NajQlcgEpegP4TJM5xZFb1t/fkygjBTdCXPcjycDMsPOkEIvY++UKh8q7
         O9+Al9HJIbu6GThZActjZ83vUxJi5h47RnVp8zWFb7JzSDFUSnYH4uMgBBsKRff7nHLQ
         H9vA==
X-Forwarded-Encrypted: i=1; AJvYcCWeF8gbsGqlNXF2eFRG2RD4QQMn3jUN5BDQkjHobZuvYvtg4/6JE+gZXdgvj4vBQbdwC5nUXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyM21NrOkcaDMiAgMjWXJJ1ZN64K6OP8gfJ1+gw1CMs7aX9s72D
	OB0qfOaD+mQIBhU87yBKpuGM06xoJwg1VMH1XlR07Iak1K8idnF/sB5EW+Li6jTNQMYK08zoL2Z
	j1xEasH/2PBKHAqVezMtaC3NzrFI=
X-Gm-Gg: ASbGncvL4xUweCbYBzaxQSsJhstEfmOgqTc6EUmsaU61UsJL2dcdaLOxadYSm9lF1mk
	iLdmC4QpSM7IrWYpcmMqkg+q+5QLCoh1aH0ZWOk3NJOKdqXbZQe7Drsa09BQoU5+pZNpB34ZsSx
	3FdtztPHMYMhpBK0xzUQnMipCq+A==
X-Google-Smtp-Source: AGHT+IHcq4EUgp5Iqa1qm+n+D0VL23C5HVqaoXE0A3FBJOcsRsJ2dj/ietDD7S4vT1adOFrbI/kcQWhlhS+m7NZLATQ=
X-Received: by 2002:a17:90b:384d:b0:2ff:7970:d2bd with SMTP id
 98e67ed59e1d1-306a498e230mr8715147a91.5.1744119266243; Tue, 08 Apr 2025
 06:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
 <20250326201230.3193329-3-abdiel.janulgue@gmail.com> <nujfDI6IKBsjlQtGWaMrhjZSQYYeQYckCyOUs9jIzgZGsP1WTalJE0sSg6tp_WMACWo9mzuDfpdzsIlmkKnL8w==@protonmail.internalid>
 <D8REH728BFP1.2BGE9DTRP2IPU@proton.me> <87ldsahlxr.fsf@kernel.org>
In-Reply-To: <87ldsahlxr.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 8 Apr 2025 15:34:12 +0200
X-Gm-Features: ATxdqUE0Cefmm1_5lUv9FqxWq5Fl0OBZj8JSRTuEMjQZc6JAlEH1sJXPGSEU63A
Message-ID: <CANiq72mahS0jiOHv-7RE8QWQunYo0bJqeGo-FAVoUL7v42RsoQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: dma: convert the read/write macros to return Result
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Benno Lossin <benno.lossin@proton.me>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, ojeda@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]" <rust-for-linux@vger.kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 2:40=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> But the `assert_eq!` would panic anyway if comparison fails, right?

Previously the `?` generated by the macro would return out of the
closure written by the sample, and thus it wouldn't reach the
`assert_eq!`.

Expanded:

    let _ =3D (|| -> Result {
        for (i, value) in TEST_VALUES.into_iter().enumerate() {
            match (
                &{
                    let item =3D ...::item_from_index(&self.ca, i)?;
                    unsafe { ... }
                },
                &value.0,
            ) {
                (left_val, right_val) =3D> {
                    if !(*left_val =3D=3D *right_val) {
                        ...::assert_failed(...);
                    }
                }
            };
        }
        Ok(())
    })();

Cheers,
Miguel
