Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA91F8ACC
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737102871; cv=none; b=e3sS7hVko71wMHUfGr7jsqDBFXMVWFLOvjRG0TF5mctlXiJKeTjIJE2lioCgCfH1MetPlZvcLPZl7uW0ksXfuYmSXaTskuA6XWNmLYY/xSM+I6wH2Z5qwWFdsaJlKM1PXYkCI/jihv4g0DJ0nyemR/f8wRwzLgWtYm3mHIcrY7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737102871; c=relaxed/simple;
	bh=sOGKnN21SydKR7OjQwmd45VUVjnqidbSZRg3IVAn+sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEnBx8xJHo8gNZ+DDKVfCCb10tiFoxa4H5CDl4F458l4VvueqqMUt5WM75UMtvZmhRZv+i/KIOD86D2Y53nP6tOhKqRpghCsPxGuzu5kGFjIGFYeGGQ5sZOZXsmXkjmAOpXAO7BJPQyFx46ft2KOyxpk70azD+0jxKdIUfNLm4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zdq4WCJH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zdq4WCJH"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21625b4f978so80055ad.0
        for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 00:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737102869; x=1737707669; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84rMYzUqq4y85KkEDWY3HmzD2Qa5Sp+w6owgX1xBktY=;
        b=zdq4WCJHoDfGmEjcyk7TW8vKY1+27l3EhZO7rD3i+FUiJ54RGLiHlnuPznkb3wYeHf
         n9Mgx8TDlWNCcQ7G24xhgHMyG78GG9Xh01fYfqPwcemMASrLMhg0uKU2kQ7kPhJ1Y6AO
         XjJE7fXhCN8mCdVfhxMw/8nt/CWgV0SYPHQ7bY4/y5i4lFBrCl0/NjNtOnHYse2IkqSA
         YLz1Owb7KpPu1u+X8HQAGFFDcqxZn7y4qdEpncsMP0HWE3omRL1Oic7X3LRyMf7KHMFl
         wliT2UulPnRt3ZBPYBtvinRg9iWxmkvcca0CzjxqkzP7RrR8jfu4YC8dSHcVTLiK4S+F
         r2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737102869; x=1737707669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84rMYzUqq4y85KkEDWY3HmzD2Qa5Sp+w6owgX1xBktY=;
        b=ZoDAk4bz9xD1wbwpjDlx9Ns08kST2ub9C5dnG624lUpBjesD7w9gNejwtaxpnRZdCS
         3fLePPglBwa4/F/8cIJfaxKwvBSLyOKywWsgc6+raigN3+t+im+J/5NjcMHSvcTh/9lj
         8U3cKVxx1KGtGUFvu2nJvzFW8flBAyNmPaTorLFjQeb3XIANYG9l/quUgbl1wDXF/Ap3
         7Dpb/4HMdA4qkwvpKTpiJ2NSSfgPyQPpuA21UnXYw8c5iBE+0jHYp2QsYtVP1gzRDPqZ
         DhdvA2FB8XjVRu8w/JKQDoDMnGOXiTLEtPlNgqCBYvM9w4gzun3IjGJ5mWfT9XfY29Rb
         RSBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPsLaTMINANAJSwN5ILdneC0k78dvo4tuXCNuJPOQmS8kdEvEqClp9Zw2wo2DNXGfjBmvT+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaKCsuuc4nOBokeZSoIr4sajNiN93Ozraf89vWJgwR+I6nfWnp
	CPi0wFqp7MW9dJNeoHTJFKbvI4rFDJKOigSbYA8fyANeGrG7gNxEf9NnD0s6mQ==
X-Gm-Gg: ASbGncvihxUh6kU5in7hEPth25R40W7uHabkOF+i1svH/9Z5GjvijlwG/3EU5Hvhqgl
	8azruLKuxH5Rh71OMaUkEVcjCHfXpc9KqU3aaXf3J/xUehs6YGsHjxxEXlOw03d+Zv5FfDk8QgL
	G8gcKLtzB6dNVp1pKuoq5O4XJyMnK85Lsm0Dcbg9a5jDPzN6XsVKoW9KZA2mg8a0vwcfMvo/Vp3
	XE5PWmxah7T3Hall/FvAA+x7jkxZh/S+7KRAB7G8wBcPHY6LmdATA65XkFcQLUQIRCmqz4HSGoN
	m7JDhl/WOjFE
X-Google-Smtp-Source: AGHT+IE7mqIl7gVi27tsigpFfH+LHplATJtz4D0uDOw0zsnmgSdBynTa28sifGUpSwSM2ArpqhIfWA==
X-Received: by 2002:a17:903:3285:b0:215:884a:e8d1 with SMTP id d9443c01a7336-21c33430be1mr1851675ad.24.1737102869074;
        Fri, 17 Jan 2025 00:34:29 -0800 (PST)
Received: from google.com (1.243.198.35.bc.googleusercontent.com. [35.198.243.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7761a713fsm1422341a91.25.2025.01.17.00.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 00:34:28 -0800 (PST)
Date: Fri, 17 Jan 2025 08:34:20 +0000
From: Pranjal Shrivastava <praan@google.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, mshavit@google.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Include string_choices.h header for
 str_read_write
Message-ID: <Z4oWDGaXpY-PPkqr@google.com>
References: <20250116121025.118464-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116121025.118464-1-angelogioacchino.delregno@collabora.com>

On Thu, Jan 16, 2025 at 01:10:25PM +0100, AngeloGioacchino Del Regno wrote:
> The str_read_write() helper function is defined in the missing
> string_choices.h header: include it to resolve build failures.
> 
> Fixes: f2c77f6e41e6 ("iommu/arm-smmu-v3: Use str_read_write helper w/ logs")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 0e4cbb2c64d7..a0e395da8a88 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -26,6 +26,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-ats.h>
>  #include <linux/platform_device.h>
> +#include <linux/string_choices.h>
>  #include <kunit/visibility.h>
>  #include <uapi/linux/iommufd.h>
>  
Hi Angelo,

This change has been applied to the arm/smmu/updates branch and should
be available in the -next when the maintainers rebuild the branch.

Thanks,
Praan
