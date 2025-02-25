Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A11C7017
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471330; cv=none; b=lyutIucY05hjpz/PLJxOwP6OODKV2avEInUwWxSChORERvCs55YalX9GIZDIE3m20w3vYRlpLaBI8Muobe3DtX1fkrnZMa0w+pqp+rMtkHr3/cNh9eXrOrO4Ylk9m51jkF8NaPRfnA30A5NRPSnt9OMlGUHDdF/f239PnYVYg2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471330; c=relaxed/simple;
	bh=yfrc+7kKphVxlnTfTwdmOQSoM2uXrBV0C9JkubOhMh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o42qPcUCJluz+uH/DFu5RVLfCbhh3JAfSYp/zKSIMY0FohhYFv/QJkXFYvmDXCea4X/J8rqfJTnKo29Yfsaq1x2nW7PaR1EOXoOWyE6RDWF573NT7FUJbsc5N+tMlolHTRDq00jviXPA2OQJUKXrrcx2n58xU0ql4nd+8A0n49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYsbvwHc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYsbvwHc"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30a317e4c27so45655431fa.2
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 00:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740471327; x=1741076127; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RdqAlLkZmfy0CFMV99JGfChSVQKpEGqALN/Yz7FEnLI=;
        b=eYsbvwHcbPTiRSwwX7KkAvZsJQqz0bEBHIryZPuQLWm6sujUq0QHBEBE6nzTvtD7XD
         ZITWJoa+qcnnQalII2g8CTiyfpykbr8Ge31ieFCFRSkTqr1lElVB7bqpzWQdzplf0VEn
         gQZravfAEqn4nfkSJG5CqFPRum5+T8bNGdjZ45QNUCudoJ0meAzcezYPayH4TTTWRaWg
         AZsUvEZDEMGiFsXvZr0pcesezjydsRFtn+busU0gcllBLTJOZ56yGyDSUhpgG+F5jDF8
         3kWK6lf6jr/0c3bwks6w4Xf/z0xf+jCpc7q5C3h2wWrLB7Z4nNYPuxYo9lGcmDE1w8kU
         Tq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740471327; x=1741076127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdqAlLkZmfy0CFMV99JGfChSVQKpEGqALN/Yz7FEnLI=;
        b=aKD2ULkKf9atpU9mV8YIhpbpZi84B+gXSFB3cOgBgNeWgqhVlXgg1Fy0hyPvz33K7n
         WGYM0SvsDytcvUsYG36CWlWqkwlgGYb1rfFN+yPoeC3v4FMHT0l1m6eLF1+3NRdBpJiC
         wERf1yV8wvjL1oi8N4fIgHFFvqY2mhoBJTS/oxWqBj40wXmR4RwTmIIQMldR/x6HL8XP
         XxPb3XgahzvjfTocrAwi9Me7t2pRjHmnHIbApHnjza9xBlj01NJWbXkF39URhzThkg7L
         DFep6GJ28yI1RnD85q06x29cx1Q668SsS5zBdxQMJ8OnMQ8vrxjoxvN2AxnlqaW2gDsx
         Z03Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtQIi7g5+i7Nzlu0HgsUXDRTj2q5E6QimaenhYDMNNb+gSOQycwsrokau2HZZ1xCnRDvK2iw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIq9VmCCvbr+L4LJXCtTYKgA0mAIs6hOS/DMVzix4nqZvdONmZ
	/AEnyW4HDyUl1D+GSwfYx6CS5U8c6tHh9AmAXwz6BCwrGD8vkWEh
X-Gm-Gg: ASbGncun16TyRzyehRfrVrak1jFk8DWf1FTzZiEykkyBGKUDZX7CARjkg3loykQ7Rie
	gCded+Gn4Z7M1lwbtkac/83MzfSHviwoEXke6G56+QTY9LGTv8QFufV5mv2oxHpGGq39yQx/Ql0
	UpMmL76I77dEL4tlh4c7oVCXsEoSsoH24ZrMSmtg2SeU2xWVML8Oz6/BmANr4Qm8TVHdqhSyrfY
	umi67KgtM2VUyfDSsszAcZcVkGHHABUEmgBYgYDvNzzGXybVhgUp2fVHa3X3uwrViVxPqLI5NwO
	VLn0mAz/tX1UWZmeRFMLvTxnINfJelKpsUAFxdLP9ti2g1hIq05SQ4weqDMEq8e/R0w4PLAC
X-Google-Smtp-Source: AGHT+IF8UCoR+9ygGt6igUqdFrgSG5IAVYIl2IQ/fAb9S/8z9eTyoWb0Ux422EVvUx9jjVWOj8wKnA==
X-Received: by 2002:a05:6512:239b:b0:546:2ea4:8e72 with SMTP id 2adb3069b0e04-548510ed685mr958741e87.49.1740471326562;
        Tue, 25 Feb 2025 00:15:26 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514efc28sm116034e87.151.2025.02.25.00.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 00:15:25 -0800 (PST)
