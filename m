Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5A1148827
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456200; cv=none; b=YNs7qXWGw4G94Nkk8WpYOG8dGRe+4t5ZkoV9lhLvSc3U1G3HOJbmmlHbFEorJbnJt3UBr1mxHdo2MKPGNoyEkgmZADNTvfGojUNbWpDJ1WG17eHXtURu8PJcEFEAgy1KrOxfpJ9DSaATg1It7cSSRrBYjeTOQLXz2cr0l+Lffuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456200; c=relaxed/simple;
	bh=3h766dFHjusL9yF2BAWAi2RB7FAbv/vaFEWG4U4Nou4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtVcmfxePVPOzJKCHYXqzk4y3QoAC/iz4pCu5sCPuvHSVUMJMRbmPu2yyuNJ13PbgARImATV7wDR1hEnia/DCl2iIDx7L7o9kyZdJIhw7gkIEUugK8oHUaVrU3SERw9nBi7fAFnFWusf3e7vLmq+/FvowACmqKT19C1GniFtq+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mSHyrozk; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mSHyrozk"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-447f0a7660fso5912611cf.3
        for <iommu@lists.linux.dev>; Mon, 08 Jul 2024 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720456198; x=1721060998; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bpADAnxMmPl0KnU1qL520o96mOq4J8FvDBj3a92ycMo=;
        b=mSHyrozkz4DRJpVfCyWQwL3c2GltRrQPhPTznHccL7szXTIfJUyezilyn0r2kNe1g5
         6x4KFNB1kAD/cOZk5LKnqS0G6ji/6+56Sewd1Sxn7eFQCmUDBW32MHOEoGOel0DsVDuE
         JW8IUEZ2asw4sx+eMzFJcMprb5Xkh9mmcJVC8J7yudNAGVw2NXPoDHQ3iBCP79bD+gvK
         P+dr4q3SzqeDyComgbo+Lh2FPMdM99pUd916eQG5lN7AJmi+o3ry+ml7/XmVF5+MTwb6
         C+d/r04VClYTtv7xNIDYv9wcVJNlmzPoEYJT/enf8mf0NoghpLmlb357tBdf2SF1wsKm
         uIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720456198; x=1721060998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpADAnxMmPl0KnU1qL520o96mOq4J8FvDBj3a92ycMo=;
        b=nAj5YhfWp0VMcYEE8K/Rym8H01dcqHH1WnCe8xvBTVtO1yrqzkhIiv5roHvPmR6cs6
         iD37Nr6ALaTFFIUYZBpLEFotsW+PS7SgleKV+NHObg+lrVbLGebo+0X4afTv1TnYz15f
         Z+2UQYjVyD7HSKaFI5crpidYX4JAL0BtW3tYoKjrgklDAVuVARBmUvqX8CX8QfX/73Lr
         gzZiUzT5zm9kpQJPW4aIsf+i8qPTzDshky5+QaIeVBNhKULN9+emDt8WMjYwSFnkbJAh
         88DSsoQHNcSzegQavm4kgJ0U8h1HTzJZBzISdYDv4NDHeYJkCsIciKmja/NWdw0nV3/g
         zp0w==
X-Forwarded-Encrypted: i=1; AJvYcCXdsmj4h0bF6zaCqOnxbj+mUQjoU/A106hoD41R16/Rpypq9u2jRELKIsabSxmQWmqEQVtQjcaddE9YuC/Y3SC7gXCt4/k=
X-Gm-Message-State: AOJu0Yy8iW6fGKvdT/sz5VSDs4PeF/b1bxlkI6TZY0JHA7s/st0wooty
	L2Z0teiJaNKODBznP8Cii5iAJKi1KhWCO4UesQvNsnGojV9Dj2sqdDdjXS8N5vc=
X-Google-Smtp-Source: AGHT+IFU/w14qf4HQu+71Ycg0U3BawEnHajgQaixjaC+e8UHgPl40rgFBfuNrXSLQ5sWrKc6QmM3IA==
X-Received: by 2002:a05:622a:13d2:b0:447:eb16:2e6a with SMTP id d75a77b69052e-447eb163298mr71776471cf.40.1720456198133;
        Mon, 08 Jul 2024 09:29:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bfb2b7sm914951cf.86.2024.07.08.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:29:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sQrFV-000SlT-1j;
	Mon, 08 Jul 2024 13:29:57 -0300
Date: Mon, 8 Jul 2024 13:29:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <20240708162957.GB14050@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>

On Wed, Jul 03, 2024 at 04:06:15PM -0700, Nicolin Chen wrote:

> I learned that this hwpt->fault is exclusively for IOPF/PRI. And
> Jason suggested me to add a different one for VIOMMU. Yet, after
> taking a closer look, I found the fault object in this series is
> seemingly quite generic at the uAPI level: its naming/structure,
> and the way how it's allocated and passed to hwpt, despite being
> highly correlated with IOPF in its fops code. So, I feel that we
> might have a chance of reusing it for different fault types:
> 
> +enum iommu_fault_type {
> +	IOMMU_FAULT_TYPE_HWPT_IOPF,
> +	IOMMU_FAULT_TYPE_VIOMMU_IRQ,
> +};
> 
>  struct iommu_fault_alloc {
>  	__u32 size;
>  	__u32 flags;
> +	__u32 type;  /* enum iommu_fault_type */
>  	__u32 out_fault_id;
>  	__u32 out_fault_fd;
>  };

I think I would just add the type at the end of the struct and rely on
our existing 0 is backwards compat mechanism. 0 means HWPT_IOPF. ie no
need to do anything now.

It would make some sense to call this a "report" object than "fault"
if we are going to use it for different things. We could probably
rename it without much trouble. There is also not a significant issue
with having two alloc commands for FDs.

I'd also think VIOMMU_IRQ is probably not that right abstraction,
likely it makes more sense to push driver-specific event messages sort
of like IOPF and one of the messages can indicate a arm-smmu-v3 VCDMQ
interrupt, other messages could indicate BAD_CD and similar sorts of
events we might want to capture and forward.

So, I'm inclined to just take this series as-is

Jason
