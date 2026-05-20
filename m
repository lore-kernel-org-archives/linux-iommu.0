Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C632D94B0
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284291; cv=none; b=eB5BrPFxxerN+73on5zBDPLniZf7EglQJtQj+3JOiHNFkQ6/EabCrja0uuIK2EirAZ9kMbMQ21EMXrOwiG3QX6NCM3MVjfSTmX7dV1Xi6ODfDN7R5FkkK50LIt3/hid3OvZNNtdE4s08m9Po2BWjBm89ml34dfcU/D0UH+Lnyd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284291; c=relaxed/simple;
	bh=FcTKYryF3HlZcFivdjcw94sl1hUA9PtC2/zgtt2ZZvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY6CKOuDe5vaMBdJV3VAI71X51J5fLWzfwBUI+qNKMUVS8iglzHMsVVVESm83ES6PbM0BVwIZXVuDArGZMCQ7o0D+nT5wTcLyjxU5dgIGkVbbWmcGHDNI6Dg8akrJ6i+r8xxV/adBJFWHgSSe8BbmuX3k3sWvyQLqHazAdfdDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jTH8kzf4; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jTH8kzf4"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-910f734b477so542117485a.0
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779284289; x=1779889089; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ta3JnaFAadHaT886JLq7+5Wp7lPw1ufIXyuy/64QRsk=;
        b=jTH8kzf4AfL1oasrp745s2lsc6mToh7wmO+2/43ZgofmOpsTb8Yy/A5UE7Mk4tJw8q
         KAp1QeCU1EcezyIkqKMwNEYbezKjgUSSLZG3LMzv0orifldeNzT5HEW4ViwfBZWT6Bsb
         LdelwNpl0PhqpOGGWdvEWhwhtMM2hmfxMvQg60aFDCscILrFhzfN6subeFrWxVn7KYqo
         o8ROMiI0FaJMv9fLhraJxhv7mr99C8NZ1vnSK6krhR8K9TLEiKJrBNukeY7Avj9Md5ia
         D6+jodC921THcdMc6vuZWbmL5iKZLIZO4CLFXfYTJrNZZkGEr9TsnX6W6XEoF+yRxg68
         5dTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284289; x=1779889089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta3JnaFAadHaT886JLq7+5Wp7lPw1ufIXyuy/64QRsk=;
        b=GI9JxfFTOFNfPQnMXPtMzqOjKT//0ECuR8TmgjH6HWuvVlxF+d3uLUUb0rqPMfvix9
         Pfp/QTmJjR8cc8uEo+J38EQ9v1hRzndXfX5Rk0L6dkm4EPceHralZ2n+o2xot3+u0uDY
         S0qlZX+Sc/YekNoII0AsoflHv0H6Acd/5sUkrjSNWrOLbN52Hi7WNkrvKEHb23zfaVDL
         XhsMBDsqKBOSOAhxd3euT0P0bOyErmIhFa1wdbEmzpNug9nm8PGvd5AJzLUKRPQaJ/t/
         w6SzkzW2Ctc+8GIO8Quh92q0En5vEHKa0o/NwGYancJIzpVozW0rf2i8PshqVAvo3nQ8
         1dTQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LLllQ+TOyfFgashT/OmiZfAvowWYTYWJ62NExVGdmaTTOVeftiQF0fg+rcX2IIeCDC9Al6A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw65sJtu+KnKy/s+0tEeWUqBWkDbXxZ5JnlCFXlxoUFiXKiyxUW
	9XjhQ28YuR6MWRYPPRO0x4YfJ63b9uQzixKGYn9xvUsLzqnlRfIBkdc7cnvdIPlHlWc=
X-Gm-Gg: Acq92OFasiGZV8vxcahDJipv+2k2rxQb2XON2pC6DIncCcdhXuMAGx4tPIl50xwsIvC
	kzffo/Drbm+5v/AhwWjIZf/VVyOdrxcBQGy64oVUj1ujQ8AG6Gsv882fgKtD6AflgHTAtUMt6GV
	mdY1BB0aVkZyaHUIAZP7wVFZVePuXXWao58ij1LUjZNrezLGwPjhcub029FZ9yjex6CKvN0G3Ky
	ZC4vlTyqV/Q5n8VCft8+M6ilffF8+Wdph5erY14QPw81d8MErpzlYr8YxwV0zOxYeOzx/kHBvKP
	6sqNpphwGgonKofoc3EJRf5OHzjvLRMkaVcGHJo3uBIOjiaVii9vUxDaYEq3x0dptEUO062F9lX
	63xxabcCyqI0We/9iks0JNRdPxIcz0Ex2ipWjZzO5ZQz0DKjAZzO/pewKkUFyOkJciSDmYeWUdz
	+jh8EqD92AiUaP3aeRK+nwJg5eQ7+VMJVZb24Ks+9q54MwHK4Vy0RX4fmW/tRqRKCM5ZJVjiEBI
	mo8r59jGM8F4Tsv
X-Received: by 2002:a05:620a:2950:b0:8ef:f1c0:ab7f with SMTP id af79cd13be357-911ce524059mr3564626085a.24.1779284288689;
        Wed, 20 May 2026 06:38:08 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83ff00sm2144919485a.26.2026.05.20.06.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:38:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPh7f-0000000HAxk-0y0i;
	Wed, 20 May 2026 10:38:07 -0300
Date: Wed, 20 May 2026 10:38:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 1/4] iommu: Move Hyper-V IOMMU driver to its own
 subdirectory
Message-ID: <20260520133807.GS7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-2-zhangyu1@linux.microsoft.com>
 <20260515221918.GJ7702@ziepe.ca>
 <elo7enhxk5m7x4rc4quiqnkgbwsqa3ex7di2ksv7szu75xqe6x@zum5nwmkl6kn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <elo7enhxk5m7x4rc4quiqnkgbwsqa3ex7di2ksv7szu75xqe6x@zum5nwmkl6kn>

On Wed, May 20, 2026 at 02:37:03PM +0800, Yu Zhang wrote:
> On Fri, May 15, 2026 at 07:19:18PM -0300, Jason Gunthorpe wrote:
> > On Tue, May 12, 2026 at 12:24:05AM +0800, Yu Zhang wrote:
> > > From: Easwar Hariharan <eahariha@linux.microsoft.com>
> > > 
> > > The Hyper-V IOMMU driver currently only supports IRQ remapping.
> > > As it will be adding DMA remapping support, prepare a directory
> > > to contain all the different feature files.
> > 
> > Any possibility we could put the irq remapping thing under the irq
> > directory?
> > 
> > The other drivers have it here because they are co-mingled with their
> > iommu HW, will hyperv have the same issue?
> > 
> 
> Good question. I don't think Hyper-V have the same co-mingling issue.
> 
> But from a code organization perspective, I think drivers/iommu/hyperv/
> is still the most natural place:
> 
> - The IRQ remapping framework itself (drivers/iommu/irq_remapping.c
>   and its internal header irq_remapping.h) lives under drivers/iommu/,
>   and all three backends (intel/, amd/, hyperv/) sit there today.
>   hyperv/irq_remapping.c includes that internal header directly.

IMHO it is a fair question if that even belongs under iommu.

I think it was dumped into here because of the co-mingled drivers..

Jason
