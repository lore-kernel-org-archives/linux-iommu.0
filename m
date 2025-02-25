Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3901C7017
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471340; cv=none; b=BALvLrx6jcehNDaUlrNPDpCmX6bER1NlcKnC/Ochq1wSAc4+dnK4uBWCmkV1OkXWfLIqyKM6qwvllXptOVs88F64MXcn7/vgNEALf8gu3ZXh8RNVhvAsFuPozlenHLYyJKkVxAbHbwKJXYev7i8j0YjL0GrlBzMmSaX74rayGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471340; c=relaxed/simple;
	bh=kmvuv+Jfr496j/cgberO76qrda4nqaWb+Uq969dYEXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VS8fXp/qhp/D10OyuH0ex8L/ZbU50psCIoDG00CZ3dx6Hvtl//fLRVNYiF6sL6TFku3tbCJQ2SSBnkZxNGTqoLZlG5yrQ6gpAPAOaS02oUwseWwv0sXGxF4nSPYYN1lrLK3gG2VcjW2yNbvjWE6I2LgLhgnF8bXuqr7Cj9p9JCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYFXanGQ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYFXanGQ"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3091fecb637so42910451fa.1
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 00:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740471337; x=1741076137; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/KJUokdxrYn1BIrwoPNGtVFx5fJyWbgxS9RdZ3FB8I=;
        b=FYFXanGQLuz6aiSwgj8d4M+f5MxcexDTFzbtu/4SJO/v/ewNwYYP5Bc0kaXkra9msV
         MWuIB1ukNhlGQv0v6wgwV9/Uc8qSKdT73d5qa0L5EpvR2j/6d3AYjJWRNzd5s66oGX1Q
         VYNmEBH4FqDDeiL3l9ukKG9QGL3K1v+4yPgWzExJ/1FCyJx2xRrEE32R05rk/Snh5FyB
         CXlvzC/UsJmrzkNFnNzyjEOnxcAIR8G7f114OK6KMvC0Sp5trQELIzLdRomq0y1GWDS2
         JAhsJVvQVTauB4H5jKLSQSKGuZdEInpfcxjM+Uho9KL40YYs87++aP86kF6v9figiHmm
         6xKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740471337; x=1741076137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/KJUokdxrYn1BIrwoPNGtVFx5fJyWbgxS9RdZ3FB8I=;
        b=bMNAFDsmhZI4Lcy26nwkOe96U72dHj+wd8Jmy0ItKqHJx0FkcgaCIi5wztxgP+cWBB
         QBvA0VnAPdPaTLb7NC2JPCjNQMaAwN4egARFeXfBvECQPm4/GaafsWDAIWO/VvptqVbp
         b9AQuQkMldEvJlkZMhbip5aPzM+Ii6WNxS9Gy4qT8jTjVsZ1lxclNaw04yBWGZEaM+0c
         2x3qhb1IsK2vS0jxtMIjYqv4Le9fqVLFSGasCyVRuwzkAhO3jP/1OUBv3utRPlfMBQIw
         2tFPXpWz3mLeF3tcMp9KAW4n6bqcvuaneJPjJZL4pwItq2WOgp2NsBpUm7/J/+zXf/Rn
         CBLA==
X-Forwarded-Encrypted: i=1; AJvYcCXz0AbRKo+mnSC6b1Jw01B0G5Im5IngiH4r2HniBvTDNszO+5aMnQB6duxXeD++rPTVmRopvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YywGFXm41M9JA4KeyRxeodjz1Q36JUY6xzL06XVTfY1uOs39wt8
	LmQ1CDPubPzuLy6o1ysliv4kuh8aF83mSeAb7lXM58T4rg0fvMI7
X-Gm-Gg: ASbGncsQtZRBEL8miA0tETmfi7uUnfYAZDpv8y5deTiZ/VWNAgaf2S+opwd35CwWlab
	RqvxIr9uBsHv71G8g/e8XYy0e9/xcpoCmE8PGxm5gcfJrA7cV0WBv1K8Q2hcpff2H9pMS9GsH/9
	4wPHly+FrnLFqtczm/6LaUjfZfgaus11iJhKT2S2eibgswHpDgM0O4qhaic8BVX5Eet/c0wgPx4
	Wiv43qHqWK6t4axqk6XiRCujyx6JEkEtyhvuss+0dADmSdx1IZm+kYC8p6HHIjEhgN73aoYcKad
	wtqkkH48UFiEZbOS5UtIjnWtdAVnwANgxONFSbbVVlT1lGaISjagNxMa4MHyw9PDf+qEUmhC
X-Google-Smtp-Source: AGHT+IHuJatL8xCQgMuRAazvliL5edKKt4ZAJLa4CGfwau4teDzhfGmcvH+sqWJ0R4CwMb9wDctcXA==
X-Received: by 2002:a2e:9658:0:b0:309:1c07:4a56 with SMTP id 38308e7fff4ca-30a80c7e8c3mr8365861fa.36.1740471336402;
        Tue, 25 Feb 2025 00:15:36 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819ec1d1sm1630461fa.41.2025.02.25.00.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 00:15:35 -0800 (PST)
Message-ID: <a65125ce-524f-4226-9e59-32b731ad97f0@gmail.com>
Date: Tue, 25 Feb 2025 10:15:33 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Benno Lossin <benno.lossin@proton.me>, aliceryhl@google.com,
 dakr@kernel.org, robin.murphy@arm.com, daniel.almeida@collabora.com,
 rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com, iommu@lists.linux.dev
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 24/02/2025 22:07, Benno Lossin wrote:
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// It is the callers responsibility to avoid separate read and write accesses to the region
>> +    /// while the returned slice is live.
> This safety requirement is worded quite differently compared to the one
> on `as_slice`, why?
> 
>> +    pub unsafe fn as_slice_mut(&self, offset: usize, count: usize) -> Result<&mut [T]> {
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
>> +        Ok(unsafe {core::slice::from_raw_parts_mut(self.cpu_addr.add(offset), count) })
>> +    }
>> +
>> +    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
>> +    /// number of bytes.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// # fn test(alloc: &mutkernel::dma::CoherentAllocation<u8>) -> Result {
>> +    /// let somedata: [u8; 4] = [0xf; 4];
>> +    /// let buf: &[u8] = &somedata;
>> +    /// alloc.write(buf, 0)?;
>> +    /// # Ok::<(), Error>(()) }
>> +    /// ```
>> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
>> +        let end = offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
>> +        if end >= self.count {
>> +            return Err(EINVAL);
>> +        }
>> +        // SAFETY:
>> +        // - The pointer is valid due to type invariant on `CoherentAllocation`
>> +        // and we've just checked that the range and index is within bounds.
>> +        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
>> +        // that `self.count` won't overflow early in the constructor.
>> +        unsafe {
>> +core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.add(offset), src.len())
> Why are there no concurrent write or read operations on `cpu_addr`?

Thanks for the feedback! I noticed an additional safety requirement in 
slice::from_raw_parts_mut:

"The memory referenced by the returned slice must not be accessed 
through any other pointer (not derived from the return value) for the 
duration of lifetime 'a. Both read and write accesses are forbidden."

I can see now though why both as_slice and as_slice_mut docs needs more 
clarity. i.e., they could be worded similarly and add the additional 
safety requirement of slice::from_raw_parts_mut of having no other r/w 
access while the slice is live?

Regards,
Abdiel



