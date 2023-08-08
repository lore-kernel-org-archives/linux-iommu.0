Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034B100B2
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 13:55:30 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-76731802203so444193385a.3
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691502929; x=1692107729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNQeuCtr5FhOuP7t6uemp/dnicZRVELxBfrPNLfh0JE=;
        b=RnNPpPbbr456Qhaxcy7JufZfYkn/4f05/7hrFxxJ508F+oDGfITRjV8RZFmWiLbFeC
         BI7TBHGP4bCnMagCqKEUG3z8IZ3YJ1pDX2eYUY0u+PEQ1yGNrc95wd4eALi3LjE4MfNj
         YEpa4v0OtkEnGvfa1Tn2J78iqhQxXLaT8bJuUY0rEZMjTageUFNz81aXXC4TGyQVnncR
         7X7pH3Hxg7f0rGSAynEktMGU7YL1TEs6M85GgeoFHJGIDYG27poxGtFbpy6YzfCvl+SZ
         WWBvMflVaXj+zHSEUxlQDqSKiNIGTRTIUnWY3MPfYzx8ptPDnnrhPabxCAVmgSuNSfPO
         ZdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691502929; x=1692107729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNQeuCtr5FhOuP7t6uemp/dnicZRVELxBfrPNLfh0JE=;
        b=fMxTeuFk0Dw7WtSbG+Yk3FxXyYwucSeuqsTI1dJUTmThqxv9W4hmWMz/JCSGRWaie/
         7N4r/PHKFiBZPisBnKc/Mwk7lWCKS4CWAWx9PJ5ystXrEuGdoE9sqr0nwEm8p0iU2vCh
         dhxTftkIfVsVCuoyXPrLBB0nR9QEcQ9Jg+kGq7fCAV5yvotgTrNWlgD57ttV8XH4z9NI
         byY59B8ILQmza3yS6kfl7gcT+9hFTv/lSTUyxy8arRkRFvYIMOEia0VAdPLZ8AfeUebF
         HW8H2G1tLdDV4Quz2c4ZmUBYwbtMJf1qpE0dK3OCKe570bJ88w8o6ENaXAnRhgxBZbuS
         Krlg==
X-Gm-Message-State: AOJu0YywRl/y/cCKR8YTrb9jpalFHMiCX1xJAWt6ejSgAu7EKqW51l15
	/+stWqeJt5LGmOdJe7nkGIMQeg==
X-Google-Smtp-Source: AGHT+IHKVqrCXZsxMnZ3ITiuLhuXFT6R8EANqN6P9zhnuieXbk1eJhWPRRBMzQRyulrXAr7WeddLXw==
X-Received: by 2002:a05:620a:4d9:b0:767:2b4e:213 with SMTP id 25-20020a05620a04d900b007672b4e0213mr11985881qks.21.1691502929120;
        Tue, 08 Aug 2023 06:55:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id d24-20020a05620a159800b00754b7ee6922sm3291081qkk.9.2023.08.08.06.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:55:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTNBH-004ZN0-PT;
	Tue, 08 Aug 2023 10:55:27 -0300
Date: Tue, 8 Aug 2023 10:55:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 10/16] iommu/amd: Modify logic for checking GT and PPR
 features
Message-ID: <ZNJJTzuCyKXQojfe@ziepe.ca>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
 <20230804064216.835544-11-vasant.hegde@amd.com>
 <ZMz66cV24yQV9Byn@ziepe.ca>
 <14ad5515-e320-198f-8e94-1a83678a51b1@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ad5515-e320-198f-8e94-1a83678a51b1@amd.com>

On Mon, Aug 07, 2023 at 10:14:23PM +0530, Vasant Hegde wrote:
> Hi Jason,
> 
> 
> On 8/4/2023 6:49 PM, Jason Gunthorpe wrote:
> > On Fri, Aug 04, 2023 at 06:42:10AM +0000, Vasant Hegde wrote:
> >> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >>
> >> In order to support v2 page table, IOMMU driver need to check if the
> >> hardware can support Guest Translation (GT) and Peripheral Page Requet
> >> (PPR) features. Currently, IOMMU driver uses global (amd_iommu_v2_present)
> >> and per-iommu (struct amd_iommu.is_iommu_v2) variables to track the
> >> features. There variables area redundant since we could simply just check
> >> the global EFR mask.
> >>
> >> Therefore, replace it with a helper function with appropriate name.
> >>
> >> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> >> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> >> ---
> >>  drivers/iommu/amd/amd_iommu.h       | 11 +++++++++++
> >>  drivers/iommu/amd/amd_iommu_types.h |  9 ++++-----
> >>  drivers/iommu/amd/init.c            | 14 +-------------
> >>  drivers/iommu/amd/iommu.c           |  2 +-
> >>  4 files changed, 17 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> >> index a5a350ee36fe..0605f02fa711 100644
> >> --- a/drivers/iommu/amd/amd_iommu.h
> >> +++ b/drivers/iommu/amd/amd_iommu.h
> >> @@ -95,6 +95,17 @@ static inline bool iommu_feature(struct amd_iommu *iommu, u64 mask)
> >>  	return !!(iommu->features & mask);
> >>  }
> >>  
> >> +static inline bool check_feature_on_all_iommus(u64 mask)
> >> +{
> >> +	return !!(amd_iommu_efr & mask);
> >> +}
> >> +
> >> +static inline bool amd_iommu_gt_ppr_supported(void)
> >> +{
> >> +	return (check_feature_on_all_iommus(FEATURE_GT) &&
> >> +		check_feature_on_all_iommus(FEATURE_PPR));
> >> +}
> >> +
> > 
> > I'm still against adding more globals, the iommu struct was available,
> > just use it directly in this patch.
> 
> Sorry. I missed to append the reason after re-generating patch series.
> 
> We want to make sure features supported by all IOMMUs are consistent.
> Hence we introduced this function. This function will be used in
> subsequent series (ex:  before enabling IOMMU PPR feature, etc).

That isn't really the right direction. iommus are per-instance things,
each instance should attend to its own stuff. Globals should be avoided.

> Also there are features like SNP which has requirement that all
> IOMMUs supports features before enabling it. So moving all checks to
> check_feature_on_all_iommu() makes it easy.

It is confusing why this would be necessary, but even if it is, it
should be limitd to SNP with a big comment explaining why SNP is
broken.

Jason
