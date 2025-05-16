Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116A310E5
	for <iommu@lists.linux.dev>; Fri, 16 May 2025 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381676; cv=none; b=UxrnMJCjGsezUmUGn6fFrJP28DiVpSXZVVyEbKMoS6bN9qBEC8Mo3ug4ZZxye+GHnarKeGrvrlEVPTEGg7K/tF2MSwlg7JzTMAzXTa5v561/T1jJP+kxdE5Jr/KUfrlDTisR1WDG/1FyXbmoYEaiCmIdsjKErk70dt0sNDZMJfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381676; c=relaxed/simple;
	bh=JJv+HY/5vWYIpGd/62mFaYjJMoxm35ZrwUO6zMwTn30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyLVWPSN19V+/PISLLBNqj6MPIjTLNMPGWhbGvS3n14BJsrYQD2/cvnsvSBKlQpDr4cnSEpHkvNVKT4wB3DCuqjsjARI/ORgeQ1Lso5KoQdFO8SL3r+OqkR270dO27dpYLEj2LqSseYDPbMzDEy2lSGro41p/pdCxR4JuTOcKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJDgMU+m; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJDgMU+m"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30db1bc464dso15884721fa.0
        for <iommu@lists.linux.dev>; Fri, 16 May 2025 00:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747381672; x=1747986472; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrSq6+VEuHJsRGf8myadx7zoK3k+PF9pl61CnGWQF0E=;
        b=MJDgMU+mWDMV9IlPSbF4ZTA6GFBIWcu4rds6xv3onzH8igLX4xH2OwnelvtQqeZXmp
         ET6y/IUysXr5ceQSrKJw56mRFkahs+hIwbduthQhNnRJd1+URzIVx8bmjGCBs97xczzA
         QXVcRw9Br/ym2pexshNtB1N1G/cP+ytaelDJDc6HTLj6XNoQNs0XabEfLLA1al7vfYfe
         PH7Tc/9O1zrpfK2ORmzL69U81TVput3QznLIJ+1/XHbCnyweDdh4RoRFCRwueXFI/cCs
         B5F6hw/LIYGgLN0gpQvpnad/1VDhULRPVC68igMDt3CmRhKObDJBxJKfHCUhgvq69rlU
         ptjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747381672; x=1747986472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrSq6+VEuHJsRGf8myadx7zoK3k+PF9pl61CnGWQF0E=;
        b=B3yYGlwljBpCsyXBL4Is9kM53PWeBUEr128LX7Zn+aJVvyR/K9D3PQk7XeodRfHT1H
         qdL8ZXFXBkvcmpOA6J+nhk6BQzgGaAUXlE8g30iqC/HlIPuSJVhe2g4B81BBsO+o8cKk
         DxU0qHWQ6P2XsJ9BRVlxoUHh1A5XLbrLUbXh/DWbuBLHAiveWGNF0wM4h+4TrvEqDr42
         6V22JpYGouKEtmjSMX95uKuT7PFukcA6AGfO+voT+50twbNBCf6FkIDmVCy+t0Pofu4T
         piAAeJJhuXkZ/MjTHGg+hZ/sf9rpSho8Yaf4LamEtcmSL1buBQs/lSg3PC49O+WHWgPl
         u3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUVsW6uiLDEj3CC9JNwmlLrBhzIGymF6afRKPv1uAiIOlqz7zQL3gr4GhtKZQxqG2AGPIqQxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaQDrLDwuxYOsDmYkaC21rvMnooNOrAoD9Vo48mI4hTm294Y10
	8eCBj1e0Z8RQPJtPNjhN0kPSwNY2jQpHUaN+oyVedNQBPp0zdS2HR7U0
X-Gm-Gg: ASbGnctE8s2dZMEUGANEILRTrW1mlYz9VEut18NvEQEMkmzhd+IREREylXZrthc7gMZ
	oDM8NkHscgHOf1c4FXFHq+8yRNIKee3f65mOEIpNEanrBT2PbjgAeKSb/lavIzNY7I4j4opWGtD
	WraG2u+RGyjZjNtEYwWfmHYgE/DNyYlrOtt7eev5bvYHmCWtyVKuf5h51g+1CI507AAeo8b9n50
	Ccq+rfbRSM0SVNNeKzcIyTmKvSAxvgcYC07DcE2lJGYF6VJBunasroOpnS1tmb+3ObbL8lx99tU
	HWCdltC3wHgLewd7Bk3ewSpH4GCj8jCkO9i025sIMEUN/dWS2BOA3ghgLWFTSNmOFf+r3xDvgTF
	49+7asq/qntCdFPVt9IrfJpmfmIL2
