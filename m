Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E0130E27
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481182; cv=none; b=GC0pUPetFg/gtWVzCKPAa+lmDGbe8Goy797HYPqYlmH3tbUdJPhyd2KdsN4QplupF+bol6Vnd67Cum+apXigaeUmniPu72yL0xsZR5fuMATIzUvCj1zxfLhYDKkHmIGEvxOyF3wX5tsz6s2+xRZkIu70wEN1fVxNnW+v4tKSDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481182; c=relaxed/simple;
	bh=M3z6WNgR0vo7LI2PJMO34phIbD2sqqEUOgx8234LZjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRimjfoECqCGq/ydreCjry8tqPsj8P5UmVGEU3QtWDIYiPKeHAmn7/Z5fevOrfz2HGfSimR4rzhzdIw1tpsUIjfuzChNbnWju2e/1mTnkffpPcIBKG5LdqzjBzf/L+06i/iKVGY4ULJili3aLzlbGDQc96zfgmLA+e2X/lv6kd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZP+ejobv; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZP+ejobv"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so8945732a12.1
        for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723481179; x=1724085979; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMl2h2APrDXrRsd54ATUVhJ1PFBmj4VZhJws35hfiaI=;
        b=ZP+ejobv4yI8EVh/X51W0aYuFmM9NM3ePZzoJ1acPF2mmxXfw2k01RLCdlkik6xcDy
         ZDjFWmX/XP36/144CkTyrBiFdK2z01ayFn/eMYS1hitPs0bUUbZqrCI3WkuYp1p/n+Kr
         dlqdLBS4ShfPXNWnqmk7+8+d7NQKtCZwLTdrYXcXCZa9JdHySIKQnN3SOUTjiUBieimN
         nlZTikjJJudH9tDg75iGwLy4fdAeMjUTSYWvGfmwkUtwG0EPjQ0bfN67Uers+M5ePGxt
         tsQ/8jnHUEPpkpHNkRFeNiklzo9xw5xePnlkzmliZTQ+8SjBAypB3W+lBxGqLp14XI/Z
         SYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481179; x=1724085979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMl2h2APrDXrRsd54ATUVhJ1PFBmj4VZhJws35hfiaI=;
        b=ojyDI5mqqi1OQvFnOquMdpb+haog2KKTYT0thWf9Zmjj2OR7kE0Z3/z01qQb0oSv9+
         L1rB+0ZG+EuZ4UGwcLA32orAZ0mNVCA7z2NmXmcnYke3HyGEmg+uoVqW/z8AGY0cmKUK
         K9zdTKwE6DEpuyIG+2F6X5MHBgWwqNiVncZJGddp6Z+X4PzKH7lgBe8ZBkB2L/Q1QdC8
         nGygBX3AmNAcfcJ7BMvYmDUfExS6H6M29W0wgvqEOrSvoMc+ZEw1ruy1+YO1eBi0fvcH
         5K2yvYpKtzKW71r941axaH0DjP4TcZtETqUwq/8mW/ZfHYgtUimweG1MEJZeTlNfxiAE
         DyjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrrvFs4Ok780dwzBIEsv3EUTs9IAxIfFWb92BBmHEG4K0nf5wvqZbgCzqxilIv4XaO1FUEyMu1hVEOSQY2BtYQfGxInP0=
X-Gm-Message-State: AOJu0YySfD6155TmnYPlLLvtDgVnv+hwf0c4HfMwNmrKWZXgXK/D3SS/
	TSfGoBpS0Xo4S05AHLujbqoP3pU7YCe6Ka1DGexqKtZ/qRdju0XyErJGXX6+J3h5a8RmkER+o8c
	YEU1utsBMqxzn3oR4Lsaw0TyR0lJ6RBSmEEh0
X-Google-Smtp-Source: AGHT+IErXfwiaED0+uNIcxVdV3hRK93+KUYrGzUzTEqPiKHU188LSxGEfoMREZR7DooTohUCAwFxrLXqRq49aFc9eNM=
X-Received: by 2002:a17:907:c7d2:b0:a72:66d5:892c with SMTP id
 a640c23a62f3a-a80f0b2f797mr21895766b.18.1723481178181; Mon, 12 Aug 2024
 09:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240810005911.684644-1-yosryahmed@google.com> <20240812083218.GA3493@lst.de>
In-Reply-To: <20240812083218.GA3493@lst.de>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 12 Aug 2024 09:45:40 -0700
Message-ID: <CAJD7tkY-JNgGXMGEcQFCfzqSNcmCZj=yNV6O1GMnOQFR4KEx=w@mail.gmail.com>
Subject: Re: [PATCH] dma-mapping: use bit masking to check VM_DMA_COHERENT
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, Reiji Watanabe <reijiw@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:32=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Thanks Yosry, this looks good to me.  I don't see a real urgency here,
> so I plan to add it to the dma-mapping tree for 6.12.
>

Yeah no urgency here, thanks for the swift response, Cristoph!
