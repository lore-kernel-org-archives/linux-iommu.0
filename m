Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB21803F
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 18:32:13 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1bbff6b2679so36590955ad.1
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 11:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692124333; x=1692729133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9syoRTOSAzSEKBlQnF+U1GBxxRqq34plvvTlAfkaZaE=;
        b=JWHHRmtsdyUwdBNj7Kgkm9GP8HuP7QNxFlq2hPgFfThDGolHMXdaR7fbH75lYdpToD
         /qLfmH99NCxYUoahJhAEsv/cpUQVqA75M36WTDOIapfDNy4b0Hrk03/TLbofFtahMvUG
         Z5OyvjG/1mo/TCOOv6OXD0xcHMXCki0xFSfDSGi1uLKy/Abh5WtnUR8IXtRSZErVThhg
         9okmWF+Ft0fiZPbCYryCINzNZumFsxWPV1h8A9ni8ejIexxNwg5HblLENcdgyZyCmxur
         qLkw6ZspnmcyKFosptflGrwSE2dkuVi8DhkvWpgQzmVe8h+oEHgTdnmEKAjUtNOfzKQ1
         YTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124333; x=1692729133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9syoRTOSAzSEKBlQnF+U1GBxxRqq34plvvTlAfkaZaE=;
        b=kr0BULkuSmC6crqkVN9n8brMFKJnaYHaHRn2AMgX0wJm8xeCbv96Tt7ha2rJs1wMXj
         pfIo4iY/8xhuB/a3oAt9JUsVI6s8ZmLRUhWTpcFFDWhVQfIj4ihgK4dsJBDNJ2wILB+0
         R3hR9IUnF5Kk8Ko8ZxKTamVxWTumXsAEGoSxVI/bNUbfyjcRuhnvhC8pbCmJ+TjQcMU+
         BTXETqy/CPVVCjBzW0z13KULuI8kDcwToddBIK/XJ4RgM+DwmXnTN30uphlZVynfQDfZ
         76jQf8iu9ErJCJZ3BrZiBDCYUGa6H7cOlQM4a8nGfWnZfJPWvO6EDGs/AafvHyAVCkH0
         DzgQ==
X-Gm-Message-State: AOJu0Yz4T2PSC+MLC91/YmFoWMEaPGCTQ5jHpjnuJ6qyABTf82PnvgB1
	KmJpMRDrC7+FObUzO9TwlZKy/g==
X-Google-Smtp-Source: AGHT+IF0QgBRhtAis1hJtgm+xz85cqtqHQ5xOTBVLTVdCg8cZzTsJC/jHwvdDZl32j3IcT/5VPnxDw==
X-Received: by 2002:a17:902:aa41:b0:1bc:3944:9391 with SMTP id c1-20020a170902aa4100b001bc39449391mr10848429plr.25.1692124332849;
        Tue, 15 Aug 2023 11:32:12 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id o5-20020a170902d4c500b001bb9bc8d232sm11342169plg.61.2023.08.15.11.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:32:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qVypv-007hjE-2T;
	Tue, 15 Aug 2023 15:32:11 -0300
Date: Tue, 15 Aug 2023 15:32:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 09/14] iommu/amd: Modify logic for checking GT and PPR
 features
Message-ID: <ZNvEq6lJ7Yfu/y10@ziepe.ca>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
 <20230815102202.565012-10-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815102202.565012-10-vasant.hegde@amd.com>

On Tue, Aug 15, 2023 at 10:21:57AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> In order to support v2 page table, IOMMU driver need to check if the
> hardware can support Guest Translation (GT) and Peripheral Page Request
> (PPR) features. Currently, IOMMU driver uses global (amd_iommu_v2_present)
> and per-iommu (struct amd_iommu.is_iommu_v2) variables to track the
> features. There variables area redundant since we could simply just check
> the global EFR mask.
> 
> Therefore, replace it with a helper function with appropriate name.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       | 6 ++++++
>  drivers/iommu/amd/amd_iommu_types.h | 5 -----
>  drivers/iommu/amd/init.c            | 9 +--------
>  drivers/iommu/amd/iommu.c           | 2 +-
>  4 files changed, 8 insertions(+), 14 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
