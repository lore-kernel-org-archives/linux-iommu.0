Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB0F1A260
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195836; cv=none; b=gmybVPolDE43Vi2VvINlBNCnLHKYPvqMcRRkMcKCgCpDlYukurGo6j29RpzLsK2t6yVasuOrNEgyloaF1JVHrVMBb6+q2ECMOlPXfGND4CYDer/NiRdeP2E4UyYnbWNBiai64HfqbZC2fA026ba9HXRJm/D3ARCDuUv9T/GM/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195836; c=relaxed/simple;
	bh=CJF62BhAmXgFVcBPNSpJZBxx67HXi6tv/Z01HS2w9pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXgC3qjrhY3c/EfgalE1Nj7PBtcAevirgt/yMuFs1Xgno1hIRgNxqNK9RpPCH+vjsWoT/+lT1DzT2usa7q3tHocg8Mzv8AS4VtL7dmY0DR0sOT9pxSu4BGOzRWCpSD0ZK2vLFvtM3reAxkr/QGQqekJTIC3E6r4oOFinLcy9UVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BcBXZ9td; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BcBXZ9td"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8efefec89so4792686d6.3
        for <iommu@lists.linux.dev>; Wed, 05 Mar 2025 09:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741195834; x=1741800634; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UnbNfNEwR2ZRmkZgevYyP92cajbp+iQbSNUyrujuWwY=;
        b=BcBXZ9tdTRd3CJ09nT4CmtsQAid4A9XQkWkWeS7RAIlg4YY/UA0TqcQYvXNBa9zkGL
         VCzYFpIs4xbW+QYjsrcLx5oYJwcfjFUYJsjQwcZfBKHFvrGbB79w13gxte0Afy9gqm72
         JfwMpVpf4dOb4knVlBihGSvUrotabrhL6U4VdDCLUb6AQym2CNdtUv8jo+vB1NN1aS0Q
         wSj9hmIJXXIp/1EyZM6BcBIr7EFD0IaOnSnS5FAOawvfWOfveKKCTpdwW5KNLrydp0GB
         8+KHDExs2JqGByDl08Ws23bETbOgqzd1nO7FBQRcQIme80oF9F3kS5CmyX7l4sHLRuV4
         ELUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741195834; x=1741800634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnbNfNEwR2ZRmkZgevYyP92cajbp+iQbSNUyrujuWwY=;
        b=hAYz3uOv3KG4mDa2/V6IvdLbSe9r6+ELgicmaeToVvTNkZdR8G4pYYaNRZf4m80mY5
         7BKAel/+PkLmlXRnpLgZnJl4mqStiiMwOrq3a/8RfscCWwVxmCW0q/8hLUTtFWyWVwx3
         28FMBUL+ClGWygi6UOBov4Wx3ijjQF51x/iGryuDmzHytt8CD45fi17DvSM23F5Jkabc
         zZs4c0cqOaBNlhDsv/Fb8CHL3zGLPzvjiarRtsz7slynalBrzrta3CjEClCsg78Ae0Sx
         tvGMNGzttG4ibXZkMyF6QTkSVewC9kY5TmhGAaDLpwcUSF6QA/WdsqysSD6ygm4jrxLC
         rxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyNL2oyZa0aNAllL4zku+59DcC1vyEiwqMDACLgThcynKBJBpptwck5lCMY2ZQ3tBmET/JZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBDfTmzHju3Zujmw9yzThe2berEUwGtEQ9T2AmX1ChzxvfYiH3
	/KuNOy4T/SXnCgSkoQUpxh5ZmTWpH30szRE+YaAU9g2ukSYGtWwYPbQhQ4lWiDU=
X-Gm-Gg: ASbGnctLV1RkB6itUuqNGyHaKpH5yyCBhgEYnzpO8aM0LGZ+3fXnnUVta4WXVkUCRjm
	r83qlANE1jfF/7T10rPfaatdVyv1OfGawREV4lnOW/deOm9tW1tLgmeDlttkwSND0qh1pLpLpiv
	Pk2PqcQgD4UKjgIqyLm8NqWCZnlxf0D63/w/cYI6mx4O/7dLcRkL5lqSYz1Y2KUlcmdlx+AHWCY
	lPrbvqVxhycUtPB6Khr0VEiJhi+nt2HJMmqfAuEGNBqBmSsMiVDOtd9Vrtj8wiIpSnLrbM40/F4
	S8X6HLLL6umRK6p4+uQ=
X-Google-Smtp-Source: AGHT+IGpOwBYCLGg+SE+XVE9sEz1UbTTNixDjTUQFq6KywYbAl34bT/LItbYRa8N42JAJkSLBhU4PQ==
X-Received: by 2002:a05:6214:5093:b0:6e4:269f:60fd with SMTP id 6a1803df08f44-6e8e6cda716mr57452306d6.23.1741195834177;
        Wed, 05 Mar 2025 09:30:34 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec1f8sm82057626d6.121.2025.03.05.09.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:30:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpsZk-00000001TJd-47R2;
	Wed, 05 Mar 2025 13:30:32 -0400
Date: Wed, 5 Mar 2025 13:30:32 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, joro@8bytes.org, iommu@lists.linux.dev,
	yf.wang@mediatek.com
Subject: Re: [PATCH] iommu/dma: Remove redundant locking
Message-ID: <20250305173032.GH5011@ziepe.ca>
References: <a943d4c198e6a1fffe998337d577dc3aa7f660a9.1740585469.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a943d4c198e6a1fffe998337d577dc3aa7f660a9.1740585469.git.robin.murphy@arm.com>

On Wed, Feb 26, 2025 at 03:57:49PM +0000, Robin Murphy wrote:
> This reverts commit ac9a5d522bb80be50ea84965699e1c8257d745ce.

Minor, style guide says to use fixes format for commit references:

commit ac9a5d522bb8 ("iommu/dma: Fix race condition during iova_domain initialization")

> iommu_dma_init_domain() is now only called under the group mutex, as it
> should be given that that the default domain belongs to the group, so
> the additional internal locking is no longer needed.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
