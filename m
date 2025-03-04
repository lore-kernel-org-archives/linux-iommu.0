Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3D1FBEA2
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076906; cv=none; b=Zq+oS7LvCyFVTy6pMxHNgOWW2dqcC5yaqGFlYEchyPO2a99WgC5oxaftTHrHvXbQ8cKqzd5/Q34+OKPNwZEXdo8eseh8TU0xQX5dlb9ldVK1MDS6ULcfj9eH59tU0a34aIjIMUmtFkKFkZ8rR8s10tIbf/A4eHiEYOAgsWCb/Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076906; c=relaxed/simple;
	bh=+Xd2Qwr5IaKsyLjb2/QOiSSthlsBv7A9tUADYqtec0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lV/RbZ6akjnHOByUjSg/MlXKFO1HdzxkczxHksH/jUP7lSfiTrGYdTXzG79PWND6BlyXS/x1W+jHpuSfmXUYxeKAxZkn/Yakw85nQklg6sQ6dX0L4PS/WeaItf3+Dj4ePf/iYLikgt55PYmg7n93hjRu3yvxSls38E7cwLYABK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/M+eVLb; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/M+eVLb"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30761be8fcfso58242001fa.0
        for <iommu@lists.linux.dev>; Tue, 04 Mar 2025 00:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741076903; x=1741681703; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mX8x9KTPJ/SeOY+OHyZ4DRgvFc341kcnP5lxBsMGds=;
        b=O/M+eVLbcCaKtq/sbv7v26eleaTN6+F3hNDzvM0ojwnsW+O7YwdXwArOc5z1Jb7Pmw
         R/1JOGYuO2Cg/9n6qFH288Khx/DAGXWDlxk08RNZ0KQqtBuJWZqTO8BQwll3QGZ39Ehy
         rec1/aQi2SLbaBYcyZnD1iwitCmRo97Qn7aUAfBY4jaV7B93IUB0JKkzoZqaHGn9ehCJ
         7shos7QIT/7PbuhRIxEjqAVmSDbNW0m+hCgYvHDTQLLvhQAEukxArJ9N3n9w7Yr3z6xb
         EZko+M6t6k/syaBAkOZ2y3jdFTIMHtFj2k+DMdRU5pmyIMWvj7+Rx9J8xBkYAr7WUKFY
         YbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741076903; x=1741681703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mX8x9KTPJ/SeOY+OHyZ4DRgvFc341kcnP5lxBsMGds=;
        b=DLDnrV8eihvIPbF3OcQsHPIskOl/jt+lc+7ps0ElEF6ZYx3BNCF+/nUClLmTU4N1FB
         cBejdXo6rMjGYHCTsx2MXgco6Cwd1b8oeDMovz0kL2OwoUiGqBGiQEji+fJOaCQDJypA
         s64PHndO16rLWP+qydLzMordjmilrj8q4j11OQWPing7yJfo8aAs5VDuxYyZycEiUfZK
         k/Z7XbxGsWm2eVxCLTmbMWM1Nho+jLTRfnrQyTIVE4gsLCcgCuTytRPmLq2OLx4Tek6x
         OPScPVzp+AEKvf9RDBEe6hNEE6Y1HPcdFd8pPvl7e3vhz2kUDardYK/y/1yd1Wo4MQxl
         Pd2A==
X-Forwarded-Encrypted: i=1; AJvYcCVB6rP5PQz+SPhRC7pKP7hCo9RMTZEbkZJOG4ywVSqEhz2yNGTzNCLa5fVUJ6kjNKgotgXwzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsEW0TjpbD8omA5QrkKSuMygxvvKvjMk2bzPk4sfEXO2tqRolI
	OKM9ojQwV0n1vUqwCz42xCGjJ0sh97moZc+BjyAJNeVopycZwxM9
X-Gm-Gg: ASbGncuXP/qbHT6GWIIUVMLfSJmZXt+l0zd5Wi61r1uClIhZ6xTKsOA+YzwrJAbUa6P
	wXlMPvJ1pdLdkJyvp8ZEFh/ulXFNsie871f7S4ZtgE+CDJd+E9iBVu9TLdDGLNc93Wx2WoXb67W
	GGJFYTfMT67V+1sYQS9yTemR1UyMe7pS0ZA++5/4KJrui7dX8vzTn2AA4Ay7ocdVPodrTn6cVil
	/04LtT/DFpW0U0qIac9QRcvX/8qucnNQ9t/kW3BKtViJ0Q2jzyDFDPBHVKSMzKIOxY4VBp1G40K
	rUCi3gOMqLrTbyzthrmkiiJTY2x9VKUoEyUstSGGpmnLjlXB4i09ohKt3npcw7/aXHteIJr2Nri
	nF8hvh0hqaByJM4EjQjDbCg==
