Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C518061D
	for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392604; cv=none; b=BhekvPQHsN5hEsh3Qzxiu/LK/bvzrI1yfN0PlCkIc1lost7haQ9MehAnmuye/aomz4WoU/d1Kesdx4a6TpkGLi9Em4loK0VMRmllo/5mTL8MwyFkIV99Np1Uu0wQeZyb4MnP61dH5YUTd5yMQl/xNkPoRPPCR+Yrfb1SbeLGT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392604; c=relaxed/simple;
	bh=k3LPaxpQ0t6t3el8UgR64nKFhllhxo4z3vuO4mc314Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/tPps+2JXnA9DDNTa1GlAyUZ2s28y0JXNEM/g5f8XWBMKLFvX9SNTdDFtAE451UszMYrwJx3kNjwoAnJkkSJzlOaCxuc2XUf/ukhjH5CM8Nl4ba/lHEhnyc7ZD/jEFYRGrZ4Wb9pP9NnF2iip+SS5zW+bKZdzy5mzNKl9ik408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MMdkBktP; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MMdkBktP"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5aa362cc2ccso3150042eaf.3
        for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714392601; x=1714997401; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXRgEPH1uU79zQD6+IHe0m9b6rETQiei9x6o058HUWY=;
        b=MMdkBktPBd1lj7AiJfjsUg7A8n9wYXWBCWMyyc720cpLun8MAYRGvsdkRGwPFKm4m4
         JALrjDlIlokUr6fW8ihwiumSe6wWMTYzNjwi6M9wsSluHEK6iIaxx/Fxaw6iXYm5YSuL
         pkVCd1AtDoFlzJJTjrJNfKJILMB/1Phan6x6AiHj8136uCSdJOH1zXc32jAqmjoYEP2h
         ujLWGhpBknBAY0fRxtR7nVD4XQQegHS/uQUoIebQO2gVvjYA6ar2HTv8XJOC2Rl0oxtZ
         E2p5YgO0XKVNhE0qafhb/k9ak/e8mr/t/8bYehGR1uKpzmzF5FISx3GL3099sJXJ+XiQ
         6NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714392601; x=1714997401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXRgEPH1uU79zQD6+IHe0m9b6rETQiei9x6o058HUWY=;
        b=VjRh7fJfLw3IMYZadsxZ+p50q6EfaOjmstDv7N/9Xbl1iUp3pb/RBY+WpbV2JoL6V1
         z7dHcRo2gsk1Q2TJRG8GQFqbeXKOFokmhCeHDam9v2ZKPU/BrDxBbVA7zXWj/6FVC+DL
         Wmna/lMnqkXGBvL8ZZALyoyJyS1NrOaO4EzNMIjGA+lZM9TVUGTBnD+kdSoIL51wbIif
         8lCtmH9db05cFXNOpJg51xK26C+r1NRyka5UNNi/ViSAK8ERn2pkLLroYHsEOVYWAAby
         4Y15EiiiiBH8D/u4QTTrRBGmGH9baIa3hNw2v6WQ8Z4PYfa1plvFV8vavMmMhtXfXVXL
         OWAA==
X-Forwarded-Encrypted: i=1; AJvYcCXQCXMpt6fivz72MV+/SHOAFnZJSNHqq70xgMPj1bXyo4Wi1EkGvx1jxhrPi+j9vws15v+Gql1q7SkQQ3l5Z0Xg/ZuR2oc=
X-Gm-Message-State: AOJu0Yy6IcVZ4aVsA2hSyR0O/AsFvxIemedMn7kbhXdAdhu9RwBVeJ3V
	uLobCGQF++1aLHZsYe/or3O/qiFZ2jECu44dSJeFL7EEohbMW/MOdrDFXempH98=
X-Google-Smtp-Source: AGHT+IEY0PvXjgaQ9NXclObpxAxFwPAYyqZoUOatV7BjbYwCTbVrRKEXAnTs41fAvifo/8xzoAQp6w==
X-Received: by 2002:a05:6358:797:b0:186:9d05:5f0 with SMTP id n23-20020a056358079700b001869d0505f0mr12388658rwj.22.1714392600738;
        Mon, 29 Apr 2024 05:10:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id h2-20020ac85682000000b004365ab2894asm10399689qta.51.2024.04.29.05.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 05:10:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s1PpX-000oW0-FJ;
	Mon, 29 Apr 2024 09:09:59 -0300
Date: Mon, 29 Apr 2024 09:09:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] iommu/amd: Fix compilation error
Message-ID: <20240429120959.GM231144@ziepe.ca>
References: <20240429111707.2795194-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429111707.2795194-1-andriy.shevchenko@linux.intel.com>

On Mon, Apr 29, 2024 at 02:17:07PM +0300, Andy Shevchenko wrote:
> With WERROR=y, which is default, clang is not happy:
> 
> .../amd/pasid.c:168:3: error: call to undeclared function 'mmu_notifier_unregister'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> .../amd/pasid.c:191:8: error: call to undeclared function 'mmu_notifier_register'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> 2 errors generated.
> 
> Select missed dependency.
> 
> Fixes: a5a91e54846d ("iommu/amd: Add SVA domain support")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iommu/amd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
