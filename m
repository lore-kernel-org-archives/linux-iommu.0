Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A8260A5B
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414453; cv=none; b=Hrud9/e/v62p+kVGokvrRz4hOX/37ky6zXus2Af6rxuqrBD9kS+FrkQlYWY/IdUyZKJG+/xZWBaom/98Dh3C4OoYgMIof8CiNoStvSfwbVFet0bQ97XIRI9m08CUY8AhhYRRzfV7k8XGw07Vaxaw1jxPoaAHFKohcSEUx5zRQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414453; c=relaxed/simple;
	bh=SfKoA6FHlpKzTjlmTl90dDY9C7098JrDWp22f8Gat5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaBsKuhaT9mWb5/QJiAiMPJRg4tjaRIkpGUE8jPto0TbJjw03EGv4Yg1mncWMbVIH9QAkUtfF2TwrfMMZw+eBjclJSAP5MwiGBI+MtDBospWtmqWejSbXbNeQ8xtmO/rfFs2pDoQueOZyXkYdWPkGZxkOF+zKXhcXfI5oTi33Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVHLPsow; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVHLPsow"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30a317e4c27so40008471fa.2
        for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 08:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740414449; x=1741019249; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bg4rB5EJpBPXIh7sJAoqg5lA1zVEFXJjjwBya4kLsHc=;
        b=lVHLPsow8plhbRA0lzrGOTgHiBjz9GeOrgFK9gk9QHyyiqsGT97ls8uNvO6oJhR+J4
         P7bNpW0BSWMpNcCtRRd3tRviGwyIBacF+jw0EHBRihnyD09ZFYIDEN7dG1sDEBr/uQ59
         UmTmpzF2GyleLbCxgQrhP6C1wcgD+SvAruMmCMGWVVS21qmaqhucUnA+t2Mbz0ulL3l7
         IzM8hGOJz19c/x2Cx+Eme54RdO4ME61kSfMcFaQ5UkAWue3S5WXdqQVvqBvb46nqqOYq
         x5MVir4DM6ZpvNvDVfvMvOq4PE4MN/1pfdxZdFVJaOTqqe52i55NwhamexVClP5Cpbxf
         e11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740414449; x=1741019249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bg4rB5EJpBPXIh7sJAoqg5lA1zVEFXJjjwBya4kLsHc=;
        b=soOZPsryv20uJe/d0MW7574rtw8Mjam84k6IFz5c4+gBPby0eaz8FESDSme4shjAiW
         mr3XbcsDUx1NKpECjH+gxYqIxxeJF0zoD68IbrcBRJKRMaACXXgjyKiYhevORbNJh5lM
         KyN1wpBFZPRP/sf4k0e2KhxC0ZB5veJzTZwPpj0OU7uo0WuuDUWQEHoWUSeje6s8dZ9R
         MLShZx9YeoHjgdPaTpMIDXJWKdkIaLt6yLSK/MWfTU72s7ivAsGiqPHGY5ThHmM/CcZK
         fbdaWTcbIhkam7HLDRmOyqaMMOmOeUx6ZNZd5qEGMjgYrKSgiolzYGHljej5or0HbIfL
         EFRA==
X-Forwarded-Encrypted: i=1; AJvYcCUsfIjJMJkV8XMlzWp+jJJfwPnN8TnghWbRkMRg6S33bunmNCMTEX07yV3N09iOCFB7z0UJdg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwLQmTaSrt+QF1uhm6tfAvM6crbZ7A+S+eOAN8HvKnrcCRZvCB
	fW/KlByTjQGIOEvBIvHe6ElYedQM463OeRE9CSAHGmWiMzLueXXt
X-Gm-Gg: ASbGncsIBBhqgd+MkBKvN29OJxnYihFUXoZHgStCprHRNvZtxmYQjCoyJA2gPubgDyU
	udEkE4pPXKEOR1/JZ5aY5YhysbkwsaU1Yz50QLAm1sGqSpQQyyLFGS2Jr2K/JTtvnLVj2muIwFv
	u4DkBmXN7Hs5kWJgf10lEp+0rWbfhzNiy1ozqObZ3GwwYh2ntW/5OIPYFBveVoFw3AiHVwDpscV
	TOQ9yTGu0QGEqaTyZ7tWPXoUWlI+gKg8Wcnf8p+zvPmHCOWIv+B0U3aWL13eVLlOppFjSJ4iiZW
	KUmgLS2WRAjAVDKN8PrO/QhkPlqL0MphzN3bL1iL4mmbHthDsXAq+BDH23bJ3xLTfedtMf9C
