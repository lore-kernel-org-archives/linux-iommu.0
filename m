Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0761F03FB
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275763; cv=none; b=RMytZdvK9/e5Ky/ZgDdP1jun4zglCySYacCiO0vbPY1i6BK0BQrEbIV/kqZC+EZuGZIkyuuZ20VtrvgMMTHaNVIyDnsiPVLsuRUXyCMyudjyk/2QxUrlIZDtnyKeeGgXuOPLbu/gRE6T5lvpdBoRbAnDCuHwibf0mgCL7ZQNJSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275763; c=relaxed/simple;
	bh=bllAD+cgiv1Z1edj2jYna3KvAuphRh3kkdTtKJRFHUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0m+RoB16pobrV5W45PVU2yKsjRgQHWgS4kwU5BxtYdo50Tj/viERRUrq8hCSl7/n1f+1E30oIt/zttlU4HSNAxIEqaUEk4U6VjjSP1Gk2PVxigPt/rxS8JL7dnyeC/gyTWoGg2Aj1Zfdyx8maP4eMCNqMvlgu4Th/iq+bhe1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OH5eYEGA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH5eYEGA"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54b1095625dso657891e87.0
        for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 02:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744275760; x=1744880560; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPa0k5nD0Exazdw2igx5RaaUvNYpfB1zvFvevijz4Tw=;
        b=OH5eYEGAa3tYkrEhqraYuueslhJh+A2haHx5klytKb0BaTQR+M0h5CBES1JSLC6ltE
         qjFf1M+DuLuAH+7XKuh6uAZnl09LB0KPUmk+w2G1Wztd1gVBTfwwRf4Rs2IWgmopP+M9
         lYcCDLMXNvddojHVellpTpu/GvIPjVXQ4OjYfyNvK4zhK55hIJNHqEDvhPaKSIDXEtHP
         eXtn26WrWIPt+LHDDD8fm9ZUJJiPvp0jFi9j7AGxDCBzsr4jFUhruE4pNxt46HzypcfF
         Nwg4OuQrfkunIH3zEoP0qCfMbgF9qfel2MhqnbtdfFfhKnb4DcBPHOL0+203PMjec7Us
         qsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744275760; x=1744880560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPa0k5nD0Exazdw2igx5RaaUvNYpfB1zvFvevijz4Tw=;
        b=xAvGMs3Yb9BhdEh34w937fJkFiA2MvG+cvmjX33kh1Lqcl5LdL6KtzzyOgNv3+v8QQ
         oYFTf8ew10E2vMubvL/pFUjTjsvnctlnNO7XRQLcLNszJLUli7OTpmCiq9Y4nlUNacy8
         mSPKkYlGpY8YoN6UAbnrwb7vYUGFAYbIIgWLMqdan+4vgdqgQHE5XFyIQV4/DMGK7uDE
         RnaSUtAUweWwMUi9AdAwvJPVF513Wrf8QN0AyLBB5Gd7oR9DcYkArVFoSsYFU2Cgk726
         hZ1JQII5wkzT0zOZO36JZBSvI45gfQzke21CXCdwfvtj6JKuFdStbBDG9ZygLGwUjZAl
         a8pA==
X-Forwarded-Encrypted: i=1; AJvYcCXp4091OXSbDOe4W2k82mEVV55OT13vOojpAstOdkZ6jnSQTvNco3QBYq05DvAEtuspaEJuhw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5hsoGYbCJoOdCWCRKAqAxkppaXgY9Gg1q7HQsSfOOOeLEYqZO
	q3XHQiLrVH1SV5yeR/2UYg8xOEZ2T+nY6NpyU2i/6R35STugc/mu
X-Gm-Gg: ASbGncsjeg116tPgmwpCh18j5lBd8yqFLwPDyAegDFr42KeGj+FmLpST6EMotMoh10H
	fulE5rXdxDD7oJUcOBYlqSYIsSINrynYBWS1LxmMa858BHBvWNSGDnrB3z8K37gIrxzK987k66P
	Wz2dSSiPdszMoGN1DntkgxrJjYA5MEoBmaeGMroOCXOdSHnv38HmwfLg8NsXLN/74MNoPV60L0h
	XGF90n/d+X+y6OT/6fzTmcq7RO8+oKCiNWNYy8XXz+FBxW0p9G1iu4jnilMfFJ3ROwVFnJYLKQ+
	0SsXQEj6G5rKsRMGc8/Q3eyqpLWt5nh1o7NgfCenI6F12Ov7ce1ErbmFRwHszSncn0XNR/kx7sa
	OvMgSpnOFr38Dr9ynTA==
X-Google-Smtp-Source: AGHT+IEk+k8B4oGNxYpPH7f91Gk3apdsXRejQvJa+4EseHotya2Zs/Azwvg7bCqIMKicblqllhvG3g==
X-Received: by 2002:a05:6512:a81:b0:549:6451:7ea0 with SMTP id 2adb3069b0e04-54caf5aeb17mr504169e87.19.1744275759611;
        Thu, 10 Apr 2025 02:02:39 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d123197sm83394e87.44.2025.04.10.02.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 02:02:39 -0700 (PDT)
Message-ID: <4a48338e-64a1-4740-ae1f-7458507a009e@gmail.com>
Date: Thu, 10 Apr 2025 12:02:37 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rust: dma: add as_slice/write functions for
 CoherentAllocation
To: Alexandre Courbot <acourbot@nvidia.com>, a.hindborg@kernel.org,
 ojeda@kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 "open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]"
 <rust-for-linux@vger.kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
 <20250326201230.3193329-4-abdiel.janulgue@gmail.com>
 <D90XDHJWABTC.1VM2A3KYOT0UL@nvidia.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <D90XDHJWABTC.1VM2A3KYOT0UL@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex,

On 08/04/2025 06:08, Alexandre Courbot wrote:
>> +        }
>> +        // SAFETY:
>> +        // - The pointer is valid due to type invariant on `CoherentAllocation`
>> +        // and we've just checked that the range and index is within bounds.
>> +        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
>> +        // that `self.count` won't overflow early in the constructor.
>> +        unsafe {
>> +            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.add(offset), src.len())
>> +        };
> 
> How about leveraging as_slice_mut() so this unsafe block can be removed?

as_slice_mut is still unsafe, no? So we couldn't remove unsafe block still?

Thanks,
Abdiel
