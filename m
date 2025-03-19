Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E62517A5A4
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385456; cv=none; b=oi4851cBPyP/7En0E0cMhdIJMT1TJWaGAWI+llGzoGlSPRNbEOvI1WWqntwNI4owcTiSSEPD3s1nEgGgxrwdQAtzBuQjpOjnXjeYl03qEN6FuKUQKATea1NDt4i+7bp+dWJGgwAKWJW7D2FCHBek5B6a8StRoaLjupBGK3yf00k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385456; c=relaxed/simple;
	bh=Zaya2Gi36xQuQT1FSI+yL5SuTA0Bx45astfys7QIp64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLvQSlVSbaevMcJYgowNnhOp2m15t5aWy/hmvGH0++DxdUWkF1h3JMbwYf/yCFi++oNgP6PsN8ACXXulwI5IoXM+oJw+Lzm1O50QTftHMzWId4yxFiTOPHquYzRk+VdwslzgHXEbWkjbGx+GZ0JI9kjna/O7BLsSBHt7c/3Cg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YPdAubQz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YPdAubQz"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c54a9d3fcaso640257885a.2
        for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742385453; x=1742990253; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zaya2Gi36xQuQT1FSI+yL5SuTA0Bx45astfys7QIp64=;
        b=YPdAubQzWJLExWPbyIrBHgHxG4KW+HcZzl/9Gc1IWF5MeUQjxN3PvEorpmI9fc0a/k
         FyCVXIQP96iHiMmjJP7FEbQACGObd8seXLmM7v/9UtYSJUE4XkqvnicRq+OPtSCMJJ/+
         qWo3PuCh+ggcfV/teECJ4mCQRJn7xkrromW4FpHDl2FVuYrZ9YWQnt+bhqEdB12c5TFe
         SodAtuxtRMbU/xSJh4mXSUrwsGGkRJMlTSxbznC5dfekwOsYkaC6CPqCT4KkRV8ea68b
         dRAJ7B/01DUfk5wjth9i/LAZcuIjPZdWeI/v0fAmp00fB6VuU5hHYVaqsxfajYeeD/11
         9hRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742385453; x=1742990253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zaya2Gi36xQuQT1FSI+yL5SuTA0Bx45astfys7QIp64=;
        b=CUQqlARmgY5V7GiwnYhNTs+t9DbibjdXJID5I5d3/zidVGdlNa0rfALUgyYzyarMKU
         Tusp4iJsJ1WZE2On1HIyuTaiquQycGcRuWY/ktFkHRkcLaxyCMNVQSwvGwMW+nwhQlV6
         yEyHMoIZfGIBzCEEQqUhQyVLJTCNSrkqBxYJ3Sg+Mv2zv99z27ov8PvdTF8/pDomE3fz
         1QaQs+6CHS6PQIhoq0J53H933Yz6bmnDxnhogzzxfIkDqpjUMioTbJY/4QhaMz1i54LL
         nPtu02pvF7laOGSYXoYH8VuTdUHsNapGVqBS7xr5lKeDrVrkMJAj5n/g5YQfhzlnCX5a
         ga5A==
X-Forwarded-Encrypted: i=1; AJvYcCXATcQNmDoK0OWuOnNYiNZFWrWnWrBfWo5miZUXvEDu5gGj29Au0p8k+44CDbtHrIxJ8BKgTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPPyBnvTVUvfpv4UmuelQFsjWeTeFbUHTe2AC4ESe9KREjwjnY
	baffinTOAk9MPYSRucMmNJZXG/g+moCiLyxiVWFqHl5HONnvPfHG34LRHoKAZL4=
X-Gm-Gg: ASbGncuKmciPrfddcpp43logiwa7HLuB6Dqu0W6RU0hSPZnJD5+5sqxzoQFy//cVWVp
	Hv2W57j/NROSi4Bi3/e9gc4nBPWGGYyP6LcGgdYWYS/ZzNcaK75xRaP4yaEE4kS9nS61gEtnhk2
	3S2u7PikXIfthYvq71PKFyrSj7v0jwtTCIOr3m9vVu97oEiaBqV9om8GJ5Z4652RQgapETFIsDB
	09v6+eKlRfF0G8vqHqt9mKxAyEJdtJ12wNw7HKjAUTe/t8ItHvTe2zcGEJmSMYcBLHsNtgQ88v5
	2Z+lSZKSwmSrlUPNZxD13vDU4XO3A78wyEIWQIcQIyBGvibBA3siRL/09PTlqTH7uR3L8kLk+NK
	+FpIiKXg27CXcigIr7w==
X-Google-Smtp-Source: AGHT+IG7vTXbxGGkqc+jLKewiu1ZOqiKaHghBJp90kznZUicLUviR9A4z7NykaVd06Xnv6wzd8KBgg==
X-Received: by 2002:a05:620a:2a06:b0:7c5:53ab:a745 with SMTP id af79cd13be357-7c5a845ece5mr347436485a.36.1742385452943;
        Wed, 19 Mar 2025 04:57:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c714c0sm854128985a.40.2025.03.19.04.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:57:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tus38-00000000TaQ-2zCJ;
	Wed, 19 Mar 2025 08:57:30 -0300
Date: Wed, 19 Mar 2025 08:57:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <20250319115730.GC10600@ziepe.ca>
References: <20250319004254.2547950-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319004254.2547950-1-praan@google.com>

On Wed, Mar 19, 2025 at 12:42:49AM +0000, Pranjal Shrivastava wrote:

> 3. Invoking runtime_pm_get/put
> Given that most of the configuration done by arm-smmu-v3 is stored in
> memory, the initial idea is to focus on areas where the driver accesses
> the hw via exposed ops, like iommmu_ops, iommu_flush_ops, sva_ops etc.

This seems weird, if the SMMU is suspended doesn't it also fail DMA
transactions? Why would ops like flush even be called if the HW is
disabled?

flush is performance path stuff, so it doesn't seem great to be adding
extra calls there.

> Instead of wrapping every exposed op with an rpm_get/put, the idea is to
> follow through till a logical common point (lowest common ancestor in
> the call hierarchies) and wrap those with the rpm_get/put calls.

Should the iommu core be doing this instead of hidden in drivers? It
seems like there might be better information there about when we
expect the IOMMU to be powered up and working and when it is OK to
have it shutdown?

And maybe in this direction we can do things like remove the
translation before doing a suspend so that flush ops are not a
problem.

Jason
