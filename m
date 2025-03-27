Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C421AA1E0
	for <iommu@lists.linux.dev>; Thu, 27 Mar 2025 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743118752; cv=none; b=puxb2gsoT5kLwaY8vnKkIG/YZQZyhJzDi+Tii6KyGad4jnYkC15rkFMpmwAd3fpXLiZCL4YqagpnksporlvOJuQL5G/2tZT6imllAoYFxOmclc3ME+vwR1lx09u3fFDcWcPPMa7OsUbdPojPHmFFeBowIpS1+WC1lHuoLq6YJ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743118752; c=relaxed/simple;
	bh=Iq8fkabNznaIKVeBv51mGPlNivd78e3y64yDdPnKcec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dtx7KrL7oZtlLoZbxaR/Ze01/JfjQcyEOdWKzk+EzOY+3qCG5q56KsAigYd4yU80qb5WFIT77suyi0itc+ZX4ktmOXOXLtLc9KdraLjkN2FJgIkRM2L/yAdcsudLuy4Tu0P+FIQ46HCoIZ4LaGKCMElPKTFb20uQzV36e4Y6FZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9/pn8Mu; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9/pn8Mu"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-301a8b7398cso293930a91.1
        for <iommu@lists.linux.dev>; Thu, 27 Mar 2025 16:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743118750; x=1743723550; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnTm9UiQ7+ij4sa2YfjCODEx8vvL8uoupOxT8VaFfk0=;
        b=N9/pn8MuwC6OeHsGYU147CA3uvxDaJD2HkfB8xmF0prq6nvwsA3MU1kVNSk06oqBGh
         1D0SPFcKC+gHutV5DRTGNt/w0FairIxMZByHfug7PIIIQ9ZRVWkftTeqqaKdZIAe609N
         YbavFA7Hl9iUnNrjyO8b1EvwHNvT287bZIUcPAnyxw5s/Ch9EGQGnfNEcH9yUjeaqf2O
         SEyOwGJPTMadByhCuilxEI/k3jqRyW58Au9+77/qPYJQMpJ7u53VGBa9TMDKSx9FuRFr
         b4+VqWGiDSow3ya+8EPqkRYeZCGv/i1FfC5vXzFNvxNu2AzrOtKiKVYGIP/1NPmOq3N+
         jCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743118750; x=1743723550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnTm9UiQ7+ij4sa2YfjCODEx8vvL8uoupOxT8VaFfk0=;
        b=lSmeQiUoEBE/cv1myZ/iDLc96ZhYIS2uMl/6BxzmeYbl8ZlMuBZm229vk0OF1rrxPc
         dJHpydXjcCj+K/NMSUwExoq0FKRmrOd2UCtvzsDsHwxH41WvDFCA9eeRYUbK8znL+hah
         zRiCkqDzbH6koJ32wp5IMPBCsfptlV6coEZWFxmGyyFreX/iTWgY8qlcoyIDFjZwklRX
         yKCVFS7gFBheAHSVgE71V+byBzfPfmmuCUk5B4tPI62HBe54SEFNqOM3P9Np1jB8Ztms
         sek7TK6bYRNZuo397Ksxq6rhDuKJdBQjk+XwiZhdu0yiieW+wHWLlGxv9DIetv+fnUNT
         oH6A==
X-Forwarded-Encrypted: i=1; AJvYcCVtrMxcV86xHgBF2v8HTN4h99ql0AgNJ7aKq7YSYq9oXWjPg1avNHXbrkV+VmpRJUqMfIfcTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFwgNpZoyrPI1OqEKpmvSsshzy3oRToVHteeo5R4/RzrolFrsz
	9eJP6q7XiaOOLovjRAsLI6kDxqZDhfpF6xdif6e/k5tGh85rZmGR/SA/H4yXSgRutjoDn6SUcFD
	LNDXPO2c17UjcXaDIpgPmzCPTtbg=
X-Gm-Gg: ASbGnct18uYcHcCLizBWJgWWS/Ir68WkKYQ7eIXBASIzOaJW9gWiZlxbR5RJ0QsCBHp
	yZbR5Rh3/U/qZrC+g3VmhSopknOasgqf90OZQAsLd2PHsmYc8wE2bJN+PU2G7/CW3CEZC2Ujtzl
	DHld2Q7y4vc4IStD+j5UqOrs0CYA==
X-Google-Smtp-Source: AGHT+IFGPH7qzBCfMvdFKrwYS6D6EKhSTXgk16xQ3JW+Qt49nZJRd4wkAFQo3rIxPuebsYm8NveXG63pCmMfMmaKFjU=
X-Received: by 2002:a17:90b:180d:b0:2ff:78dd:2875 with SMTP id
 98e67ed59e1d1-303b2754fddmr2818380a91.5.1743118749669; Thu, 27 Mar 2025
 16:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com> <20250326201230.3193329-4-abdiel.janulgue@gmail.com>
In-Reply-To: <20250326201230.3193329-4-abdiel.janulgue@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 28 Mar 2025 00:38:57 +0100
X-Gm-Features: AQ5f1JpO0ix6LGGpIw8NmovhhECl19xyvqN09h5Zqra_u1faeMtSnDMnIzxYki8
Message-ID: <CANiq72mwp6=6PHzwaenovuJ+emW+A-wmun34oTUJQFd3vPV_zA@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: dma: add as_slice/write functions for CoherentAllocation
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: a.hindborg@kernel.org, ojeda@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, 
	"open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]" <rust-for-linux@vger.kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Few doc nits...

On Wed, Mar 26, 2025 at 9:13=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> +    /// Due to the safety requirements of slice, the caller should consi=
der that the region could

Which requirements in particular? Link?

> +    /// be modified by the device at anytime. For ringbuffer type of r/w=
 access or use-cases where

at anytime -> "at any time" or "anytime"

> +    /// the pointer to the live data is needed, `start_ptr()` or `start_=
ptr_mut()` could be

Intra-doc links where possible.

> +    /// Writes data to the region starting from `offset`. `offset` is in=
 units of `T`, not the
> +    /// number of bytes.

I would double-check how it looks in the rendered docs (same for the
other method) -- the second sentence may be best in another paragraph,
i.e. outside the title, since it is special in the rendered
documentation ("short description"), unless you want to e.g.
differentiate from another variant.

> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`
> +        // and we've just checked that the range and index is within bou=
nds.

Please indent the comments as you would the docs -- the docs ones are
correct, and Clippy should check those, but it doesn't check normal
comments, sadly.

Thanks!

Cheers,
Miguel
