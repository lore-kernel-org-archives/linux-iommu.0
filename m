Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B614329E52
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735271; cv=none; b=HNO27FDdPkqt86qN/CsbRNUCtYSEPhe4OkV7grWt00q30ROWy94IWSDjDyAIbUX/IyXAKb7cvHdPQBCh4F28i+F7XGzU7J7tc/V48VDCAt33PkXfKf+4yOb2tU2qsDLH667lMqBcc0IoT7M4gxqk9W6xadsBU0avJJbkln2XBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735271; c=relaxed/simple;
	bh=0cPCA9Kv3jfRsyrFM9MyPi7hD3kaQlMf7gj3XZzuvQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvQ6zD9ZqZ7EMNm0GgDRhDLNpHsDudqZdh5CH8nmdtKuBN9mnTH4fqL0pDNPF0nfwqiAj40hPnKrKDSaiFQYR/mVuKuGiA24B66NaG984U8x7vLQwgzPvLejhSg1ykyHj4VPmJ2DA+HcfoPF+PsEhVMbjWypI+5283Ut7t/E8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MRvi7TdG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MRvi7TdG"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c532d8be8cso534583385a.2
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 06:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770735269; x=1771340069; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Agj0c4R15XGINXILYWi8Un1ej02BkfWDujptUtk/bVQ=;
        b=MRvi7TdGGyu7NjDV6xpP6wYqDf2jQXKQw8LIFxpWFiI0qHxK7eiK4qRO90Ie9RXGQ/
         6MTDc+IVCINGT7li+lS+bjpvxNa+oQZ2P5f7MaS0Z3l5zOxVT2Q6NKRYJvvkiUxF5VIs
         FgQPujQUEOn2Z6dODEi7yDWgAmhdn2IhWOdqv7fJRPpLTpMSWU1+QsgVZdTdjR8Ee0Op
         m2ZPNgQhIVBIVQDX6cBlhaA8G5VW61/OCUN68oDfAZZFmOkypFpc3lKdMf2d3FEel815
         ZJiijv2+yeo9s2MmeHRxAU2rPv98L23Hy+tKqL+JnC843P290trWw5KcyMasTSp3/Sza
         igAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770735269; x=1771340069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Agj0c4R15XGINXILYWi8Un1ej02BkfWDujptUtk/bVQ=;
        b=A9YwbgH7B5Zoohi256NAIRRRN/9piZBywqyG3Nb3gMxJ7BNMFzMXv2UQTdXvq93hxN
         9S9FjokHPeSDL8iakd+Vi+fCpHoNVuRb3BpyFe97rIvIB7JELzHAtB4jI6UM8kI1PIr0
         taxtJCC5S/6Y0QYixXLWKQsdLB8lgYvG1c+fcDP3vZGE1+raxPGYq9v/A6RBy7OVmbNk
         pLez2Zk5f+09Ig9WUNuUFZ//iA8dA3U48+w7P+Q0zrwofFxjDU9vOXUM6bp80I3rck3t
         zCeD27+rNAcoZHuLeTS0pnpZ1f3NMF3Fo3ggPLU6nUpOUDLHwkhUameFmvoueJX5Yqmz
         7v5A==
X-Forwarded-Encrypted: i=1; AJvYcCUyM96n2+wEef7EwCE4jrNtb2IcUCGAbXxEs2yf54tFEK6P1UHpamQIOZBjYaXe5jC4f96dAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ6h7g0jVtOaKAn6S9r4c3KE0jNjKKVrV9ZpJYrZfZ1uFzNer6
	TTSSDSzAYTU/CMqjrmhnt4QgZDArUA6bYH1jHGbEHfNCNwx+239PtqGgckmvZnSCzPk=
