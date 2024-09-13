Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF70E155A47
	for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263596; cv=none; b=CzAH7sUP4c/Uf+5D9VBt0nFdvG/04kVsGfWGXWcV+6E9TG3ar+eqld0VeLpnmP1ggMvPaHpNsdiHiTerxnpHa4gw9VYXBBivME8b16IPQMY713HFxFsTAW0B9zll3TVu5QhbBEILuFB+GK0vOANQtMCDcM0DQ5QB3SInKDO2vZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263596; c=relaxed/simple;
	bh=72CZFpMlE7Q1P0ikFZiM/g9UNnG/aDOUSDV63qQwbX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEgJ6TYDQfpTvp12w9S7TXI+grEntzLWD0Qtp+iGx46T+eeJIQUE6PU+VK7yy9rhdpfKlJU5CYXlnpO6Ho68bu6e8+iB+ZPOeRiG+kD8H30cMvbDHRGb+jK8bCoq5Z0Ih++AXevQu6xiRoeWdOu0TwT2ABHzPIJK+1gJJOO/GyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TZQHxBxK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TZQHxBxK"
Received: from DESKTOP-0403QTC. (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 25E3520BE5BA;
	Fri, 13 Sep 2024 14:39:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25E3520BE5BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726263588;
	bh=3Zn9ZYNTvGBsbVI3PYzpZmCVg/uY8mvJQs7DVw6EW+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=TZQHxBxKxTWzA7ZssD+i49aB+cv+JnSvZnUXHuvr3183Mfg1Rd+/kVKkRsHztv/lX
	 jL/N9ZiBep8mpWVo5G49f6Ru9pykm/819BTpt4Q5+OHLluZOMnxQc4k7P604us8OG3
	 hIIGQ+gWbdbdVIBavfy2R+DLfPlPn1SvvvfQxtgM=
Date: Fri, 13 Sep 2024 14:39:45 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
 <robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>,
 <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 5/8] iommu/amd: Pass page table type as param to
 pdom_setup_pgtable()
Message-ID: <20240913143945.4499e7e0@DESKTOP-0403QTC.>
In-Reply-To: <20240911101911.6269-6-vasant.hegde@amd.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
	<20240911101911.6269-6-vasant.hegde@amd.com>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Vasant,

On Wed, 11 Sep 2024 10:19:08 +0000
Vasant Hegde <vasant.hegde@amd.com> wrote:

> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2285,28 +2285,13 @@ struct protection_domain
> *protection_domain_alloc(unsigned int type, int nid) }
>  
>  static int pdom_setup_pgtable(struct protection_domain *domain,
> -			      unsigned int type)
> +			      unsigned int type, int pgtable)
>  {
>  	struct io_pgtable_ops *pgtbl_ops;
> -	int pgtable;
>  
> -	switch (type) {
>  	/* No need to allocate io pgtable ops in passthrough mode */
> -	case IOMMU_DOMAIN_IDENTITY:
> +	if (!(type & __IOMMU_DOMAIN_PAGING))
>  		return 0;
Now that you pass in the pgtable format explicitly, I think you can
delete 'type' parameter and move this check to do_iommu_domain_alloc().
As you mentioned in [4/8], pdom_setup_pgtable() is factored out for
setting up page table only.

Other than that,
Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
