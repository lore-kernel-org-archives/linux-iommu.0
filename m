Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59F413E893
	for <iommu@lists.linux.dev>; Mon,  8 Apr 2024 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592094; cv=none; b=Zug9wY3K+HDSmjPakmtQ5dB/vjlpcG/Jq6fjxZTqhJfI/LpiLcx50uMwPu2+RNQFuIXtnpzhxm3XzvsBxM4NlyczUY+cvL6cbJnSyUgds02l0sJfFeIup8UzwItTresYxpgmp2VvKLBgk1lUGo3ynL0MzdsnRvGKn3x0epE/mfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592094; c=relaxed/simple;
	bh=Ygi3/4LFZQsuI5V6cl+E49vdQAx7C3y5XXwlxvBn2is=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxkgPoam5bNup/Akvu55P/2aLWyKcwzDncufmMg04fFunPsC0kVu3Ws0oxvSh6IHG3NcMBqekdzqo7aKuhpmmyw/7IL04eQSBUn6zCO3tArEa9NBozESPNQpQX0MRt9q8PUiHaafx37GfQsIjWt7DVUJao7PEqzIIEG8nAQIeR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5JzUbpx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5JzUbpx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712592093; x=1744128093;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ygi3/4LFZQsuI5V6cl+E49vdQAx7C3y5XXwlxvBn2is=;
  b=b5JzUbpxGfY/T/7XNN3SldXqZ72bXiu0/TPwg5jnG3/ymRQiKgfsJAJI
   wplb8zXThVV6j2qlOgpux57uk+mcjZy8jyYRzRA4GiAdB6Jmmd6y1XwvL
   kyYppTnMCHbVwuZlr2IPkhFs0NuyYIYJfGnalZx8ZOKHhro32hsE+eklm
   L90L1sNgUoNNZQ1bWOptfQoiodxq8sfseBRUaY7Xmyzbu310GEbmnFpXj
   vVn7Xu3hb70SZA1AIm2Jp4MX8eOpFig8iAtK4Y4LnYf+qy5aFxNFTf0an
   JP/Tjpl5y5GXL2j99XYxmXosyKsidq0eVsZ9qSYtEf6ZvcPcOUiBsBfBG
   A==;
X-CSE-ConnectionGUID: 6cOu9MopQVm6/7p0/EutRg==
X-CSE-MsgGUID: cAHxj8OCRJGkakEzBoNp+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11656110"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="11656110"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:01:31 -0700
X-CSE-ConnectionGUID: INLreHreTUSw5gvULrK0Mw==
X-CSE-MsgGUID: e2IUKgdJRnS2RmR0O3qmPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20054868"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:01:27 -0700
Date: Mon, 8 Apr 2024 09:05:56 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "sivanich@hpe.com" <sivanich@hpe.com>, Thomas Gleixner
 <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "steve.wahl@hpe.com" <steve.wahl@hpe.com>, "Anderson,
 Russ" <russ.anderson@hpe.com>, "Peter Zijlstra" <peterz@infradead.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/2] iommu/vt-d: Share DMAR fault IRQ to prevent vector
 exhaustion
Message-ID: <20240408090556.6165e603@jacob-builder>
In-Reply-To: <BN9PR11MB527677A69A2004A951165CC38C002@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240403234548.989061-1-jacob.jun.pan@linux.intel.com>
	<20240403234548.989061-2-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB527677A69A2004A951165CC38C002@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Kevin,

On Mon, 8 Apr 2024 08:48:54 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, April 4, 2024 7:46 AM
> > 
> > DMAR fault interrupt is used for per-IOMMU unrecoverable fault
> > reporting, it occurs only if there is a kernel programming error or
> > serious hardware failure. In other words, they should never occur under
> > normal circumstances.  
> 
> this is not accurate. When a device is assigned to a malicious guest then
> it's not unusual to observe faults.
> 
Right, a malicious guest kernel could cause unrecoverable faults, e.g.
wrong privilege.

> in this context you probably meant that it's not a performance path hence
> sharing the vector is acceptable.
> 
Yes.
> >
> > @@ -1182,7 +1182,6 @@ static void free_iommu(struct intel_iommu
> > *iommu)
> >  			iommu->pr_irq = 0;
> >  		}
> >  		free_irq(iommu->fault_irq, iommu);
> > -		dmar_free_hwirq(iommu->fault_irq);  
> 
> You still want to free the vector for the iommu which first gets the
> vector allocated.
> 
I think we always want to keep this vector since the system always needs
one vector to share. We will never offline all the IOMMUs, right?

> > @@ -1956,9 +1955,8 @@ void dmar_msi_mask(struct irq_data *data)
> >  	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
> >  }
> > 
> > -void dmar_msi_write(int irq, struct msi_msg *msg)
> > +static void dmar_msi_write_msg(struct intel_iommu *iommu, int irq,
> > struct msi_msg *msg)
> >  {  
> 
> what about iommu_msi_write_msg() to match the first parameter?
> 
> otherwise it leads to a slightly circled calltrace:
> 	dmar_msi_write_msg()
> 		dmar_msi_write()
> 			dmar_msi_write_msg()
> 
Good point, will do.

> > +
> > +	/*
> > +	 * Only the owner IOMMU of the shared IRQ has its fault event
> > +	 * interrupt unmasked after request_irq(), the rest are
> > explicitly
> > +	 * unmasked.
> > +	 */
> > +	if (!(iommu->flags & VTD_FLAG_FAULT_IRQ_OWNER))
> > +		dmar_fault_irq_unmask(iommu);
> > +  
> 
> em there is a problem in dmar_msi_mask() and dmar_msi_mask()
> which only touches the owner IOMMU. With this shared vector
> approach we should mask/unmask all IOMMU's together. 
I thought about this as well, in addition to fault_irq,
dmar_msi_mask/unmask() are used for other DMAR irqs, page request and
perfmon. So we need a special case for fault_irq there, it is not pretty.

I added a special case here in this patch, thinking we never mask the
fault_irq since we need to cover the lifetime of the system. I have looked
at:
1.IOMMU suspend/resume, no mask/unmask
2.IRQ migration, added IRQF_NOBALANCING

maybe I missed some cases?


Thanks,

Jacob
