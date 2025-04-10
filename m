Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756B3212FAC
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744326013; cv=none; b=rc1ewM0kAbAOuGvNoOg9GhGUTXklAuUFHAPVo17NDlX1Nc3AJXeViG7XLIuy6KjKAaNNdwNVIbsxO6REGHL2qBz71YXfgk384p5p+XkYNd+Bbrx4pemOAd+P4O7/kMf/bAkJSzxWj530FNyeu9lINffb7wrbCjdxiAVK9XxV/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744326013; c=relaxed/simple;
	bh=KJDeLRPNP4KR15v2b6aVw2383AZQQQwiuSEL1SwZOgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdwqXdyYZxDi7MdJ5ZYiaQitwNS5Ng+7Er5ojjh59gLdj60JbsgmKsw2M5KpsSDA1DPTNeZDtWEDoK4VIrAgLDLkvQidNUWveFsYSFHTcpU1cAoCdQC8/6KSR4SxfO2DxTXLJt00YE7AkN5oYZgooGHB8k+Bh7TtYyqHNw4fGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WnbtB+Wd; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WnbtB+Wd"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5a88b34a6so135460085a.3
        for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 16:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744326010; x=1744930810; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JpO2S4wctyk68CVyOkNnoYhQpTc8ULQAveyt4WbuIOg=;
        b=WnbtB+Wdyi9jHaaB9LPX2jwsCMHs+4q+9XCQ+OpRLZYucnGP6WDgROT3kKxuTzEeWi
         KXUjSIVmGWoNz/PBKaGOL6+yr8gV2MnQ8K8MMHO/v/NHaaHUXbKNS8Y8SSOBLEdcQtDT
         YCgPdnC/uusQps3rwyYhFbInqATGLjFwX5QrY4GNywF2MdoRZfvXUo4X1MurD00BtnFq
         +WTHt6a1HFRWiAyTu5sVP4TZBxfCne0yQ7onMSEfo6pUEDs/DMPUpu7u9edozq227Xhz
         xta22W+0WuDTvZCaljdx99q3Gi/On6bkqRbe7Dg+8OQMHNT/UHfGuVglClkIIVtzx5jg
         aBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744326010; x=1744930810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpO2S4wctyk68CVyOkNnoYhQpTc8ULQAveyt4WbuIOg=;
        b=EMsqROlHIcHaFcSusAB9Nbxms0n2USP8HgSr5ouN/6b3lMJMHXY7/mHcBjQ19Gcwkw
         suYLBT42KGehq3iLhW5v7IityrBm5gjLzOUTczw/y/XHcfK91t0bE20ghqh9HlO51v3Z
         zsVS/vt+AlQszkZe996QY3gk0klwCGHADjYAIhP05QzzDGn/xRAX/qm/NZlSoyO7BvHC
         84pK1xdg7qsAKMWumei7NpSsHbvpZNqB2HRTlho038LPnf5UxNs2NfevU3bw/eE5iO6V
         Ps3bs8e56JaOfHcvdFL0h1qRnt9bLFCjQKK881PkCpoXZBRws5LwQDJClVhVoPbACb0f
         7k7A==
X-Gm-Message-State: AOJu0YxIJOrkpvgzawPxZJZWtToVicJ/2FuPDttmWdOHqaaxU+0fO7bi
	9IKHMHpzm1QB1mu81t9IMoS72bOsCRRS5MQ1trPtepchaj9KayuxZYvEwsETApo=
X-Gm-Gg: ASbGncuy11ci/s6UU1X5fbvjB9kkbvmrGoIXF29Dhh9FaQEJsDSEGEJnXsRJ8D2mLrp
	SRkEQY7OZRaOqo9xfTQ4jdrPPC1M0xb12OwQSADYBMoVDDPbiZvKS9plslUc+upuqwuzd0aER7v
	opDMW86FdSzi1bvxIyHa8NkSxzIB0aOPl+b+G7fkrDcEn8u0a+Chn84Ay7XpBvWU23wWTtO9lO5
	hd6pMLqkVxo6Ol6jNhN3heqJop8JXWryqndZ+2+ixBZfVksESicRQBokmywHMk/Z3xnFe/gQKIt
	kuoiFRnS/Udkhblj5JjnyBAftJfHacR2baWoRbjz6yQoYe6Q1ixR1rYxucGh61OW7i8vLp4ov8X
	IQ1Qm5HcFulKgoCak29U=
X-Google-Smtp-Source: AGHT+IHr0/WY2Rqb4JC2JVZGgAH4AixNta9jAPZvPdjOUO1pv6CI6b5DlSO9IE1VF0/bDnrgXDRKew==
X-Received: by 2002:a05:620a:4306:b0:7c5:5cc4:ca5c with SMTP id af79cd13be357-7c7af12e6ebmr102606285a.14.1744326010083;
        Thu, 10 Apr 2025 16:00:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a89437a4sm164415585a.23.2025.04.10.16.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 16:00:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u30sS-00000000GRz-4851;
	Thu, 10 Apr 2025 20:00:08 -0300
Date: Thu, 10 Apr 2025 20:00:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	will@kernel.org, jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250410230008.GA6905@ziepe.ca>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>

On Thu, Apr 10, 2025 at 03:50:27PM -0700, Shyam Saini wrote:
> 
> Hi,
> 
> Currently, the MSI_IOVA_BASE address is hard-coded to 0x80000000,
> assuming that all platforms have this address available for MSI IOVA
> reservation. However, this is not always the case, as some platforms
> reserve this address for other purposes. Consequently, these platforms
> cannot reserve the MSI_IOVA_BASE address for MSI.
> 
> There was an [1] attempt to fix this problem by passing the MSI IOVA
> base as a kernel command line parameter.
> 
> This patch series aims to address the issue by introducing a new DTS
> property, "arm,smmu-faulty-msi-iova" which can be used to hold faulty
> MSI IOVA address. This property can be passed to ARM SMMU drivers
> via device tree so that the drivers can select appropriate MSI IOVA base
> address which doesn't intersect with the faulty MSI IOVA address.

I thought we already talked about this and you were not going to be
doing a DT proposal for a software knob?

And then you didn't even link to the recent discussion :(

https://lore.kernel.org/linux-iommu/20250403232619.GA681099@ziepe.ca/

It is easily solved in the smmuv3 driver without out any DT. Please
do that.

Jason
