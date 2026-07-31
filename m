Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05C3769E0
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529367; cv=none; b=jrfWrEleW5AhmpOOgeFD3TtB95581kiCP6iEWhRX7pTLZKc0sT1boXAUe2lIphkATzGnWZ2doCm35Q2Ao5g5Kv2HSltET1iOz0or+TYHvnrLdE/zQJpirip1pO3h7I2P8hS6l2a+16mc30FF395Eu1Leer27ZwEmZSMjOqVuOB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529367; c=relaxed/simple;
	bh=ODFxmISHVX8EchUHZB7K9XrBqrp4gzoOkBwwuVYI1Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gf0eCsmcotShzS0DxR8n3Ha6W5PlHx/L1xKAsaCjn8JCfcSm0M77koSZ4Pc3kLZsn+iegslfHJoNoCCNhPW+2Rk7DKKY2j9NCtsvp2GVTn/Ij71yUaBwIbzDKs8JmqTns58jCGvYNgAhmB8JJatl3wighVDPP5E5jnjKcHZFxYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4720f3bf164so1612492f8f.1
        for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 13:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785529364; x=1786134164;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D3E8q6SLFA2ZLcc8B4L7d4FJiaa1UbNh29dUR+fF9fY=;
        b=Fc5SVHTi9pxpBChuG5SRMYa9clTLKPbzyEJwDt8e7Z+1v4yzolwMvVr9/yjolA5lQq
         06T4hRMXr6mzMrymJSbOgQYOJTmPuLRaWPh/na98U8tdaRjGUFWLW8xAL0WhZINhKdzX
         PuXpjmHPgPGECNy3Yt0fi9hnxgLmeVqtJNZZyIUQ1bFKSEAHAJvmIHkmPunf1SGH8C2G
         CILOe/EtYTe4OrPEN0EOMEyBr7eEiBTXlTbB1pd4JAJyijFFXMvfFp+AsAr7sZPcY7u+
         HkYIJ5/+bEt/8ohuwD32l1B6CAnBszfKOuiltg/yc0ds4UrW6Acu2RiV1/NV6s4wqKoD
         +yCg==
X-Forwarded-Encrypted: i=1; AHgh+RpLOslhC5g308snMbEPp2FPUEdKCWR2vtSsPMLoI5JRAvDDNudeQDyDkxWxclF8D+teZ3FlvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTp2cOl/i8iM4ZtmbsgJSD3DaCwEh1k4V1EToAh32IPWPSUbaq
	ADCsR2H/VmEp9191SfYZVcV6c0YRTFMygiAktJ5w3BbXrkh4fkbZKEwD
X-Gm-Gg: AR+sD11qacXmt+wH8NVklwiXhyP80IIxZQyI+c7e55cxg0Urc4iVUvuJ9BhbAWS25Ic
	kEOFBLjPhX0+Babua7qMqJJ63Cw2WnSS464oBrBmv0JrUzHOvmFuLbzWhCAb04ltZyeUB7pyeJd
	P5iNXPO86h1VoSxqCmCeKxshiO+Hrcp60r+cg6jK2dBVoncivF6IdpoHF8Yqr6jnzxEn9jvUALz
	tyVx125+I02QEq2ppTqdECfqtgkbd5JpIfmR0Xju7oNgbs7YAcKjRH+YD2VEKybiJXnL0PhCa2r
	jgLROu8jlgjFPpbYRjooH+Ekd2vRoiBiYay8/FNtNTjGOjieuHVgNgsqi4Z3DCF9w3ATDHY3jFE
	1KeRoYgl0iyv15YD5ngTCr8k4aWOPYwQCuzyEtsr6Efz/As0Pg/s135qNROEF+HM0/B0HVHoxb7
	nyVQnSN/tEvK+9eyVGMfWgKPNJYuUTzVE7WUG3isXL1zKCIM1JBfqOkx0F+UTQwrKPU3ylQkE4M
	3MjqCh9WoBTUjSiGcF9usK5kzYJBst2pZIZczu+Ad79kwkSAAp92iSPEQJ0+FN2wJVv
X-Received: by 2002:a05:6000:25f3:b0:47f:90f1:68c8 with SMTP id ffacd0b85a97d-47fd32b19d0mr7598242f8f.1.1785529364463;
        Fri, 31 Jul 2026 13:22:44 -0700 (PDT)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4562a38sm9066484f8f.21.2026.07.31.13.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 13:22:43 -0700 (PDT)
