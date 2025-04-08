Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2772EB663;
	Tue,  8 Apr 2025 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116038; cv=none; b=Vyy3FmdccmN21mGImUwyTTnMcSyJ/tfuTHx2bw53dEMCpV5zSk3isupzHD+df376i0/JqUW2pSRX3ozGBhbh2QzoPccmPer8c/9gxF9dh2VKwrB4+3Y4KM0jgrZ0IjjIpbw9+C+hd2nAEb5ENm96PJ4kAbK8Wjd2USBV/8RrCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116038; c=relaxed/simple;
	bh=J9sS9BYFKqNpm63hs9bprrqPIhjvC0tgMde5KXh1DFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XzCgbVr2astxh5Wvw2lItox4X1JS2oEe4Wjk7/zYqFUTd/xRmSAg+HcYf5gm0hbhMAghmByQ/qKfnVEy/im+9wXUYRAcuX41okuwB0hULnzRdcjEvb3RSx+3TyPXIK0v+mfvm0KgcDN8nXO70p1DFw1GY8zrnjVrltoGV/Di18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaZQ7Nyb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaZQ7Nyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1C6C4CEE5;
	Tue,  8 Apr 2025 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744116037;
	bh=J9sS9BYFKqNpm63hs9bprrqPIhjvC0tgMde5KXh1DFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PaZQ7NybpSTc3u6LMf0GyakpZbAH6uWAYkR3PEAVRoLikJQ6JTcBZW35reZTyFFN+
	 E8yJ7Z0KrjFy8CHATkOlPTvGUUM9on6Hvx2h+dji3NJt9Rcjcl3R+Y70htmt7tMZh0
	 XcFhP72Ypa8tCNKazIX2duu5kWA0jm9YQRRH8OxGXQqd/pflPU16KJvECLJelWdf5X
	 pqEGNs0lVB3AqBsHsw1VsijG5T87Cg0qc7VWRIMFeoNo/by4q8qWaU8+3rAttmgocv
	 3pu1K08NEYGtJ+batEIRnp/NOgV2n0EdN7XPp5VmoGTbNEHeaoe1atqsNd8j/MFpjK
	 DG2C/uCeDlUqw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: <ojeda@kernel.org>,  "Danilo Krummrich" <dakr@kernel.org>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Robin Murphy"
 <robin.murphy@arm.com>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun
 Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>,  "Benno Lossin"
 <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  <rust-for-linux@vger.kernel.org>,  "Marek
 Szyprowski" <m.szyprowski@samsung.com>,  <iommu@lists.linux.dev>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: dma: be consistent in using the `coherent`
 nomenclature
In-Reply-To: <20250326201230.3193329-2-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Wed, 26 Mar 2025 22:11:42 +0200")
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
	<iA3Kum15KL4RrDONXH8tPrKBbFuskGFUDLRzBFHceQi9DhEFzoDSryS7C3eLAJCtGkRCswvoORtja0H68Pyadg==@protonmail.internalid>
	<20250326201230.3193329-2-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 08 Apr 2025 14:27:42 +0200
Message-ID: <87wmbuhm81.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> In the kernel, `consistent` and `coherent` are used interchangeably for
> the region described in this api. Stick with `coherent` nomenclature
> to show that dma_alloc_coherent() is being used.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/kernel/dma.rs | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 8cdc76043ee7..d3f448868457 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -89,15 +89,15 @@ pub mod attrs {
>      /// Forces contiguous allocation of the buffer in physical memory.
>      pub const DMA_ATTR_FORCE_CONTIGUOUS: Attrs = Attrs(bindings::DMA_ATTR_FORCE_CONTIGUOUS);
>
> -    /// This is a hint to the DMA-mapping subsystem that it's probably not worth the time to try
> +    /// Hints DMA-mapping subsystem that it's probably not worth the time to try

This and the next two edits has nothing to do with coherent/consistent
nomenclature. Please update the commit message to reflect that.


Best regards,
Andreas Hindborg


