Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBEC1371C
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 16:57:48 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bb1baf55f5so3973985ad.0
        for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689353868; x=1691945868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+ySb2iwE/trEYHujgNLZKVBt4wCZVG3k5U10OlXcyM=;
        b=gO0UzATDQ7oXdVlc/6UkWXuv8YjQrtAcI9fhA9/8PhC7LNYo+WAc6FjcclIBRvfZQ7
         doc8zbTNFPwa/gd+MG/y/uixrg7BI0Fz58yagdQQxtWZvVqqwRLvYLgUNiaWJlulu9CJ
         aiZm6l2cZcIirPLfdWgQO9sSLSgRgOO1yCOXDTL4QDbpXKQms6M6WpKE5tG/msWq3Plr
         Gxskhd7jzIvFbWwVPjmKi9mAvOwdOl2qxx20Cih5wfAzDmPIUm51RlFpzYc32HWwPszS
         H3lhHQpwd5v5dxr5DRe7cWPBGbPstWbBtx3dnM1rTpVBnZUbsU2MVkb3ctumMK6VRzJ1
         QKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689353868; x=1691945868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+ySb2iwE/trEYHujgNLZKVBt4wCZVG3k5U10OlXcyM=;
        b=hkwwPS+GxA6yicOlVpy4MWC4M61ckwkf35iN2sdvcrAX5v21VDJ2czlIhV8IFg8J2R
         9LuEDHA+4qyKFKny2ho06L3TMOonvemicKnwU5sVTcFkNxCNze9Y5NqOGYYHTiEVsiTM
         tmeJq4Ieb/d1KJbJvWmUOVJccOZDgLLtrQkDucn/doC987z46pCu+E4abt5CDYSfsi8p
         GeobG5fpTKnekV+h1cm2+kNwhxmxEyQuKjKO6ytNF/tljXsjwXgvKO815CqdyMGCmEvP
         pOj8rASta4SuWNHgRe+6Fs0nB3EiAFF3sOxdeS6kJwD1Xo1e6cGP4Co6vS3HqzCx8GfP
         +dGw==
X-Gm-Message-State: ABy/qLa1NhMmYUXT2t6RO8ape9hyCWzYYqYnQDQW1Ul5ZvfFc1K6WgnS
	kBMVoselvR/DppjfAHhp3MAhJg==
X-Google-Smtp-Source: APBJJlFYopdF14sotjoqaLRxcLhDtVZOS9pMm/tfLCIMPL4y9jnIUKiVq7+wraxj8rCQsKp7tSjZxg==
X-Received: by 2002:a17:902:7894:b0:1b7:ffb9:ea85 with SMTP id q20-20020a170902789400b001b7ffb9ea85mr5069748pll.29.1689353868503;
        Fri, 14 Jul 2023 09:57:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001b8b2bf3313sm7999905plg.217.2023.07.14.09.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 09:57:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qKM70-0018Ka-KU;
	Fri, 14 Jul 2023 13:57:46 -0300
Date: Fri, 14 Jul 2023 13:57:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 07/21] iommu/amd: Use struct protection_domain in helper
 functions
Message-ID: <ZLF+im8zYcZG/hGt@ziepe.ca>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
 <20230712141516.154144-8-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712141516.154144-8-vasant.hegde@amd.com>

On Wed, Jul 12, 2023 at 02:15:02PM +0000, Vasant Hegde wrote:

> +static inline struct protection_domain *amd_iommu_get_pdomain(struct device *dev)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +
> +	if (!dev_data || !dev_data->domain)
> +		return NULL;
> +
> +	return dev_data->domain;
> +}

This hunk seems to be in the wrong patch?

Jason
