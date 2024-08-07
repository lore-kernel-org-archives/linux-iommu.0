Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B11C9DD0
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723033038; cv=none; b=E+Y2BoPIOoP+y1N8gtXXPFE/2CCYb9N/3JYcaEO86f0o7PNtnETLnGz/nUgmF499Z2aZCPDJiRF78OifxF7mNg/9UXQNUG2dBoXh7PYIE+u9Ckwbu/LO+AJG5eUtHBVLBD5a1mK2R2CV3x+m1pRj4UI9/IzMb/e2ZH+0Qf1encw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723033038; c=relaxed/simple;
	bh=FIlVj6Sse0FxgT4tPlHHo/z//Fy3UvwKu0v9S+ye0uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jw0z7Vfg5UMllentAKaMf3BLnnw1nsL2gRr1Hr4oJf8VEiXlvqf8wf4nMamW0UQ7ermr07ssT37GTvY3jqNDOpTQBar/zQVw4G2vhJd8wiSb5mD51YIPA6084pzLf60Zm55iOcET0oCHVIfRo0U9Y/q9IgnkJ63DSICH42H9L38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fIwDnEn1; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fIwDnEn1"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b791cddfcbso8939936d6.0
        for <iommu@lists.linux.dev>; Wed, 07 Aug 2024 05:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723033034; x=1723637834; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9aYfmnTgp8VccaVsoIgM6Nd0JM4AIFNu3GuM0vIyKg=;
        b=fIwDnEn1L0MNrLm6gYymhfX2dkcqYN3h9Dxs56EoJ/HCFK3lBb1ZDzWBQ39I0bpdSw
         xc51Z/c0G2OozaIgXt256eqVSSZmMYL+HDMJx5rw8FH1K+GVdVVx/Q5sBy9EMS82DSnl
         mbWx7eStCIHmtARFXP9Ivl2SMnytSh1urC0LgGDXTiSvJwcWyEg0WFcVzlRxYSZzaqrw
         Q6QbRS+J24xk9cMIdiogkGbhtTSTX+WrRqNMfoEZJP8ELIGq4UJB0QlNlolMEQZXblik
         mRxk1HRW/PZL9XbvnIRwAJfpdxsxXa1eNkq+mBtJ6MTHRTmKlxcX2dqk70woHeQAoe1f
         wy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723033034; x=1723637834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9aYfmnTgp8VccaVsoIgM6Nd0JM4AIFNu3GuM0vIyKg=;
        b=pU5E7tggBzLdMsWP/dnZwI5PnfM8oiQ70BQJZs09o/RORH7aIrcOos7Xl5WPUfdi0z
         1SEhLtgAVFXxoSvHZH5LES36QH+VCGTImXXE7+Drxctk18uL1HhFtuk9WuXh9GUkXorI
         Cxu0sU/UdcIiq0Hb+q9H6EdUgLgya95lZp9vdB7tHluKqmiJpweEx56PUgJQQe7Vmq+7
         zi8y6CDsKaboQe4/yjPbEozUCa4T+/UPaDIMB28NpUffXfZ19GgniQLKh6IjevVWobiE
         LBVjc+YVSEZ4WD8T6OIxxBDA/iLx3KMsYlw1neXh96miGn6VIby/yUMt0jh9KMj4zq7U
         tT6w==
X-Forwarded-Encrypted: i=1; AJvYcCVzIs3URx2SNI8/BDt0m/gH0yBqsje8fHSs/SdlArB2p5+pYtFdUOeFINejb5G6WZ2EnKrEi7TNWYfBSfTC9o0Q7SE8qwo=
X-Gm-Message-State: AOJu0YyRyirz7C7HZeoIjO+jmA3TAWLBn2BUKLpHc3wEVSEmXMqTdWq8
	f41O/OMNOUnxoaGozSf4ip7ZLG1VPRFWVCPKP6y3yASX4q9o0ASoz4rP3nUD/YQ=
X-Google-Smtp-Source: AGHT+IHhsaoe3pLaUBrbRcWvTT69L3kXjKkj4dSPaadCCQjbpgMTzV3yG93DN8+PNDKRYlUt15eyDQ==
X-Received: by 2002:a05:6214:5405:b0:6b5:d9ef:d576 with SMTP id 6a1803df08f44-6bb98379a5amr202476736d6.12.1723033033682;
        Wed, 07 Aug 2024 05:17:13 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c86baa8sm56066246d6.118.2024.08.07.05.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 05:17:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbfbM-001m4K-2a;
	Wed, 07 Aug 2024 09:17:12 -0300
Date: Wed, 7 Aug 2024 09:17:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] iommu/vt-d: Prepare for global static identity
 domain
Message-ID: <20240807121712.GD8473@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-5-baolu.lu@linux.intel.com>
 <20240806171236.GM676757@ziepe.ca>
 <9aa9e93e-915e-4c6d-9adb-b7d5facdf3bc@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aa9e93e-915e-4c6d-9adb-b7d5facdf3bc@linux.intel.com>

