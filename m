Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904C0371
	for <iommu@lists.linux.dev>; Mon, 25 Jul 2022 07:39:52 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so5826061wmj.1
        for <iommu@lists.linux.dev>; Mon, 25 Jul 2022 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e1aZ+o8kUOGYYPE2I8Uql3rIMOoNeVnZ6eovO9V2SYI=;
        b=e0kcc9cMVIDcngDRSTaZnB9OpBUCxX3qmlG7Rf8UF8KxVdSSsYTKRRoayVBXIw3Sng
         wu03r67IdDvHjuKRBxBG/MxS7zaI0Fo1WODf40DlybOy4RWF2zFeZBXFfeKyNY0k3tY0
         9acd2YlEjpByWP6lqxFmT8VFC6fWMD8ow89/760tUyLKH0o9qeiprvAj+2sNGlgZhJZI
         P/HxJLpuRxogFWVWPIjIQAFfo0PO7Gp9AJcrqgFGB0IZOyTnjDFWfH0tafCnnyRMGVx7
         qdcnwKIosMyB5F+UvM7GWAw6I/korbMgwAcezOoI6zLqC6A5RcxfoKxbs4WKBmEsKJwO
         BYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e1aZ+o8kUOGYYPE2I8Uql3rIMOoNeVnZ6eovO9V2SYI=;
        b=To/9yQv0tvmQ6GoHQz8s+paSS9n7MAhYIqy1V3PH4mBeddCK5jggcarnJf46J3visV
         EOxUs9FKcDo6WcEV/ZdKXyZDCBe+a9xMycNnlo3E07A5iDZMT7636xY0cvDi5n9DO4dm
         P8gU4PGd+++WSZDqAdWPoe/vwHbLq2wCXLZKrOgn9s7HzLjbm5iU+Iz55txcYb83djuZ
         0MeAbXa9o+5QF7HO+9+RoRvRAP4GqluvEHC3OJf/C9TJgy0qfwk4pDXIqSAVqA1ItmYm
         TV8rx67wJ/zzDfzc+X1HvKlVKwm6hWpgchwhLUcS9+GhWLfSZgR+0/bdF+XYaR+GpJoK
         Cv5w==
X-Gm-Message-State: AJIora9br7BCzkxlgI4ljx5KVYYpB+sXDk34P1nIvoAHF91hLU4pX1dw
	de5FOBdEVszWnzw5s4pCdd3x+w==
X-Google-Smtp-Source: AGRyM1v6drvIQaPtLI2eyqwiXdbwRxbi3X7EtVh03o9xVmLSg1+t1aTiJIzZGSIA3tAvrAovwl/Odw==
X-Received: by 2002:a05:600c:17c7:b0:3a3:f1:148c with SMTP id y7-20020a05600c17c700b003a300f1148cmr20833043wmo.32.1658734790751;
        Mon, 25 Jul 2022 00:39:50 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id f9-20020adfb609000000b0021e519eba9bsm11085090wre.42.2022.07.25.00.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 00:39:50 -0700 (PDT)
Date: Mon, 25 Jul 2022 08:39:23 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <Yt5IqyZw/Sa6Ck5t@myrica>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <20220723142650.GH79279@nvidia.com>
 <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>

On Sun, Jul 24, 2022 at 09:48:15PM +0800, Baolu Lu wrote:
> /*
>  * iommu_detach_device_pasid() - Detach the domain from pasid of device
>  * @domain: the iommu domain.
>  * @dev: the attached device.
>  * @pasid: the pasid of the device.
>  *
>  * The @domain must have been attached to @pasid of the @dev with
>  * iommu_detach_device_pasid().
>  */
> void iommu_detach_device_pasid(struct iommu_domain *domain, struct device
> *dev,
> 			       ioasid_t pasid)
> {
> 	struct iommu_group *group = iommu_group_get(dev);
> 	struct group_pasid *param;
> 
> 	mutex_lock(&group->mutex);
> 	domain->ops->set_dev_pasid(group->blocking_domain, dev, pasid);

Please also pass the old domain to this detach() function, so that the
IOMMU driver doesn't have to keep track of them internally.

In addition to clearing contexts, detach() also needs to invalidate TLBs,
and for that the SMMU driver needs to know the old ASID (!= PASID) that
was used by the context descriptor.

Thanks,
Jean


