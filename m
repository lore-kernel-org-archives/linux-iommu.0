Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790CA15444A
	for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763698; cv=none; b=rbDk5kW6ZelAs07qcnJIzSqTV/zhJQOE2MOe2kYhdiBm8ePmdb81Pns/cK/zfWKMVrNGIrfG7SXYjhQKojX0BA4q5RkHg7gXz44cUmQU5FS4peESvM3S5wCxTfPV0pqpr+CLTMII2L9+ae1fDHxLmG8JWksZ8G/u+6hcU9OTr7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763698; c=relaxed/simple;
	bh=sBaAau9xEeJf8roh6msHFnyACVS56UGKbvbAsQ86sAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIOUy1lacP+1Jjeu58MfTKwzTHdqC0OiXS9QwAeItsPdcfXgtbRyLvMrMJnhcmEzXVJ94zxKXdi3NmL8O9vS54Lar/DyzPzFPoiA9kzBso42D5UL+HoPOzj9nhOVTp1PHRtrkHLVwp12fi8FF2FUeXdbOWKxbiiergRlr6p2aiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KsyaZhXg; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KsyaZhXg"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ea3855011fso159239a34.2
        for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712763695; x=1713368495; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i1uyVIcyqxPJmYh56tL6RiRYduMPkQf65GN7JkcsbVE=;
        b=KsyaZhXgBoQzBUiWDwPP1klHyhwe758DzemdYfpJvvnGhfFA7JPgQhFHF3HqHCpT2i
         8+iy1unImS9/3XiWWzOaYL2tLcyczMw/6U26hyILTQH+rcyZ1ruULIXnAdsFOJOQErfc
         ZyJV6jirA2Mx11XBnY2CQriC2Q0B2gMk26ndcpGWrh4p2wCCRVHYDiKFpinll3aSOn/f
         /QzeZc9ztys4gh19D4Rsw8WCWB9Y+XF4uMmuMAaNRxVfAOk5KK7kLHz2lV0qqLE9De/K
         I7PK5Rb1++L4CzQcJGOk7cdCxEWAtF85YT8Yo9F+74mLXqPYcT25ioEvpJn4CyXWLqvw
         i1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712763695; x=1713368495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1uyVIcyqxPJmYh56tL6RiRYduMPkQf65GN7JkcsbVE=;
        b=l2/KOydubkxe9EMkOHLTVEAsWKLrRRErMKpROkp/v1ZfnCDITcLLTOAitZkQ9TQybf
         KulrRCFrUncpLVvSkkKA9gAqvYJ3QpbIiRjfJRP0Knv5QWh591s5fZB/Cmd5urkJ9/oy
         /f/u7ZENpXL6uhz8qt9jbznwc/QWcwQENExPBH84a/8AZIHC6J7PNweZU6diMy8V26A5
         2GMBLzXZ2kCgQYI58klWejUdsPXdaK6yzwQtB5TijG8UF/DgxDxMHaSuAogESHUSowE+
         8pBlnLCwkTpIIgcAZa6b6fmrE/BrHY8m/YLCYj/Yq7TElaaECiwMKYA9oZOnPV8qrgat
         KWsw==
X-Forwarded-Encrypted: i=1; AJvYcCVV2xcHM6Qnn+dAzMvZbYJttdm0hUaHLYXRkS9S1u5fywxb9PIkd6D4r4E7XrWtOXtxmLh1Ue+84qpCyeyXNpdG/+odOJI=
X-Gm-Message-State: AOJu0Ywp2HkBtcvbC3Ynm45tFTXIPpqmHWLhZl5lyi+GWmwOPa2C8vg8
	zaSlaThUoTkNn/KAWwwG1uJLDqGKp1Rm6m6IrJn8WpwpBQwwwNaWRmt2ZB5oLcY=
X-Google-Smtp-Source: AGHT+IGjvgHPzlbtSke1df6CNZVMzhBHqQLj0GdDl9JuvwsX6FiQ77sduSoLZ+Gt//YtFRjLu30GfQ==
X-Received: by 2002:a9d:7415:0:b0:6ea:177b:f08b with SMTP id n21-20020a9d7415000000b006ea177bf08bmr3062635otk.36.1712763695506;
        Wed, 10 Apr 2024 08:41:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id u4-20020a0562140b0400b006990c05f0ccsm5171664qvj.110.2024.04.10.08.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:41:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rua4s-008Eh1-7t;
	Wed, 10 Apr 2024 12:41:34 -0300
Date: Wed, 10 Apr 2024 12:41:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
Message-ID: <20240410154134.GG223006@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325021705.249769-2-baolu.lu@linux.intel.com>

On Mon, Mar 25, 2024 at 10:16:54AM +0800, Lu Baolu wrote:
> Caching tag is a combination of tags used by the hardware to cache various
> translations. Whenever a mapping in a domain is changed, the IOMMU driver
> should invalidate the caches with the caching tags. The VT-d specification
> describes caching tags in section 6.2.1, Tagging of Cached Translations.
> 
> Add interface to assign caching tags to an IOMMU domain when attached to a
> RID or PASID, and unassign caching tags when a domain is detached from a
> RID or PASID. All caching tags are listed in the per-domain tag list and
> are protected by a dedicated lock.
> 
> In addition to the basic IOTLB and devTLB caching tag types, PARENT_IOTLB
> and PARENT_DEVTLB tag types are also introduced. These tags are used for
> caches that store translations for DMA accesses through a nested user
> domain. They are affected by changes to mappings in the parent domain.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h  |  25 +++++
>  drivers/iommu/intel/cache.c  | 192 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel/iommu.c  |  31 +++++-
>  drivers/iommu/intel/nested.c |  21 +++-
>  drivers/iommu/intel/svm.c    |  12 ++-
>  drivers/iommu/intel/Makefile |   2 +-
>  6 files changed, 274 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/iommu/intel/cache.c
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 404d2476a877..e3723b7a0b31 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -607,6 +607,9 @@ struct dmar_domain {
>  	struct list_head devices;	/* all devices' list */
>  	struct list_head dev_pasids;	/* all attached pasids */
>  
> +	spinlock_t cache_lock;		/* Protect the cache tag list */
> +	struct list_head cache_tags;	/* Cache tag list */

That is quite a neat trick - though building a dedicated invalidation
list duplicates data stored in the attached devices list?

You didn't try to make it RCU safe for invalidation?

> +struct cache_tag {
> +	struct list_head node;
> +	enum cache_tag_type type;
> +	struct intel_iommu *iommu;
> +	struct device *dev;

iommu and dev probably don't both need to be stored together. We have
iommu_get_iommu_dev() now.. I suppose this is probably a union of the
two pointers depending on tag. DEVTLB needs the dev and IOTLB needs
the iommu.

> +	u16 domain_id;
> +	ioasid_t pasid;
> +	int users;

unsigned int

> +static int __cache_tag_assign_parent_domain(struct dmar_domain *domain, u16 did,
> +					    struct device *dev, ioasid_t pasid)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	int ret;
> +
> +	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_TYPE_PARENT_IOTLB);
> +	if (ret || !info->ats_enabled)
> +		return ret;

I'm not sure I understood the point of PARENT_IOTLB? I didn't see any
different implementation?

Isn't this backwards though? Each domain should have a list of things
to invalidate if the domain itself changes.

So the nesting parent should have a list of CHILD_DEVTLB's that need
cleaning. That list is changed when the nesting domains are attached
to something.

And a list of CHILD_IOTLBs, but the HW doesn't seem to need that?

Jason
