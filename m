Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AABC1DE2C1
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171332; cv=none; b=miQooKCzZ/h2NGGR9LQ4em235ZRJf3FtFYVcyhgvquyvhg6+BtIC4BbX51zm4RNk1Ofjcv4fpDvYBiP9l+z6DrFzZDJ8w1d1YzsEEFSVixjiL1Yy4WIuid+1/VdhRg7Jgl60hUAs5J5zmDzO3KWrvD4m+OQHYzaP5DKJyzQXEoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171332; c=relaxed/simple;
	bh=oZh+yU+Nl/9coBb9uSVPevy2L6oKGQh0M1hW2pnySBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1p8xmo+FTNlqKiMS9JHe1/9JVDnPsISzrcLhF2IdQ3CCR1qBXyCISz7fqwkWNTWgFRnmKnemaAC/ta6wYnTbkggHFENXmTwsrPTqPQyYZ09lvEmpuQuI3A+9AnoiyO4CiZ53G63SsYiUkVoZXgI0ZyHF2RahOMLfhYeoyZCq50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hYsEzjFG; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hYsEzjFG"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbd550b648so7548676d6.0
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729171328; x=1729776128; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YXGMw7VjMgSYdJQSGrxZLX7qC8+PFvEyyF1GfRTqBvY=;
        b=hYsEzjFGw05r4LD+8mp0akAa+LvYaoxLIbYLgCSh9Fc5JMegQFlfVgkjQZ5Sf9st52
         b0er7KZq/ap8eRn0A9Bt8RFrIjLvhzusuqoI5gwgqQw4hBuP7b3sYxl6vFWWAn/bzgYN
         QyQHMk30yQKup7OlTQ9aRxmKq6IuticUhh/yW8OCujdr1MKjyZcqJjjPW8HBMXpz6rGL
         6cPoicUYUQTziwd6oKvO+Y4fF0vIbOrFccmZPWe/YXXYoJ9KceThOYlDhFu1lC8Cmlh6
         OtI/Q3Cnd6tlQ0IwUSOYIfT64Lb3XrsmqV9mPmtLAF3KWaz+YjG5XQi7yJwZIkZwW/2o
         UZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729171328; x=1729776128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXGMw7VjMgSYdJQSGrxZLX7qC8+PFvEyyF1GfRTqBvY=;
        b=hdv7ySVRnxx+53HK7ewewbHEl7eN6Yv9CRRvpfbbO5dg5Z8Us96UMSz/v0w7HgfLGW
         xOl5hRVj5nyjkzvhgckc8r+19ilf1Es6rJnXfOy1pTRxYeEZJfM+luQan5hgcRimc6GA
         pAFbmdwWs3n4UjNs+KKIikxlVwybP6u9gXb+DwDA0aP8kqHAH4+QV1IaZEsfSEzGfDcF
         dSrNDZCFFA6TDsOq5WH9seGvX5baQ413Uq4D27LzbV/DhX2HOqyLuORCrNZMHxqHjmhm
         rBHS8kFYn+tF4s1w6xZTjxF698DEXgqD+4QVgGvdPzxILX/lTnzG1c5qfacJwY1pTuNz
         raXA==
X-Gm-Message-State: AOJu0YyTbcvyFH9/GhWR7NsOuTS/Rn7rsegsDRE3+cSrl0GJObBlIMgQ
	UQqPD5OQn3N3G53R5ccs7slfMS6oEk08ksAgbDf3FWAUN0zjVqziG3o0b9fwrv4=
X-Google-Smtp-Source: AGHT+IEKeGnjHsvIgiGJYz+tOaMF1t1lVtHpUbs0H588IqCCoBVJy0wKrj2qZXMQBtWZCH4dSld9eA==
X-Received: by 2002:a05:6214:53c1:b0:6cc:18b3:c66f with SMTP id 6a1803df08f44-6cc18b3c7e6mr174977796d6.5.1729171328299;
        Thu, 17 Oct 2024 06:22:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2295ac65sm28236046d6.81.2024.10.17.06.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:22:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1QS7-003vpT-F9;
	Thu, 17 Oct 2024 10:22:07 -0300
Date: Thu, 17 Oct 2024 10:22:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 05/10] iommu/amd: Do not detach devices in domain free
 path
Message-ID: <20241017132207.GO4020792@ziepe.ca>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-6-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016053501.97497-6-vasant.hegde@amd.com>

On Wed, Oct 16, 2024 at 05:34:56AM +0000, Vasant Hegde wrote:
> All devices attached to a protection domain must be freed before
> calling domain free. Hence do not try to free devices in domain
> free path. Continue to throw warning if pdom->dev_list is not empty
> so that any potential issues can be fixed.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/amd/iommu.c | 26 +-------------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)

Yes!

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

>  void protection_domain_free(struct protection_domain *domain)
>  {
>  	WARN_ON(!list_empty(&domain->dev_list));

Probably should also check that the new xarray is empty here too??
Otherwise it will leak struct pdom_iommu_info memory.

Jason
