Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCCED52F
	for <iommu@lists.linux.dev>; Thu,  2 May 2024 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714611159; cv=none; b=cq2QYWKSfTszSMy1lRMRMik66oVpumDSi0xuLeSjmLgbtzMZcO3srYQAjKCxE0Dv5m/mmS2u6/XkihnaJ49ydiB+0SN8gQlF321OzPHnYhNKw1E2LTsEzHDzK91UZKWdOksjahopJ6Rxn1o/yZ7oMQiKMkKWBJS7i95NBJ4okjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714611159; c=relaxed/simple;
	bh=xnGH4XbmTFoht1KOiwCMDV60ppiri5Zo8GDKQxKyPXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IjrsGfvH4dKVpjOijUOXzrVFdrTTIBynulZaaeymOyw5BHGTOekY/9utUuS7RufSPRHZiMOOhFQudyIj4SFvos1fhUimIXffKPAIWeeMQoba5Bsh1csBwQVeJr++Ppzvi+X885Pk4ua8p50xeF4AmkThRGrsmPkubjsmKyxig1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W24CXJsu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W24CXJsu"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ecd9a81966so2227095ad.0
        for <iommu@lists.linux.dev>; Wed, 01 May 2024 17:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714611157; x=1715215957; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KiClpx8en7jGiPuIVIRk6u5bdQ8fzLhRfc1W/iVK5Q8=;
        b=W24CXJsu1hIJsBXaF4KiaH2AYfqtOtXU1bOzl6lhwsKbBZP0ybgOPx48YEOhkTvVyL
         0+xvX4RDR+KWLfPGWdSJA9C16BsbTtGt+NcWnGig8O8I1nI8p1wASxJYcnprOIC/6yzz
         0SOBuHRcxRQdZSKXMQSTF6LS9VIR7A89v8rtdNc8ojsaRpRbr/bHB3b9MnnHDmkktzFg
         y9pGyekMGQ1yizpupr+oveOKGvyhmDvILSk1E7UN2rnsxB0wb5OPxI/aKb/Az4sIVyEZ
         l3zZae0AmS2p1m1bQ78UGWg3PGmrK4L6WRt19lXrbrBpzBlHl7fPvOwUfqfvcy6Oc8Bx
         /neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714611157; x=1715215957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiClpx8en7jGiPuIVIRk6u5bdQ8fzLhRfc1W/iVK5Q8=;
        b=kVMOkwL42Q+PcFEX+z9rdqR/Q2otevh9Ycn1nJUTon4iFaSvpf3/blKkOKDS+OUXzr
         WwPzBKvDnKhZ3pR1n0UYygy1t951Gu9Mfo6brGjczf2RxIVWRJVnj+M49bDylmQNqzPX
         HHyOl8xoeRJrYcKm8qrfqfJnFQB9JP/xw2VNWcX+/5N8hxLn4dAMsx5JLsDHwDfP+1Qh
         HVnhqCM5L8zTKzrjgD07fiHplmFTdEhWwOuGZDSHNUPOs3ipOsDyhN/5wlQR7y0Mtgby
         9hKRLyH9QHrMKRPUYUgtQwhtMrS+k7cBqtgzzul6Q8wBnY+0hnKJ8Sf09KJZF44ggbGl
         5M4A==
X-Forwarded-Encrypted: i=1; AJvYcCVow/WkxdjEh6x5Pzbi7QH+z7wBGDX6sKqFbhESSWine+Q+smaMWCY8kMqJg2A2812unasUEpErn5iBaDItTu8YrDUfYEA=
X-Gm-Message-State: AOJu0YxaRIF3ofPNuZ5+eA5XLaotiFD9Hm46eophKegiUg2KMTxqztvz
	t2uNAc0FbMDGHoOxPEETUPAXMlxg/VvYW4pnr98muy/1QFS9u9aa
X-Google-Smtp-Source: AGHT+IG8oQUiorwBnxV0eC3LSJCQz1jnCAKbHg0kvh6Mr6O3B8VYhbFrkPHTmVFdcX+SYpsnDbIWlw==
X-Received: by 2002:a17:902:ec87:b0:1e5:e676:4b09 with SMTP id x7-20020a170902ec8700b001e5e6764b09mr1984424plg.25.1714611157329;
        Wed, 01 May 2024 17:52:37 -0700 (PDT)
Received: from [192.168.0.107] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902a70300b001e83a718d87sm24844659plq.19.2024.05.01.17.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 17:52:36 -0700 (PDT)
Message-ID: <33862156-cd95-4b74-bd64-82a4a4d2583f@gmail.com>
Date: Thu, 2 May 2024 07:52:31 +0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] Documentation/core-api: Add swiotlb documentation
To: Michael Kelley <mhklinux@outlook.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "petr@tesarici.cz" <petr@tesarici.cz>,
 "roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>
References: <20240429151337.1069470-1-mhklinux@outlook.com>
 <ZjHxxzRb-63ARo6Z@archie.me>
 <SN6PR02MB41574D7C31507EA7AD10FAA5D4192@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <SN6PR02MB41574D7C31507EA7AD10FAA5D4192@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/24 01:05, Michael Kelley wrote:
> From: Bagas Sanjaya <bagasdotme@gmail.com> Sent: Wednesday, May 1, 2024 12:40 AM
>>
>> On Mon, Apr 29, 2024 at 08:13:37AM -0700, mhkelley58@gmail.com wrote:
>>> From: Michael Kelley <mhklinux@outlook.com>
>>>
>>> There's currently no documentation for the swiotlb. Add documentation
>>> describing usage scenarios, the key APIs, and implementation details.
>>> Group the new documentation with other DMA-related documentation.
>>>
>>> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>>
>> Other than outstanding reviews, the doc LGTM. Thanks!
>>
>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>
> 
> Thanks for your review!  I realize that I forgot to carry your Reviewed-by
> forward to v4.   If you care to do it again for v4, that would be great.
> 

Done [1], thanks!

[1]: https://lore.kernel.org/linux-doc/ZjLieHFvjlTJrCUM@archie.me/

-- 
An old man doll... just what I always wanted! - Clara

