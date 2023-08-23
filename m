Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D2FAD42
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 15:28:15 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-68a3236a414so3487418b3a.0
        for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692804495; x=1693409295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKivbGvCmRtHg5RnZaeK6yphfVaSke4gUnvxGVeBTG8=;
        b=Eg9gbWVK6xyNZsElaWVjLKr2DSSEuPwJ+/pdGEnE7xHlV0zNTkutVybL9yOPIPR+92
         c2wTOEK+lhDbmd/LPxpAaJ+5l1zddvmBwMZ7rjNfv0hQE4yHiXYPIDyaqUKolKJ7BqDB
         yB2Z3jkDDELMXmP5L9n4EzhQ8M3vMtkWuVgYaqXoltyl+scjLmravbG+97UuCUGcQRQ7
         Do1BeKp/vqFhpmGkwy/+1Jiloisr9xNy9MZOS+EZzvKA5Kc6wOo74ZVb/Ia0O8ZJL6tk
         KPwRK8T2tFjhuWoPU5B2e+/P4Z0gqEz6qc8LrbhP4WbWrBimRRkmCsG1b/0HcXpQxnSY
         +xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692804495; x=1693409295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKivbGvCmRtHg5RnZaeK6yphfVaSke4gUnvxGVeBTG8=;
        b=He/eD/KybhckY2i06aRCrLgUuf7KH162HDnu9VH1h87aO5lnJw3sf5Myb/h+jkbwVt
         YhYyL7UGLnTGhMZptmVsTvn2Rzx+2HbrPJU1wCC6gJtfFV7pSd/slhvAyTggdXLb0KoC
         JV/EXSWGoe52Kd2fQVFFhZkeYdxna1zt790TKWsxS2O5L9GEOb4b+DoCizuNpQP2oxH5
         +rgs4SeNpKgfjrkeGTmH+FAA8YbocHr2MnXpzRCjphcsPv9uwAsLF7MVJDlwBVtmsTBa
         HxvFNQiW59+zM0Ed2Tan0Rd4WlKgNP2WtmHm9EVGZYQ3drDi6yuLrtGx1vWIFo5ZueG4
         0shg==
X-Gm-Message-State: AOJu0Yz/ahGqbAjJP+gO0wQXquBma7CDwcYLA86ZpIJWzXT2BTTciUBf
	5wJLwidD7IFbujgCPoC0yw/TwQ==
X-Google-Smtp-Source: AGHT+IELeZR8Y6rsYg8CaCvJ/YLIFt2M6GjmjUpRplHjqMNTUtlisPMaIy1oU6V6+YuAnpC7Kk6Ycw==
X-Received: by 2002:a17:90b:e97:b0:268:34b1:a5a9 with SMTP id fv23-20020a17090b0e9700b0026834b1a5a9mr12316278pjb.8.1692804495388;
        Wed, 23 Aug 2023 08:28:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090a2a0c00b00260a5ecd273sm10562054pjd.1.2023.08.23.08.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 08:28:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qYpmH-00HTIA-7c;
	Wed, 23 Aug 2023 12:28:13 -0300
Date: Wed, 23 Aug 2023 12:28:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH RESEND 04/10] iommu/amd: Add support to enable/disable
 SVA feature
Message-ID: <ZOYljfDOgbzVeBeX@ziepe.ca>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-5-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823140415.729050-5-vasant.hegde@amd.com>

On Wed, Aug 23, 2023 at 02:04:09PM +0000, Vasant Hegde wrote:

> +int amd_iommu_sva_enable(struct device *dev)
> +{
> +	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +
> +	if (!pdev || !iommu || !dev_data)
> +		return -EINVAL;
> +
> +	if (!amd_iommu_sva_supported())
> +		return -ENODEV;
> +
> +	if (!dev_data->pasid_enabled)
> +		return -EINVAL;
> +
> +	return amd_iommu_sva_gcr3_init(dev_data, dev->iommu->max_pasids);
> +}
> +
> +int amd_iommu_sva_disable(struct device *dev)
> +{
> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +
> +	if (!iommu || !dev_data)
> +		return -EINVAL;
> +
> +	return amd_iommu_sva_gcr3_uninit(dev_data);
> +}

I think these features are a mistake, you need to implement them for
now but I wouldn't touch the gcr3 table, and disable should be a NOP.

gcr3 touching and enforcing should be part of generic PASID code and
be triggered naturally when the SVA domain is attached to a PASID.

Jason
