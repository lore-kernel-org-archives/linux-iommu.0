Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7ED20CCF2;
	Tue, 18 Mar 2025 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306496; cv=none; b=MYRE8mmG3PYGi2K/kILbvwv68PTC4WoYbRFhv7FD4N92GiJ9pkAglEGzjWW23iOBp+CNcBOhk3UGmtQssPGVh0sdnSOh0erGwc25nY7Zte1eaFUdwJEziK0Q1cJiL6mDjpvAR/uf4/iPjF3MRE2Sx+LjtzeM2Fc59qwaOr+V4yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306496; c=relaxed/simple;
	bh=3cmRnMYukVAIeZVGYalyMJ4UjuQ2TRhzGHCptcLjrfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TxdyOcK62HtKyuHBAcJblI8ZH6HHoTi7+zxAjOEqxIt3nuaTZD/pPFE9egKtdCK5OkN/7+YoY3JlabH0fy1P6q/Ml+wfZXpZgzeaZEXMRHLFtyx0LnyAcH+Vtj0v4nG5gTwlaDiEixFVcxOX8jj76snUundP/J6Yy7FbdKna1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLkmW779; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLkmW779"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED768C4CEE3;
	Tue, 18 Mar 2025 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742306495;
	bh=3cmRnMYukVAIeZVGYalyMJ4UjuQ2TRhzGHCptcLjrfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NLkmW7796Wtwdh0pu84meFsUfJ/4VV2ZW2c4tSf8AOP1ionVbwWPuQS1ur4di8dNe
	 4BARn8fBK8GmDggvlLVQ6Xh8keXIiQXv6WP2wKCwspQ18FMtk2t2y/iG0kDUBfJPKm
	 bsUs3QrAdhEeBuRPJ+FZBVzqU8Z9I/MdsK0TmQyqJJXixvSHIU8tzI3xhbdAj9L+e8
	 NaeREM5/QcYoow+f0gcn6fLldFUL+9OLpDZ6g6FvMs5wIrykNJu/wEXeUmdrHYduT8
	 QsSrq2jCS7Onnf7iXMFJDHOqLu3g3gc3cnBxXZ7fUjfGHzqF+frN9AGhSRYSaTAj3+
	 r92OjX3HT+fZg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org,  daniel.almeida@collabora.com,
  dakr@kernel.org,  robin.murphy@arm.com,  aliceryhl@google.com,  Miguel
 Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,  Boqun
 Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>,
  Trevor Gross <tmgross@umich.edu>,  Valentin Obst
 <kernel@valentinobst.de>,  linux-kernel@vger.kernel.org (open list),
  Christoph Hellwig <hch@lst.de>,  Marek Szyprowski
 <m.szyprowski@samsung.com>,  airlied@redhat.com,  iommu@lists.linux.dev
 (open list:DMA MAPPING HELPERS)
Subject: Re: [PATCH v14 06/11] rust: dma: add dma addressing capabilities
In-Reply-To: <20250311174930.2348813-7-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Tue, 11 Mar 2025 19:48:02 +0200")
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
	<20250311174930.2348813-7-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 14:50:23 +0100
Message-ID: <874izqjvmo.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Abdiel Janulgue <abdiel.janulgue@gmail.com> writes:

> From: Danilo Krummrich <dakr@kernel.org>
>
> Implement `dma_set_mask()` and `dma_set_mask_and_coherent()` in the
> `dma::Device` trait.
>
> Those methods are used to inform the kernel about the device's DMA
> addressing capabilities.
>
> Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

[...]

> +
> +/// Helper function to set the bit mask for DMA addressing.
> +pub const fn dma_bit_mask(n: usize) -> u64 {
> +    if n > 64 {
> +        return 0;
> +    }
> +    if n == 64 {
> +        !0
> +    } else {
> +        (1 << (n)) - 1
> +    }
> +}

I think this is dead code?


Best regards,
Andreas Hindborg


