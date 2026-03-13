Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22023B777E
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416208; cv=none; b=tKCynLVuYruqe1J/z2M6wNEj2onGkWkv2qIZ9WzVpcgHYdYa9DNeFO3vPDX2YMrwOjRl1ArnP8f+QP7ssibLj2tTfpBbbuRTo/xuxthgqS1oKlZtqseSbOaZxxUnPO54ryXB1cbrkasNFXdabJsxNLCMHhScV/jlHXxDkZz83wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416208; c=relaxed/simple;
	bh=mVJqAoGCdzDxY6EScXWW6YPCOZawlS/f85uqEYbM+Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U125buNfkScL9s3pDtBp9HKgxlQFWi5W8UvTbTk7/2gk9NFVM9StMWzKc5VRHgLd/FovouF2WoXCmk1eBEnP4TeTUWrapBk1OufkDiQXZbibxKTNBDtjdMTToQrOHaR+ybT+VBsZ6Rl5Fpt+eGAycidUxuDzuPC9DBTAbJWFFJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JK/98vEA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JK/98vEA"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aeab6ff148so87565ad.1
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773416202; x=1774021002; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QnL4RthXjRr5EwbDeuhNCTPnFU8J1byxNF4coj8lpk8=;
        b=JK/98vEAQkF8sLyEZ9nsBOmc4Mqiq9t2tLGIRJ4wLS/hWZ7xKpQ5Zr8wiiRFn+mK/Q
         Gmae01lo3ZKtZg/ka+Zm7++eGWP8rMjCVtFzcWb88jmXHP+KD+PXU+3OpwY+iLVS7MgK
         SAGSMdE7fFoIbCOTPjcJDbfpv8rFF+KesncPSW68dbmL5GaUi3VJWreTf3+nY1RPuksi
         /t4uMNmI+6so6XA32kNDytxxtofE4iZuQ0gkIPLjncWI0k0dAt6DlRjDW285KcrK5Rjq
         BlryYBMYZz+JIklIaWC8GJDhfFSzpavuNVvww18FeSsdegKdd2TesxG2UGS4Y/sHa0AH
         V26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773416202; x=1774021002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnL4RthXjRr5EwbDeuhNCTPnFU8J1byxNF4coj8lpk8=;
        b=PqGb9z3PtQteqo36un3FNosuwF1Ajqf0XOXKQrhNu5ms6NrK9+alfVhJvOBSJ28CGL
         +CL9FGrhX0bG/5qwQuCoZ1uVkSBpPChBJKOXC49sNPDuhRkNEq7jrxamThowC7U97MbE
         lMHAwJc6UWJQQcWsckrnOihwobH+huhDg3KrvtgO2hT+c0iLVYmdXypoTPE9E7X2uVCH
         YM2igHol3mHBWiohLUlSQBJFp0dltyZoqjlLAL2W8BiZKWOyBPxCNhgaCZSg3FGKdyzB
         Uu+UJajUJ7YmFONeztPF3mMsza3GRfNtK3w4+a7djfotJiaizCOczwM/4QxAZk0yPNpc
         vzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5TvLYEgmDi8ugYFCW8DKpGbUrMhpLVS/oT1HfgRwyoKT6qizsg67kBlcHtf29ccXH1VnO/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvMyke4/cNpw9YIWAVParZdVHiHQano4pCrA/pDTBHY7hQifAZ
	oo5vRoJE0y0/6L7JQ9EoLfwAEY7ZxJtolsJf5vqvApBC1QyBOwj/B54/exq5qcqQZA==
X-Gm-Gg: ATEYQzyfp5FrD0vaiK4PNnoV06DX0hh2GPlop6j+CrET/nZyQPCzOV3ox9RO5myLIZT
	SY6lGnvpYm5/i89aExwXefDVif654O+EjcoZA3LlXi9jYoFEZzCgSCOawWY8BeYmrJOrK9MQXLj
	wTIVNqtP2Ikli9pULQeJ5NiAwqM6IInbZpySBLU3/1ljBpKmpwYt0C9gmhk9mbf3F5c155opASs
	VpIYas2tH7xfBLsRNLQvC7PeSUDO1iPAxhUzDnzqTDgqLzkCYCm/4SC0j5LGhfZRoDeWqE4GFwl
	AvQdt1XWRnN9S+MonslFiJ13XrSZ8PU3IU5O8Fw+jDIfrrFvIfUxSDGuE3cGPYoZEWuFfXwPu+U
	v/ec9o7MeGF057xEq5wJzKV+7RJqNKuAHyUJBOrVKRblqHsg4TT/PHtVKs/lhMr9ts1uZ+LmJN2
	ksRhVMQNqHlcOAOAH8hk5neuv6LjSZX4CxjyezI/SIdgRU+h4fmjSvoA3KkRBHXmoR6Wyr
