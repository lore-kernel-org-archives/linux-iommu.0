Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5ED1EB46
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948587; cv=none; b=BZ55j4RBqMPv2uriyq3uCEzh/TpVzzzrUJ7jR+JtF6FmIoso3Ae7Gps7RDTBe8Q6o2ykYGfmIdoK8SSbO0FZiggHiBxmr+RIKlIYa+uShFnFwpK083BvxnPKaTOb5bro7zwu/iAqFR4wHXVybqI8kS2bo48awQo1YbaPp80dS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948587; c=relaxed/simple;
	bh=o2YjKCknl6M8LtLbfpnw3wCcfLP7Y1pD+V1xIOT7uLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQTKdski4o2S61759EPeCPSdBnG+bmNC/hoS47egzpTJnMzUwj6X4nteQd9ZZi7yR+GWOkbJgLmoAqoTC4tDs/4ImNc/uHZrAevtkSBJQQhoDKVoGUogiUao5zg1K288iidgyCVUP+D9w7ni+ki6RJJQC05Mc1MHcVQxchYh0d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NI9rLbRY; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NI9rLbRY"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b7a3773a95so3083196d6.2
        for <iommu@lists.linux.dev>; Tue, 06 Aug 2024 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722948584; x=1723553384; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsS8lDANHoxr8XxddcWQLsVxBCftUnrKv7PenmFYu8c=;
        b=NI9rLbRYMcu42pMp0XIsAOdBtSxOZtaS+NL1Lp9S8kibwKR8Qp/Nxt8bir7ukL22Gz
         FO5CDdxrk9MJC07eVjj7PVInWs+f1zXLI0lbIqXXrKRbhz+Wr3Lq7oAVxATwHnFowpGh
         ikpGWNdMii6TSbhR/keayDPm9CNme/nm+IubUQ/7Oxd8Qxcp1OMH1LqEG9YuEmZcfCcr
         J664PLjBd0hhw+9PVoyIdli7tAgvw8rWr4Y7rTPmGwoxnY7sl1JA4sOQ1tU0i0CNyRAy
         Ro7ybDpe9mAdciXwUxHbzDE9Aq3y/WwkKFQsuWDj/bPILuvXbgwoGqFAqt457sMlxKrN
         yQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948584; x=1723553384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsS8lDANHoxr8XxddcWQLsVxBCftUnrKv7PenmFYu8c=;
        b=oGSxZ56TwjQM5vIymBnKoMO4EIF63atW70aq0I6z9Nr09s8CBEqSCatHtOY6ywTnEQ
         Rwo9ZV3lw7ccwOGPorA/iRJdhX20HNjz7mhPVQNsAj11hFdoXDN+2rksjM876espYLfb
         lCb0Ly3J9QXbYhbwfTA3M7a7ux1H+EwMU8nzohwY/BdZvyb2TBAW8cMep2nPG7QwJjnf
         j3plwim035Lcu36qgCxqcIn99GqeajCpxiIqUcir0xs6c0tPUsJpXWCx7GYIrGn4A9Hm
         3IPawTp8O0hw9uJ2/5LLp4POKUSrXVrWY1KJk7LT6AiijJEqS7YA18TyzJNgco5A75SC
         dFBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5hiWejVTfRemZw52JgZiRel3AVZZ02cR+Ar/4Qprzv6fpkjKH2pmypjOn9tldgDC6afopZzIkK8MiVvodnn774fmL+9Y=
X-Gm-Message-State: AOJu0YyAl96SOQptJVKRyp5WW+X8BpUuQej4QroFGNtnoe/iZamb3Mni
	4OI/x3X8zr8zbI8213aIJO9dkjICRiuqBhBlCHqSDnEp1SdjYn6yeUwhkrxsbDY=
X-Google-Smtp-Source: AGHT+IE4gm6wgloJySeIldlxpXgfok3Evok6Njg2O3IYxbHH8YUdW3ULVRl1IGWvijLFTM05yqG0ew==
X-Received: by 2002:a05:6214:5a02:b0:6b5:da50:ac18 with SMTP id 6a1803df08f44-6bb983eeecfmr211113546d6.41.1722948584248;
        Tue, 06 Aug 2024 05:49:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c765e4asm46058956d6.25.2024.08.06.05.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:49:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbJdH-00EL3r-8m;
	Tue, 06 Aug 2024 09:49:43 -0300
Date: Tue, 6 Aug 2024 09:49:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Will Deacon <will@kernel.org>, Kunkun Jiang <jiangkunkun@huawei.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
	tangnianyao@huawei.com
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Message-ID: <20240806124943.GF676757@ziepe.ca>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
 <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
 <20240724102417.GA27376@willie-the-truck>
 <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
 <CAN6iL-QvE29-t4B+Ucg+AYMPhr9cqDa8xGj9oz_MAO5uyZyX2g@mail.gmail.com>
 <5e8e6857-44c9-40a1-f86a-b8b5aae65bfb@huawei.com>
 <20240805123001.GB9326@willie-the-truck>
 <ZrDwolC6oXN44coq@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrDwolC6oXN44coq@google.com>

On Mon, Aug 05, 2024 at 03:32:50PM +0000, Pranjal Shrivastava wrote:
> Here's the updated diff:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a31460f9f3d4..ed2b106e02dd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1777,7 +1777,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>  		goto out_unlock;
>  	}
>  
> -	iommu_report_device_fault(master->dev, &fault_evt);
> +	ret = iommu_report_device_fault(master->dev, &fault_evt);
>  out_unlock:
>  	mutex_unlock(&smmu->streams_mutex);
>  	return ret;
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 0e3a9b38bef2..7684e7562584 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -532,6 +532,9 @@ void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
>  	bool last_page;
>  	u16 sid;
>  
> +	if (!evt)
> +		return;
> +

I'm not sure this make sense??

The point of this path is for the driver to retire the fault with a
failure. This prevents that from happing on Intel and we are back to
loosing track of a fault.

All calls to iommu_report_device_fault() must result in
page_response() properly retiring whatever the event was.

> +static void iopf_error_response(struct device *dev, struct iommu_fault *fault)
> +{
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	struct iommu_page_response resp = {
> +		.pasid = fault->prm.pasid,
> +		.grpid = fault->prm.grpid,
> +		.code = IOMMU_PAGE_RESP_INVALID
> +	};
> +
> +	ops->page_response(dev, NULL, &resp);
> +}

The issue originates here, why is this NULL?

void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
{

The caller has an evt? I think we should pass it down.

Looking at the abort_group path that is effectively what we do, but
the evt is copied to the group's evt first.

I also noticed we have another similar issue with the
report_partial_fault() loosing the fault if memory allocation
fails.. A goto for your new err label after report_partial_fault()
would be appropriate too

Jason
