Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F26261B9E
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384233; cv=none; b=LNTRteR+2GFkwZaCpSDxSWN5OyJZIwIMksctpqs5O5QVxUrAyITrkLvcyBO61CDI2JXBeUa4E3Z333C+1FTzF9FSHZvbKX1hznouTBR64klc1cJZlcAKx0+05LPXRR4nW3capzZ/4xx8gvND1wupmNtkqZGic8JvyZd7nomfbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384233; c=relaxed/simple;
	bh=Tey6SVYpWtryUf49rWPG/gjXRb3iJqKZf+I/nXWKq3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSspp8pFIAVwL4QDc3H4jJWPwLb1XC/70hJcfjbymh9zd1FAq7rUBbxFaN+n4+PyYowJi5gM3JqTttPGPhofJOvOVIicGqlt8nSVF31S6YOk/BaeEroDdpp/qWsDBxPGmTksty9y+nPo0y+yeSq7VOLRzXrOVNlrAViBw65g/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rtKweWRv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtKweWRv"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b052562254so28015ad.0
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 13:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774384231; x=1774989031; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4GyQVsw9WUXq0Tx/o/WK9RzM8Q6jgQHyNgH4GZL/eMM=;
        b=rtKweWRvncB3t/IgjE5Iu0claDsrt9vpkRZ81BXzJglF5YcksJZw5M0qN7Mr6PUQbe
         k+GAb/SIt7clhDFx+EWtB6faJg/LF/1THQmXyV2tM7UijuoF1a5IbipHq9uG/hPd/45r
         e++kzADRwmbNJ2SQFPlpROp+UGi0ywITsGeOPShdrPIWBZBNUbsX+oom6kIrVJRDrnbK
         AkcmxgH0HLaCOpINEXldqJYppQFUrrM+tMk7+IP2An11ALFPuZGH0yj8njVUyJXnt+Gd
         PhU8j1xslbeG4zj70iYizEicHeJ54LUi3NUQU6OaAhjqOKxMa1F2q+ZPht2M5XIzD/8C
         1z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774384231; x=1774989031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GyQVsw9WUXq0Tx/o/WK9RzM8Q6jgQHyNgH4GZL/eMM=;
        b=XIY+4qQmZSJV8OW4TkGpuRjCSPwyccI25bzFEcpJfVw9F69/yHZG4VCzX3swqxqZ96
         4wfHtadIo8OVpB5KmI3V1uRrbNARJkqPQnnDepSpFYSiBylz4/xoB6DBz3s6eybkHTlG
         N/CXNr00RRr1VJE616BpS1jvxKMR4JxtAmfx6kabvr6mr78a4aPauIrYLrMAQp0KKF3S
         0cNpjO+4RKam0e+uRakqxyljuNEbrAMdoCVzBl1j6tdluaISMiq1W97ftjfBZPLuLh9A
         SzuNq5f7Z3sO5H8XML9lgjtb6IHimVnlWYcRdp+nkjbkTIhpbotvAoyF9JViyAH72gZ4
         LOTA==
X-Forwarded-Encrypted: i=1; AJvYcCXShyDVx4YgZokjPoR9UD9aJzL+A+XtGepe3WGjIgCbMr8MTxZuYvRuZvavtSM8ceiks73kCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEqnNfmeFVOf2RPaaJwqWUZNP4dXxy9WSl32BwhHK/ZMpnAQLi
	1pms/gAneIXWstpvu1BahnD9GiaMEJsJE6PdPcUfsdatnLQEFYT352gHJeWLSuoOPQ==
X-Gm-Gg: ATEYQzwMnYEnjyOw0KbPHnBxTlF+yGfwM0w9UYchSObdgws/6DYTh9eRsPXQ1+Pt5ks
	TdGBy/psAaL2P55JZf8EnszA1eM47N/tUmOyEmodt5GNZjjs1nrnHtgs8WUept5tbHUfchff3P4
	3/xlqD70RdYtW9ZxfQeIrXe5tJCBSRZRa4EDy3s4auvbBdWSI3osL3W0wbX1thvGm8+DQOhs6st
	EvOH1E5I903GIKFdsCfZb/h0fePOhQoOpEw59T2rMDQyF/tZGGmLZDgbv6cx2j2OdG698FD6sKl
	gkYkkTeazXDcQxdQXqVJ851K+x5kPCLTlWmSInV4ce+DTsydUsmBNgwVfg79MZSw6IRCmPaGhFW
	x5Y1J2uf/oSlpPYmw58E+HoGxNfhDKRMsMIqVhcvK7bOjuYHjTV8Nz3p6/8SakQnaavr6q97/Q8
	Ke1SLa1X/QbT2yfxk38qcRp0OtgwEpXxnnnUTUxK550CWKYUgVzK1sv6+x+A==
X-Received: by 2002:a17:903:32c5:b0:2b0:95a2:f84e with SMTP id d9443c01a7336-2b0b2ad9dbamr141655ad.19.1774384230665;
        Tue, 24 Mar 2026 13:30:30 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa960csm16439526b3a.12.2026.03.24.13.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:30:28 -0700 (PDT)
Date: Tue, 24 Mar 2026 13:30:24 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 13/14] vfio/pci: Preserve the iommufd state of the vfio
 cdev
Message-ID: <20260324202859.GF190066.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-14-skhawaja@google.com>
 <20260323210111.GB2571566.vipinsh@google.com>
 <acG3M41Ho96FyJ8V@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acG3M41Ho96FyJ8V@google.com>

On Mon, Mar 23, 2026 at 10:07:31PM +0000, Samiullah Khawaja wrote:
> On Mon, Mar 23, 2026 at 02:17:29PM -0700, Vipin Sharma wrote:
> > On Tue, Feb 03, 2026 at 10:09:47PM +0000, Samiullah Khawaja wrote:
> > > diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > > @@ -49,15 +51,32 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
> > >  	if (vfio_pci_is_intel_display(pdev))
> > >  		return -EINVAL;
> > > 
> > > +#if CONFIG_IOMMU_LIVEUPDATE
> > > +	/* If iommufd is attached, preserve the underlying domain */
> > > +	if (device->iommufd_attached) {
> > > +		int err = iommufd_device_preserve(args->session,
> > > +						  device->iommufd_device,
> > > +						  &token);
> > > +		if (err < 0)
> > > +			return err;
> > > +	}
> > > +#endif
> > > +
> > >  	ser = kho_alloc_preserve(sizeof(*ser));
> > > -	if (IS_ERR(ser))
> > > +	if (IS_ERR(ser)) {
> > > +		if (device->iommufd_attached)
> > > +			iommufd_device_unpreserve(args->session,
> > > +						  device->iommufd_device, token);
> > > +
> > >  		return PTR_ERR(ser);
> > > +	}
> > 
> > driver/vfio/pci/iommufd.c has all of the code which interacts with
> > iommufd in VFIO, I think we should follow the convention and add a
> > function there which can be called from here.
> 
> I am assuming you meant driver/vfio/iommufd.c as
> drivers/vfio/pci/iommufd.c doens't exist.
> 
> I see iommufd_ctx and other iommufd_ functions being used directly in
> various places outside drivers/vfio/iommufd.c, so there is not a hard
> split I think. This will introduce unnecessary indirection I think.

Yes. sorry, for the wrong path. Sounds good, I misunderstood things.

