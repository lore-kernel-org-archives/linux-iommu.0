Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B029302774
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161274; cv=none; b=VqDp+qK8cAKw3Dqu8viBr7qcqLpOveC6GXv9BPjwVScCIPzB7Is5BMsB1/wWGVVFqLYzQpHBvpB1/FF9EsNIhTjynwrE7XunFOwbERsTq4YkCt6MPLHvs+aekda4UdZ9Tdp82wxz7dcw9rufCMI59Z7G2Xv41oVQCXGnMvhdisE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161274; c=relaxed/simple;
	bh=pxV7kBbXU2ByvzUZ1puidxSyC67U1iF/n3wQaH/iU00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOexGcpdKIoyNV/RBo8lmpxmSumAqBP4Ek80Ue5ser19QRzFoPNiQj0C+4xW0ipbIT7cOUdbSR9Hm2YzoScy/sCYiuULb+meFsdlXiEhvRM2/eivDOtbDz7la+9HW7V0F4BT0UeRTGTgp/d9B/3qkQkuxFtS/T+WBjmmGG1SIpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IraUs+mr; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IraUs+mr"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4df2911ac5aso14262821cf.2
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 08:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759161272; x=1759766072; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lc3yIVTCt7GESleGWEPj94fox63P9DXvd9ojEsera/Q=;
        b=IraUs+mrp2cnTNepbdFS8+la+r5yX4B/D54L7mVRwwKVg6WfdgLc7U9QPQCmPs+kLs
         3RUFd4dWjN/X5/QGfV+mYeIFBKUtIdH1yf12IR+uQcmYD7WN2vgcI5KQDmcZbrG6sOz6
         Udh4omaE66rPxsheqev5HsIUIY07QX3pAkSilLWFl2hU/xgmxDymng6+zsCP+26MIRde
         IpG84tMYZCmSYiYypQfd6IAkDNTDzBYEW2ayg02+db0AGu4VDzr8oAz0ie9XD9+fyYpu
         7sx63Ilqf1hb4RZbLTtD0HCtbyIikrz7GNwLcELMafH+6l8XTWtE0W3IfLZa/zI4yaMP
         t3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161272; x=1759766072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc3yIVTCt7GESleGWEPj94fox63P9DXvd9ojEsera/Q=;
        b=KrKniBLKWh1OkCBsoxgNv5d4484JzYMAkkiefSIUTzB5NCmji3vpkhvo8w9+YhiNUK
         sAyXU2rRov3dCc6J+F2EL7ALrfjykDqAJFn76jobqlEsGE25lNFnXXA3mq3RKBlMv7D2
         Hz7BeeMTVj0SZ5gXcXCrXX00XRttEc8ErwBM3bHeotO7nJecVRSKUUSUd74lcXBwo8Y6
         9l8f0T8+/Kj/Jq8O1tynEsZuLFh1hoGAvN7NEbZ5RCWwfEI0o5aDX8b/2Kqhdqu/wAWL
         bOklT8RQHbgzK3CsOXWL4hk90oWzy7NBR/oXd5jaKp4NJQYNji/C0vc/j9pWOHvYu8RF
         6HRg==
X-Forwarded-Encrypted: i=1; AJvYcCXUAuacFrQWja0z1rcs2ENykkw6h7Fg7K7Jw95ZyxE+yjDvVDaiFXVrx4b2F7bg4UqBW0kb8A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+tJsEXrUqGRY7d1lXR3LQU7GIxEo8wzFT7lAdNjO+GSsaQce3
	HiPlzkMh76YefEcQgT2cRYXMgToms6IWlrVzxtre4PngO1HYLLG4GFM0/zz210Yin2k=
X-Gm-Gg: ASbGncvnusZsfvAPW6Qfi7rRgS/b5onnMvJZA4fnDczOcfpqReSC4MUqK7kiIL+0N5q
	1mLv2DYaRWx6nigwlqf8N3EAOEgYuFTH/RGU6to/AXEWx3jJHvcR/gMRXmV+iTWMVra+KjmLY/T
	5lCA0k1nKX+80bYAHLXALicKpwdz5ld3Jv6yb54ta/TfDUL935824T8y7Q/yYtbYVl2KmxRhawP
	pq5S7qxCQ3jZtWDt4dVXh9iYnNF/5+KMTL/x26Fs7b0aYJUOe3639+yTRud3IVxWXaALdQwMpvz
	6DnPzaGMuCnHcPVbPJaJ/EgSyxJzBRsigshE/M6A1OKatLTQMY2+ysXevJY0XMk803hCMiD3Pj8
	PF1Q2vKI=
X-Google-Smtp-Source: AGHT+IE73a8LyblCeUGV6w2tUddEWRBZht7Dzz/jDO6Cu/jrH8WHnHtrf2D16knXnBLwZow0GuMN6g==
X-Received: by 2002:a05:622a:13d0:b0:4b7:aa52:a710 with SMTP id d75a77b69052e-4da4d126930mr236668211cf.80.1759161271391;
        Mon, 29 Sep 2025 08:54:31 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4dfec096b98sm40112511cf.46.2025.09.29.08.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:54:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3GCs-0000000CM40-0CsH;
	Mon, 29 Sep 2025 12:54:30 -0300
Date: Mon, 29 Sep 2025 12:54:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	zhuyifei@google.com, Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 05/15] iommu: Introduce API to preserve iommu domain
Message-ID: <20250929155430.GD2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-6-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928190624.3735830-6-skhawaja@google.com>

On Sun, Sep 28, 2025 at 07:06:13PM +0000, Samiullah Khawaja wrote:
> Add an API that can be called by the iommu users to preserve iommu
> domain. Currently it only marks the iommu_domain as preserved.

Merge it with the previous path

> +#ifdef CONFIG_LIVEUPDATE
> +	atomic_set(&domain->preserved, 0);
> +#endif

The memory is kzallocated, I don't think this is needed

> +int iommu_domain_preserve(struct iommu_domain *domain)
> +{

I expect this to accept some kind of luo pointer to signal what stream
the domain is part of.

Domains are linked to iommufd's which are linked to luo sessions. This
all needs to be carefully conveyed down to all the lower levels.

I also expect preserve to return some kind of handle that the caller
can hide away to deserialize.

> +	lockdep_assert_held(&liveupdate_state_rwsem);
> +	if (!domain->ops->preserve)
> +		return -EOPNOTSUPP;
> +
> +	ret = domain->ops->preserve(domain);
> +	if (!ret)
> +		atomic_set(&domain->preserved, 1);

And if we have a caller handle then there is probably no reason to
have this state tracking atomic.

Jason
