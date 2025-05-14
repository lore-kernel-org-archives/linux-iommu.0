Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B71F1921
	for <iommu@lists.linux.dev>; Wed, 14 May 2025 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206063; cv=none; b=XaSSs2K8PXoqY7U0Yn/7zpJYr2bZRzMZd1ix0ht+DELtfwDcuUgjG67TAKts3wCM/y++Mmte8HQX989Sv/SJYXU4yZN+QHwslfHR09UtXJxNPaiv2xnWhIaDlzXsA53K+QGAgFokSX8sW0GXKqVzP6VYUpRpIMn9cAhWAtsRaNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206063; c=relaxed/simple;
	bh=00TG9hraW+ho4aYNxAKghUbX1JBVLpm/zp47GHTcitw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cThG7r4rm3Ez9UhC6x7fM4SOPmPmKluINqIEMfyNaU4W2vno8nUoc13/sk2llb3q8RT2BjkPBUCPfa3EOAXuj5RgDNMUnbw0LqEpyP4gjzSDNAN95CcOgqYtIRaHCdaNqrF6gl88eykOBYOx/UzcSbvfyaEGjFftpjk3FmyBrHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzy7UdMR; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzy7UdMR"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54fcb7e3474so4756521e87.2
        for <iommu@lists.linux.dev>; Wed, 14 May 2025 00:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747206060; x=1747810860; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4UWq00FQ3wfcO8+cSz3Rl5HWcj+xSQgpD/JijtD+sU=;
        b=bzy7UdMRaxUGZkeXUP/F/oeb9tcqblosepBa5JJJ3b5tWb6lOj9u4Zd3jGUaXiupFG
         lzdcZdA0NTrMWfNul8MZBTiLjhy8fwOqWcVkNSxVzAiGYxhxPHoZz82BjsbvLOUtQVw9
         /V/lSHvyCvyctg/pmTFZdCQSqY+5WfKVAnisAfPPwtuQ0f2AN3AKz6yMCnQZucEyw2wt
         H62HCpOItrUHsGw0nkpRkmQyfiSWx0JTClbDwwZjKJYYzItNQ1a1jCAtJIDs/uYacp57
         by0iV07/gazx6Yy/3XocACQqsmGSP2DePJM+qbL8xTh+VVT37K27kRn+pMXPGOOiDK1N
         cUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747206060; x=1747810860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4UWq00FQ3wfcO8+cSz3Rl5HWcj+xSQgpD/JijtD+sU=;
        b=jRT0A3B+PL4T8BiPrHBe6lq2DFD3m/lG1GzQwALRXChISREpgyg7d5IX1O2DyrcIYW
         D7IsyTg8K2J+WXbwra08+UlIv+FGWk0aMDoLU65lhFVDzVTRSTKoWrSYr2VPYqT7ql+O
         VVz9uLlVsKR5o6+e6p7ZycBZZJQ15BVc3+7LRv7H1cyn3e86SnwC+kk5p2f9CU2sTL8Z
         wYIp/pz0Eq39ZIGX2KN+kGDH1wxj7J7NhRqxE5fsiJZeQ7pR0WHwjGNc80fdPS81UOcH
         VA+G9LUu4op1SCqBI3XP7E0PBFQzha+jY7N85Jzg86MhJ7yV2oHzNjxjN9X5ltyJ2ADJ
         tEVA==
X-Forwarded-Encrypted: i=1; AJvYcCV5bFLGQGeTJEa6aosZ4mKm3T0Xwnp9Hjl+mLP3SRbIA3yTT6UWSQt5/t0Acpaw+afa2sWpWw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywkc93hfuFjlcmQD1yraj5HXIg9JzFyeFiA8cRrbMdOf1N++MrG
	11KYYlE5wkXPIMWcDnBr75BCJkDYCX/U+6gGLSIO26IIs19gR1GU
