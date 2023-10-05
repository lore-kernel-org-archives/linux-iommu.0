Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F30405C4
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R1fL8W7B"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7740cedd4baso88413585a.2
        for <iommu@lists.linux.dev>; Thu, 05 Oct 2023 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696531798; x=1697136598; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uEUBHmO4oSTKiWUy3dq5rRvK6vcXZtKKFUQd3G4W35k=;
        b=R1fL8W7Bfpd3O3AI7dEdXhSprlHW5SWVbqpAXKuZw8Y0fhWukPfSO2te2slmCdSyaa
         ONm7fe/sflfaN8c7Twhx+c3IanR/vqlQRwgr3ItJT+FzxriWAWHA9ZD5xlNOstcSrYjJ
         i+P+OrZ0qndlWMThtEQSzKkZ8cAoR0jRJqFCPaN2Hm410IGUoUDZvi2I1uwf9IFOAEJ7
         3eRnWIlHu1pAe1cyK4uIp0ADRxWoq+99NbiaEmOC0uFiKYUL5OgIHCRwCmsp8ChA5J4k
         wZxJUxFsDb4DeDeSD7FBOUBeWc4NVeKlNQs0Iw+nk+i1MfRmnira9gsrDhT3iycPw51D
         yvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531798; x=1697136598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEUBHmO4oSTKiWUy3dq5rRvK6vcXZtKKFUQd3G4W35k=;
        b=bDQrKoCeJsVljl/2m9uANR6TLXLUWWBhjbtcoTe0FpifcthrbizBRTG8gwJijGWss3
         YyrWk3AufykD0HXySUW4my37MpzVjZeNHJ/ki9X+H3YAx6K8ATdACsr0baNzn/76i5+0
         J72H/MaGgWDNYA4Av+hH9oSPEUDx0YNP/4g5zvAbitNnHnLMTzHH47BuqyQpwh/24Wa3
         zQL6RHZh589ToXpKO37pOduL6Fipz8WAvko/MgLo3JcXudjhOODUWiBQID0bYfEGFS0p
         mEiNrrC2VdK6oW6qUVcp3ZoWm3umBZA2dHAimo7GTqDQFBf3VWdmyGLw83j5ABWp/hMR
         3c7A==
X-Gm-Message-State: AOJu0YyQhVL2pBe6Hmyt5SeSc9sJKJcD4dcMHK9FRwDdmViXBPpnY0w1
	DXhE8l56v4WKUUQaHq6xSqMCBA==
X-Google-Smtp-Source: AGHT+IEYC20BC1N5PA3gTmAKCxQySylj6S2PPzcS+TN9Nf4nkusD/9nv9hcsp7t8uHVeZNgRY2U4TQ==
X-Received: by 2002:a0c:b312:0:b0:65d:6665:b422 with SMTP id s18-20020a0cb312000000b0065d6665b422mr5136260qve.33.1696531798420;
        Thu, 05 Oct 2023 11:49:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id i9-20020a0cf109000000b006263a9e7c63sm691247qvl.104.2023.10.05.11.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:49:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qoTQ5-004Z83-Dw;
	Thu, 05 Oct 2023 15:49:57 -0300
Date: Thu, 5 Oct 2023 15:49:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] iommu: Support mm PASID 1:n with sva domains
Message-ID: <20231005184957.GV13795@ziepe.ca>
References: <20230925023813.575016-1-tina.zhang@intel.com>
 <20230925023813.575016-6-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925023813.575016-6-tina.zhang@intel.com>

On Mon, Sep 25, 2023 at 10:38:12AM +0800, Tina Zhang wrote:
> Each mm bound to devices gets a PASID and corresponding sva domains
> allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
> field of the mm. The PASID is released in __mmdrop(), while a sva domain
> is released when no one is using it (the reference count is decremented
> in iommu_sva_unbind_device()). However, although sva domains and their
> PASID are separate objects such that their own life cycles could be
> handled independently, an enqcmd use case may require releasing the
> PASID in releasing the mm (i.e., once a PASID is allocated for a mm, it
> will be permanently used by the mm and won't be released until the end
> of mm) and only allows to drop the PASID after the sva domains are
> released. To this end, mmgrab() is called in iommu_sva_domain_alloc() to
> increment the mm reference count and mmdrop() is invoked in
> iommu_domain_free() to decrement the mm reference count.
> 
> Since the required info of PASID and sva domains is kept in struct
> iommu_mm_data of a mm, use mm->iommu_mm field instead of the old pasid
> field in mm struct. The sva domain list is protected by iommu_sva_lock.
> 
> Besides, this patch removes mm_pasid_init(), as with the introduced
> iommu_mm structure, initializing mm pasid in mm_init() is unnecessary.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
> 
> Change in v5:
> - Use smp_store_release() & READ_ONCE() in storing and loading mm's
>   pasid value.
> 
> Change in v4:
> - Rebase to v6.6-rc1.
> 
>  drivers/iommu/iommu-sva.c | 40 +++++++++++++++++++++++++++------------
>  include/linux/iommu.h     | 18 +++++++++++-------
>  kernel/fork.c             |  1 -
>  3 files changed, 39 insertions(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
