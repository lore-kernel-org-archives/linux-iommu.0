Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B52D5925
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238772; cv=none; b=bbKQg8FEGHWHu8pMa9Oztm6dhkGF6XggFxZ0QI1zI366xYjJALBFaa4nC/mo75Q15ZDDEkXrDmfgC2xtdgp1gCgtOjBxrXxK8Szp2KkKU0mZVeA55e3ARt1hT+WihLT4vGuvHGp/qw9KiL3eplRSj2S6Q6eGRpIPONFUCUgl+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238772; c=relaxed/simple;
	bh=ZrUWNUYcRB4S08yg1WEQ2YVogaM7A4KC4ZmR4pQ+1F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYwKRurnv53QVeiJvyxKcu4SoQ8EYYTaBmK15yvXM1kAQlGCMejjP+9qF4yJ86ATqsukt+Z/s0pSByr5dDyTSQ4vQGP9e6HIbBSzYxPRW/bsZgDM/KZFtAYI0Z83NS5KhPRq1iC0RNW/cCZGB25z2KGfC/Z9l1yewLKcLclqDUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Cel83xcd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Cel83xcd"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-485392de558so21858605e9.1
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773238767; x=1773843567; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrUWNUYcRB4S08yg1WEQ2YVogaM7A4KC4ZmR4pQ+1F4=;
        b=Cel83xcdsGWWyndZy9319/MRneAGIyBPTcscEW862mz3ODg5fBib+D8+x0FGlQEFL+
         DWNSLjLjjYP6/QQT+3VU8rIliPZYVx1wrqTWRfyuu/t255gHOUIDk2Ntr/A0HQgcsbyI
         AV6s9oiZZQo+vmOjNN+JqbnwCkxvOTd29NEZNFOgPcbYGw+wip93lm3GzgRbOb5NFVfa
         arB2tLh6Fy/f6VOtX8uWGpWEEudibvhR4piFVCXjuTmYKXS/jLwXKAT6iA+oxjECX0zj
         ZfluohUXZkTg41zCyI+r8tSydif5IG54Gnlc3UY4xaVZFv+xVB2m/eVJSUBtOgZbKiEF
         8dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238767; x=1773843567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrUWNUYcRB4S08yg1WEQ2YVogaM7A4KC4ZmR4pQ+1F4=;
        b=ru1LUl/VW1KK5zhxBiR6rOd9bT1hJAwl5NxUQW6+TVixJiR5Way6BiatN27IkQghzB
         tsSv971Bs7sfcu9w+MplMekNXGtDUyWYCfaxTYCJzDV5wJ4Mi6VyBClyevn6rW00RG5r
         8sU31rGJZmV90aEp2WGjC/Q82drG9ISE9Od1FE/j+9cZkTlSQILCJyeeMxk5XTIGCJuU
         YYzPWd1gbhqULxrCWFbF3ebtgnTxKiXfKjpQuDxxAqsfuw0xtuu8Dp0ev2qJ9cAx2k8H
         up7a174yZqmzjgQWrfs+Ig0oNpFmeM+Hsdz6WeL0+7TJW5Vf5vuLbYtzq1+neOnIhG1S
         cXwA==
X-Forwarded-Encrypted: i=1; AJvYcCULEUFyq94l37bxZijMcaC6HA6SoWxYT9bmbNP8CThDurZxz11EBsw3aqlVvI1hxv+gFjLvKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYUkSiUk13YEG1U7xT3IrAQigAmP1X1nmeh0fdF82QasxsBrcr
	PLn4QaJZSKw6KNc26lkxL7i7TPGb9uigj0ohtV9BdncJgT/hFC2M6d41VagNhqP6tNQ=
X-Gm-Gg: ATEYQzxTU/IImaha0rwTkpwG+0pc7nwerNYta+kewU86wpWGJdqRpkRdEqfUO4A6tfg
	nAWvUzkcG/NVA+KWDaug6u7X4IUKdU1QY9UkMaJL/Ma+lwzHoYGyjk2kPLAMsA46XIAgHkSO4Ar
	VD2MYzQjEu21Fs0Js2W9TvHTeD7H8YHTxSiGaU+wDQg3NIwH+97nE8qXLne+Y5B9fFQRNO+c3zs
	uxEe4Xbga62DCoJWw98SPZeY5dKFdO1MfcVUrKrbfKFf4Zzy7MzpC1AfQ/YQEKaXk/cIcpxoVwi
	6poQso9CWvSe1c3WQNwl64lLzUOEOs7eiiz4qOUN6QTVK29BX9V+zjh0hJI1DJYJfMw4RWC5obV
	2Vn1UqvGpOGC7GxrT7arTBUojlg39vKSy4ihKY+ZIeJ2uIrvFUt63rdyGDy7V8b/rPQoIw9A3qZ
	hMUYSqK/REuan2s2joVReHTZfKISZqjgj5Et7Gd3vvcQ==
X-Received: by 2002:a05:600c:4745:b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-4854b0ae77bmr43456195e9.2.1773238766811;
        Wed, 11 Mar 2026 07:19:26 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm162608305e9.4.2026.03.11.07.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 07:19:25 -0700 (PDT)
Date: Wed, 11 Mar 2026 15:19:23 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Petr Tesarik <ptesarik@suse.com>, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, linux-media@vger.kernel.org, 
	sumit.semwal@linaro.org, benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, 
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/2] dma-mapping: introduce
 DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
Message-ID: <p52ohr7pqtpzmwdpwzfwmwpor3wkop3quwxmq57jopan4awwav@5hhcgsskzgu2>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <20260305123641.164164-2-jiri@resnulli.us>
 <20260309135610.1f81d2df@mordecai>
 <20260309131736.GK1687929@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309131736.GK1687929@ziepe.ca>

Mon, Mar 09, 2026 at 02:17:36PM +0100, jgg@ziepe.ca wrote:
>On Mon, Mar 09, 2026 at 01:56:10PM +0100, Petr Tesarik wrote:
>> I don't want to start a bikeshedding discussion, so if everyone else
>> likes this name, let's keep it. But maybe the "_CC" (meaning
>> Confidential Comptuing) is not necessary. IIUC it's the same concept as
>> set_page_encrypted(), set_page_decrypted(), which does not refer to
>> CoCo either.
>
>Frankly I hate that AMD got their "encrypted" "decrypted" naming baked
>into the CC related APIs.
>
>I'm not at all convinced that they "do not refer to CoCo" in the way
>Linux uses them and other arches absolutely make them 100% tied to coco.
>
>If we are going to bikeshed the name it should be DMA_ATTR_CC_SHARED

On the other hand, the encrypted/decrypted helpers could be always
renamed if it makes sense. Better to perhaps have DMA_ATTR_DECRYPTED to
have things consistently named now? If someone renames them all in the
future, so be it.
