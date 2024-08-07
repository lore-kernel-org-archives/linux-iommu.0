Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F61521373
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039697; cv=none; b=TzWEOlJS3zwJ5Xu3HF0lHOuSenViBuYsAvS6aXeI8rVv+LQ3z4QEMcjrPHzxcL1rXzoey6Vz9baBK3CGxIKFW5+2ES3kSErjPBlIanhFq+Jex6IER2dcrMD2oWzt9G0Du/uxgYGBwzW5C+/TeWPBSgKvUQZZRZux+8sKhGq8B4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039697; c=relaxed/simple;
	bh=Wm5X2pmatDZ8NRzqTemNgeLsBy6/XgA+9ER923XC4ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iF9x8FOZiUnCWkvL/i8Yq6GA+PeOXJpgynSE6QKwKMQK4Y2k/pyAHQYtV5fsM9iwtB5Tkvw+dav3QQlC4zXDY51bLbUiPJc8AtLUIsFFmPAudmct3FlFCcLw6YUmYPGjUN3o5Y8e+Nckqn9SY91wn2usyUkal1prgn8sAkdObkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P8FuzKlB; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P8FuzKlB"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79ef72bb8c8so53250185a.2
        for <iommu@lists.linux.dev>; Wed, 07 Aug 2024 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723039694; x=1723644494; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/doNaqve0RVimZoZhnlklc8gK3fdvMd7kWH/NbSTlak=;
        b=P8FuzKlBAjgfGSVduNHjMZexXoHaKrxh/U+rd2JYGiWCsO90r1ohuYup/7yRBrANKH
         oZ2aWD5gY+XUhRdEAzw3mHgNyNIgwyG27dYA31sw78nQ3NfEIaQchKh1qq29jGfT2SVS
         5rATuMCtm9srxMoM9/fU20RWWolShztNGfWRy2f4wo6NnBWsDyA5Y1UyI7jwfRr+0yBS
         TnYEtF3eyz4R4zgwM2rcSOm16l6XgbtPyMyi65tHFfG7fW8qY3zEfI2FSV8HIcYqW4As
         +H1jj5FUtcw6Rt6s3CflXdmlYOLbGjWvbu3d2AwRcwFHUF/qOe4hbM+H9drBazBLU4Eu
         SRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039694; x=1723644494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/doNaqve0RVimZoZhnlklc8gK3fdvMd7kWH/NbSTlak=;
        b=vxIPdSvDMYIeM2GGgitq91qgeJ79gIIyCXT/vXRNOlAUrcypQYdWhuD0fiK3eJCoD/
         wbDdwLlJTPog6frJDvxhOpdFOBvdYpbpgNex1C8sY6+5yMaBA9tYy3QX5k707C/vQa+Q
         bBZZfvbW1ZoEp3Qh37lH5V1cRUBEn6irPav8ZT8jtipq0WZ6az8izVg/N25KjIZS+qZD
         bfyu7/zTstn2WcAsmM+3IXSRK8BMG/RjkdHEPkwQYJPu9eHgQv+9wUCLLOzWd4wwlJDF
         H4zmS1tSrsigdJBKcbVEQQ03p19YQwvK6Oy4Zd9iGbkgDu9ZEETs+g35JofaJp9xA36+
         bpCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ5FJx4hCCdadY8XxhzRS3dkESoxy+OUQqNqmmQ77ffOSggppE77YE0ABVX+gVM5GTe/l+MKvMJyL8J3da0eXF2xiBlQM=
X-Gm-Message-State: AOJu0YyM5nnzoAne8hmBOsTDqyzqqQyfhaMBNixfWgFtbLLw3MJbSaDO
	mJJTbBPUMD9MJcqNr0tLqNe+V+CYnf/ZObvjn8vkXQDySCAr9hnLAwngdNypJWs=
