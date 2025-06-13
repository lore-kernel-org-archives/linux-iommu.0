Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909ED2C327C
	for <iommu@lists.linux.dev>; Fri, 13 Jun 2025 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807922; cv=none; b=UR8W8AT/jC6yvlhDTwJXILlniiMSO03sbjUpOpL8KNSO67GObb/ur5WOmt0+EerT7auy6EE9mSl/s2EAbCwgipBNZqv4+/oVRoMkESCXN03+SyD1cbvtGTqIblNtpCkAcQRVmG3lSrPE5p68MfxsuaCUmwlIUYHP7Nu4zAzUUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807922; c=relaxed/simple;
	bh=2bAxLZdmW+dB6hgjHfQTeJYs5D2kkGbxxoTra19Jy04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqc+aRuvnctxVwb410d16WzeIOTPNN2kuqmC3OC2p54Mk+/kvZM5mw8c0NDUld1TY6cRC5gpiEMv17b0qcNDR+KZbxO5ocHGAJfN/L/xQMYAfQAoJX6sqPVB5fo3lJFBdDgNEgpOlDTXfDc1p8bsXfv91gopS5MbIqFsLT46+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1Dy7iUt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1Dy7iUt"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553b544e7b4so31366e87.3
        for <iommu@lists.linux.dev>; Fri, 13 Jun 2025 02:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749807917; x=1750412717; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxrGh0fCLnQwX4nzD6CTGfjfOhrw6Z6qm6oKUUOWy6s=;
        b=T1Dy7iUtQWnRcs2IBDUKkTCZVDbHalrs1MUPXqGfrhIs/StuW5Zs5DG4NvbJscxeds
         05thNOyUGv3+KydKHMkwVTTmIGAEFpJW09BAfymhrTNdTve3sx1HoFOsZ7bZMloY43Gq
         wLJBMnA+yjN60OP87XsLMOZoG+PAFSp2pHH5M+bMS68fpNTqB7H1gB0mNFIe4F8dQAQX
         +ZeUYoqNTYEa+HLPLUW9TZTuFUiU2GhoRUVXcwTYE6Ob80uZTb9lPlBSwlmoWaf4v3Bo
         A+76+SPa8cco1eeuLDWH7a0n1PrEBCublDl5m0KZ258wMZGK4/+IItgJEagq/l2LLgk6
         NaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749807917; x=1750412717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxrGh0fCLnQwX4nzD6CTGfjfOhrw6Z6qm6oKUUOWy6s=;
        b=MfRRmFzyTDSFr8j++eRmsr03gxdnSkzs6TpPmBGmNPK5e7BfDm4B+kCn5IRGHbNfT3
         T9RGUaXLNuoah3QSzk0eUA9DHcikxMx43GdHwTi4h43d8oeuGPk3PAKmORdgpTVuvAlX
         EfJxkG37nhYbksarCYer2W2Yc6D97tOoO1cFBR7LTbbUbzXkeL5/rVOtkI26dIDDPjyF
         6uRHNi6N7ENf35ShiZ0HPwqyC4Fd7iPf8f9Py6gG/iS8gYVOVBKchcLFGbzfznr68kGc
         eLojBfTd6nfX9zHJeeJ7m9pYOaWOP+voKJD3POedn+C2evfeQ/U6cTyxBTbvm+Id5cGA
         WQ0g==
X-Forwarded-Encrypted: i=1; AJvYcCUaZOAb6evYPaGEtwipZEgoZ/CpS8oZyM0p+4QxQIpAB7OqHdhLoDmUmtmR1GaiUSWlD8iRCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxj3VFw0gCgYcwMonnUi9qXyuzkpJhYOaIZw/KAc5JwaYLHt3D+
	FJpVy4ss7ls61DSnNxPjCIvfVHPlWWlp5mVm9+Lbxweng2OeFWsDY3zI
X-Gm-Gg: ASbGnctEV/HOVWpg/lnQzk1/4L526HJzymyMydx3zGq80OdDv/3uLt7ZGHjC4TOjlrB
	yPd12HRT8dVgNaQb+pIU0sXtpCLq06QIJcBMwM/DKjKIsboCkmF+AZYPX2jYxsomhfcHX2R5BYh
	zIF9RDDbI0EwdjseFcuX6eYffiivs+gNzwv7yCUdXqEypsg+VnL6Dt/x2AUjYHmQZBxeoB4SyIc
	4V+vvyNfDqM/+1yiq+8J3/DiObaqqpUTRp4P/g+ex6Yet58wXUnEnUctphndg0g2F026Nu3ie7U
	SuZK1dEjkU2fhjulZ7RbsYLwBUjcLdU3UzDfrCTQX35ag8Kszqz25NwqWdpd2r9vmLMW/iqjQu0
	dUdY0aV37L5S8V8yBZVGEhKG1HZnWjrnD8CGxR7o=
X-Google-Smtp-Source: AGHT+IHiJOoevlgKdwDSnmotX6IPm3Uj1/yrY7CfWWn7/KrZu7vk47zHN6lD4iwOK4EjOUhVQcIvWQ==
X-Received: by 2002:a05:6512:114e:b0:553:2f61:58eb with SMTP id 2adb3069b0e04-553af96f227mr619887e87.49.1749807916268;
        Fri, 13 Jun 2025 02:45:16 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1f7799sm381819e87.229.2025.06.13.02.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 02:45:15 -0700 (PDT)
Message-ID: <0b71832f-f3a9-4109-baa1-f29a8327d872@gmail.com>
Date: Fri, 13 Jun 2025 12:45:14 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] rust: dma: add as_slice/write functions for
 CoherentAllocation
To: Alexandre Courbot <acourbot@nvidia.com>, dakr@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
 rust-for-linux@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Petr Tesarik <petr@tesarici.cz>, Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Sui Jingfeng <sui.jingfeng@linux.dev>, Randy Dunlap <rdunlap@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
References: <20250602085444.1925053-1-abdiel.janulgue@gmail.com>
 <20250602085444.1925053-4-abdiel.janulgue@gmail.com>
 <DAC2ILD2DSIZ.3TF8W39X5DDH8@nvidia.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <DAC2ILD2DSIZ.3TF8W39X5DDH8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/2025 16:05, Alexandre Courbot wrote:
> On Mon Jun 2, 2025 at 5:53 PM JST, Abdiel Janulgue wrote:
>> Add unsafe accessors for the region for reading or writing large
>> blocks of data.
>>
>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> 
> A couple remaining nits/questions below, but FWIW:
> 
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>> +
>> +    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
>> +    /// number of bytes.
> 
> Reading this sentence it occured to me that `offset` may be ambiguous
> here, as in my mind it rings as being in bytes unit. How about using
> `index` throughout the file?

Thanks! I don't have any strong opinion about this, I think it's enough 
that the subsequent paragraph makes it clear that the unit is in bytes 
unit? In any case, this could this be updated later after the merge?

>> +    /// ```
>> +    pub unsafe fn write(&self, src: &[T], offset: usize) -> Result {
> 
> Can this function be written by leveraging `as_slice_mut` and
> `clone_from_slice`?

using `slice::clone_from_slice` would enforce the length of the coherent 
allocation to be always the same as src data. Not sure if that is what 
we want. Also, instead of just a straight memcpy, this would go through 
a 2-step layer (a call to `slice::from_raw_parts_mut` and then the 
`slice::clone_from_slice` itself)?.


Regards,
Abdiel
