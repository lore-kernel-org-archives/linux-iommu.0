Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885A1A8401
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737141010; cv=none; b=GBq9VrOO1r4uCIJLb5r5y6tNAodWblMpd+K9dCCjBl/0LO0g3VPFIE/oQbEoC0QJ1wy1CKslMWgjsDHei2CP7wNHSxuBt7gwBaom+Py/yJtKSQIwojhRawEkmg3PqDTuArYPwjqAsiKF7cLVHJoVfUJxvRC1vy+feti9SrDI5T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737141010; c=relaxed/simple;
	bh=6bSQJQuDaly4oBY8u5yY44S8OYiNaD29V5U21qbneHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FpqdQkfa7fteuHejslTMCIGAW94MBRlj5JiD7MFnz82ElGGucm9Yp7bpUmpwoTyEaz0ydDd65dsEZFIAKl+lcMxzC6VKWOwPh8exVthx2zyFkLM/6TzmzrHMf4MLkhZNnCAgNSLMsZsBjmEfl+meB3RYonxP4zVIp05Xyn7Dd0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxhnW2N1; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxhnW2N1"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-540254357c8so2380028e87.1
        for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 11:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737141007; x=1737745807; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KYMjJwjDC5d1EGswtLs/piOvg4B1ntDaj8I7fcHjGDk=;
        b=cxhnW2N1OnHW1c7CF0zm94CfvUxTcyiI2aWL4WUmOCIzmWOHnn0cgbZiPhbNE7xMNN
         f/w492JlPh5f/bVFbc0HhFtFvlvFY/qPTWogmG60835YoIEeWkcWhz4YpAiLLvevt/jT
         8y7dQjD+0omI4fzlYJ9izolLRsn/N15uLyguMb1ZfRDM3HFjTx/sOfVo0/cxAXBfGium
         Mt5eu55UZQN1t7nMBtbYkyvWEChJw8EkCBX6d5q+iTh9jCrZz7vRZ4rhi+YzdlvXOjKb
         WcFT9Wjs9lwKeouRlUswlx0zwPmv9W8LPipMB/M/Wkzb+UeuQVW6wUATP92EyyvQSu+B
         l/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737141007; x=1737745807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYMjJwjDC5d1EGswtLs/piOvg4B1ntDaj8I7fcHjGDk=;
        b=UtN/5TTdwirVFHL/Xmaodrflnmzv44LWbHmCZPUwKa47et+usf2h76mAeqfGbRg9XF
         vLl0hpuxfIG6x9uW976fUxhQC47ux8o8YCl/OOlf7mB/tsRrStl3mYJ5XnghYoRwi12b
         Eslg6vU3KPL3P8pPJ3juQi7Vo49LDIT3rOOjQDsMEPMsuGcJ5uGi2SKIaNCn09h9tzfB
         DAF9AOQxHM0UzvDyyxBgoxXOHW7s5fv4ThIWqEciv2hr/eXos+mFMoYj5xgdJpEXG4g/
         HJaaj4p7WZIOZz85zS7Ue1/eYR1ibNj2srVsE8sor0RjmG8Zm0UmjWW2/VfjozNPhXVT
         qozQ==
X-Forwarded-Encrypted: i=1; AJvYcCX++79Wk4wQlgWwOOZWzCYeGfrczTMAJ8X3zj0ef/XEoE3DUmFInvl7sbBw2eFgkkw0hvkIQg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/EXab3fOY+uB/BNtUgNKnUa+hLUURkY+4eTpIIwRKfgo432Ue
	SoSGyg0tSYeyddG7xTQ8f5e5JwCaw/4NjlG7dheysuPM9numB8/L
X-Gm-Gg: ASbGncsWO9vqUU+hMTzFFZTye6QR80kKWKKe0VbElcU5f3Lm/G+fEcdIcxGy+dHvcn0
	M4hMBJWuk5sP0CJvn+HbZaTLN4fxWfCPBCjB91NYHrP1mNPKUxLZrtwqdvNT/3wRlrokxyE+GEs
	ra4yrgslnNbEHD3z2YL3gNBGUcsVHECS7QXShvFwPry6bbA1NB8LKJNqWTu/0tPP/6+UPjhZBqD
	G7UK1f4pZvI2TTRUU3H+bGwlQtA0o1JWkWzI6t2coGr8HifgfiUKaLXgUuqQTDelevsU301H6sw
	xW/pi8Cp4HGgkGn6MpG6B/wiyI8=
X-Google-Smtp-Source: AGHT+IErrerCITlsLuY/1AF/BCiS35sCLgXfRsqSr1c33Y5jFVuD1YlYQJnlJ+UFpnw5RSinwwwu9g==
X-Received: by 2002:a05:6512:230f:b0:540:1e65:1d7d with SMTP id 2adb3069b0e04-5439c2481ffmr1481551e87.23.1737141006892;
        Fri, 17 Jan 2025 11:10:06 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af60c4esm466066e87.128.2025.01.17.11.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 11:10:05 -0800 (PST)
Message-ID: <ddd6c0f6-a0da-4bf1-b9fd-9f73651b7cb0@gmail.com>
Date: Fri, 17 Jan 2025 21:10:03 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
To: Danilo Krummrich <dakr@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 daniel.almeida@collabora.com, aliceryhl@google.com,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Greg KH <gregkh@linuxfoundation.org>
References: <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
 <20250108151858.GB24499@lst.de> <Z36X_ZnCmBQBMoZ6@pollux>
 <20250109080812.GA20431@lst.de> <Z3-NqwAG_96yq8VD@pollux>
 <20250110083955.GA5395@lst.de> <Z4D5a5NYrAbNxUL6@pollux>
 <Z4kG5AcVeQKegLnb@pollux> <bbc60912-7ed5-4bb1-b273-8061abe49e10@arm.com>
 <Z4kshDHw8NEjQONR@pollux> <Z4pheSjBMOjgvk8W@phenom.ffwll.local>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <Z4pheSjBMOjgvk8W@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17/01/2025 15:56, Simona Vetter wrote:
> Plus this patch here is not even close to tackling
> the sg based dma-api parts.

The scatterlist portion of dma-api bindings are in the pipeline. The 
idea was to start upstreaming this basic component of the dma-api first.

Regards,
Abdiel
