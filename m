Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1043149C7F
	for <iommu@lists.linux.dev>; Thu, 11 Apr 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712840884; cv=none; b=HSdODM5lXKXaLGkwG4vruIEev3D1uHQBlyOWuOYhzEZQhSkRQcGljz30+tzH4FDDReg7jbl40r5T68DkRWj33+9GTAHt2/L3mmhhQE6eUP8OF52o2uyG2atBQrMIfHZDfp77OI45WqNbfXHk7EzLsTgDhqhdRXzDrya+YfIFGDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712840884; c=relaxed/simple;
	bh=LmTO+KxDlHRhBPWCiz60VVAyqvQ0G4Y3rwwGGUqxSPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlmlxQXp1R6gpLPZZakAz2yWEa+vd5a1POw8Xyckz4OERu9A/mVjZx3q6G7N6QxbvweaqnJdDy6/KKpnN65iOJ4YbsZI52GaeNkzJSK02wGDB41lMWAM54fW5rF8R0HiYBQEj12UpeJ7eTQgyI/hGwnAU19f4MPMp58Nfue9vLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hhi7+jwP; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hhi7+jwP"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-69943ef42b2so38427126d6.3
        for <iommu@lists.linux.dev>; Thu, 11 Apr 2024 06:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712840881; x=1713445681; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZz8mg6eRHraKg0plKxBZ6VZYCeo2xoi8/P4hFIe9J8=;
        b=hhi7+jwPrFgyHyTzyFPeHo0r7VfV9WIqUrDxTWVjj3KugadN58ORCtfFsaIQ+koTOK
         kUwRAHBw7Bc5lLqBXqATW7+wRFwNE7Ua6oreCjaILsqLBHVvRyODgIXuiBd8tu0CisuO
         EEGQ/8uDrxG9K/9RGBP/lM6JMxbR8y2CElYa6MG/mfDC4r251iLJ6x/mHgd+IV/aBpQM
         NCqix6j2X7VYV5jZIfD5HJ1H9B+j5SEPO+asBOQ36SuBulupD23Ek0QZnZRTZPlc6YvW
         /fgw0YlCK/QUjs3VeAN9jJRBLj9S1LWI+dVWKV+qDR6ktPGNcQPDsUcnUP2M8/mlbk5a
         2jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712840881; x=1713445681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZz8mg6eRHraKg0plKxBZ6VZYCeo2xoi8/P4hFIe9J8=;
        b=KIQ+KQ2M5aroM/m0q2acw/9+7EhSUGpb3fTpdTrm/UPQppJHvOhTH1fBhEFoRg+uu2
         XJHESog7ZgA4au1fj321I3h+uBTeDxFq21lhPUIjB8fow7BZgMv0m3aUiNaOzs1acaKh
         KHu1X17FemnXju9bXBUUsmw7KCv9j+hmkeYmUkcXvDoFrfMD1OWLvcu95nGZFAOhPKQN
         HAc1q2aKrkZ9IXo8ajwPjvDBm76T3g60oA1aA6VuL9+nuium30IkkLvN1ARC2GthWSzX
         58DM7J3y2oCORvVUwfk4QNKhZlevSp4yVgzkv1sXbqw469JQB0aVSety9YjjdjdpVl4h
         f5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXWdTJhNTsqyq9nVgesWfJtw8ksQ27HE8kbdeHhntD2WsWQaGwO3bYxMEeSCF1dop+AkFDpj1dfPaalNyoF0UoMuoEzd7s=
X-Gm-Message-State: AOJu0YxRhI1FtwjjTx++z87DSYV//mlPKKMHjJH/3YF5skenXUseIfN5
	mOzd/E38k1MKCHb8NZbaWKkK7WkUURNwYZH9GXAudPA0Q2ssDOC8tm6EvHxcZBo=
