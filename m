Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0E14276
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 18:35:25 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5657add1073so2733621a12.0
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692124524; x=1692729324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6yo0O8N6kOtb9LCjUhoBAztuugoQ3kMnALCDpD3ZKSE=;
        b=CsvqQYGu82OezXMDNwwwBzqYNQWieASuWjWJLfGLhhNCgOvrlp0Nq26K6tTuq5W9ua
         NbZ1CS+vlP5KqKZt5HiUmpCVB/L66C1W0RnY7XridQprfOfNHwJaM2zvGeStMFSi4eaK
         fblO35fcohjbdnUpNUTFUvm6Ap+nsMECMUVBqjKW3yTMYDJOmicTTXwEjLOwp3mhNZCQ
         GgoWvqJU9e+YLPeqS+Bvo8Vbm6ooSVoOW4+hBXKgBDjNRJdugfDWUri2d9XJYqnBJk9p
         ZtNMgzEtGVs9jnXm9Yr70vnpV+T99VTi4E1KZTeXoO0o6B1R88KdDwlDjEUCmwfgAhM1
         qMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124524; x=1692729324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yo0O8N6kOtb9LCjUhoBAztuugoQ3kMnALCDpD3ZKSE=;
        b=BvdIoQJY6V6nic3AjtN6Mau27gxuSS30cjvAUhYKbYmmGqgaiO+kxUVKiAJiufcmiT
         A73VKpMHLBdjOekXHhGFd/K/jMWzUSBnOBneltR1/xoJzPkGIFBHWd8zNv/drZ0myZe3
         i5YdRYDcJPF4THfUpsEPO/+fL7Jm5iT+9JwQIMPewXWILHZqzkXfrz0X3mHENoaAwFfZ
         9AKlhfvUdolTEer6RBv+Z6Suw/p1z6ZqzeK/F1HqzHxU63q6tMQ5L1ig3tAcB0RiOIjJ
         jYTl4lSnn3RS+T1O9HNUjtI/UzJZR/LtLDZoaKmNx8emekbiVgoxD3tri4jAv6cSF+vj
         dmlw==
X-Gm-Message-State: AOJu0YyP/HDU0Z4z0vkuPlCQQ5X1BHgwfarBOQlZIFbVQVLDZg3XNVhj
	3K+//UhTzmwlJKgnvEHfeL7wQg==
X-Google-Smtp-Source: AGHT+IHcrg34Jh+AyTGSEhAjVGeEBdwbsmXYvTmR7FRTikBtNafR4tHVfPn8Mm5V/bxV0xLhasMzzw==
X-Received: by 2002:a05:6a20:6a0a:b0:125:3445:8af0 with SMTP id p10-20020a056a206a0a00b0012534458af0mr3275814pzk.7.1692124524597;
        Tue, 15 Aug 2023 11:35:24 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id z2-20020a63e542000000b0056368adf5e2sm10550798pgj.87.2023.08.15.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:35:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qVyt0-007hlK-HJ;
	Tue, 15 Aug 2023 15:35:22 -0300
Date: Tue, 15 Aug 2023 15:35:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 14/14] iommu/amd: Initialize iommu_device->max_pasids
Message-ID: <ZNvFauXKrVg+Z1VO@ziepe.ca>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
 <20230815102202.565012-15-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815102202.565012-15-vasant.hegde@amd.com>

On Tue, Aug 15, 2023 at 10:22:02AM +0000, Vasant Hegde wrote:
> Commit 1adf3cc20d69 ("iommu: Add max_pasids field in struct iommu_device")
> introduced a variable struct iommu_device.max_pasids to track max
> PASIDS supported by each IOMMU.
> 
> Let us initialize this field for AMD IOMMU. IOMMU core will use this value
> to set max PASIDs per device (see __iommu_probe_device()).
> 
> Also remove unused global 'amd_iommu_max_pasid' variable.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 3 ---
>  drivers/iommu/amd/init.c            | 9 ++-------
>  2 files changed, 2 insertions(+), 10 deletions(-)

It looks OK, but you should still strive to remove the BUG_ON's in
this driver.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
