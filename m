Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1F2F41
	for <iommu@lists.linux.dev>; Fri, 10 Feb 2023 22:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676069054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8VZLwEZ0VhiWmW6aalUpiTNY5oCQlCmFrf7N1T4iZuc=;
	b=cgt/nRk9la+RvyddEagInq3UKLEkDd+OYfIYKq3t8udgrm3AOreQmGe2gt9b5M0Jt4iCVd
	2opA5nGnyLw/X933I7FR9q69UV6SFvGmkfcSXed7EF3SfkhaNRCiDXwCbsm1kix5Hv9Pbg
	sF/XB9myzbDyNTOMgWGKk9vFdLHThGY=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-166-KxWUwKDtPpGRjbJuCtw4wA-1; Fri, 10 Feb 2023 17:44:13 -0500
X-MC-Unique: KxWUwKDtPpGRjbJuCtw4wA-1
Received: by mail-il1-f197.google.com with SMTP id k13-20020a056e021a8d00b00313951035ccso5169623ilv.22
        for <iommu@lists.linux.dev>; Fri, 10 Feb 2023 14:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VZLwEZ0VhiWmW6aalUpiTNY5oCQlCmFrf7N1T4iZuc=;
        b=IW/TKGekoH4Ega7yfJdiCbqTTYnB5epuJqV0PwC/25I/VPdoS5OTxplpjpGFXpViBw
         ZI+1GKasEOzlYb6C5OllVx+sXQCqwyP7uIjsG1iqxXe2UnJ2MAqXrBBtFcXUXRI/vBCo
         hxlf/hcZjB/s3KQGOBj1Sj+3SQgacT0gkxIrIDWZeAyxcVbqS58iU/AKZx720ZEXx2YN
         9o4cEaZwruENzc/u8FBdbolJ+KV0yRmc2IFxuuhJGN0Zw0UPgsKr8ZtXhZcsExXkhN3W
         n+Fe07rWm+13Jfb2yWYo9LYyaeynrSzPhUtevAW7unjSYl94/K5tSJSlqowEpf8KI8AU
         Ak1w==
X-Gm-Message-State: AO0yUKVVdsh/GgAbAmiJy6MwkwGQsl5H0FHQvxYq6DZuNI4ZtmxNjrXC
	qWM65GN7i0UlGDIUS1T03yoPMM4MRHK2SX/loAheKQqXr2rEY0bWWSpltC5xPyzoEc1mBxaITS8
	Cvl9l8DNDczqKuo0=
X-Received: by 2002:a05:6602:2acd:b0:722:827d:e6ac with SMTP id m13-20020a0566022acd00b00722827de6acmr17507159iov.6.1676069052832;
        Fri, 10 Feb 2023 14:44:12 -0800 (PST)
X-Google-Smtp-Source: AK7set/pYb5EOh/Drz42V1PJ5+VKWj6WP/ITUzBus6W3/LeQWRmoejvgCP3pyCdxFAjIjZZ39ARC1A==
X-Received: by 2002:a05:6602:2acd:b0:722:827d:e6ac with SMTP id m13-20020a0566022acd00b00722827de6acmr17507122iov.6.1676069052584;
        Fri, 10 Feb 2023 14:44:12 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c11-20020a02a40b000000b003bf39936d1esm1666882jal.131.2023.02.10.14.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 14:44:11 -0800 (PST)
Date: Fri, 10 Feb 2023 15:44:10 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
 robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 baolu.lu@linux.intel.com
Subject: Re: [PATCH 2/6] iommu/vt-d: Implement hw_info for iommu capability
 query
Message-ID: <20230210154410.2b3b8296.alex.williamson@redhat.com>
In-Reply-To: <20230209041642.9346-3-yi.l.liu@intel.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
	<20230209041642.9346-3-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Feb 2023 20:16:38 -0800
Yi Liu <yi.l.liu@intel.com> wrote:

> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> To support nested translation in the userspace, it should check the
> underlying hardware information for the capabilities.
> 
> Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c  | 19 +++++++++++++++++++
>  drivers/iommu/intel/iommu.h  |  1 +
>  include/uapi/linux/iommufd.h | 21 +++++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 59df7e42fd53..929f600cc350 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4760,8 +4760,26 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>  	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>  }
>  
> +static void *intel_iommu_hw_info(struct device *dev, u32 *length)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu = info->iommu;
> +	struct iommu_device_info_vtd *vtd;
> +
> +	vtd = kzalloc(sizeof(*vtd), GFP_KERNEL);
> +	if (!vtd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	vtd->cap_reg = iommu->cap;
> +	vtd->ecap_reg = iommu->ecap;

Just a friendly reminder that these registers are already exposed to
userspace under /sys/class/iommu/ and each device has an iommu link
back to their iommu device there.  This series doesn't really stand on
its own without some discussion of why that interface is not sufficient
for this use case.  Thanks,

Alex

