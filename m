Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F176F1591E1
	for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762772; cv=none; b=sbebRbsmhuYMMDTgRreJywv6zlZhUoXucWSoHc2E6CsS3qI+SWi0TuwILIq0zM371M2jGYki+cnTmq+hCegEjbvTUrAnkK4c83Nj/ieCdxaBilLoIIraSCb7me4KTM7lV4Eam/UpX4qaSPgaZOYmi+f0egVzuQEkwQOEYqPDXqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762772; c=relaxed/simple;
	bh=NjI5rFggc3aqQe0o+gfJSoRvtLTRJmexa+8r0p9Ntco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmfWNCSvm8bd9Gagdb08RAAHElNFfGrtgawWrFK5At6pfBk0VU1jjP+9WLRDgDahg9iTRcDy56oSjkiOuLvCBfyeF/CGxRE+4Ae0WjTfewYSEPIzVz3OmffaGSIqIj7tuP9LB8RkUAtxMXJERkt1PE0YZHXQgzawAfp6HpMk6XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VUWAr316; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VUWAr316"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78ebc7e1586so28431785a.1
        for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 08:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712762769; x=1713367569; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AYtRG8OSIBC59TZF+GDLNPNPrXRQAi2vj0OFPl1DVg8=;
        b=VUWAr316T8RYZirTzL0ZEQFQxwtAfi8LTtvTFqRc33YiXCMZwV+ogd6WANcWcX0QVj
         HyVPJ+rEQN0CB/UuUBx1Yzn9rup/FmL/+bPyKb/117mgtfT76g3ORoz6APO2o5Boimzw
         qm1AU3z5WDsDWvzxIINPY/bEZGHpsNNJnST9JbuCARmWtriKIkIT6j4TpnGQIK6vAhP1
         PSx59MkgiuFdxztPSOTvrZPAn+C7k26CVSSoWghrlu+/o/pvQP5c+P/M4gqJHGwPSK8S
         nrVc4Yaa0EweW7boVzzXKTQHVWmkmbAEMKGarTePGewDw1ylq6WW69CTYTktXxVJ648C
         CeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712762769; x=1713367569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYtRG8OSIBC59TZF+GDLNPNPrXRQAi2vj0OFPl1DVg8=;
        b=r3M7kmDoG50RM1rbS+jROPKXKqhIyRWE1FkoPQFsrXR9z4DWRV3O0ybJKTdJKWaXvH
         rms0kohaLsMh1nTrNEhzDym0syyRAzhNbFIA6zXtd7a9qfWqkbwOtM3XE345iVaEzBt1
         eHUjIgdW9P3kSj6fofSsfSyxVChiv0g2B+dL70MWTI0ICnPqFhBFqefWnMT4FpzwXe51
         sWxlTrWBGlzo9ZTX/RZq5SAmArI9kjyPJDBTe+OPGlGRgJTDBr7vBvs6v3ZMM554KT5U
         I5vB0gR9COocSUYBjkzxS0SqHnJ8JDJ3BXHApDfr1pofVzhwE5qgG+SypoFchQGB6lbU
         FbjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUntqqYHMaANOtQ2Iz1qHCRMmmXkjQ/tCzblqNXerXfjXGdYUJY6DbUc0rh81wCEinu6G2AxWIET12u9/LdMOOJv+uBFr0=
X-Gm-Message-State: AOJu0YwO4OcyYokZBBOP03C/Ph7/QedMg5ZIlgPNtfhWkJtsK1nNmWLp
	GY+4DxgZ0rVmXbiIVAzUWRst/lecSEXGrmn5S5A6NI51implYOBxUnwYmLMWpFI=
X-Google-Smtp-Source: AGHT+IGLypAGDe3QxT1cY2n+wr00FUlMz9BvHKaU5Fchaycn6bNlZiKi4cPrlNk7kg+txx8meLFuYA==
X-Received: by 2002:a05:620a:469f:b0:78e:9715:7dc5 with SMTP id bq31-20020a05620a469f00b0078e97157dc5mr2575426qkb.23.1712762768726;
        Wed, 10 Apr 2024 08:26:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id a16-20020a05620a16d000b0078d6349aa03sm3525474qkn.103.2024.04.10.08.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:26:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ruZpu-008Dhh-VX;
	Wed, 10 Apr 2024 12:26:06 -0300
Date: Wed, 10 Apr 2024 12:26:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Badger <ebadger@purestorage.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iommu: Add static iommu_ops->release_domain
Message-ID: <20240410152606.GF223006@ziepe.ca>
References: <20240305013305.204605-1-baolu.lu@linux.intel.com>
 <20240305013305.204605-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305013305.204605-2-baolu.lu@linux.intel.com>

On Tue, Mar 05, 2024 at 09:33:01AM +0800, Lu Baolu wrote:
> The current device_release callback for individual iommu drivers does the
> following:
> 
> 1) Silent IOMMU DMA translation: It detaches any existing domain from the
>    device and puts it into a blocking state (some drivers might use the
>    identity state).
> 2) Resource release: It releases resources allocated during the
>    device_probe callback and restores the device to its pre-probe state.
> 
> Step 1 is challenging for individual iommu drivers because each must check
> if a domain is already attached to the device. Additionally, if a deferred
> attach never occurred, the device_release should avoid modifying hardware
> configuration regardless of the reason for its call.
> 
> To simplify this process, introduce a static release_domain within the
> iommu_ops structure. It can be either a blocking or identity domain
> depending on the iommu hardware. The iommu core will decide whether to
> attach this domain before the device_release callback, eliminating the
> need for repetitive code in various drivers.
> 
> Consequently, the device_release callback can focus solely on the opposite
> operations of device_probe, including releasing all resources allocated
> during that callback.
> 
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>  include/linux/iommu.h |  1 +
>  drivers/iommu/iommu.c | 19 +++++++++++++++----
>  2 files changed, 16 insertions(+), 4 deletions(-)

