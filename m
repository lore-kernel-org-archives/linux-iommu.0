Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E6AC8C5
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 15:36:04 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3a7781225b4so3798342b6e.3
        for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 08:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692804963; x=1693409763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhIISOuNzj6uKgd2RwPdmIiiPIXsOaH4chNQd3+7Qsg=;
        b=f7fvwKPKAjt/csJO1SjQNsUhLFpWB2M/ajMaFOKSdCPLoVqB98A+ArSl9XQB+EDkvb
         CcbSzYDAoJFbnzvk7PQOTjjpF/CklrAaqJo2BRQRi0ck9U8ulwUqwWFS2vIRCakGiqa7
         7M7xVsMCaW8lYLDldwPrQVocE3LhVcQ7FLYd4I9ntdHNM7vqP30znAMjTilA92DZakav
         fS4/I/6c9JEUEI+CYSOPsYT9BZruZz3F8YxRiph2d8O4a4ri+pbyctZvjFVc41JKb7I1
         QBaj36yzkCYLup1JQ7r6vkvfXK90nNkXTVIWl+hClMFsFmAzHelpBziPiGF84pM/jYf9
         q6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692804963; x=1693409763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhIISOuNzj6uKgd2RwPdmIiiPIXsOaH4chNQd3+7Qsg=;
        b=i8Z7PiFBJKR6rLFnbdf9gQBpHcUJI5pG84aAi0lfV+Yn+fykZHZ7dLHKx3cE+/7psK
         YguR8NcCGKxxJb8oQPiQUCu0ZBKpXgFp+GASNw/sQE2HMXlKHqjZvIC68pb/PHvj8VZy
         hols1KQyPNG0pYrpzB6zVCbr4dXRMkCPRKOKnHg1u/At6HMIAaDw4TYruOktU0iYU8NQ
         AtPECZIc4P30wJFbutKfRiGPxe2geSk6dPs3sjMMswnIoRBUrCXRV20UlKH4bV3zlGMW
         Z4aXNqpnpuDHJi3j6XUZqqRLhz8eNGWPvi8D7GrZzQ9yw98xjWecUm00aGg40BMp8Jj0
         hj5w==
X-Gm-Message-State: AOJu0Yzz47qnTuYwfP9ilMddNlxlEqXAChKRgCNEPxF92yxvbBu7IllN
	VmyPj5/sVFWm0BUFZNr78qeDtw==
X-Google-Smtp-Source: AGHT+IH3ifUuzSMaFXi3fDXsvxcyPQgl7B8ph4889LVZbUqFzxoaA3WjB5Bm1K7dWDd+u9iJJpOoLQ==
X-Received: by 2002:a05:6808:5c9:b0:3a7:3ccd:2634 with SMTP id d9-20020a05680805c900b003a73ccd2634mr11869271oij.44.1692804963724;
        Wed, 23 Aug 2023 08:36:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id a24-20020a637058000000b0056c2843d80dsm5816935pgn.10.2023.08.23.08.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 08:36:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qYptq-00HTpm-2k;
	Wed, 23 Aug 2023 12:36:02 -0300
Date: Wed, 23 Aug 2023 12:36:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH RESEND 10/10] iommu/amd: Introduce logic to
 enable/disable IOPF
Message-ID: <ZOYnYrNjneEa2XVS@ziepe.ca>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-11-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823140415.729050-11-vasant.hegde@amd.com>

On Wed, Aug 23, 2023 at 02:04:15PM +0000, Vasant Hegde wrote:
> diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
> index db4fa4534cd6..8c197b768b4a 100644
> --- a/drivers/iommu/amd/ppr.c
> +++ b/drivers/iommu/amd/ppr.c
> @@ -9,6 +9,7 @@
>  #include <linux/amd-iommu.h>
>  #include <linux/delay.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/pci-ats.h>
>  
>  #include "amd_iommu.h"
>  #include "amd_iommu_types.h"
> @@ -319,3 +320,58 @@ int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev)
>  	raw_spin_unlock_irqrestore(&iommu->lock, flags);
>  	return ret;
>  }
> +
> +static int amd_iommu_iopf_update(struct device *dev, bool enable)
> +{
> +	unsigned long flags;
> +	int ret;
> +	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct protection_domain *pdom = amd_iommu_get_pdomain(dev);
> +
> +	if (!pdev || !iommu || !dev_data)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&pdom->lock, flags);
> +
> +	if (enable) {
> +		ret = amd_iommu_iopf_add_device(iommu, dev);
> +		if (ret)
> +			goto out;
> +
> +		dev_data->ppr = true;
> +	} else {
> +		ret = amd_iommu_iopf_remove_device(iommu, dev);
> +		dev_data->ppr = false;
> +	}
> +
> +	amd_iommu_domain_update(pdom);
> +
> +out:
> +	spin_unlock_irqrestore(&pdom->lock, flags);
> +	return ret;
> +}
> +
> +int amd_iommu_iopf_enable(struct device *dev)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +
> +	if (!(dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP))
> +		return -ENODEV;
> +
> +	if (!dev_data->ats_enabled || !dev_data->pri_enabled)
> +		return -EINVAL;
> +
> +	return amd_iommu_iopf_update(dev, true);
> +}
> +
> +int amd_iommu_iopf_disable(struct device *dev)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +
> +	if (!dev_data->pri_enabled)
> +		return -EINVAL;
> +
> +	return amd_iommu_iopf_update(dev, false);
> +}

These features also look like a mistake..

PRI is enabled if the domain has an iopf handler, when that domain is
attached to the RID/PASID.

It remains enabled so long as any IOPF enabled domain is present on
the device.

So again, these should be checks but otherwise NOPs and any actual
working has to be pushed into the domain attach code.

Jason
