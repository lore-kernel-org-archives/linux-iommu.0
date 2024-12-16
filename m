Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84C4202F8C
	for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344898; cv=none; b=bkrFRZwl5KbB3JFqYNWXF57md2z7gCxQAhMJxJcGTmOPzp07bnVs4MEBowHSSre1oFpVhpVVBozJnQ44tcL0n1ov8EF5D5wnRTF2EL3HKEw436qtLeZJQrpdoq/q+DvilW+OaxVLCqJjqLx9jRiOgceWngkeidQ6yFJ7nWRifl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344898; c=relaxed/simple;
	bh=I6SS3jrfUdbjQxbfuV3zgKgJ1lGXHpGlboZOPNu8/w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QipuQ3j3j9e4UY2yJXnu/HY17+sA3pDQBFrauX097hyBEdrJTY8JbQjKtUFejEB7eaSAUM3xoRcb7VK03o+kZ764sPH0N3i+lcNW3PLxcq4UJUX/LqmNDWIxcGKOosV19lgTrLGX329zgfGfPc09tt0gpzOLFTzgepIZYUhRjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpOzxNAX; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpOzxNAX"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54020b0dcd2so5541790e87.1
        for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 02:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734344895; x=1734949695; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qo4gtspC0QWz1YSfHZwlyzeb7x8qKi22+rub3ebtAOs=;
        b=DpOzxNAXdd8fyZ3qiPsDWr4OdjGrKsqjb4GTjMhMj6c6PB6H2xFT00oO5B452Bqptt
         iZFGr6kW+P3/ODOx6estAfjSb7I5MPhDoy39wX2ADcePF0SFqskPZrAOXv14vkSqgW2b
         nt2XKNWn9DKED3dImHVmX1EnUFPIn5Sw7lO1VwKp3ryVPYh5pEyfUfCIuYYfzKN70zOX
         Y126E0T3NL9/eDoLmUXDWf0BiBcvnQkh2GPegVSoEcrsicMLl8vShqzy/ZQbYowOiKhr
         pYtLZ/Aj06C3zPGwPXOLSwVsgPMiHr8zQkim7LLpCulEpU6Kj1zeUfRUthbChWXjXW12
         2nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344895; x=1734949695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qo4gtspC0QWz1YSfHZwlyzeb7x8qKi22+rub3ebtAOs=;
        b=N6wOL30NInNPXt2pdsjDinyxWSMW74kJfqGWg5qcr8iPTLp/bU28k5EkxFwxHYoBIW
         q62bOW8FVglPOIbwJK2uiQkRqCRMeip7lnTl0shSzW7h/lbtI8+DN6ALFCFteAZSAi4g
         qm1tCAglJPIcZT25aNaXJZtnwIMCO5qj53EU5DP0vdXXnv8C3LhA7kl3Soe1pJ/EznKn
         aOL/uBf4PE5awpuB8+O5gRWEEvGu8nr91A7dfRWCRVOwW1oSg4UoSZe1t25oyazmK83N
         0dX6VYOHqzsZYD71GIrPJ1WaDXoTFwcS2oPhSyR/rUIccZIh3QN9g8sL1ncz5nyDF7kd
         olvw==
X-Forwarded-Encrypted: i=1; AJvYcCUqVz2VeJFSBk+ZdkYjtS785BM/OqRSMLr3bGFEfz+84RnsDBsoZM0PgdA85yo+7y7dnFbahQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrV3Rd0E/L0y1ylHbZz8dcjRcijlSy2nSWkhkCMdwUN7S/C36w
	n28iAIP+bJW/N45G7PkOw2xT1DBVUzMNtTJVkKTCEM5mvd+P/ds6
X-Gm-Gg: ASbGncvDZt++qkH/OcSzgLArlM8I6xXsdv6knrs5MiuOQz/JTSBX5qQoTTXgvBZ2+Go
	iwc9loG6v2lKkveuji4JGaAmjwZKKOr8twYbr747LB+sDuTK8d5QQmA2uhSUmHPZ8BuAZgj0hfy
	XtiesOnoPuD7P8KZz5P6nE42Y9vjLiSdfPsRFho9kYZLOaK86OdQG3+KumToHD67y6b8WkX0O2l
	h4dU8+XCj0/UPgj6nerGTqJsdm45aow8suXIqrV5k+jUXxcuRPNQlhVbmDi8yChUoBm64kvC7Na
	WZFBl+ZviR0/iuvA7XQzG7R7vEg=
X-Google-Smtp-Source: AGHT+IHKteDfC2OCM7+VId/zWFwdJEzRXp9u+arJZpLS+qjCfcM0xdomEsTAyrePdyrGdWJsG8L7tg==
X-Received: by 2002:a05:6512:3c82:b0:540:3579:c647 with SMTP id 2adb3069b0e04-5403579c673mr3819124e87.6.1734344894673;
        Mon, 16 Dec 2024 02:28:14 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c13c3asm783129e87.210.2024.12.16.02.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 02:28:13 -0800 (PST)
Message-ID: <b877f4dd-08a7-4298-80d4-be3570c8fe93@gmail.com>
Date: Mon, 16 Dec 2024 12:28:12 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] rust: add dma coherent allocator abstraction.
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Daniel Almeida <daniel.almeida@collabora.com>
References: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
 <20241210221603.3174929-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjO-GbB85dDdxLSSWY74cUn8-Lt-yaRGkUVxb-E8YaO2Q@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAH5fLgjO-GbB85dDdxLSSWY74cUn8-Lt-yaRGkUVxb-E8YaO2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/2024 16:27, Alice Ryhl wrote:
> 
>> +    /// Returns the base address to the allocated region and the dma handle. The caller takes
>> +    /// ownership of the returned resources.
>> +    pub fn into_parts(self) -> (usize, bindings::dma_addr_t) {
>> +        let ret = (self.cpu_addr as _, self.dma_handle);
>> +        core::mem::forget(self);
>> +        ret
>> +    }
> 
> Not only does this skip the destructor of `dma_free_attrs`. It also
> skips the destructor of fields including the `dev` field. Did you
> intend to leave the refcount on `struct device` without decrementing
> it?
> 

Good catch. Yeah dev should be decremented here as well.
Will incorporate fix into next revision.

Regards,
Abdiel