I looked at all the drivers:
 1) Didn't spend time to guess what ipmmu-vmss is doing
 2) Several drivers are obviously missing the release_domain behavior
    and now be trivially fixed
 3) amd, s390, virtio-iommu and arm-smmu should probably support
    blocked_domain (I assume that is what their detach does)
 4) arm-smmuv3 can use it too once disable_bypass is removed
 5) Several drivers don't even have release_device functions.
    Probably all of them can do their identiy domains too.

This seems like a pretty reasonable thing to add to this series too:

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index eb1e62cd499a58..3ddc4b4418a049 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -979,6 +979,7 @@ static void apple_dart_get_resv_regions(struct device *dev,
 static const struct iommu_ops apple_dart_iommu_ops = {
 	.identity_domain = &apple_dart_identity_domain,
 	.blocked_domain = &apple_dart_blocked_domain,
+	.release_domain = &apple_dart_blocked_domain,
 	.domain_alloc_paging = apple_dart_domain_alloc_paging,
 	.probe_device = apple_dart_probe_device,
 	.release_device = apple_dart_release_device,
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index d98c9161948a25..902dc4da44f987 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1424,8 +1424,6 @@ static void exynos_iommu_release_device(struct device *dev)
 	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
 	struct sysmmu_drvdata *data;
 
-	WARN_ON(exynos_iommu_identity_attach(&exynos_identity_domain, dev));
-
 	list_for_each_entry(data, &owner->controllers, owner_node)
 		device_link_del(data->link);
 }
@@ -1471,6 +1469,7 @@ static int exynos_iommu_of_xlate(struct device *dev,
 
 static const struct iommu_ops exynos_iommu_ops = {
 	.identity_domain = &exynos_identity_domain,
+	.release_domain = &exynos_identity_domain,
 	.domain_alloc_paging = exynos_iommu_domain_alloc_paging,
 	.device_group = generic_device_group,
 	.probe_device = exynos_iommu_probe_device,
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b8c47f18bc2612..b5693041b18dd4 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1012,6 +1012,7 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
 
 static const struct iommu_ops mtk_iommu_ops = {
 	.identity_domain = &mtk_iommu_identity_domain,
+	.release_domain = &mtk_iommu_identity_domain,
 	.domain_alloc_paging = mtk_iommu_domain_alloc_paging,
 	.probe_device	= mtk_iommu_probe_device,
 	.release_device	= mtk_iommu_release_device,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index a9fa2a54dc9b39..9e7205af7d7316 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -580,6 +580,7 @@ static int mtk_iommu_v1_hw_init(const struct mtk_iommu_v1_data *data)
 
 static const struct iommu_ops mtk_iommu_v1_ops = {
 	.identity_domain = &mtk_iommu_v1_identity_domain,
+	.release_domain = &mtk_iommu_v1_identity_domain,
 	.domain_alloc_paging = mtk_iommu_v1_domain_alloc_paging,
 	.probe_device	= mtk_iommu_v1_probe_device,
 	.probe_finalize = mtk_iommu_v1_probe_finalize,
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index c9528065a59afa..c4c76aaec19e50 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1725,6 +1725,7 @@ static void omap_iommu_release_device(struct device *dev)
 
 static const struct iommu_ops omap_iommu_ops = {
 	.identity_domain = &omap_iommu_identity_domain,
+	.release_domain = &omap_iommu_identity_domain,
 	.domain_alloc_paging = omap_iommu_domain_alloc_paging,
 	.probe_device	= omap_iommu_probe_device,
 	.release_device	= omap_iommu_release_device,
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index da79d9f4cf6371..e551c5b143bbd3 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1162,6 +1162,7 @@ static int rk_iommu_of_xlate(struct device *dev,
 
 static const struct iommu_ops rk_iommu_ops = {
 	.identity_domain = &rk_identity_domain,
+	.release_domain = &rk_identity_domain,
 	.domain_alloc_paging = rk_iommu_domain_alloc_paging,
 	.probe_device = rk_iommu_probe_device,
 	.release_device = rk_iommu_release_device,

> +	if (!dev->iommu->attach_deferred && ops->release_domain)
> +		ops->release_domain->ops->attach_dev(ops->release_domain, dev);

We should probably be sensitive to the 
dev->iommu->require_direct flag - generally drivers should prefer the
blocked for the release domain, but in case the FW ias asking for
require_direct we need to switch to identity.

Also, may as well avoid switching a domain if the group is already
correct and use the common attach function to get the tracing.. So
like this?

	if (!dev->iommu->attach_deferred) {
		struct iommu_domain *release_domain = ops->release_domain;

		if (dev->iommu->require_direct && ops->identity_domain)
			release_domain = ops->identity_domain;

		if (release_domain && group->domain != release_domain)
			WARN_ON(__iommu_attach_device(release_domain, dev));
	}

Jason
