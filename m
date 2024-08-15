Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B421AB52A
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730594; cv=none; b=u1Mpxp6t5ccKYhtV5fhphG8NpYT9d8ET66bV1L6ehjQ1RH9mlq//Z2fQP8SusWxeb6entjO0RWxuBjt9Sw7rauzH2X0FVB1f+4uy8Ac/UnmPtCzVYI4/wJo5SLdS2+Cwu4Si7YGceRABESxfIbNfDSPZ/Anoj7njyU0C+dwitOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730594; c=relaxed/simple;
	bh=S/01c2oaXBqxoo+TrQOPdXPRQYIjPpVJkDY/Dy0tCTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1nUeb+U8VB7eDI7YxjhF28jK4X1QNORxt4sKaAah4nJidx5iYHAztfmY0HqwdN1BJfMyKy6aYKawk0/h6LeQDF3MMjKrtrTlY09yklKG7l9rJ/ti/7cCkMpJV6qoxuPmJT7hqZqxBWZVdbByt3pDyDbLRupAc6thjA5JCFy+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3194614BF;
	Thu, 15 Aug 2024 07:03:38 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D1B63F73B;
	Thu, 15 Aug 2024 07:03:10 -0700 (PDT)
Message-ID: <13778702-717d-4b7e-8ead-3ba86bfe55bd@arm.com>
Date: Thu, 15 Aug 2024 15:03:07 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu: Handle iommu faults for a bad iopf setup
To: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
 Kunkun Jiang <jiangkunkun@huawei.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20240815124602.65439-1-praan@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240815124602.65439-1-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2024 1:46 pm, Pranjal Shrivastava wrote:
[...]> @@ -155,22 +208,37 @@ static struct iopf_group 
*iopf_group_alloc(struct iommu_fault_param *iopf_param,
>    * hardware has been set to block the page faults) and the pending page faults
>    * have been flushed.
>    */
> -void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
> +int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>   {
> +	struct iommu_attach_handle *attach_handle;
>   	struct iommu_fault *fault = &evt->fault;
>   	struct iommu_fault_param *iopf_param;
>   	struct iopf_group abort_group = {};
>   	struct iopf_group *group;
> +	int ret = 0;
>   
> +	attach_handle = find_fault_handler(dev, evt);
> +	if (!attach_handle) {
> +		ret = -EINVAL;
> +		goto err_bad_iopf;
> +	}
> +
> +	/*
> +	 * Something has gone wrong if a fault capable domain is attached but no
> +	 * iopf_param is setup
> +	 */
>   	iopf_param = iopf_get_dev_fault_param(dev);
> -	if (WARN_ON(!iopf_param))
> -		return;
> +	if (WARN_ON(!iopf_param)) {
> +		ret = -EINVAL;
> +		goto err_bad_iopf;

Nit: the err_bad_iopf path is only ever returning -EINVAL, so you could 
simply hard-code that there...

> +	}
>   
>   	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
> -		report_partial_fault(iopf_param, fault);
> +		ret = report_partial_fault(iopf_param, fault);

...and declare "ret" here in the one scope it's actually needed.

Thanks,
Robin.

>   		iopf_put_dev_fault_param(iopf_param);
>   		/* A request that is not the last does not need to be ack'd */
> -		return;
> +
> +		return ret;
>   	}
>   
>   	/*
