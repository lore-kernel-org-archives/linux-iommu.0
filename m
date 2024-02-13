Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF633A1B5
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826382; cv=none; b=YrfNXwtaBSIeU0ryse5ucAqq0rY2P4QJFcJfH30Bbvqc/O8Uou9qOawGKNkiXUpDUZOF5uexxM4FG0ymJLbZvFZ4Ou//yWjVp0ffZtXI3QJjMv/pZ1ZQ/6IxAMQ+n5LdhCnIzAkETpRSvKj4vN5/830Yza/Ka8Vd1Z9TL4yK+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826382; c=relaxed/simple;
	bh=+bZnJcvLbBr67dRtqXosVQCfwvQmnNsE9e8Q61aZkME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+VjFIH5lRQRPDBE7AzzRogx6zCJEelemj3w2SxxVPGqNRxh6Ugj4kjjmWzfMtbolP/28KYUhhghoHuYijTDvDNnTMML9LdLu2PlPd6hTVycOE0yJt/dNzNg1saYKudBEwnFE0Uk9gTbDVjR5JdDpikJC8HwitViqpxpbr8IjjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mQ+BXHq0; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mQ+BXHq0"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3be9e11ee59so2064431b6e.1
        for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 04:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707826379; x=1708431179; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lh2S53PNrVSpQ9ctYNwyUkzWXBkJcw0etvJ1hxA115I=;
        b=mQ+BXHq0gR+RmWnY2D0Vn35hUgJab2d63+fuLWaRi68lY+MzmAka0bNp5qE1a1vGJz
         dc2KacKsanFxUXH6ZYfMFIpuLlGVI/NAHntTAa6zULjoc7z06tgZ2rO3rApZ/8iRdWJ9
         IRsFxsxFU2XMdZO00A8c6QZFcINN8E6UyhHFEHSb22kiShuaYv/mFGoglq2onjhsC9dE
         oWA5ZRad+URNFS18vogVpzj2f1NY3SalayUUytMpAN6o08sVxJ1leJ4zRL6igNTifC4P
         /yql16nEulmtFt5xBZiLf8Br5IdaZEzly1G4tod1TsH/XzgTEWFLN0cXjp4yowZjWxl5
         /IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707826379; x=1708431179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lh2S53PNrVSpQ9ctYNwyUkzWXBkJcw0etvJ1hxA115I=;
        b=NJa0sWOniPxFjioHSYyTNQ12Ib3rUygffsKYofD2NQvdgp0uYgF6Sh+psi8QoTJj8p
         i6ybrsGSHxFctWRcql9gEMH5IMmD2lCkwMnAEbMPmtKUDfi6m/cRxa4dic2wGRNYYaxk
         rBs1vGTcvhRUt2kQv2siRO0QGKeKcorQfFYQmUwtGf4Vx6qkBxXnFJruLokHy3v65aO+
         blHTidf6GmQSxyvcRzniznBRwxIb6UGbgEg1rEfligTc2ePq2/sUuR0yKvCI384EB2d9
         3mXwt+B4Gz2Y3tBDbsp7Boa5HubRvpDi++BvSK9jdknd+gGK4DiwBUdjvzVJSJF2Yumb
         xx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXP9qt7knh6hy+1Lx2EwDcnuAy9BlWPv+wy6BFsWauodJaaBA997hNt0EVWn1eK7A3pQbo91hS4eBbLsdgd9lRfjR6lQSE=
X-Gm-Message-State: AOJu0YwVcRX9b6r6fDdH7ezMlMkXhrXC+hG01eXo2GOBc9MVZdWqob+q
	4q1aggmWuMybaAb15pCgiZqR1wcbXRBaK/DmAgfqfZZy1sS4VRQq64pSVPcQIX8=
X-Google-Smtp-Source: AGHT+IF2S9NvcWTIHZLBSkIb+Q4dx69PQhLwBzE8c7PMO/UI2iadkvy+/2caCK/VF1CqKs//+EdA9Q==
X-Received: by 2002:a05:6870:c08e:b0:21d:d9b:c3fd with SMTP id c14-20020a056870c08e00b0021d0d9bc3fdmr139240oad.55.1707826379654;
        Tue, 13 Feb 2024 04:12:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2Ro/6j76H4+eYPLEB5BTAvd5rTrW/8UhzECCu6fwZzxbdzMM0SdAuI9ybj/E0Ugy+RxmKQivEi89dwRYWHXUIov3z8oBQvUatKs1hPmwzqhXOKVMnf0YuRjqnAJla4DB7u9rv5wn3+HrOYc3ZlQhF9e3PBvPk8irT7HZRtTTMkcJmdsbJZz6PjYRMBYW3FTjQxp3zfWwwCDMW3DgZtW7PyPHfBGvfntvE3sFPdLhIwMZq7CwPMkMw+92tC7iX46F53xxoCrI=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id p9-20020a0568301d4900b006e2df9470d4sm435849oth.80.2024.02.13.04.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:12:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rZrej-0040Cc-KN;
	Tue, 13 Feb 2024 08:12:57 -0400
Date: Tue, 13 Feb 2024 08:12:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] Revert "iommu/arm-smmu: Convert to domain_alloc_paging()"
Message-ID: <20240213121257.GI765010@ziepe.ca>
References: <20240213-iommu-revert-domain-alloc-v1-1-325ff55dece4@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-iommu-revert-domain-alloc-v1-1-325ff55dece4@linaro.org>

On Tue, Feb 13, 2024 at 01:31:56PM +0200, Dmitry Baryshkov wrote:
> This reverts commit 9b3febc3a3da ("iommu/arm-smmu: Convert to
> domain_alloc_paging()"). It breaks Qualcomm MSM8996 platform. Calling
> arm_smmu_write_context_bank() from new codepath results in the platform
> being reset because of the unclocked hardware access.
> 
> Fixes: 9b3febc3a3da ("iommu/arm-smmu: Convert to domain_alloc_paging()")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

Please no, as I said in the other email the only thing that should be
reverted is this:

> @@ -875,15 +879,6 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
>  	mutex_init(&smmu_domain->init_mutex);
>  	spin_lock_init(&smmu_domain->cb_lock);
>  
> -	if (dev) {
> -		struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> -
> -		if (arm_smmu_init_domain_context(smmu_domain, cfg->smmu, dev)) {
> -			kfree(smmu_domain);
> -			return NULL;
> -		}
> -	}
> -
>  	return &smmu_domain->domain;
>  }

Everything else is fine, you already tested with that arrangement.

Jason
