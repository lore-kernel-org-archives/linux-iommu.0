Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19C1B6CE6
	for <iommu@lists.linux.dev>; Tue,  5 Nov 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730810000; cv=none; b=fnGMJaCz+PeZwT1VxmRxgPZQbc74nzpq1r9Mdj1+AJiZBQsiZelkcRakjk9wByTT1ReQKQYT7/0g+UrqISOzygfM0PBbaqPXwTbMcj1bX0c3qljmCavIRmRatwvLLgIsjokLOy9OBI/Ug2Vs5Ar/+KwH2+sDvBFkphtnO3KfVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730810000; c=relaxed/simple;
	bh=SH5DObzbxDzcGOGT6e2U6FN5pyTuB1giwH54NIrhXxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWyp3UdBdDCirRGwMsdUA++meE10TTIj/EQpnjz7j6wKjjuXmEHgJq5gzW5ByRcPwRBFoDN0ywccBKP0bIdd/6v6bmKtOFh0Hi9uVqfzr8uOkoycPzPctH76oPAa7N+NLS6tQr/l1ctHfxygW9NNdvH6SeI87fCt7mEvQyVC3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=54HenCmx; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="54HenCmx"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 23D252A8B28;
	Tue,  5 Nov 2024 13:33:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730809998;
	bh=SH5DObzbxDzcGOGT6e2U6FN5pyTuB1giwH54NIrhXxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=54HenCmxp1Q5b1qnTOXrFhYFbAYiiuk9WlkG/uTEqvwpLwd7d+iAasBG2BaAh528u
	 iCPjnuIe+mE0DiaqAoq4KGfDywhrO8nuamcBQuy+tJcI+lrhls1xd7/88qXvp6vHN3
	 aV6kJFFUyRSq8UQ345VY90+4YjEDxL244vvBZqUON13b1D5Fsc9NNZA+JLPYAUPWib
	 LnLPrZqmlKAXGKbxRqztTZh4MzY2u+LeDlmOKqUMdn86ucf3fVtdEmLwPXLROOct0m
	 /rQmIUMou6cf3Z40mIDTaXONl3JQ6vQi/mlWugUn7Ui3PbRbsq5Ot+yAM9kwamXg9k
	 bDIIvZtvIF8ig==
Date: Tue, 5 Nov 2024 13:33:17 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] [PULL REQUEST] Intel IOMMU updates for v6.13
Message-ID: <ZyoQjZH3aoBOfbx5@8bytes.org>
References: <20241104014040.106100-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104014040.106100-1-baolu.lu@linux.intel.com>

On Mon, Nov 04, 2024 at 09:40:20AM +0800, Lu Baolu wrote:
> Andy Shevchenko (1):
>   iommu/vt-d: Increase buffer size for device name
> 
> Dr. David Alan Gilbert (1):
>   iommu/vt-d: Remove unused dmar_msi_read
> 
> Jinjie Ruan (1):
>   iommu/vt-d: Use PCI_DEVID() macro
> 
> Joel Granados (3):
>   iommu/vt-d: Separate page request queue from SVM
>   iommu/vt-d: Move IOMMU_IOPF into INTEL_IOMMU
>   iommufd: Enable PRI when doing the iommufd_hwpt_alloc
> 
> Klaus Jensen (2):
>   iommu/vt-d: Remove the pasid present check in prq_event_thread
>   iommu/vt-d: Drop pasid requirement for prq initialization
> 
> Lu Baolu (8):
>   iommu/vt-d: Add domain_alloc_paging support
>   iommu/vt-d: Remove unused domain_alloc callback
>   iommu/vt-d: Enhance compatibility check for paging domain attach
>   iommu/vt-d: Remove domain_update_iommu_cap()
>   iommu/vt-d: Remove domain_update_iommu_superpage()
>   iommu/vt-d: Refactor first_level_by_default()
>   iommu/vt-d: Refine intel_iommu_domain_alloc_user()
>   iommu/vt-d: Drain PRQs when domain removed from RID
> 
> Yi Liu (1):
>   iommu/vt-d: Drop s1_pgtbl from dmar_domain
> 
> Zhenzhong Duan (2):
>   iommu/vt-d: Fix checks and print in dmar_fault_dump_ptes()
>   iommu/vt-d: Fix checks and print in pgtable_walk()

Applied, thanks Baolu.
