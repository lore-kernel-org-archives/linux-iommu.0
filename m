Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034F389104
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781641096; cv=none; b=bl9oH7LXo75t7N4NWktRK84+a58sicRfX0PRrqVjPmJ1NKI7+2DotKYnFx5bWwOEvQzW+MRAArCa5ws+6KT1pcJqmVv0MhRSQZw3yqeQkbnKY+yw9XM/F6NeLPgaHQwWJm+LIm9s07s7uezYPHDvemRD+qLZcGhFrVdEIxdHQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781641096; c=relaxed/simple;
	bh=Y3MG0dey+WorwLfZ/iABdp39TkDt/9ppHxmDi9BUIAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuA6lLEZ0pI3PjdL8dEUzpyIAwvryyOM+1IXdHtsOnTDFUCN43LG2sN2wdUV5zcf2TznFOo1ndE//BKszZlUNYzeQoheGjaP/eJd991VdRKX+LfLdQMLe5P+ZamsydFSFbr6ktxzWE/QoNEYURgHlm4SjHmnG2Fql2xQ+53nDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MyE7FD/L; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MyE7FD/L"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c6a4eccab1so2935ad.1
        for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781641095; x=1782245895; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ekeo93H4IkViidGXaNTVyvKiJzNOYNB42Mr4fQp0DLo=;
        b=MyE7FD/LzzJQu/ovv/xS9eKxtBPs05pJ+5YqNDgup21t0IJkaBBazkN9s66xmmzOdA
         /69mjfRJDYcdyhJJESnW5pmDEPAsNqHCc9Jz+WU9BbNVOldU11ZJ6sZD0iT4IwU9/CNb
         QE6dklpHBa6vAEJEnu9lQpTIy9Yoi3AB/NZh+SRO50Teqp16I1T7udzaUNG6Hf1DOG3H
         lKwsSwco5lnDy93hQHVRPOS8Iy3u+6DU22L5iCcIXOlmYg9y+AmCfC8fng1ImRo8L9Kk
         cwlOlUAbFMfKOt0esvOLgX5sO70tSB0IvqxKJv9W5sAGV23pMDOqGGKuy5cUhm1iUxol
         kdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781641095; x=1782245895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekeo93H4IkViidGXaNTVyvKiJzNOYNB42Mr4fQp0DLo=;
        b=NNR0ziXQGQJ1lY/CZVlsiEJWjkWh7XKLfVMqKUY/N9DKu750CvEe6linDNbGR2tcQS
         w/Bi6nkx3JDRUmRyDQMtvgbSZFV1E2nl5101Gxcz1WRNCuWK9cV4H82Iq9d/TSmZiMsP
         MzLRGxfGtrCbzZ9lgZw6YmwBEsH7z1T7/Ul2n+uysMlSdvid1zZ2AuoFVd3M0pHpULb/
         T85u8c71IUY6AnG4o/q6e3lhyEm2PLmC9fUAd5Xz/kUT3HVSwp9yJgL1psxOgauUUwhp
         Z3atx87zqQdmk3OFuuXO2TEWrhHQqbHCt3EPsmNH5wjp0W0AsVmAVB8F7hS/2xnib6gJ
         dILA==
X-Forwarded-Encrypted: i=1; AFNElJ/p5mckmtzae/bhPvCBWeAaNlX84nMfrfnqh9dZ/EjqXSxlS1sGFxd6KhFt++fNfTxKlobAgg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywdkvv6sc8EisuXj6xHLzIbZm/+RHW+mkiGU5tBMoMoGd+OPhEh
	K2pvpYUY6mlIUGS5ITfrFBfx+iHIo6SvlCba9m5MQ+k5vvIs6S8bLjL4jtAYrXZ4oA==
X-Gm-Gg: AfdE7cl92z/Tw2vnr+MOqd5o60hahHitxb7QbJ0CtOiaPcbODERtNnrgh6qaiQVlmh9
	fQRHod6fuw7T1WAL3ZW+l3D/dFC3cln7WD9xhcSYpKvtd4Yr/XUjWyc/QvpZr/a1toIC3JDtw3O
	UObOvS3zXhs4bERJkvac9hVl5n101b6TuTCnrYooTdIL7yFZPX+c8F6Aq0yHuOpNlVfkbXtOswP
	oKhl213z/OykDAo64dzGEc9CwbL8nV4g/ql3o+raOe0CARqBozN/MkStpIQvvLA5r2XzVEs8pg9
	+nGZpri3dR3kj/qhFlkrtI7fbg0R3rTp0IoKXoUzqzCsUaYN5rEWBnMvywuZcNPGcWiEjgGX5sB
	z1nMbalShR+WkNzH3JSi+dGxpDNUqJzNfln98Aw6QtKnaWKaA3SQwSgHXUM3zNMWcIhQTq9KPX9
	r5aV4K9wV1GSurkTXhZpeavxDYcTe2jN1yDLD4t37jzKMjKlqZFrtWT7YngElJ
