Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05B672605;
	Fri, 18 Jul 2025 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835821; cv=none; b=r4wfBiz2/VQdnhMqv7bMoqMOKno48PG2IlHTvjFxdIOnKL8HEN3Z3xOLllEsfXhu3/5QOymBR7x7vHyVYl3XfipSC+/yxi0aq0VOuqdwvWT/cqgtrRMpQBAnYb8hWddNym3ekNFSdM9ChzdJn4NV58V47mFK1bkv4RLPb7clwgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835821; c=relaxed/simple;
	bh=HebdHsS4n8w/p8M0w8SAL7pKxJdoLT/etZGGGL2VYMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9KOBH257N2lqeM0cxUNAM+Z8g11HZOyULXfKL+X6ozqplCiGuR7IH3m8as+kI/5Y+ZOhVG4df25umpP9tRIKk3de+B3gHCbjlWuyIwawHqQwW6pO2cwJjZSALLC99o/art4PFlqcmJaNUoZH2YcpdWsMzFCSIUhjI68Ftzvbys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7gqLWkn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7gqLWkn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57121C4CEEB;
	Fri, 18 Jul 2025 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752835821;
	bh=HebdHsS4n8w/p8M0w8SAL7pKxJdoLT/etZGGGL2VYMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X7gqLWknqtGGoKvEI+04i0epAm6MbvsEZpT4Xi13Y8XAyvckmWpLryvk5bpNNij0W
	 MTQLLJXCJ62xYdvgts/BOxh8oyEFtqeaDciorCxhHo6FVLZVPdAvxnrbx0b60R68Vm
	 JA8OjHCzc/6BelYn6lycjoeUTiCu0vwC9FxwOQWhRHc3+QvsjxjzxyeU8LvgIX5Lev
	 eX2XIfm5ik8w91Ytx0CByvQVaQBWqooEynfTVE2E9PWrZyor+kv923isyFsgVutpjL
	 OF/UJejhNohhci+gZlJV7VDwu1fiPB28ZarCY+kS6vsVyrqzSkIO83Rzp4IVelQuiS
	 tYXQHASjX829w==
Message-ID: <57e06aa7-4805-4b1e-bc46-e6f33582fb97@kernel.org>
Date: Fri, 18 Jul 2025 12:50:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] rust: add initial scatterlist abstraction
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: acourbot@nvidia.com, jgg@ziepe.ca, lyude@redhat.com,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@gmail.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Petr Tesarik <petr@tesarici.cz>, Sui Jingfeng <sui.jingfeng@linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 rust-for-linux@vger.kernel.org
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/25 12:33 PM, Abdiel Janulgue wrote:
> Abdiel Janulgue (2):
>    rust: add initial scatterlist abstraction
>    samples: rust: add sample code for scatterlist abstraction
> 
>   rust/bindings/bindings_helper.h |   1 +
>   rust/helpers/helpers.c          |   1 +
>   rust/helpers/scatterlist.c      |  30 +++
>   rust/kernel/dma.rs              |  18 ++
>   rust/kernel/lib.rs              |   1 +
>   rust/kernel/scatterlist.rs      | 405 ++++++++++++++++++++++++++++++++
>   samples/rust/rust_dma.rs        |  49 +++-
>   7 files changed, 504 insertions(+), 1 deletion(-)
>   create mode 100644 rust/helpers/scatterlist.c
>   create mode 100644 rust/kernel/scatterlist.rs

I think this is missing a corresponding MAINTAINERS entry. I assume the
scatterlist stuff should go under the "DMA MAPPING HELPERS DEVICE DRIVER API
[RUST]" entry (which we may want to rename a bit for this purpose).

@Andrew: Any comments or other preferences from your end?
