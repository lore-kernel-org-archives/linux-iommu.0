Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01837485
	for <iommu@lists.linux.dev>; Mon,  2 Jun 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748867163; cv=none; b=VPgOOAvt9wNWzsEeNDlV2FVMHwr+Mgsvqduh/APAhRnbGQH8rQN1zBK11zncNo8n3VJuaaTXLCWQDsh7KIKiDVEq5/u33tQ9Qyst7ElDMASY2yKcjmnsfB3nEFDY38OKkhTc9kORImyEH1K8sDiARGuP6Tnejm+pS6K8QjBvPrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748867163; c=relaxed/simple;
	bh=IvyJNoELFWAc1pwZK+On2sYk30E3H6Bv/8JU7bkB85k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvfduy/ST6xibayLarFX4kfKxuEndm+PJ4EvTxCJkfh/7Xn5iNhy0bl7hNat56R8Qg2Cc9/K2g9ll4ZTVtyis9yS8z6q41Vsi0vA6cZuOFf/GC/2FOhJb6qDKVWZ/towUFEMy8GGSD6lm5hOGxXnL0wF5uYLX6MYuqFqllF7uJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtNidmfe; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtNidmfe"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32a806ef504so39232101fa.3
        for <iommu@lists.linux.dev>; Mon, 02 Jun 2025 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748867160; x=1749471960; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+xZ+1rNLzamfg62JThm32IA/jBJvxSiOUYhQofWR7Y=;
        b=VtNidmfe4/nq0XzcctFV4EQvulPudhrrcZy0PptMEdqEBcVCBlscVdZgh9CMynKDQ6
         jDqvXM44eUEmObYx3LRYh/Ik0mW60i0FF5+VW+UPIUDyMdca4BONTigKkhSpGiE0rmIu
         vGo6evQv2MVFJfxQxvJpMADiDkYDY2x+UZfycaMjBnXn96GXp8ODUXSrFrbrjow2txi8
         k+pgRgFvbo5SNrmTll3fE6ma0E3wSKK8C3jol9sP0a116Zn6Wy9p4ofiSwglhytfSZ1Q
         E7GoSe5ojlKRSQkx5bJ60zdOe5pjtvDCEMJ6uS87fFlXESMp1cLAnQ1zEsttTputFfrm
         HKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748867160; x=1749471960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+xZ+1rNLzamfg62JThm32IA/jBJvxSiOUYhQofWR7Y=;
        b=cCfe2vlptypmHNJt0hopnGdDnfB5JrnQHmst5GrKL/rUsMLRfYTDVjn0Z/6V9fqMaR
         6TayjuAgcuzhSNwRzsNMJ4fayLcSXhRG1+CmI/c0mCkm9YzUX40OzvQqTHtEzXxH0JBY
         7QSvocj7GF0d5muszIcVXdftjOA9ekfeXifYth/bHp98E78MYnNxuxQ+hs8jpJduJoRL
         +ffj5fkunwZXe+V8m5VUoMb8lUi1NhNXLm8ognq8jS/NeCKCHRC3H7fs6QBmQ0b+k4Ie
         WIU+ZO5i5vjxdcZLhonY6fQKFxL9j2vt+2VUq3F2QA8gveTkpGXdcPDFE7flwcpajcQr
         uu1w==
X-Forwarded-Encrypted: i=1; AJvYcCWT3oob3YJ/tOPfmQChD9P3vW11NCnTFwiHo5AiNqbiAaU4XcfKACuR5unpBlUZKYLLEzGlqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJT7K+pFB9UpXKQn4i7mxS+OCWaos3igWCtoId24+2PVFGBRJv
	mwEbFjUi9T89Ia3hzp7/u+Jw6IG6inZ93uDgEAzoJMfO6EnZLI12JA/B
X-Gm-Gg: ASbGncvINpQFEundgmbV2aRWqKlwzvgTyhaU3Yr+6L8hSdvqNhP7Lls4GXdz/EqEp5l
	N+7teMsbRbXXC1v+2FJb+x0JtIHV+qAUQhQr0av9JrG33/zZ0w5IYILGHZkjdfzbsTo4DCDIlV4
	rQcKBHYZGtvKWBrpdV7qCqvPmifZjf6aP4Pui5uAOpZNs2T9n1P55FPsSWy/9w5ZtdcB51/WFw2
	sk5mHeGD49AXTz18VBB8Q5ax0tMqVOhRHZJLflE5p3vAUpfPa79aisXDCzyj/zshZDdOKgg7aNe
	iiWHzbyIqfFJI3+nNe2HhJb/qlj5wsJ19tDvuQuY5m98AGzoBec4ImGj6W/SNtWJ4NK+KNLub5L
	1GTU6MN32K4SYR8Vp4MY/udkVkzk9cfDz4m5lLzw=
X-Google-Smtp-Source: AGHT+IHfLZLW7auV30M3BKqzYy/PS/uhPlzd7MURt+DLuiKZmTu4Csl3qjOP0d7BohBDI7Zrb+dLMQ==
X-Received: by 2002:a05:651c:3247:20b0:32a:8c95:d841 with SMTP id 38308e7fff4ca-32a9e9cee67mr11289011fa.14.1748867159569;
        Mon, 02 Jun 2025 05:25:59 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a85b527ecsm15045091fa.48.2025.06.02.05.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 05:25:59 -0700 (PDT)
Message-ID: <5380b2a1-8a92-4362-a014-132fbc301579@gmail.com>
Date: Mon, 2 Jun 2025 15:25:58 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
To: Jason Gunthorpe <jgg@ziepe.ca>, Alexandre Courbot <acourbot@nvidia.com>
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
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca> <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
 <20250530141419.GA292183@ziepe.ca> <DA9KQF9CY77R.77PBMU8Y1FPY@nvidia.com>
 <20250530145026.GB293473@ziepe.ca> <DAAD0NZOCHS5.9FTVJIOI12QI@nvidia.com>
 <20250602114047.GA298147@ziepe.ca>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <20250602114047.GA298147@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/06/2025 14:40, Jason Gunthorpe wrote:
> On Sat, May 31, 2025 at 09:54:20PM +0900, Alexandre Courbot wrote:
> 
>> So if I understood your idea correctly, this would mean creating the
>> SGTable and mapping it in one call, eschewing the typestate entirely?
> 
> Probably no need for a type state
> 
>> And the `SGTable` would own the backing data, and only release it upon
>> destruction and unmapping?
> 
> But I don't think you can do this, it is not allowed to pin kmalloc
> memory for instance so you have to do something as you showed to tie
> the lifetime to the kmalloc across the sgtable lifetime.
> 

We could explicitly have the SGTable own the backing store, so the 
lifetime of the pages is connected to it? ie., we have a VVec with the 
kmalloc allocator, instead of passing a a reference to pages, one could 
have the page builder something in the likes of:

sgt.init(||
	let k = Vec::<PageSlice, Kmalloc>::new();
	k.reserve(pages, GFP_KERNEL) {
	...
	)

Anyway this probably needs the related (still WIP btw) support in: 
https://lore.kernel.org/rust-for-linux/20241119112408.779243-3-abdiel.janulgue@gmail.com/ 


/Abdiel

