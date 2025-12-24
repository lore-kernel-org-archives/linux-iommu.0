Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE942AD22
	for <iommu@lists.linux.dev>; Wed, 24 Dec 2025 01:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766541163; cv=none; b=fW9sZPGd5h6RKzZAy6pLrKIneH6bkqa+kWA1Aut4cuUCvQ12WcW+zat6/NBvFWfzUc3yEhivoUyFLplQTytdml1Cs+WO58eh40n9zjwTpN5edx8NSFVxyk/YSKyXHmdMudO25kvSScRy4yoQpVWUFIroDAZ+bIiuOighKO5bETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766541163; c=relaxed/simple;
	bh=5lPG4IOf+sBq6TrpNhLFNFU/P+BDTFLEEuHrmUhykmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivRYhy21NoSCRs/2fGuuhY4WmPQ8nMRNViLCWCvi4NbWvlHknrUmRk7RZIcg4KvSoCJYnXR4qqyk4/RXqEtiIX6AcbT8jYNnlecIA/SQJ8+EWv/X/6NSm3m+RW3bncYEPHf0aKesFLPuNghjgq29HgoJuOUx/jkbw8zm1st/078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AgJwbmrX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AgJwbmrX"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0fe77d141so59393165ad.1
        for <iommu@lists.linux.dev>; Tue, 23 Dec 2025 17:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1766541160; x=1767145960; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=howC3qe0NOwtd1tHxmKfOKuZ1Et78AmRirPyytf0b1M=;
        b=AgJwbmrX6ukmi6S9mdfz8M60+byGWUO3nFKyMcjQIrxCp7ernfWL10evlbZVly8CsY
         f9tfxddVXr6Ic8f9rBkVHvfd8TPwPxGIykPe0btkLdXvTyFJovm5EHw+aWcwNo2KtYOP
         clqcP+UsO9UyWX547TQIwis+QR1kxxfQZH8/gxaXhU0SxzTWRjzWlYGsqrYSJg1vQH4T
         Skp277oDJdQV1QDlHT8HqmDNo08eapVu/5d2CRnhXm5mhwCYjan/pvIkVxFbBuhMEiu3
         j1gPYBS+98kUlBc472/ka6M5d2oMSOrtstsXNgyJuZ9jJCKNPNPCrA+P0FrgzJ2NfVdd
         LYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766541160; x=1767145960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=howC3qe0NOwtd1tHxmKfOKuZ1Et78AmRirPyytf0b1M=;
        b=Pvu78Xa12giS1qCWeVJRhDrM/N6y2Kncd+ZhoGIyyxr0CRxCx5D0Nh378OVR2RcnzE
         gX+raXxkbJ1ETEuqm2sO/bW8rviBObNLQdUcmqrHuwDZ0jbvN65+iNEcDVT7LiD3QPkf
         z1QMK3I9JN1PgVX0MnBOkYLcICXY6JsnfOPND4s1xEhv4V7+fwL8XnhzVrOp99cCKw6l
         HLL53Gz1MsjzjeGwmzVTipyfdEi3cGxKSkQrSG61/Ko63KGRMueeeBONLK0nf5kYbL+d
         AQ1I1tjdeAqjd0yzeRIyn76TOLLM8jSeN/tAvMuIhml4W6IwOEQ8Arm7NowpCX+v9Os4
         F6wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUptYbZFP+iI7lZgL3kNKlOYewYflP2qqHzqqevlXctYpMPgXKSrEVbsoRUDugBv965PsmnPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxYAch5vG/Guc7wPyGWOqoRmR5q6tYWUIIhf7bTEYJt0aJOlaX
	HhsuGlxhcokX8iP9fhodf083rTf3yVPe1zPbGu/vbUOgdkYXsQxgAXDr0kj+wcGj8szjIM4YakN
	oOTRh
X-Gm-Gg: AY/fxX5pR1TJD4GkAP9bPXCNEi0LDxd6o2OQJU/XB15R82vDOLZEgiLDeWyX02Fimts
	9vJpDkQ/InT6m1CDctPneJzQeqnne3LiKx16PfvtTrTnjBmmvpbF8DFF+m2y4usrBLl1HEZJ/uq
	dLrLVaW2q+qYS8CeLwwXfcF+e3ncrqJv1W5X5MNPpXoxUrsg5PU9jS1RkeCtc/6nliGA67gNA8H
	QjrDvZBrv8rDCjZfbzOo+F38bLfcZJfWLm/n2SHnMEKlQr3fwbJbaP3BNcmoFffaQWFJwohJgAL
	H+QX/MLcpJ8bbxvzaBG7dEPrj++QWLkBeMHTHCaYjYsVaTC2CIfH5siNZEfzl9DXYuOkWbtu7xE
	inQqLXFLxRLTnX+ttbfIa1qv/9iaRawQXQDyfY/B276EzMPg8wWm/XwU3fibUW7DB3No8QHRBbp
	6MlWs3sVJvI2+Fw0X1O6jRrbc=
X-Google-Smtp-Source: AGHT+IEIpdwQ0t7SVPcZiTBNzBGw4vQ+EhUtMmvoCQetYW3tzxZPzl0WNSZXH98FL0e4VACW9LOKpw==
X-Received: by 2002:a17:902:c94f:b0:29f:2b9:6cca with SMTP id d9443c01a7336-2a2f293d118mr153893565ad.44.1766541160599;
        Tue, 23 Dec 2025 17:52:40 -0800 (PST)
Received: from ziepe.ca (S010670037e345dea.cg.shawcable.net. [68.146.128.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d407sm137888175ad.72.2025.12.23.17.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 17:52:39 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1vYE3L-0001t8-3V;
	Tue, 23 Dec 2025 21:52:39 -0400
Date: Tue, 23 Dec 2025 21:52:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pranjal Shrivastava <praan@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd: fix selftest link dependency on amdv1 driver
Message-ID: <aUtHZ1KHTJjW7SPP@ziepe.ca>
References: <20251223215127.603969-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223215127.603969-1-arnd@kernel.org>

On Tue, Dec 23, 2025 at 10:51:22PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_AMD_IOMMU is disabled, the selftest runs into a link failure:
> 
> aarch64-linux-ld: drivers/iommu/iommufd/selftest.o: in function `mock_domain_alloc_pgtable.isra.0':
> selftest.c:(.text+0x1590): undefined reference to `pt_iommu_amdv1_init'
> aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x280): undefined reference to `pt_iommu_amdv1_map_pages'
> aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x288): undefined reference to `pt_iommu_amdv1_unmap_pages'
> aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x2b0): undefined reference to `pt_iommu_amdv1_iova_to_phys'
> aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x2d8): undefined reference to `pt_iommu_amdv1_read_and_clear_dirty'
> 
> Change the top-level function to skip all the amdv1 tests in this
> configuration.

kconfig shouldn't let this build happen:

config IOMMUFD_TEST
        bool "IOMMU Userspace API Test support"
        depends on DEBUG_KERNEL
        depends on FAULT_INJECTION
        depends on RUNTIME_TESTING_MENU
        depends on IOMMU_PT_AMDV1
        select IOMMUFD_DRIVER

I think this is more fall out from Geert's change to make GENERIC_PT 
unselectable, the 'depends on' is no longer enough??

I guess the right fix is to add a "select GENERIC_PT" above, does that
work for you?

Jason
