Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F642137D
	for <iommu@lists.linux.dev>; Fri,  1 Dec 2023 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cDDkcODd"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-41cc44736f2so14864621cf.3
        for <iommu@lists.linux.dev>; Fri, 01 Dec 2023 11:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701459964; x=1702064764; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U51b6DOvae7badw0cILrKOdmI7KPWtEKHdBIgXOpwAo=;
        b=cDDkcODd31Fu/ux36JAVIddJtq/viO2DgvI49ZeAjPxrk36MX5oAZa4stliQMEJ7GQ
         2UzqRQ5K2ujuES53lLTRcYfNcal2R3P62hJy2ISStARohzdz0NmKrILNvDCeM2sFzbOM
         h4nlu4oDWJmi83LQTWCmKoHAglHRTVH0HnMtKg6JQFxXgAAoxSj5vECbcsMWF4gnPT5L
         Hf89wk7Pc+FhcoryrxEPnw5AU+9n28+iKy1Od6qOQvj7V5gnb3J8NsCoRtYd3cN4cBFz
         1RE+pFIuRCZdoz+TRk1a98wwQID0QhvYjPGOnK7OB6DOJrQRVNI3KoJgz3bZzjyWIU9G
         fatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701459964; x=1702064764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U51b6DOvae7badw0cILrKOdmI7KPWtEKHdBIgXOpwAo=;
        b=aEq43Go0SCpj6r1jZjnqePeZbCuCVRbXhDEeyJPnu5dMSqPIr74fZ1rufVAwtoTkBK
         otO7iKbW6pM9fs1L7jzhGdnJWyZBBR4s6AjJSKy9iYaTzGe2oEufa7YNzSjExXjUmAj9
         L1H6HSqm6kT/8s46+e2H9VFXbMxQfODtdTryGo5N8i+mES3o6YgrTD4WW7iDGq2EbgdQ
         UWMMxEwgfKoSM5vC9v057YZcqBV5JDduobFiQMmOmaYdTiV2te18AzbSYdexo8N6NHuX
         7WPnLwaqjaqZuiH7AEuVkJtkFmoDratFSJsJ38z7AZvf0fIY5bOgG/ZB1fEp+ocWzMh8
         S7fA==
X-Gm-Message-State: AOJu0YzfSiezVA5DWSa4sLWpZLGxjkkNilO66l2yKn/dYl9rS0f+HT01
	P7b48f1EuJAJq353O3kGb0wiBQ==
X-Google-Smtp-Source: AGHT+IHJCuV3KvM+nqo/V6zkIZj2zDcpkiMw26vPVeayu5TilFxweaNcQBHSSoPH460XwQaorBXMvw==
X-Received: by 2002:ac8:5c02:0:b0:41e:3259:529a with SMTP id i2-20020ac85c02000000b0041e3259529amr39547qti.9.1701459963863;
        Fri, 01 Dec 2023 11:46:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id r21-20020ac85215000000b004181c32dcc3sm1743712qtn.16.2023.12.01.11.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 11:46:03 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r99Sc-006JuU-B4;
	Fri, 01 Dec 2023 15:46:02 -0400
Date: Fri, 1 Dec 2023 15:46:02 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 11/12] iommu: Consolidate per-device fault data
 management
Message-ID: <20231201194602.GF1489931@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-12-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115030226.16700-12-baolu.lu@linux.intel.com>

On Wed, Nov 15, 2023 at 11:02:25AM +0800, Lu Baolu wrote:

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d19031c1b0e6..c17d5979d70d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -597,6 +597,8 @@ struct iommu_device {
>  /**
>   * struct iommu_fault_param - per-device IOMMU fault data
>   * @lock: protect pending faults list
> + * @users: user counter to manage the lifetime of the data, this field
> + *         is protected by dev->iommu->lock.
>   * @dev: the device that owns this param
>   * @queue: IOPF queue
>   * @queue_list: index into queue->devices
> @@ -606,6 +608,7 @@ struct iommu_device {
>   */
>  struct iommu_fault_param {
>  	struct mutex lock;
> +	int users;

Use refcount_t for the debugging features

>  	struct device *dev;
>  	struct iopf_queue *queue;

But why do we need this to be refcounted? iopf_queue_remove_device()
is always called before we get to release? This struct isn't very big
so I'd just leave it allocated and free it during release?

> @@ -72,23 +115,14 @@ static int iommu_handle_iopf(struct iommu_fault *fault, struct device *dev)
>  	struct iopf_group *group;
>  	struct iopf_fault *iopf, *next;
>  	struct iommu_domain *domain = NULL;
> -	struct iommu_fault_param *iopf_param;
> -	struct dev_iommu *param = dev->iommu;
> +	struct iommu_fault_param *iopf_param = dev->iommu->fault_param;
>  
> -	lockdep_assert_held(&param->lock);
> +	lockdep_assert_held(&iopf_param->lock);

This patch seems like it is doing a few things, can the locking
changes be kept in their own patch?

Jason
