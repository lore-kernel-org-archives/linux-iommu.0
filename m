Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324BC6FA1
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 23:46:51 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-40a9918ec08so1577811cf.0
        for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 16:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693439211; x=1694044011; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIy4iKxg4IiVNC8CqNY1T4GbkGxa0vq7Q+S38R5flW0=;
        b=j5+eA7u2ns2bZOyc0jtKmKlwJ85KzbM1VelBKLkfuMn6XEkq6zVEpYdN4JC12l+4uo
         FuB2CZi2UaZvYXqlnOWo43EQ3GzxEJA1EVHafnzTK8XP02e4e9IzhzC4+lc9YyoaS+wX
         GTNoMkal+YW3E9mIgjQ5dNfr6kei8TPq3NuXmFeuIiSeHIAHMROTWd8fBxjB7LxBXrqu
         VTSvNupVYQmdCjrPm3iE5qjXO2I4K4k3qUk7N1euPyQLsyW50EB+SIvIe8m5MoPnA5ux
         cqpThiWiReM9BrN/07UlkT7slzT5wVBk9gLvzkfMMBeBUlINvtL3U34/z48ovzpU5oJj
         MXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693439211; x=1694044011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIy4iKxg4IiVNC8CqNY1T4GbkGxa0vq7Q+S38R5flW0=;
        b=SoW+wBJ/MNMWNwVCNYeMOvqCdncgyjCR7CNI90pT1Z/G52uWfibCXUwmfucDmvfneg
         QzVXSd4E5VdrceFarFYt7yuhMBtuBWDD2NRky/BENngRqkq1LJFpsgCwP0fExqyNGVIP
         to4M66A+fgaWaK69n/FKODojKFDf2NVZ1OsbFIDg49EGuVmzBPAaMbgu0cxAORZf67ej
         RQsQXnLWIwECzeCfgF2HYsvtLrKVEhQAasdj5xKrbdC0530IVpfEAbnfOonkf7Ixwgds
         8m6FTZPlwE3TOC29RWTCriWxSsxRwCO4a+p8ba+owNqIfAYiUAAnfBOcnvP1yEoMn6g/
         w0sQ==
X-Gm-Message-State: AOJu0YxxSf8GNkFoqXAzzheqVY11p5yBOj6b60xLxGPjyeaKyk7gA9ao
	Bjg8DOj+r8j7gTVNA5MYELRC3Q==
X-Google-Smtp-Source: AGHT+IE5zPb7kL4+li+kqZW9VL1RkCHK2twIBNk4sLTFKOgWIa6Cq3DbeHx9gOJNRWzWR+T6cvKc8A==
X-Received: by 2002:ac8:5fc3:0:b0:403:8d34:5254 with SMTP id k3-20020ac85fc3000000b004038d345254mr1064529qta.61.1693439210829;
        Wed, 30 Aug 2023 16:46:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id h7-20020ac87447000000b00403af2cf825sm70055qtr.34.2023.08.30.16.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:46:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qbUtd-000EHz-9c;
	Wed, 30 Aug 2023 20:46:49 -0300
Date: Wed, 30 Aug 2023 20:46:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH RESEND 04/10] iommu/amd: Add support to enable/disable
 SVA feature
Message-ID: <ZO/U6WfzSerXUaj7@ziepe.ca>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-5-vasant.hegde@amd.com>
 <ZOYljfDOgbzVeBeX@ziepe.ca>
 <cbf043cb-aa4e-ff00-5d13-7b09ceaf0986@amd.com>
 <ZO93zPITePX52FaE@ziepe.ca>
 <7f231d1c-30d8-d30c-8cc3-82179066909d@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f231d1c-30d8-d30c-8cc3-82179066909d@amd.com>

On Thu, Aug 31, 2023 at 12:30:21AM +0530, Vasant Hegde wrote:
> >>>> +int amd_iommu_sva_disable(struct device *dev)
> >>>> +{
> >>>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
> >>>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> >>>> +
> >>>> +	if (!iommu || !dev_data)
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	return amd_iommu_sva_gcr3_uninit(dev_data);
> >>>> +}
> >>>
> >>> I think these features are a mistake, you need to implement them for
> >>> now but I wouldn't touch the gcr3 table, and disable should be a NOP.
> >>
> >> We need to configure Device Table Entry when we enable/disable SVA.
> > 
> > The DTE should only be changed by bind/unbind of RID/PASID - it has
> > nothing to do with these APIs.
> 
> Above functions are called during enable_feature(SVA) path. Not in PASID
> bind/unbind path. In PASID bind/unbind path we just update PASID table.

I know, which is why they can't change anything about the IOMMU
HW. Only attach/bind/unbind should change HW state.

I intend to remove these APIs once ARM is fixed, so please don't start
to rely on them. The driver is doing something wrong if it is changing
HW setups outside of attach/bind/unbind.

These APIs are from an era before we had proper PASID API support and
no longer make sense.

> > Again, start with enabling native PASID support for UNAMANGED v2
> > domains and your SVA will make alot more sense and be alot cleaner.
> 
> Currently, the IOMMU_DOMAIN_UNMANAGED is used by VFIO, which sets up the v1
> table for GPA->SPA translation.

> If we were to force the unmanaged domain to use the v2 table by default, we
> would not be able to support nested translation, where it requires v1 table to
> be managed by the host ( GPA->SPA) and v2 in the guest (GVA->GPA).

I've said this so many times now

Upstream kernel does not support nested translation with VFIO. The
force v1 hack in the AMD driver *SHOULD NOT* be part of mainline.

I don't care about any unmerged out of tree patch sets that rely on it -
especially ones that ignored that the semi-upstream approved hack to do
this is VFIO_TYPE1_NESTING_IOMMU (which is also about to be removed),
not what you are talking about here.

iommufd has the upstream solution for this problem and it relies on
the iommufd user specifically asking for a nesting parent page table
which is the only signal that the AMD driver should use to force a v1
format on a PASID capable device.

Otherwise *all* requests for any kind of paging domain should use the
v2 if the device has PASID support.

Indeed after my other series is merged the AMD driver should be
converted to the alloc_domain_paging() interface that directly
prevents this abuse of the API.

Jason
