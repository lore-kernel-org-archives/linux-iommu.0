Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058E2173;
	Mon, 31 Mar 2025 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743405837; cv=none; b=JC+afLCJeiRZpC9lZWLEPSUx7RRKg2wn37imVIi5fTxpt82jueTcweAGGxlGJTAz5CpnmgNGecMxInF0ecFT3F+7a1OlkF7NQg0l94t3hV65rXi+L6yBWedlnhSs4W0PQs1V0jyqcLmCnGawxLCRu5Xba5L0UxPhg2fu9yEZd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743405837; c=relaxed/simple;
	bh=Bd4owxWHhGkZzOfNhIaGrET3H137uDGRw7djbI4sleA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j3lBjOEdjBCrgI+MGm7pTdZoVfAOamr6KLfCbYeOyZoP7OEktWHrlkOent/7Cyz3NWfE9AAqhuHnjU+yc17qkI7e6iayJVcduV9nV76Ot3IaFk8Rp1hP3b5iUIBLUvVmiMirDEE22SAhIXet9eREERPAp0AKEAdOW+psP9uOYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeAUocNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeAUocNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9079C4CEE3;
	Mon, 31 Mar 2025 07:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743405836;
	bh=Bd4owxWHhGkZzOfNhIaGrET3H137uDGRw7djbI4sleA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jeAUocNvdYTsG0w92ZMxxtRxAzDuGvvSGeKLYsBiQy3GgH9F6NCUrAZUk4XDZYpIw
	 /bTL+Mu5hdfdnUcfGA7DvcM7lvUiF7cGnGaL9zcUq3M73yLIqHrZqrcNBjT0xJ8Tmk
	 mZRcbpYprcw2dfvBgxyl2ZPg73SMZk266hcdICBtI3VvNOo62T7KA6Prn77TiI6we+
	 JUH5wjQnGsom+zlMXpzqEqcO2oxB4Ixbu8q5OzKmFE609QniPuRdViL38LoYnF1qxL
	 /awNAmFOMnmAk4AylzVTUi5w+DCUXTM17/gi39SmjfNZVGTWm/T+FIq28PIDATXMEU
	 i6lM6961x2KQQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,  <ojeda@kernel.org>,
  "Danilo Krummrich" <dakr@kernel.org>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  "Robin Murphy" <robin.murphy@arm.com>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "open list:DMA MAPPING HELPERS DEVICE DRIVER
 API [RUST]" <rust-for-linux@vger.kernel.org>,  "Marek Szyprowski"
 <m.szyprowski@samsung.com>,  "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>,  "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: dma: add as_slice/write functions for
 CoherentAllocation
In-Reply-To: <D8REKSIL1W0E.6A40JD86RFPZ@proton.me> (Benno Lossin's message of
	"Thu, 27 Mar 2025 22:31:02 +0000")
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
	<20250326201230.3193329-4-abdiel.janulgue@gmail.com>
	<DCOZ-dq4bhxZ-K_Fl61tlmWk89AfdmVvbCO-2xxgMZV2lP6QalgBE20J901AhbZPCHuzDty3iDERbTWp1_ys0Q==@protonmail.internalid>
	<D8REKSIL1W0E.6A40JD86RFPZ@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 31 Mar 2025 09:23:35 +0200
Message-ID: <87a59164ug.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Wed Mar 26, 2025 at 9:11 PM CET, Abdiel Janulgue wrote:
>> +    /// Returns the data from the region starting from `offset` as a slice.
>> +    /// `offset` and `count` are in units of `T`, not the number of bytes.
>> +    ///
>> +    /// Due to the safety requirements of slice, the caller should consider that the region could
>> +    /// be modified by the device at anytime. For ringbuffer type of r/w access or use-cases where
>> +    /// the pointer to the live data is needed, `start_ptr()` or `start_ptr_mut()` could be
>> +    /// used instead.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// * Callers must ensure that no hardware operations that involve the buffer are currently
>> +    ///   taking place while the returned slice is live.
>> +    /// * Callers must ensure that this call does not race with a write to the same region while
>> +    ///   while the returned slice is live.
>> +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
>> +        let end = offset.checked_add(count).ok_or(EOVERFLOW)?;
>> +        if end >= self.count {
>> +            return Err(EINVAL);
>> +        }
>> +        // SAFETY:
>> +        // - The pointer is valid due to type invariant on `CoherentAllocation`,
>> +        // we've just checked that the range and index is within bounds. The immutability of the
>> +        // of data is also guaranteed by the safety requirements of the function.
>> +        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
>> +        // that `self.count` won't overflow early in the constructor.
>> +        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.add(offset), count) })
>
> I vaguely recall that there was some discussion on why this is OK (ie
> the value behind the reference being modified by the device), but I
> haven't followed it. Can you add the reasoning for why that is fine to
> some comment here?

My objection was with the function being safe. In this version it is
unsafe, and the safety requirement is that there must be no concurrent
reads/writes to the memory being operated on. That seems fine to me.

> I also am not really fond of the phrase "hardware operations that
> involve the buffer":
> * what do you mean with "buffer"? `self`?
> * what are "hardware operations"? (I no nothing about hardware, so that
>   might be a knowledge gap on my part)
> * what does "involve" mean?

It is clear to me, but using terminology read/write to/from memory is
probably better. The operations being executed by hardware is not
strictly relevant. We could have a note cautioning that devices must
also obey this.


Best regards,
Andreas Hindborg




