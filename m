Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663EB4DC54E
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201618; cv=none; b=onTIjIg8m5+1kWWP7/UHugiLrXi9CyqzZhfYH3gFOXKuiYhn6tzLmFQH7NaRFqD0TzythzSfYxnNnYb6pLsGR/kZInnRnAvsQD6iwFrKUpZe3t1TEFa87npikdISccRIiWQSgKAfXKGfHOm2Ep7c/N6NYrjCFUs+JnVqcWJ2ht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201618; c=relaxed/simple;
	bh=f4R4U5Ar4zJ/4MQD6l6HxvWkEJAg60iD6DPVV1Prcak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tExUQKlDcsLkhGwFuYJcH7KhibqGomZ67wbIkpyISZzjK4Q1CBvWGdwAC4tG63Lcne30cRysgRBb8dZruyuwq6OUmYpYK5WYLf6dtxSU5lGhQcpO4XIfXzjJ9Xr/8JgAc1HcIxemYqjVpu/TItGAmhr5YaRaddsb9BYJDPWAyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WVpmDz+3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVpmDz+3"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1405ad.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779201616; x=1779806416; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pFrnW7yNBIXff+8j+5lqhWdfBhK7nbCJmLOYnxsRaNg=;
        b=WVpmDz+3GbJqsTex3AsD37mgAhukLxkxm/q2+YvIZbYA0F9OX3C+TN4zNOsr3t6Isd
         jqbwvm5Q0YfB7bJeEr2Wv7g9aY436b+ouSfC24+m5WqSnxyeP1Dz/4gMUIok/SaG5nJy
         j2yhZjutvAGO9BpIJH0D3WX5iKlTF+wLReAR7ASQLKt8wR6W1xbJyyzBsOrupv99npC9
         bSLRiD2hq1zZPu1Iuk14tESdDC4WaRPs3PQuw+6TEq8htnqXlFUXjCtbnsf5HBKUJReg
         2G1PI9NnCw/CptSty+LoeA1qKD54ld7QGvXWBcQwAtv0UNzSW4W0peOD3n/S/pwXuLGU
         tXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201616; x=1779806416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFrnW7yNBIXff+8j+5lqhWdfBhK7nbCJmLOYnxsRaNg=;
        b=ldtVrTInK/ZHCErBQsnz+iabCYyU5uAx9fb5+3THfniAoLHu2GErEb2qJV3b78n5ZU
         BuEGdz0Anu2QOJdKt0QHTpZuXCyfZJFagNCsvfgxorN7uWgSnecsGTrga7jgZmAXAN/H
         r4uMkyY79oR7rnNHL0CNfQCJJxILnlJHqLgJYnaoBNZZPB1JcIdT682qT3z5OwiNKOuL
         8Z0UZKlXjYOG9+H3JoUHjTObKSX+W+0LAlvPdAnNJPZmRQ6R7h2poRz2HtnEt7Jp2mSs
         104r3/XJqQHuSIWnx5AQEz4FkCB9+YmWlepCBw+cukUXT/Ad8RMOMktznAyb0XstsIHr
         Jhdw==
X-Forwarded-Encrypted: i=1; AFNElJ9DHOCa/9SF11tFTyyQWdh8uSyoe5d2if3W5sHMoIdWL6GfBaiiOw7aSeSu50dmDaiMuffC2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUguExlStTUqv0xBuGKRlfV2v2dzP/ExdTEG+A33tLdvWLvitG
	COFuUt4CfECTZ+tvxXxKC04TcpPz3fBZ5hFmr0qwsXl2jQG0mAm/9x5PUcxlOmbzKw==
X-Gm-Gg: Acq92OGIFHGSPFr7g4AdsqTZuNasUQlvPcUaGDwrF3gocPNGDo3lDRRKLlpkRCAnme6
	WQRTBFw5nLllOS7zgfKNBxli3gFARSa6dRZ7eUQSfiucxPwyF30ot+WxWkhwLIPLUxqMSEj4w8S
	FSol0oFtR5VCgS5s2CndoqSx06J0YJbii9IwzOWBLF0zGU3s6YCesbUQMdZxZiq+um3w0F1Keo1
	fShxh5O/VhqVPQeUof09tyv45hdDQEbCjNVgJVilsTPRIw/6lKLRChq5I5R2RMIKPc2zIWO9JpN
	9417eQ8IKuJMicZtJKm/Z4QVhf4sqRV254FPNgGz21mEgWeuj4s5aOot6S9l7JZLwbbNFcSJ9h7
	Y+WWcQc6CkW07TPeuPtHxPybrEL/SxOQGVuwszzxWVRAW6IW9eVCObxwgbwyGvPdaJUBD1LGLEA
	HjdTmjXEus0LpJUl9G79m0hpsOeDF90A0Ja9E8DqgOYb5w53CjNK/GfCC62OX8aJtL7O2X
X-Received: by 2002:a17:903:46ce:b0:2bd:9e75:9e98 with SMTP id d9443c01a7336-2bdb329b484mr6449415ad.9.1779201614999;
        Tue, 19 May 2026 07:40:14 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5ef27sm242035275ad.8.2026.05.19.07.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:40:14 -0700 (PDT)
Date: Tue, 19 May 2026 14:40:05 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 07/16] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <agx2RW_jujXbsiea@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-8-skhawaja@google.com>
 <a968550d-2cab-47fd-8639-a8747a8a7535@linux.intel.com>
 <af023TAT1m3oA9ez@google.com>
 <agtux6SrjpRYvMit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agtux6SrjpRYvMit@google.com>

