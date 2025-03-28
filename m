Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962D18309C
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743160633; cv=none; b=FFjDY5b5dCCWlfW+0TBPaLGpLsTH+Uge5spqsYJEMgVf4D3F9/J07ZX1GdAFuw/fJ7l+U71EuNwtyeZyvyc3lLBJiOksOHbbSPOnSGnV+y2x48AHtdsP8AmGpp3ZZMQ1QgSqhxL1SW65rUWVzG0WFDvln1KI47PaZAAXZ7oG2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743160633; c=relaxed/simple;
	bh=ATmkCr9/LRwvdnKxS3aGj5ubD3sZ7z0EHrruuITaLOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7Hr5MiPkwR+DOFkP0MXgHaCGFp90vLcOgGvA3rylGr8DrqoeWM5/axZr/8d1OtMg3uZZb2EmXPiYv6WYp3B8QMrp7G88om7/ABHVpGsEqTnEwadn9FP6bLZBC28vS2t7sBqXrwM71uJ/zbji8gzjPTXh81b7yeK51yvjGJyo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vv1f7CYZ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv1f7CYZ"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-549b159c84cso57462e87.3
        for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 04:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743160629; x=1743765429; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rKihExt9HYKQ9h38yM30v9LllX8UfcKsGYU9/UYaes=;
        b=Vv1f7CYZUgzjUVVCMxBjqn5dZ3GrOWOKjxUdz+eA5+Q2wPg4ueNJ/u2JAjkF+cq2/R
         3VIwvTZZuLHHv2qtyO/Qp3mj6HsxLorl0bgBMkeR2Qr3TeWBCuoVajCqu01xYNQ8aMKI
         RERWrmaA/BVSrevrKPIi075ltiDzQzARt3/FBNpb6I/GVOZfRIFz97qaVRMqy81ZVdRc
         +ZF5c+r4G7bxzt73nd2tXfR1kP+B8DWEjLoYdflxJcn9NO3u5ZVZ8VlvQHSriXTfgmkH
         9x984DTRS1rXHXqTUE2bAeZOnuHzSYSYYGMZOdwi72zByL/KQCiw6DuDiSLyRaBpTnO0
         /dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743160629; x=1743765429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rKihExt9HYKQ9h38yM30v9LllX8UfcKsGYU9/UYaes=;
        b=HAgb/b4YL7XrKFXf7zpDkaSYh2bMjL+kHQmct3mcYJXt50pzdBzG+mFn1NPJaMMC5X
         5HnZ6r3KBF7+6t3l3iJzEC2+ukOj9bwmoOAifMS4eXfypR6/+H7g0GZ1F618EjUn46FK
         Gjy2hkIV6cvF5GUU3ou065X2rU1Bu5F5HuRmsuccoa+hT7O91ESurtEVUfqB1J0348jw
         mGnfQvOibPevRIHDo4nZ8tb5BpcHYGfPGQhqkbUwJevmRXZ8okoNmneLPCy2oFhtHpIH
         jWLbyRIwViLb6sOd0sxVXCCmG83k04iMNm9x5XjQxLMl/MoAeJMRhUmjHbObQFzwy+dj
         3iGg==
X-Forwarded-Encrypted: i=1; AJvYcCUzK6arhE0uq0rcQdzK5yTBc86JhkeaK9qioZPsU4TaDvISJ/4nJ6wlnGCZKvVHIrBROZ7gBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNQMLrsSvmv5++ZkW5Rx27NpZFTncczVxpApB9pDZpJCM96SQ9
	veY9mK22LF0enEmG24NggG2f25r0sO6rLg79zW6aQMH/SvmfEOhG
X-Gm-Gg: ASbGncutKvDVcQICuEOGDS711MOqsiQv+g8VRIDe0qfMEWAu2lY7dTOk9iH1KUjjFNX
	QPUwbVOTHBNn9SkEaiXGfclAni8BJa0NM3buc1ucL8eqpjBxdUkD66YtCWfAtjijgFfjyNWrdy4
	DvUfdjSzoeBFo7VpZDEcWPWvLRIy6bNp9KKIRhAmD05vw5q9EztVz9IIatk/KoP7gah9g6DSuND
	BYDjBr6YBdQyRkl0m3PXEj5MA8Np4lusZ7sdLVlxx2hl8SUfbkEfhepzu7l2Lpa6dkLL57Y9NAu
	cXmPY3O+5hRbs4BCGyMTNsqDucYFzMrA36Pd+q5aSOjh6+a+g5vMAEnJ3Mg+5yN6Ew256QlV10x
	sC20IGJySWMdZbJvbdAXK0g==
X-Google-Smtp-Source: AGHT+IGDXfJRX8+c/mHqwDZ+4Z803ZCEpKU/+JV3WpAa4Q8rcBv2/VrqaEaFPiYE5fRE2QgTz4TElw==
X-Received: by 2002:a05:6512:1317:b0:54a:cc75:3d81 with SMTP id 2adb3069b0e04-54b011cf63amr2756090e87.4.1743160629278;
        Fri, 28 Mar 2025 04:17:09 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b094c1d9asm270614e87.100.2025.03.28.04.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 04:17:07 -0700 (PDT)
Message-ID: <f2c36d1e-cde0-420e-a19a-fda479d79572@gmail.com>
Date: Fri, 28 Mar 2025 13:17:06 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rust: dma: convert the read/write macros to return
 Result
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 "a.hindborg@kernel.org" <a.hindborg@kernel.org>
Cc: a.hindborg@kernel.org, ojeda@kernel.org,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 "open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]"
 <rust-for-linux@vger.kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
 <20250326201230.3193329-3-abdiel.janulgue@gmail.com>
 <CANiq72mjGf1pBG7PM7fKJA_EZkphp5he2H9pvg1mxJYZb-WGxw@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CANiq72mjGf1pBG7PM7fKJA_EZkphp5he2H9pvg1mxJYZb-WGxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/03/2025 22:48, Miguel Ojeda wrote:
> On Wed, Mar 26, 2025 at 9:13 PM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
>>
>> As suggested by Andreas Hindborg, we could do better here by
>> having the macros return `Result`, so that we don't have to wrap
>> these calls in a closure for validation which is confusing.
>>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> 
> I would suggest:
> 
> Suggested-by: Andreas Hindborg <a.hindborg@kernel.org>
> Link: https://lore.kernel.org/rust-for-linux/87h63qhz4q.fsf@kernel.org/
> 
> Maybe also consider if Co-developed-by etc. makes sense since he
> provided the diff.

Thanks! Andreas, would you be okay if I add the Co-developed-by tag?

Regards,
Abdiel