On Wed, Aug 07, 2024 at 02:41:39PM +0800, Baolu Lu wrote:
> On 2024/8/7 1:12, Jason Gunthorpe wrote:
> > On Tue, Aug 06, 2024 at 10:39:38AM +0800, Lu Baolu wrote:
> > > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > > index c019fb3b3e78..f37c8c3cba3c 100644
> > > --- a/drivers/iommu/intel/iommu.c
> > > +++ b/drivers/iommu/intel/iommu.c
> > > @@ -1270,6 +1270,9 @@ void domain_update_iotlb(struct dmar_domain *domain)
> > >   	bool has_iotlb_device = false;
> > >   	unsigned long flags;
> > > +	if (!domain)
> > > +		return;
> > > +
> > This seems really strange, maybe wrong..
> > 
> > The only callers that could take advantage are
> > iommu_enable_pci_caps()/iommu_disable_pci_caps()
> 
> Yes.
> 
> When the PCI ATS status changes, the domain attached to the device
> should have its domain->has_iotlb_device flag updated.
> 
> The global static identity domain is a dummy domain without a
> corresponding dmar_domain structure. Consequently, the device's
> info->domain will be NULL. This is why a check is necessary.

I get it, but you can't have ATS turned on at all if you can push the
invalidations. So it seems like something is missing to enforce that
with the identity domains.

> > So I looked at this and, uh, who even reads domain->has_iotlb_device ?
> 
> The has_iotlb_device flag indicates whether a domain is attached to
> devices with ATS enabled. If a domain lacks this flag, no device TBLs
> need to be invalidated during unmap operations. This optimization avoids
> unnecessary looping through all attached devices.

Not any more, that was removed in commit 06792d067989 ("iommu/vt-d:
Cleanup use of iommu_flush_iotlb_psi()")

This compiles, so you should do this instead:

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ad81db026ab236..6549488d1f6bb1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -492,7 +492,6 @@ void domain_update_iommu_cap(struct dmar_domain *domain)
 		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
 
 	domain->domain.pgsize_bitmap |= domain_super_pgsize_bitmap(domain);
-	domain_update_iotlb(domain);
 }
 
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
@@ -1270,32 +1269,6 @@ domain_lookup_dev_info(struct dmar_domain *domain,
 	return NULL;
 }
 
-void domain_update_iotlb(struct dmar_domain *domain)
-{
-	struct dev_pasid_info *dev_pasid;
-	struct device_domain_info *info;
-	bool has_iotlb_device = false;
-	unsigned long flags;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_for_each_entry(info, &domain->devices, link) {
-		if (info->ats_enabled) {
-			has_iotlb_device = true;
-			break;
-		}
-	}
-
-	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
-		info = dev_iommu_priv_get(dev_pasid->dev);
-		if (info->ats_enabled) {
-			has_iotlb_device = true;
-			break;
-		}
-	}
-	domain->has_iotlb_device = has_iotlb_device;
-	spin_unlock_irqrestore(&domain->lock, flags);
-}
-
 /*
  * The extra devTLB flush quirk impacts those QAT devices with PCI device
  * IDs ranging from 0x4940 to 0x4943. It is exempted from risky_device()
@@ -1332,10 +1305,8 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 		info->pasid_enabled = 1;
 
 	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
-	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
+	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
 		info->ats_enabled = 1;
-		domain_update_iotlb(info->domain);
-	}
 }
 
 static void iommu_disable_pci_caps(struct device_domain_info *info)
@@ -1350,7 +1321,6 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
 	if (info->ats_enabled) {
 		pci_disable_ats(pdev);
 		info->ats_enabled = 0;
-		domain_update_iotlb(info->domain);
 	}
 
 	if (info->pasid_enabled) {
@@ -1524,7 +1494,6 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	domain->nid = NUMA_NO_NODE;
 	if (first_level_by_default(type))
 		domain->use_first_level = true;
-	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
 	INIT_LIST_HEAD(&domain->dev_pasids);
 	INIT_LIST_HEAD(&domain->cache_tags);
@@ -3622,7 +3591,6 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
 	xa_init(&domain->iommu_array);
 
 	domain->nid = dev_to_node(dev);
-	domain->has_iotlb_device = info->ats_enabled;
 	domain->use_first_level = first_stage;
 
 	/* calculate the address width */
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b67c14da12408b..e80aed3bc06e61 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -588,7 +588,6 @@ struct dmar_domain {
 	int	nid;			/* node id */
 	struct xarray iommu_array;	/* Attached IOMMU array */
 
-	u8 has_iotlb_device: 1;
 	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
 	u8 force_snooping : 1;		/* Create IOPTEs with snoop control */
 	u8 set_pte_snp:1;
