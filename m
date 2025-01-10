Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306A933987
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736496426; cv=none; b=hdC7fiOtk64TyrPp0msurILCh5oWZKcnS1n1dBVuk0V+CekW/h+qMV2rm56uM50SPcocFMJfDHr6JQ9hZd/ChilvB6BnO5nJjPTwAJXAkGiMclQlhvHTRDbHbVUVNsCnC7ADevi+YWAM69C+sf/bIMHIYxgrYwHVr4Pmq7QNqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736496426; c=relaxed/simple;
	bh=S/07Lq4g6SQZA+O0TPG38HJaRNp1ftTFTV/q5XdL3AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2yVtTKbVuKMuRjmDspPhWLqxTf4t7/qqzONpVnop9FHlGBW72wB4gzpzYokWs/5Rb1wjL34XveFLEfWCNYdSVLVNdjYYKB55r0BfRgmoXY6Xl0jpyyALi+eYBrCTjJYNGckNst/PP5q3cWGKBjde8e9PcJc17TERkvsePoBv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaGDM65o; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaGDM65o"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5401c52000dso1828769e87.3
        for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 00:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736496423; x=1737101223; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iaIJAYfUAcAAsckScHCT7VmL8XK0S1e3k+LlB+CZhYo=;
        b=ZaGDM65orontzQCtc1MOPeckf53k+Zo7vflHOtQELl9pDO3ZEk6wk8i9M8X5Co0ZqB
         NsqFsNugmAJnHEpqVVlclog5W52X5VLVp+38aalpb+KUo/YOMNA/NX0LzxMO+mCohAOd
         eDD4KOK52v7sCZzv5/R0lgW9zmIYkqMNGzYyFHY72k1vsvJl0Ll0R3MA+Lksq5e4JEuJ
         IEN702maJu+QqHg0wBh4Vgf8KAujiszWbgB+4hCbkBxnSg2DApygh6ML4ZcKSlOW5D37
         Om5938zR4LuAE4sWgVUSW2dib+9gzkOcOgqRr/1FAc6GvsR8ja6nmu1ZJvd+AkyetwP6
         FfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736496423; x=1737101223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaIJAYfUAcAAsckScHCT7VmL8XK0S1e3k+LlB+CZhYo=;
        b=QVrQQlyvth1qk8NFaSbyToEKWqP/Ygfx/Wr2+srm5tB/qz3PR6gLZaTLJGMMwLixGS
         P0dXC5FIgfdt5jjtonyHoFClmrS/kGlMvXV3n5mjTW5P1ccfl2EDXrUZVg+uSBgGjvPK
         U71goJ6gLKWtL8QLfWOtF/kdLfl1dSH9rqYp9uLLNNgr0voAzWWSBFLkTjydVIaSJU/+
         v2NIvP3rouoMGdCbTYfiGrCZ43GZtZgNoh478GZEHwFUtlIVG3Bfuk54eJW/zral3BmK
         llwq9TsfcPUOaw7Hw4nvrmqEJ/rNdR2NW5DWcNJ+7XsS2XM1YaRH5ZRVjnTNW8b2JzE6
         7olQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3sWDL87fy2nCTygzsJC+tyTA+L2933Vj3kY4xEwBtiJzDpJguN+XzEm9ve+0AaHkM29zrWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHWDJf6uRzmTG/AHPI4YrUVATVLHSLefu8Zw1YXUVw13K/T6S5
	IUf7FhI6fQ8I6rlcnJnlYoaFYMPSb0EAtbWZMwduqqyitIEhoHnD
X-Gm-Gg: ASbGncuzAKzWBX/yXxY5NdjkywjAum6RYB9fqr0QbFeM2IB1o335fom7BH7HbDkzdsu
	qZnwojRjMB8C4gu1y6GgZ2z2Xy86DniwsTi6qfF/mKjuFSn01WNfQNadPERpSpf/498wmHfi5Xh
	//P6fgNth6N8xwgDZssncbUJHnlVRPATmvQHFSWK0ednBQ406Ram9A8JP5PgqjGS8hyn7ZpqVLT
	GYD89pxvMgJFFRa/7sNEJKfHLuqxRQALJLZkM5bnW4YTnPFVXXJiCDTPHTop2edT+WTLjfuxPXv
	eOqB68O0LjpkxyoEckI6iQ1n3Ng=
X-Google-Smtp-Source: AGHT+IEHAAuHb4Kr/mBw8+GAXqS+vcvNrL6NpogYByuTz2AGjklhx3461a1KQRiGvphtei5iThMVHw==
X-Received: by 2002:a05:6512:401b:b0:540:20eb:80c5 with SMTP id 2adb3069b0e04-542848166b8mr3084264e87.37.1736496423094;
        Fri, 10 Jan 2025 00:07:03 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428be54869sm458053e87.108.2025.01.10.00.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 00:07:01 -0800 (PST)
Message-ID: <81e9f9aa-d6ff-4377-b278-21898d61b170@gmail.com>
Date: Fri, 10 Jan 2025 10:07:00 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Daniel Sedlak <daniel@sedlak.dev>, aliceryhl@google.com,
 robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
 <20250108122825.136021-3-abdiel.janulgue@gmail.com>
 <588af6c5-02cf-437a-a909-c22744a6df1c@sedlak.dev>
 <EFC67281-5CE1-44BC-92A5-7B0E4A7FB6AD@collabora.com>
 <ba95a574-2dba-4299-9ec4-bb776a228d98@gmail.com>
 <CANiq72kiUgLacBf9i3Dt+OPLZEyksc3s==HRp5R3EB74VuZu9A@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CANiq72kiUgLacBf9i3Dt+OPLZEyksc3s==HRp5R3EB74VuZu9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 09/01/2025 13:32, Miguel Ojeda wrote:
> 
> Note that in mainline, `ffi` (the crate) still redirects to
> `core::ffi`, since we split the change in 2 kernel cycles to make it
> easier to migrate. But in `rust-next`, `ffi` (the crate) already uses
> the new mapping.
> 
> The idea is that you can already use `ffi` (the crate) -- so please use that.
> 
> I hope that helps!
> 
> Cheers,
> Miguel

Thanks, sticking to ffi::c_ulong does indeed fix this.

Regards,
Abdiel

