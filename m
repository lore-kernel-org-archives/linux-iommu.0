Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C603B47E5
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699907; cv=none; b=niL2Tu8IJmjQo9yocymL4L5jzP8tPKAMxNEa1mRowpTm6IXIKQVdqQIUlHGm2Z6YGy7VLPbGyex8FgZBc1K2rh98Jg4fq3uqHvLsfcAZrthF5XNFrEq7v+WJ3NiJWaInPv9uSWvJBpFdDMPte0Jq832YCFody9BYCI7qIKkoDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699907; c=relaxed/simple;
	bh=pAi6YP4RjyDy00jk6oW+1Chj0bEIiFue3MJBPh2OHtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNcBmjUtcXd4M8MJzm8Ufe5/6IpAnCfOyeHVV0XcdAI/KhmzXjZBHPyUyku3rzWB+Dvx87ipFrRIgRkbKhEh0uSMYUUMgrM0mgXHIQdwZfVTqifde6xUsTQWaj003Iyw8N0/4PEdI/iAbnF1Z5EMN+oEnuW2JZWG1JFUyQlI23I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nKZ1DWQ+; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKZ1DWQ+"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c8d0945b3so93c88.0
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 12:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778699905; x=1779304705; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4e+3qV/LYmemclDGdoZ+eZkWfztJP8QDUVxcLhLFE4=;
        b=nKZ1DWQ+OTp9UZ0b1FmAK9uhmd0iWmZnre1sN1lH6CniM4R3FHVcu5H0b5dZd4YSDO
         LUCXequbeya9OPg79CEJBa3gDSWfJvNFFMEGSyY7/yQCxIerjk1L1G4VsmsHTza74Pxh
         831kGXL/gPben+Aq8Jb5c5cN8eIlt/p9kwP971YA5d/6fqUiDAhAgbPkskGQXtnh1f49
         1BdvXwRIK0lEWJw/ELnnwbP7tdaq/+OJKJGcYGvq0fHn5OCY5rNFpSpmijAHEpOsV/F0
         1BwHc2JO04e7uKTo0RxXGMlRZmb51xNtmoClifvZSqpyn2onamD8P71cIHE788/lb7R1
         /a8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778699905; x=1779304705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4e+3qV/LYmemclDGdoZ+eZkWfztJP8QDUVxcLhLFE4=;
        b=FMBiJJP4VjYDiWzfPGFy4kR+nDc4erW6GjkytM3eRkZkgcsM84JZJHID/ZyRUMg/Pb
         zG79BVNP6DsnbTEDtCU6UhXpZcHvT537pWdG0wUQ+jfu13bcI/NuvdiMXqmGKqb04YUi
         WvRh/Vqcs8oQKWLTa+7+TWndWNaNtDZcedtwu2xY3Q5Bg5szvPkYsrJc9/iTpfilYHHq
         NBppnJDwUd0x2i1EaEiD2DXDCgpJ9pz43FdjoH+RQAqmC1PQ2v29kFN0U3Z40aznfeaj
         OMoxaKrukN5NIGDdJFJmjAJy70Qgw11yADAZXav2LfrCLTh2Q5ROSEVWaVS/06Rq2FgH
         QQ2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8LVW5wbFV1mZyRzIVdj0wf7fOxy3V60NK2lDS24pEKBH0w5y+d2Fpy/lPI+QTJPEc/rQBRJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZ4qgg/rGajNw5h3aFKbu4wLWSZuAlITDXqJchGT1xyC57Skyz
	eUAI1S/EZCPxhEePYd3q9CPp1vhXkHhyAkdoProeFRO81pI1AGeM/42ZkNxUXs58FA==
X-Gm-Gg: Acq92OGIVppe01oI1h80TaN216w0elfzcI3k9Y2/moFsFizsnOfjRg8T3/WfGCdvTlE
	xL0sJN898+nWvuu8o3ANF+jNHc9IwCgG7pDSIs2FmgF4bfM3+hZdsoqLj8r47e4GmeA+JxXcPup
	yz1VkrRiQVuTlzWCkIhPb8KZKGS0IF9o4moMeHVf3ghaa5DHenV38zI55Yodhk2rKfZ0dC1KDW+
	CfZ5IcYlXuYnH/OyaQUC9nBv5d4vpZEjUHUU0VNJvdFF/B8OXDHEt1TnM4jKtbmz1lsK1yTR3mp
	ZcVAY9ZS2raNeLNZcIULGNpzAqEB2dNuRdtPjMe8D1WATYm3IpHAca9f/KN0wDlK94asdououHf
	i5vjPRqstzwuK3MCyhAmzLmZZfECWuOpEQBcpTttUQeMbsDZ0alCIzrAfGVrtnXf5naff7T3ttJ
	id2IOuiT3sRCEeVQVTiI+Z28ORDBpH96HoIp7HSwMiMNz0Q7t8cbMWtGbmcMIjNbkUEcBrGNNzV
	kV1eM/7
X-Received: by 2002:a05:7022:385:b0:11a:2c18:9e70 with SMTP id a92af1059eb24-134cbdd1a20mr42735c88.11.1778699904531;
        Wed, 13 May 2026 12:18:24 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6f6sm79812eec.17.2026.05.13.12.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:18:24 -0700 (PDT)
Date: Wed, 13 May 2026 19:18:20 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, 
	Mostafa Saleh <smostafa@google.com>, David Matlack <dmatlack@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>, 
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 2/9] iommufd: Support a HWPT without an iommu driver
 for noiommu
Message-ID: <agTOaMJGJGa9YQFk@google.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-3-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260511184116.3687392-3-jacob.pan@linux.microsoft.com>

On Mon, May 11, 2026 at 11:41:07AM -0700, Jacob Pan wrote:
>From: Jason Gunthorpe <jgg@nvidia.com>
>
>Create just a little part of a real iommu driver, enough to
>slot in under the dev_iommu_ops() and allow iommufd to call
>domain_alloc_paging_flags() and fail everything else.
>
>This allows explicitly creating a HWPT under an IOAS.
>
>A new Kconfig option IOMMUFD_NOIOMMU is introduced to differentiate
>from the VFIO group/container based noiommu mode.
>
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
>---
>v5:
>   - Use the new IOMMUFD_NOIOMMU Kconfig instead of VFIO_NOIOMMU
>   - Use consistent wording referring to VFIO noiommu mode (Kevin)
>   - Copyright date fix (Kevin)
>v4:
>   - Make iommufd_noiommu_ops const
>v3:
>   - Add comment to explain the design difference over the
>     legacy noiommu VFIO code.
>---
> drivers/iommu/iommufd/Kconfig           |  13 +++
> drivers/iommu/iommufd/Makefile          |   1 +
> drivers/iommu/iommufd/hw_pagetable.c    |  15 +++-
> drivers/iommu/iommufd/hwpt_noiommu.c    | 102 ++++++++++++++++++++++++
> drivers/iommu/iommufd/iommufd_private.h |   2 +
> 5 files changed, 131 insertions(+), 2 deletions(-)
> create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
