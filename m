Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68058C1F
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334499; cv=none; b=TNa8MIAbVfEPig4BA5pM6FHQ1MCslYb1lAiHzWIrRLfFznu44epj1vJfppf9F01ei9wfkZRDzxLz9wIgbekVD7HDoYyB+ELTR2zqIuBfxa4tF4iFxKKBQfQEcMfkb2mBLjOLsFXabg799HM9UFSBSz4sBZ8rhVuyufZWM2979Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334499; c=relaxed/simple;
	bh=QScjIjS+08rOjpmvtHUriwdOvh5yhFq6mIStf39uLrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBEheEIdv0B4MEGRmE80ifUwEWC5OMzOvmrNaXgMZASbnKaBJiJDH3WirMZxNEia8HABcP9yXfijRfIu6XWAtCj1MIyeRsnqjwTx/bUFiDHMjxeI2cSpmk+HPXQ0ggTQKJ5bitcBrnUA8IzPJDN3D/A92G8vlGoLfzWxX7Jtkj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YKvKe/Fp; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YKvKe/Fp"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5579235200so5347032a12.3
        for <iommu@lists.linux.dev>; Wed, 01 Oct 2025 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759334497; x=1759939297; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UH6IkusvJFATMVxIHkG8s4UMo8zcL0KjEQKMfxIzPfU=;
        b=YKvKe/FpTyqxtR5O6wiCepwglurzoQJhMo7WwuIuniXmKmZ8otO475Uf6iYdWcz5Od
         tyYHIquUJCnXnXie7ZTvBIucD+R4ZV2EwZeY5ShPzoe0j9N13OFIOitn5Pl2rnwtlepU
         0jBWgKJ8iSCG545iCccHe49H1SQMJtLL4MDuX5LfKtuKVDeHtfisFz4zHEiDrh7rGUV0
         wSW5KurtC5dEf9BQpNTWUALGysdt1nn+ArJbkhpHlRZB9WiMEJw3rhdey0iRtlnq+SsK
         7XJTdHZ2KO0fFsOyZh44uiTa4SS1LEaFxh1UtbCLc1df6LyEkoZflc0PBzYoCH4DyQV9
         ccsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334497; x=1759939297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UH6IkusvJFATMVxIHkG8s4UMo8zcL0KjEQKMfxIzPfU=;
        b=nxIKOPN2qFSVOYFU8w58qPFmSHxsnIsUArkMbWvwjFzTz8WEN2YsnS1xOwk3IsTQkO
         Oz8z53iFkFlqjdo6NvmGJpW4I0GuSlYWbBEste4b3+dD/Iv2Fc4+ztvCJJeG7J01mnxI
         E/BTzMkaNyqjqlervFtdNGpVw90Ox/sbARA7Wz7VQpQ6Ax4nnmLg+9SEby/ffKmfPHbC
         1gmi2CX5uhjqS9q2FHZpDUfrkBqlDZd1eQEDdRiV5v9UUhAnPQdd9gZw7NRiUddIFgno
         Vdg60RYpec/AYAkc4kFYwUwphuHuNyp+4UjmV2IIMsACn/Q5XqjpfiNIq8x9XxD42Zgl
         fzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6XIbTuSGX9p1eSyhV0zDqSwAEbW+tHeyF3rq+9URL0ygcy4FOSlrhqrwspfcYCtYMTfU/Ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfXuTNvC1kb+raqpoUXZf0wMyiE3WX/SEDVeCPPb9nZ6OJ7Z8q
	Ouu+Sv1UWbltkNQjRqoknWtxhHSzQ8dMECDISs6wtKg1L41zFPOEiUU8a6fXcjr7xwg=
X-Gm-Gg: ASbGncsbKP0CqqC2RZDz4PYszu+YDybQ5iz3hlJKxo1zy0qhSakvmRUs4lFPP3HKL/8
	9SnM4k6BAmRJyCIh5SjFqPpNXVIL+cCrBeVAVuYYgxpeL1841YKICmKKm5dy/MXBFmDz8rSCYzJ
	I1VakG7Be8ny+kjkYp/beZ4iMa5Gg7M42cRLXNRNd8lup05IQr2s7hieWBpbyZLMtIdPV4Ixrwp
	kA2iY2Tl9sJkAk3oLtR/NhX8OaEd+Zy0tIMhRVD+YyY8EuAwwBGFyGB4iYlnZ2BLU7P/hGlNkzR
	DiD63gOy/SwuJvWP+pUeiETgzPTLty6xJI88VMoMdzJlndsq6Mab8AQJfXux6/L8VkTC3sk2823
	5aGQdt1lbUMaUmdsEF1oG
X-Google-Smtp-Source: AGHT+IExwHPQDdMmrUmU/Gt9OCBOCpSUvUeFlozS00WZfFCFEsNWqjNIoRXAmCYpPytPWPAcbS0LDQ==
X-Received: by 2002:a17:902:db01:b0:26d:d860:3db1 with SMTP id d9443c01a7336-28e7f329234mr51251095ad.24.1759334494849;
        Wed, 01 Oct 2025 09:01:34 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d24fdsm196895ad.93.2025.10.01.09.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 09:01:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3zGm-0000000D4Pi-2l7S;
	Wed, 01 Oct 2025 13:01:32 -0300
Date: Wed, 1 Oct 2025 13:01:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Johan Hovold <johan@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] iommu: fix device leaks
Message-ID: <20251001160132.GX2695987@ziepe.ca>
References: <20250925122756.10910-1-johan@kernel.org>
 <20250930182158.GS2695987@ziepe.ca>
 <aNzxWZlWmQMokLd_@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNzxWZlWmQMokLd_@hovoldconsulting.com>

On Wed, Oct 01, 2025 at 11:16:09AM +0200, Johan Hovold wrote:

> This seems to be more a case of developers not reading documentation and
> copying implementations from existing drivers.

IMHO the drivers are mis-using of_xlate, it shouldn't be looking up
drvdata at all.
 
> > IDK if it is worth fixing like this, or if more effort should be put
> > to make the drivers use of_xlate properly - the arm smmu drivers show
> > the only way to use it..
> 
> As Robin pointed out, those drivers just drop the reference as they
> should (even if I'd drop the reference after looking up the driver
> data).

So I wrote the series to clean this up and drop the calls to
of_find_device_by_node() and so on.

I left dart, exynos, msm and omap as-is, so I suggest you trim this
series to only those drivers and rely on my version to fix the rest.

Jason
