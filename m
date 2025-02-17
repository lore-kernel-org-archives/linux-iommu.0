Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87A22A1EF
	for <iommu@lists.linux.dev>; Mon, 17 Feb 2025 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813868; cv=none; b=Vf1sRyCt2VZ+7fQXoEKcugUQKYU+YE/qC18FGru2o1bjizeITdQzzQjBKjhgPks/fbgU7ostpTXr2VUQW/4aAeb3XE7Zy6TojjGpiWQ4WHLpBLhcYgAJxpcOY7+LF1i1gqGfg1AQex5N78ZHN7hTB0+6EnYtQcRGUzjECK67Fdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813868; c=relaxed/simple;
	bh=8/L3gmfFAHfFA3roVYdsJEdGq7TwcZjgK8Y4cSwVPIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbt3R5McuKAlxUYDtRffxxLLlqt6yT7xzRT+3lm9npgSL8DHkgcGtfOBa5227fbiM0GCB2Rr3aNzTGxEyR4PJjLPqhwhhynExoKj0XikyAaxmJQrvByIC/Op5sjJFY7hRl4b3JpmlhVZSAG8ptuI1FEkbiAzGw2D/lrnVfyEOzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGpZmB+9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGpZmB+9"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5453153782aso2097006e87.2
        for <iommu@lists.linux.dev>; Mon, 17 Feb 2025 09:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739813865; x=1740418665; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=djXZZJISJ1TKosjoS1puXMdvOw7lbev+k0Hn9OFuMbs=;
        b=dGpZmB+9lQwj6NLDy+8hIPR0aBSaMG7s+XeKUueJ+sakH40CW04SaE9dx2HofHG3Fv
         3g8UkgVn6IyC0mkZ8L0rlEFUwrNSm1ZB2QVL0NMHfSIsYuKXOgfjrs6iklx2ZokygVJa
         my7U4ji10dL8Zq5ngKbOL2QHeqkWUbTyzRMWshyKVrXdu8KaWgDeRcnsxF4COKkAUgUC
         1sFNg4LsO7WwZWWyEZGtfp4kzRK39QsfmdfJTcRqKYk88mXhjxApDjpAtByKjBFyrlbe
         iNcphKcnuSdaYaPZ0BaUs5pZG1f37WLPu3KOJvxA3HRT9oodWCll0f899eH3qwFB1DGm
         Kp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739813865; x=1740418665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djXZZJISJ1TKosjoS1puXMdvOw7lbev+k0Hn9OFuMbs=;
        b=gwuBatV3hNQh8uUZafzy+YtGmPTrxN7dmT9WDvkjU6fqm1goFdn+Zzw2UrD/FF1+Oc
         6cBXiK1B7ZvgOMUDNP5AxH26QBkOhJ5rGGBXs2R8ZN49+k1tY1DFKULHCAL7ndNvxNWN
         mBhtx0d/ygi9HHU3v6yNoJgHbStD5+eLrwUaBLPwV0o7yVebge5xjNupCi8lDPdFBE9k
         GSY0a7gqjapsGTueJ2ZQ3L2eVEiPTof3DD7l2bNUKe83jtq9guXP/cpzHuGymM/s6mxK
         eMXCR4GjdULMr0xAMgWPc6cP7AHV+vyfTsbUw4NUfHy1jGIfpgD3YeQavpxYnOrQGcgA
         YcQA==
X-Forwarded-Encrypted: i=1; AJvYcCVHt1EnQvNT8TLqxAqc6vzvxsaNazXXqqErRxys76qfaOvBv6xlw5Ugx3cnqYJzwfw5WizucA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTKTLGsDv3CT0dDIiDu61pssDwDLOz2Eukwnn7UJ8DJR/0l2dW
	dkKgrpTt07gE9+YdkbkE3jjefZ0+70WQq8UH5Axg1OwStGpvny/W
X-Gm-Gg: ASbGncu7mCL8LMKgTxwqvTptJ9za2JcIq39S05qPuZArL02wh6wT7Y2HSVf4RY7d2L/
	91HXjZ+VkT4iewKeBE8wjWk7vIMZeQaA9alN6PkWh3ay7L7wJAjUOtn1/rBqHZYYaCoVnbG4PJ/
	hNY53V+h1m9s2UdF3mJztUezLbjMEUIK45oaXnMBfbweOw/LMWSo5gsxn5KQCqVnbuKaUCDeq5r
	Nx9yYJs5Ecs1kB+DcUlo8dOv6g/qBgqI+K2s02DtXVHzfE2VbHGOpKmqSrmFunvyN3h9N1dwepa
	ppaVDyTQXY1KOnhLy9nXmBuiRUBYhrta076pjQ26MaAniCYdgGdIYV+ra3kSNw==
X-Google-Smtp-Source: AGHT+IHahEhRB+xxQGpF1DyRBvIF1Rb5cbY8BrO1SPBJMBOL7KKWdBONU9dPd4DzVJZu0lRRxJ7BKQ==
X-Received: by 2002:a05:6512:1194:b0:545:a89:4dc7 with SMTP id 2adb3069b0e04-5452feab102mr3061810e87.52.1739813864297;
        Mon, 17 Feb 2025 09:37:44 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54527f929e7sm1341292e87.44.2025.02.17.09.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 09:37:43 -0800 (PST)
Message-ID: <ecf3752d-87ab-4b3b-8660-d827437b0ffb@gmail.com>
Date: Mon, 17 Feb 2025 19:37:43 +0200
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
Content-Transfer-Encoding: 8bit



On 17/02/2025 15:52, Robin Murphy wrote:
> On 15/02/2025 9:40 pm, Daniel Almeida wrote:
>> Hi Abdiel
>>
>> I noticed that there’s no API to call `dma_set_mask/ 
>> dma_set_coherent_mask`.
>>
>> This should probably be included, i.e.:
>>
>> ```
>> By default, the kernel assumes that your device can address 32-bits of 
>> DMA addressing.
>> For a 64-bit capable device, this needs to be increased, and for a 
>> device with limitations,
>> it needs to be decreased.
>> ```
> 
> Oh, good point (and I'm rather ashamed I missed that!)


Ok. Missed this part while working on the nova stub and hadn't had to 
use this interface yet, but yes will add this for the next revision.

> 
> FWIW we've been wanting to steer away from relying on the default mask 
> in new code, so it would be quite neat to actually enforce that 
> allocations fail if dma_coherent_mask hasn't been explicitly set 
> (assuming it's sufficiently cheap to keep a flag in the Device handle or 
> something like that - it's not the end of the world if it isn't practical).
> 
Thanks for the heads-up on what this interface is expected to look like!


Regards,
Abdiel