On Mon, May 18, 2026 at 08:32:42PM +0000, Samiullah Khawaja wrote:
> On Fri, May 08, 2026 at 02:36:56AM +0000, Samiullah Khawaja wrote:
> > On Thu, May 07, 2026 at 02:25:14PM +0800, Baolu Lu wrote:
> > > On 4/28/26 01:56, Samiullah Khawaja wrote:
> > > > Add implementation of the device and iommu presevation in a separate
> > > > file. Also set the device and iommu preserve/unpreserve ops in the
> > > > struct iommu_ops.
> > > > 
> > > > During normal shutdown the iommu translation is disabled. Since the root
> > > > table is preserved during live update, it needs to be cleaned up and the
> > > > context entries of the unpreserved devices need to be cleared.
> > > 
> > > This is not related to preserve/unpreserve ops and could be made in a
> > > separated patch?
> > 
> > Agreed. I will move this stuff to a separate patch.
> > > 
> > > > 
> > > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > > > ---
> > > > MAINTAINERS                      |   1 +
> > > > drivers/iommu/intel/Makefile     |   1 +
> > > > drivers/iommu/intel/iommu.c      |  52 +++++++++++-
> > > > drivers/iommu/intel/iommu.h      |  28 +++++++
> > > > drivers/iommu/intel/liveupdate.c | 139 +++++++++++++++++++++++++++++++
> > > > drivers/iommu/iommu.c            |  18 ++++
> > > > include/linux/iommu-liveupdate.h |  10 +++
> > > > include/linux/iommu.h            |  14 ++++
> > > > include/linux/kho/abi/iommu.h    |  18 ++++
> > > > 9 files changed, 277 insertions(+), 4 deletions(-)
> > > > create mode 100644 drivers/iommu/intel/liveupdate.c
> > > > 
> 
> [snip]
> > > 
> > > > +{
> > > > +	struct context_entry *context;
> > > > +	int ret;
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < ROOT_ENTRY_NR; i++) {
> > > > +		/*
> > > > +		 * Alloc the context tables now to make sure the iommu unit is
> > > > +		 * properly preserved. These might stay unused and wastes around
> > > > +		 * 32MB max in scalable mode.
> > > > +		 */
> > > 
> > > Instead of allocating and preserving context tables for all root entries
> > > (as noted, can waste up to 32MB), could we restrict this only to the
> > > entries possibly in use by active PCI devices?
> > 
> > I think the hotplug devices or VFs created through SR-IOV will be missed
> > that way. Lets say device A is preserved and the associated iommu is
> > also preserved. And then a new device B is hotplugged and preserved,
> > then the context table for that will be missed.
> 
> Ok I thought about it a little more and basically we have following
> things to consider when we preserve context tables,
> 
> - The devices can be hotplugged and preserved, so the context tables of
>   those need to be preserved if we don't allocate all of them first time
>   we preserve iommu, as done here.
> - New context tables can be added (after hotplug) for unpreserved
>   devices. And if we don't get another iommu preserve call after these
>   are added, those remain unpreserved, so during shutdown those entries
>   need to be removed from root table or preserved for simplicity.
> 
> To solve this we can,
> 
> 1. Either preserve the new context table when it is added for a preserved
>   iommu. This can be done in iommu_context_addr(). This is simpler and
>   no tracking needed.
> 
> 2. Or track the preserved context tables using a bitmap and then preserve
>   them incremently whenever a device is preserved. On shutdown during
>   cleanup, we can clear the entries for unpreserved context tables from
>   root table.
> 
> I am inclined towards second option. WDYT?

Thinking out loud here, I agree that shifting away from the 32MB 
pre-allocation is the right direction. I'm wondering if we can avoid the
overhead of introducing a new tracking bitmap (Option 2) altogether?

Since the IOMMU serialization is a strict dependency for device tracking,
could we move the context table preservation directly into the device 
level op: intel_iommu_preserve_device()?

Whenever a specific device is preserved on-demand:

1. It queries the parent IOMMU to fetch the allocated context table 
   backing its info->bus.

2. It calls iommu_preserve_page(context) for that table. Because KHO's
   tracking handles duplicates, this should be fine if multiple devices
   reside on the same bus...

Regarding Scalable Mode, we could just need a simple check in that path:


/* intel_iommu_preserve_device */
/* Preserve the primary/lower context table backing this bus */
context = iommu_context_addr(info->iommu, info->bus, 0, 0);
if (context)
	iommu_preserve_page(context);

/* If scalable mode is active, preserve the upper context table as well */
if (sm_supported(info->iommu)) {
	context = iommu_context_addr(info->iommu, info->bus, 0x80, 0);
	if (context)
		iommu_preserve_page(context);
}

WDYT?

> 
> I think we will have to do similar stuff for PASID also down the road to
> preserve pasid_tables in PASID directory.
> > 
> > Since we don't track the context_tables that are preserved, there is no
> > way to incremently preserve the new-ones. Let me look into the behaviour
> > of KHO, maybe we can make the preserve call idempotent and do these
> > incrementally.
> > > 
> > > > +		spin_lock(&iommu->lock);
> > > > +		context = iommu_context_addr(iommu, i, 0, 1);
> > > > +		spin_unlock(&iommu->lock);
> > > > +		if (!context) {
> > > > +			ret = -ENOMEM;
> > > > +			goto error;
> > > > +		}
> 
[snip]

Thanks,
Praan
