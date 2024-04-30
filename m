Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00396FC02
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472628; cv=none; b=e0LLUWbjLS+gKXaD3cytyY+KNmiCnndLR+8nqAU3fA9nLYiNagOh8/owGssRBFnZ0qGnaY3QW16WV+0cJRIyRsNDM+Lw8lqBP5Kebdwr7uZuCFtf9++b0EyWcD5QqGARzDX2CUTxz/6mwB5HgdZGwexnx7AJcP1Z0iQvao0Ro3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472628; c=relaxed/simple;
	bh=eLH+METm0AsTFQ6Y4g1s5b5xJ/ljP9ZtdjDuXyD+Kmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9V23vwCBoDsM+cPYL75oc355T4wAmLop72kixsXsIIsECbsjcJvCqCctOOv5J33/mO1BdCTmjcQ7Q7J6X9PS3FBDru78AUfGkrRPx0/iwAvTeUQD0lfrhWqTGklK3e6OtyFCcx4Hoyg8PpREud5KI28JYD2L7AfquL1WM4ep7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C1B2113E
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 03:24:13 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6716D3F73F
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 03:23:46 -0700 (PDT)
Date: Tue, 30 Apr 2024 11:23:29 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: will@kernel.org, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	sudeep.holla@arm.com, joro@8bytes.org, robin.murphy@arm.com,
	nicolinc@nvidia.com, ketanp@nvidia.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] iommu/of: Support ats-supported device-tree property
Message-ID: <ZjDGoT2kAmnilqVu@e110455-lin.cambridge.arm.com>
References: <20240429113938.192706-2-jean-philippe@linaro.org>
 <20240429113938.192706-4-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429113938.192706-4-jean-philippe@linaro.org>

On Mon, Apr 29, 2024 at 12:39:38PM +0100, Jean-Philippe Brucker wrote:
> Device-tree declares whether a PCI root-complex supports ATS by setting
> the "ats-supported" property. Copy this flag into device fwspec to let
> IOMMU drivers quickly check if they can enable ATS for a device.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Ketan Patil <ketanp@nvidia.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

> ---
>  drivers/iommu/of_iommu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 3afe0b48a48db..082b94c2b3291 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -105,6 +105,14 @@ static int of_iommu_configure_device(struct device_node *master_np,
>  		      of_iommu_configure_dev(master_np, dev);
>  }
>  
> +static void of_pci_check_device_ats(struct device *dev, struct device_node *np)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	if (fwspec && of_property_read_bool(np, "ats-supported"))
> +		fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
> +}
> +
>  /*
>   * Returns:
>   *  0 on success, an iommu was configured
> @@ -147,6 +155,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>  		pci_request_acs();
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
>  					     of_pci_iommu_init, &info);
> +		of_pci_check_device_ats(dev, master_np);
>  	} else {
>  		err = of_iommu_configure_device(master_np, dev, id);
>  	}
> -- 
> 2.44.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
