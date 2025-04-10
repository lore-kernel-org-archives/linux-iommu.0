Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31BD20C49F
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 23:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744328143; cv=none; b=J4jYa3glUjVYFe8D+yjnKvKtAZN06vVJVqv0d3g8YdAD3ONT2Xn8VHKWuCxiEP3jaR/DwDhJQPHreLCxexL4l7gEr771ML41q20y3ZbbQ1lJRya3C/aKjWQlALR0KUR9y132pE7xs+KKK75JXo5qucQfKVOBY8+2mj62mkc/ecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744328143; c=relaxed/simple;
	bh=tRlS4O0/+C1kQ95RbK996sKQ54ej29u03LUx18bld3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puEokZUq0I3NZUTppu6YwYYskJcnM7FHxqlxD3gHOCBm9IwBL6wYogHwZOYBGW2xRY3EdlCtZSafTDT+1dmHXWhYODHvDscDd49oCWZ1fuHEA3e3KAbTdYyOg8peOpTpN6zKF6KFzHb8NlLEf67QFln3UdAqe+wqUVsnQJzJ1Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B3L396V3; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B3L396V3"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f0ad74483fso13930656d6.1
        for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 16:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744328140; x=1744932940; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SsiOb5m/HApO2cPZvJeq1vFF4NxW3wALOz15Q1Msims=;
        b=B3L396V3sA6BnvszcBndYYm97kpvE18+TpamB3tsEv0xfDd4c9GbDRzXqAGUHlPQPA
         tAP4aZ2741W4N3uVwj57HXBmGQY6o0MmXnplxGVo5B3TlQ95vbRck/2sRFLuepq0qkcI
         Yjr6/P2EEMH8vyebHPUjnj2HWXNENcd4gJ+KN6N5YWTC40XbzwU23tTjQ1UAALTNastL
         oxEzcN5GtbiUMnLIXx8K/x/MWyQT13kt8HbLWdHFhec/ThUJ7dSIPlglzAaESC/z6DI+
         H9G3N8sYtTy6C6ZQ7/0axE5DNF7ald3/D39TGdY7F1ECzEXrNyk2YK3ZnELjraScFNxH
         n91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744328140; x=1744932940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsiOb5m/HApO2cPZvJeq1vFF4NxW3wALOz15Q1Msims=;
        b=LnMZMHjCxCZjXIRWzWnNB0GtX+FfRNb9fbpebTR5aoDwXT2Y5Hdpp7NOTBUJL0Je8b
         r1ThVCwjCToqsrXocO10+/D1CRfKuSkoAJja27T6p3fUbsNxmzTN/ETwhlmZ//lGOl3r
         zzAvo1rxz1QOHaiVOrNfe+yVLK4YTnZge5H55Bxpa9/UraXcIYxTcQjTFzPYS+TXbJdN
         JM5WDP6CogQlbYC0Rhgb74gg9KNLNU4WCeg9HOcauBCq42Ok/Ml6S/XW+p58cUGelPQl
         f6SelPdRf9T2F7Y3TSsh0XOzb482XghaLy9nS54SD8lKW8OJbWvGpaHRPSD7ZQCfE1Ux
         zF3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/g9ijKoQPn+tLeJ3KJ4eAdSIV/ZBPoD0WbxbmvyvclaZTyYdstTih42qdUJa9XTZOKYs1MA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuO4F41jv/Svud9Lx3vLE9kXLy2MpFCBb+VA4qNfouIaw/o4Eq
	5hs2IucBs5Ng5CUsnMOJjRioCAncRBKxekPKngjLLUvLkCK/S5uTxyjbmFoqno8=
X-Gm-Gg: ASbGnctZzv9XKeE/1GbM6Y2j4hDIeOiDg4c479ygjGMxgwQ8iUx0Oh5WPnen492FaaP
	Nphpib5PrxaZZp/fcAsto8iorbF1I2IoJ4KEgUR3YVeqo12UyQZh2A/3UlKr1jL8Vefs/YJ4zxl
	hHQcNYk7fjcpM7gzbHFOocc3XSWBpVldT5Sihl3CcLwkok8GbUdFjui+kv2UCWJJJ+dTuoNbT8n
	AQfF1kPykJ4ZheNl6xT6YS3xgAZsTqxs9Sr2MZHPLBNdd5N3WvpUgMF8QFqky0RPz7yLIiB/taS
	ks6pCGb2dMGSgujG3MVcbc58YeIPVqeTsRoPsh+1+g3HS0J/l/IbRU65VDDz+Yt3hysF6yuzffp
	GEjDWqeX8gGxyjuVC5Ns=
X-Google-Smtp-Source: AGHT+IEHpFgvns6ijdbYQArbmPY7gz+0mqpbsktaDBlicxrjzTEe365GQodeIavE8HY3pzSOmrC8Ng==
X-Received: by 2002:a05:6214:493:b0:6e6:5bd5:f3a8 with SMTP id 6a1803df08f44-6f23f1398cbmr9275076d6.29.1744328140577;
        Thu, 10 Apr 2025 16:35:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea1068csm28194666d6.102.2025.04.10.16.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 16:35:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u31Qp-00000000N0t-2ZVB;
	Thu, 10 Apr 2025 20:35:39 -0300
Date: Thu, 10 Apr 2025 20:35:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: xiaopeitux@foxmail.com
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH] iommu: remove unneeded semicolon
Message-ID: <20250410233539.GA63245@ziepe.ca>
References: <tencent_73EEE47E6ECCF538229C9B9E6A0272DA2B05@qq.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_73EEE47E6ECCF538229C9B9E6A0272DA2B05@qq.com>

On Mon, Apr 07, 2025 at 09:53:28AM +0800, xiaopeitux@foxmail.com wrote:
> From: Pei Xiao <xiaopei01@kylinos.cn>
> 
> cocci warnings:
> 	drivers/iommu/dma-iommu.c:1788:2-3: Unneeded semicolon
> 
> so remove unneeded semicolon to fix cocci warnings.
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/iommu/dma-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