X-Gm-Gg: ASbGnctA0eX7OAfQn6NxtnKELh/hjJ6RY+/QozaVlUQl15bbvwCM4uoYY5ho/6LbT+U
	VeaShXLdSGFSt6R+tV6mNCAomzoSYAIx1T92ALtlofYKVFQlFJg85e3VW4vvYJepebaC0Xo0D7G
	EWQLMPuyQqLsUx/ltScG8XhJIZJtPltU2508dFV8sL3R+OxzxdbscEvZalez8iH3sBWBlXYF1fn
	6aQ+UZq33ucYTS3wqlBBot2s41goNQn1iTFZO1EURWVHD7Swn5oEbxTw1C0PYnYqr61Dv3QZRQa
	gvj9GQkpDpONXy9BNjS9kxTv22znLdjCcP8Pi+HzErdCXhEUHJMlZeBwBu+woID7CWYzpUr8Yso
	J3IYu6rXuN/RIFSibiVSD8oXcvtT/4iLuENI9n6A=
X-Google-Smtp-Source: AGHT+IHFvZG1KdFnKOihoApsIRTLV2xT/k/MQynT2nLT5kj+9wfpveOdmyHEDnx5dVQDVckkFIOS+Q==
X-Received: by 2002:a05:6512:6c4:b0:54f:c57d:d25 with SMTP id 2adb3069b0e04-550d61ddbe6mr762503e87.48.1747206059504;
        Wed, 14 May 2025 00:00:59 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550d747b54bsm145249e87.216.2025.05.14.00.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 00:00:58 -0700 (PDT)
Message-ID: <77afb898-fe6e-480d-9b7a-05cc31d8545b@gmail.com>
Date: Wed, 14 May 2025 10:00:58 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] scatterlist rust bindings
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: dakr@kernel.org, lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
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
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
 <78DB1F66-9DF5-4679-ADC4-177BED5D4FDE@collabora.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <78DB1F66-9DF5-4679-ADC4-177BED5D4FDE@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/05/2025 14:19, Daniel Almeida wrote:
> Hi Abdiel,
> 
>> On 12 May 2025, at 06:53, Abdiel Janulgue <abdiel.janulgue@gmail.com> wrote:
>>
>> Hi,
>>
>> Here are the scatterlist bindings that has been brewing for a while in my
>> local tree while working with Nova code. The bindings are used mostly to
>> build the radix3 table from the GSP firmware which is loaded via dma.
>> This interface can be used on top of existing kernel scatterlist objects
>> or to allocate a new one from scratch.
>>
>> Some questions still need to be resolved, which mostly come from
>> the DeviceSGTable::dma_map() function. Primarily, what if you call
>> bindings::dma_map_sgtable() on an already mapped sg_table? From my
> 
> Perhaps we should introduce a type for buffers which are known to be mapped. Then
> we can simply not offer the option to map for that type.
> 
>> experiments it doesn't seem to do anything and no indication is returned if
>> the call succeeded or not. Should we save the "mapping info" to a list
>> everytime we call DeviceSGTable::dma_map more than once?
> 
> What mapping info are you referring to?
> 
Basically the dma_data_direction enum and possibly `Device`, if we 
decouple SGTable from the device. So this approach would mean that 
every-time SGTable::dma_map() is called, unique mapping object(s) would 
be created, and which would get unmapped later on the destructor:

struct SgtDmaMap {
     dev: ARef<Device>,
     dir: DmaDataDirection,
}

impl SgtDmaMap {
     /// Creates a new mapping object
     fn new(dev: &Device, dir: DmaDataDirection) -> Self {
         Self { dev: dev.into(), dir, }
     }
}
...
...

impl SGTable {
     pub fn dma_map(dev: &Device, dir: DmaDataDirection) -> 
Result<SgtDmaMap>

But I'm not sure if there is any point to that as the C 
`dma_map_sgtable()` doesn't seem to care anyway (I could be wrong with 
this) if the sg_table gets mapped more than once?

Regards,
Abdiel
