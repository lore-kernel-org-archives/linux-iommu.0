Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6489920F96F
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737639539; cv=none; b=GyZLjv9f5Twh+AOrnc0J+RgbLM7elMVFnLWqx7MOR0XfphR+pDMOqG7X2m+AR24lw/SC22CGLnAWFRc2nKwKLwSF+LKe5k6cB8vDiEGeVmufy9oZg6lUMJxrkU1t3wBFXBxAvsLJi6QfEVu1ND2PKvcgjfCcr++d/PXWaXYgtK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737639539; c=relaxed/simple;
	bh=H6twPTqW2YNPZEHjuhv/7ZZcLpRtPfjqPNicQhiMj0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HytNr3Pe7z11iULRI+/z6Yr/eA4Ct0uRuL9tYBfl0FafAq3Px4VinaKh7uS9vSk9VguQllN6gPyyXmhAjdPKXxAw0FEhsmGWHiSnGA9boO12Wg4dps8eFD4PFZlp4qysKYu+vitYCUdQzd8zyqfjkEIuD1UyaVx4BG8BA5WlnJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPMPpk+7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPMPpk+7"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-542af38ecd6so1121773e87.0
        for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 05:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737639535; x=1738244335; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MoQ9IGp4whEExHxhY59ZLJ44gGy0SbKOPAvP/FBCCqc=;
        b=YPMPpk+7hsL+cEKWU2mDB+TzeyKFL2ngT8LxuxQTe+xm694zxx5+Lg3kzsjx1bF4dt
         8OWfmj99NPXvtA5QNCE1kHul9eARVu9ik+oj0fPpF+fgyHEb5v3aGt/5NmWcxEa/mGE1
         4SqAG/KT3PHyad9nhAih9mJwFLpzmcm8mTul+Umzjq7dkrkALol056kBEHgHwk5xUAhP
         vz3RhbLuDS5ZSYoVLDbTcf882a73Gt46TGTMxwvUcpNzcAr9bG8L0C86gOsQrTnei8ns
         L1d/S16YAGRIFsXaCSoFQu15cELQwlsw2/C3b6Ma5CXbD5LQr6Oi5WJ4QnPrAAWBK7uR
         TqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737639535; x=1738244335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MoQ9IGp4whEExHxhY59ZLJ44gGy0SbKOPAvP/FBCCqc=;
        b=q9xXZYSk6h/onKYm37QXPqQQRH0lkFHdRXnUcsJu/21ZJhzDi/iKkQM5XgKA7p2l2A
         tkSx0dnFE6vLVbkvYhkErMtE/yWRik9nb44Ozdew6oC4H7Ivf3AnsNygdpqa/IH1Rb3D
         V4Ql3BSI3h8wGHPoaTrG1ANrdQhHLy6XD/etQUqVAjoeQ0QTwigHNB8hOQmbfkELGz4K
         Ew1R7kQhQpz5pFdKjVro4O+EAq9ibL/b/2M8nKM5fiulwGbH9Gps1F+vHN6/ABx0xht0
         eCpC8hLgL4ofpmObIH494o9Izk+N+ANFZD8Qq/gRzxWgs0hNMuv6HOMAjXb+dxsGsciA
         5mLg==
X-Forwarded-Encrypted: i=1; AJvYcCUtw2xaOFe8utiRrfPMfLypglXl5IM6JX5F5RQe0UOnZPAKzHiLf0mBZfM4MIoVXyFV0srQYw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1Agl11p6X3aYjdy6aZSQhoDtw1wPCqobjxKkpugEf4SMvkJz5
	4GiIttcymHkrEQ2X59LQbgDNkJqILxsO8Gw/UBbCoPAmhRP+ej4K
X-Gm-Gg: ASbGncuEgpYMySGoKd6GwlPjou0h+PsF/kAWw4dakPtUH+PsPDJAJEIkygF4djcvVtC
	zFzMyHZwx88rO6O8HbYOh+qzhBQ1dpUqCngjwbcWmdaiZTPZe9UyAX1wFsyxws2876jtdPD2P23
	SfZyuTqmNmUnxUsLbcMYiBY/KLLiFt282l7wt8j6ZbgoLmPfVEGEV26Ln2t3CSjJbh4q8GkkzgU
	CB3qNujz443rcfFkMUJY2CyAI6sLwf2q5US1QyoKvqLXBTeNyN/sj6csrQENnpcLnle+B0y4XKD
	u0HOOYbP7Z7tOMHRHWwu4XeREJuvqiStBFGleztSFpWErBJ5LNM=
X-Google-Smtp-Source: AGHT+IEP/6i6xgCw6pTtBHwEU4qFrba14QxCQ2NAPJBPbhpM7DQIw6+UCHWsUtZ5ZgT4V86oDJnX4Q==
X-Received: by 2002:ac2:5a4e:0:b0:540:1d0a:581e with SMTP id 2adb3069b0e04-5439c253dcbmr7950917e87.28.1737639535131;
        Thu, 23 Jan 2025 05:38:55 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af7900asm2636582e87.249.2025.01.23.05.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 05:38:54 -0800 (PST)
Message-ID: <cd25d3a6-c203-4460-ab7c-81fa4b56c566@gmail.com>
Date: Thu, 23 Jan 2025 15:38:53 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <20250123132940.1f3c2666@mordecai.tesarici.cz>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <20250123132940.1f3c2666@mordecai.tesarici.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 23/01/2025 14:30, Petr Tesařík wrote:
> On Thu, 23 Jan 2025 12:42:58 +0200
> Abdiel Janulgue <abdiel.janulgue@gmail.com> wrote:
>> +
>> +    /// Reads data from the region starting from `offset` as a slice.
>> +    /// `offset` and `count` are in units of `T`, not the number of bytes.
>> +    ///
>> +    /// Due to the safety requirements of slice, the data returned should be regarded by the
>> +    /// caller as a snapshot of the region when this function is called, as the region could
>> +    /// be modified by the device at anytime. For ringbuffer type of r/w access or use-cases
>> +    /// where the pointer to the live data is needed, `start_ptr()` or `start_ptr_mut()`
>> +    /// could be used instead.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that no hardware operations that involve the buffer are currently
>> +    /// taking place while the returned slice is live.
>> +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
>> +        if offset + count >= self.count {
> 
> I'm probably missing something, but how do you know that this addition
> can't overflow? I mean, since this is a public function, users can do
> something dumb such as buf.as_slice(usize::MAX, n), can't they?
> 
> What about something like:
> 
>      let end = offset.checked_add(count).ok_or(EOVERFLOW)?;
>      if end >= self.count { ... }
>

Makes sense. This could also just return EINVAL instead of EOVERFLOW, 
but either way is fine with me.

Miguel, what do you think? Would it be possible just include this change 
and the one below locally if you think this series is ready for merging?

Regards,
Abdiel

>> +            return Err(EINVAL);
>> +        }
>> +        // SAFETY:
>> +        // - The pointer is valid due to type invariant on `CoherentAllocation`,
>> +        // we've just checked that the range and index is within bounds. The immutability of the
>> +        // of data is also guaranteed by the safety requirements of the function.
>> +        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
>> +        // that `self.count` won't overflow early in the constructor.
>> +        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.add(offset), count) })
>> +    }
>> +
>> +    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
>> +    /// number of bytes.
>> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
>> +        if offset + src.len() >= self.count {
> 
> Same here.
> 
> Petr T

