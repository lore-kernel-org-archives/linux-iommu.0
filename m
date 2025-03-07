Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24488216E30
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346288; cv=none; b=AEbfqHnOfAhxXFNCMqetMTe7n5oN0r84p/GXv7/ltUvozDoQJUoIoKlT3h6OcQkV4HeLLZDU9kgX1iMhK0+hYrzgP/gCK3RZOaDIrfJb8VbkWDhJV7+g9/4ubqjndDdE/kg41MHW1L1UUa6Bs840UbQ7PaGvnbSNYg6LFltAhFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346288; c=relaxed/simple;
	bh=aV2N+gi/KxHt+cRDpHyCOE0yhPBLPVwL0fDQFadQGrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qtX86Z0Y55mE20kU1YhLMtFGzhcyEN0PtU0JnnztCP0aMbgq56rKYrGaXPiEd3TKWj9nGIFd3aadna/KxOlT9wef5eiRiN6AF1rxKosGlL2dB31SIygiJM6RJBDDDjzYmPYBEqbSr6Pm1lA9jSbBCEJWAD9a6xowKHLCiPjHems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0c8Zk8wb; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0c8Zk8wb"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bcd9a46feso7603895e9.2
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 03:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741346285; x=1741951085; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRLcibLkNuqSJ4oebIn+gemASecItzRG6bVok0DbXQU=;
        b=0c8Zk8wb+jmS5rRjxtF0x5oReKknnrQBwIytw7nRJ1PrbmiklQGMYcpCr5XaoMltbG
         PS+W+5VqJ3koL0+W5402GO1mJvC/I1vhFxCyJNmwEJQM8AhfCXfnJtLitaztGjCOfnUL
         VOO2xwCEnZzsYi5wS/n+hKjkoz7Wr4Aqu+H+eXB/E8r/xsjLO5gC3O99HaCKFxRE648y
         zMIWcNEeUfaBkv4dmOzcHwvG+a/Ezn7pT74bE/2ZOjDpJZL2qveG/NT7YBZX3G//QSIR
         cifHSH/Nq8s7/O8nnqWWk/8azYNGNUSYdG0CiwjxFSYgZYZ1rfXb6FGUml7h9xVgTzNc
         4MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346285; x=1741951085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRLcibLkNuqSJ4oebIn+gemASecItzRG6bVok0DbXQU=;
        b=dGLyz1HaW09tt+TK+y/zvFwgv9u/plhn9m9iyvcd8+zsgbS8eUIFSavjp7DsqZ2DHh
         1TsDmgLJANStx39sEdrPKeDWHrJymRHyWejltHKhuSZn0btMgG2qJePIoQEQMaShRBzA
         mWMynPzBISbvCdpq6rC1vaKQ7syqvdDNLYopV+6VoVHTiXRVN5jtEtTt0SpxXseEkNKd
         vifm5Fgs5+yb6+7bMGLIELz/0Rlw1Uga9UzcEIQxEaHdQVh/KT7M7pVPCPNOhAapUvgQ
         s1QRWW/5zWzpYJTYNszf5dminPlJN2nW7dXGE1qOZcW5OIE20ZtBZVJAKIzfGG3iF09z
         dp6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsm+XS3jm8J6rMhouOdKudsmObiQ1zlC7SIJQOfVhJ/5nnYLlHusxSqg0T0ETAw3wNex+5nA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm6NxTn/7+mW+0sGWytx7gFgIpOUvy+CBeQq2CQGHMugmaRyy2
	VXDJfmXViUP8v8G0+r9Q6Zpc+P0xP9+wpPWp+a2bZ2ZKGadLbfUXx6YmTGhT4CUicl+cL+o0NRm
	/giIewp0NZd0vBw==
X-Google-Smtp-Source: AGHT+IHnzb2nOCmp6+c+syQ1hYMjFz5XWhAo+dQvq2xXAHc19m9MS1tNxCTMGHGXg0ybwWZMPJp/Okj0I4a8moc=
X-Received: from wmbgw6.prod.google.com ([2002:a05:600c:8506:b0:43b:d732:fc79])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ecb:b0:439:99d1:d4a4 with SMTP id 5b1f17b1804b1-43c601e1873mr20865475e9.18.1741346285547;
 Fri, 07 Mar 2025 03:18:05 -0800 (PST)
Date: Fri, 7 Mar 2025 11:18:03 +0000
In-Reply-To: <20250307110821.1703422-4-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com> <20250307110821.1703422-4-abdiel.janulgue@gmail.com>
Message-ID: <Z8rV6y5GLgovaWdN@google.com>
Subject: Re: [PATCH v13 3/7] rust: pci: impl AsMut<Device> for pci::Device
From: Alice Ryhl <aliceryhl@google.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, 
	dakr@kernel.org, robin.murphy@arm.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="utf-8"

On Fri, Mar 07, 2025 at 01:06:20PM +0200, Abdiel Janulgue wrote:
> From: Danilo Krummrich <dakr@kernel.org>
> 
> Some device methods require mutable references, since they change the
> underlying struct device without lock protection.
> 
> Hence, make it possible to retrieve a mutable reference to a Device from
> a mutable pci::Device.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/pci.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 4c98b5b9aa1e..141430dac2d5 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -432,3 +432,14 @@ fn as_ref(&self) -> &device::Device {
>          &self.0
>      }
>  }
> +
> +impl AsMut<device::Device> for Device {
> +    fn as_mut(&mut self) -> &mut device::Device {
> +        // SAFETY:
> +        // - `self.0.as_raw()` is valid by the type invariant of `device::Device`,
> +        // - `struct device` is embedded in `struct pci_dev`, hence it is safe to give out a
> +        //    mutable reference for `device::Device` if we have a mutable reference to the
> +        //    corresponding `pci::Device`.
> +        unsafe { &mut *self.0.as_raw().cast() }
> +    }
> +}

This makes it possible to call `mem::swap` on two devices, which I doubt
is allowed.

Alice
