Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD4B24338C
	for <iommu@lists.linux.dev>; Sat,  8 Feb 2025 23:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739058923; cv=none; b=A7kLP9t4Bq7aVGbFvHolyIubFDidi+5Y1Lme6HnUkAijyGN7Oy/v+YXmbFPSBcrPLaM+UO2kPqse+6e1BzIIIng/QJs06HXpMgE5hX38DNro1QPWoUiI8UsdqYSD881xnbZUr6BSVTIr7KKl45DTfPkLKnNLHpiooi2lW8RgYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739058923; c=relaxed/simple;
	bh=JRYaldM9lNmyv0V3AluADdJ9dlvrHbXlkp5UU3XH9Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYOF+f6ArPFaxFjALianelOQI+PgpHRk838gZUTtpL9pzDyp2lhu2nGSNw7EFmvJofOQA0M7zOMOMLDtuV9fE2XMd95uPwUg/gnioFGJudyCH1+8Mlm2sVANI8F7K2goq7j8+jTaxdSX26qYxpdrhvUE87Apqhlq3vtcOZOQMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu; spf=pass smtp.mailfrom=vt.edu; dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b=mHlkptNY; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b="mHlkptNY"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2b83078ed33so1485845fac.2
        for <iommu@lists.linux.dev>; Sat, 08 Feb 2025 15:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1739058920; x=1739663720; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mPicVwQS5wbJAwKsL40Ymzq5q/Ob6IjbFcIhIGSOedI=;
        b=mHlkptNYF7CYvYDAZDciRfWPTRMplKSWSLeKBmkjI+ZF5eJ5l9kBqfuyUsypMyRM5A
         D4cse1sWYyEzcmSovuc5rRdTDARLDPZ0JFAF2MACpVjWc3Mi5GAx5yA4dMDFwxxXBZrb
         qcbGk3Qdo5UUXAr286QrEcuEpIuy6JO86VFlQNSxkzCUe4WAHJSCqaeTsAXiGD9Ya7EN
         U4GN1m5lNXZoUmuSLO3T8zo0jzXMxAuieMctvp0lEMhD75XR5VQAeAifJcN+jpmNH47P
         yCYXenXiDNOM4qg0KSmZb72V/LXMMno2F/4mcAQBeCLxkwTYUJWHLS0EzjWtUjUraiGE
         VAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739058920; x=1739663720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPicVwQS5wbJAwKsL40Ymzq5q/Ob6IjbFcIhIGSOedI=;
        b=LyNTsoUOzpYekDWqiv/CY8sPBZkkgz1WP8wx55wAGZSrVVqSr0P1YLLvFCDE5Awtp4
         lKZyX70ejEi/hp/u7WFg13r6npiA7jO4l6xj4PBVKgeKRIMCX80WKlljNpnR18fd2KHw
         OCsITYvNMbB9hl6TL0mGAFFbrN1dafOxJ1TwEiCEgALoGqucQcrPwsb5Z3T9PnIbf4Tt
         xRpMRERmhc1rMGU64Ak1aSgek9Q7ueIZUfMgcIBVqx3CRAZPrYjIbi9E7SnyTP4QZXPP
         mCqjewqep9KHYoedUExTtMjzHwsgOv8BAwaW86foN0TXCBpbUL++SLNtWwQhnrvq08bO
         ZXvA==
X-Forwarded-Encrypted: i=1; AJvYcCVP4pRnkVEFSwqFUqk4EFVus/9TGR8e9nU/S1y2/OHxyWTo2BFyPLIJt9PYwb3GyeqynOltyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz99nVlzKQQroHuNUFUtnMWYfhR56O9SsHu0K0U6wUV9j/daUad
	ifaolnJtnUQX3x8VuIH0B805Lnha6Wnsn5yimx0dUpUgEYojMlouROY81f7eSEs=
X-Gm-Gg: ASbGncvnaNw4mL80Wmz6zkjd4lZPL8Vy0SrhS2wD9DoFakyECc3hhNPuQRntb7poZLX
	zg7cD60HQTj2VMO3iF8ar5TlXu65Hj7uwRVPws0nVnqdeS3jnhFvxuKekBtayFHZDaZFfWjbi57
	SgSXvMCW2wEiW3Ok89Uno6GNEDbjj9Gj1JttK+/TwH/SgyP5q7PaEPROTlTEw5+pwUeRafl1HD6
	81MaYzH9MxAIGC3UQYKqiSOimfGDunKeieGC/cSNfl+EFn/Cfn+s6UlBshsY148i/B2Iyr2ygbO
	H6ZfVyTwA4tDuS8lX1CZTeCAXUpCv6XZGlQ0JhwG+5qwXxhSzDnN8IKTtQ==
X-Google-Smtp-Source: AGHT+IHWk4r4HVyiqLL19e9cELrxNlFZUIzBX3h21rZtA7zL/FAkU7jPy3L3H4qYyNZyOB/xY8XDPw==
X-Received: by 2002:a05:6870:5154:b0:2b7:fa6f:9672 with SMTP id 586e51a60fabf-2b83ee95b12mr5471087fac.38.1739058920357;
        Sat, 08 Feb 2025 15:55:20 -0800 (PST)
Received: from ?IPV6:2603:8080:7400:36da:dff5:4180:2562:4c1e? ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b826262333sm1734780fac.37.2025.02.08.15.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 15:55:19 -0800 (PST)
Message-ID: <1894f095-e93a-4def-a223-d5c089ecc2df@vt.edu>
Date: Sat, 8 Feb 2025 17:55:16 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 daniel.almeida@collabora.com, aliceryhl@google.com, robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Greg KH <gregkh@linuxfoundation.org>
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
 <20250108122825.136021-3-abdiel.janulgue@gmail.com>
 <20250108135951.GA18074@lst.de>
 <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
Content-Language: en-US
From: Carlos Bilbao <bilbao@vt.edu>
In-Reply-To: <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 1/8/25 09:16, Miguel Ojeda wrote:
> On Wed, Jan 8, 2025 at 3:00 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> No rust code in kernel/dma, please.
> 
> What do you suggest?

This is it. What do people suggest? This thread has received a lot of
attention -- maybe it's an opportunity for the community to brainstorm.
Here's an idea:

Some maintainers clearly hate wrappers/bindings to Rust, while others don't
mind as long as the R4L folks commit to the maintenance duties. Depending on
the subsystem, it will be a completely different conversation. It seems to
me that right now, every time the R4L folks interact with a new subsystem,
they need to understand the maintainer's stance. That looks like an
exhausting process.

Would it make sense to have a C middleman that Rust calls instead of
binding directly to the C funcs? This dispatcher would provide a simpler,
stable API with fixed function signatures, even if the C functions change.
If a C func is removed/changed, only the C dispatcher would need to be
adapted, but until that happens, a new error could be returned to the Rust
side (not ideal, but Rust doesn't just break). 

This would obviously impose some limitations on the Rust side, but it might
be less conflictive than direct bindings. Also, in Abdiel's case here (for
example), he'd explicitly take on the maintenance of the Rust abstraction
and its DMA dispatchers, leaving no ambiguity about ownership.

> 
> Thanks!
> 
> Cheers,
> Miguel
> 
> 

Thanks,
Carlos
