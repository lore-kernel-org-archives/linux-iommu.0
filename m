Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781DD2FF178
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769630386; cv=none; b=gIyvN6Psc5m+KxzxlUEe95uxmBTRS5raHYvxFLrhhGIAColV9NvuTThg0NghHs9CQKUwE/gbA3e4InzxumDAWp0VZX12GNBQ/auwkYXsoi4sf1msOe51ABMIXJgmChc/CSGwX9faOwL0Jbyeybe0HYc+P1qpryVuvNJGJFprLIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769630386; c=relaxed/simple;
	bh=INVF0NKpfeA9Zqk17ZaQUkV6i2PcpJndfTdw11nI7f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsNzdErEP9wjVQjxuQDKqejxJy79TmmVQdh82UBIKFbXDhW0ikZseDQL2PE6vakbnP1QwsC7vbSDLhU+ZnYNG0CiBKPq0SYg1UTqrEuzU+S17Hzry8DUCMfHQ//N6nudLCcyPh4iDZslfzJa60HrYD1+RwLnRy+GjXCo6aVW8vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CC+tYUtT; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CC+tYUtT"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8946a794e4fso3074886d6.2
        for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 11:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769630384; x=1770235184; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYo9G/VcbU/Bswn8IpEHmUA4exilaj26AXaG+5ltVBw=;
        b=CC+tYUtTERwWBtK11jsKpyAzeNN74t8N/bk0JwNzAuQEB9i5QrTEXktvx10oeFlaVZ
         ChXts3gSpknu6Hl2zFc0Nxk67t6cBQ/XPZKMYR3RKqfJUN3f+cb6OjJxNN1G+aHikrwC
         3od0Al0LSJHljFNiPk8QFbqxzi3Qi7NoHm6CS9eXGb2mgkSsVpzYrOXvIfepDQKWjQxp
         Oak4RDxw4sPnX3tQIp4Iwjj68GXLTn3JwXZpdT18gv+ITs7zFVMaD0l7hb5m3OVuhxXR
         Aju7aBmhZdIiVmni7IObepAzQEkRTozDBGbILXpPZG2UtjNGKLnUj3YtjagOSL/V/6ON
         edwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769630384; x=1770235184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYo9G/VcbU/Bswn8IpEHmUA4exilaj26AXaG+5ltVBw=;
        b=GAqnK8g4av5+N0QwkmunnxklWvKiT2WSZqkvFylnLq6yjKr7Z4XfL+VFQ0RVRtUNCJ
         bqtSbl99mo/YB8lNECNOgKnavYkeqOFji5MwtuouxSzNIpS61FiKZR/z9qbizWyC2jp0
         /GRl1KFbK++Q+4Y5/+WKe8h/KhMw4i/gbrC44OuHFYa9u45a2D213ephynuO5agQ32RT
         SokiJnDWOLyRZENd90YtNRfRFAa7PHt0Th+IZSQLURmNq1RDiWkTiMvwejGm+rsz7jMh
         uLCov34YDmd0IADlzn2EC1jyNKH5by1ca4jRZ9f04fnN/hOHf3yigCsgDuS+pyB92f2h
         KpZw==
X-Forwarded-Encrypted: i=1; AJvYcCVnHkD/9BW2UPJUoZSkGAaTZ8FTl8m0n+5pRifSpRaPA6QBQ3wSZzDoRO6CTBPVQ0i5I/ALpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGOZ+hf4lTQlF9vrwOmhIJO/TB/alf+SPgMy40qMw0LU9cT0Uq
	wpkX1Z9HCrdRZIMS/nwTniHOE+j+nBMD87tIAnI1grorO3cXs3lPFSKUzeJaUBV0tLM=
X-Gm-Gg: AZuq6aI16NvdUdrsMBfvAE17l/21g/W9PzuorOKj5Wo4We1+pZCNkIvU5ILzh+FJUD0
	0t+bDSIyrah8xVgT8thphwl/LzML0/AfGM1227+1B92aQ7ng9or9THL8gpGSEstcbLkJnkcJSTw
	6kC0IpLJ66VrMsU+anr/dxkrpatDu6bJCu/2/+FIFW9T6urG3izNka3QNuus1EsWNsyjz0rzVSw
	/FN+v2mjUzSbN4ArfYolQ0fQXPm8u3JCvZf0bURGFtKt5EL+wQIewwzSyZGznCW3RPOHTU/DuYP
	Qut0bwjue3pGrHB5fpCou3l7IJ1mHajcZKsLG1ppruGLnk50PFRoBX6dxpYqrrNyd0um489yRZI
	p9y9PR+QTa8kYzgyhqVcA6ZfHyRfRTeyFLVhB7m7mK8FAFqE8+1a811m1uBfBnzw2opgzHJ1XKw
	N69zoxswi5b72Vj8BZtc6/dvWVkOGa6GxchtcnFx+oG1iqwe/39jbZOLps/HwNnbzXQGg=
