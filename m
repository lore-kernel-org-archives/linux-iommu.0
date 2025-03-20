Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDB4218ADD
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512950; cv=none; b=nrNfNCjsaaFdJ6xW3Y+/xq1SR8FZyDJ8PEGcxp/PBFfE4Mh9LX/ZE2mIDuGlCaTTtqjvWLWqtC9Foz+CBMzqvlJ15oG0aP9A/Azx3Vdqvdn7uYsZlP2vNZ4PDOWxdzbBlz5DO7yjWLW9V2Bpmi0l4riGmFr7hPUwr2Ur0ePaxoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512950; c=relaxed/simple;
	bh=rsqeVDdht3L66LHZac8aylMcpBieGO2/hBxpHx2hDBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svUNUaZf6LSeaTw3MPf9/zW/er8GoXbu1kzlCPoMbWD8bZBJsjp/EgndkeBmNTbsOpYdk1MOgT9uOwlj21e54OOZd/0C1nz6XEndrecXE9EALB33XcDbzjI7WPYpH4jz7+d/tvHYWs46qB1eFK8q4qtBduFGNxOQv42E06XH1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1XLqevi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1XLqevi"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22409402574so3442125ad.1
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 16:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742512949; x=1743117749; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdKauJu93MoJRBBc3vto2MePH9Tt2mlxWo5dQZdkk6c=;
        b=B1XLqeviG5vGv3/PIdZoC9BO9M05znI1KcdHfN4r2uWTr5tcu6kJ3NVlBb2TEB7z/c
         92p/Q3G6hXfSLrGgKYiWDDcuDPqT6HQIzmAF9gzSzx1Lfr8JadENQHfRg4ibh5gOnj9t
         xYEsr+/BtgwrPWN5NjDgH5QSxCg0/GjUdjulox28sEPGfu8K71/h5CE711coLvQR/wYK
         u3LMK14EY2zxfkpVLyFPtvKt5Py5rS52yH/7dGXLNrmMtUKBoXvu9dY+PUXEAyNaYNU0
         BqkW5KymQZR1TgqcvQwalE1g1/xnsVnhMBmVnoAbHJBXH05snEJiCype84WRLmC5IZMT
         Ic9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742512949; x=1743117749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdKauJu93MoJRBBc3vto2MePH9Tt2mlxWo5dQZdkk6c=;
        b=ZfbeU+N0T3pXteoK8+YphfTkaTUlMElCh7TyDr6w7xjRqbsJJfBOU3XO/rrEmAm8X+
         ninYCpXi872T/w88Eh7ixBPHhgnKuMIg0KiA88+j05aQVSWnjYpKNEm4QWf+jtuuX4MP
         jraEx4PSjl86VfhKvUsC7fIi+UlmWH4/AczMToKKsaLowavOv9zV0Omj9Mz0nAsIFnpQ
         ioVb7NMVEFXyYMhQbaCyrwt+wJQwJPUnPyeJAx2Ny5SEI5alIjqenxnlQix3tjOAbG6c
         pVmhP9K5EpbyrsDq/Bl2e+Hz1DiOU5havKcUMfmD7bdtbb4mCboG1la9zTHYEBPNvD6n
         z5qw==
X-Forwarded-Encrypted: i=1; AJvYcCXljqO6nuyTEXvusvWJnVayqGdgbV5Eq4+Gic05UUz7476I52yAL8EQUZbdAcfCSQSSJ0zcmg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzsjtn3QqFlyrhvOOLRAU5SsO/Uq8QikJiWOwLv4mTlKOgpmvSm
	XPdCh6bbEkym4+RQQqk4meoKNfST1zuLIpOBR3N97FmslAnpowr6RGHOZpDyEF/FVK91NQM/pkm
	Sy24CallkbGgRFr/2SLtHLtjEJTA=
X-Gm-Gg: ASbGncuPS/XfDGLU9OAzJ4IMWB6gE+gSvUO0d2UMaIbgAX63WY8DD9r9XhRtjhMKNmR
	FBHi5Vqv63H6ac+L/gT5TXp1jfwoxWPiHZGIt3Mm9mbXDGs4wsZea7rRnxkv+sPrUyeoT+wkyEe
	jfrzfK0AijFXeaF/qeDRmwPEYP0w==
X-Google-Smtp-Source: AGHT+IHBYgL2z5SOF0wcGeJiLprNiblgwngPdjLO6Y46Kvg1U568ayZ1Q7zD3yMLx1qf5LEfFZGbpyKvtwUTOO2J9NQ=
X-Received: by 2002:a17:902:d4c1:b0:223:28a8:610b with SMTP id
 d9443c01a7336-227852b8081mr2510905ad.14.1742512948653; Thu, 20 Mar 2025
 16:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
In-Reply-To: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Mar 2025 00:22:16 +0100
X-Gm-Features: AQ5f1JpBk6Nt5QqSgaZxqHC41axRSzyVxdHhPrG_3P7bjcNOlmhVgpt7sAY0xjw
Message-ID: <CANiq72kAK84N-2ZzB1tKPQ-gwiYzE=QginDc1Fw4g7FBLDn4yw@mail.gmail.com>
Subject: Re: [PATCH v15 00/11] rust: add dma coherent allocator abstraction
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, 
	dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 7:54=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> This series adds the rust bindings for the dma coherent allocator which
> is needed for nova-core[0].
>
> For v15, document safety comments on the exception of usage on
> read_volatile and write_volatile as suggested by Boqun Feng.
>
> This is tested on a Nvidia GA104 GPU device using PoC code which parses
> and loads the GSP firmware via DMA.

Applied (up to the `MAINTAINERS` patch, as discussed) to `rust-next`
-- thanks everyone!

    [ Removed period. - Miguel ]

    [ Renamed Kconfig symbol and moved it up. Migrated to the new
      `authors` key in `module!`. Fixed module name in description
      and typo in commit message. - Miguel ]

Cheers,
Miguel