X-Received: by 2002:a17:902:ec82:b0:2ad:6f9b:7818 with SMTP id d9443c01a7336-2aecd67598fmr2482035ad.23.1773416201213;
        Fri, 13 Mar 2026 08:36:41 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb62f0esm2233230a12.17.2026.03.13.08.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:36:40 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:36:33 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
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
Subject: Re: [PATCH 01/14] iommu: Implement IOMMU LU FLB callbacks
Message-ID: <abQvAY8Ao4acgmk2@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-2-skhawaja@google.com>
 <abHZdOKyLmmmHADz@google.com>
 <abLi5giBpi05_CLn@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abLi5giBpi05_CLn@google.com>

On Thu, Mar 12, 2026 at 04:43:00PM +0000, Samiullah Khawaja wrote:
> On Wed, Mar 11, 2026 at 09:07:00PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Feb 03, 2026 at 10:09:35PM +0000, Samiullah Khawaja wrote:
> > > Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
> > > alloc/free helper functions to allocate memory for the IOMMU LU FLB
> > > object and the serialization structs for device, domain and iommu.
> > > 
> > > During retrieve, walk through the preserved objs nodes and restore each
> > > folio. Also recreate the FLB obj.
> > > 
> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > > ---
> > >  drivers/iommu/Kconfig         |  11 +++
> > >  drivers/iommu/Makefile        |   1 +
> > >  drivers/iommu/liveupdate.c    | 177 ++++++++++++++++++++++++++++++++++
> > >  include/linux/iommu-lu.h      |  17 ++++
> > >  include/linux/kho/abi/iommu.h | 119 +++++++++++++++++++++++
> > >  5 files changed, 325 insertions(+)
> > >  create mode 100644 drivers/iommu/liveupdate.c
> > >  create mode 100644 include/linux/iommu-lu.h
> > >  create mode 100644 include/linux/kho/abi/iommu.h
> > > 
> > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > index f86262b11416..fdcfbedee5ed 100644
> > > --- a/drivers/iommu/Kconfig
> > > +++ b/drivers/iommu/Kconfig
> > > @@ -11,6 +11,17 @@ config IOMMUFD_DRIVER
> > >  	bool
> > >  	default n
> > > 

[ snip ---- >8 -----]

> > 
> > > +enum iommu_lu_type {
> > > +	IOMMU_INVALID,
> > > +	IOMMU_INTEL,
> > > +};
> > > +
> > > +struct iommu_obj_ser {
> > > +	u32 idx;
> > > +	u32 ref_count;
> > > +	u32 deleted:1;
> > > +	u32 incoming:1;
> > > +} __packed;
> > > +
> > > +struct iommu_domain_ser {
> > > +	struct iommu_obj_ser obj;
> > > +	u64 top_table;
> > > +	u64 top_level;
> > > +	struct iommu_domain *restored_domain;
> > > +} __packed;
> > > +
> > > +struct device_domain_iommu_ser {
> > > +	u32 did;
> > > +	u64 domain_phys;
> > > +	u64 iommu_phys;
> > > +} __packed;
> > > +
> > > +struct device_ser {
> > > +	struct iommu_obj_ser obj;
> > > +	u64 token;
> > > +	u32 devid;
> > > +	u32 pci_domain;
> > > +	struct device_domain_iommu_ser domain_iommu_ser;
> > > +	enum iommu_lu_type type;
> > > +} __packed;
> > > +
> > > +struct iommu_intel_ser {
> > > +	u64 phys_addr;
> > > +	u64 root_table;
> > > +} __packed;
> > > +

One more thing here, let's add the "intel" stuff with the intel patches

Thanks,
Praan

> > > +struct iommu_ser {
> > > +	struct iommu_obj_ser obj;
> > > +	u64 token;
> > > +	enum iommu_lu_type type;
> > > +	union {
> > > +		struct iommu_intel_ser intel;
> > > +	};
> > > +} __packed;
> > > +
> > > +struct iommu_objs_ser {
> > > +	u64 next_objs;
> > > +	u64 nr_objs;
> > > +} __packed;
> > > +
> > > +struct iommus_ser {
> > > +	struct iommu_objs_ser objs;
> > > +	struct iommu_ser iommus[];
> > > +} __packed;
> > > +
> > > +struct iommu_domains_ser {
> > > +	struct iommu_objs_ser objs;
> > > +	struct iommu_domain_ser iommu_domains[];
> > > +} __packed;
> > > +
> > > +struct devices_ser {
> > > +	struct iommu_objs_ser objs;
> > > +	struct device_ser devices[];
> > > +} __packed;
> > > +

Thanks,
Praan
