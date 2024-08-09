Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB218C93F
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210924; cv=none; b=ofHcK+T7SxX/GQrf0aUeNPt8xeX/CQy6/ABEsKsT+Iddv0EXMv7WRP34wEtc9TgERfOO58ULUhgFqTJOfFZqNmsNwdCXBSUVYWMSwMbdaWPPYT8ntUy//DQxXB4QiQirVSF2BUJGxVd0FyO5SJELpTlrnE8QuV7bAxIWs4qy+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210924; c=relaxed/simple;
	bh=1fxOc/3P0me+bve4od/PfTJ74lOE4vkcbcv9RZZM76I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOgideuaWXsl2+3Q21gbcrlVfKKtbhAsmM2aaYDJwIHKeVpHh47vT3XWEW8LEJxZkzuS0yDqSFG1mGeojxwaOoH9nxeWb917RUz2e3wpZtHVQC3vhuDPqtSbjZEirz8tY2wQM3pzn/H+E9oHNa71MVotdGep0ULG7l1DYOccuBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FNiJOOXD; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FNiJOOXD"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b7a0ef0e75so12320326d6.1
        for <iommu@lists.linux.dev>; Fri, 09 Aug 2024 06:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723210921; x=1723815721; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZY6QlLIxw4WLcroKmo96KDSwkSC+vWL18J8wOL3lA0=;
        b=FNiJOOXDY8Q+fXyytsVmF5I8kHHyTb0+0J+7eNXezqt8diF3NQYEwtZ5lOHlRJksDo
         23PPbHPILojwh7ha2ssmnjz8EwTXcemrope9UI3U8PGaHG1hTIWtdNWcRy+nBi2dYUAM
         bp6wapSwNjaWvG2U1umyG0D/1ZtMQ+pD8ti51bLwsZVFJN5JraaCOVGe48TyZV+Br71s
         lmqUzSp9hapCKYs8OdKcbNNPM5sUSGs/AZ7Q2bXYuKcGgtV82aE0XudI2ytVNN8Nxipi
         OE5U0Sj6B6+fHYqmVvKJf+kZGTUal2/qkKo587NPgzhB78HPzVP+fg52ET1s7VUKfljF
         0XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723210921; x=1723815721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZY6QlLIxw4WLcroKmo96KDSwkSC+vWL18J8wOL3lA0=;
        b=eNPB7z1iQ/DGtClbRXSq5P1uNdJDHrqp93O5tn09vY4+QMHyry26k0hkwNokKIKpVY
         UNJELM5ZA3sdOGCDOONPh+4CAQBeaub+tmB5FFdvipcqjfV5rpIkzHzvbFUNvKSKo1QL
         Pkb0+rhOzHhoD5+VzbQfJ0zjK5siMNgTWU5WA954TOtn6dhOLWvJJDJOFWbWABEGfYed
         8hNaBgQ8CM8caIS2oM608QQH0EoPxhZ0Piy7uG4kn2F5Ljx6ntPLz+bhVcy7LYePOk9Y
         vWFeuHopJzgYmK7VrjgZj7szQdxl/hrVFSJRlXpIg8H1/kkF+kFJpAJM28WJo72ibjhu
         iKnw==
X-Forwarded-Encrypted: i=1; AJvYcCWpRSG176jwpHdWNzVBzlv9jLx1h5Q+9XEaCVnJxDgL9In/8+g/oThp7Mcj5fytXRkfGPx7lgGv256dMnyq5zLGJEaKDgg=
X-Gm-Message-State: AOJu0YyunhwyMvlRqbFe8lhg8Z6T5ipX+t10gYmmZ8RB0wgTv4Hs1fI4
	VM15gXGzyfSh2By5wKljJLUDVjNC/u5Nll32a+c0m8sXF987RKVnP1xQ5KD5c/U=
X-Google-Smtp-Source: AGHT+IFS+jxQx9k25oojEqcmdiGM2mY6Nd3gXM9gU92IDbR4zObHr3JkscBcWZyMpP32Un+K1OEdTQ==
X-Received: by 2002:a05:6214:3187:b0:6b7:ad32:3815 with SMTP id 6a1803df08f44-6bd78de66e6mr16564456d6.14.1723210921231;
        Fri, 09 Aug 2024 06:42:01 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c8678f7sm76635006d6.109.2024.08.09.06.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:42:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1scPsV-00G7sD-Di;
	Fri, 09 Aug 2024 10:41:59 -0300
Date: Fri, 9 Aug 2024 10:41:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu: Remove unused declaration
 iommu_sva_unbind_gpasid()
Message-ID: <20240809134159.GE1985367@ziepe.ca>
References: <20240808140619.2498535-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808140619.2498535-1-yuehaibing@huawei.com>

On Thu, Aug 08, 2024 at 10:06:19PM +0800, Yue Haibing wrote:
> Commit 0c9f17877891 ("iommu: Remove guest pasid related interfaces and definitions")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/iommu.h | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