X-Gm-Gg: AZuq6aK9V44QWF6d2fySXJPlROkUhKh29Zgnnqn3eDMedBs/NUonIXAeOmVTBizO75q
	r3sinVGxR+8P0Ieen412AINr5NcB/Tf5r/7ITCGLYrqp9va4MCDuelHK5Kjl4H9jatJwH60pUR2
	h2NXG23Nb4ZxjG/+OQVx1hQlP6X0c9cl35OnbveOEQWxa7XrzcO6fzqPKVAnx4McdXSlfSETY9z
	QfAMD9HokyMlMFMezwY3DMUmn65T/4hoqSJn3cFVD+aTfmXPLLV11z45R7aPjR+X1FIIC2xKBrK
	sOnin0SG+t5Ff0Bz+zneZUcqhM2fb9ru3x6XQ6F3jBsurkgsGGb3QXd5GqMzZliXTDSwZ/jw1Ar
	8tGIGM+P5y0v+0JepJVWCMYRjQ3qdhtG740oL3wSGiuCykXMYthVZyqbDeEgPu1zuFvn5g5ZXCF
	X0Gjr1D4lp1HHdWZbLuFvPxCqpN73BWaAhvjQsAaitnQjVpuex0Fg143gqnltrUXep/KVn3p+DN
	nBTuyI=
X-Received: by 2002:a05:620a:2804:b0:8c5:2f89:6904 with SMTP id af79cd13be357-8caefeb4daemr2082380185a.45.1770735269414;
        Tue, 10 Feb 2026 06:54:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9a157ddsm1121052485a.28.2026.02.10.06.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 06:54:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vpp8F-00000003mvN-47aU;
	Tue, 10 Feb 2026 10:54:27 -0400
Date: Tue, 10 Feb 2026 10:54:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: John Stultz <jstultz@google.com>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH 4/5] dma-buf: heaps: allow heap to specify valid heap
 flags
Message-ID: <20260210145427.GA750753@ziepe.ca>
References: <20260209153809.250835-1-jiri@resnulli.us>
 <20260209153809.250835-5-jiri@resnulli.us>
 <CANDhNCoHEZsNRmU+3z5AbeAy05H7PTtUdTq1apNd5k0f9hWW8A@mail.gmail.com>
 <20260210002927.GC943673@ziepe.ca>
 <tgvdjszwxggr53digbmddcbxvupzl4xcoprofkgrs2kgf6rknx@44ebljjpghjm>
 <20260210124357.GD943673@ziepe.ca>
 <y7gvezflidmma7odnut2rmlecsbxahrcwpmoevfnhzjveusuwj@6qxqogin45j3>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y7gvezflidmma7odnut2rmlecsbxahrcwpmoevfnhzjveusuwj@6qxqogin45j3>

On Tue, Feb 10, 2026 at 03:49:02PM +0100, Jiri Pirko wrote:
> Tue, Feb 10, 2026 at 01:43:57PM +0100, jgg@ziepe.ca wrote:
> >On Tue, Feb 10, 2026 at 10:14:08AM +0100, Jiri Pirko wrote:
> >
> >> >I'd advocate that the right design is for userspace to positively
> >> >signal via this flag that it wants/accepts shared memory and without
> >> >the flag shared memory should never be returned.
> >> 
> >> We can have the same behaviour with the separate heap, can't we?
> >> Userpace positively signals it wants/accepts the shared memory by
> >> choosing "system_cc_decrypted" heap name.
> >
> >So what do the other heap names do? Always private? Do you ever get
> >heaps that are unknowably private or shared (eg MMIO backed?)
> 
> If I understand the code correctly, you may get something like this:
> $ ls /dev/dma_heap/
> default_cma_region
> protected,secure-video
> protected,secure-video-record
> protected,trusted-ui
> system
> 
> The "protected*" ones are created by tee. I believe they handle
> memory that is inaccesible to CPU.

If that is the only list of options then maybe just the name will work
Ok.

I *think* CMA and system should be reliably CC private.

The protected ones seem to have their own internal definition, and
probably can't exist on CC VM systems..

Meaning we don't have any shared things leaking through which would be
the point.

Jason
