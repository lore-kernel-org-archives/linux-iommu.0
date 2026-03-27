Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391AE3932D8
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613425; cv=none; b=jM3MqrjeI+EaSoSXpJTXsO47WvXXCir0vmeARdevpoLWybL2zzN6t5/G76l4JCkrOzqMNWFTiIHsKXKs8XKDN5kHcz2Z7/w4RB3+nmT5zbkMj7RqZGpsKwJ/VXyoC6jPImhYLHMiN/0x1JhIR3XEVmKZYD+a6vHfKnex/SdseTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613425; c=relaxed/simple;
	bh=ghZHpLykub1cNN1HjFeRqA1TQ1HWa/ZB0207dvHDd5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvsps3er4WMyAAlc/0+7iM1TPV6r+fhp69YJmp2irJZeoL/W6SD6zSdzOQvG5ejudS3gTwgscDdSY4neuLcUSweiEQKRfYh1dfAEuzdPnHxfmINM1AduBYSyf9yolTYFAbS/ew5/lHNzivxYrAKgMFaC928MB7ZCWE4CVp0CQwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J4Y3Ml+P; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J4Y3Ml+P"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb3bae8d3eso210520785a.1
        for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774613423; x=1775218223; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfIjIsS8DDjImfR7uqLq3DxooHT40pwlydrjxj52iHU=;
        b=J4Y3Ml+P38SFSU1flktb/4yGjijQhQ2rT4DXAlqr2iNzJkbQ8vUMp6loajYwv2wuU9
         6Suv036iYmcz4YNaIpE800kHAjwfXFASrlwpPWxiHh2pmhJDZOF48tYZBo0Pn7kTAu5Q
         upgaXP4LAmhSzrmHje86hJ9Ij+wrh1yPWUwTZv3HnxtZPdassPgREJV0Dd0bQ9Ax4QOL
         NNy2e0Bn/kaG4cCveCcYuiTfm8aFULoRZwruvg9apa/jxpiumuxxGAEWo6sB64TN6RP1
         3HBdAdwhseNHHDUOEACrh6Xge90RXWz2e7+qR9sVlDsB3inRHG1F95dW54A+CnGoDw6r
         +Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774613423; x=1775218223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfIjIsS8DDjImfR7uqLq3DxooHT40pwlydrjxj52iHU=;
        b=ifHOsoTdjXrBT2ACg9nUBAu5UZD8LnoyhyiRWA+FT7MhplMkvAjC6Bjd00rJL5+2Xh
         HIwDCUjs83sCb609bcXmNb9a4EXDg2XKVMimaUlgQxum+t163btekXIljVGExBzi3ArV
         Qyc+MIhU73lqrNNHt3rqUCzTFlwA4F/JEWriYJ8rZnEs7jkxmmw1jRLnSyfGM9KZTjsV
         dH+HIMqSMbu0Vn7bKbcH0RdCEwCSe2TXtMYxyeCZ95NsZwFC9w1x7ymB2E0tFGEpmxPa
         STyTuzDT13UdbnHrI/kGnO22UP3g9/CvyirSXQtpoJM4+hw7V003I1myqkV0q01RalLC
         zVqA==
X-Forwarded-Encrypted: i=1; AJvYcCV7/9syT8WyM5ILsRTBi8GsroutI8TmbzFZUe5dqZvMsCXbosIaOoKH1Vx5Xh6RDWLXXm9GQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YywsJQcXbbtGNJEOspNsnXoiiWGfgnPVXnLfol8tHrCwkzWBLPb
	BQrWEiW2b4t9NoIE0ktlgc9hFDtPLjwCquYqMhwe8Mrm8dp82tsmaMihUsnFD91XFR4=
