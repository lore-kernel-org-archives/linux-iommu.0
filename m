Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8EC1C06
	for <iommu@lists.linux.dev>; Sat, 29 Jun 2024 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623509; cv=none; b=oNkwWrePZYXYMfELUUGuPdqlR2AkhNHmFtr5z2da2Ha7LrSo0io7PBggDqvXyT9yHsnh+YPAcV41Z7faCBTWkDJ0BJuP4OKTq90ALvMoSKQjmlpF2OZmQZA5mNeogYsLjKVAk3G1rokKAPK53Gm9/rRqazp1JBM51X+kFuXRFpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623509; c=relaxed/simple;
	bh=NmWmB8xJkdpQ6+qsRZ3yNW+0DCBVDLk7Mf7CANqDZmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWv4Pwl3SPo43J3oLDvi2mkmHdckVAdFqVoJvGw3aB4AUEJ3iQOyoeL3NJv0so6MDZSZngEQqT6NNUCaMA6OIuualy/lQDi5GN2SFa2Pu1L3VHesy7k/0z5Rx0eY5eJxqzrB1xWewui4Yi8JPFHRDd6cf7hk0VkFXpXOFzKwMr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dnorY7Y3; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dnorY7Y3"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-37613975e20so4817825ab.2
        for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 18:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623507; x=1720228307; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EBVtd4lNh6ldbTw81Bxi6NFxymecp4v8R1CgV33/re8=;
        b=dnorY7Y38sYK+8q5WTTyrUoaNz45xAygmrr3O+1//+TZCda721Iaqe6FUj3ns5V787
         R2w4W16OnPvRCFilxuU0rS1Hgjnps666PR2PYCRkqiVlbhvWHgR/kh1WRtPg9zKmmAsQ
         fHAWejRn+DJTVGWK2bRyY/1X46iG5aTozbgO5bPxtL296Ciy6yI/gHOWRWWzGhkq3Uie
         HlamGA2TyolVLgNNNO/4JxS5mmVGyoIuRzxpht4JoxSmGo88YTc4ZpkS5Tm8622o1Xsw
         xUyanUEo8CwA8DqWTK+otqC8pkiXi/ukWI3xFK8ESIr6mbhlQ1u2rMsbkTNH5N5CYfQh
         5ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623507; x=1720228307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBVtd4lNh6ldbTw81Bxi6NFxymecp4v8R1CgV33/re8=;
        b=qw3FzsMTMJMYQnOPOq9syWgkrEtpNnRMYcluJNz+wT7ZEv65TuSHRk0GuAdTsnrxB4
         NjmjX69TI4GX3d6SeO7mHOYlottjqnl6iT7eqIzllzeXG+f0rGkymaGGNhDBDzv0qyet
         zYpHff54cqp1yH//JqNyYpEw21GDE95JLkRNf7lchlN6yds1cnANOnZfzh8xqtHUzH5r
         U3u9ApfqL4Lvvh646dWSFd/yowY4MwjHN9fSJyRBVpXcrPj1ve9LNJtsev4t/xcTbmyy
         SJh/tK8EZGNKeshC0YM+Fh0UeMQqzDt0q9O8v3lEddflIm8d8ikNhhgOzkoG/Ceum9dW
         02hw==
X-Forwarded-Encrypted: i=1; AJvYcCVfkK2AoxBO8ZZvsE9oJB1MJPoObFtY6tpBFrr0repR1SbfOo4vP2PIkL5UljQajGxbozLZZRY6T+zeT6Vskaz8RweHhwE=
X-Gm-Message-State: AOJu0YwEjZJ+iE45i7AdxhjnBCQdOU9CErcAh99UYFuff73Mj8zMuRU6
	lF6wkrmBbBYq0k+eRXt30vetNTcmNIgsu8LUWU8vhujO8eAK/dyVET7hQCwsvBI=
X-Google-Smtp-Source: AGHT+IE4QgUFrWMp+tH+7fcsNM5wNf5R+mcyUObJCqnJg+lJpDagM/8QA1d89wQbwLfqFUo7RgzINQ==
X-Received: by 2002:a05:6e02:20e2:b0:377:14a7:fc99 with SMTP id e9e14a558f8ab-37714a7ff6bmr145245465ab.24.1719623506847;
        Fri, 28 Jun 2024 18:11:46 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:45 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNInD-0004RY-K3;
	Fri, 28 Jun 2024 18:06:03 -0300
Date: Fri, 28 Jun 2024 18:06:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/10] iommu: Extend domain attach group with handle
 support
Message-ID: <Zn8luxc+RLBOIIX0@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-5-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:49PM +0800, Lu Baolu wrote:

> +int iommu_replace_group_handle(struct iommu_group *group,
> +			       struct iommu_domain *new_domain,
> +			       struct iommu_attach_handle *handle)
> +{
> +	struct iommu_domain *old_domain = group->domain;
> +	void *curr;
> +	int ret;
> +
> +	if (!new_domain)
> +		return -EINVAL;
> +
> +	mutex_lock(&group->mutex);
> +	ret = __iommu_group_set_domain(group, new_domain);
> +	if (ret)
> +		goto err_unlock;
> +	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
> +	if (handle) {
> +		curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
> +		if (xa_err(curr)) {
> +			ret = xa_err(curr);
> +			goto err_restore;

But this error unwind doesn't work because the xa_erase() already
happened and there may have been a handle there that we don't put
back.

Something like this - store to a reserved entry cannot fail:

int iommu_replace_group_handle(struct iommu_group *group,
			       struct iommu_domain *new_domain,
			       struct iommu_attach_handle *handle)
{
	void *curr;
	int ret;

	if (!new_domain)
		return -EINVAL;

	mutex_lock(&group->mutex);
	if (handle) {
		ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID,
				 GFP_KERNEL);
		if (ret)
			goto err_unlock;
	}

	ret = __iommu_group_set_domain(group, new_domain);
	if (ret)
		goto err_release;

	curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle,
			GFP_KERNEL);
	WARN_ON(xa_is_err(curr));

	mutex_unlock(&group->mutex);

	return 0;
err_release:
	xa_release(&group->pasid_array, IOMMU_NO_PASID);
err_unlock:
	mutex_unlock(&group->mutex);
	return ret;
}

Jason
