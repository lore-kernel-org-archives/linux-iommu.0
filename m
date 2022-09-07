Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FA15C91
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 14:14:47 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id F0A832409A7;
	Wed,  7 Sep 2022 16:14:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662560087;
	bh=tPPU2UGF0chqil0RpZeP5ui2+4Lg6Hg3kcq900TvvvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0e1KvJMOMSlieCpKz7k9gDd5GjYJOwc5vrBoCzgix7hJEIdjFDRyb5i4HR0ALSleM
	 jGkdRQhFCC0I1p1Gb+naTorwJklXYa15qQF/TY5wpWmrWMAVuX3fUmrJPaMxni6zP5
	 B9KN0ltZ60R8gTZfYMjoWzt2GbQDarlnfANBAfitWW/wv6Kvaeoo5mikFAZ0aj0k/Y
	 uCjl8l1V0NocqDCdpdrDXTqLLmf2xz8NvtzHVFTuS0YH7rumjwcxipaYNF1WBURgd+
	 kcz81Fem9dlCpm7xLBq14c70J96LkAM0qLGM6ndDzKehd7A7Yc1JBVuE+MxpRlWXAn
	 RCqLguzaLZrRg==
Date: Wed, 7 Sep 2022 16:14:45 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Message-ID: <YxinVSaZV0ccQfnD@8bytes.org>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825063939.8360-1-vasant.hegde@amd.com>

On Thu, Aug 25, 2022 at 06:39:30AM +0000, Vasant Hegde wrote:
> Suravee Suthikulpanit (4):
>   iommu/amd: Refactor amd_iommu_domain_enable_v2 to remove locking
>   iommu/amd: Update sanity check when enable PRI/ATS for IOMMU v1 table
>   iommu/amd: Add support for Guest IO protection
>   iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API
> 
> Vasant Hegde (5):
>   iommu/amd/io-pgtable: Implement map_pages io_pgtable_ops callback
>   iommu/amd/io-pgtable: Implement unmap_pages io_pgtable_ops callback
>   iommu/amd: Add map/unmap_pages() iommu_domain_ops callback support
>   iommu/amd: Initial support for AMD IOMMU v2 page table
>   iommu/amd: Add command-line option to enable different page table

Applied, thanks.