X-Gm-Gg: ATEYQzyNKckE2ikVxirlCptqYkR5jVT72M2zBqoqmhBv+m1IFh+ItJ4Sfj241td0UVZ
	KUmCT6PMlDQXqio63QbE5spOfjOOmPLwVOm8LI4wjIYH9tMqO03+0G5NT9rfcjCzyir1gpKU1xr
	tuGcyMdDmDsp8t+LsctDWc3Wa1OqheUvkRW3wZGYXhd9NzjdiOXrOs8psYNwlknmhxgqvpA9ARJ
	ICECsCkAYYLt05A1ucwTjO/VGRBhoUAjiFUyEU5ju0abDJmJW6Q9y85dVj506iAya3WXnybZ4mX
	bnyGmlhJb0Pyr62dNVQI9+TvTEC7Cb/B4lsaHMmEXyK+q86eHmljNGAXkokWDXpEsQjghlrc46H
	/LgNIBsRFz7945ujMr8iXKMGslmU/EgzUtH2RzhntqAAE74WNQfHnBeaRjwrCpAY6i5UGp1NEsZ
	6cAC1RWidLL2vn8f8Aj6zKjtQk7LZwvsBmdgO6K+atemHCWfwWqyYkCQdJyGNYstcBRXehbg==
X-Received: by 2002:a05:620a:4589:b0:8cd:6175:9b17 with SMTP id af79cd13be357-8d01c5bf3ffmr259778785a.3.1774613423032;
        Fri, 27 Mar 2026 05:10:23 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e3c3a0dsm507700285a.13.2026.03.27.05.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 05:10:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w6617-00000001CcJ-1QAP;
	Fri, 27 Mar 2026 09:10:21 -0300
Date: Fri, 27 Mar 2026 09:10:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	"T.J. Mercier" <tjmercier@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
	robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev,
	ptesarik@suse.com, catalin.marinas@arm.com, aneesh.kumar@kernel.org,
	suzuki.poulose@arm.com, steven.price@arm.com,
	thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
	suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 0/2] dma-buf: heaps: system: add an option to allocate
 explicitly shared/decrypted memory
Message-ID: <20260327121021.GB246076@ziepe.ca>
References: <CGME20260325192400eucas1p2ae38ff4c2b3ab35a7047cfd680d9fda3@eucas1p2.samsung.com>
 <20260325192352.437608-1-jiri@resnulli.us>
 <f2047cd7-91a8-4f6a-b6b9-0e4f143f6854@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2047cd7-91a8-4f6a-b6b9-0e4f143f6854@samsung.com>

On Fri, Mar 27, 2026 at 10:38:10AM +0100, Marek Szyprowski wrote:
> On 25.03.2026 20:23, Jiri Pirko wrote:
> > From: Jiri Pirko <jiri@nvidia.com>
> >
> > Confidential computing (CoCo) VMs/guests, such as AMD SEV and Intel TDX,
> > run with private/encrypted memory which creates a challenge
> > for devices that do not support DMA to it (no TDISP support).
> >
> > For kernel-only DMA operations, swiotlb bounce buffering provides a
> > transparent solution by copying data through shared memory.
> > However, the only way to get this memory into userspace is via the DMA
> > API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
> > the use of the memory to a single DMA device, and is incompatible with
> > pin_user_pages().
> >
> > These limitations are particularly problematic for the RDMA subsystem
> > which makes heavy use of pin_user_pages() and expects flexible memory
> > usage between many different DMA devices.
> >
> > This patch series enables userspace to explicitly request shared
> > (decrypted) memory allocations from new dma-buf system_cc_shared heap.
> > Userspace can mmap this memory and pass the dma-buf fd to other
> > existing importers such as RDMA or DRM devices to access the
> > memory. The DMA API is improved to allow the dma heap exporter to DMA
> > map the shared memory to each importing device.
> >
> > Based on dma-mapping-for-next e7442a68cd1ee797b585f045d348781e9c0dde0d
> 
> I would like to merge this to dma-mapping-next, but I feel a bit 
> uncomfortable with my lack of knowledge about CoCo and friends. Could 
> those who know a bit more about it provide some Reviewed-by tags?

I'm confident in the CC stuff, I was hoping to see someone from dmabuf
heap land ack that the uAPI design is OK.. TJ?

Jason
