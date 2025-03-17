Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E7143748
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237523; cv=none; b=TkrknyraIgE/EPpROyGY4O/+LYn4bklOkzMhuI2cNs6CfVafTqfaG5w5OWUZhRYKHXPCw9CiInpkgakWOiG7dPrMcg3ZI205nvriRDjGG/fKQ9u5O29fTEmNyZR9Dhb2Qdt/c9j5hSymH7D7LNyxWYR6R5IRpMZym75miKIgbmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237523; c=relaxed/simple;
	bh=Wg2MnKTnhKly0wHBDH0v1yjZPcwO2/sURBDBD4Ujzzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkT+CuCTALf3txpf5lZ3yeEVdmBImLhVDqiTh99crMfDQ16bt8Q6Gr6GPK2AFS2f0tyf4Q9zs8D0I/cf5bIEnDCJ8boA1LBjhpU1U6v3aKClpsIt/b5hlsmjZl0FjZEXzt013772b7lu/MBaXmsA6EXOgROSGC8yJqv6btki+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GihE/i9n; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GihE/i9n"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30b83290b7bso48735771fa.1
        for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237519; x=1742842319; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VkDPZzkLzIOYkUqZhOny1EDRvgrh4Eeg1KqEx4AgrNY=;
        b=GihE/i9nzrwe+Ard4awAOeAfRhpM2/N1hpMByX1WAUDIsEaluqDP8Ed5N6h4avEAef
         XK0g7b7dChVhWkY1enBUvaKVcsf1/4mjTZLstNaVRvwh6AkmIdN07lOhERDCgLI7+I+e
         VniBOnTCGWdvG6+WO03ExG/nn9r1hef0nULaz1B9MP8YVezouQ6cPp62ArRR0QbDLII5
         kRhrmtSnnQiJvYa9XDXiYUhcnZEU0Wtw6yVJXCtSl7An6kfO9KtqjkesPaOZn0fpZnFn
         pGjRJDw2dZzw+IK5ccvqRz90KvW0xGp84ygB15lFOwCkD4KcjRmbs06kEcPZtseC489L
         ye0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237519; x=1742842319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkDPZzkLzIOYkUqZhOny1EDRvgrh4Eeg1KqEx4AgrNY=;
        b=SPZqpt8U8tFfhzWmsVdVBP/qyTPjhvZxWaZ3RDJnMEjIrC9+AMi8PXJY+jAgCrZZ9u
         +vmwqFyHrfTMLMP3+y/GrmNVkouX5STA6tbnTn/k7owvXckE2R8U7V7VQ8rUfi9Xdg+i
         d2K/wrcURh5MH3pnOle6vuPEjvqTXGYaEmLglDKy+0y9MyO6c4eBhogSF7SPOI2VNCqk
         v7W1Yz6MsUBhjN860fCArSoPojucg4LScpBxKb3rL/Ya36b/rIaQ/Qik7HstkZxxwekc
         9pYeN4m4uDjjG4hBx+MILQ0pvkPjDCDoCRB9TxoT6FGxwoFsxyeEn9kbJhfoF4KJmQfO
         KPkw==
X-Forwarded-Encrypted: i=1; AJvYcCWCA010DWj8A9s2TzY/VDmotAAC6QrsxNBy4sJvxMt3p6oPbQpybqRoBCCVlpLSjUmEFYZBtg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6vXwcS1xlEqMxorm7YQMl7Cd4JrUc1NzSSETCm80uZBO41nj3
	EWtk/ZWLmIiYDkaHt51ZMfPvXkmkkjQ8nOCIpjz/PlQ1ZwVbXcMp
X-Gm-Gg: ASbGncsLZ0IwOCfCDkMizFmTKTXkHwCU0C2DRCxyB94rHcmxTXfJ1JvkjlPtWhgHalU
	SKEQb/qU2iydXMUYTS9nOYbyuFRP+p4utDH+d1WJjtxDo3vJGq+BRkj5P+815nCojOqlI0JCvEe
	+ueRNYEbDfnfEqYTRZ1CpaKIQjb0WYu/+S0ka4Ks+ThRZ9e8+Ehhq2dxxoeRPXZCZSMlmDaeAnE
	wRkrotk0jER8Qz8I2x2+DpSSHzB4Dp8fjAgQbkiZHqa3OFDyO07vlFJAl3fgSlge3OgKySBNVmz
	zF5N+g0nkvey7lte7YoO9Fb0MqpPEiJNWZ2vSi/GRLWRv+mPZzfoL3EmQcREpgXv2aRk5ICs94N
	VMsHtyasZvuiAQcdr+M36Gw==
X-Google-Smtp-Source: AGHT+IGhFAz/32DEqSkaVGzak/mdI4abDJ2a5/Fq/9391vxM2WM/qYuPtsbwDak0wY/6j9h0ejxofw==
X-Received: by 2002:a2e:a548:0:b0:30b:badf:75fd with SMTP id 38308e7fff4ca-30c9752f015mr10834551fa.1.1742237519033;
        Mon, 17 Mar 2025 11:51:59 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f117b8fsm16853841fa.63.2025.03.17.11.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 11:51:57 -0700 (PDT)
Message-ID: <0bff87e4-30cf-497d-8c50-a3469b4ec535@gmail.com>
Date: Mon, 17 Mar 2025 20:51:55 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/11] rust: add dma coherent allocator abstraction.
To: Benno Lossin <benno.lossin@proton.me>, Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
 <20250311174930.2348813-3-abdiel.janulgue@gmail.com>
 <Z9B9CNRatBtyAO8Q@boqun-archlinux> <D8DRCM2FOEBN.3IVEVKW9A65AL@proton.me>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <D8DRCM2FOEBN.3IVEVKW9A65AL@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/03/2025 23:34, Benno Lossin wrote:
> On Tue Mar 11, 2025 at 7:12 PM CET, Boqun Feng wrote:
>> On Tue, Mar 11, 2025 at 07:47:58PM +0200, Abdiel Janulgue wrote:
>> [...]
>>> +    /// Reads the value of `field` and ensures that its type is [`FromBytes`].
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// This must be called from the [`dma_read`] macro which ensures that the `field` pointer is
>>> +    /// validated beforehand.
>>> +    ///
>>> +    /// Public but hidden since it should only be used from [`dma_read`] macro.
>>> +    #[doc(hidden)]
>>> +    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F {
>>> +        // SAFETY: By the safety requirements field is valid.
>>> +        unsafe { field.read_volatile() }
>>
>> I agree with Andreas that we should document the exception of usage on
>> {read,write}_volatile() here. How about:
>>
>> When dealing with a potential race from a hardware or code outside
>> kernel (e.g. user-space program), we need that read and write on a valid
>> memory are not UBs. Currently {read,write}_volatile() are used for this,
> 
> I would use the singular `UB` here and below.
> 
>> and the rationale behind is that they should generate the same code as
>> READ_ONCE() and WRITE_ONCE() which kernel already relies on to avoid UBs
> 
> s/kernel/the kernel/
> 
>> on data races. Note that the usage of {read,write}_volatile() is limited
>> to this particular case, they cannot be used to emit the UBs caused by
> 
> s/emit/prevent/
> 
>> racing between two kernel functions nor do they provide atomicity.
>>
>> Thoughts? One problem is that I don't know where to put this document
>> :-( Any suggestion?
> 
> I am a bit out of the loop on this one, but why not put into the safety
> comment? I.e. explicitly state that this is *not* sound as per the usual
> rules and it is a special exception?
> 

Thanks for this! I've incorporated the comments in v15

/Abdiel

