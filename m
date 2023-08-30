Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C026FB2
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 17:09:35 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bf48546ccfso31775235ad.2
        for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693415375; x=1694020175; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0u1/xGdFV0pX20ylHbVsmVK66kOO6EODJCkBCTTMjEc=;
        b=UrzmDhN0NE5qXTE7KKTOuaM5k8SMPCb5KBh685gsIXIVZ/TJat5DxC+J1FzgLeoEhY
         K76GLLODahH3fQp9pRmDhCkv23BQ9/QFlj/LgIGNywelfrjrXMmbm9WulTBfecvhvQSU
         NFxQYIA/KsOLy4otRECiP41WvKck5yQYdsdSrarSwN2Tabwes4XUDKHmjkeRVzKsOYCL
         dz6NSx+EQDbiycD5w3LqF6yne8yZHtkJ4EhDbHJoeRlXaVT9VjPO/z2WUgIo4+wYlP81
         il4v/5+x1/L7N3Jtz76OIY415Zh8Udq3GC18Mfw6NGK/rW7f6PBp0GtDfdPtOhuJxJq6
         RMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693415375; x=1694020175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0u1/xGdFV0pX20ylHbVsmVK66kOO6EODJCkBCTTMjEc=;
        b=KPo55cGdupE9Wa9KLzWGFU34qdS0YW2VHsvnItHdajAZXpvnY4L12pS5JgcDVkalnK
         C/8H+L6lj6SjDysgmRN7Cv0L4ztWZ31bQDUqopiPxNtAHZ1sjPO71wNNaGi0d/bte1P0
         1jtRMV+3w79fxYyuVJtvJf99/Df4/SKO5RodZo1bpLP6qTJML2jVGXn2wUlusfxLrF/a
         hJE8DvgQbV5z99h6w7rvA6Kl+VWF50Csw137UIvOb50bBR2O8qMZcjQWaG8cxmoOpMkg
         gGX4aI1cz4QesmRP02yLGo95tP4LpdFgJjZwdFFppzrr9GXkorVEfSkHrvMunMtDZv0U
         CmGA==
X-Gm-Message-State: AOJu0YyEXT1R3KryLEVwPh7H/Z1OPKl7Z/FwxHR+FIxYjxbQlZ609b7Z
	q7vOxLl9AfaC9Nn8Fn0qTBQd9A==
X-Google-Smtp-Source: AGHT+IF4S7hwEwBX/vyGSjKfXGjbfRjJM318jpYmbbHLyw+Y6jmd/wkqcIhkdM+34ZsTl8yrqMayfA==
X-Received: by 2002:a17:902:6b42:b0:1c0:a5c9:e05a with SMTP id g2-20020a1709026b4200b001c0a5c9e05amr2310085plt.43.1693415374681;
        Wed, 30 Aug 2023 10:09:34 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090330d200b001bbd1562e75sm11416237plc.55.2023.08.30.10.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 10:09:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qbOhA-00062T-5c;
	Wed, 30 Aug 2023 14:09:32 -0300
Date: Wed, 30 Aug 2023 14:09:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH RESEND 04/10] iommu/amd: Add support to enable/disable
 SVA feature
Message-ID: <ZO93zPITePX52FaE@ziepe.ca>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-5-vasant.hegde@amd.com>
 <ZOYljfDOgbzVeBeX@ziepe.ca>
 <cbf043cb-aa4e-ff00-5d13-7b09ceaf0986@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf043cb-aa4e-ff00-5d13-7b09ceaf0986@amd.com>

On Mon, Aug 28, 2023 at 04:15:45PM +0530, Vasant Hegde wrote:
> Jason,
> 
> 
> On 8/23/2023 8:58 PM, Jason Gunthorpe wrote:
> > On Wed, Aug 23, 2023 at 02:04:09PM +0000, Vasant Hegde wrote:
> > 
> >> +int amd_iommu_sva_enable(struct device *dev)
> >> +{
> >> +	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
> >> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
> >> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> >> +
> >> +	if (!pdev || !iommu || !dev_data)
> >> +		return -EINVAL;
> >> +
> >> +	if (!amd_iommu_sva_supported())
> >> +		return -ENODEV;
> >> +
> >> +	if (!dev_data->pasid_enabled)
> >> +		return -EINVAL;
> >> +
> >> +	return amd_iommu_sva_gcr3_init(dev_data, dev->iommu->max_pasids);
> >> +}
> >> +
> >> +int amd_iommu_sva_disable(struct device *dev)
> >> +{
> >> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
> >> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> >> +
> >> +	if (!iommu || !dev_data)
> >> +		return -EINVAL;
> >> +
> >> +	return amd_iommu_sva_gcr3_uninit(dev_data);
> >> +}
> > 
> > I think these features are a mistake, you need to implement them for
> > now but I wouldn't touch the gcr3 table, and disable should be a NOP.
> 
> We need to configure Device Table Entry when we enable/disable SVA.

The DTE should only be changed by bind/unbind of RID/PASID - it has
nothing to do with these APIs.

Again, start with enabling native PASID support for UNAMANGED v2
domains and your SVA will make alot more sense and be alot cleaner.

Jason
