Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3901E2312
	for <iommu@lists.linux.dev>; Fri, 13 Dec 2024 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103712; cv=none; b=aGPW53U+8kCI+QaWSbcAB3tPauIvU1RLWl/JSsCp7eUzOttQcnd6YDU29JBcFAG9i0Wv5+qxHSrXlvBLb0gq6fDpdsQ2j9MxE4TR6+TFnmJOTbA70pQktZ4R0ZHxSeaZq5an81TCowElZHXMduJpPgvsjF4tdTBHjDfqkN4IPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103712; c=relaxed/simple;
	bh=S6ngcvffWreb1pIBx+eV1GL9aDoASQZY3lV3XiCaRC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eylDz8conctwGhhRhT+jw+EI5NAPbAeDn6+qgnaf2Xk3jk3X9mj85XN2BrgxTj9rvJlv9dZngRHbYvaUpbSQtkPigAmWJfudjGCAqGt5FiPL+Rk8FfWvx0CpOrNS9fW3PgA6YpKn38MtmYSJhDbXzLJ8uZ7aoRjL/aYSndhgMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DF551480;
	Fri, 13 Dec 2024 07:28:50 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDD083F720;
	Fri, 13 Dec 2024 07:28:19 -0800 (PST)
Message-ID: <b7130ae2-6314-41d9-bda2-d875b22463bb@arm.com>
Date: Fri, 13 Dec 2024 15:28:18 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] rust: add dma coherent allocator abstraction.
To: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
 <20241210221603.3174929-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjO-GbB85dDdxLSSWY74cUn8-Lt-yaRGkUVxb-E8YaO2Q@mail.gmail.com>
 <0F719804-2AD3-4C4E-A98C-2862295990BA@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <0F719804-2AD3-4C4E-A98C-2862295990BA@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/12/2024 2:47 pm, Daniel Almeida wrote:
[...]
>>> +    /// Returns the CPU-addressable region as a slice.
>>> +    pub fn cpu_buf(&self) -> &[T]
>>> +    {
>>> +        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
>>> +        // is valid for reads for `self.count * size_of::<T>` bytes.
>>> +        unsafe { core::slice::from_raw_parts(self.cpu_addr, self.count) }
>>
>> Immutable slices require that the data does not change while the
>> reference is live. Is that the case? If so, your safety comment should
>> explain that.
>>
>>> +    }
>>> +
>>> +    /// Performs the same functionality as `cpu_buf`, except that a mutable slice is returned.
>>> +    pub fn cpu_buf_mut(&mut self) -> &mut [T]
>>> +    {
>>> +        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
>>> +        // is valid for reads for `self.count * size_of::<T>` bytes.
>>> +        unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, self.count) }
>>
>> Mutable slices require that the data is not written to *or read* by
>> anybody else while the reference is live. Is that the case? If so,
>> your safety comment should explain that.
>>
> 
> The buffer will probably be shared between the CPU and some hardware device, since this is the
> point of the dma mapping API.
> 
> It’s up to the caller to ensure that no hardware operations that involve the buffer are currently taking
> place while the slices above are alive.

Hmm, that sounds troublesome... the nature of coherent allocations is 
that both CPU and device may access them at any time, and you can 
definitely expect ringbuffer-style usage models where a CPU is writing 
to part of the buffer while the device is reading/writing another part, 
but also cases where a CPU needs to poll for a device write to a 
particular location.

Thanks,
Robin.

> I think that adding that as a safety requirement to `cpu_buf` and `cpu_buf_mut` will be sufficient.
> 
>>> +    }
>>> +}
>>> +
>>> +impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
>>> +    fn drop(&mut self) {
>>> +        let size = self.count * core::mem::size_of::<T>();
>>> +        // SAFETY: the device, cpu address, and the dma handle is valid due to the
>>> +        // type invariants on `CoherentAllocation`.
>>> +        unsafe { bindings::dma_free_attrs(self.dev.as_raw(), size,
>>> +                                          self.cpu_addr as _,
>>> +                                          self.dma_handle,
>>> +                                          self.dma_attrs.as_raw(),) }
>>> +    }
>>> +}
>>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>>> index e1065a7551a3..6e90ebf5a130 100644
>>> --- a/rust/kernel/lib.rs
>>> +++ b/rust/kernel/lib.rs
>>> @@ -35,6 +35,7 @@
>>> mod build_assert;
>>> pub mod cred;
>>> pub mod device;
>>> +pub mod dma;
>>> pub mod error;
>>> #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
>>> pub mod firmware;
>>> —
>>> 2.43.0
> 
> — Daniel
