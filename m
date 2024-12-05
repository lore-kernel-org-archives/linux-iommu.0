Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B2A21A440
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408758; cv=none; b=fr2CKhBQt6Zv2r7ceJlg+nvMgYp1c6U2EyhO23zDTJ08f9PAn8nP85nu6DHziR44v5i96RQnjvC70RNGIPVK6dZV/P/BvGe68zodsZ9QHxyO6JyQL+zF+EtsFE+0VKKhd19Yz6zl55ftwibnohLqsb7kDRlRpVwk+msm1Y9S2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408758; c=relaxed/simple;
	bh=0qWPKNY/t9iR/pOsdFpN8VpUFDmeBzeQfCckYttTZnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isp/VxKtXw6zPecYF3CfPYNpcuwCsqJ2erF17VsxfZmPPY+4v5nYxHKwOVgY+W9i48YxPEHNhRdxOaVSLOwwLdMgL1/SmLCU0mGUm6D0WIKZdk1fxx+qYbcxbLfPC8MtdI/vqasqkAW4fj3eBn+7cUxQR1PNp1J6Vq7rkrbiKqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8XzLFFk; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8XzLFFk"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53dd668c5easo1114802e87.1
        for <iommu@lists.linux.dev>; Thu, 05 Dec 2024 06:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733408755; x=1734013555; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECr3j+PJPfH3u1FCY8Jwj8p+fy3HgSStYnz6KYhRzjc=;
        b=K8XzLFFkhhwzEujUERgQy+dcmPS8Cx7gQgII1U0wNAv1uLDwHY2HBQdu60ZpVDJNUd
         GCE9tqBzgslIj25f8u3bDoUy/KTr8/E0DymBxH5DN4egltdvQ5WWwYjXAqRQ7UZzE58b
         S4ACb8clr1GSW3u3JF7lvQ1mRbkpc6XcF/I/fS+OGP3QlUWVB99SdW2QmH7sjeBqksnz
         nShjgSLURESllQXGtggZrqfM5uJ1EB5RFTjRrML9oR5/TE7krhda9VnmJFhkPm40RY6a
         iJKFDUfF0A14SbqQzzTXrYiD0jWL3A9o6OLWNFFUSGlJlwRlqA7VNafCH1zqRkukh+jv
         Pjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733408755; x=1734013555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECr3j+PJPfH3u1FCY8Jwj8p+fy3HgSStYnz6KYhRzjc=;
        b=Sn+qrp35N6tt+25EezWX8XXXkmrhMeONWRTNy5iV7w0sM2VDO4QXv/WS6+p3lIjv4o
         3ZSUVBd60Dni9PwQrXlI8/0RVezddiVUnU9rtqyah1NtnJ9As+tOBgutYqDNTYWKKL4f
         jqALFarWal/khpgrfHXFMtyve2xuluJ323JIebXkw+0DNvGKGyqhxR+XNpyTZcwIV2Cj
         xLgJ3ekoKRyN00KTtCOCCgpk0EMIwPw+jvBwhHSPndG45Lf0IPKGMO/f9bLDlFPqq8ye
         P9aA3taMb3E0E1mBKUamhHYcFMYKNWLljSeVNmYunukjG9VeMiXDELsNhxSfXrXl2Zro
         7EAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGGiKZ8L7tfCgPGfZeLPb+P7fmUVAXVWfEB2A8m/x+lxqUd95u2ePmrrOHasTeSEEANp/8Kg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbPFuQ1xCbrHn07jZDWvoc+3Gvbhn5VW/VJfUG3MD0Pl8w7wje
	/qTBeu+0tPz1R6GSUmcrxruaiCFtNfOm2q9BS7Up7kDwch/vFLyn
X-Gm-Gg: ASbGnct+tcF7pxRaEEcMHidEVE8+7uhGAo6DBo/GeLdiOdzeQcGtsQvZ6E9ZU7a0cb9
	cL+GsWcGdHtJyp8A+TK0+jlFvrT7IkO4DKfFNW/P7tK4KT41IS6HfCKRnUcXbRBKllIx+IKTLD8
	HMtJ+ZGuUY6snSD+Z7j8SZTJP2GuQIYtr6hSZctsVKTyw7Qc6IIay6iHDGTLgEo7SHFeBzZe2RT
	S7Ys7Dsh2s5opLQ5lBphEli3DuxKWCmgCr3BynWgmo3rBIZXAhHVRxGv6xarfcKS9UDrbgFRojw
	w1vE169BtJ6i/dBnpMJa
X-Google-Smtp-Source: AGHT+IFzlJ/ndqgl+nEbM84hx+ZYeslhN+ABZV1lIYxXxfYOelqjUzikzeWd4ZSkjTOWIlPz8RbBWA==
X-Received: by 2002:a05:6512:10cd:b0:53d:f63a:e428 with SMTP id 2adb3069b0e04-53e2192c603mr1207101e87.27.1733408754721;
        Thu, 05 Dec 2024 06:25:54 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229c1edcsm261651e87.187.2024.12.05.06.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 06:25:54 -0800 (PST)
Message-ID: <c9baa4bb-81db-42ae-98be-d8cb7d57f237@gmail.com>
Date: Thu, 5 Dec 2024 16:25:53 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] rust: add dma coherent allocator abstraction.
To: Robin Murphy <robin.murphy@arm.com>, daniel.almeida@collabora.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>,
 "open list:RUST" <rust-for-linux@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20241205113234.2021442-1-abdiel.janulgue@gmail.com>
 <20241205113234.2021442-2-abdiel.janulgue@gmail.com>
 <1c13843f-6929-4bc6-8564-0ec2d964c41d@arm.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <1c13843f-6929-4bc6-8564-0ec2d964c41d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/12/2024 15:07, Robin Murphy wrote:
>> +    pub fn alloc_coherent(
>> +        dev: &Device,
>> +        count: usize,
>> +        flags: kernel::alloc::Flags,
> 
> Might it be worth adding at least a placeholder type and argument for 
> "attrs" as well, so there's less churn involved in coming back and 
> adding it later? Or is the intention to have a separate 
> dma_alloc_attrs() constructor for such users?
> 

It certainly is possible to include attrs in the constructor using Option:
```
     pub fn alloc_coherent(
         dev: &Device,
         count: usize,
         flags: kernel::alloc::Flags,
         attrs: Option<u64>,
     ) -> Result<CoherentAllocation<T>> {

<cut>
         let ret = unsafe {
             bindings::dma_alloc_attrs(
                 dev.as_raw(),
                 size,
                 &mut dma_handle, flags.as_raw(),
                 attrs.unwrap_or(0),
             )
         };
<cut>
     }

```
So the signature of the constructor could be:

let c = CoherentAllocation::alloc_coherent(dev, 4, GFP_KERNEL, None)?;

Andreas, Miguel, Daniel, any thoughts?

Regards,
Abdiel

