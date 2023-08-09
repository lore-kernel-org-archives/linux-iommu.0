Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A89218AE4
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 16:59:45 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6bca3588edbso23438a34.0
        for <iommu@lists.linux.dev>; Wed, 09 Aug 2023 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691600384; x=1692205184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XTEsQP1+0iumF877RP4qQLHej8hsu/9BpYuUN5Y2adY=;
        b=JzlC8Zw9WKivJVxz26FYwqB80WVfFZ6RDiS980y67gmTTNuF7ER+yz08CPVwASwoZM
         gKYV7BCMOa6zNvbbVCtWaxGDgfUkQ9qJmez94gYiktjPGpOmDjgkfsHiHTTFp/8xFTtf
         DlOmv8AX5zaHS9ih6o9Q7j0FIxPpPFcT2fnBsU92+V4kJRCVEuLVp/fzvl2N0bIbpxi6
         SuCTNor5R/pwn+u0oZ2YrCPUsrqYNzRV60a1T/LCyNBE3osy8HyYLEJM9ZV1+buUemOe
         avfBcqa5N4koDm2vxcyUqsSN8QgDCc9kjJFkgFvPN3JjT8qwQuRMo89sT9Pij82iX2I+
         3NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600384; x=1692205184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTEsQP1+0iumF877RP4qQLHej8hsu/9BpYuUN5Y2adY=;
        b=a5wAvZHrXnaLDD+/PJ2dSgMS/KrLJRepAhuHXIOucAGbLy0kX+m7UmDamT+qkf3nS4
         z9NDN/IBKCYj3zJiik4eP9pSMegTckN2EqhCQXSMeC1E0o236DNPIcD9ZDqD9JvhFTMm
         UO/Cg1imzQrvPGpQWq19za9RcqkM5JpgAAzdHo/JyhUGDTe2GdjBHTsoxOS/sBCj5J1F
         J9XuAswG+SFq1VTOpJuGoe/q+6/WWS6P3Wg5xi3rBP3FVjR7xvkVh/D1ZwEjWdyWB9pM
         KeXpo+lWLuMLdMpyAKndtS6IKhK0Hg2zR2lW1ntheTbUda+Qx05Hj0i1mA9rbNYCn9gz
         NG5g==
X-Gm-Message-State: AOJu0YzF3up+s4SM1+IWk8LD6Sauy+X//0y6+VTUSprjaUgF0EfArjtE
	LbHjiECCcroAvRvBi+Km/bJ98Q==
X-Google-Smtp-Source: AGHT+IEmzHenOJPDunw1cOZQzJjOj5rapAsmFJV0dYT4pA3Ve+ScUpS7lPR4AvRR0PMTnE+Xw/oiqw==
X-Received: by 2002:a05:6358:c18:b0:139:71af:ed0f with SMTP id f24-20020a0563580c1800b0013971afed0fmr2197432rwj.1.1691600384122;
        Wed, 09 Aug 2023 09:59:44 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f6-20020ac81346000000b0040f200feb4fsm4152679qtj.80.2023.08.09.09.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:59:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTmX8-00551w-Uh;
	Wed, 09 Aug 2023 13:59:42 -0300
Date: Wed, 9 Aug 2023 13:59:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/12] iommu: Remove unrecoverable fault data
Message-ID: <ZNPF/nA2JdqHMM10@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727054837.147050-4-baolu.lu@linux.intel.com>

On Thu, Jul 27, 2023 at 01:48:28PM +0800, Lu Baolu wrote:
> The unrecoverable fault data is not used anywhere. Remove it to avoid
> dead code.
> 
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h | 70 +------------------------------------------
>  1 file changed, 1 insertion(+), 69 deletions(-)

Do we plan to bring this back in some form? A driver specific fault
report via iommufd?

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
