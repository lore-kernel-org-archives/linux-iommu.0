Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5212D1E1DA
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 18:22:19 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-63fbfc0b817so5407496d6.1
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 11:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691691738; x=1692296538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcjxdJ9WmHxKNY6KosOB3TxKaZ6LfXZdDC4NFaJO6to=;
        b=BdW7UNRg9AT5/2egP81zRCWOkcMVXDUf1IoXVs7kpDi/lU81fRnympXyKF6K9B9cyK
         6WONDV4Q2c9S5P3f3uZL7pDa7/Q2FaJUlBMm2qWjgMdAbsBhFKKAc1YN12dpmy6iSYwA
         lITo7ZQfY77GJMyCh2VpHTHr3XCat9iB87Fvck0pK44glJm/A6tjCYggASebe6HJXUUv
         rlM4ZcRpnXmAM8T5Z/U2++n7YHKDm6qnqG83zFbHP1j0Fvi1RaYqNylfYUk5qAf5EHgj
         8Fj2MPAUyhE1e/0U2eG49MOoO1uX8fovF0M71I51V4rr87rgHR/0s8kdVhlPbcKll0ej
         jKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691691738; x=1692296538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcjxdJ9WmHxKNY6KosOB3TxKaZ6LfXZdDC4NFaJO6to=;
        b=lvyiEv1E3ekmPdAc80E011sV+pNJz0z4wpia6U7RcKDUeVn5G8KgJLL0xCR4SHUUnE
         4ZHE499dfHGMBYHsxi1ORaWOJGjVTLiti+UvtoVs0DYsvCYTtcSx6sYDfszp7Z4ikcJ3
         w6g4Ja35WUXr9yGCQ2Q/LpuA3EyYymu8443FZpsfS0j1tlrsVJO2uu9JbwXX+g5/KZpA
         3Iq7kE7EWP567N6w7tijvS0QnlUgSTKMl6+S1Vie8q0d494D5+a18Y+g3qsX6/UHFRwT
         LITbCanvbn+FBQGbycG2yzFVyJ3avCHOiUxETCc63Z5o9EfrF6L9IkHHkBLCMex0svBl
         FZ+w==
X-Gm-Message-State: AOJu0YwiSJXtazddKQ5YxNGzV66ztDURtY/R8BdEnr6OjkNbfcvXTVMC
	wNTrMXSl3uIKzBW0QEz6gdImtw==
X-Google-Smtp-Source: AGHT+IHj7SJ/OqzVLjOSuCJ7oMR36+mlM3SPJmZN9QqQiO3KgmWZpdToIz8CpVW8DosUmgWCzhtI6Q==
X-Received: by 2002:a0c:c986:0:b0:63c:ed11:7bf0 with SMTP id b6-20020a0cc986000000b0063ced117bf0mr2923351qvk.6.1691691738065;
        Thu, 10 Aug 2023 11:22:18 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id r27-20020a0cb29b000000b0063cdcd5699csm665282qve.118.2023.08.10.11.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:22:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qUAIa-005HuO-83;
	Thu, 10 Aug 2023 15:22:16 -0300
Date: Thu, 10 Aug 2023 15:22:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/12] iommu: Replace device fault handler with
 iommu_queue_iopf()
Message-ID: <ZNUq2IcvjEkwQewc@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727054837.147050-5-baolu.lu@linux.intel.com>

On Thu, Jul 27, 2023 at 01:48:29PM +0800, Lu Baolu wrote:
> The individual iommu drivers report iommu faults by calling
> iommu_report_device_fault(), where a pre-registered device fault handler
> is called to route the fault to another fault handler installed on the
> corresponding iommu domain.
> 
> The pre-registered device fault handler is static and won't be dynamic
> as the fault handler is eventually per iommu domain. Replace calling
> device fault handler with iommu_queue_iopf().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4352a149a935..00309f66153b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1381,7 +1381,7 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
>  		mutex_unlock(&fparam->lock);
>  	}
>  
> -	ret = fparam->handler(&evt->fault, fparam->data);
> +	ret = iommu_queue_iopf(&evt->fault, dev);
>  	if (ret && evt_pending) {
>  		mutex_lock(&fparam->lock);
>  		list_del(&evt_pending->list);

I don't get it, why not remove fparam->handler/data entirely in this
patch? There is no user once you do this change?

Jason