X-Google-Smtp-Source: AGHT+IEPAgCtEoMT1Dy9PWUXsMfinArPefbdmYY6hpI3rekR9+YayzJUONasdrKBVzwoDgBWCdjimA==
X-Received: by 2002:a05:651c:110e:b0:30c:160b:c76c with SMTP id 38308e7fff4ca-3280773721cmr6106691fa.17.1747381671858;
        Fri, 16 May 2025 00:47:51 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-328085d11desm2818681fa.96.2025.05.16.00.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 00:47:51 -0700 (PDT)
Message-ID: <e9ce5d1e-1465-4a0d-97f4-0495e02c8189@gmail.com>
Date: Fri, 16 May 2025 10:47:50 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] scatterlist rust bindings
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: dakr@kernel.org, lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, airlied@redhat.com, rust-for-linux@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Petr Tesarik <petr@tesarici.cz>, Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Sui Jingfeng <sui.jingfeng@linux.dev>, Randy Dunlap <rdunlap@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
 <78DB1F66-9DF5-4679-ADC4-177BED5D4FDE@collabora.com>
 <CGME20250514070104eucas1p1b2e420e8827d55521bd9aca3e1341ee7@eucas1p1.samsung.com>
 <77afb898-fe6e-480d-9b7a-05cc31d8545b@gmail.com>
 <8eedf638-9fa5-470e-976e-9b18971f7b46@samsung.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <8eedf638-9fa5-470e-976e-9b18971f7b46@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/05/2025 15:12, Marek Szyprowski wrote:
> On 14.05.2025 09:00, Abdiel Janulgue wrote:
>>
>> On 12/05/2025 14:19, Daniel Almeida wrote:
>>> Hi Abdiel,
>>>
>>>> On 12 May 2025, at 06:53, Abdiel Janulgue
>>>> <abdiel.janulgue@gmail.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> Here are the scatterlist bindings that has been brewing for a while
>>>> in my
>>>> local tree while working with Nova code. The bindings are used
>>>> mostly to
>>>> build the radix3 table from the GSP firmware which is loaded via dma.
>>>> This interface can be used on top of existing kernel scatterlist
>>>> objects
>>>> or to allocate a new one from scratch.
>>>>
>>>> Some questions still need to be resolved, which mostly come from
>>>> the DeviceSGTable::dma_map() function. Primarily, what if you call
>>>> bindings::dma_map_sgtable() on an already mapped sg_table? From my
>>>
>>> Perhaps we should introduce a type for buffers which are known to be
>>> mapped. Then
>>> we can simply not offer the option to map for that type.
>>>
>>>> experiments it doesn't seem to do anything and no indication is
>>>> returned if
>>>> the call succeeded or not. Should we save the "mapping info" to a list
>>>> everytime we call DeviceSGTable::dma_map more than once?
>>>
>>> What mapping info are you referring to?
>>>
>> Basically the dma_data_direction enum and possibly `Device`, if we
>> decouple SGTable from the device. So this approach would mean that
>> every-time SGTable::dma_map() is called, unique mapping object(s)
>> would be created, and which would get unmapped later on the destructor:
>>
>> struct SgtDmaMap {
>>      dev: ARef<Device>,
>>      dir: DmaDataDirection,
>> }
>>
>> impl SgtDmaMap {
>>      /// Creates a new mapping object
>>      fn new(dev: &Device, dir: DmaDataDirection) -> Self {
>>          Self { dev: dev.into(), dir, }
>>      }
>> }
>> ...
>> ...
>>
>> impl SGTable {
>>      pub fn dma_map(dev: &Device, dir: DmaDataDirection) ->
>> Result<SgtDmaMap>
>>
>> But I'm not sure if there is any point to that as the C
>> `dma_map_sgtable()` doesn't seem to care anyway (I could be wrong with
>> this) if the sg_table gets mapped more than once?
> 
> 
> Standard DMA-mapping C api doesn't have the notion of the object,
> although in case of sgtable structure, one might add some flags might
> there. Originally the sgtable based helpers were just trivial wrappers
> for dma_sync_sg_*() and dma_unmap_sg() ensuring proper parameters (and
> avoiding the confusion which nents to pass).
> 
> It is generally assumed that caller uses the DMA API properly and there
> are no checks for double dma_map calls. It is only correct to call
> dma_map_sgtable() for the same sgtable structure after earlier call to
> dma_unmap_sgtable().

Thanks for the clarification! I think this double mapping issue can be 
solved by the suggestion presented by Alexander Courbot.

/Abdiel
> 
> 
> Best regards

