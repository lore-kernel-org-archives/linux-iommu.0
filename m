Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3E5627
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 00:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EiJAHhPm"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6705379b835so26421726d6.1
        for <iommu@lists.linux.dev>; Tue, 31 Oct 2023 17:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698799668; x=1699404468; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KtTZeU1qyZPr5NnJG5tqBE/Hw8vzn/1VxFwr17IS4sA=;
        b=EiJAHhPm43OKsa4Euh+q+pnuZ6t0CpgngdrPY/sHuoAczU4lGDqHxpWUvMht28zyjV
         tF3rieSBZV+Qz8kz9N5KCRhjNe33Kos0ppZSsk7ewHxyZ4WK0vT2V1EhhqFECHrIcvtH
         BZ0yPdUpLHODhfJZ1YnV55ah7QWXO3XaHybmLCP/wJ5/R0FPpj4l2a+YPQxQqgHVHyg9
         8ivJol01Fqv/NhZU9XPmzpc1Y7yLfp9CdyZd5mARy9pgCaR45zyd+aMlt1K6mhkV3h9A
         9MoQD5rpTwaTsIAdCz5GVDMbGCh0h16TY2SyKxj1shnrt45Vf+2Fv1bEcpNLbbGG67v0
         pZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698799668; x=1699404468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtTZeU1qyZPr5NnJG5tqBE/Hw8vzn/1VxFwr17IS4sA=;
        b=WDbjvkLAkH2cQj7Gv8vsR946tX9zfu2GVeQzY1ro7I5Vv73XUXO79Vb3Zwo5yy6uUS
         hIvFGP1PvPmh9YJxaWSCd/oDtUP7CivLLjIN7S86GtYSKbYHrXUEgFjeWuNV1J+vWlHT
         9jge+c6lnmFDD43MQ5ZtUEvTaoeOJTvx2j2WQ6B9wHjK7/NeYqzbayUSfpa6+VPoIHr7
         3W84+qF+gNomuuTLXJA+BlEQl2t3DoGg0pSNr8QkKObvFuGEuSA4Xvxu9FcT1qPJdJgy
         pfw/PhYI+jRgvpvAyJwaM026Cw2TiCUySD/cBAJE2fG5Hr2L5l18A7ct9JjYnMRzlVEY
         zczA==
X-Gm-Message-State: AOJu0YygK97GrideTt28unP53IVhBqztG0SYs7eX9PqzRzNvxfu/avTB
	71GKZhD9oXYs1laOeoH+xyixBw==
X-Google-Smtp-Source: AGHT+IGBoZF6m4BoEcXMbgmscTRORzSW7sDdPYnhLQJDO7yeyyH3b7tmen41fCbsn0gHL99uZVHZtw==
X-Received: by 2002:ad4:574b:0:b0:66d:775:d1af with SMTP id q11-20020ad4574b000000b0066d0775d1afmr17062290qvx.59.1698799668692;
        Tue, 31 Oct 2023 17:47:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id i5-20020ad44ba5000000b0065b22afe53csm997511qvw.94.2023.10.31.17.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 17:47:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qxzOd-0080uo-GZ;
	Tue, 31 Oct 2023 21:47:47 -0300
Date: Tue, 31 Oct 2023 21:47:47 -0300
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
Message-ID: <20231101004747.GK691768@ziepe.ca>
References: <b85e0715-3224-4f45-ad6b-ebb9f08c015d@moroto.mountain>
 <20231030115650.GC691768@ziepe.ca>
 <d42a8cb4-dd0d-407e-8659-915ca821e1f6@kadam.mountain>
 <20231030123823.GD691768@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030123823.GD691768@ziepe.ca>

On Mon, Oct 30, 2023 at 09:38:23AM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 30, 2023 at 03:00:56PM +0300, Dan Carpenter wrote:
> > On Mon, Oct 30, 2023 at 08:56:50AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Oct 30, 2023 at 12:03:12PM +0300, Dan Carpenter wrote:
> > > > The apple_dart_domain_alloc_paging() function is supposed to return NULL
> > > > on error.  Returning an error pointer will lead to an Oops in
> > > > __iommu_domain_alloc().
> > > > 
> > > > Fixes: 482feb5c6492 ("iommu/dart: Call apple_dart_finalize_domain() as part of alloc_paging()")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > ---
> > > >  drivers/iommu/apple-dart.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > 
> > > Really need to fix this so the function does return ERR_PTR..
> > 
> > It's called as a function pointer.  Changing that will create a
> > backporting hazard unless we rename the pointer or something.
> 
> You can make that argument about almost any change in the kernel..
> 
> IMHO we needed an annotation like __user/__iomem/etc to indicate
> ERR_PTR so at least there is some hope of trivially finding it.

I was thinking about this some more, I think I prefer we fix the core
code to accept the ERR_PTR and just start moving gently in that
direction. I was working on some other stuff and it is starting to get
really confusing that only this op is different.

I'll send a patch

Jason
