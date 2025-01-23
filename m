Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE585320B
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737639477; cv=none; b=J2CNZzN30CWtISBlhDjZVxj9Oe3wmcGr1I+01c1bvKqcPndtzkM13OWRRYgekqKq7LhYxYedThxzcXwG6pI/3kxAIPFd1JgdR3Ms9SLzUDXOVYxq4UD0qBzeAyDmGgAzQtJaNJJZePYzn8LWsM2y3+5zKhRxAKJ2BZqvxX3Kk5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737639477; c=relaxed/simple;
	bh=dWwkvG0NgJkuDKDCVMlgsAAcUGE/cRUVyUcEKt93XTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPXm4wJWfHBkrR4Kdpn82IiHwL7DcCqMDWb6uB+UDaOvFpTugqTtskzX3EDgssLit/MRZaJkuS8sDVPwXYOh3/o+YB52/mFQcAkQYFho4KtfVGlpI4oEoF0Tm7Gr692baQOTaWjXMPXQTPdiydFL9eigZpu5Gkxfr+Lo/3gtxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MB4IkcG2; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB4IkcG2"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso1005020e87.0
        for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 05:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737639474; x=1738244274; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/MMgpKl63Du7VL4wEl7ZQDO+gVwz7TEMPUfjQb0S+9E=;
        b=MB4IkcG2RbEwkdGwnWWlAgmQtAiVa5MrUOL2SNeyqdzyTrXN07pUQ/2e2TyHimOEs9
         zPVadprrSzORIf4pIaIY3RDX9Mak5hwmAeb/ZTrlZU/LtidDaS0GBQYAsQww9H67+2RM
         n2bnxghinZHqbZH8aTKYN5bDWJaUWg2vSGWQ3oDFiZDFWcaaaUyZ/WTPZHm2LMSCgsc1
         cvyH9BcbnR/EhHFCpsrmrTqh8bMRwKpNbyBJWn11/C89EMQrCUf3YTm6VizbC03i2XXm
         SVIaghgSCty6iSTKYN1T33cuRrhq4UK5j1gmwTfpeYOToxiwFb7M+tTCvOvMpSTZspu+
         mX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737639474; x=1738244274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/MMgpKl63Du7VL4wEl7ZQDO+gVwz7TEMPUfjQb0S+9E=;
        b=TVCkd4WwA6veff8B3y5CrgksX+5Pa2B9wxzxfjaTZcN2pA7uTpdY0Yl5vHxptbWs5m
         ppy7OvqHIoXyytNGe9mmxAmeHqrfOGMecuHtcxxu7uVk7g2/T2W2RIv6rSUYQhBC+8al
         sw3KISijjhCwSp5FTAD0BcH0+YVEzntuV9y3FslFFSpzSz851z62/nThtbZ95B20RMNI
         TYm7Gs1Bfab7nUosxeoSwM8GdEojIV0S7apsEmkWJtgYr9BUFE0FUW10Bhd0nmV+JlX7
         RTmWuhVSikTfh7ZabViudJJpHnCAopYkwYko9m0aftQ14XysWIPwV22pSicEDjx7ajju
         ZrpA==
X-Forwarded-Encrypted: i=1; AJvYcCVCWIiqsFvd1dpaPSYLXglsRYBafBZT9+jGkVAczldWv0v5mbogKgB7q8poIJsNZv2+NtMv5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIwu7EbBaTnJkpP56gexY9py2NUQW7fZ0ZQqgNxAvWuBbZPAHs
	QRTVmpnevLas3s81QoFfTFmSnOsZoVqzC6z7i/x/okZbDmrMK5Um
X-Gm-Gg: ASbGncvvS2cW5do6mcm6Fya+HAEWx5V1uBJeLf7eKy593MKUvqzbnF2iTKHzCpSmjIQ
	H7KQ3ip2Ogpdg0ZvWax47LzZdc+fhu+BNiZ2TEgMAUb8VN+NF7eQULzngdBjT7mRtzPYdxLtS2M
	LQK2jPZu4K0/cPmNbj+FLSk7mEta8pF/SKOQ0hLS0o2N1NOdJmzkMwRqVpRDn3aNN1ejyurZ6g/
	xW1NLrnhbi8VumL2CzSiRMAhWFFO1KPhwyxzvAWK0XBnGZczs1XVQpFiREdNi8SjNKwsNKdto54
	7rChPIJoJxaqT4GjYGh7XVbsr5KCLs4WHWC2DFA1jAYRaVTp3P8uds2fErPu9Q==
X-Google-Smtp-Source: AGHT+IGpH+jo8gywfkjdem5Cs1IfguO8yO2Jw4lhNXYRnXDJ1vlhdmkHqTpFhzY0l3OErzRsN1T9Bg==
X-Received: by 2002:ac2:511e:0:b0:542:98bb:5678 with SMTP id 2adb3069b0e04-5439c248293mr6346876e87.25.1737639473446;
        Thu, 23 Jan 2025 05:37:53 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af60942sm2680774e87.134.2025.01.23.05.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 05:37:51 -0800 (PST)
Message-ID: <ddc185e6-3fee-40ea-ab55-b0f414e0f015@gmail.com>
Date: Thu, 23 Jan 2025 15:37:50 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] rust: add dma coherent allocator abstraction.
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 dakr@kernel.org, robin.murphy@arm.com, daniel@sedlak.dev,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250121084756.1051758-1-abdiel.janulgue@gmail.com>
 <20250121084756.1051758-3-abdiel.janulgue@gmail.com>
 <Z4_7-jbmeQ62hMb0@tardis.local>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <Z4_7-jbmeQ62hMb0@tardis.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/01/2025 21:56, Boqun Feng wrote:
> On Tue, Jan 21, 2025 at 10:47:46AM +0200, Abdiel Janulgue wrote:
> [...]
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
>> +    pub unsafe fn read(&self, offset: usize, count: usize) -> Result<&[T]> {
> 
> I don't think `read()` is a proper name here since this function only
> provides a slice for the caller to read. How about `as_slice()`? Or you
> can change the function signature to:
> 
> 	read(&self, offset, usize, count: usize, dst: &mut [T]) -> Result
> 

Thanks for the feedback! I've now changed this in v10 onwards.

/Abdiel


> Regards,
> Boqun
> 
>> +        if offset + count >= self.count {
>> +            return Err(EINVAL);
>> +        }
>> +        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation`,
>> +        // we've just checked that the range and index is within bounds. The immutability of the
>> +        // of data is also guaranteed by the safety requirements of the function.
>> +        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.wrapping_add(offset), count) })
>> +    }
>> +
> [...]

