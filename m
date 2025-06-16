Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0E298CDC
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080222; cv=none; b=LnSR2xbBmImtjrYmLR1YkwBoE+b1xLcof9IumpsCg4rz80vwpqdwGqNN7E0kRFTD5KKQA/hRZ7MK40PhdM/VmPdh6DLGU6zO5OgS/CElqfnNXPk5jJutUlDdRIvlyxqIIk4A0CtLHs95Codytw8FAUTFHvx43+VzVYMIrYgb+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080222; c=relaxed/simple;
	bh=cyawNk1X0Zi/5eV0YddzR83paiy0w8sFEtP0KMTHO+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSlapzHYY1l9+GQpqzRI9x+erpvKkDjPxPbxuO/CKhbjgn0A5qRSn3kIbHEmZIAqnLgfyJQ8tUldL4oTWMRYcEt0JDlOTsws1I2ZxxErmsZfBKfByQJbDoiMnYSwb7MzgSkndUWy+xp+dfNIC6TKbKSiKM7C1i8U/pxtuof5PIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g0lIPrRX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0lIPrRX"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so29562005e9.2
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 06:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750080219; x=1750685019; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/qEWpHoeWIO3tFYAF9CvYNghxJJaKn+YeJWG4YUN/nk=;
        b=g0lIPrRXeBkCdieZow4owicA0RwudmCxRTS/s1Q0+cxQEH0h09BhcKTdRn5mcSUkxf
         ww/7zrlzrbuTKNtCBRv7lFm6gPC2KMHfbgjyovgDJ7TUJb/jzLNlJINDoUiPfIl7JA1G
         TQALTbeI67RRszJhaLcwOz6CtcfLYAOAU9k1ydtLog5eVULZXEvV58K7rMWqvYeNZxts
         S5XO552SJbpIxzybVATjac8DeZTpHok9vyEpAHhPhZkqB6f32bV0WVVy0WUp2jJgf/ZM
         mFd0guyNm3so2Pj6HXcncuEsNPhJuZCRVJ/LKS/j4VoNDLI4jNIS2AkjhIq1N62eSLbE
         4C3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080219; x=1750685019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qEWpHoeWIO3tFYAF9CvYNghxJJaKn+YeJWG4YUN/nk=;
        b=irM8Pvhr0brLVsxyF/2/c8a0z6JLi39VaAWlaXFGLF9goxGMl2eNvd42WzKr9CO2Uw
         LGg9odIIrNYcbqW/GwKpc0S86B1LNAAfOjaAwSit4BGXMGku3l0XUh8Si3uATk2hx7t2
         ZQiEnqp+R+Fqcll8mxrS9wBm+7ZqqwmmuRAOM7bDbGBQ+rqVZFFb7wq1bIXxKeg9Nk9o
         EVAnJkZqH+VaebvxWpKgbvMxfbzNUycyFaG1fLigIrVXnDgve1GZ04CsN5kc+OqOeMOc
         OLRmFeBUSIlLihm3TpHjCb6yUK245fmuDQZLvkNV1L6KiAAp+fjv8gTCh3rrKx9/AFgk
         d8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVw+PUtd1uvFwColnkIiolbiGW7QavEiUmYbd4OUCWOZdTwg+EVsihtBPyHwZb7e3YuBr+n4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCVtxbEZ97tw1uLJgcGcKDkSkoHOkmm7mwZ1xV9I6XxtelIY+S
	krK9jh9NVlRIVAzR1KYMOZbiUng37NO5RUXAkEGd0pTcL/KTrRywb1bf6c00XiTYAag=
X-Gm-Gg: ASbGncv4dxL4mNQMJ1puyAXYzQTpAXQuyiJ6NaVnWb9+oQDpxXLeFKqxA6ntkRwUrI8
	0acPkehhYFdfBmSTCuBQQ4UKXAuv3yEruTAGJqLTZt8quZFXgTbtBTBIFURzFefJ+tMPguXWowp
	XRqRHU6XKZKn3SZGulq0Tk9y6INm+11UE2ma9uvoO4j+MxwMuWSDYGUIwauwCV9s9UuXjqdySt6
	R66CozdTpV6ZnWHrzPv2Mldw15Ku1HZj4vcb/onQIPpeigZDGomHI06RYUs0wss5cvSTv9fX6cF
	2/C+E0ZQ0TuuNi0/TYI/mWJkUnsQYXLf+DQhdhPhIUidVntvkzFJ1fmwXTBpRC25EgY=
X-Google-Smtp-Source: AGHT+IERCtaWBolBNjDrXYPOFWEd3Y/yA2ERjVGzzTRMp9TUI6iIxEBCxIQatiSsuRqkKHIXYBVg9A==
X-Received: by 2002:a05:600c:1d1f:b0:440:68db:9fef with SMTP id 5b1f17b1804b1-4534f9f165amr12231765e9.20.1750080218851;
        Mon, 16 Jun 2025 06:23:38 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e241b70sm142753815e9.18.2025.06.16.06.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 06:23:38 -0700 (PDT)
Message-ID: <f723d490-c228-42d5-9f9f-158df54a092d@linaro.org>
Date: Mon, 16 Jun 2025 14:23:37 +0100
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
References: <20250616111749.316413-1-james.clark@linaro.org>
 <20250616112927.GA21689@lst.de>
 <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk>
 <20250616120832.GA24959@lst.de>
 <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk>
 <20250616121444.GA25443@lst.de>
 <7cfcf919-3c7d-4f0c-911f-697ea3141080@linaro.org>
 <20250616131346.GB29838@lst.de>
 <83855c1a-c128-4762-9d6b-e17f2c4c8820@linaro.org>
 <d16bdc40-20d6-49db-bf41-18bb9b8e01fd@linaro.org>
 <20250616131944.GA30260@lst.de>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250616131944.GA30260@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/06/2025 2:19 pm, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 02:15:56PM +0100, James Clark wrote:
>>> Yes it does, it has a few modes that don't require it. Presumably we can't
>>> just add a depends into the kconfig for all devices because they might not
>>> be using DMA.
>>
>> *for all the different variants of spi-fsl-dpsi devices I mean
> 
> This is drivers/spi/spi-fsl-dspi.c?
> 
> Yes, looks like it is one of those rare devices supporting a DMA and
> non-DMA mode.  But everything seems nicely guarded off using
> "dspi->devtype_data->trans_mode == DSPI_DMA_MODE" checks there.  So
> wrap them into a little helper using IS_ENABLED(CONFIG_HAS_DMA) and
> everything should be sorted out.

Sure, I don't mind doing it.

But separately to that, I still think making the stubs consistent would 
save people a lot of time diagnosing build failures if they switch 
existing code to any of those 3 functions. Principle of Least 
Astonishment and all that.