X-Received: by 2002:a17:902:da8b:b0:2c0:c14c:bf37 with SMTP id d9443c01a7336-2c6bb8be5a4mr583025ad.16.1781641094236;
        Tue, 16 Jun 2026 13:18:14 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86651af0edsm11921031a12.32.2026.06.16.13.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 13:18:13 -0700 (PDT)
Date: Tue, 16 Jun 2026 20:18:06 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v9 1/6] iommufd: Support a HWPT without an iommu driver
 for noiommu
Message-ID: <ajGvfqjkZ3I1E-hA@google.com>
References: <20260611172658.3421138-1-jacob.pan@linux.microsoft.com>
 <20260611172658.3421138-2-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611172658.3421138-2-jacob.pan@linux.microsoft.com>

On Thu, Jun 11, 2026 at 10:26:53AM -0700, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Create just a little part of a real iommu driver, enough to
> slot in under the dev_iommu_ops() and allow iommufd to call
> domain_alloc_paging_flags() and fail everything else.
> 
> This allows explicitly creating a HWPT under an IOAS.
> 
> A new Kconfig option IOMMUFD_NOIOMMU is introduced to differentiate
> from the VFIO group/container based noiommu mode.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> V8:
>   - Guard vIOMMU and vDevice allocation paths for noiommu (Sashiko)
> v7:
>   - Drain no-IOMMU generic-PT freelist (Sashiko)
>   - Import generic-PT IOMMU namespace (Sashiko)
> v6: (Yi)
>   - Sort includes alphabetically (iommu.h after generic_pt/iommu.h)
>   - Fix comment: s/mock page table/SW-only page table/ to avoid confusion
>     with selftest mock
>   - Rewrite noiommu_amdv1_ops comment: explain why AMDV1 format is chosen
>     (multi-page size options), remove references to group-container mode distinction
> v5:
>    - Use the new IOMMUFD_NOIOMMU Kconfig instead of VFIO_NOIOMMU
>    - Use consistent wording referring to VFIO noiommu mode (Kevin)
>    - Copyright date fix (Kevin)
> v4:
>    - Make iommufd_noiommu_ops const
> v3:
>    - Add comment to explain the design difference over the
>      legacy noiommu VFIO code.
> ---
>  drivers/iommu/iommufd/Kconfig           |  12 +++
>  drivers/iommu/iommufd/Makefile          |   1 +
>  drivers/iommu/iommufd/hw_pagetable.c    |  19 ++++-
>  drivers/iommu/iommufd/hwpt_noiommu.c    | 105 ++++++++++++++++++++++++
>  drivers/iommu/iommufd/iommufd_private.h |  12 +++
>  drivers/iommu/iommufd/main.c            |   1 +
>  drivers/iommu/iommufd/viommu.c          |  14 +++-
>  7 files changed, 158 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c
> 
> diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
> index 455bac0351f2..6c3bea83631b 100644
> --- a/drivers/iommu/iommufd/Kconfig
> +++ b/drivers/iommu/iommufd/Kconfig
> @@ -16,6 +16,18 @@ config IOMMUFD
>  	  If you don't know what to do here, say N.
>  
>  if IOMMUFD
> +config IOMMUFD_NOIOMMU
> +	bool
> +	depends on !GENERIC_ATOMIC64 # IOMMU_PT_AMDV1 requires cmpxchg64

Nit: Should we explicitly depend on 64BIT here?
I see further in the patch we assume 64-bit addresses:

+	cfg.common.hw_max_vasz_lg2 = 64;
+	cfg.common.hw_max_oasz_lg2 = 52;

> +	select GENERIC_PT
> +	select IOMMU_PT
> +	select IOMMU_PT_AMDV1
> +	help
> +	  Provides a SW-only IO page table for devices without hardware
> +	  IOMMU backing. This uses the AMDV1 page table format for
> +	  IOVA-to-PA lookups only, not for hardware DMA translation.
> +	  To be selected by VFIO_NOIOMMU when VFIO_DEVICE_CDEV is enabled.
> +

Apart from that,
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
