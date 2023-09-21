Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B07816429
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 23:31:35 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1d66bf632bdso837866fac.2
        for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 16:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695339095; x=1695943895; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vRAHoKrBGfBYsWb1uVktJ9AcaRiuBBSufLkHTgcXpQ=;
        b=bylAN51b9i6M/yA+DeUBdgtRY8IuiejfPVjTk6Aw2EinaoNS1xE+pBgzbUe2zAt5Cx
         OhTt8R9SLecCjNdH7PKH9WtbBfXETaja/8IESHSceLz+v2gZczZcFux1x5Olvb2q1ISz
         j6rcktbM3Aby0s1vW0UdA2HkvRYWsnCV+rIzVOUMHZMQ+VVbfu2X+lvtjHjFBxHyBwA2
         HsAp2znjB7Z8XXUE4gUhO9oFaFqRUFH+7qDvQk54G8T75vlKMTf/CQs6/otf+G18ajGl
         5RJ1p3/zGtvthbUOJqjCdBkDhhsrMAKR+0TKyURsd3vkXSjxAisNnAFblCd0Q/sYB708
         Sqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695339095; x=1695943895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vRAHoKrBGfBYsWb1uVktJ9AcaRiuBBSufLkHTgcXpQ=;
        b=rHm1yDT6Dr8uJ07RbtzFBK5WF2NF8RUukol5Bj/rrehPUiAzl5JYVClTHWc5fQoJjJ
         oUNYgAqzz5WY9rOH3E+abQGGBl6mzE4VK6zPXQibfcX5lTDhJh6zIseYomeg5sAe/LU5
         JKTpyM8MpGHWURKHGHDWYWrn7svj4ZfkiyvRCP0r1GxT93HgVKqXhj9mh4qlyMu+iGTr
         wlyWXylKITr23Jux2szk7JxK0pIYlq64dQLG4GfjyNyi1MIjwo/+7xw4JTOZ1lPPmPZF
         46DBLALLgQ7r9gAcVOzBY2JZrnLndOQX9kkZCCFWq5eXX6zt/WLNS23U6ATJhvsRNhsG
         TvAg==
X-Gm-Message-State: AOJu0Yy4YwM3KseiOqhpRREeLczYFmcu/vJbz+B6dMVlCftkpqFXJtk5
	TxEeAAixtpv57vqwq4wwWvAvzg==
X-Google-Smtp-Source: AGHT+IHOp6xGDw4D0NmKC1EUFwovljdQRKwnyAsIoXdxF5prMSG6PeCqPtOlHL1IOsdsa4UK0fOIrg==
X-Received: by 2002:a05:6870:5622:b0:1d5:8f05:39da with SMTP id m34-20020a056870562200b001d58f0539damr7664576oao.25.1695339095164;
        Thu, 21 Sep 2023 16:31:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id mm5-20020a0562145e8500b006564afc5908sm294372qvb.111.2023.09.21.16.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 16:31:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qjT8v-000Us1-UF;
	Thu, 21 Sep 2023 20:31:33 -0300
Date: Thu, 21 Sep 2023 20:31:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] iommu: Support mm PASID 1:n with sva domains
Message-ID: <20230921233133.GB13795@ziepe.ca>
References: <20230912125936.722348-1-tina.zhang@intel.com>
 <20230912125936.722348-6-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912125936.722348-6-tina.zhang@intel.com>