Message-ID: <d6bb859e-c1e7-428e-b765-7b471e1ce005@reactivated.net>
Date: Fri, 31 Jul 2026 21:22:42 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] iommu: Add Broadcom BCM2712 IOMMU driver
To: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 nick.hollinghurst@raspberrypi.com
References: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
 <20260727-bcm2712-iommu-submit-v2-4-0247b5c03de8@reactivated.net>
 <3e7ba95b-51e7-48e4-aea5-f86db1739ac2@arm.com> <amlE8rEgryPqrUZd@ziepe.ca>
Content-Language: en-US
From: Daniel Drake <dan@reactivated.net>
In-Reply-To: <amlE8rEgryPqrUZd@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/07/2026 01:10, Jason Gunthorpe wrote:
> If paging is attached then it sets MMMU_CTRL_OPERATING_FLAGS and
> places the aperture at 40G. Based on the comments about blocking I
> wonder if the "bypass" even works when paging is on?
> 
> If blocking is attached then it sets MMMU_CTRL_OPERATING_FLAGS with
> some 0 address cap which aborts everything?

The hardware lets two regions be configured:

1. Bypass window
Configured as BYPASS_START_OFFSET..BYPASS_END_OFFSET
Any device access to addresses in this range go straight through to the 
same addresses in physical memory. There is no PT translation.

2. IOVA Aperture
Configured as BYPASS_END_OFFSET..ADDR_CAP_OFFSET
Any device access to addresses in this region go through page table 
translation before reaching physical memory.

The bypass must come before the aperture.

Access to any address above ADDR_CAP_OFFSET will abort.

So the blocking domain is implemented by setting both of those ranges to 
0, which means ADDR_CAP_OFFSET=0 as part of that. (I'm going with the 
interpretation that a blocking domain is like a killswitch and should 
abort all memory accesses.)

However, the blocking domain implementation should be removed (see below).

The bypass works fine when paging is on - did you spot something that 
makes you suspect otherwise?

> It looks to me like some of those comments and choices don't reflect
> what the driver actually does. Since there is only ever one
> translation we never need to be worried about where the aperture is,
> it could be anything so long as the HW gives it priority to bypass.
> 
> Could the aperture be placed at 0 with the bypass fully disabled? Then
> it would basically be a normal iommu.
Please let me know which comments/choices you are finding unclear, I 
tried to make this driver readable and would like to fix that.

The aperture could be placed anywhere, but the key idea in the current 
driver structure is that we deliberately place it above physical memory, 
so that we can have the bypass window operational for all regular 
physical addresses, meaning that iommu-unaware devices can operate as 
normal.

Each of the 3-4 IOMMUs has around 5 devices hardwired into it. When the 
IOMMU is switched on (effectively via setting CTRL_OPERATING_FLAGS), 
*all* of the hardwired devices are subject to the IOMMU operation, 
uniformly. There is no gating where you can have one of the devices in 
standard passthrough mode and the rest using the IOMMU. Also there is no 
Stream ID in the transactions, there is no way to configure per-device 
page tables.

Among the devices hardwired to the IOMMUs we might have:
  - Devices already set up by the firmware and relying on regular access
    to physical memory
  - Devices that don't require large contiguous DMA allocations and would
    prefer not to have the translation overhead of the iommu
  - Devices that handle scatter-gather natively and prefer not to have
    the translation overhead of the iommu
  - & devices that want to use the IOMMU :) so that they can work with
    large contiguous allocations which are actually scattered in
    underlying physical memory

So we have multiple needs to tend to, which is why the driver currently 
sets up the bypass in the regular address space (serving the first 3 
above), and the IOMMU aperture in a high, unused part of the address 
space (for the devices that do want to take advantage of the IOMMU).

Are those good enough reasons to set up the driver in this way? Or are 
there other approaches to consider?

Let's take an example where the aperture gets placed at address 0 (and 
hence there is no bypass window). Now it is operating more like a 
"normal" IOMMU (except without per-device configurable behaviour, stream 
IDs, etc). The system boots and the firmware sets up the display 
controller rendering some early boot screens. Then the kernel boots and 
takes over the framebuffer using efifb or simpledrm. Then it loads a 
device driver for, let's say, an image processor. This turns on one of 
the iommus and puts it in paging mode. The aperture gets placed at 
address 0, no bypass window. But, whoops, that iommu happened to *also* 
have the display controller hardwared into it. Now we have a big visual 
glitch and the display output has stopped. And maybe the kernel doesn't 
even have the vc4 display driver available to correct that later, 
because the expectation was just to use the simple fw-configured 
framebuffer.

This is also why I think the blocking domain implementation should be 
removed. It causes collateral damage to all the devices which might not 
have had any idea they were influenced by an iommu.

Thanks for your help!

Daniel

