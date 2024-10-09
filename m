Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6791718D623
	for <iommu@lists.linux.dev>; Wed,  9 Oct 2024 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476153; cv=none; b=mJ4oQ34gxwqVSby+Ng6EIfsRJscwuQT938g1LPjRMWJr7y2Tl5xuCU05c53NaGWnG3Nsb/LSTogYbPjvGIyqagtM79OuyRjmByBefJvbmCaA71UNBx7wxZWPXSJPoANmQxZCD+SY3tKJag4kXYXGzc+995lBJGm3chbfkG85zTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476153; c=relaxed/simple;
	bh=bQgPrB8mvU+ZVBUTVMTXl+7ThkKj9tOIGniYd2MzKQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnskK5FcgeHALSuftdvCZCU3sVKfyWmw6AjylYmvYW0isv/1/yeBKRmqzEdQBMw1C2cmrR+WcxuR0OZwXRCXMynLrgnHR+Wvp7ar5pEwWUAbfgXD0VuY2nHyzYvnXKg3ezb4E+gxG1VJy/0Lw1WCPCyTbfYP5HEfgjeoHpkVqEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RYJ2Gskr; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RYJ2Gskr"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbd1ae26a6so2387216d6.1
        for <iommu@lists.linux.dev>; Wed, 09 Oct 2024 05:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728476150; x=1729080950; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=//O4UssP3kPcriATbh1SUGw2BRvtAqceh8yy962RN9I=;
        b=RYJ2GskrVNfB9H6Sx96tcSMnG4Bp1ma6qAwLqVE5kSrvR3A/ydPxRIhuOCm7pZddgD
         8VJgLqtLtN/FiWzu6UT7w2tZ+YxffcFKsj497Y1B+QH8i+qNUNU+6IxRiNvdbDn/gXpG
         YuKfnEHXfHEMixxPK6RzDmDQfpy45mEbHA2+UsgLqeJ6r5ybQQyV3yK+DEc5eqp/AAX9
         bFX1BmIC69RvBVwKtUbaWd8QKApopJJcrGPxY13LHjJve+87K+wHpKS3QXCBIB2EItRM
         epGntEE7xOZ7FN6DNHQaHa2ZUIaGMCnCbqCwY90ejQ7GXfshz7dXspUoqvLApdN5OdcY
         FZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728476150; x=1729080950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//O4UssP3kPcriATbh1SUGw2BRvtAqceh8yy962RN9I=;
        b=IvUulJwLicSYF1J7QxlVMetujUXH1OjQs3V50k2SkBjhjpcvrLj8492Bkoa1woQ0fw
         4cYrlJFDYSJnLdBYwJdT2aU+78Ilzg3oUCTlXpiiDajlu5TqGQ07lPJCzU+yq5xK/WPS
         GSctdwjwUtgpULkI0FbS3BgLUBhM0rhmGRYhtIHqWzV6/oXePu2VqHhrjwGWhQAVVY5Q
         fdtUWdMYIGliJjmlgDy1TOwlUB9ZRfaBhVKJC4DueK+fMuDf/VT/0yGZiHtnUJrINVmB
         7pGy/2y9sbEun90vh8ECO8qQSw3cBdXZ5cs5RgZ5gnEm5sAeA5FWmFnACslKhG3IMUqm
         a0gw==
X-Forwarded-Encrypted: i=1; AJvYcCV+CnG0zv/vKzFkLhsDiupR3tM8PyR1MU7yADydevnJKdI7iYd1Z5HBoa5a01eW/eJj8P/9sQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUlkvFmy3DcAegAX5OeJUjGP/oZV5qcZMLU8amvtg4gAGlsKvZ
	7JRvWeLpzL4kOS5hFoDT0c3j/fiqFd/rSWLTSqCrnKQIPdndtPD9+CbG3ErRG7M=
X-Google-Smtp-Source: AGHT+IG+A6hOLbYKAbXVsJyotyTyNmuSQUw6mr433GY2JNkN91xRgKJl39mz9EIJ7K/ZRNh18dCsDw==
X-Received: by 2002:a0c:f412:0:b0:6cb:3c08:6a6a with SMTP id 6a1803df08f44-6cbc95d818emr32757716d6.49.1728476150204;
        Wed, 09 Oct 2024 05:15:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbd568a405sm979206d6.31.2024.10.09.05.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:15:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1syVbY-00BH27-UV;
	Wed, 09 Oct 2024 09:15:48 -0300
