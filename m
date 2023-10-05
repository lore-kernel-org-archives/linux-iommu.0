Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C97405C4
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="j1S/zAGH"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d81afd5273eso1428774276.3
        for <iommu@lists.linux.dev>; Thu, 05 Oct 2023 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696531814; x=1697136614; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/15YjTNGO7/laG0/KUBKbnKqMvDPAnAc/F84yDPFqo=;
        b=j1S/zAGHsW32s7tq3tPZcHK7+OVQDyBpCRXS3Xrh4e3yHL6GRdPasW4mLLg3ea0OZI
         rLj8uVYylWRbBExXsZ2U2VU6vnQu3UdQ5LBpzZHDOnAOYeXfjeTpP6T/y4DvY7ff6Owi
         bkaumfkMCATOJNRT9bhDdaOFuS3npxcDtp3eTxxv2eqjjlsKpMp5gqoVcOith62Vv8tT
         BdQNDVx6zlOLk8pUCMDNRBzsSWmvy3OBWkuBCVXKmwX9WrGOkERIY4qhK3y2L7kiMnS0
         q57lS2lmZrWIr5bsDyjY+qsFtmnoc7lFagdcPeIGoPPxV2AysIqaFq/hFh3K0KjJ8U3U
         sRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531814; x=1697136614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/15YjTNGO7/laG0/KUBKbnKqMvDPAnAc/F84yDPFqo=;
        b=AuBkq+C1/KQXTOHZ2ErjP38+KHqEVS81A+Qn0RjvxN94g+ZpNIGgkY9a8+PKNhagfj
         1VjjmO/fowcwoZljOEhjbcMjFnN0IK96PzuB4XJz7MUFPwv5yHUMCbkLFIs821j4hOcU
         OO+Estpi+hHBXq6fbcRq/qDcTuVw7SRuc5oADvlQnSXKddALCJJMCj3t53pxQO/PZYo7
         +gpRmAfachyuWHTWDh3Afr1NXMgBeKud1cW56qBxblObLrqUt+JmJNulm3XKIBebZu3U
         ZhZkulM9lfk2wgowp17wQTrO68ETtsX2K2UuezujRGD0eZTwGeoa4n1DTvmBQTzX7Svd
         S8WA==
X-Gm-Message-State: AOJu0YyYf6ljLQLiBQ7yojpzuAd4TU1/ng3DV/1SooxY6OoC1rDIlHmb
	WxA/e+GJ+o9Ekpui+1faZ9KconquR7wCzX3BS4M=
X-Google-Smtp-Source: AGHT+IE9vkjVIAkLcNbgY+36PhAH/k/F6DOzSR5t+bI4gIxK41GHXUo5VmRj4PtH+H/Mr0bYRrvrAA==
X-Received: by 2002:a25:8b84:0:b0:d09:34f4:6698 with SMTP id j4-20020a258b84000000b00d0934f46698mr5277131ybl.36.1696531813823;
        Thu, 05 Oct 2023 11:50:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id u21-20020a0cb415000000b0065b0771f2edsm711107qve.136.2023.10.05.11.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:50:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qoTQK-004Z8M-TB;
	Thu, 05 Oct 2023 15:50:12 -0300
Date: Thu, 5 Oct 2023 15:50:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/6] mm: Deprecate pasid field
Message-ID: <20231005185012.GW13795@ziepe.ca>
References: <20230925023813.575016-1-tina.zhang@intel.com>
 <20230925023813.575016-7-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925023813.575016-7-tina.zhang@intel.com>

On Mon, Sep 25, 2023 at 10:38:13AM +0800, Tina Zhang wrote:
> Drop the pasid field, as all the information needed for sva domain
> management has been moved to the newly added iommu_mm field.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  include/linux/mm_types.h | 1 -
>  mm/init-mm.c             | 3 ---
>  2 files changed, 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