X-Received: by 2002:ad4:5ce9:0:b0:880:5883:4d23 with SMTP id 6a1803df08f44-894cc7f5461mr96138006d6.16.1769630384364;
        Wed, 28 Jan 2026 11:59:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375f3casm23658566d6.47.2026.01.28.11.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 11:59:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlBhX-00000009es5-18WU;
	Wed, 28 Jan 2026 15:59:43 -0400
Date: Wed, 28 Jan 2026 15:59:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	YiFei Zhu <zhuyifei@google.com>, Chris Li <chrisl@kernel.org>,
	praan@google.com
Subject: Re: [RFC PATCH v2 00/32] Add live update state preservation
Message-ID: <20260128195943.GY1641016@ziepe.ca>
References: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>

On Tue, Dec 02, 2025 at 11:02:30PM +0000, Samiullah Khawaja wrote:
> 
> Samiullah Khawaja (26):
>   iommu: Add liveupdate FLB for IOMMU state preservation
>   iommu: Register IOMMU FLB with iommufd file handler
>   iommu: Implement IOMMU LU FLB preserve/unpreserve callbacks
>   iommu: Add iommu_domain ops to preserve, unpreserve and restore
>   iommu/pages: Add APIs to preserve/unpreserve/restore iommu pages
>   iommupt: Implement preserve/unpreserve/restore callbacks
>   iommu: Add APIs to preserve/unpreserve iommu domains
>   iommufd: Use the iommu_domain_preserve/unpreserve APIs
>   iommu: Add API to keep track of iommu domain attachments
>   iommu: Add API to preserve/unpreserve a device
>   iommu/vt-d: Implement device and iommu preserve/unpreserve ops
>   iommufd: Add APIs to preserve/unpreserve a vfio cdev
>   vfio/pci: Preserve the iommufd state of the vfio cdev
>   iommu: Add APIs to get preserved state of a device
>   iommu/vt-d: Clean the context entries of unpreserved devices
>   iommu: Implement IOMMU FLB retrieve and finish ops
>   iommu: Add an API get the preserved state of an IOMMU
>   iommu/vt-d: restore state of the preserved IOMMU
>   iommu: Add helper APIs to fetch preserved device state
>   iommu/vt-d: reclaim domain ids of the preserved devices
>   iommu: restore preserved domain and reattach
>   iommu/vt-d: reuse the preserved domain id for preserved devices
>   iommufd: Handle the iommufd can_finish properly
>   iommu: Transfer device ownership after liveupdate
>   iommu: Allow replacing restored domain
>   iommufd/selftest: Add test to verify iommufd preservation
> 
> YiFei Zhu (6):
>   iommufd: Allow HWPTs to have a NULL IOAS
>   iommufd: split alloc and domain assign from iommufd_hwpt_paging_alloc
>   iommufd: Add basic skeleton based on liveupdate_file_handler
>   iommufd-lu: Implement basic prepare/cancel/finish/retrieve using
>     folios
>   iommufd-lu: Implement ioctl to let userspace mark an HWPT to be
>     preserved
>   iommufd-lu: Persist iommu hardware pagetables for live update

This really needs to be made smaller and more focused to be
reviewable and mergable. Try to stick to 15-ish patches.

There is a lot giong on here, I suggest focusing this only on the main
iommu core, a vt-d driver implementation of the bare minimum, and an
iommufd function to trigger preservation of a domain.

Start off by just making the successor kernel fail to accept any
drivers at all because the iommu_domain was preserved. ie restore the
domain and set it as the default_domain and then fail in
iommu_device_use_default_domain() and related functions.

All it should do is convey an iommu_domain and the pasid table entry
unchanged without hit from prior to successor kernel. That's the bare
minimum.

Then a second series which picks up from there and feeds the sucessor path
through iommufd/vfio.

Jason
