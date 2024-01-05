Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB10924B2A
	for <iommu@lists.linux.dev>; Fri,  5 Jan 2024 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EDa2luuN"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5f3da7ba2bfso18231267b3.3
        for <iommu@lists.linux.dev>; Fri, 05 Jan 2024 08:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704471941; x=1705076741; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xt6bOKxX4WKSd5QuH7ry/2mZIxNV/j9IGmlac4AQg1Q=;
        b=EDa2luuN9KCndyMXE84s+CIJIY7A2+MKjDwlkGHsEB2yM8kZS+K8szsJvOLYRtuP/t
         wLBFBTHml6Uybxe3MrmhKGIKBTVuARA4hXcDJCoJ6coUVSD9WHPFkuX1sKyQnBfXoc2J
         rTmW7eFOLK03VDecRMJh/2P+YOtVn6anFHj+5c/dxgY+g3a4pLts4vTBRkz69e3FbtU8
         DkfdNaDXuRSIrZ+KJ8IPkelxCHFCVmZkJ6yUA4MyB03hQe754MwZQUL4cRkXfY+ZUnax
         /5Q5qEi/Y/iSKSHN2xv+ugb/Dln+/w8i1Csk6swhfpapn8AkmC061vRlOzrMD08Ih/HA
         vBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704471941; x=1705076741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xt6bOKxX4WKSd5QuH7ry/2mZIxNV/j9IGmlac4AQg1Q=;
        b=IFhmvTD8flNX+ygItYxWSAnNw6XmRdBKrRR99THqWZrrkqrzTBt3+UgvYlcfKdNHcb
         reKnqV98LQG+5HMnV1yPQH/8EtrWKNO9CZy3+6r8OjJjnKZqcjyUrhVilbTw4Wb5pDZ2
         c4fv2+hDlbNzRbwV4UjgHPi9M8ZYUi7UrC0vIxEXgPWIniY8FLGWPdjGIsL9b6rPxfRc
         wqHibXwgWKUXcWXsxNzj+z+MpntETCpK46uyuVAPPf1R+lV9WvnHrM1z+Q/gkZVnDyAx
         26BinPOKygUmIvE9//IgYNc7tO8FaW+ZTaM1jA4NcKe9flUdaRXL85QnGyURYSZzYMkv
         Xm4Q==
X-Gm-Message-State: AOJu0Yxn/WXXIOFt+PYaT76MhI/hf/c94QR7Qf2D8J4vn3pp4hcP9Krk
	h4taY283Vp8eQ/sEQdXbX8aFOmmQsUVEIw==
X-Google-Smtp-Source: AGHT+IHH8UN8MoX0zsxIuGAZ3wRCTin7zoXycnqxgOEJNmeU4cje+YwzHaFJ7RjoRuZOBMhG15NGxQ==
X-Received: by 2002:a0d:c783:0:b0:5ea:c5d5:6a00 with SMTP id j125-20020a0dc783000000b005eac5d56a00mr2373497ywd.55.1704471941479;
        Fri, 05 Jan 2024 08:25:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id da13-20020a05621408cd00b0067f9bbd1689sm720815qvb.76.2024.01.05.08.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 08:25:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLn0u-001Td8-HY;
	Fri, 05 Jan 2024 12:25:40 -0400
Date: Fri, 5 Jan 2024 12:25:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 13/14] iommu: Improve iopf_queue_remove_device()
Message-ID: <20240105162540.GH50608@ziepe.ca>
References: <20231220012332.168188-1-baolu.lu@linux.intel.com>
 <20231220012332.168188-14-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220012332.168188-14-baolu.lu@linux.intel.com>

On Wed, Dec 20, 2023 at 09:23:31AM +0800, Lu Baolu wrote:
> -int iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
> +void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
>  {
> -	int ret = 0;
>  	struct iopf_fault *iopf, *next;
> +	struct iommu_page_response resp;
>  	struct dev_iommu *param = dev->iommu;
>  	struct iommu_fault_param *fault_param;
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>  
>  	mutex_lock(&queue->lock);
>  	mutex_lock(&param->lock);
>  	fault_param = rcu_dereference_check(param->fault_param,
>  					    lockdep_is_held(&param->lock));
> -	if (!fault_param) {
> -		ret = -ENODEV;
> -		goto unlock;
> -	}
> -
> -	if (fault_param->queue != queue) {
> -		ret = -EINVAL;
> -		goto unlock;
> -	}
>  
> -	if (!list_empty(&fault_param->faults)) {
> -		ret = -EBUSY;
> +	if (WARN_ON(!fault_param || fault_param->queue != queue))
>  		goto unlock;
> -	}
> -
> -	list_del(&fault_param->queue_list);
>  
> -	/* Just in case some faults are still stuck */
> +	mutex_lock(&fault_param->lock);
>  	list_for_each_entry_safe(iopf, next, &fault_param->partial, list)
>  		kfree(iopf);
>  
> +	list_for_each_entry_safe(iopf, next, &fault_param->faults, list) {
> +		memset(&resp, 0, sizeof(struct iommu_page_response));
> +		resp.pasid = iopf->fault.prm.pasid;
> +		resp.grpid = iopf->fault.prm.grpid;
> +		resp.code = IOMMU_PAGE_RESP_INVALID;

I would probably move the resp and iopf variables into here:

		struct iopf_fault *iopf = &group->last_fault;
		struct iommu_page_response resp = {
			.pasid = iopf->fault.prm.pasid,
			.grpid = iopf->fault.prm.grpid,
			.code = IOMMU_PAGE_RESP_INVALID
		};

(and call the other one partial_iopf)

But this looks fine either way

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
