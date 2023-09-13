Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111BB1E522
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 14:42:29 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-41205469f4eso4844281cf.0
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694616149; x=1695220949; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M40HyrbyuiRSEaK65IibWJwe9nMOi87zGy7uP/dUv6I=;
        b=nNtfvwjPOQx4IoPXbPsAt9Yxu9nC675ZuGQONBBwwzXJO6KCQLlfUaO2+2sxlS9FmL
         A5FtLxUYtbrSyC8Dl/owrgknlZOC+BibavFBnRoT2nQFTDDIohSGjPrpoLThjA9gahV+
         gAUy0ANng8vSps2m0VflPideFYdxzed6SNrGGoGeLXlxn9V2KiMryI60n1N1uTXWRQb6
         Me3RZE4O4nbgHratRMjsrmtCTfMkMvZJGWDGKmeEHnsUAYoGZB2xa2kFgMgr6JdjT/a3
         U+ySid8ZCB4kRisFNbovmpoK2CimH9iqozD3g1D4nT9B1zU+l5FuzUiDjtnKZWhYgFqK
         w4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694616149; x=1695220949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M40HyrbyuiRSEaK65IibWJwe9nMOi87zGy7uP/dUv6I=;
        b=pahdnVdat1RNtNM6M7T/k0WvV68/xfs/ofpDd6iPhtL7kceL21rsMPXksLhTvwTA59
         5S2/PNbhFuR7hYZe68YJLLLjeRUZ5LTnUHWer/X3z2w3m0ftXAvDQr+8P0gB6aGMVrDw
         vY8wmQEbcIhTvWsCWvvurh5Dqdp3NGtx3DgpKSXv2T9QRuNHM7W6sJX03ZIH+IJPRjXc
         2ELHuKjK29L+T0ViheOQrjHF474wssIUgBkWe6tTv7XhOzCj6QCI+CJRgnMh83lp78rN
         nukohHbweA21aMRZ2PqNf/ri2yrDggFHhWPTifVvMj7LXqidJ8UEvdjhYOggWo7dId0a
         nvYQ==
X-Gm-Message-State: AOJu0YyF4CnmhV87iUd3RWkkW6ugOHpCUZzU5nttTdOYKFYawPoNug98
	tyczBLGTgJ/ibEbfRy+Q4/D/u+i9Gham85f6+hU=
X-Google-Smtp-Source: AGHT+IHSU/kpm4BzRQGJACWAgTGMwO59DOjwuF+6uiVt9QrzL9oGBwvT6U/nE+fb5HKnkKz96i9UKg==
X-Received: by 2002:a05:622a:199e:b0:40f:de47:9b6c with SMTP id u30-20020a05622a199e00b0040fde479b6cmr7098251qtc.30.1694616149034;
        Wed, 13 Sep 2023 07:42:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id r19-20020ac84253000000b00413152fb99esm4037470qtm.49.2023.09.13.07.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 07:42:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qgR4W-003eg1-1L;
	Wed, 13 Sep 2023 11:42:28 -0300
Date: Wed, 13 Sep 2023 11:42:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 03/10] iommu/amd: Introduce struct
 protection_domain.pd_mode
Message-ID: <ZQHKVH7eocAaHl4L@ziepe.ca>
References: <20230816174031.634453-1-vasant.hegde@amd.com>
 <20230816174031.634453-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816174031.634453-4-vasant.hegde@amd.com>

On Wed, Aug 16, 2023 at 05:40:24PM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> This enum variable is used to track the type of page table used by the
> protection domain. It will replace the protection_domain.flags in
> subsequent series.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 6 ++++++
>  drivers/iommu/amd/iommu.c           | 2 ++
>  2 files changed, 8 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
