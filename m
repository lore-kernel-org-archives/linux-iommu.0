Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79A3546E9
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162715; cv=none; b=WiOvnA94Lz0OPN/zIe/85eLx8O7YWX1PXrsSVLPfFm/rpSzWe7PdqbZs8njeoLHPc3tNwNLRclHrwMEqZCuVY/8zgpgRkNLEWAENQYyH2m2YFiToeESswTzQd5zZJOOroC5bd1k9/4391KnduusH1nwENXjeL6GS2l8JQ9TLUCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162715; c=relaxed/simple;
	bh=mTMdRDasmuA/EDAmwz9LCUnoHW7nOhtRiIxjXAgYEZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5n3cas1ep8oIvtz4nUEYJbjqY7G5HzBcWVOIam1c4ZBs+XO59FcWzwPZhi+cwQvCuYX58oEUEUPRgtcbEYNZqyih7Cg4xJJsbSpYtTpeK4wm320rO0FNgXZ3Yqdqn2sWKsddsIm4RuqC2H25XGq8YTYvZT8Iqslt/6JV2zTdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MhfPShB8; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MhfPShB8"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533952f3714so66938191cf.2
        for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792162712; x=1792767512; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4kgwhKXvrsbFVEHtBB9HsyIrs9QabB8/6eZ9haqu9k4=;
        b=MhfPShB8B5m72uI8ytEQwE8YRMDLf5fppBKO3qs8YZCjJlY1RuHs8cZly7Yqu8Zkms
         4RJDQeN2R8X8T6SdtT6lR3RNDDuAU9i4N0I5iPnAkTQ1m5scqRqoyC4Rd0RPKMDrE++E
         AuynhrW5F3UI08+yQnZLsrg2qoLii0t7wQy9jgi903xCi0HqYFuNepd4Faf1qIjt84S5
         3XFvzUnq626hD6PSu8rfjXklH9WMx03V9j6qkvvVZHcsnu/8UIZmLlCtHsf0s/yomguK
         3bir8nrhX2IynrZ9fqt+tPdDs+lGTcVRsNA/G9ZKEQdQuAzfSAjpUSz3+h3Enjtmy++u
         WTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792162712; x=1792767512;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4kgwhKXvrsbFVEHtBB9HsyIrs9QabB8/6eZ9haqu9k4=;
        b=xqSwOk98h4YjftHt0kyJGnpaq51K4rMD9LtoeXuXE+nP7aQ1FTe0GisszGkZs6D5Co
         ig8ql57Y9Hy+4VmEv6w7GjUF4sxChZIR2eHYu0R3FyAZPuHQMvKWHWld/N+ITiKB+J3y
         8O16KIeQZVizTGOTSfXawWjiJfr0LeiK8pmSEcqy1Cr8V1JejETZ5nfMIoo0eWi6FuOB
         6Rvv5NDU1cMnyW3LB8VLwK4QITKi6L0RrhmgGVUkk529IXQ2PD9aa8snX4FH2cY6KUFP
         AloI+kYOzGoXEKIl2H6h8CnHDDDj/jeaUx8u7hwAhgKa6VarU7kFgEdkXAmQeqnh3hm6
         Rgww==
X-Forwarded-Encrypted: i=1; AKwUvByisCIQefIzwIZx7l9hk4m3PlQ8SNNkco2wpYEMVRyxhtUO072jdyFG6sg3gwbc3iSwK1Ojqg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLBnJuJw/PwN3K1bjVX6Sb8DwQEUFhau4FSrQNLnLSpld0T0o1G
	NA5L3T6z1+3WANoXbV0Drc2y/Z441X2G9/q87FV9SG7rWskDmZCx9jta9K8mBxgIhpc=
X-Gm-Gg: AYBFou2QDR++FFI3i/UQpPZz3dMRK4HewEVGjX4RmjuB9iGwO3apHfMVPP6M/3MOlHF
	j3v0LrUJc+tfCn6gpx/2LtA5oFTiWRQ7iLxU3b03870f06G8jILRTqgWeTNvA4Zya2jKlQDARXf
	RZKqBwEwkOSsKcDHzPEL3Su9ACg8+m7D49OxVD5LyxNlXnzYRAJGDs1Lr55ptAYBX5GYt06RqmD
	ZxbYt13pwdJE4NgCNTno5iXU8j3B0tYUtrBuqCAF5/kjui0G2QEgNGN5xbx41wP+LA6j3IQZX19
	1OFu1/UT8X1zBQhiBTqTM2BH37s3fxhiU1hmHlrGMn4e+DHMQaQX7V87U/d28BcjS6OHKR8LvAw
	GG0tBnhRiB+//9DlgRl6bqPBj67Jt50MRwHT/115/Obz5r9PA7vsrQ5bWSvSwCLPX8v1Uf1Y1Gu
	4HXqVbbRxVGD4FIlM5DUZh8XDaQ9IEHz6jrWv1dsiext4foHjqmOnBbBbhFN5+k/jn8vihCsABW
	riYuPwbkTbGYJL41aBAwJDzeZTcXbXjxcZK81a1R5HHjHC/jfbKFs/P
