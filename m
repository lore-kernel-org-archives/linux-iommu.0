Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C512D4B59
	for <iommu@lists.linux.dev>; Fri, 13 Jun 2025 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749810715; cv=none; b=VMD6NlT7RpGPeNmZJ2cpYDADAFxiu29C1Fk0o96hNdjHPKZe+b861XLOksbnwizNupUv25EksYYiInvjlVlvbfDCcbwN58ziLLZ4FBsmQzbI3M3B63zqpikcl5ZPNsAyMZktQZheX7JN+mrPaH+CsbcEo1+VMXXZ2eREvDH8XA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749810715; c=relaxed/simple;
	bh=Jo2S1Vhmz+DHyBwpm2/Wakx8tkEoQUYYmyKwEmiczVc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hbJ2E3kPaJOYwcUqRqnMhadFRTQFNHOkbcBCBg9+1xJdo8DGhVDFW6yB0fgLkyw+GzbypOSNVg/ybptL/oztlNls9jIe0x/Z8TjVlHw1gHC5tQ6WjdOU9Qachr+Hal59uSFShczDh4hJlh88f2TFae89VWaYa+XmdnpT6GGDa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvdjqoQB; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvdjqoQB"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32ac52f78c1so21674381fa.3
        for <iommu@lists.linux.dev>; Fri, 13 Jun 2025 03:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749810712; x=1750415512; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qFr8LwPYLDgF3kaOI6zifGZaMW4ZcZipWwfZcZc5XZU=;
        b=jvdjqoQBeUfRiRqJQl3iJITdBj+gw80MwFyx1s76WDcWdEGp7boRWtzwEIC4y4wjM9
         aJszpYO+FxpF9nAuga38uVMjBvbx1W5rC+gZFjaIWqwW6dTuojUBTYAV9UdtelKZ95MN
         uTlU2s/YiPgD4gffOCVrDAZOlqF6n+i3ODLv8ToSOk9dOFkP/A6Th06OEkjtkoEjy3iO
         rKaQf7Y0gYFAfwPu+AN+2UZ0pcuj8FDu12ga8/JeCulwuMTEjZAry+B7k19rXd7T9QUl
         YRfbywrJaIjn1NW6PeoG9rFrAs/3UOeGqvUMhapa7RAyasf0APOrrOYXI5vb3G8b26Mc
         yx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749810712; x=1750415512;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFr8LwPYLDgF3kaOI6zifGZaMW4ZcZipWwfZcZc5XZU=;
        b=F1ipRXBvicX7Vu3zzGhDxf1EqOeL43SeivvtfgxySmOQUPVsykHNeh/d1x8j+7nqzO
         mxWNNBfgUYYSSdlCEDHeHjQQsPN3lUiBGX2mBfj4w3zOLEcKdb8bczizCFWdOpoU1D2L
         +Mg85vXa4lTnBqWRZthmSdHVBYTgjIyeHcGweSFczWd2WtnxTOLeAnAvzR9DxxLwZtWX
         I6/sRbBondoQ3uPKv+a0KsUEGGWB3382I6mHS7eip9oS0yguxkOZuxYTvFhrEl3xH+wn
         jpQhLGe7VIrTuAWGQhRqEq2Uew4M58OLf1nWKXkL6b86tur9xSHe2UV7s3OLFauOf1IJ
         OaMg==
X-Forwarded-Encrypted: i=1; AJvYcCVeFMu35JByPNa0mgE0ivtz9v8uAakSmN+3MwNAvXSEd+lUiY1zdgXqhmMMuk2zgAEQOzwvxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrTUy1u5/mQKb/6J1MWk11lPXhOc6vFccmkDlfzTJkoDbH1/6Q
	GM27MtASUa4z3ObS1hXpLVo2ayMuN244VcriTYU0xKCEquZQGqjwOONO
X-Gm-Gg: ASbGnctTj1OZaOuVXIurLViUwPp15B0JbUrg+Yvg5meJ6KAmz2SZ35i5K9d8yYqVyOY
	JvcXPvYjQP8+p3m7ede5TlHKeibg3g1Ugu+qeyyp9wgU9vyHJQqU5JQ484Ucc2hNkRpBZ4Veafz
	YY+ahU5sBr7cvSSlm6xF7ItIayqgoxa0boX6SPpBE3wQdZf4UG68OImGzgX21OWVF614e6m3HV9
	efmbG6p1MVnScOJwFfvBZ8TdqV5gcvO8mmuUhxAlTfOdWLJWeGEUa0MIrHh8s7d5AUg/auS63+y
	zDhVRDG291xbyLUd6+bB/Vk3T2LPzY8TZQCC5I0xpcoG8cpzpQWj+SHqgUHMHTMlyhnFg8cD7lT
	u75/gCNtPQ3jVJW/fQ/V6E/UEnkw1QOQW1Mgjn6Y=
X-Google-Smtp-Source: AGHT+IFRFFHwGOays8LaUCDYJXNXCmkVUhd04lr0fFAv7SLkPad+uB9OtTwn3owIn4pP4b0UsMJj7Q==
X-Received: by 2002:a2e:be9f:0:b0:32b:3cf5:7358 with SMTP id 38308e7fff4ca-32b3eb6edc0mr7716691fa.28.1749810711440;
        Fri, 13 Jun 2025 03:31:51 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b33189c36sm4876741fa.76.2025.06.13.03.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 03:31:50 -0700 (PDT)
Message-ID: <2d269d74-6151-4871-95a3-08089111358d@gmail.com>
Date: Fri, 13 Jun 2025 13:31:50 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] rust: dma: add as_slice/write functions for
 CoherentAllocation
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
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
 <0b71832f-f3a9-4109-baa1-f29a8327d872@gmail.com>
Content-Language: en-US
In-Reply-To: <0b71832f-f3a9-4109-baa1-f29a8327d872@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 13/06/2025 12:45, Abdiel Janulgue wrote:
> that the subsequent paragraph makes it clear that the unit is in bytes 
> unit? 

Sorry, I mean *not* in bytes unit.
