Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2263B369D47
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269894; cv=none; b=uBnJbgVb/tyU7IhAxgkkxRz7L5zzyLfUyF9T1Zr/8c8z6Dojx6avQ6C+UsTeDEqnhNInRqe7ICLk3wyEk7Fyr/TgVDhthMbPIrRCSa2GflFjJ+3HDBlnKFr3npcZdxLa4+kJ8Mo2EQJQCjI3AXYwoRB2QSjJPLgVfBNVz1+Ahyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269894; c=relaxed/simple;
	bh=6RLM95tVXhhqTEAI3bs8f9Td4O4dFxD+RZMu3o1Spsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ2UwZUAdW5psWlkl5hl16VAhiZn2bdN6+fQ12G7utSba8liJuoTmt/f3kxOfVG9BNtm4udv7XS2nztsrQT909FJvnCzI9SmehQOU41IF2lvEntc/7gLmb/HJGtw9rzTE9Bi/bFViNCFJZ68z8ZBQ7Bmt8KuHwGziQo9wDzOXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hXpoMCnW; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hXpoMCnW"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-915e1354934so100128985a.1
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781269892; x=1781874692; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SY1qh2EzoD4lSSqxBaYm2zj05JXfJ1AIWyiIERVGfUQ=;
        b=hXpoMCnWQJNOQ7y/C2rwPXt5220c+UDumSXxeKxrVU+nym6jNI1gxKgRv/IF435R7y
         tcvj4lYm8qB/2k1ezmlUwediEAr9jhmGdc5DhsCUvKMnPcakbtSgRDImtC83XISvPt/R
         QarlibJSIkaGjd4geiu4WDQX7PR1FczCR69cKD0ZWyJfkOh+thmPr2OrETNkODm01fnZ
         86RJK0xc/Jtpb+yCwOrkQ7r+f8k1fCdA4I3ocIN2YXwbzBEjN3I0uIT8mKBjDwBxA6zR
         jkV+QZNClRsRvvmjyfmomWCkW+iIczinfm/MRHmsqaFyeFJPYbX8aJUm2HDGAMRowyeC
         3IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781269892; x=1781874692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SY1qh2EzoD4lSSqxBaYm2zj05JXfJ1AIWyiIERVGfUQ=;
        b=maLt42ESpCGDP5pcp27KTxtOo2w0Z7zUoZKXk9zw7WrRZE/kst/naxT563da0aN7c5
         nIE5N2cLNDaPFxaYYoHG6VvQO4xgKUjCNnBSXMVKCr7nAjHwNyFXr7yby4LcpEQjmJOz
         GWIWzzbJD0OJUkm1jRqdhz3AHQA0HZzbkIh0V5NE2T/ZUzM/GyyCQRrfnJLdEvRNvTIk
         KMiUKOZS9qOV/XaPOYZMZ9UK8YfPD4lXzEcQgO2q3zeL/2HpNxv4XzWGWUIwhvdtMDQc
         MUkAQSAMCpaU8BFYI5wFOaWALNU2gr+yHYO+jsSBSPYCVXEnoW8uAeRBk3Dym4u50qWt
         Qq+A==
X-Forwarded-Encrypted: i=1; AFNElJ8Eqb3celHo/J7vcFInipOFHGOzWBtwt9mONa7HCvBjAUVnIlwSwIj5uusSreXnTN0hbF7Bvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgRU8YWHBL+fUymdVRulxOIdLSgW61wJKgmoapVx+xs2h/yio5
	xBT0Mfwp1FVeKW3rGQT7GT7zjM9b70HoWohp9oNaxrtZskjEN90Wa7dzCeEqsew8KJE=
X-Gm-Gg: Acq92OE6y8iycddV8wgWNV3uaO25C948zUCqx3xPD9wBQsN6hz6tiS1L/XFkPwIMuU7
	vxXRWqOeaxKdsEn0E/nC9dQSgKfqkxJ/KM/uKNCAAX0GYi/q18uTczZV/afu13Nb9fHl9Un0Dp6
	Sb99Mef/5Tb0oSarsmsDI7VN/7ayfeo1xtv+OmvlmbevBVo0YUxKNF/EuUbUIN+DuQgzK2iZ9IN
	+M4HyvEsLG8CAKeFCE81nXXsz9WzgEXjpbFW63U5jLZTTQNkxMTINbtuRocEz6T6oJpQYvGu+N7
	WfIsRG+6WFeIQe8PC8aLIxSf2TX7A0xz6yIQytZiSfTLjqJ5rgb9rn+d4Dt8Cubb6j9QlJA48a9
	1wKVPFsRxV51f3rZSim2hk1r/eauSuvMkFol1jxkfgUXPked64s+7ACOgHWX2P7VKXgt5FO265Y
	nFn9pFhto4gi1JiC51+tgSPRCHYI/XaAoGEKpf3V7Rz5AL3W1J02Za3AnH9fsswsuxps0zXPEFc
	UdzXg==
X-Received: by 2002:a05:620a:2987:b0:915:cda5:27fa with SMTP id af79cd13be357-9161bfad4e8mr354973885a.58.1781269891895;
        Fri, 12 Jun 2026 06:11:31 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a055046sm203238485a.41.2026.06.12.06.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:11:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wY1fW-00000007mFT-2jeB;
	Fri, 12 Jun 2026 10:11:30 -0300
Date: Fri, 12 Jun 2026 10:11:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Mastro <amastro@fb.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd: Clarify IOAS_MAP_FILE dma-buf support
Message-ID: <20260612131130.GK1066031@ziepe.ca>
References: <20260610-tmp-v1-1-b8ccbf557391@fb.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-tmp-v1-1-b8ccbf557391@fb.com>

On Wed, Jun 10, 2026 at 01:44:41PM -0700, Alex Mastro wrote:
> IOMMU_IOAS_MAP_FILE is documented as mapping a memfd, but the
> implementation first tries to resolve the fd as a dma-buf and has a
> special path for supported dma-buf exporters. In particular, VFIO PCI
> dma-bufs exported through VFIO_DEVICE_FEATURE_DMA_BUF can be mapped when
> they describe a single DMA range.
> 
> Update the UAPI comment so userspace understands that certain kinds of
> dma-buf are supported in addition to memfd.
> 
> Fixes: 44ebaa1744fd ("iommufd: Accept a DMABUF through IOMMU_IOAS_MAP_FILE")
> Signed-off-by: Alex Mastro <amastro@fb.com>
> Assisted-by: Codex:gpt-5.5-high
> ---
>  include/uapi/linux/iommufd.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Applied thanks

Jason