X-Google-Smtp-Source: AGHT+IHBgXZZzFfbNMLo222gZPwlFYRgAZedKzFQUiG2Bw8tF1Z/I7Zf+UnLx86eOMX9UZ5/EKj6WQ==
X-Received: by 2002:a05:620a:4606:b0:79f:ed1:81c with SMTP id af79cd13be357-7a34efc0583mr2255012085a.55.1723039694269;
        Wed, 07 Aug 2024 07:08:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786e3cdfsm63962585a.128.2024.08.07.07.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:08:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbhC7-002By5-UW;
	Wed, 07 Aug 2024 10:59:15 -0300
Date: Wed, 7 Aug 2024 10:59:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Message-ID: <20240807135915.GF8473@ziepe.ca>
References: <20240801144523.11803-1-vasant.hegde@amd.com>
 <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>

On Wed, Aug 07, 2024 at 03:00:50PM +0530, Vasant Hegde wrote:
> 
> commit 312c2a99897937834f6a679b6f9956288e8c93de
> Author: Vasant Hegde <vasant.hegde@amd.com>
> Date:   Wed Aug 7 14:42:24 2024 +0530
> 
>     vfio: User iommu_ops->domain_alloc_user() to allocate IOMMU domain
> 
>     - Include uapi/linux/iommufd.h in vfio_iommu_type1.c so that we can use
>       HWPT flags.
>     - Move dev_iommu_ops() from iommu-priv.h to linux/iommu.h
> 
>     Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Yeah, this seems like a good start

> @@ -2134,8 +2135,14 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu
> *iommu,
>  static int vfio_iommu_domain_alloc(struct device *dev, void *data)
>  {
>  	struct iommu_domain **domain = data;
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	u32 flags = 0;
> +
> +	if (ops->domain_alloc_user)
> +		*domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
> +	else
> +		*domain = iommu_paging_domain_alloc(dev);

I suggest to wrapper this in a EXPORT_SYMBOL rather than expose
dev_iommu_ops ?

> @@ -359,11 +359,14 @@ struct iommu_vfio_ioas {
>   *                                   enforced on device attachment
>   * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
>   *                             valid.
> + * @IOMMU_HWPT_ALLOC_PASID : If set, allocate a HWPT that support PASID
> + *
>   */

Needs more words, maybe even two flags?

 @IOMMU_HWPT_ALLOC_DEV_PASID: When the domain is used on a device,
 with no PASID, the device will support later attaching a PASID as
 well. Some HW requires a specific domain format on the device to
 allow PASID to work.

 @IOMMU_HWPT_ALLOC_PASID: The domain can be used as a PASID. The
 domain attached to the device must have also been allocated with
 IOMMU_HWPT_ALLOC_DEV_PASID.

And then we'd want to enforce this rule in iommufd to force userspace
to use the flags properly. Otherwise AMD will be permanently broken :\

I'm guessing that userspace will never want to share a PASID domain
and a device domain, and current iommu HW will treat both flags as the
same functionality (use the AMD v2 domain)

Yi will need to accomodate these flags in his series..

SMMUv3 support would look like this:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9bc50bded5af72..c2e46a352d6b09 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3052,7 +3052,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
                           const struct iommu_user_data *user_data)
 {
        struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-       const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+       const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+                                IOMMU_HWPT_ALLOC_DEV_PASID |
+                                IOMMU_HWPT_ALLOC_PASID;
        struct arm_smmu_domain *smmu_domain;
        int ret;
 
@@ -3065,6 +3067,14 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
        if (!smmu_domain)
                return ERR_PTR(-ENOMEM);
 
+       if (flags & (IOMMU_HWPT_ALLOC_DEV_PASID | IOMMU_HWPT_ALLOC_PASID)) {
+               if (!(master->smmu->features & ARM_SMMU_FEAT_TRANS_S1)) {
+                       ret = -EOPNOTSUPP;
+                       goto err_free;
+               }
+               smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
+       }
+
        smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
        smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
        ret = arm_smmu_domain_finalise(smmu_domain, master->smmu, flags);

(though this will clash with the nesting series I just sent)

Jason