X-Google-Smtp-Source: AGHT+IGQXjXy4I7TbIxibMzg0y1cK5xMehOkC/wPiOXepdk9gzG4SYdo2xhPe+ixkrPITWiBjQcj8Q==
X-Received: by 2002:a2e:bc0f:0:b0:30b:b987:b68d with SMTP id 38308e7fff4ca-30bb987bb51mr20938931fa.8.1741076902435;
        Tue, 04 Mar 2025 00:28:22 -0800 (PST)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b86875b76sm16838331fa.91.2025.03.04.00.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 00:28:21 -0800 (PST)
Message-ID: <8d998447-bb4e-4b4b-a2d7-f5cba4b815dc@gmail.com>
Date: Tue, 4 Mar 2025 10:28:21 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Alice Ryhl <aliceryhl@google.com>,
 Andreas Hindborg <a.hindborg@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Benno Lossin <benno.lossin@proton.me>, dakr@kernel.org,
 robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 iommu@lists.linux.dev
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
 <tnwDK3QN_Xr0Yoa3U8HVxS5OqjvxIhgmmO_ifTGJR_EtIzjoxawOHtnbOJ9yChsUWXyFPcU9beIdrgbpfGZI8w==@protonmail.internalid>
 <3202F69F-397E-4BC4-8DD8-E2D4B0AB056F@collabora.com>
 <87bjuil15w.fsf@kernel.org>
 <CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/03/2025 15:13, Alice Ryhl wrote:
> On Mon, Mar 3, 2025 at 2:00 PM Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
>>
>>> Hi Benno,
>>>
>>
>> [...]
>>
>>>>> +    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
>>>>> +    /// number of bytes.
>>>>> +    ///
>>>>> +    /// # Examples
>>>>> +    ///
>>>>> +    /// ```
>>>>> +    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>) -> Result {
>>>>> +    /// let somedata: [u8; 4] = [0xf; 4];
>>>>> +    /// let buf: &[u8] = &somedata;
>>>>> +    /// alloc.write(buf, 0)?;
>>>>> +    /// # Ok::<(), Error>(()) }
>>>>> +    /// ```
>>>>> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
>>>>> +        let end = offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
>>>>> +        if end >= self.count {
>>>>> +            return Err(EINVAL);
>>>>> +        }
>>>>> +        // SAFETY:
>>>>> +        // - The pointer is valid due to type invariant on `CoherentAllocation`
>>>>> +        // and we've just checked that the range and index is within bounds.
>>>>> +        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
>>>>> +        // that `self.count` won't overflow early in the constructor.
>>>>> +        unsafe {
>>>>> +            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.add(offset), src.len())
>>>>
>>>> Why are there no concurrent write or read operations on `cpu_addr`?
>>>
>>> Sorry, can you rephrase this question?
>>
>> This write is suffering the same complications as discussed here [1].
>> There are multiple issues with this implementation.
>>
>> 1) `write` takes a shared reference and thus may be called concurrently.
>> There is no synchronization, so `copy_nonoverlapping` could be called
>> concurrently on the same address. The safety requirements for
>> `copy_nonoverlapping` state that the destination must be valid for
>> write. Alice claims in [1] that any memory area that experience data
>> races are not valid for writes. So the safety requirement of
>> `copy_nonoverlapping` is violated and this call is potential UB.
>>
>> 2) The destination of this write is DMA memory. It could be concurrently
>> modified by hardware, leading to the same issues as 1). Thus the
>> function cannot be safe if we cannot guarantee hardware will not write
>> to the region while this function is executing.
>>
>> Now, I don't think that these _should_ be issues, but according to our
>> Rust language experts they _are_.
>>
>> I really think that copying data through a raw pointer to or from a
>> place that experiences data races, should _not_ be UB if the data is not
>> interpreted in any way, other than moving it.
>>
>>
>> Best regards,
>> Andreas Hindborg
> 
> We need to make progress on this series, and it's starting to get late
> in the cycle. I suggest we:
> 
> 1. Delete as_slice, as_slice_mut, write, and skip_drop.
> 2. Change field_read/field_write to use a volatile read/write.
> 
> This will let us make progress now and sidestep this discussion. The
> deleted methods can happen in a follow-up.
> 
> Similarly for the dma mask methods, let's either drop them to a
> follow-up patch or just put them anywhere and move them later.
> 
> Alice

Thanks Alice. Yeah, will follow-up with those other patches and move 
forward with the basic implementation for now.

Regards,
Abdiel
