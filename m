Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F052E2EEE
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773185660; cv=none; b=b3KTUAs1Wuj+OEdPpgNIVL67d/H8dmHSDJTUuKUFL3WLh00jGaF9LCyFsVxBpYbK1y7gbhI2ZZrxP060O047mWdA/2jxsBAl2bLzTFeyxMgTRXjLM7PvbtyVDYS3qGrXEHM2gLDaT55VmdDjHYWnLhU/KXN7YpsveB0GcDyyIxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773185660; c=relaxed/simple;
	bh=zCDQLm/ti7Fh+tEKDvr17wEEpnNO9M6S1JIlwzo9Acs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T97+lkNHguXQfs0GoMmFzr9um9XB3VYawdYj7NFJeqbBboHsXctuTWu69ifaVIZloJRv8uISUtstSrZw3RSj2HG4dBaLVmfNFVbrM6WpUP9WiVAhMu5Ffy4MxNAFCt0NccylC6lF/Nx7ja7Nf35Quf2aeuyCT9qf/KWKy2PJdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R2UopT5K; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R2UopT5K"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd79e43da3so350769085a.1
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 16:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773185658; x=1773790458; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsiIyQd4tPWumA9ZQMQURKCway9cLZHNLfL2p5j0zPY=;
        b=R2UopT5KSGYiUWREQzEGDMfEEYG0uNkdKE3WOXGZ/YShTaQbKQfDqc8FQl6Cwf5W8K
         SeEYlhpKAEOZcwmYsg5BtYRHqCQR2H/LGuU18Wh5ZZ0FIC3khlxLELFM1HyTB7w5PjP4
         za1Z/a7GHAn1JGJdWT7uCVHxgI5PixCqXPBpUBCxm5/6qTPDnqrjuk39otCiS4VEGjyk
         CawaehuVrAJhiXvTnUpNom94TRPvrypzH4sTdcQhmQlYR0hyvCyZC/2qD+Q7W3UwKwoP
         qCRCrzCBphSSN0l/2C/rAgFn0fisqx+FOzkLEdgAb/iJJUQn348nG2W1i34FcahlYMJ4
         bHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773185658; x=1773790458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsiIyQd4tPWumA9ZQMQURKCway9cLZHNLfL2p5j0zPY=;
        b=VpcuG/EuaISEKuN/BS7W35h/INXUto99QYNJ1SblcwOecq05849+qPNKdUlbMgCjMs
         VGxYjCtK5qO52iMGRdXP8QAJswYhbISFlO3hgeNlCY1cKLtFEUxTibYj1uq7aokCsHje
         uvIjcF8XCOq73+eMJGDeE8F8g621sL5A/qi5yPSFBq/tt+vtBaK523GmatG40S3wj/ue
         JdhT8pZSyl+MKLlDxHO7z7At6gVjYlBK4vRqDl+M8VgU+vTS7Quf2+M5ZbYarqfERyUx
         v3oTq0v9goioXjKsaUhgz5xUPniIWoINPDJA6z7mMiOSh6go9FBaQyTsGPB/zHRj8Esz
         Jegg==
X-Forwarded-Encrypted: i=1; AJvYcCUzRWkG0y0HHyxPcGMf3gvWCUNqwqLI7pv3JPDDnppqlZKn+7TGiadpO3QmeBfVfl/nda+Itw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnFnAQEuVrMd85WW91fJwufqdDulg0sgET92emLLXshVbUb/Pi
	mxZvH5OkZofSKiX2D3LX7+EfEFHgRG3nc8HqabsC5syB+CyJdrTddNU1hWONHwUTrx0=
