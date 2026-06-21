Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B5F1E7C12
	for <iommu@lists.linux.dev>; Sun, 21 Jun 2026 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782005364; cv=none; b=pX530tNXRH7SelUUJHrT9jB1eH6NdzpOiG7ozsvN+/+1qjuLLllmcYMEtQTlGQAnaJCbAOMbUL6ZSI/3tPNe4LvdoK3QfsHNtyNqEKbZTIbNn4jU6+me3WEnpLqhgH2MKqGCx0uJwGFYxbjnwwRi8cDZ90pLykp/u13Iplkg3Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782005364; c=relaxed/simple;
	bh=n4gcNnjcoEFUDh49zhBMUkrMqns10GW7OqVmBxWbF9o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EDM8jPAUlfUppDF6UTCD4jyytKAz0AQRrTE/lRYcWESuNpmOpmAb19MaIqXtIodegDHGUDcFM1KkPXF8vOSlbEMFgURDLc+nO+9tGKCEWau0cXtCMbY/Gvj14616+E8X9+auHSWnY5oxnLKjS24fF0Wr8pqX+3UhprSB8YLwAHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5YeH3m+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5YeH3m+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782005362; x=1813541362;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n4gcNnjcoEFUDh49zhBMUkrMqns10GW7OqVmBxWbF9o=;
  b=l5YeH3m+GwldakurhcCsaoIoA3+fQ4YYnqXm7eLqZclxdwWdvo6fZH/V
   HuvS2GHBeFvjhPWo80ZXhziwVrToB/8TxD5DIPI0gD6jwXfentslKBiEs
   94M55Ne49azrErWURWgQuFsvOG257xOInEs4Nby4xmxRtW+qWPM8T54ML
   ELhWmPEGnpn/85qxKF7B5nnGILZEcu8GdrRwEmuWTvFAaLlIFLTJuT7gr
   aBsHzV+2VXU4uutJj9SHgXSiQexMlTvonY7IjDYbjs1lD3GocT+p4UJUV
   U4/pg96CPxU5xlzOHPgCJFZq6sx9o7uAdpuS5niUpfHLwgI1NWhFNVl5d
   A==;
X-CSE-ConnectionGUID: nPtYAMcYRJq8jzG91ovgxQ==
X-CSE-MsgGUID: k6mQqrblSW6tl0nQN4qapA==
X-IronPort-AV: E=McAfee;i="6800,10657,11823"; a="94174144"
X-IronPort-AV: E=Sophos;i="6.24,216,1774335600"; 
   d="scan'208";a="94174144"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2026 18:29:20 -0700
X-CSE-ConnectionGUID: 7zdPoMnUSXq4ldov9AXttg==
X-CSE-MsgGUID: 1xP/+pxHTNyhRK8CyDOuwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,216,1774335600"; 
   d="scan'208";a="247770672"
Received: from unknown (HELO [10.238.9.114]) ([10.238.9.114])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2026 18:29:18 -0700
Message-ID: <7ebdaa50-2048-486e-9da4-145cea4e3753@linux.intel.com>
Date: Sun, 21 Jun 2026 09:29:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Disable IOMMU on Lenovo ThinkPad P50s
To: Oliver Lin <oliver@liuxiaozhen.dev>, dwmw2@infradead.org
References: <20260620192214.923500-1-oliver@liuxiaozhen.dev>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260620192214.923500-1-oliver@liuxiaozhen.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/21/2026 3:22 AM, Oliver Lin wrote:
> On Lenovo ThinkPad P50s, enabling Intel IOMMU causes TPM
> initialization failures, suspend/resume issues, and prevents the
> system from powering off completely.
> 
> The system works correctly with intel_iommu=off. A locally tested
> kernel with this DMI quirk also works correctly without requiring the
> kernel parameter.
> 
> Add a DMI quirk to disable Intel IOMMU on this platform.
> 
> Link:https://bugzilla.kernel.org/show_bug.cgi?id=221674
> Signed-off-by: Oliver Lin<oliver@liuxiaozhen.dev>
> ---
>   drivers/iommu/intel/iommu.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 849d06dfe1ae..a072e9ef63ef 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -278,6 +278,19 @@ static int __init intel_iommu_setup(char *str)
>   
>   	return 1;
>   }
> +
> +static const struct dmi_system_id intel_iommu_broken_dmar_table[] __initconst = {
> +	{
> +		.ident = "Lenovo ThinkPad P50s",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "20FLCTO1WW"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P50s"),
> +		},
> +	},
> +	{}
> +};

Is this a broken ACPI DMAR table? If so, please try updating to the
latest firmware. Otherwise, report the issue to the laptop vendor and
ask them to resolve it, especially if they claim their product supports
Linux.

Thanks,
baolu