X-Google-Smtp-Source: AGHT+IGdsV6VuMH1mr2wYZzWOKRPyftVbhVqgaj2HeDq7VSym8AAoN7aN/aGmmBPQAbcNEOLEsALrQ==
X-Received: by 2002:a05:6512:b8c:b0:545:22fe:616f with SMTP id 2adb3069b0e04-54838ef7278mr6089217e87.24.1740414448976;
        Mon, 24 Feb 2025 08:27:28 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f08332bsm3478218e87.48.2025.02.24.08.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:27:27 -0800 (PST)
Message-ID: <6f154af8-6379-4b1f-9e30-2b99f7f736dd@gmail.com>
Date: Mon, 24 Feb 2025 18:27:27 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: aliceryhl@google.com, dakr@kernel.org, robin.murphy@arm.com,
 daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com, iommu@lists.linux.dev
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <k3GMnfXzzvUVOgSnuMlEq3eVRyq1qjcf_tDtILRbOwj08EIQpwQ4bGtGhwWufr8lUn-VlHnNjP8FxIA48Jv-Ug==@protonmail.internalid>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <87seo3z9qr.fsf@kernel.org>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <87seo3z9qr.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 24/02/2025 16:40, Andreas Hindborg wrote:
> "Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:
> 
> [...]
> 
>> +/// Inform the kernel about the device's DMA addressing capabilities. This will set the mask for
>> +/// both streaming and coherent APIs together.
>> +pub fn dma_set_mask_and_coherent(dev: &Device, mask: u64) -> i32 {
>> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
>> +    unsafe { bindings::dma_set_mask_and_coherent(dev.as_raw(), mask) }
>> +}
>> +
>> +/// Same as `dma_set_mask_and_coherent`, but set the mask only for streaming mappings.
>> +pub fn dma_set_mask(dev: &Device, mask: u64) -> i32 {
>> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
>> +    unsafe { bindings::dma_set_mask(dev.as_raw(), mask) }
>> +}
> 
> Sorry if it was asked before, I am late to the party. But would it make
> sense to put these to functions on `Device` and make them take `&self`.

Thanks for checking this. The API is about the dma addressing 
capabalities of the device, my thoughts would be to group them with the 
rest of the dma API? But either way, I don't have a strong preference. 
I'll let others comment.

Daniel, Danilo?

Regards,
Abdiel

> 
>> +
>> +/// Possible attributes associated with a DMA mapping.
>> +///
>> +/// They can be combined with the operators `|`, `&`, and `!`.
>> +///
>> +/// Values can be used from the [`attrs`] module.
>> +#[derive(Clone, Copy, PartialEq)]
>> +#[repr(transparent)]
>> +pub struct Attrs(u32);
>> +
>> +impl Attrs {
>> +    /// Get the raw representation of this attribute.
>> +    pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
>> +        self.0 as _
>> +    }
>> +
>> +    /// Check whether `flags` is contained in `self`.
>> +    pub fn contains(self, flags: Attrs) -> bool {
>> +        (self & flags) == flags
>> +    }
>> +}
>> +
>> +impl core::ops::BitOr for Attrs {
>> +    type Output = Self;
>> +    fn bitor(self, rhs: Self) -> Self::Output {
>> +        Self(self.0 | rhs.0)
>> +    }
>> +}
>> +
>> +impl core::ops::BitAnd for Attrs {
>> +    type Output = Self;
>> +    fn bitand(self, rhs: Self) -> Self::Output {
>> +        Self(self.0 & rhs.0)
>> +    }
>> +}
>> +
>> +impl core::ops::Not for Attrs {
>> +    type Output = Self;
>> +    fn not(self) -> Self::Output {
>> +        Self(!self.0)
>> +    }
>> +}
>> +
>> +/// DMA mapping attrributes.
> 
> Typo in attributes.
> 
> 
> Best regards,
> Andreas Hindborg
> 
> 

