Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13615487
	for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yao2KNFC"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40850b244beso34129625e9.2
        for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698667259; x=1699272059; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EoSNs9EZy8FjXofhAFGXrcuEgy2S3k0/mRHsu+JGg+o=;
        b=Yao2KNFCRYBYBPtLy0P7eTfF72fg0Kuf/QywBB7VUOj+eatd3JPSJE8AjaAAWvGhwv
         TsQVjqFu1vS9delsVCrsnhEZZNXuLCgstWY3xTX1QNvqizKROE4sTSG7QAUHI0wmjmN6
         bBC2T0/GFc7XzzRScZk7AgZTHr6nFuhKh9xkRryUwVuj5w0TJH6Jf7c0g/3x8Wqqw1n6
         cdHweYA0b/jEkjyndTn2ZnOnuGH+atPaBLZERs6LL5+zXVUqo8aGcfrhWo7B4tA+y0c6
         do+rziZDUlxnd7x+tZuscQtNjzcYflZl1xuF0fwtr660U6Ri7LjJvtkKynCfMSlLOsZ5
         /OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698667259; x=1699272059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoSNs9EZy8FjXofhAFGXrcuEgy2S3k0/mRHsu+JGg+o=;
        b=IRJvYWqO5kok1MYbZN+nHX5lBoANGiLH/yYRYG7xcVLYETZ1ZoW5P3TehDYwEOmPcO
         JpL0pXdVyOatXjIEj4jv9fAyN5Az+4sKEU2DOl6CbEL1JDAcMEY5IF+x513P4HCCmEy2
         Nq0HllbxI6oDbNwLtffngKZnzRES3RENm/Z83CGFF2xj0SkZ8No/01ZmRrMpaYjUfZX7
         H6z6TVxLA9dnWMPr1JR+cAQHDLl35ALPzVvflT1UBVSwh8KQWt5R9uuc98Mfn4xV+pia
         XutmZ+YoYAGRp1B0revLWGJcYv81MO1yo2tWpu7Mt7wjOYVjfh5dJe9OjzTh0CKVbhjh
         1gCw==
X-Gm-Message-State: AOJu0Yx7DFkRQZ8e2eIQpTluT0JG3hN7RSwt1Jm75VeNzJNebcrygMPB
	k4UuVKL5ktS//rTczGBOcbnsYQ==
X-Google-Smtp-Source: AGHT+IEHoMWYLrdiInS+Ryyqg0WeP4bGW1pIEoKS/odTJNy57DBtLeVnqhfxJHH9SxRsxYXg5KZzgg==
X-Received: by 2002:a05:600c:3146:b0:406:53ab:a9af with SMTP id h6-20020a05600c314600b0040653aba9afmr8298697wmo.10.1698667258881;
        Mon, 30 Oct 2023 05:00:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id hj19-20020a05600c529300b0040841e79715sm8903405wmb.27.2023.10.30.05.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:00:58 -0700 (PDT)
Date: Mon, 30 Oct 2023 15:00:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Janne Grunau <j@jannau.net>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/dart: Fix return code in
 apple_dart_domain_alloc_paging()
Message-ID: <d42a8cb4-dd0d-407e-8659-915ca821e1f6@kadam.mountain>
References: <b85e0715-3224-4f45-ad6b-ebb9f08c015d@moroto.mountain>
 <20231030115650.GC691768@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030115650.GC691768@ziepe.ca>

On Mon, Oct 30, 2023 at 08:56:50AM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 30, 2023 at 12:03:12PM +0300, Dan Carpenter wrote:
> > The apple_dart_domain_alloc_paging() function is supposed to return NULL
> > on error.  Returning an error pointer will lead to an Oops in
> > __iommu_domain_alloc().
> > 
> > Fixes: 482feb5c6492 ("iommu/dart: Call apple_dart_finalize_domain() as part of alloc_paging()")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/iommu/apple-dart.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Really need to fix this so the function does return ERR_PTR..

It's called as a function pointer.  Changing that will create a
backporting hazard unless we rename the pointer or something.

regards,
dan carpenter

