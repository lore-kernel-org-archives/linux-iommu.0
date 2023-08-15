Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2BB259B
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 14:41:04 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5656a5b83e4so2730512a12.3
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692110463; x=1692715263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHv9hk7aO9kMgyWcHEzwDOx/QhyHQSlbP6bU7K91qCY=;
        b=R1qIrhz+QcaR5TTZOjDzt/rUJuoZPEFvnmBkfYSO0yMntTjeYMdm5DgOKUDIXJlNWb
         NOB/EpxxzsQsNhzy2AXBTs7JufJEYgJ8k1LZ8ekxOurZCNhjjXbjE+Ifehj4iIhsqoyK
         EyPJyaEokDShs1Ebw3YtVZZGNBJdPoFTY/azHmqMvPhBe1hP4O4NC9D8R6nAwPwbZNhm
         VLNHkaQHNw3rk8xoNJt7IETrndCcTlq3ArmgSps5lKlRb3VCBofZ8Aj5sVS9IQwjKr73
         iVMSaxiI0eZvP+Mg0p2awPNLEiVg8mloGVqczwtqr021RHyZmA+AGrr+EzdWn3aV06fM
         4Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692110463; x=1692715263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHv9hk7aO9kMgyWcHEzwDOx/QhyHQSlbP6bU7K91qCY=;
        b=LpUFEzhxaOrQ8piFxV9X7MLsREWr1eaVFus7dPf/l1okMFk/QqLyyxrFpBt2VMP2g+
         8n9G1L6/Knv6uDO4QcrAnMSsM0TTmGXQjPLzHWtLDErKRVeHnr0FNQynaX14VM1Pg393
         ipPlcJ+CAXp4UOOPJ5z+95V1V4oDavocW33Vy4GoI44DqodEWNn2U2ueukHqDOSUL+eE
         pZmrFl/Me+8+BAxFV6PVctYhRxTen4VSAnLKn2m6/m+/Fet3Aw6uczgrBHcMenxUNsgw
         flmx/Q8ul4vsK7Banqgv4i68U/loRKkxjGiRO6Aq5owKn0XO49Irw5yNXItO5u996BK3
         gL1g==
X-Gm-Message-State: AOJu0YyAOJM7I0mkeubLQ99sRZfXo0V7CHeVcYHYXRtRlmik2lRXupiB
	N8Rk7GWcJnPt9BMocRxLKCl+Hw==
X-Google-Smtp-Source: AGHT+IE0Cq0mDGXdyUc6C1NcwrBhagxLiwydfzMwtVwp2bB+k+PT/0snODUO0VRkDhfo5weB2n5PhQ==
X-Received: by 2002:a05:6a20:970f:b0:134:d4d3:f0ab with SMTP id hr15-20020a056a20970f00b00134d4d3f0abmr10327289pzc.4.1692110463642;
        Tue, 15 Aug 2023 07:41:03 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id e18-20020a62ee12000000b006870ff20254sm9374745pfi.125.2023.08.15.07.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:41:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qVvED-007bvG-4z;
	Tue, 15 Aug 2023 11:41:01 -0300
Date: Tue, 15 Aug 2023 11:41:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH 0/4] iommu/amd: SVA Support (part 2) - deprecate iommu_v2
 module
Message-ID: <ZNuOfZIm6itzNkbu@ziepe.ca>
References: <20230815103255.565295-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815103255.565295-1-vasant.hegde@amd.com>

On Tue, Aug 15, 2023 at 10:32:51AM +0000, Vasant Hegde wrote:
> This is part 2 of the 4-part series to introduce Share Virtual Address
> (SVA) support. This series removes iommu_v2 module support.
> 
> AMD GPU driver which was the only in-kernel user of iommu_v2 module is
> removing dependency on iommu_v2 module [1].
> 
> [1] https://patchwork.freedesktop.org/series/122124/
> 
> Also subsequent series will add SVA spuport in AMD IOMMU driver. Device
> drivers are expected to use common SVA framework to enable device
> PASID/PRI features.
> 
> Hence this series removes iommu_v2 module and the functions used to support
> iommu_v2 modue. Note that there are certain functions (ex: PPR interrupt
> handling code) which will be used in subsequent series for SVA support.
> Hence not removed those functions.
> 
> This patch series is based on top of SVA Part 1 [1] :
>   https://lore.kernel.org/linux-iommu/20230815102202.565012-1-vasant.hegde@amd.com/T/#t
> 
>   Also to build kernel with this series either we need above AMD GPU
>   related changes [1] -OR- compile with kernel config 'CONFIG_HSA_AMD=n'.

Why did you order it this way? Wouldn't part 1 be nicer if it doesn't
have to worry about this code? Especially since part 1 is now not
changing this code?

Jason
