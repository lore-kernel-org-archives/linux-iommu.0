Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983420CA8
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 19:18:56 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-63cf28db24cso7959826d6.2
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 12:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691695135; x=1692299935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6nK40dlXSEtV9j+1clrTX2RCnnQWiTsk3pHmbVPkUwY=;
        b=VmBkafl1u25d2ecLyUc29ulrsvOSkhhEKJzuIU93CMtsoCspLy4ihE6XAu6q0FKV7H
         7LnJGstvlp0byYFZseM2BaVUeXnNZLL+R2jOlaxU4o1Ud/nwJDZ3AlwHHAWddr1hdDAg
         8Alv1t72xMjHMEMMtHU9bWogP2hPkCqxEH22qnX5LDAMnjcCIdacsNJpfbyNjw80iyd3
         0Xa721kMEsJQYgnTNhLDNMaDAoCHiSoBnKuy0rN8Z+NmXMYhiCdRQJSBHOdZ5K2x7LBG
         538LpY5D5oj+OGHc81pQ5kls8HpXumbdw5zvGYkIXTJUyb1xkQ++ypNWCPge9FRsMSvh
         zm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691695135; x=1692299935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nK40dlXSEtV9j+1clrTX2RCnnQWiTsk3pHmbVPkUwY=;
        b=RBL5ONIV++A4IZUyMtM2YzSZmcGi16S1VXddS4+tKJzMbU+aF4wZDmMNciSX+yu2FG
         +JFxpWAdZPy3/SBwYHVRNEYDf4eQurWDFzehn3exiqKknTiUS248yRb/yvFbKPl/Mmbp
         5KhshuXOausITWawIK2epAXud+f2Iks0bXj2d7xJ3HER2HbQ3FDrL+ACP16PYfIrS483
         pRPojNWt9Tk02zMFsG9yu228katxKmWOOZYx/D2GHnfZ0B3XcABI6+NN/Lfrv9JASsSj
         /9uae4siHAY6bIOmkWGvUWVxF4Lu6/4dM68Al31wqeOUcwNKRu2K8MgDYExDL4snHo67
         q8HA==
X-Gm-Message-State: AOJu0YzXWiWOHH04ZpDOIMD9r7zVK/g5djZGFdNQ/xLtgFmpyC1Z12mu
	k7bBvp1fmuM3zo5uHzKHo98agA==
X-Google-Smtp-Source: AGHT+IHH4IrROTfTjO5eB3vOPq41MQjpTBHKBaN/zPPR2N44/sTFeqgtLodbzZoyZt1KMjgv18nz0g==
X-Received: by 2002:a05:6214:15c3:b0:635:e528:5213 with SMTP id p3-20020a05621415c300b00635e5285213mr3435331qvz.23.1691695135500;
        Thu, 10 Aug 2023 12:18:55 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id i9-20020a0cab49000000b0063d316af55csm694456qvb.3.2023.08.10.12.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:18:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qUBBO-005Ips-5n;
	Thu, 10 Aug 2023 16:18:54 -0300
Date: Thu, 10 Aug 2023 16:18:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] iommu: Add helper to set iopf handler for domain
Message-ID: <ZNU4Hio8oAHH8RLn@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-13-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727054837.147050-13-baolu.lu@linux.intel.com>

On Thu, Jul 27, 2023 at 01:48:37PM +0800, Lu Baolu wrote:
> To avoid open code everywhere.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h | 11 ++++++++++-
>  drivers/iommu/iommu.c | 20 ++++++++++++++++++--
>  2 files changed, 28 insertions(+), 3 deletions(-)

Seems like overkill at this point..

Also, I think this is probably upside down.

We want to create the domains as fault enabled in the first place.

A fault enabled domain should never be attached to something that
cannot support faults. It should also not support changing the fault
handler while it exists.

Thus at the creation point would be the time to supply the fault handler
as part of requesting faulting.

Taking an existing domain and making it faulting enabled is going to
be really messy in all the corner cases.

My advice (and Robin will probably hate me), is to define a new op:

struct domain_alloc_paging_args {
       struct fault_handler *fault_handler;
       void *fault_data
};

struct iommu_domain *domain_alloc_paging2(struct device *dev, struct
       domain_alloc_paging_args *args)

The point would be to leave the majority of drivers using the
simplified, core assisted, domain_alloc_paging() interface and they
just don't have to touch any of this stuff at all.

Obviously if handler is given then the domain will be initialized as
faulting.

Jason