On Tue, Sep 12, 2023 at 08:59:35PM +0800, Tina Zhang wrote:
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 0f956ecd0c9b..79779bbef653 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -15,6 +15,7 @@ static DEFINE_MUTEX(iommu_sva_lock);
>  static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
>  {
>  	ioasid_t pasid;
> +	struct iommu_mm_data *iommu_mm;
>  	int ret = 0;
>  
>  	if (!arch_pgtable_dma_compat(mm))
> @@ -28,12 +29,22 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
>  		goto out;
>  	}
>  
> +	iommu_mm = kzalloc(sizeof(struct iommu_mm_data), GFP_KERNEL);
> +	if (!iommu_mm) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>  	pasid = iommu_alloc_global_pasid(dev);
>  	if (pasid == IOMMU_PASID_INVALID) {
> +		kfree(iommu_mm);
>  		ret = -ENOSPC;
>  		goto out;
>  	}
> -	mm->pasid = pasid;
> +	iommu_mm->pasid = pasid;
> +	INIT_LIST_HEAD(&iommu_mm->sva_domains);
> +	mm->iommu_mm = iommu_mm;
> +
>  	ret = 0;
>  out:
>  	mutex_unlock(&iommu_sva_lock);
> @@ -73,16 +84,12 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>  
>  	mutex_lock(&iommu_sva_lock);
>  	/* Search for an existing domain. */
> -	domain = iommu_get_domain_for_dev_pasid(dev, mm_get_pasid(mm),
> -						IOMMU_DOMAIN_SVA);
> -	if (IS_ERR(domain)) {
> -		ret = PTR_ERR(domain);
> -		goto out_unlock;
> -	}
> -
> -	if (domain) {
> -		domain->users++;
> -		goto out;
> +	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
> +		ret = iommu_attach_device_pasid(domain, dev, mm_get_pasid(mm));
> +		if (!ret) {
> +			domain->users++;
> +			goto out;
> +		}
>  	}
>  
>  	/* Allocate a new domain and set it on device pasid. */
> @@ -96,6 +103,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>  	if (ret)
>  		goto out_free_domain;
>  	domain->users = 1;
> +	list_add(&domain->next, &mm->iommu_mm->sva_domains);
> +
>  out:
>  	mutex_unlock(&iommu_sva_lock);
>  	handle->dev = dev;
> @@ -128,8 +137,9 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>  	struct device *dev = handle->dev;
>  
>  	mutex_lock(&iommu_sva_lock);
> +	iommu_detach_device_pasid(domain, dev, pasid);
>  	if (--domain->users == 0) {
> -		iommu_detach_device_pasid(domain, dev, pasid);
> +		list_del(&domain->next);
>  		iommu_domain_free(domain);
>  	}
>  	mutex_unlock(&iommu_sva_lock);
> @@ -209,4 +219,5 @@ void mm_pasid_drop(struct mm_struct *mm)
>  		return;
>  
>  	iommu_free_global_pasid(mm_get_pasid(mm));
> +	kfree(mm->iommu_mm);
>  }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b9c9f14a95cc..c61bc45d5a82 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -109,6 +109,11 @@ struct iommu_domain {
>  		struct {	/* IOMMU_DOMAIN_SVA */
>  			struct mm_struct *mm;
>  			int users;
> +			/*
> +			 * Next iommu_domain in mm->iommu_mm->sva-domains list
> +			 * protected by iommu_sva_lock.
> +			 */
> +			struct list_head next;
>  		};
>  	};
>  };
> @@ -1186,17 +1191,13 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
>  }
>  
>  #ifdef CONFIG_IOMMU_SVA
> -static inline void mm_pasid_init(struct mm_struct *mm)
> -{
> -	mm->pasid = IOMMU_PASID_INVALID;
> -}
>  static inline bool mm_valid_pasid(struct mm_struct *mm)
>  {
> -	return mm->pasid != IOMMU_PASID_INVALID;
> +	return mm->iommu_mm ? true : false;
>  }

HUm this isn't locked very nicely.

Above do

smp_store_release(&mm->iommu_mm, iommu_mm);

And then do 

  return READ_ONCE(mm->iommu_mm)

(no need for ternaries with bools, compiler generates it automatically)


>  static inline u32 mm_get_pasid(struct mm_struct *mm)
>  {
> -	return mm->pasid;
> +	return mm->iommu_mm ? mm->iommu_mm->pasid : IOMMU_PASID_INVALID;
>  }

Then this should be

struct iommu_mm_data *iommu_mm = READ_ONCE(mm->iommu_mm);

if (!iommu_mm)
   return IOMMU_PASID_INVALID;
return iommu_mm->pasid;

Keeping in mind that the kfree(mm->iommu_mm) being placed in the
mm_drop is critical to this working safely.

Otherwise the logic looks OK.

Jason