X-Received: by 2002:a05:622a:2b06:b0:533:920d:7bf8 with SMTP id d75a77b69052e-5359fae3efdmr392482121cf.24.1792162712412;
        Fri, 16 Oct 2026 07:58:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa19fefsm24355711cf.23.2026.10.16.07.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:58:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHjOA-00000001tOb-2Mjk;
	Fri, 16 Oct 2026 11:58:30 -0300
Date: Fri, 16 Oct 2026 11:58:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
Message-ID: <20261016145830.GA448730@ziepe.ca>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050>
 <20261015173707.GV14213@ziepe.ca>
 <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>
 <CO1PR11MB4836E2CB05E1448BB42047458C9B2@CO1PR11MB4836.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB4836E2CB05E1448BB42047458C9B2@CO1PR11MB4836.namprd11.prod.outlook.com>

On Fri, Oct 16, 2026 at 07:17:31AM +0000, Tian, Kevin wrote:
> +Aneesh.
> 
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Friday, October 16, 2026 3:03 PM
> > 
> > On 10/16/2026 1:37 AM, Jason Gunthorpe wrote:
> > > On Thu, Oct 15, 2026 at 04:31:31PM +0800, Xu Yilun wrote:
> > >
> > >> An alternative could be, bringing up one IOMMU when an associated
> > >> device requests link encryption. Then a no-tdx-support iommu fails the
> > >> encryption request naturally.
> > > That is what ARM is planning to do. I think it is reasonable to
> > > trigger creation of the secure iommu when the TSM is connected to TDX.
> > >
> > > Fail connect if the iommu could not be created.
> > 
> > Yes, agreed. The Intel iommu driver could use per-device interfaces,
> > just as ARM is planning. There are some differences, though.
> > 
> > ARM's interaction with the iommu driver in viommu_init() appears to
> > consist of two steps:
> > 
> >   - arm_smmu_get_realm_params(dev, &params): get and validate the
> >     physical iommu information from the arm-smmu-v3 driver;
> >   - cca_psmmu_get(&params): activate the physical smmu for Realm use.
> > 
> > Intel differs in two ways:
> > 
> >   - ARM queries the physical iommu information from the iommu driver
> >     in the viommu_init() path. On Intel, the secure iommu must be set
> >     up during TSM connect, because it is part of establishing PCIe
> >     link encryption.
> 
> My understanding is that the psmmu is required for link encryption, so
> it's similar ordering here i.e. activated before tsm connect?

No, AFAIK? The psmmu has to be linked before creating the vdev, and in
the current spec the only way to get the measurements is through the
vdev, but I am expecting that to change.

I have no idea what brilliant idea caused the VT-d iommu HW to become
involved in DOE and link IDE configuration in the root port. That
makes very little sense from an architecture perspective.

> >   - The TDX Connect architecture places requirements on the host
> >     iommu driver while the secure IOMMU is being set up. For example,
> >     the host iommu driver must block the enhanced command (ECMD)
> >     interface while the TDH.IOMMU.SETUP SEAMCALL runs, and it must
> >     reserve the upper half of the domain ID space. These steps have
> >     to happen atomically under the iommu driver's own locks. As a
> >     result, the Intel iommu driver needs to merge the two steps above
> >     into one.
> 
> Didn't get this. Both ECMD and DID reservation are TDX specific things.
> How are they related to the two steps in the ARM sides and why calls
> for merging?
> 
> and why are they must be done atomically? they are conditions to
> execute TDH.IOMMU.SETUP, but it is perfectly fine to reserve DID
> at an early point then block ECMD later...

That's going to be a bit of a PITA, since the DIDs can be in use when
the tdx module is start potentially.

I suppose you can start out by just failing if this has happened.

But as soon as reasonably possible once the system opts into a TDX
operation the VT-d drivers should stop using the upper did space.

Otherwise you will have to implement live DID renaming, which is a
PITA in an iommu driver.

Jason

