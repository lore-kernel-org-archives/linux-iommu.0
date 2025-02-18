Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFF918E743
	for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872719; cv=none; b=SL1HbmX3zjRb36b5FqyWRADz6fbozCtLUdfRrloNGnbRk/JvTUnMFKiKDTwLKVPpxG6oWs9WjkBdcPX5NPl5+WekKh+y7+4UaEaYoE1CQa0FzdDrxd8veKM+Y8XYrEKIum92FBHoIGOjfpiH/U1xGh87BWKj1sJBl0ZnhufsFRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872719; c=relaxed/simple;
	bh=6cooqqHCoA6P1atL6E2YmZn6GVJWVgjv5JafkIvyAbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0pkbeL53ZgY2Yl/SiQFosWzRmssJQj5jyH+M/6I+CiIITalK2mDfKICg4hCbQh/LvoxzS/iytxgoFdji7tYfHuMl4KqlRrFl20YVFO9BbdNPmm1wGKQiMx+dBa03M5b6e59sueoknCksBE/NgaFckxY36vmpYKhTV+2FXYJC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enBlU/wJ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enBlU/wJ"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5452c1daabeso3142365e87.1
        for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 01:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739872716; x=1740477516; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmts2CcKs4nwISoE8RyWH4djGtBRCn0gg8bpEKNfluA=;
        b=enBlU/wJxajEVsgnf3voQt5Py50FdzcxdZ5iXsRX9/vvtdWOwOqjqSVBjdd89l7BdJ
         7pE0ZYGmJtvlojTBbBWw/tTuDqOmgM0T2OKee2yd8FN2CWpa0ITWoKlQbbnAYlVinfA7
         Xm/MsE8+IERPBGtCFB506f0k1HNWxvyIf+gmm9LYPGKrBBAu1fZ0CAEwTCAWoBm5laxW
         kniBrgoeRl4aKJzXeGfYyk/T8e8+tmcrXip3yTlaQBFmH+ti9OUc2MQorsatpm+PjPsx
         cIEDro22yBQ9RNgztcZjrE7vwdtcwhdRUtBIM+1tMtldnIoY2IrICIGeqQ6xhXpyYUSW
         Nt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739872716; x=1740477516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmts2CcKs4nwISoE8RyWH4djGtBRCn0gg8bpEKNfluA=;
        b=sIvlJLiaHt8bWldUM/r40NWeyGRosZGlZDbowYyVnmphjqSz+opNZMj0mhER1uMRWO
         M+R/QnzcOgTViDkQ8qSktfxQYd2u1HdT9E1HNA7sVwPn8/3V7Bss9S2VPk9IjNueKGge
         WGo90CSc8QSGBchkRYvWDtZINyFIRmM08e76s4d0fcsLFuy7C7SUHQx0k13yReI/nMBl
         A2xcJjpkfOmRWo2DcaUsC0DgwpBCAcbCEQmox2PzmgEBQe0uOaOndDj9M5SRgns59KV6
         dv+6H+F/CSTJSMCgVyDpB87On7gI4k4fxUfVqqWD2Xpao7I9KbpwqyNCl93AAnAWoF06
         MsSw==
X-Forwarded-Encrypted: i=1; AJvYcCVnkUXSE2ZAwp8svWzBjn+P6aiSyhoyFDpdL+NQSm2kYvsAauI8Zl8fm76PotwSJHjb9uzE2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcTVU8+pPGTqIuv2FYu3aED55v9BuECgpAwXs7Vsv8iZ7NJJMY
	p3438wcXet7ev8IvZw0aqpk8RHlJlWus7ty2gGTqybfOZxhROYfl
X-Gm-Gg: ASbGncuCPIUQG7XrwSTOGueb/c6TlVpzTRU2OKUVFbQHM9X6hOC0fks0tZznh1b3D3O
	c8rPHQCDo0imDjBiui2BeV2lNNUjvwHs7mqsuXgJrQg1eV55D5wapFcBVxovM5AAefh0R7Czsbg
	w39Z9oIq4/W0KuNhikyiiwRCyukz9vJ5QPaRrMDFzz9WkYEAd7Ov1Q8EhLNADjrhTe+NG2aAMPb
	A6jMFU2rOFwXYEuevq14bXdAUR5Ad1eup8/IPc1XhZsxfa3NnQxNXwurJR9+oMfmb72ZlhrGJ1T
	F5Jy62imlD4TcOZlwv5KxLObBbg1ig+IrACgU5H6p6RWYSMR2KYwxY03In0jYw==
X-Google-Smtp-Source: AGHT+IFSgaLtcnavys5mJwrcFVSSqID4HA2Wxm607QSTsSZJ468RX9mWtnC6yEKMzbHenx1fdpwcuA==
X-Received: by 2002:a05:6512:2398:b0:545:b89:309b with SMTP id 2adb3069b0e04-5452fe955efmr5596497e87.44.1739872715711;
        Tue, 18 Feb 2025 01:58:35 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30931b895e5sm11078211fa.113.2025.02.18.01.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 01:58:35 -0800 (PST)
Message-ID: <2b019479-2d32-433f-af78-c3378dee4e2b@gmail.com>
Date: Tue, 18 Feb 2025 11:58:33 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
To: Robin Murphy <robin.murphy@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <633274AD-E55C-4A90-AB72-33D3E176176F@collabora.com>
 <dd57c3ba-246e-414d-a9c1-eb2cff032d83@arm.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <dd57c3ba-246e-414d-a9c1-eb2cff032d83@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Robin,

On 17/02/2025 15:52, Robin Murphy wrote:
> FWIW we've been wanting to steer away from relying on the default mask 
> in new code, so it would be quite neat to actually enforce that 
> allocations fail if dma_coherent_mask hasn't been explicitly set 
> (assuming it's sufficiently cheap to keep a flag in the Device handle or 
> something like that - it's not the end of the world if it isn't practical).

I just had a quick look on how to possible approach this and indeed 
would refactor the Device binding a bit. If it is okay with you this 
could go in a follow-up patch? I was hoping to upstream the initial 
support first - at least with the dma_set_mask/dma_set_coherent_mask put 
in place already.

Thanks!
/Abdiel
