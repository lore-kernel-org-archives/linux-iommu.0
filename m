Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A519013F428
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456451; cv=none; b=dIjeZy7kP/Tf77pbZp3KNOIuMkkQOP3fSQEr16+E5yFZnuA2ZtzW1y9gTdB8H4Dusdq65AFwuyGgeJgabOWOQ9lmJKpZgPj6wFKyj8EJ96gOUwgNG6ll2oLTrSAPk4j4HVV1qaYDcF3IjQEogntBgPu3HIUPfnHV20beBUq0VCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456451; c=relaxed/simple;
	bh=ToqemI+ldYTTw6gsG148j31AJrUX3qaN+RZnDX0lyq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KB0aycS9CRdh0zcaGGdVpXbTBZFeeg3TRi6RfYg7168BqydQ4QjdpyHaxx7Fd8X9+WJXuZNK77xUErHmZpTvErdZ8EcpI4LjdsuQGAy+yrIhYak/gcDKw/zZK3445g7H2GmHg03WkrJ3WyQ2vPrQ0+NtFFwf2Sw+zJUwAwFyqhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EW7/oroL; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EW7/oroL"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7036ab4a2acso946003a34.2
        for <iommu@lists.linux.dev>; Mon, 08 Jul 2024 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720456449; x=1721061249; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RFoxv2StTkAy81FUVFoM8zRGh/jhofwCwoDeHKUmFcQ=;
        b=EW7/oroLiuk9BCS3u9+wzfXOJCM+gYkgLEwBZI+HUJEhto4SwVr13Ep4rouWirnvP3
         sbcJIK82IuoB0HvPeGEx+pALRq5GYNLwjD19aT/blv8EvccVjDgnGEKDiItIsLDkKm1H
         G/CGbcbecn4fPwSqx5biRmaK0dyBmewwBe7c16/1hL6/Lb2V106xC28TimyhiGxoT2hi
         PpgbaI2G/DVa+JeuuXZfAyuxCVtGWSAxHK/jhSEpLeydC5JAKS4ul2jMrjz9PiTvZ32Z
         CR698CWJRecWMUISPevSTCK5yD+PI+a/+Aqxs1cx9w7EyL06VTRQJLnK348roT+QreVT
         g6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720456449; x=1721061249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFoxv2StTkAy81FUVFoM8zRGh/jhofwCwoDeHKUmFcQ=;
        b=b5ERdk2j+FKiZPro1niAbbN7CjsvCZ4yXk2NACfK86si2JnboeA+AJ9Z8SbhtDPzJX
         1CrcMqC5eYzQCQ9r/59RB6kF5CeX4GVUYYVcZ6QvGlcINdG/jY2g85OyLzqe65ijZfHe
         Z9184Fa9OF0tWpH+/MPtFA8/o9na+5ezuvrt6PLVyLC+h/qoffCpYB70P/8zfDFHFp8v
         R+DKv7dy4LaOHoEEkVoLmQRPJo0TlhDI+paRgdQ5SzHX2kBWow0jNTG34lqWGhYQSKqv
         j9L/QhqFTS9emVs+B6SHYBm8dbifxXc+cdf3MT8RuHTrigRqD+RCjz3KvOzegQg+8SPV
         ewwg==
X-Forwarded-Encrypted: i=1; AJvYcCWwLk3VyoreUA+U32lXClGMh1Z4TVu+gMFoFywhCJr97lovzoIc1tlyy4ZmcR0QggxQ4Hh3Vel9HfG24wY2sbEjR9KEfr4=
X-Gm-Message-State: AOJu0YxVogB0kFXB3dVisTxwfYjWrW9SPzL+NaatzCWqdiZXlYW2/CZm
	DVJo7irZBtxEyKvnh0Io7ahcj2vvD4ic4i3Mj3uBkDZqCWi0vyklpwNU90ivez8=
X-Google-Smtp-Source: AGHT+IH+SY7z9YUcEZHvm3NIhA2HWB3anmidOCwHHCYQdqIO1Nns+4jOSBLNnwnl/BLk4XULUJpMlg==
X-Received: by 2002:a9d:7996:0:b0:703:60b7:5de6 with SMTP id 46e09a7af769-70360b761b0mr6939936a34.27.1720456448709;
        Mon, 08 Jul 2024 09:34:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1900f2bcsm7175785a.32.2024.07.08.09.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:34:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sQrJX-000TAF-N5;
	Mon, 08 Jul 2024 13:34:07 -0300
Date: Mon, 8 Jul 2024 13:34:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, catalin.marinas@arm.com,
	kernel-team@android.com, Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/21] iommu: Refactoring domain allocation interface
Message-ID: <20240708163407.GC14050@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <172009858593.2049787.5200500337719932334.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172009858593.2049787.5200500337719932334.b4-ty@kernel.org>

On Thu, Jul 04, 2024 at 03:18:56PM +0100, Will Deacon wrote:
> On Mon, 10 Jun 2024 16:55:34 +0800, Lu Baolu wrote:
> > The IOMMU subsystem has undergone some changes, including the removal
> > of iommu_ops from the bus structure. Consequently, the existing domain
> > allocation interface, which relies on a bus type argument, is no longer
> > relevant:
> >
> >     struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
> >
> > [...]
> 
> Applied a few of these to iommu (iommufd/paging-domain-alloc), thanks!
> 
> [01/21] iommu: Add iommu_paging_domain_alloc() interface
>         https://git.kernel.org/iommu/c/a27bf2743cb8
> [02/21] iommufd: Use iommu_paging_domain_alloc()
>         https://git.kernel.org/iommu/c/26a581606fab
> [03/21] vfio/type1: Use iommu_paging_domain_alloc()
>         https://git.kernel.org/iommu/c/60ffc4501722
> [04/21] vhost-vdpa: Use iommu_paging_domain_alloc()
>         https://git.kernel.org/iommu/c/9c159f6de1ae
> [05/21] drm/msm: Use iommu_paging_domain_alloc()
>         https://git.kernel.org/iommu/c/45acf35af200
> 
> [10/21] wifi: ath10k: Use iommu_paging_domain_alloc()
>         https://git.kernel.org/iommu/c/d5b7485588df
> [11/21] wifi: ath11k: Use iommu_paging_domain_alloc()
>         https://git.kernel.org/iommu/c/ef50d41fbf1c
> 
> [14/21] RDMA/usnic: Use iommu_paging_domain_alloc()
>         https://git.kernel.org/iommu/c/3b10f25704be
> [15/21] iommu/vt-d: Add helper to allocate paging domain
>         https://git.kernel.org/iommu/c/9e9ba576c259

Great, Lu can you please split the remaining by subsystem and try to
get them to go through subsystem trees? Joerg can take the leftovers
at rc6/7 or something like that so we can finish this.

I think this is enough that Intel and AMD could now assert that dev is
non-null?

Jason
