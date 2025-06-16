Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CA02DBF76
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079699; cv=none; b=SyUWZUv7seFF5Vk8aZqpcDB4d2tLRddyDOmGJ1+A2Jy9IdshVL87i2cOtZCINuxvMVeGkCma/PGiwNgjV0hKJoUDiONtjQ5j5Atj3N+FuDnqAx05FPCar37faghMZaOWIkttqjb64Hjp5bDQxURjcYiSTq7E1nZv773xU0779SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079699; c=relaxed/simple;
	bh=h+AoZLWnrd8a6Oc4wKT40DhZiludtEsDa24LLYFfTC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgYeQsBEGeFdGB+HMSyfKJxS3ZdcUgtnvhDuRHnpynteMre3tFurj9U9O4Two7fjd8VjK731dHUfl4ZD1C4PmSn7C9XX0oVT3mWjiCh2QmlSB/Nn1jo0Ib/xv6jw5zOi0sHSZczEC5PqZbiOOSMlqzNFKFvXB5DMrXa/G7LThBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TQqiIiyY; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQqiIiyY"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a53ee6fcd5so2770264f8f.1
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 06:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750079696; x=1750684496; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJ++7qElBXjbLPKEg859pJbPfq8le05HNKkEpAhCAPU=;
        b=TQqiIiyYE8VbUjnBdHNjpoZBto2xoqMV483Wd1puAm3DHlE6B5iIyuMc/yKL+PXLP5
         24Nrz7Au529NAaUAOsHjkmNJZqWX2LEC0Ibn3IfGKqWe4R+cVSYaNTSKyoIglCGEaHQK
         O3PVrLixDNSRp+YfxL414L7qty5Fnxfj2b159Pw8pQQYUEG1TFxa81MuuVvD9OL2UNhn
         ZDqryJdrR+4mk8aErAdK51lO32NG9NiC3yD1N4v9XDIEklVL/aqSgpugcV1RbslyzB54
         IaRyBMMpvHfwaUaaBWvgq6wAmPO+z5JAw7Mz42aWIS1J1+X4eSwGinM/33wQfnP+gmFd
         qIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750079696; x=1750684496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ++7qElBXjbLPKEg859pJbPfq8le05HNKkEpAhCAPU=;
        b=ebRp/7wvbRbbHJ2p41TqtS6RP6mSfXN3gNOp8demnS7D7//oGpOljv59ZHKS72m+dv
         UpH1hYTwE9RrdqyGGkt4ZyXZBlM/3jLDU08ajoYbCmJnLGowSao44mdg8yJq4XssRJ87
         9GPwts+D9SUVMAC6XdZwXp+hiEpIxMZkxuHpFuzkRt6b5qzVHFFBMLxhAJ3G4om2Cqyw
         YgApU6MGiEwCl5y8FuYzc262jVNu+VREVPxg6BIJktmrAH/2y4CJZTxxQR+ZYK1y3suL
         HIRNZ2blu+5VuqtSVLkAMotWmBN66Su/A8o3cko0Lyo4tOA5pIOMpT7h6C1L6VcvoSpv
         HjJg==
X-Forwarded-Encrypted: i=1; AJvYcCV9MkNtdnVfSAbaGpyeC3CKWPKhYBm6CDvMiWdQFa5cOBYHgW4WssG08G4IlYBdRHfqnArpyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YymxqTm5AeRzML1rahhxd3pZn+ZrUcdWlepJwN9M4K+C1NEVNnh
	7w0RlnQHQtKoBgRUcgUAzvTYW2K2EjIr56H5I5or4lHLqvo0jyF7XyFaKnvhWeu4oeU=
X-Gm-Gg: ASbGncsd3AaEoWyConXqzeEN44GLXeU94AL2hL0yEzLSv5e+GSjHKI6o1VvWbb5yBcC
	gQmReNTq79UnUTMhjHIh5Msds3oem4lMmI1aBIGat0c74+Jc6m0u5IJy6bth23a4tpGfdF5i7Jm
	4VJcAlbptL16gwK78J+HAfsAAP6zzcA3lFlstZcEE47U8SVR2DW169mk0eUgmqc5OiW5uFm7N0w
	74JP74kCOyW6C0Igj9TTTpVlhqVwt0fa8aZ5F2mKMtyc8sQljCbu3uFouK6bWGwE4Xn6Upo2uuG
	5CunfCna2UQ8y7SCE9kQrNbIhYWueDFqRHT1gG1vCdZz+kLUEK5iVD7NqeWWU6420Ek=
X-Google-Smtp-Source: AGHT+IHos6U7nxGDoiXdGjhAs3Whyn47rcft9em19E32YJ5Q6QPRqLvwdbpp0G+JbOnleSw237UOPg==
X-Received: by 2002:a05:6000:2908:b0:3a0:b84d:60cc with SMTP id ffacd0b85a97d-3a572399156mr7832327f8f.2.1750079696270;
        Mon, 16 Jun 2025 06:14:56 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a6ee12sm11079775f8f.31.2025.06.16.06.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 06:14:55 -0700 (PDT)
Message-ID: <83855c1a-c128-4762-9d6b-e17f2c4c8820@linaro.org>
Date: Mon, 16 Jun 2025 14:14:54 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
To: Christoph Hellwig <hch@lst.de>
Cc: Mark Brown <broonie@kernel.org>, olteanv@gmail.com,
 oe-kbuild-all@lists.linux.dev, arnd@arndb.de, larisa.grigore@nxp.com,
 Frank.li@nxp.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
References: <202506160036.t9VDxF6p-lkp@intel.com>
 <20250616111749.316413-1-james.clark@linaro.org>
 <20250616112927.GA21689@lst.de>
 <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk>
 <20250616120832.GA24959@lst.de>
 <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk>
 <20250616121444.GA25443@lst.de>
 <7cfcf919-3c7d-4f0c-911f-697ea3141080@linaro.org>
 <20250616131346.GB29838@lst.de>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250616131346.GB29838@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/06/2025 2:13 pm, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 02:10:40PM +0100, James Clark wrote:
>> The change introduces consistency with the existing declarations in
>> dma-mapping.h. Surely there is value in consistency and it doesn't do any
>> harm to define new ones with stubs the same as the other ones. That way
>> when you change an existing device that has DMA stuff to use a new part of
>> the API you don't have to predict that it will behave differently to
>> another part of the API.
> 
> Well, redoing the rest would definitively be nice, but so far no one
> has signed up to that.
> 
>> I suppose it is possible to #ifdef out the DMA stuff in this driver, but
>> IMO it would be quite messy, and I don't think randomly not stubbing out
>> some functions is the right way to move towards fixing all the dependencies
>> in all drivers. We should continue with the stubs for now and fix whole
>> drivers one by one as a proper effort.
> 
> Does the driver even work at all without DMA support?
> 

Yes it does, it has a few modes that don't require it. Presumably we 
can't just add a depends into the kconfig for all devices because they 
might not be using DMA.