Message-ID: <02911a6d-e17a-4d17-b060-83c96732003f@gmail.com>
Date: Tue, 25 Feb 2025 10:15:23 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: aliceryhl@google.com, dakr@kernel.org, robin.murphy@arm.com,
 daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <CANiq72mMKx3kD5KEcT0gOa1zkCt-VXxTEhnDa3feq0H7AttUGw@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CANiq72mMKx3kD5KEcT0gOa1zkCt-VXxTEhnDa3feq0H7AttUGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/02/2025 00:05, Miguel Ojeda wrote:
> Hi Abdiel,
> 
> Some quick doc-related nits -- please take them as a general guide for
> potential improvements in newer versions etc., given there are still
> other comments that could change the contents.
> 
> On Mon, Feb 24, 2025 at 12:50 PM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
>>
>> +/// Inform the kernel about the device's DMA addressing capabilities. This will set the mask for
>> +/// both streaming and coherent APIs together.
> 
> This comment differs from the C side one -- that is OK, but just
> wondering if there was a strong reason for that.
> 
>> +pub fn dma_set_mask_and_coherent(dev: &Device, mask: u64) -> i32 {
> 
> This returns `i32` -- I have not read the users of this, but should we
> take the chance to have a `Result` already here? Same below for the
> other one.
> 
>> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
> 
> To keep things consistent, please start comments with uppercase, i.e.
> "SAFETY: Device pointer ..."
> 
> It may also be clearer to say "by the type invariant on".
> 
>> +/// Possible attributes associated with a DMA mapping.
>> +///
>> +/// They can be combined with the operators `|`, `&`, and `!`.
> 
> Even if it may be trivial, a small example could be nice here (when I
> see a sentence like "This can be used ...", I typically consider
> whether it is a good place to show how).
> 
>> +/// DMA mapping attrributes.
> 
> Typo: attributes.
> 
>> +    /// let c: CoherentAllocation<u64> = CoherentAllocation::alloc_attrs(dev.into(), 4, GFP_KERNEL,
>> +    ///                                                                  DMA_ATTR_NO_WARN)?;
> 
> Please try to format the code as `rustfmt` would normally do it. I
> know it is a pain to do it manually -- hopefully
> `format_code_in_doc_comments` will eventually be stable.
> 
>> +        // We ensure that we catch the failure on this function and throw an ENOMEM
> 
> Apart from what Benno said, please try to use Markdown in all comments.
> 
>> +    /// Performs the same functionality as `alloc_attrs`, except the `dma_attrs` is 0 by default.
> 
> Intra-doc links (I will mark a few more that I think may work).
> 
>> +    /// Create a duplicate of the `CoherentAllocation` object but prevent it from being dropped.
> 
> Intra-doc link.
> 
>> +    /// r/w access or use-cases where the pointer to the live data is needed, `start_ptr()` or
>> +    /// `start_ptr_mut()` could be used instead.
> 
> Intra-doc links.
> 
>> +    /// Performs the same functionality as `as_slice`, except that a mutable slice is returned.
> 
> Intra-doc link.
> 
>> +    /// Reads the value of `field` and ensures that its type is `FromBytes`
> 
> Intra-doc link.
> 
>> +    /// # Safety:
> 
> Typo: no colon. Also another one below.
> 
>> +    /// This must be called from the `dma_read` macro which ensures that the `field` pointer is
>> +    /// validated beforehand.
>> +    ///
>> +    /// Public but hidden since it should only be used from `dma_read` macro.
> 
> Intra-doc links -- even if they are not rendered because it is hidden
> (also even if it were a private item).
> 
>> +    #[doc(hidden)]
>> +    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F {
>> +        // SAFETY: By the safety requirements field is valid
> 
> Markdown; and please end the sentence with a period for consistency.
> 
>> +    /// Writes a value to `field` and ensures that its type is `AsBytes`
> 
> Intra-doc link, and period at the end (same below too).
> 
>> +/// Reads a field of an item from an allocated region of structs.
>> +/// # Examples
> 
> Newline between these two lines. Also for the write equivalent one below.
> 
>> +/// struct MyStruct { field: u32, }
>> +/// // SAFETY: All bit patterns are acceptable values for MyStruct.
> 
> Newline between these two, also Markdown. Same below and in the write
> equivalent.
> 
> I think it is fairly important to have clean examples, since people
> will learn from and follow them!

Hi Miguel,

Thanks for the valuable feedback. Still learning the ropes at this 
point, but will further improve this. :)

Regards,
Abdiel

> 
> Thanks!
> 
> Cheers,
> Miguel