X-Gm-Gg: ATEYQzxkFviHcmu1O0iX7w5Mmc6f2aBvSiZ/ruBEvoj943g9rG0jN+JxZmGwYeI8VVN
	j9PmIOtnfS4i8RFfb502+Sp7M27J3WUA9p8s5F9r2qi6w7zgPn6wlVbngo/kQj/RwWXwITmicSz
	mx5lKie0NaBqqhcVtS6stlhJUEY3SXMMc9t/z9O699dm3m+aMWxwn9MXiAx0uLcC0KgDKHeK8AV
	a01mRFcrjmcVF2SLhom1+SivWHb+GG/7+Anxdcucuypq7oRESP1r1l7Ekp+F/yjNvv/ynyp1jsP
	rCRksrQV+juXfy+xiRGN42H7S1jrbzZlv2x9LM9ntoQxD39rscoiQ3YaShMe5XLzfm5n8w+mjh/
	YeGnuIeQpI/95wZFlPSGSP5oZ4VT1anj/NhT74QX6YSvIFFitqtyQKRh/1b/pWjFW2O94Qfq0zQ
	Q5eCDpxT4bCkqvX6rTomi8XUhO4d/Ya900XsdEcbsNLebO6ZS+TEwBQYEEnHfFX/kMX3ySKSigI
	9T0ujef
X-Received: by 2002:a05:620a:3941:b0:8cd:982d:4101 with SMTP id af79cd13be357-8cda1a28be2mr93012785a.27.1773185658222;
        Tue, 10 Mar 2026 16:34:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fd6325sm24946085a.11.2026.03.10.16.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 16:34:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w06ae-000000064gS-3fKz;
	Tue, 10 Mar 2026 20:34:16 -0300
Date: Tue, 10 Mar 2026 20:34:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] dma-mapping: Clarify valid conditions for CPU cache
 line overlap
Message-ID: <20260310233416.GT1687929@ziepe.ca>
References: <20260308184902.GR12611@unreal>
 <20260308230916.GI1687929@ziepe.ca>
 <CGME20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07@eucas1p2.samsung.com>
 <20260309090342.GS12611@unreal>
 <c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>
 <20260309150502.GX12611@unreal>
 <20260309151356.GN1687929@ziepe.ca>
 <aaebc5b6-2805-46d3-a68e-549c26a3ef03@samsung.com>
 <20260310123405.GR1687929@ziepe.ca>
 <a61f8814-b896-4ec0-bb83-a8cbd8aca4e8@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a61f8814-b896-4ec0-bb83-a8cbd8aca4e8@samsung.com>

On Tue, Mar 10, 2026 at 10:08:38PM +0100, Marek Szyprowski wrote:
> On 10.03.2026 13:34, Jason Gunthorpe wrote:
> > On Tue, Mar 10, 2026 at 10:45:38AM +0100, Marek Szyprowski wrote:
> >> Jason is right. Indeed the rdma/uverbs case needs some extension to
> >> ensure that the coherent mapping is used, what is not possible now. This
> >> however doesn't mean that the DMA_ATTR_CPU_CACHE_OVERLAP is not needed
> >> for that use case too. I'm open to accept both. The only question I have
> >> is which name should we use? We already have DMA_ATTR_CPU_CACHE_CLEAN,
> >> while DMA_ATTR_CPU_CACHE_OVERLAP and
> >> DMA_ATTR_DEBUGGING_IGNORE_CACHELINES were proposed here. The last seems
> >> to be most descriptive.
> > If we do DMA_ATTR_REQUIRE_COHERENCE then I imagine it would internally
> > also set DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, but I'd prefer that
> > detail not leak into the callers.
> 
> Why DMA_ATTR_REQUIRE_COHERENCE should imply 
> DMA_ATTR_DEBUGGING_IGNORE_CACHELINES?

AFAICT the purpose of the DMA API debugging cacheline tracking is to
ensure that drivers are mapping things properly such that the cache
flushing in incoherent systems can properly cache flush them without
creating bugs (ie a dirty line overwriteing DMA'd data or something).

If the mapping is REQUIRE_COHERENCE then it is prevented from running
on systems where these cache artifacts can cause corruption, so we
don't need to track them and we don't need the strict restrictions on
what can be mapped.

Which trips up and gives false positives for cases like RDMA, DRM, etc
that are allowing userspace to multi-map userspace memory.

Jason
