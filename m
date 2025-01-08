Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA441F37C1
	for <iommu@lists.linux.dev>; Wed,  8 Jan 2025 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359715; cv=none; b=kmHJhDgghIOhswoj3tZKLnTIrT3zL/ncEKA8Cg7M+sqGXV7eFOngI10aE2Rv6w/1/e7jt9wW3VQUFWcAMwNEdaDu9C55aSE9yE542UXRiZe9stXuEG3nBRaLhV8NhTvlD+0kBkyfPzG+XqfFc/TVVLY/eH2K59IYb9LD5U5cvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359715; c=relaxed/simple;
	bh=E7MMhTekMnQL1NJh37hwISSn2L9xkDLjeShEJFzqNq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHLO3T5k/NYui6hDETI0EPhW/Klh4onIkCdW6w7DMLl+XjYT7V0kUUAhMaisExu6loGxjt74+4i4fIToSI9TsEIdxssfPZpDeLRUZ7mz8OOlSIZeEkwsYXngZJMLUd3+Y9A9DVceClEgNznaH/5DP45BH2tQYY7YT3dYdRGp7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev; spf=none smtp.mailfrom=sedlak.dev; dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b=RePMB37L; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b="RePMB37L"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43690d4605dso1058635e9.0
        for <iommu@lists.linux.dev>; Wed, 08 Jan 2025 10:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1736359711; x=1736964511; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HilkiTTLf9cVUbCyXpjrscybDeaKlWfm6LTEslw4II=;
        b=RePMB37L2XBYxUloc39bIP9mNLWG158kjE+KMAr8NsCnNLhLC6JFOobUXJXO8KotrR
         vsk+v1k6pMvXLMxvOLwS0fqozhxFD+aQPzaMgLB8eS2phKylGKhLrc5F4drHkryCHSKe
         mG8nO4Ijfm9N5TTqE8/Vc4+RK3ybr0vkUhVL/KswJv88zyz8Ib/6wPeX/Hoy8HTKJa7G
         sHxoi2HmIH1lehWNxcWyd8mBLhFGaCk8hQzDVztlNz5fWp0vGcE0DWrDE3sspPQrsJ2B
         +NfvqtNzpDqOPn9JKXmlVfiiJHGoFWWMtw1zQOl0HK0P1SaTKtD2to7msLfxnwtFHHSQ
         SVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736359711; x=1736964511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HilkiTTLf9cVUbCyXpjrscybDeaKlWfm6LTEslw4II=;
        b=xF61zNlA05Jay5+b6RBcc//SxHRvhn82I8z5isOziQkL5vkIER25krgS8EgNyCREKM
         veofVFgD7ZAjruc6GHnfMb22PO8G4kycB0LoPYjfFHHQDu2ryC5F8GuO5mXZT4cvHujO
         r2D/CgnZVCN8tc7TbPHu7TE8NKxzeeqVv5FFHWufLBtSyEspGhzbum2XFxfP9LkeUHJL
         ZfspAzTn58jHImbNdaBHh25U+Y/SzToovCRDty5wE+25h6V42jHk0fZXvsBsf0qVPj1R
         4cowhl23hTz0kyQmniATB+sM46iKeDrTVlV8nXJpehjr8vnXNkvI8175DqewgkhgORaa
         ViSg==
X-Forwarded-Encrypted: i=1; AJvYcCXSTay/bvXmYm0hTvwTILrg3XkXNxmLEU50XO2zW9GLlixK9Bibc5wYdkobgcXeKNyvXFPITg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuMrjIibyCiKeRtVAEWHnvca+dLvDCoNDbZapcCEW1iaKqkFKC
	l6+i36p9sLWaqM5MHlX+xVQvXdHFIfStUQkP+zb6h0W/9BwA5XI0Qk1Z116jxtg=
X-Gm-Gg: ASbGncvi3BqdPl39lT7E7CfbSglUGIQumn4EZj2F2p5B+iZAlrR0LLZBJH88HVpwtvw
	6ywFinSIkb373nm3HGczC7TEqiROIFdwA0AwtYdt6OKvD3R9nLVxM0dmkrxLd/RUhUQon+uAJgY
	RG8hcXNNfyMu1CW7MwziQK+3sgnUnHW4Zv+RsBIPMGHZdacvBmZxmYsDdZHuOMQlFOtDyMgfpZt
	0P4k1vHYONxlW7NANYN9SStK0uoRQAKjtx75v1o1o70OREPERORn7mAXA==
X-Google-Smtp-Source: AGHT+IHlheQWH+MHSVCHWYXlmi7X7VEgIEttRToULqF7IDKXgbJyihsbnt6QC2q5b8CdCUMs66DdDQ==
X-Received: by 2002:a05:600c:5491:b0:434:f7f0:1880 with SMTP id 5b1f17b1804b1-436e26ec32amr29456375e9.32.1736359711133;
        Wed, 08 Jan 2025 10:08:31 -0800 (PST)
Received: from [192.168.88.249] ([95.85.217.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2c27b54sm28695265e9.0.2025.01.08.10.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 10:08:30 -0800 (PST)
Message-ID: <588af6c5-02cf-437a-a909-c22744a6df1c@sedlak.dev>
Date: Wed, 8 Jan 2025 19:08:29 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 daniel.almeida@collabora.com, aliceryhl@google.com, robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
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
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
In-Reply-To: <20250108122825.136021-3-abdiel.janulgue@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/8/25 1:27 PM, Abdiel Janulgue wrote:
> +/// Possible attributes associated with a DMA mapping.
> +///
> +/// They can be combined with the operators `|`, `&`, and `!`.
> +///
> +/// Values can be used from the [`attrs`] module.
> +#[derive(Clone, Copy, PartialEq)]
> +pub struct Attrs(pub u32);

Shouldn't this be non-pub? It seems unfortunate to leak C representation 
to the Rust world and allow its construction without going through 
constructor method. Also #[repr(transparent)] may be well suited? [1]

Link: https://doc.rust-lang.org/nomicon/other-reprs.html#reprtransparent 
[1]
> +
> +impl Attrs {
> +    /// Get the raw representation of this attribute.
> +    pub(crate) fn as_raw(self) -> usize {
> +        self.0.try_into().unwrap()
> +    }

Shouldn't be the return type u32 instead of usize? Or at least to my 
understanding the raw means C representation which should be the type 
that bindgen generates.
> +
> +    /// Check whether `flags` is contained in `self`.
> +    pub fn contains(self, flags: Attrs) -> bool {
> +        (self & flags) == flags
> +    }
> +}
Daniel
