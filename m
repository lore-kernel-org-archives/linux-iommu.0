Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC5919BB4
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 16:32:13 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4124e1909edso36485461cf.1
        for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694536333; x=1695141133; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htC+hW4XEwdC1kHNbpyEHGroFcchZC3k5a1wXMHon8Q=;
        b=Ff+ydghV7LXUTXcssJoM0znuocYqpDclhWFTpM5RZSg+BT5CvL+o/Po4qYWv/mPJbP
         yWNHsJbeBs0e2sBxHexN/rG1mMOT0qPHIBuhm8bnz+yImI/nyEuf4iKTHbdErTQHZN6W
         SrIQnxuKnvoAx6vcU/+vLHJ/Kt99nY1FrSocOPD0qNq+YKE3YVJszTcOsi1igJ0P+hru
         FpJau4ofN+WHwXgj6OwSZKQgFQMdFLaoUoJRCaII44leF619lRsEiUMsq9iw2vzRAwLn
         0qILw5Q2dYKoFQOn4ZKUu1COgBYxxBslCCwYFOmzk2H2OiBsGcdUa+TXev6XYSKJNdvv
         bs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694536333; x=1695141133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htC+hW4XEwdC1kHNbpyEHGroFcchZC3k5a1wXMHon8Q=;
        b=ik2DDBTKG5gQct80IssUBD2D9Xt58i9RZa0RVJYYYM4tPNXzhrps8+FRI8ncVFLbZQ
         guDFFzPIPvy6/hu0SQg2Bdw07BiaYcCGMWSXDbJ26IgfYbatk9P2uZ38BUeMe+8Zf9xk
         1wnLj+VahlTTnZggX4s2rjwC4vGklCR5b8MKOMNbVeaZSnGyBt+/F/z5REUb3GDNO/lh
         kiVt4cJRhr6gCpSn5bHFNM/VbflckbTzNuz1VltsVIo9midfWPmK7/iuqJWrPC0HDZA7
         W/KG+JGkD+0WQHQFzIZURw6B6bb7OijPeyRsJIvulTeyK5EG9ezLqWYzvfEphcpCHkt+
         QO0w==
X-Gm-Message-State: AOJu0Yw19oO9PceAWEWAdgEIqf9OF1TnBCDQ2UTAQOPKERVTfXI/tA+i
	VgyIoNlNBIB0RqVxQ2BR3zXf2A==
X-Google-Smtp-Source: AGHT+IFXgoroCV0ThPod+ysYao+NpHHyyHYMoW7IVn5ZNv6cK7cP4oIqdKV4gTJvnWj5PLKAZ09zLg==
X-Received: by 2002:a05:622a:2:b0:412:20b7:5941 with SMTP id x2-20020a05622a000200b0041220b75941mr15905469qtw.44.1694536333097;
        Tue, 12 Sep 2023 09:32:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id h5-20020ac87145000000b00407ffb2c24dsm3369353qtp.63.2023.09.12.09.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 09:32:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qg6J9-002FWM-EW;
	Tue, 12 Sep 2023 13:32:11 -0300
Date: Tue, 12 Sep 2023 13:32:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 11/11] iommu/amd: Introduce logic to enable/disable
 IOPF
Message-ID: <ZQCSi6ROWVrIZEux@ziepe.ca>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-12-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911121046.1025732-12-vasant.hegde@amd.com>

On Mon, Sep 11, 2023 at 12:10:46PM +0000, Vasant Hegde wrote:
> diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
> index 2891f67a6ca0..86c0cb836a71 100644
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
> @@ -306,3 +307,58 @@ int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev)
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

Same remarks as for the SVA, this is in the wrong place.

iopf_queue_add_device() should be done when a PRI enabled domain is
attached to a device, not in feature things. I also want to remove
these too once ARM is fixed..

And the iopf is a device wide thing, it makes no sense that some
random pdom->lock is protecting dev_dev->ppr..

amd_iommu_get_pdomain() has improper locking, it needs to hold some
kind of dev_data lock to access dev_data->domain. (and really this
would all be clearer if it was just written dev_data->domain instead
of the redundant function)

Jason
