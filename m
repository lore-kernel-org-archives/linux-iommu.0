Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203A20FA84
	for <iommu@lists.linux.dev>; Mon,  2 Jun 2025 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748864462; cv=none; b=aE3ZgBm7ouqGHa7qf9mf+fZ1/b69ChmIaU2n+U2kJQRzfk6JR1bccTqhZ7ioDP0Xnb8J0g5Hadpg3rhrh65hGrN6LrtD/eqhPqsQ4HF449riuLzQ9bhYl+5lBAUNfIOj42tCwjKoiMjM5nWrnHScI+UA3K2KeHC0D827d+lluQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748864462; c=relaxed/simple;
	bh=U8K0uf4aWhhzfObYJoePKwQHyJj41+wsc7eB/15CdT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHeMnnaiYaoD0azu9hCARe+M+IqSaBJK5zH1MlLNgBSO0vnOQh13NoHZFFqKz/FYIdpfJc74jo2w2iHhhOKK5xASJn6qdbnVa8OaCT5NbZX6na5NvP1NseqZ3adkiA00dOqsPouS4r7kSOa/2kXOAWhPM9mqZeNn761r1FwQU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YK7jAZ3a; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YK7jAZ3a"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7382a999970so925630a34.3
        for <iommu@lists.linux.dev>; Mon, 02 Jun 2025 04:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748864460; x=1749469260; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8K0uf4aWhhzfObYJoePKwQHyJj41+wsc7eB/15CdT4=;
        b=YK7jAZ3a2IadNQc1vHaTEl1zV19uydh3/bku1mXz2+zaIj6BvNvZKSTSNjEuaR1WeE
         xbcmXWLefBUUcvxXi7saJ4m0FxBjSeDCujLHUlWasJx/qx+0lp5tTEjy2LXYOgkfRnDR
         xbE72f0XXf/a0Ns2BkpdbdsNx0hQ876N3It53c4d1bAvprSyUp4k3gTAN7GuQppKBcFp
         h+9Cuak97csNzIlyhazh3+WX/rseHS8pGYd0LKq3un2QMzraYmpHq4oug204oSm7Pbtf
         ggd4yFzjWO4my45M7Ob6k4hfDwY4euMxlaSkkYHTyOHIh9a9yN32skrUDqfpZJ6Ho0j7
         qh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748864460; x=1749469260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8K0uf4aWhhzfObYJoePKwQHyJj41+wsc7eB/15CdT4=;
        b=aaGzxmgTAlQkJjH3slTJ1d5I1bN/IMiRV/LE9ecyidimXiKK4ebcMMEXsMUgeAFKxC
         mArdZhuFciOZOv8uB9XZMDlubJuwAOSRm5FnJRI4vNSes6h8TWf2+/F8Wf4zRYlu9Ju3
         eJz4nQzh/s0rgF3zyssZVox8kqkzR0HZsLG5QElreADec9WNhG7kneNkZhWGKF7Nj20g
         R2tu7TbSSIJpY3owkFcOKz6ECA+3pG+x4Rt2lvh/QivOkEnyO7Qtkv48O733kWUTq9PF
         VRyvVLy0fZZhh2Mka2V7gJ1T87GnTLZMQtCB0EwEqgD8uRq3hr/VD+I2sHDXq51N7ep0
         J0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ/y0EF7Ol0+qYY0cxZ+tqpIJoj41VBVkAK1EaYvMnm+SY4rf0yQXlvvldPaGFo60MEviT7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFVAQijcfJRAg0bZ8atbfGx2O6txUakwzIs/7xNJuopONGq3i+
	v6wwOb8fucTZSRvXRCIrHXGlqtdLbaOS/qAOI3avq5A1emvMl724bK0XdUD5honWRADFjzOmInp
	mwG3v
X-Gm-Gg: ASbGnct1zJXOtz9c+tcx9GoYtJvAzFQcthDAlsQfc8qz/Oop80gor7PVC4S4rZ3Ubmh
	AlphNeSWoKmxCB+Vupf0AH//SEjuZucDRDeHqwwTiB7cQBu8+O6g3Hn0oj/LGyG0WUAacv3F/iZ
	AsNAATMkPFaVlIv/yaFya88svh+Z3ZA9a99h7LhuMfrYqrexwIWnjWR6xe1vq6z1BjhikGW8pQj
	bn81DuIlFtCd2K5oq/c9//PmbK0erMnSyVOKbLNmL8ByIwP5BJOuC5wgF56jErh6L6zjCzVVFf1
	Fjeh6WRUsOjNyj0810wy/mzHfoePBsks0LvHFSb5Bo9RCs9R/JeKAmHLAhoPlSJtYTo0WXBv56T
	TNvfw6KTy/jtPdcMRyYsiwfUb+no=
X-Google-Smtp-Source: AGHT+IGfF18ffm8VzY6ByMTGaYLJNsId5S1P2oW9/h5gR4uH/hdOQWknfp/QYUyMCIClWhNY/nUI7w==
X-Received: by 2002:a05:6214:248d:b0:6e8:f166:b19c with SMTP id 6a1803df08f44-6faced23964mr189368276d6.41.1748864448996;
        Mon, 02 Jun 2025 04:40:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d4d498sm60065976d6.27.2025.06.02.04.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 04:40:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uM3X5-00000001XQw-1BjZ;
	Mon, 02 Jun 2025 08:40:47 -0300
Date: Mon, 2 Jun 2025 08:40:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org,
	lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
Message-ID: <20250602114047.GA298147@ziepe.ca>
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca>
 <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
 <20250530141419.GA292183@ziepe.ca>
 <DA9KQF9CY77R.77PBMU8Y1FPY@nvidia.com>
 <20250530145026.GB293473@ziepe.ca>
 <DAAD0NZOCHS5.9FTVJIOI12QI@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAAD0NZOCHS5.9FTVJIOI12QI@nvidia.com>

On Sat, May 31, 2025 at 09:54:20PM +0900, Alexandre Courbot wrote:

> So if I understood your idea correctly, this would mean creating the
> SGTable and mapping it in one call, eschewing the typestate entirely?

Probably no need for a type state

> And the `SGTable` would own the backing data, and only release it upon
> destruction and unmapping?

But I don't think you can do this, it is not allowed to pin kmalloc
memory for instance so you have to do something as you showed to tie
the lifetime to the kmalloc across the sgtable lifetime.

Jason