X-Google-Smtp-Source: AGHT+IH4+qVUSOa2pmGIwOYUtFulDJSO4P5hIKc5/szMKl/OWfradbdDHKtYAcK9NUmzYNoPFQMmFw==
X-Received: by 2002:ad4:5ecf:0:b0:69b:1f8b:2e71 with SMTP id jm15-20020ad45ecf000000b0069b1f8b2e71mr6482575qvb.47.1712840880726;
        Thu, 11 Apr 2024 06:08:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id g6-20020ad45106000000b0069b439190c8sm905262qvp.64.2024.04.11.06.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:07:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ruu9n-00AgEt-5q;
	Thu, 11 Apr 2024 10:07:59 -0300
Date: Thu, 11 Apr 2024 10:07:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] iommu/vt-d: Retire struct intel_svm
Message-ID: <20240411130759.GJ223006@ziepe.ca>
References: <20240410020844.253535-1-baolu.lu@linux.intel.com>
 <20240410020844.253535-13-baolu.lu@linux.intel.com>
 <20240410154951.GH223006@ziepe.ca>
 <b24f3380-1ac3-41c4-9163-56c1dcff6297@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24f3380-1ac3-41c4-9163-56c1dcff6297@linux.intel.com>

On Thu, Apr 11, 2024 at 03:55:50PM +0800, Baolu Lu wrote:
> > > @@ -4388,14 +4386,8 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
> > >   	WARN_ON_ONCE(!dev_pasid);
> > >   	spin_unlock_irqrestore(&dmar_domain->lock, flags);
> > > -	/*
> > > -	 * The SVA implementation needs to handle its own stuffs like the mm
> > > -	 * notification. Before consolidating that code into iommu core, let
> > > -	 * the intel sva code handle it.
> > > -	 */
> > >   	if (domain->type == IOMMU_DOMAIN_SVA) {
> > >   		cache_tag_unassign_domain(dmar_domain, FLPT_DEFAULT_DID, dev, pasid);
> > > -		intel_svm_remove_dev_pasid(domain);
> > >   	} else {
> > >   		did = domain_id_iommu(dmar_domain, iommu);
> > >   		cache_tag_unassign_domain(dmar_domain, did, dev, pasid);
> > 
> > It seems very strange that SVA has a different DID scheme, why is
> > this? PASID and SVA should not be different at this layer.
> 
> The VT-d spec recommends that all SVA domains share a single domain ID.
> The PASID is unique to each SVA domain, hence the cache tags are unique.
> Currently, the Intel IOMMU driver assigns different domain IDs for all
> domains except the SVA type.
> 
> Sharing a domain ID is not specific to SVA. In general, for devices
> under a single IOMMU, domains with unique PASIDs can share the same
> domain ID.
> 
> In the long term (also on my task list), we will extend the cache tag
> code to support sharing domain IDs and remove the domain type check from
> the main code. This will also benefit the nesting case, where user
> domains nested on the same parent could share a domain ID.

Okay, that makes sense

> +static void intel_mm_free_notifier(struct mmu_notifier *mn)
> +{
> +       kfree(container_of(mn, struct dmar_domain, notifier));
> +}
> +
>  static const struct mmu_notifier_ops intel_mmuops = {
>         .release = intel_mm_release,
>         .arch_invalidate_secondary_tlbs =
> intel_arch_invalidate_secondary_tlbs,
> +       .free_notifier = intel_mm_free_notifier,
>  };
> 
>  static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
> @@ -598,10 +604,8 @@ static void intel_svm_domain_free(struct iommu_domain
> *domain)
>  {
>         struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> 
> -       if (dmar_domain->notifier.ops)
> -               mmu_notifier_unregister(&dmar_domain->notifier, domain->mm);
> -
> -       kfree(dmar_domain);
> +       /* dmar_domain free is defered to the mmu free_notifier callback. */
> +       mmu_notifier_put(&dmar_domain->notifier);
>  }

Yeah, that is better.

Also you need to have mmu notifier call on module unload when using
this scheme.

Jason
