Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E726EEDB
	for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XSHOzEjD"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-77896da2118so306825685a.1
        for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 04:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698667013; x=1699271813; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gQKrKJYeQqI408ZiaZJRkmFH/H0/KalWqC8BKV3SRh4=;
        b=XSHOzEjDdRXT7qlVdWyBtFdwG0fLKCdo5FKV4T/cjix9R7CxUhYABmdL6j0jlRYy6Z
         +8OPU3AnAG58uESlOtckurlXvoJrNM5sxKu5LRRB+SJZBJ0lZLzX3cZebM5bA40XB1wq
         2JSkbzmtiQSBiryHmNVnJWhdJ4/r4d//QpeiZg9o2M1b1SajMUnHG8GmsDwtSPcIwbW6
         85C9s+x77k4eUV0D0BMZC8DktrEp7plAmq88MM9GF/WL5W7y2gWJmhBLSvIOj6TuSlj6
         Z3n2PegSGT05vcq9S+5GqHc5gKKritZ7xw1GEvv2cT0oCGZ7UHZSPQtan8bPASU+mnEw
         pnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698667013; x=1699271813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQKrKJYeQqI408ZiaZJRkmFH/H0/KalWqC8BKV3SRh4=;
        b=eToeRE3wt0CC93r5pzXbb/Cl1wwJ8xF8VLLewl0fIVXYj2/nDXbDYbS+7wnem86pZE
         pB+zLPbEP27LacWQbyTPuiHSqMSbACBaxPwkPc273M4dmWTYeAWKr8BY2LsimXSp55BH
         cCcm9Q4Vk8wcWOoGQM6oP87Grrymvzrhnj9TwRrP35owtRgMrykc55ts8vQEk0cevq8M
         vfItZK2eLOVY/qIHGEvC29N8Pi/52EMJireK7vwbJ6yjgT5rjJsNi4GOIlhDgQgz06WA
         8s2Csd79Vx3QUPbSPNtqy3zwY3QhbXFFykBOJ1bGvRCGUR4DMY0PHbAN57yYCbTc5SU0
         hdGg==
X-Gm-Message-State: AOJu0Yw1c9I//tRY/ebL4IPv9WKzGwWTpXtlWVwK2SsIMF5a8TWk7E/C
	nBc6bi4ZDhh3dHCFXJl4iwKaEw==
X-Google-Smtp-Source: AGHT+IGlo1N1nWgqEHCTfKHD4x4QvCUlpDbIj3E4lfEj8khCJx1F+5pIBfZ7gBWPby1i734LKGkdUg==
X-Received: by 2002:a05:620a:4395:b0:778:909b:58c8 with SMTP id a21-20020a05620a439500b00778909b58c8mr8857446qkp.78.1698667012846;
        Mon, 30 Oct 2023 04:56:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id r29-20020a05620a03dd00b00767da9b6ae9sm3242228qkm.11.2023.10.30.04.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 04:56:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qxQt0-006eIL-QP;
	Mon, 30 Oct 2023 08:56:50 -0300
Date: Mon, 30 Oct 2023 08:56:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Janne Grunau <j@jannau.net>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/dart: Fix return code in
 apple_dart_domain_alloc_paging()
Message-ID: <20231030115650.GC691768@ziepe.ca>
References: <b85e0715-3224-4f45-ad6b-ebb9f08c015d@moroto.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b85e0715-3224-4f45-ad6b-ebb9f08c015d@moroto.mountain>

On Mon, Oct 30, 2023 at 12:03:12PM +0300, Dan Carpenter wrote:
> The apple_dart_domain_alloc_paging() function is supposed to return NULL
> on error.  Returning an error pointer will lead to an Oops in
> __iommu_domain_alloc().
> 
> Fixes: 482feb5c6492 ("iommu/dart: Call apple_dart_finalize_domain() as part of alloc_paging()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/iommu/apple-dart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Really need to fix this so the function does return ERR_PTR..

Thanks,
Jason
