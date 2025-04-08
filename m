Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CD6263C83;
	Tue,  8 Apr 2025 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116051; cv=none; b=ee2R5dzyOTdNPbQcXs4NELB3aNWANSiORJVM1iTds6tgtnqgu2Sm+x7VikahgE5zb7oruHreJu60obq73EqVU7nrUsAbqXOmL03DsEq9zM4Svul2WmZ1oDmqOSs8hWzRHhHJgZd08WuYcvlJG6LNgJKG6iSUHB4B8RNSNZb9xCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116051; c=relaxed/simple;
	bh=dHP0/udm20sXgQKDlru8Fc0+oci1llyIjyVrg4/zGdg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TrWvUI0o7RG9gBoGXMa0WyxkUxUHYvXWtpelOPBClVNvquegnyS3hje4zEKeos12PV1UmQ1H9zPPhbskYv1wXXgj/TxbiKzJm1/xDCy62RViwfoWlBD6AB+5BB0xyC/NBU9lxeZbLfd3nQOt803bErw49he+s+vXPiw2QULbU4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8fbRvfx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8fbRvfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298D8C4CEE5;
	Tue,  8 Apr 2025 12:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744116050;
	bh=dHP0/udm20sXgQKDlru8Fc0+oci1llyIjyVrg4/zGdg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=c8fbRvfxjziB7Io+USquH5XEtqf7lDQk3JFK8aOt0z/9KBVBiuLgEZCN0YsT61ug7
	 uTs04krMG0aSWDXCfrvKo91MUorTseZqJ+ExDUrfhIZCHnylsUn9r0DOUJ0svg4XbY
	 dM/x/+0rqNSD1cfqOkdCVT+3JFNpmAF/8t5LiPpzRKFuAGD+WXBJg6sOKlZqRbqkhR
	 RfHTub4Zufn/r1h9lSF/E3SkK1lOuWYwD2NQObsUvhYskaY80/yTCB+9/PmCE1R+j0
	 gM5Z3akGSOdVfUvAU00JGybeD7Sr9G4OgoC9Rq0eF4pRkujZsl6FAq2wI9VIFoHoTA
	 M8a3YYRZdAU1g==
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
Subject: Re: [PATCH 3/3] rust: dma: add as_slice/write functions for
 CoherentAllocation
In-Reply-To: <20250326201230.3193329-4-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Wed, 26 Mar 2025 22:11:44 +0200")
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
	<Jv5VZvihK_dgh5j6Ml8T-c7Q8EICtgbgAMI_g_QT51H7--Za9Dbwvz4j1ouuseFxM26sKP0_J3h38ffbQq0Y_A==@protonmail.internalid>
	<20250326201230.3193329-4-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 08 Apr 2025 14:39:29 +0200
Message-ID: <87friihloe.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> Add unsafe accessors for the region for reading or writing large
> blocks of data.
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/kernel/dma.rs | 87 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 24a6f10370c4..24025ec602ff 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -218,6 +218,93 @@ pub fn dma_handle(&self) -> bindings::dma_addr_t {
>          self.dma_handle
>      }
>
> +    /// Returns the data from the region starting from `offset` as a slice.
> +    /// `offset` and `count` are in units of `T`, not the number of bytes.
> +    ///
> +    /// Due to the safety requirements of slice, the caller should consider that the region could
> +    /// be modified by the device at anytime.

The user does not need to consider this, because the safety requirements
make sure this is not a problem. The user only needs to consider the
safety requirements.

>> For ringbuffer type of r/w access or use-cases where
> +    /// the pointer to the live data is needed, `start_ptr()` or `start_ptr_mut()` could be
> +    /// used instead.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that no hardware operations that involve the buffer are currently
> +    ///   taking place while the returned slice is live.
> +    /// * Callers must ensure that this call does not race with a write to the same region while
> +    ///   while the returned slice is live.
> +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
> +        let end = offset.checked_add(count).ok_or(EOVERFLOW)?;
> +        if end >= self.count {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllocation`,
> +        // we've just checked that the range and index is within bounds. The immutability of the
> +        // of data is also guaranteed by the safety requirements of the function.
> +        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
> +        // that `self.count` won't overflow early in the constructor.
> +        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.add(offset), count) })
> +    }
> +
> +    /// Performs the same functionality as [`CoherentAllocation::as_slice`], except that a mutable
> +    /// slice is returned.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that no hardware operations that involve the buffer are currently
> +    ///   taking place while the returned slice is live.
> +    /// * Callers must ensure that this call does not race with a read or write to the same region
> +    ///   while the returned slice is live.
> +    pub unsafe fn as_slice_mut(&self, offset: usize, count: usize) -> Result<&mut [T]> {
> +        let end = offset.checked_add(count).ok_or(EOVERFLOW)?;
> +        if end >= self.count {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllocation`,
> +        // we've just checked that the range and index is within bounds. The immutability of the
> +        // of data is also guaranteed by the safety requirements of the function.

Formatting nit: could you indent the paragraph under the bullet:

  - The pointer is valid due to type invariant on `CoherentAllocation`,
    we've just checked that the range and index is within bounds. The immutability of the
    of data is also guaranteed by the safety requirements of the function.



Best regards,
Andreas Hindborg


