Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360F43B184
	for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EaJ6kDIW"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59091e4a0f9so1115798eaf.1
        for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 07:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702308297; x=1702913097; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3xtaErerlt4nlnnOzSlabRBtDSO5G3MlJlaHfuuRQ8=;
        b=EaJ6kDIWOJAhdnvLrpDN72ppBv4jolGoHoeWD8REYQBX4CWL7O3d32rODMD0d+DqUj
         fepFzRxAEKetf9OjQDZcck80eLKUFpWiT8Upc0iWaFtfDnU+I88JbdFSCN6ZIQxDmIvj
         1RG1RMgwF8vhnd8cuA5Xktis3wWOB5V9XW2JxRzXg5raek8f5t7HmaRSeUxNZPIOTiNR
         aXcuVL9YwQVvRUUdgT9hHYzFApxmbHW/YiGxaP2K2G1cHH13B+/vfryPE1YjLz4duDjb
         9ROdXXtLYKPnuCRRNP0NZjsus/4dSPRt9PDbCf1i+VjUllUqQlmwDcm1iG9t679Gtzve
         T3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308297; x=1702913097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3xtaErerlt4nlnnOzSlabRBtDSO5G3MlJlaHfuuRQ8=;
        b=VY+mEKUqeJFPUG/cGkTbG6sBuZq7TjClHbL4IwnAsKg3VqNGKVE13mN7m8rAE/4Wgm
         +KEy1skOuHJ7tGp7LLjnoNklS/q/abD06HS3jE84qPwlu00AH+rr8kX2NOfvw9D2nZxC
         TllxRSghLPp3xc2NJzLeD8FfXaDcoLRy8JFLVuF37BDa6XAGQlp0/dTqdWI8/WkGO3OM
         6JaNqCew8S/lYweDiWtGXqvAeCA4jvwEaEcRK5KQM+fMj7d6EgBISHj8NdP1cyOvKM94
         QF59pOd6jpHEyUwOlWIU+EOkbPimZ70UJCGqCW3nJe3F7TXEC4qiFvShF23HJBT16grs
         9W4w==
X-Gm-Message-State: AOJu0YyroaqUV+uvuVmQN2g/qOBTjWkjyMXJzkhN73UiEvf5BL26nfVr
	sM8tsQQtrO6GF8OsWITJ6JuEjw==
X-Google-Smtp-Source: AGHT+IE0Zf78g8ypnJBYnHHcuYVxNHlZOXYBWbQ4OhuKwmXbnnnqqiXckwuMpS1xSNOWaCdBv28c9A==
X-Received: by 2002:a05:6359:628c:b0:170:17eb:2fc6 with SMTP id se12-20020a056359628c00b0017017eb2fc6mr834223rwb.63.1702308297235;
        Mon, 11 Dec 2023 07:24:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id t11-20020a056214154b00b0065b13180892sm3375747qvw.16.2023.12.11.07.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:24:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rCi9Q-00CcQj-Ag;
	Mon, 11 Dec 2023 11:24:56 -0400
Date: Mon, 11 Dec 2023 11:24:56 -0400
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
Subject: Re: [PATCH v8 12/12] iommu: Use refcount for fault data access
Message-ID: <20231211152456.GB1489931@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-13-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207064308.313316-13-baolu.lu@linux.intel.com>

On Thu, Dec 07, 2023 at 02:43:08PM +0800, Lu Baolu wrote:
> @@ -217,12 +250,9 @@ int iommu_page_response(struct device *dev,
>  	if (!ops->page_response)
>  		return -ENODEV;
>  
> -	mutex_lock(&param->lock);
> -	fault_param = param->fault_param;
> -	if (!fault_param) {
> -		mutex_unlock(&param->lock);
> +	fault_param = iopf_get_dev_fault_param(dev);
> +	if (!fault_param)
>  		return -EINVAL;
> -	}

The refcounting should work by passing around the fault_param object,
not re-obtaining it from the dev from a work.

The work should be locked to the iommu_fault_param that was active
when the work was launched.

When we get to iommu_page_response it does this:

	/* Only send response if there is a fault report pending */
	mutex_lock(&fault_param->lock);
	if (list_empty(&fault_param->faults)) {
		dev_warn_ratelimited(dev, "no pending PRQ, drop response\n");
		goto done_unlock;
	}

Which determines that the iommu_fault_param is stale and pending
free..

Also iopf_queue_remove_device() is messed up - it returns an error
code but nothing ever does anything with it :( Remove functions like
this should never fail.

Removal should be like I explained earlier:
 - Disable new PRI reception
 - Ack all outstanding PRQ to the device
 - Disable PRI on the device
 - Tear down the iopf infrastructure

So under this model if the iopf_queue_remove_device() has been called
it should be sort of a 'disassociate' action where fault_param is
still floating out there but iommu_page_response() does nothing.

IOW pass the refcount from the iommu_report_device_fault() down into
the fault handler, into the work and then into iommu_page_response()
which will ultimately put it back.

> @@ -282,22 +313,15 @@ EXPORT_SYMBOL_GPL(iommu_page_response);
>   */
>  int iopf_queue_flush_dev(struct device *dev)
>  {
> -	int ret = 0;
> -	struct iommu_fault_param *iopf_param;
> -	struct dev_iommu *param = dev->iommu;
> +	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
>  
> -	if (!param)
> +	if (!iopf_param)
>  		return -ENODEV;

And this also seems unnecessary, it is a bug to call this after
iopf_queue_remove_device() right? Just
rcu_derefernce(param->fault_param, true) and WARN_ON NULL.

Jason