Date: Wed, 9 Oct 2024 09:15:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	kevin.tian@intel.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 0/8] iommu: Domain allocation enhancements
Message-ID: <20241009121548.GE762027@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <970c6058-9e02-4cf6-bcb9-cfb8afb4eac1@amd.com>
 <71d20ff3-0a85-4670-8559-70ca5e6543c0@linux.intel.com>
 <9d0101b4-af13-4bf6-94a5-43a79f4d9989@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d0101b4-af13-4bf6-94a5-43a79f4d9989@amd.com>

On Wed, Oct 09, 2024 at 03:23:16PM +0530, Vasant Hegde wrote:

> > This change might cause a functional regression when it comes to nested
> > translation. In nested translation mode, the user page table (e.g.,
> > created and managed by a guest VM for guest kernel DMA) must be in the
> > first-stage page table format. Then, it can be nested on a second-stage
> > page table managed by the host kernel.
> > 
> > Currently, the kernel automatically selects the page table formats. For
> > example, the Intel IOMMU driver always uses the first-stage page table
> > for guest kernel DMA. After this change, this assumption no longer holds
> > true. This means the kernel might use a second-stage page table for
> > guest kernel DMA, breaking nested translation.
> 
> Hmmm. I assumed after discussion in v1 series you are fine. Looks like I misread it?

It is a bug in the implementation in the intel driver.

intel_iommu_domain_alloc_user() should always allocate a page table
that works, if you are in a guest context it must allocate a first
level/guest page table otherwise nested VFIO will be broken.

For this reason Intel driver should always allocate the guest
compatible page table unless IOMMU_HWPT_ALLOC_NEST_PARENT is
specified.

Something like this:

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9f6b0780f2ef5e..cfae6c2973e0ee 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1440,7 +1440,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
  * Check and return whether first level is used by default for
  * DMA translation.
  */
-static bool first_level_by_default(unsigned int type)
+static bool first_level_by_default(void)
 {
 	/* Only SL is available in legacy mode */
 	if (!scalable_mode_support())
@@ -1450,8 +1450,8 @@ static bool first_level_by_default(unsigned int type)
 	if (intel_cap_flts_sanity() ^ intel_cap_slts_sanity())
 		return intel_cap_flts_sanity();
 
-	/* Both levels are available, decide it based on domain type */
-	return type != IOMMU_DOMAIN_UNMANAGED;
+	/* Both levels are available, use FL */
+	return true;
 }
 
 static struct dmar_domain *alloc_domain(unsigned int type)
@@ -1463,7 +1463,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 		return NULL;
 
 	domain->nid = NUMA_NO_NODE;
-	if (first_level_by_default(type))
+	if (first_level_by_default())
 		domain->use_first_level = true;
 	INIT_LIST_HEAD(&domain->devices);
 	INIT_LIST_HEAD(&domain->dev_pasids);
@@ -3287,8 +3287,7 @@ int __init intel_iommu_init(void)
 		 * is likely to be much lower than the overhead of synchronizing
 		 * the virtual and physical IOMMU page-tables.
 		 */
-		if (cap_caching_mode(iommu->cap) &&
-		    !first_level_by_default(IOMMU_DOMAIN_DMA)) {
+		if (cap_caching_mode(iommu->cap) && !first_level_by_default()) {
 			pr_info_once("IOMMU batching disallowed due to virtualization\n");
 			iommu_set_dma_strict();
 		}
@@ -3530,6 +3529,7 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	struct intel_iommu *iommu = info->iommu;
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
+	bool first_level;
 
 	/* Must be NESTING domain */
 	if (parent) {
@@ -3541,13 +3541,18 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	if (flags &
 	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
 		return ERR_PTR(-EOPNOTSUPP);
+	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !intel_cap_slts_sanity())
+		return ERR_PTR(-EOPNOTSUPP);
 	if (nested_parent && !nested_supported(iommu))
 		return ERR_PTR(-EOPNOTSUPP);
 	if (user_data || (dirty_tracking && !ssads_supported(iommu)))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	/* Do not use first stage for user domain translation. */
-	dmar_domain = paging_domain_alloc(dev, false);
+	if (flags & IOMMU_HWPT_ALLOC_NEST_PARENT)
+		first_level = false;
+	else
+		first_level = first_level_by_default();
+	dmar_domain = paging_domain_alloc(dev, first_level);
 	if (IS_ERR(dmar_domain))
 		return ERR_CAST(dmar_domain);
 	domain = &dmar_domain->domain;
