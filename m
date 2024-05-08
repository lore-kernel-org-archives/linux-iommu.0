Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13376372
	for <iommu@lists.linux.dev>; Wed,  8 May 2024 00:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127524; cv=none; b=gY7NspRif17lqr8+XZbjSfP1qNr7Tw7WB7xClAMoapKCgRRV6KJa3FrE4ZsyTRR8LumMFCj8PY2x+qXql++zl5uKVa59G08ncPYcnobSrh5usam+18GcqDWwm9YSKYJnkSi2YRzdkz3t+n1Efy3vrRjoBcwBAX2Y2LfmUIUTFTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127524; c=relaxed/simple;
	bh=yYyTvuGPY9Yh5W/zUy0ZLLfIboxNn47n/XUpWdPEdkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX3MDxURXWMFnlB6hbLiNKrVojxJ4FYv6ozfQGgjOgHjhzzr+URqAL6N3Bmcof0bn9fbcyJ6IzXHqSxvK1NhPmZiolTKHQjZPb9/5DdZ5A9hTd/ZaCfV3bbaqos7DMG8D4dd5zw9EUrcxvA3XUXHz/O5XZQDkr+TsIImvQ/Gy6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ky5ORiY0; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ky5ORiY0"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7928ec5308cso28744185a.1
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 17:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715127522; x=1715732322; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xz9j1cB4bE9JnQUPVM/3p943nBzNMqY3vx9jMGSHBwA=;
        b=Ky5ORiY0K9PXqM3wBKjJaI+OQmKGYWlPt3L1QeFvr5FrUa5oDe3KX3W15dMplQK7LP
         coliArPFFpwg5V+cRvLlMoSEFJ0k3Ns+Os/j7fpZYBohbv1JB1N4AdshWm8lIc0gKsNr
         k2YQqCpUE7M2lqg+5+hTbtSBxH8PxlJTfXupzC4MDqd1Ioi9WNch7t05CcpsiJx83wDM
         mO4420E59yvPX3a4cl0qDH4T7vkUmfljylR4WMqLyMtfkKN9zzb+XqnBy03/F0IYQFen
         dnXw1Vmw6CdHgYiNmICi3Z2Ta6cIAG4QNyvwhq4XsMOCPE2Ze6tUoVMejICqRH86lfd4
         ettQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715127522; x=1715732322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz9j1cB4bE9JnQUPVM/3p943nBzNMqY3vx9jMGSHBwA=;
        b=EWNnGWIgrMOwnHF5f7QXyVcihHv0GHCo8HEDsvqp7d23Hmj0gJhS3Kxgf1a7NEvL/o
         KqH0aECnM3EzJSBqT4xhDHrOjmfB7i1zGrrTDVb5qTQ+ay6EAxJXHy/tt/58ZHsnk7hx
         MINQxjfAUB/aUnwnv5Ghhoh46ZIMEs4++zAAvKRqbL6thXOCtiO7gjeDoYq0/lNksD5k
         r+5eP80JFiVTZ2ypfK2RDayNo5kmV9QYCsHzwBFxJrAL42ZEGKkRCak0th9Za9eYb2pS
         A18YgU9vwlSV2Djw3zoiw7z/qNYEN/kT/TDYoFxsIfIYocycYmMHhHOKSJniWRfjcDzY
         ywSA==
X-Forwarded-Encrypted: i=1; AJvYcCVq+fM4RLZYp4LcDVuHwskXIz2inWkejHxqvSfQGcYOL/gR/UK4WQhgkNzgyosPZW3TOReCp/bnPreWRdCWTLp38VvXLv8=
X-Gm-Message-State: AOJu0Yx0BsqPe4PdpnT2d3f8w3A/6gwNDeulFqRSJn/rZ8/67I3P7ccH
	ffPvH9mj3y/N8nvD0CitIME/78wzUHgIUAImcyeKfOpRpTav+AZxHCH/bS+6KKg=
X-Google-Smtp-Source: AGHT+IH/oKAJDpiDkQ/SfwUCo/HBUUtNt6FLW2j+wSJ+9VeCJKucyFKqJPPS4SU5qDn89BCTBGrk9w==
X-Received: by 2002:a05:620a:1901:b0:790:ec77:4c1a with SMTP id af79cd13be357-792a64cdb96mr636436685a.39.1715127522026;
        Tue, 07 May 2024 17:18:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id y7-20020a05620a44c700b007929ca64e0fsm2160454qkp.5.2024.05.07.17.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:18:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4V16-0004sp-PU;
	Tue, 07 May 2024 21:18:40 -0300
Date: Tue, 7 May 2024 21:18:40 -0300
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
Subject: Re: [PATCH v5 6/9] iommufd: Fault-capable hwpt attach/detach/replace
Message-ID: <20240508001840.GO4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-7-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:07PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index 13125c0feecb..6357229bf3b4 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -15,6 +15,124 @@
>  #include "../iommu-priv.h"
>  #include "iommufd_private.h"
>  
> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> +{
> +	int ret;
> +
> +	if (idev->iopf_enabled)
> +		return 0;
> +
> +	ret = iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
> +	if (ret)
> +		return ret;
> +
> +	idev->iopf_enabled = true;
> +
> +	return 0;
> +}

I would greatly prefer we remove this from the drivers :\ I guess it
is Ok for now

Doesn't this need a counter? We can have many fault capable PASIDs?
That will get changed in the PASID series?

Jason

