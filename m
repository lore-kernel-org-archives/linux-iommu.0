Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396BE2367B1
	for <iommu@lists.linux.dev>; Mon,  4 Aug 2025 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297818; cv=none; b=q90rySmDbJyRSrXdFY+OOhP7nLdAFQ6xE3/FflZwPxJy0LNjr+MCs1iBpwQ5aUtncM5zjqhnLNHIWU12eqM2kjs6TpFN8fjAtfQ7QVBAV2mWRrC+Ty9aZ92gW6vbR6elV8Tk2tth4ZeKIChDQzYeKRCAWbw84LKDHCRVqwnN8rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297818; c=relaxed/simple;
	bh=3qBZn4w05JGOtMDXOQ7+xMH5EVG6nlTtM3RcZXw7U/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wm8PhuP40hfnP1TbI41dw/rGjLRzyFX0n89YWRKV7/TgsMvxpy1/0RMQ2flU4Sh+vtnII1fC6mrzo07gw7/74AZE5EnnCEev5lCyfopekZmqKbQT6nJlpHXkzxiffKcEgm/NNhDMWWtFbyn9LaLP1wl9OzHro2ycsxDlsooO204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwivPlK2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwivPlK2"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55b8bf653dfso3961298e87.0
        for <iommu@lists.linux.dev>; Mon, 04 Aug 2025 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754297815; x=1754902615; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pl4J9DSJdPoU7MePCxJI1iZTtMOValE01c+lvXVqDdY=;
        b=KwivPlK2quE/Hv0Lwo4Js7eAs6ImPrM6AJwngoJDqrUQpu9BculQYYnWbWOYfpXZfO
         vGxp6xiG/c3oMxfcbFfoC3BzCfLsFAuFsHl3q0qORin5kjksshw6yRPsNaXzQKzwpGK7
         m1jeS/w+przOk7QOowT75cras/phxCDTQNiFwtRyet/DlwHxh+sk7EpioQzHq9XHkFNe
         hCzKFtRHlXtcmOXHfjlfBpSEg50CmLNy917cr1NmhZD2ZlHGXMHKiIm07F2dm4kjvNOl
         4YwZEhTC8YV5xAI1qGYl9Yd47DkZ0cErW1IXI1Sg8eqVHoZ50LRbbVtNeaiiTlNED/oJ
         NGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754297815; x=1754902615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pl4J9DSJdPoU7MePCxJI1iZTtMOValE01c+lvXVqDdY=;
        b=Vc/d1Od7CQZIJDz405AaDdBNQ8seD/4smh3dDO2rP3zxeHKo0zwd1/VGMJPgOTIi/i
         rR0/iPpwxrVdzAWHF/H0plt126HgvE7/QcW/lHEaf2oV6eCH2aSYqcg/k1ANxmC9Icpy
         kOBO4Ba08x8tcZrh2zziEoXP3Wr8D6A8bCycVhMjIc5Z+GaJT6nUvp1gBebnK97ylyzF
         USI2WQLgNKCfG7R+yJpJodh6aP0tcVig5HL56loRZsFGEDaCbyr/8pU5K1i43dcBZ4m8
         git5kjWwoL0+esLK0KbUo5rlcPRym5GRTs99U3edxg8096yx1RoKpYa8Ynkc0g0fsSk8
         iRwg==
X-Forwarded-Encrypted: i=1; AJvYcCXH27dTUWkMB1TC/rkMp6s+GRFGWjDfGfevqvqhrckkUJzSHQeQpJmXk3J3/dnEBCc8CspMEg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6eP4zkyFOX9CD7kqWdYoh2zUYYHqHvkjRnE3FyQ3b40g3TgB4
	346K4bWaWuI6GvnvB1z/sBfJzuv7uHoGyysXv/xUR3MPLrgFmJxLmXAV
X-Gm-Gg: ASbGncsj5A7bjkBhGiAWCOlDyE8O6u4gClqgudtg4PdrD8ZsjxSA6LJByOsFAkNzzlP
	g4QkBurX1t9UE8UNq5+OmjUhiSIvHsJXxCvqE7X3MezoheW3Gcqc3l56gNWjNUKlMw2LkLb4kEB
	yR4nW6p4ZGyCuLYU9dMWD4sC7LH0e80aHIMEXiBN89jPexOH6oXKWn7+EQDjCSCo3um1dy8jAqk
	A/Hl/ci62TS8ixH4C5Tad3ijpjJPMHlKA8pLTt8eQ9WcrO6VwYMpnLSnO3YG74WewimYfgP1bhb
	5QigBauM0YRr15cZln9NAvb10RKoKjq6nPQWMVrii9i7OYLRa6JhjNgfgNOy8rWFLuHukqo9m+V
	jEFT7iWjciUbjIj+Ni5t1+RASlA0bJgVsfl25C869tjK6n4hplahBJ/yPEYlsVm6RaUfb8XuNeA
	8=
X-Google-Smtp-Source: AGHT+IG96iIhaKuZo/8tUym8kIXc9FXtyvOtzG3w6vbrarnj3aUq6j46ErJDofXhIYR9H+m0/as0AA==
X-Received: by 2002:a05:6512:a8b:b0:55b:945a:64ee with SMTP id 2adb3069b0e04-55b97b43789mr2299477e87.32.1754297815004;
        Mon, 04 Aug 2025 01:56:55 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88daec97sm1580562e87.189.2025.08.04.01.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 01:56:54 -0700 (PDT)
Message-ID: <676ac763-cd23-4077-815f-8eaa9bc960fb@gmail.com>
Date: Mon, 4 Aug 2025 11:56:53 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] rust: add initial scatterlist abstraction
To: Alexandre Courbot <acourbot@nvidia.com>, dakr@kernel.org, jgg@ziepe.ca,
 lyude@redhat.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@gmail.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Petr Tesarik <petr@tesarici.cz>, Sui Jingfeng <sui.jingfeng@linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 rust-for-linux@vger.kernel.org
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
 <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
 <DBK1M000P87N.2HJHDJN1LG5CA@nvidia.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <DBK1M000P87N.2HJHDJN1LG5CA@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 24/07/2025 08:40, Alexandre Courbot wrote:
> 
> I see a few issues with the `Item` type here.
> 
> The first one is that `Page` can only be created by allocating a new
> page from scratch using `Page::alloc_page`. This doesn't cover the cases
> where we want to map memory that is now allocated through this
> mechanism, e.g. when mapping a `VVec`. So I think we have no choice but
> return `*mut bindings::page`s.
> 
Just commenting on this bit, still going through the others one by one. 
Anyways, there is already existing code I'm working on that should be 
able to extend Page that are not allocated by it's constructor (e.g. 
those coming from vmalloc_to_page). I think's it's safe at least to not 
expose the raw pointers here if we can? Just a thought.

Regars,
Abdiel
