Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9520C399001
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387333; cv=none; b=PhmgnWJXVWsIp8eoAvDAhluUQIKcuhnlQOySpcIOaOWv9HA1kt9gDEc5irc7X3tEmJyNybax1+G1tzrRUSAhsTninsRpuIT93UMGHfDBFM0v2iECehpRuNDTLVcFQcII3iJrhC+ahgpuR/0j3eOpBLcR3XFmVnM6VZqAjt+aLK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387333; c=relaxed/simple;
	bh=HkFAbO8MygqvyTuNPvM8c2JpQVjswNB1aNAD46Eofxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spSTQ6+NpP+iCjjjvAmvJo8jrHlH4slupUIiD+jY0HhGTecfGVE6Glh9Ayj//3i3oaaBibYp5Y2iKbIxmjC2P2+WcViVakvr8T9GbeL9o7EOK//MIxC5F0a80QqIQuNOyTVy2i9go+jirfbC8dXobPe7cmd5nMu0sRPSo1cNmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso1126308f8f.1
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 15:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788387326; x=1788992126;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I+vEOyqPDv7rU89jwmnevj+9dxsKc/yKY2uAhwHha8M=;
        b=QwKay50jVB7seZH02vk66nkDtxw3c/zTuAnk7ABRcJ4DmSKzLrF2r8CXLFBtazfScj
         zXHYOnSElC4xaOL5vt8bQ4YXwiZI2SbPc2NrlR9ROyh0Vr3CoABq7Y/EsZzua0Tr0Akg
         KfmHEhQN3C9zNjqw1gZq1heIJhNOC8sgJeYjc2DG4B/hzuHUbJcWNGjCC2iQ7EPeHQw3
         /6F3uLQXOPffz3m6q//id2hkMhy+WpBy0G9Ly1d5JWTltfuF+gcUskkbyaeCro8tcvPd
         IrQvwd1t1r6qanajYDnO9X2PgK+FANGsfjtKORPjCXI5jMV6ZfCsrbZ++5zQN4gVdlU0
         4c/Q==
X-Gm-Message-State: AFuF++miH29fRT8TI1+4ce7jI3sVeqf1qAaMcrD18S4xzVtt7ukUHaXh
	Hn3v3pyF1Arm5hMOIUkrDHzhe7PsTiw7sy08OlV/ujFQs/BeL5CAj/XGUU+MPF9H
X-Gm-Gg: AYBFou0BUjiGlNPCUPFPn5+SSqYIIRRxAGl7rvrb4DYPt1vyAoDN0Il3dp50OiIjDoe
	fpr52FeeVW9W2GjcpufaloYeKQig7kktwza8qKBERwi6NGUOHjPN9BMs7icJfWDMlMoj/GIuWsU
	3H6jCAR7nQIcMzk1A1Z1L/b3T4VZ46DghSD4GE6g1PNEvJ45Mjh9WAQamBmBxXqxICbvAnalXQM
	dyYSr2d/sur62XQT+zT69O0FB0g7ZF1Wx2Zj87O4PG56x33R7k7GdmXo49Ca6pPavFoOyPtNcqQ
	FjOIQNHCBVoqYUUlNNdsjrjinoMpy3SlOf4jts9X2h2k0VBWgGftGvntkBZiwJ2cebYLXddA1Py
	kncAcUhBo+k/XelTihT1RaH590sVSXHPMnBpn3wK9txSwCd7o0pmUgu/1+vBN9pclIxfsRbeP7r
	8fPUr/4J0vypYMNsnxLPy9jy8TZigj8o9MJOAb+DRXUPbV+rqh3U2Mc8Y4WZv+Kw6IoC8ugQWWn
	UY7sHKFLPfwGglajQ8y5iT1i7KfyFPj7TfWbT+sLfa4Z1gbyUWaZDlWWuJYy+WN431tVdnc0wiL
	jms=
X-Received: by 2002:a05:6000:4208:b0:484:4769:18a4 with SMTP id ffacd0b85a97d-48488f10236mr16624383f8f.14.1788387326455;
        Wed, 02 Sep 2026 15:15:26 -0700 (PDT)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed38cfsm8301961f8f.19.2026.09.02.15.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 15:15:25 -0700 (PDT)
Message-ID: <9bb0ee66-d313-4a07-af4c-ffd002b55dee@reactivated.net>
Date: Wed, 2 Sep 2026 23:15:23 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] iommu: Add Broadcom BCM2712 IOMMU driver
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com,
 james.quinlan@broadcom.com, Jason Gunthorpe <jgg@ziepe.ca>
References: <20260902-bcm2712-iommu-submit-v4-0-9dbb657578c1@reactivated.net>
 <20260902-bcm2712-iommu-submit-v4-4-9dbb657578c1@reactivated.net>
Content-Language: en-US
From: Daniel Drake <dan@reactivated.net>
In-Reply-To: <20260902-bcm2712-iommu-submit-v4-4-9dbb657578c1@reactivated.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/09/2026 18:57, Daniel Drake wrote:
> +static int bcm2712_iommu_blocking_attach(struct iommu_domain *blocking_domain,
> +					 struct device *dev,
> +					 struct iommu_domain *old)
> +{
> +	struct bcm2712_iommu *mmu = dev_iommu_priv_get(dev);
> +	int ret = 0;
> +
> +	scoped_guard(spinlock_irqsave, &mmu->hw_lock) {
> +		/*
> +		 * Completely block DMA by disabling both the bypass window
> +		 * and the translation aperture.
> +		 */
> +		bcm2712_iommu_writel(mmu, MMMU_BYPASS_START_OFFSET, 0);
> +		bcm2712_iommu_writel(mmu, MMMU_BYPASS_END_OFFSET, 0);
> +		bcm2712_iommu_writel(mmu, MMMU_ADDR_CAP_OFFSET,
> +				     MMMU_ADDR_CAP_ENABLE);
> +		bcm2712_iommu_writel(mmu, MMMU_ILLEGAL_ADR_OFFSET, 0);
> +		ret = bcm2712_iommu_clear_and_enable(mmu);
> +		mmu->domain = NULL;
> +	}

My understanding is that when the IOMMU is enabled, the address cap 
represents the highest permittable memory address; requests for anything 
higher would abort. So I had hoped to achieve blocking mode by setting 
ENABLE | 0 in ADDR_CAP, thinking that would set a cap of 0, and hence 
memory accesses would fail.

But a Sashiko review pointed out that actually this value would produce 
a translation aperture of 256MB, because of the way the register works. 
And I confirmed this experimentally, Sashiko is right.

I also confirmed experimentally that setting value 0 to ADDR_CAP (i.e. 
dropping the enable bit too), with the IOMMU enabled, results in a full 
unrestricted bypass/identity mode.

So unless someone from RPi/Broadcom can inform otherwise, I'm going to 
conclude that the hardware doesn't support blocking mode and remove the 
blocking domain implementation.

This will cause the iommu layer to fall back to creating an empty paging 
domain when blocking mode is requested, which seems appropriate if the 
hardware doesn't offer a more direct way of blocking all memory access.

Daniel

