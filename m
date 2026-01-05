Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D62DF131
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767624806; cv=none; b=FmHS9TGA+m5LJoeRGo5QdXDsErZSuEzCTyTJeeKheeiBRbe/q50xag5KP0AK4EqufgS9AnPRlxYJIe/rQM4fdjWb1FrPNU6fndsjLdvmer6Mh4yPJ+gzlmpj98Js9SeaV7USmjez+y5+u6NBl81KLS76CsowONoSSJUP6j4T4ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767624806; c=relaxed/simple;
	bh=0VJAy1LxeO1DoMMmQqr6qf7GwbBJdW99Z0xb4rwj9wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7FlUSOpMeiZaF0MyDO8vFxksKS5r4AsqfyjN9LaSGiSkyRqtuHzu7/ldr6iQCAcWafF3WPZr2omKce5Nxv5E1zIyYbtii40ZO5uvbLq9k4af05Usjg1JdZUmR0z2uBtBHqqgqMsInlnb7+TvPJtuAFcU7jVFQCGExoLMeZjglQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Mf4ST3sl; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Mf4ST3sl"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2148ca40eso2278590685a.1
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767624803; x=1768229603; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0VJAy1LxeO1DoMMmQqr6qf7GwbBJdW99Z0xb4rwj9wE=;
        b=Mf4ST3slFWs+QV/gmpPahBeQSph/p3ge7RLC456vddZVJCpzK5mnzhUGLSgH0ZdZYW
         4FqsGKZuoSaEGTYm2rycr7FPxZSpwpfz1iH3dumm191Vs6Sbuch55yquci2hSp5tUosq
         GYHTFjwvJME29s7ZGOEx+LQIlf3Iree8t1YBxSyARndNN7Tm1q5w5nVVj7YdEPIl/tif
         rtl7PQF7ORbjbOFyvZi6HjxVqfNWw8GUmXvMCzC3U437YWMejM/wb19+cqDSC2zFbIIC
         NePQuGKwjUOZBzuAwsqcrmJ4zu616fbZqJFutJts9paYEQcpK6jygpCnvai6JI8bNf25
         j/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767624803; x=1768229603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VJAy1LxeO1DoMMmQqr6qf7GwbBJdW99Z0xb4rwj9wE=;
        b=Fm3aGj/WJIB0YzaEMXuHPLOr5tSaJmtbRpfAz7VZJ/YTHkA4WodXncz25fbuDAjpjl
         q5aPmi2tAZxOPAC0s0estxM4O6SGehYKakguFC4b68n/Is2ITbnJNVDSrNre/cCFbp0+
         olEBTZNdtD5jRI3YaDul7CR9MLwVXQU7kzWuk+fiYpfoy3DYiT5bRdunkrw+M0t7Hve1
         U2XbgR1rMPub6sczLCsbUllaQXK8In4HaK6/vyPtSUZQadMpwopRMxNf2QQcobU9ayla
         jJxHRUsgRgN8pEKQGWhXYkvEstMQYglHQYpSGnTVB3P7e+aFh0JKubm4D+npjD4On473
         wlyg==
X-Forwarded-Encrypted: i=1; AJvYcCVP+yqzu0AJg+QPZT+LKbQcKyvN+mHXXdDCmmHLthV1Qmb+Wwe7mJB06RVacP9JapvwskoOtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPziJ9fnspTJqzzHjnr2YOyuLMb2w6NMsGUlZijobvZW5ZuFQd
	RjmOe63wNolRUd1nLglMv9CSJiTniGej8Bbl7ymTJgQzLUhP1zjQvskovPMRxRr0Vu0=
X-Gm-Gg: AY/fxX5n7e7/gSx/hX5XtiM4cUZGiWFUDHa9wfCIPNQLlU8pVbTelJAiuuUuAqI5nnp
	2SHLpMuV76v+mKEGhRV//2OU+OpPmu9KHpWfWQZG4BlFOjla6mAlCq+iIg0dmNSBBzITv2fZawn
	ShhUUZrYx9M0DialNoSXGG41l5Oh+8lcN2c4woGWvs9NXanjcq7iVS89USNZbgNmgdZe0FoCwBk
	GsFCfafjhZRj+juZjJ7HzTLkRrBQyZtNhJ6a53vuu1B879iwjE+9vvxQtmnlpjBrCrNmyymqiQp
	orDR3M2pd+PnBBQD9ifJ8g8xpIpe6GHrOkMU3WWwEreI/9kMKvI30Em/e3WaaU7bPZlNvP/l5D/
	3damMW/5UrgBErXHMN7a8WKwlWzO+m3lZOfKhxDP4PxHFwiGcf9TGuc2tg5x5/nzMA2LUwIjTCp
	QNOr9yDIjryZILOkn3XP7rG3XRi69xrEU+OhYMMBtpPblyOR9lzgxz6KDCgH1Nsg7/a5M=
X-Google-Smtp-Source: AGHT+IFUt6wPvI9u2rR/xi8Np2VLLWZzGxeI/Po3U8DHhN0nYQEKldceIemvjTqj2Iro8b99/psoBA==
X-Received: by 2002:a05:620a:4611:b0:89f:19e:46fa with SMTP id af79cd13be357-8c08fab5a22mr6994767385a.20.1767624803162;
        Mon, 05 Jan 2026 06:53:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f28e3sm3963769885a.45.2026.01.05.06.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:53:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vclxR-00000001ANB-23EY;
	Mon, 05 Jan 2026 10:53:21 -0400
Date: Mon, 5 Jan 2026 10:53:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Dawei Li <dawei.li@linux.dev>, will@kernel.org, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Maintain valid access attributes for
 non-coherent SMMU
Message-ID: <20260105145321.GD125261@ziepe.ca>
References: <20251229002354.162872-1-dawei.li@linux.dev>
 <c25309d1-0424-495e-82af-d025b3e6d8c8@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c25309d1-0424-495e-82af-d025b3e6d8c8@arm.com>

On Mon, Jan 05, 2026 at 01:33:34PM +0000, Robin Murphy wrote:
> The assumption is that if the SMMU is not I/O-coherent, then the Normal
> Cacheable attribute will inherently degrade to a non-snooping (and thus
> effectively Normal Non-Cacheable) one, as that's essentially what AXI will
> do in practice, and thus the attribute doesn't actually matter all that much
> in terms of functional correctness. If the SMMU _is_ capable of snooping but
> is not described as such then frankly firmware is wrong.

Sadly I am aware of people doing this.. Either a HW bug or some other
weird issue forces the FW to set a non-coherent FW attribute even
though the HW is partially or fully able to process cachable AXI
attributes.

It is reasonable that Linux will set the attributes properly based on
what it is doing. Setting the wrong attributes and expecting the HW to
ignore them seems like a hacky direction.

I didn't see anything in the spec that says COHACC means the memory
attributes are ignored and forced to non-coherent, even though that is
the current assumption of the driver.

> If prople have a good reason for wanting to use a coherent SMMU
> non-coherently (and/or control of allocation hints), then that should really
> be some kind of driver-level option - it would need a bit of additional DMA
> API work (which has been low down my to-do list for a few years now...), but
> it's perfectly achievable, and I think it's still preferable to abusing the
> COHACC override in firmware.

IMHO, this is a different topic, and something that will probably
become interesting this year. I'm aware of some HW/drivers that needs
optional non-coherent mappings for isochronous flows - but it is not
the DMA API that is the main issue but the page table walks :\

Jason
