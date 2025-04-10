Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C9BA33
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744282085; cv=none; b=arLBqNOp3zKMXbV4UVD3kByV2x8HPBkSTBl6BGhHISzxVbR65kgwYPSrmcRGupAuNvX2aa889vcWM4KQGfnpMhfJOTkG0v/rchRSxJoi3k7TqXRlr7UdyBcO7qsIDONbWM+DMPytJPTKQ/gWqK7EZnYzt2EidFp+QRG1yrU2Q24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744282085; c=relaxed/simple;
	bh=cGLWvchrfLR7zhi+J73CP0vruS4QypgLHhmrKJ1biEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzjEw6uU4BAMBYINsAnLuv51waZ4I75DN4IawuUSYwA+iT0ecGfitAy2X65LXAtFmFxjww44zX33Yp9lmmhRI9aKYj2S1Wkm5AGYU6dtQVisn/KCRgswajLWCms+GDWBRQk1brTKyNAroer16HTJwTxsfR54+gWgS7fJFeocgcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxuYZHuL; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxuYZHuL"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-549b116321aso773859e87.3
        for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744282081; x=1744886881; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHWj7S6vcwSOKxDCquC2leHCOUIgqVrIQcFhFrWcmR0=;
        b=GxuYZHuLsXVDjNkQx40XC34Myy9ZS1Auoo0TwKelTCOIAXUr2CgcL9BzkiX/2IIorB
         yDbvAXg4dT7t46WI+V8aWBFB+7yQV12SZPEbJsEd/rpY8u473IzwozCcvyFL9jiaYcje
         ZdoYHArn7bNm+v5OjZzVRRdEqcQPhk2MGQpcP6Rlh+0aKgMJGtMj5Z1gd5uQeHzNH6Q4
         8+dEhFmya2W+bmMBzab/8rwwcqVuYaZsSNBPankp5vfj9pWsR3RdDNscrYakDYZogoX0
         tjhV+WESpe9+hKGhEiiS/OrYHogxX20FRcibC3s3CuO9DLzJzocpEmi2SE8pp3XTudR9
         5iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744282081; x=1744886881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHWj7S6vcwSOKxDCquC2leHCOUIgqVrIQcFhFrWcmR0=;
        b=HytQkSCj1l+4JwgLpwMJ9hikv9IRMdzUr4RM32dtM80GhXg1eoAkJSyzr1amy49ArG
         s6C3fO1Zsiha5ovMmm0IdHOsdNw0NiWDk563R985NxFzV8WjqJzRR56KzkW4F1WSZr3P
         DpmU9dg1cBkNSr6Hx/f2zvOijjeqtxB4zpm4L5z0WyAmJe21MaTaXVPjQ+cAH+5Lvd/Y
         EokWBdJVa3uthq/dQ65h8q5sMnbZAGxz1v8MhALrsF7FqwL5RI8RejKb/JrxFnMjVzwk
         7QtlI+Gw+tSdaPceskR2bpUpcMHjJRltEz8XIFeZFqtELUeU7imDncyYxEKgnN6Uo8gk
         tk7A==
X-Forwarded-Encrypted: i=1; AJvYcCW3yGRk0wVLEeMzoYz2/QCHqSt1HYD4jvkrjlI9DVaTuUZjnoy86Fv1QxrniSLpNWuVC3HGQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzL0Pg/8JWrZGTnVgf4FoZOugvg3qq3f+1sR8JeR7a/xY8QX/3n
	9+oLD2UqaPKj53huBB2I2uaxqGXR+BZPSWKrZi0U4ftCiUkRcHj4
X-Gm-Gg: ASbGncvB1EdZ0qXNTnNadLAdE/AFReUDRzD/TYW4wolhtQUmv3Wqg5+9kcnwXlNvR4M
	EnhcH+WEM0TT5hiFdE27v5UwiMNCArMzSt4/K/E8HNlia/b89Spx1uCThqnIzndIxlgtigDtzx3
	E6WinezQRJfwL3cZF6DB3d+b4jJnNOYT/MIMLtOPQMsZtiRBaxjvAGRbJmbvpdR0QniD+Xnk601
	4lXK7/0r3O9o5OkdsEpc2DJ0A3qu4DiTbYttoL8KTIL2dqJPDPpmsC7+nAX0cffeKt9JWZ6XSZx
	xBlLf05O3+gYNtDGRD3nFQXMtZ3K3byv6jw6wsvrSLyiyavAtAksg0o6RvSpSZetoyI0SCac9pl
	H23lEQ5tB8zQp63qB7g==
X-Google-Smtp-Source: AGHT+IHqX5l/kcuKqLCPF60f6BqiCxTYZ4htKWdJyJeyOLAxTlcGym2HuOu5+eqmF8ESjMtq8wYXwQ==
X-Received: by 2002:a05:6512:4010:b0:549:4ab7:7221 with SMTP id 2adb3069b0e04-54cb688ae13mr701719e87.50.1744282081053;
        Thu, 10 Apr 2025 03:48:01 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d2387d9sm111307e87.92.2025.04.10.03.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 03:47:59 -0700 (PDT)
Message-ID: <dbfad5a9-7e31-4674-b1e4-9d0ad55b64e4@gmail.com>
Date: Thu, 10 Apr 2025 13:47:59 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] rust: dma: add as_slice/write functions for
 CoherentAllocation
To: Alexandre Courbot <acourbot@nvidia.com>, a.hindborg@kernel.org,
 benno.lossin@proton.me, rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250410085916.546511-1-abdiel.janulgue@gmail.com>
 <20250410085916.546511-4-abdiel.janulgue@gmail.com>
 <D92VBJWRTE2N.1O4IA5X7I1YFS@nvidia.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <D92VBJWRTE2N.1O4IA5X7I1YFS@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/04/2025 12:57, Alexandre Courbot wrote:
> Hi Abdiel,
> 
> On Thu Apr 10, 2025 at 5:58 PM JST, Abdiel Janulgue wrote:
>> Add unsafe accessors for the region for reading or writing large
>> blocks of data.
>>
>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>> ---
>>   rust/kernel/dma.rs | 85 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 85 insertions(+)
>>
>> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
>> index a61da5eeb017..880f6f04ba86 100644
>> --- a/rust/kernel/dma.rs
>> +++ b/rust/kernel/dma.rs
>> @@ -218,6 +218,91 @@ pub fn dma_handle(&self) -> bindings::dma_addr_t {
>>           self.dma_handle
>>       }
>>   
>> +    /// Returns the data from the region starting from `offset` as a slice.
>> +    /// `offset` and `count` are in units of `T`, not the number of bytes.
>> +    ///
>> +    /// For ringbuffer type of r/w access or use-cases where the pointer to the live data is needed,
>> +    /// [`CoherentAllocation::start_ptr`] or [`CoherentAllocation::start_ptr_mut`] could be used instead.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// * Callers must ensure that the device does not read/write to/from memory while the returned
>> +    ///   slice is live.
>> +    /// * Callers must ensure that this call does not race with a write to the same region while
>> +    ///   while the returned slice is live.
>> +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
>> +        let end = offset.checked_add(count).ok_or(EOVERFLOW)?;
>> +        if end >= self.count {
>> +            return Err(EINVAL);
>> +        }
> 
> Not sure if you have overlooked my comment on the previous iteration or
> if I completely missed the mark, but my understanding if that the bound
> check should be `if end > self.count`. Also applies to the other methods
> of this patch.
> 
Ah sorry about that, just missed that part! But will definitely do a 
follow-up that includes this (with other changes if needed).

/Abdiel

