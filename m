Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B23B183CB0;
	Fri,  7 Mar 2025 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741380042; cv=none; b=IJqDGjSDfQ9IT4GjHW6FXSd9E0UDdqes7w2PJuGrux/t+t1vn10Q6+I/HJ23dAEPwjznRmDf6g3Drh+lCbOGJfZBk/sUKGCncxkK9BFFx0GVV0MLmlS8nH2h6ytqpbelVqcNa+ON/1//MuG7p3drSYcVcXz1mExOKM1rQFs/hoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741380042; c=relaxed/simple;
	bh=EVxChS+74swYadRrkHg1iNrCXtQarsnTlJJNN+38/gU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nY+hVY0xdKj49/+vd0OrWvmuptqkhYNqz0YsNNY9NEqoYqNmIWQDsqC6cVCz2AK4UioJfv+KmfUzOvv0fjeAbZeBkE2ajEwqmD1rBQxFxE/HIlIXbvoIGe5I2KrRw4bBxSfddwvWEtUEic5XT87muGQ01WdtVgiT+3feAY0rMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjAEZBeN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjAEZBeN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE97CC4CED1;
	Fri,  7 Mar 2025 20:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741380042;
	bh=EVxChS+74swYadRrkHg1iNrCXtQarsnTlJJNN+38/gU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QjAEZBeNLkVr4V628qfMuGWLsQSE/m9kEDOICsGpltkgQCC3t0kqVfyeHSREQt52K
	 hWwIn21kTYPa31ChCJP/wa8a6pgPUAVOO/zm96qdowu0efHGrDthMPMjGUIQ4uS8gv
	 SjOGbYKqc292K4+ADYBhmuIKcEDrvLjxcRJaMyznuixseEvDyq4YGAkruJEHRhUgL9
	 7N/7YaEPM1+pUea/CkZB5WWv0S8UTi530TfEIzvAGth8yUAD++IcgInA26zWq6k5dl
	 3k7Q720K9yvJUNv6Y7nA++ACQuj2/5pvR4K4P9ih8egiz1x53lJSHxo5DUN4hdRZML
	 D9+8Qz4Il+usA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>,  <daniel.almeida@collabora.com>,
  <dakr@kernel.org>,  <robin.murphy@arm.com>,  <aliceryhl@google.com>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  "Valentin Obst" <kernel@valentinobst.de>,
  <linux-kernel@vger.kernel.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Marek Szyprowski" <m.szyprowski@samsung.com>,  <airlied@redhat.com>,
  <iommu@lists.linux.dev>
Subject: Re: [PATCH v13 2/7] rust: add dma coherent allocator abstraction.
In-Reply-To: <20250307110821.1703422-3-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Fri, 07 Mar 2025 13:06:19 +0200")
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
	<ON3xPFZKwDe669Eic3fleeCuj2PZ8YyJQY9XrhmZgeKr3QzeQaObo4o4af-hJmU9RCrKn6zui34cF4M3P4bSAw==@protonmail.internalid>
	<20250307110821.1703422-3-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 21:40:30 +0100
Message-ID: <871pv8377l.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
>
> A CoherentAllocation is wrapped in Devres which basically guarantees
> that a driver can't make a CoherentAllocation out-live driver unbind.
> This is needed, since DMA allocations potentially also result in
> programming of the IOMMU. IOMMU mappings are device resources and
> hence the device / driver lifecycle needs to be enforced.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
> +
> +    /// Reads the value of `field` and ensures that its type is [`FromBytes`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// This must be called from the [`dma_read`] macro which ensures that the `field` pointer is
> +    /// validated beforehand.
> +    ///
> +    /// Public but hidden since it should only be used from [`dma_read`] macro.
> +    #[doc(hidden)]
> +    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F {
> +        // SAFETY: By the safety requirements field is valid.
> +        unsafe { field.read_volatile() }

From the docs of `read_volatile`:

   Just like in C, whether an operation is volatile has no bearing
   whatsoever on questions involving concurrent access from multiple
   threads. Volatile accesses behave exactly like non-atomic accesses in
   that regard. In particular, a race between a read_volatile and any
   write operation to the same location is undefined behavior.

So the safety requirement is not sufficient. Alice responded to my
question on v12:

   > Volatile reads/writes that race are OK?

   I will not give a blanket yes to that. If you read their docs, you
   will find that they claim to not allow it. But they are the correct
   choice for DMA memory, and there's no way in practice to get
   miscompilations on memory locations that are only accessed with
   volatile operations, and never have references to them created.

   In general, this will fall into the exception that we've been given
   from the Rust people. In cases such as this where the Rust language
   does not give us the operation we want, do it like you do in C. Since
   Rust uses LLVM which does not miscompile the C part of the kernel, it
   should not miscompile the Rust part either.

Since we have an exception for the safety requirements in the
documentation, we should make that clear in the safety comment at the
call site.


Best regards,
Andreas Hindborg


