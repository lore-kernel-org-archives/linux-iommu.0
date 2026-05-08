Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C33C318139
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271880; cv=none; b=XomTCh1SSATFAnsVa9FU8YPhozduoCSVux1DKvfmjyEwnto+6HMzzC75BLe80X4k3bNoSxYibgWwXbeXIMFAw0sPeZOyITAkAzt28qLsqsns6t6gyFUPYZQownWOy7iztXH8ek2G87O+1zAoxg+555FNd4T8OiBrTe+7RRKHuLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271880; c=relaxed/simple;
	bh=kp8rSN7aw4Y1OKNbD2bQGxjOJigkUnTB7MvPDsPxF0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3CJlw+sEOK/pjRHv+ppZRkQ8kfNMaRXA3YJp5qf+0r7nogpmESWJ93fBFMi71iBnv+vKk7CA7t23epBeWpIsyJpABFDG6Y/g6egpctFCpcELU5DrOFkrTJRbtXb2m9pffAvq66Z9W3MfNMghl9aU6xf4KWaNQajs+gB72wVuaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EyWPjcXt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EyWPjcXt"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1135ad.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778271878; x=1778876678; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ce+YnMBE0LJf/ZEN+RPq6mW2l9lqvy12xVD6Nz1p8bo=;
        b=EyWPjcXtCnXY60xLUMCcAWPHy8UM81ZlpbMbdLQFwY4u3HWixvPjx/inmumET0KtAv
         Vu8dptDgzvUJCZPia7tcmSk6o6s4R6p2ZowBwZoOE1YFiZiftvRLFuCuF4G5ouErnAmj
         i32xMG9oQXIJTFlWoMTqYDHqtiFTUxx/hGW6vqNJoX1F3DT8Tg9EqvKQ0C/U+bWTtaa5
         Vi1FuSrFL3I6Rk9aXHHKQ84YChsl8bxYaAJE7BRCH+J9UWNUxyjEIkLFaBZrVEYY4aNq
         P8IlCgEXCdP550E8xPrStAEuKQ5z3w1B+fqg9+LpRCH77pQ6G6kuyIQHwdByaP3n27nu
         nvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778271878; x=1778876678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ce+YnMBE0LJf/ZEN+RPq6mW2l9lqvy12xVD6Nz1p8bo=;
        b=eT4+ser+5OqPfZodTyqSfyDbkAIpg5ZMHdmHlX5YmaquVGdJkFM2noL7NiY4GpmEip
         X8KWJPX0uJGHWIdcN+g3vY/+3oSRFG3PsTcw8czZEFVjPoY6s9vyag7sfXcjrsOmkgTK
         JWuawx7mgv7kW8K4kVtW4mTQtSFu4iNZqtkW3+Tp6e+BM7OVk1nsjXsd/YU6cn/q6e+p
         cCYSvEjS3zOcpX2Zhvm0VeEqBHze6r7N8wKwFXB0JWtTOm3LY36wyyJF390TYHEr7nxr
         bhrOtAcD25INCKvTjKw+Ls7JrUnr4ye9+0+72vxdzmhV4zjeDBuxfJ4AO0SVcTFBk85o
         UCgQ==
X-Forwarded-Encrypted: i=1; AFNElJ83JVDmiaUfZxxV0S09sXl5MnpxtCBY9/l2pqa190i1c0D60MJLS1Bfui/QkYjovuPM78R/xA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYo6smxfSA5FzsL5lCudc85Q+WyW4J7Yk2AbbErZIUzDxcYS0X
	zqCwY4FkrzzMMG1TZthXYfDAQYjWqdIW+n+G1AHAi3jfC+wDpZ7/pkToW3l6Gdbxhg==
X-Gm-Gg: Acq92OGoXjfcXr2OCipvmKkAhsy/lxyyZW4eOFkyhXrDUjfXb7caJBsM0VSSffMDQoB
	+hgKcqqblr1JQvy04pdGQFVG6ey/YyerjkWHw7NsfgAD6ye4A/fjBLweBqjiRGlCJ6bUQ90O1Gq
	t9SzIITphLDEq6+excPqT5XDS2xeEmoEcKDI2wwFcytj1jbl9OW4ezrJh04OQHGqWwO5+lovneg
	yfm92fOcTchfMEMVfw7zVeoQ1rf1Vm+ofxrhEBF2dYAUT/TZ5jXDri7vHMswQQKP43lcBuodY8D
	Enlk350Hle4VupN+qS1q8p59vd5cuKgurCZoKhE4FKWT5Zz7SN79Ln+9oW6kcSzXTH51qe1bwPD
	deVFIX5wMc90sGLfvmCMcodjlCtRH5+xXMG+ZMKV081ZGZEdB0pBtY32b+3ZCNNHy7oC9DuyjIG
	GUa7b8bfn6S58vdkSG82gzcxgSLYSrIZUSbOy45ADE3gyX8wOOy7FmK+r5W99zDcrr+hp4
X-Received: by 2002:a17:903:1666:b0:2b0:5c88:51e1 with SMTP id d9443c01a7336-2bc747c1c17mr760485ad.14.1778271877978;
        Fri, 08 May 2026 13:24:37 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826767be0csm2827343a12.2.2026.05.08.13.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 13:24:37 -0700 (PDT)
Date: Fri, 8 May 2026 20:24:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 1/8] iommu: Split the kdoc comment for struct
 iommu_iotlb_gather
Message-ID: <af5Gf10IujBbDXij@google.com>
References: <0-v2-b5156f657dc1+25f-iommu_riscv_inv_jgg@nvidia.com>
 <1-v2-b5156f657dc1+25f-iommu_riscv_inv_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v2-b5156f657dc1+25f-iommu_riscv_inv_jgg@nvidia.com>

On Fri, May 08, 2026 at 11:53:00AM -0300, Jason Gunthorpe wrote:
> Use in-line member documentation and add some small clarifications to
> the members. This is preparation to add more members.
> 
> - Note that pgsize is only used by arm-smmuv3
> 
> - Note that freelist is only used by iommupt
> 
> - Reword queued to emphasize the flush-all behavior
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  include/linux/iommu.h | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
