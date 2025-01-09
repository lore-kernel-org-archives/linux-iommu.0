Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975E72153FE
	for <iommu@lists.linux.dev>; Thu,  9 Jan 2025 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736421272; cv=none; b=KKhHcuGwAadKhzUBbzdbfJkhr0M2cuktM3JG45JbaITKR1ZLhqd0Dxl3CNEFQb+YDNsnuzhGO2ZQ1THNsiCMS2JOtvGsGfes+4Py3jIuw4aCcfEXnI744CibzivFuKrUCPUQKNlyAmcLqY79AMPfzJz+7QrlJJPWyC46zKpPJkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736421272; c=relaxed/simple;
	bh=OWWcFlbpG+OMXb7VXzYJPRO+OVmfyWw2GlvoPFeUbws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5X68BhyYpgA3BWvzBwxf72rAZvPR1ovHovjWyXrgxoHUmhJZukboYU0fx5V+Vm2Nz70AwesJesWTwhxn6D92T3kTtqab5OrafjLm7uRktpcHB+TLPTnlqjiDwRi/F/udlbTchg7Enx1CdymOTQxF4e6NIQXPVOrXbY2U20p0PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKuN+0YF; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKuN+0YF"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-540201cfedbso755449e87.3
        for <iommu@lists.linux.dev>; Thu, 09 Jan 2025 03:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736421269; x=1737026069; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CDSrvt1tvrLZL3pv39ao1tOanTPvH3WNKnuKQXw/zNM=;
        b=DKuN+0YFzq88Eo3MFn1uuSWOd/z/M8Sx0dZ9dqkTtat4wdCRHqUR8CLuzNi/bW/jx3
         whaEyK3Rbw6lUj6lmapYasvCpcVxAEtMqPC6aBYJ/Sxmeh9S8WNr3UH9pQ0SM+987bua
         FOTYmSHjcr9Vm4xNdDng5nwg5CT76YNXgJBIukb9VXTsYXBMJBO9DKwllwHfl/8xrKbP
         P5shR73eQwhBIeDEgb56Cr+QrgKWgVHQD5fBBe+DinDXhEQdmIFy94AbIeUaSAB89Yr2
         fgrB3Fjzp7bU50wTcibCHkAU2ADdYieIc4S7ecTnFX4+3i59j1HFWocSmJckNoQX+LIp
         K1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736421269; x=1737026069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDSrvt1tvrLZL3pv39ao1tOanTPvH3WNKnuKQXw/zNM=;
        b=PJUvBUiBAY9Tih/dMW5oHAQJY9R4EgjfCI1Lj4ib/QdLO/p+9cgWSAeqJQF9ECH9+Q
         1Lz0+CDrY521zcWWAj9QNjC3XZpDk3l2HRSJGezy/vzKNo1SeyyAdTxO88AIYpnMLHBh
         V8UMkDVlRFljiMua+YGN/qEQAFQBp+Bloqe10S+ztrMh1o1JWdzDKnfU2gSEUtNQv3g3
         /ss1SnL016Q8reNS8HtJNZdDWoaonhjWC4NtTxbv2PBBNBEiw9UzIiBka12l9ujmvGVz
         S8gI6vOBH+FE5XQFti05iLBbMTlIk09FTU5X0+0cGwChsoFieUFQLL1u+xd6bHloNTnu
         1oyg==
X-Forwarded-Encrypted: i=1; AJvYcCV8sq8K/X5e4sq0qv7KuJueWM5lxN82nZMpxMsaLDI6DsV0wcfc7PBQecfBgvXRT8MFGBsizA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcnCKCMQ3wAEC7extLFb9JtqW+DIpNlP+NiNVEkzw50hvz1sA+
	RVdVka4nLHS5/dY8vQz6x2wDNXVbWRD5W6KkCdX5c+GXJ+Bal4V+
X-Gm-Gg: ASbGncu7JWnezPnQLf+xTp3VB67dccxdix114CX2KmmtHh0DN82d2WuHkV8XRqFMNPR
	BZXcc4UqZGVuJ6CzPRkaVF3mmhcCNr4sFOrxBN+vkuf9EFExWQHhj83Gyca27inrR6qJ1S2lWwq
	rm2E2UyNCwBJn4Z+IOBHGvNR7CGRQZWLQpaGrt1CKcNF7AAFeiMBrGqAr4N8j2gwoAuXMTqw5IK
	DQtDvWbLPI0HcUzyTtl6W4abHlwcnuIFmQelZgDntV9rJkiQL+QLapDiCHiLy3Bc7h2jJbYQPj6
	RW8Mb/QVCcYaU2xrmSDm547OqKw=
X-Google-Smtp-Source: AGHT+IGOTFBWUf0qMr+9PwwTq2Kyqqb8CpMObKdP6HCrxE2MChgbnsJPBPgxn4nmfxGO5Li8ZWHrqQ==
X-Received: by 2002:a05:6512:2399:b0:542:19ef:9877 with SMTP id 2adb3069b0e04-542845232d2mr1720792e87.17.1736421268391;
        Thu, 09 Jan 2025 03:14:28 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428be49e2esm165503e87.29.2025.01.09.03.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 03:14:26 -0800 (PST)
Message-ID: <ba95a574-2dba-4299-9ec4-bb776a228d98@gmail.com>
Date: Thu, 9 Jan 2025 13:14:25 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
To: Daniel Almeida <daniel.almeida@collabora.com>,
 Daniel Sedlak <daniel@sedlak.dev>
Cc: aliceryhl@google.com, robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
 <20250108122825.136021-3-abdiel.janulgue@gmail.com>
 <588af6c5-02cf-437a-a909-c22744a6df1c@sedlak.dev>
 <EFC67281-5CE1-44BC-92A5-7B0E4A7FB6AD@collabora.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <EFC67281-5CE1-44BC-92A5-7B0E4A7FB6AD@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 08/01/2025 21:09, Daniel Almeida wrote:
> I was trying to test this again, but it apparently doesn’t compile for the reasons
> Daniel Sedlak pointed out above.
> 

Okay, now I noticed the problem.

bindgen generates this rust signature for dma_alloc_attrs():

extern "C" {
     pub fn dma_alloc_attrs(
         dev: *mut device,
         size: usize,
         dma_handle: *mut dma_addr_t,
         flag: gfp_t,
         attrs: ffi::c_ulong,
     ) -> *mut ffi::c_void;
}

We are interested in the last argument 'attrs'. For some reason it seems 
ffi::c_ulong is defined as usize at least on top of `rust-next` commit 
0c5928deada15a8d075516e6e0d9ee19011bb000.

In previous versions ffi::c_ulong used to be u64. I also noticed that 
core::ffi::c_ulong is u64 while crate::ffi::c_ulong is usize. In the 
previous versions they're both u64.

So my mistake here as is I tried to match the signature manually by 
using usize as suggested by the compiler. Maybe we should stick to 
ffi::c_ulong return type for Attrs::as_raw() to be in sync the 
bindgen-generated interface?

Regards,
Abdiel

