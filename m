Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2EA1B269
	for <iommu@lists.linux.dev>; Mon, 18 Sep 2023 12:45:07 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6c0b3cea424so2844492a34.2
        for <iommu@lists.linux.dev>; Mon, 18 Sep 2023 05:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695041106; x=1695645906; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gPMeNDvJahMoxXGYIbQwqGTKNl0OC9Rs0fLHhpuWUk=;
        b=SCq62EZKBRByeX24OXYTUuxm48/sxp18jvm20rI1M57qmGVul8eN4Ckx4cCOhF7Uch
         98galp4jfLTFUGkq1eZIMc5vZ29x2uES39mfe/kFXJ4sjEJtKfHl+1ygnXwDIP3uaC5z
         HNsFzVmUM99q/cI1kozAvtZtkLQYwj1CIIDvLv0PNcKTZdGqJaYEIljXTCRuiXCPpPJA
         GFwnE7U4/v4ov+bhdw6xtOHjto9cB4PRG56eNL7fxsvNLFrKISNjurM2rIcZ2zgHiJUU
         h9GMtK9x6EKZv0S49Q8W3QnmVXJuXB9q1bO4B4CYU63JBr2swSYIbSorfgfAGSvKU8zt
         UYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695041106; x=1695645906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gPMeNDvJahMoxXGYIbQwqGTKNl0OC9Rs0fLHhpuWUk=;
        b=LIWci1Kna2bzYLLQhA/Z8nxQ9cJHvqG7hogD8ekaO4yV/e1QFUaGUU5ZmqCnZCkkDU
         bxlzFYe6IeFzEQVKq/261tLjvtJIj7ZM/UsUYgRbqqmKe30mbkLABCQ0QK2WiEnxymN4
         P2a+G1MKUbLvyhImzXcHQCzB+JfEnO3fs7E7SKzaF5j84ClbmuZq3zCVG8YxUmpp/R46
         oRU3i4vceXjcjuNdbrV+wq7vK/pxYcBuJi3keMUOjG4KX3tMsb9C/YmnFyIrbzQ8SeZw
         rpWpFFIrSHiQsBLPrhKrUF1oDzjxDwIkpHherTqdJiYO8he5p4xgp2Ugp+sthEwRxpFs
         IkoA==
X-Gm-Message-State: AOJu0YxXg5nG2HDXM4DfWTU8BBy4pAPmwuhICYiKoWZK1JJljxC+W/lX
	ixUcEO8Sg/sBsnJASmak/TWQqA==
X-Google-Smtp-Source: AGHT+IHomY1ShtEQBUplEfPXgMWPZq+cSTMn0KNGbIdAXUL1et3lJm3iluGpFz4BmvmKhDS0N765sg==
X-Received: by 2002:a05:6358:c22:b0:134:e777:c78b with SMTP id f34-20020a0563580c2200b00134e777c78bmr11747397rwj.5.1695041106597;
        Mon, 18 Sep 2023 05:45:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id a17-20020a0ce351000000b0064f53943626sm973742qvm.89.2023.09.18.05.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 05:45:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qiDcf-0004C2-H5;
	Mon, 18 Sep 2023 09:45:05 -0300
Date: Mon, 18 Sep 2023 09:45:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 11/11] iommu/amd: Introduce logic to enable/disable
 IOPF
Message-ID: <20230918124505.GC13795@ziepe.ca>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-12-vasant.hegde@amd.com>
 <ZQCSi6ROWVrIZEux@ziepe.ca>
 <57dfeefb-5a21-3e18-46f1-851de56a3037@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57dfeefb-5a21-3e18-46f1-851de56a3037@amd.com>

On Fri, Sep 15, 2023 at 01:56:54PM +0530, Vasant Hegde wrote:

> >> +static int amd_iommu_iopf_update(struct device *dev, bool enable)
> >> +{
> >> +	unsigned long flags;
> >> +	int ret;
> >> +	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
> >> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
> >> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> >> +	struct protection_domain *pdom = amd_iommu_get_pdomain(dev);
> >> +
> >> +	if (!pdev || !iommu || !dev_data)
> >> +		return -EINVAL;
> >> +
> >> +	spin_lock_irqsave(&pdom->lock, flags);
> >> +
> >> +	if (enable) {
> >> +		ret = amd_iommu_iopf_add_device(iommu, dev);
> >> +		if (ret)
> >> +			goto out;
> >> +
> >> +		dev_data->ppr = true;
> >> +	} else {
> >> +		ret = amd_iommu_iopf_remove_device(iommu, dev);
> >> +		dev_data->ppr = false;
> >> +	}
> >> +
> >> +	amd_iommu_domain_update(pdom);
> >> +
> >> +out:
> >> +	spin_unlock_irqrestore(&pdom->lock, flags);
> >> +	return ret;
> >> +}
> > 
> > Same remarks as for the SVA, this is in the wrong place.
> > 
> > iopf_queue_add_device() should be done when a PRI enabled domain is
> > attached to a device, not in feature things. I also want to remove
> > these too once ARM is fixed..
> 
> You mean we should do this during first device/pasid bind time?

Yes, when a PRI capable domain is first attached the PRI stuff should
be setup. SVA is a PRI capable domain type, but we will have more..

> > amd_iommu_get_pdomain() has improper locking, it needs to hold some
> > kind of dev_data lock to access dev_data->domain. (and really this
> > would all be clearer if it was just written dev_data->domain instead
> > of the redundant function)
> 
> It helps to get iommu from device structure. Its useful and we want to use it
> other places as well.

As I said, it seems obfuscating as to how the locking needs to work as
you must hold a lock while using dev_data->domain. In some cases that
can be the core code's group mutex, but that doesn't always work..

Jason
