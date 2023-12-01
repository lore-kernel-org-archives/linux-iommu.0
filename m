Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A0621A0E
	for <iommu@lists.linux.dev>; Fri,  1 Dec 2023 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VIK67UKx"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-58d439e3e15so1147054eaf.1
        for <iommu@lists.linux.dev>; Fri, 01 Dec 2023 11:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701458009; x=1702062809; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I2OeVOQrD9mA7MkxNCDuZeDEn1PaLfVovbPcfbgEPHs=;
        b=VIK67UKxzOUyLoNET6L03XhXYhmPmglrWQcwNTBb5WNiiV1V5LPUG+uFNt5u4QIoow
         HavSoF6mVMNzfXF0SOVG9X8DtVL3JiaNUDHlunsMIYYG8o7bgAryhcxk3B7aqwvNtuof
         30MsE3t+AEGDH3vbIvsmCsdsJLWBRB7clEXTChhTy9KM9IbO3gq3owbCIqvA/4sy4VDD
         q4BKEF6ocPnLUI36knFPzJByzw+T5zkq2Dzh3DNaHmrByRkEepnxuMmiSwkxDvzBLYX4
         ekJUXBpblqGuMvl/J2SMo2v8kjBaAwfeYorVcxxQYPz0kN+RrHplxPaRmWYHRxn6v2He
         lsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701458009; x=1702062809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2OeVOQrD9mA7MkxNCDuZeDEn1PaLfVovbPcfbgEPHs=;
        b=Rfjk9no+BnvosXLK21ERg1U3zLih/M01nm9HJ61kIo5PyAEmO8VkUVMZv6k5tDuBRb
         zQoPjDqKKcFHLOlRMMmgFh57BlM2H5kMX0CANXOtaSVR06G/aQF+N5UURZRh2YoBvgRd
         1+VOSlaqlszCXvuRcuejHYtqM2yzok/Dp9PRIPZeby4EJks3OQi0g1dMeKt8jQFRikzz
         4rltFPW1ia/Ov08JixEuP0WBTRYS+tqfA7l3353Ny1yLKY6k5K0f9VOdgUd5oEdVEEm8
         3rj1Ynz7dn8hHUk0i1U0jPlmuXv5h4mpaOyDWPfmYnrFprrIAoAewN+jyUTSs/bt96IO
         U6OA==
X-Gm-Message-State: AOJu0YwZPG7uIpjkoD60tpkd9qdNbyo2PNwmk4bQYNoeGWtq50tBwR9a
	CW/a53x+0Cl/x5dOrKP/YmLeWjAxEIqWnkLua8Q=
X-Google-Smtp-Source: AGHT+IEQWhwo+YQs87zSg16Es/DvsBvlD+J/VYbJsutxQ5RoA/cQ603E7sqNxOjxpSBkuubb9x+1Iw==
X-Received: by 2002:ac8:7f8c:0:b0:421:b323:bffe with SMTP id z12-20020ac87f8c000000b00421b323bffemr88819qtj.10.1701457750139;
        Fri, 01 Dec 2023 11:09:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id w2-20020ac87182000000b00423de58d3d8sm1731502qto.40.2023.12.01.11.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 11:09:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r98sv-006Hqv-2W;
	Fri, 01 Dec 2023 15:09:09 -0400
Date: Fri, 1 Dec 2023 15:09:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/12] iommu: Merge iommu_fault_event and iopf_fault
Message-ID: <20231201190909.GD1489931@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115030226.16700-8-baolu.lu@linux.intel.com>

On Wed, Nov 15, 2023 at 11:02:21AM +0800, Lu Baolu wrote:
> The iommu_fault_event and iopf_fault data structures store the same
> information about an iopf fault. They are also used in the same way.
> Merge these two data structures into a single one to make the code
> more concise and easier to maintain.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  include/linux/iommu.h                       | 27 ++++++---------------
>  drivers/iommu/intel/iommu.h                 |  2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  4 +--
>  drivers/iommu/intel/svm.c                   |  5 ++--
>  drivers/iommu/io-pgfault.c                  |  5 ----
>  drivers/iommu/iommu.c                       |  8 +++---
>  6 files changed, 17 insertions(+), 34 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
