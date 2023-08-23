Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D319FAD42
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 15:33:11 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-68a3582c04fso2557526b3a.1
        for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692804791; x=1693409591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WcaRGvkxMCqRfiGU85EVV2+aUOpxX7qtt23U4p+Uovk=;
        b=DLG1srCX8bvOrV5SkoKqWGZ+cKFASOwhgeEO301wf4w7DlwihhQsdFvexMzjgTYGc5
         vHIWdCRGUT+jot1eFmHk3/ZuMYll9J6bASZecV9vBHqUoKQAhBSXE/hEMI5hBvyZxtM1
         MGwwfKEvUYYWBv+GTGbL2tCiF9tXCMLa5ihkroZdrXkf4ng4hfZO4PpDsUioPYEN6n70
         LYH3XUoTDqpjYwyg8qJu1QnaufdXuEahrSuxUYl7vcJqSJchRHtdYPGeLropD9hBnObS
         +vRFwgEbZU0JPMbmYRQ7RTy6vZV90Ep59Xj4YA/OKtCSYPhcBuh/DeZhPO5LVJi7kp/k
         HNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692804791; x=1693409591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcaRGvkxMCqRfiGU85EVV2+aUOpxX7qtt23U4p+Uovk=;
        b=U/4Nb45Nt9Wc8wUatqTEYEoLFOpEJ4uuGeYqxxR8/uzw/bcIcwsX65LAQr0rxcYjaT
         buDYe9YIGEdpEWAUqYA8USexoHeFwdzOkQHnF5BLs+12D+oQf580YYt6hMzs6Csk+sxr
         kkT1N7oD041gcANIjwCJO3aRrUyP9exRWho85lO62U5b2D9ZEkvm2F1Mt/R1kI+Fj3rK
         943PLLbiU4Prcdj74b2JdaAyZyOo9Zh62cFJ0VHai017zSqakATaItnud6I4JgWucCzR
         kNzIgeQEGUSRhbsP7h4M4aa/Z8q0UkBskRVVpLJRYZJ7XQyId/q9+BtW3/SRxJJtbR8u
         qbKQ==
X-Gm-Message-State: AOJu0YwM/lekFn0ittwSyKWvWL29wP6Vs8zHd1V/vSrPlzAwo46GrBex
	8FGGCPghsEn0nK4eHcvQWz787w==
X-Google-Smtp-Source: AGHT+IGp4Xlqe5qmWlIQvZm+gVDFD+X6NRcrcfMSe92ZmAg+bp1S7PWA8SoSE0qw8c0/grpM9T2avA==
X-Received: by 2002:a05:6a21:47c7:b0:148:48de:f6ae with SMTP id as7-20020a056a2147c700b0014848def6aemr10066184pzc.32.1692804790947;
        Wed, 23 Aug 2023 08:33:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79251000000b006875493da20sm9588000pfp.3.2023.08.23.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 08:33:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qYpr3-00HTav-9s;
	Wed, 23 Aug 2023 12:33:09 -0300
Date: Wed, 23 Aug 2023 12:33:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH RESEND 08/10] iommu/amd: Add support for add/remove
 device for IOPF
Message-ID: <ZOYmtQiwsodtm/Eu@ziepe.ca>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-9-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823140415.729050-9-vasant.hegde@amd.com>

On Wed, Aug 23, 2023 at 02:04:13PM +0000, Vasant Hegde wrote:

> diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
> index 8cbcdb9c1669..2e5ca4847eda 100644
> --- a/drivers/iommu/amd/ppr.c
> +++ b/drivers/iommu/amd/ppr.c
> @@ -168,3 +168,53 @@ int amd_iommu_page_response(struct device *dev,
>  	return amd_iommu_complete_ppr(pdev, resp->pasid, resp->code,
>  				      resp->grpid);
>  }
> +
> +int amd_iommu_iopf_add_device(struct amd_iommu *iommu, struct device *dev)
> +{
> +	unsigned long flags;
> +	int ret = -EINVAL;
> +
> +	raw_spin_lock_irqsave(&iommu->lock, flags);
> +
> +	if (!iommu->iopf_queue)
> +		goto out;
> +
> +	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
> +	if (ret)
> +		goto out;
> +
> +	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
> +	if (ret)
> +		iopf_queue_remove_device(iommu->iopf_queue, dev);
> +
> +out:
> +	raw_spin_unlock_irqrestore(&iommu->lock, flags);
> +	return ret;
> +}

Please assume the iopf rework will arrive before your series:

https://lore.kernel.org/linux-iommu/20230817234047.195194-1-baolu.lu@linux.intel.com/

In the new arrangement the work queue to is used by the SVA code to
move the blocking handle_mm_fault out of the global page request
processing.

I would expect there to be one (unbound) work_queue for SVA, shared by
all SVA domains.

Jason
