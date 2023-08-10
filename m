Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050C22EE4
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 19:09:06 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-63d0d38ff97so5997346d6.1
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 12:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691694545; x=1692299345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBsV6+ts68b3MCiRcACqm+YmuoRBitbyDh+1vB9eOfo=;
        b=COIcEt0fqX73UeUlZllLXQvgTUm3SxDi7CEN7pJgTWDiV+EDp5lJjGdEZeRwUo8ba7
         PXaBP/ouioLF1NT142OLFuwkskZeDbXO8am2iRGaWKue9antxAodqBhuD/TywtShnwKD
         EGXqkqzWvQkbkbBw8ZPH3qHUIhOe/Z0FBdAvip6DPUp9uImmcB6DzdEwjuuqM4o5+eRk
         6i+/8cV93o0QKwhzUWti9awORJDqxqI09xY3Vnp8k7T2mOEdS8GrO2BaWkkmPvmXPR1F
         vjigqQ/CjxJhRXstDjJ8WoCVpCjWxVK9jAQ0airFucBdnmarCSvz80ZZGhCT3+IBIIPh
         TODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691694545; x=1692299345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBsV6+ts68b3MCiRcACqm+YmuoRBitbyDh+1vB9eOfo=;
        b=TBpzKihAP8C3cTwkxNm6jpZ1GYxx0E7IB+9iFrkTIJ+daGhcNQ36mpBSb1EZAO9Sl0
         WBaiQqG/xabxmPMfbLo6WCHLwJhanIJ7iCbBhupbRgkVB6jm1wdH4HAUOZCHXtUZNs4G
         hjWOq0qDCqhmEbTMfnql/KXNeKzBf+RDipZPdU0J07i+MIU+knZPrIsH82UbqqW2uSEe
         nBj6HbUCBB1kmMDKNrs2DJaz6SyWQbUKaFuSF+JSdoE9P4FAsUa5n5zi5aKNA2FTFFgA
         pUOtzEvaDOpYYTmEISOziTceFqn0G3rqMtVeGk3DTD0ewHPqxclUG8aHirqHLa3HyTRb
         TU+Q==
X-Gm-Message-State: AOJu0Yyie8n4oS+XH7znoT207iXhXl4ahJfTzXXP1DaUDiFoFb7NaZHE
	lnqLdOw8mvgdNaMvk9CGAWAXJw==
X-Google-Smtp-Source: AGHT+IGbRBMB1G0DgtrN1Ti5jWBuKV+GQrt2F3rx7SFZCKQn9VB73jXia/E3+tJJ4ZW9NFFbohJcag==
X-Received: by 2002:a0c:f04c:0:b0:635:ea31:521a with SMTP id b12-20020a0cf04c000000b00635ea31521amr3605192qvl.7.1691694545156;
        Thu, 10 Aug 2023 12:09:05 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id l17-20020a0ce091000000b0061b5dbf1994sm659891qvk.146.2023.08.10.12.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:09:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qUB1r-005IlP-2Y;
	Thu, 10 Aug 2023 16:09:03 -0300
Date: Thu, 10 Aug 2023 16:09:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/12] iommu: Separate SVA and IOPF in Makefile and
 Kconfig
Message-ID: <ZNU1zw1PDs6z9nv4@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-12-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727054837.147050-12-baolu.lu@linux.intel.com>

On Thu, Jul 27, 2023 at 01:48:36PM +0800, Lu Baolu wrote:
> Add CONFIG_IOMMU_IOPF for page fault handling framework and select it
> from its real consumer. Move iopf function declaration from iommu-sva.h
> to iommu.h and remove iommu-sva.h as it's empty now.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h                         | 63 +++++++++++++++
>  drivers/iommu/iommu-sva.h                     | 80 -------------------
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  1 -
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 -
>  drivers/iommu/intel/iommu.c                   |  1 -
>  drivers/iommu/intel/svm.c                     |  1 -
>  drivers/iommu/iommu-sva.c                     |  3 +-
>  drivers/iommu/iommu.c                         |  2 -
>  drivers/iommu/Kconfig                         |  4 +
>  drivers/iommu/Makefile                        |  3 +-
>  drivers/iommu/intel/Kconfig                   |  1 +
>  11 files changed, 71 insertions(+), 89 deletions(-)
>  delete mode 100644 drivers/iommu/iommu-sva.h

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

At some point it would be a nice touch to split iommu.h into the
consumer and iommu driver interfaces

Jason
