Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C651DF739
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742527327; cv=none; b=rcPkOc3yq1nPbs/ojdNQqnjNydScQXVxqW6BQb/PAX9PJwritPLrcj4z1DIl8FeqQjWQG8JZs8Jkb/lCYp4yf9dLLEh5cKoAAAh6HaRwHwk01Kj+WcZnnqUYwkUW5l04kRjpRzTmXZZrNcCUoyr8woWkWV7/npgLf/26He/NPDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742527327; c=relaxed/simple;
	bh=iWnBRKgQfCm6dQYsjrgF/LO3aAM7fgKNCyCCt78z3Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYxFf4jzI/ldearL8x33MBs854VTHjxN98wjAUXKARDz57Nkn+TikgR1AoULQ4Qa3AAjILbkldM0NQKpUrArgeV2iRi5xrZVEoyl1fjetP0DqlORwEEV0f6JrQXCE+k6Rof3IraoijvNU6OMaIaJDpIhXob4gMk5a5kYSMn6Nho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsAUMIXR; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsAUMIXR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742527324; x=1774063324;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iWnBRKgQfCm6dQYsjrgF/LO3aAM7fgKNCyCCt78z3Yo=;
  b=SsAUMIXRsz/uMQbhseR6VleFcBEB74LUpyds+FEpvIz3aU5+bGkc2fRv
   i0+LehaWIxgjmhh++Ve74LQkIydiYxbmJdZEgZETmY0Sj9lZbncRZLQ1M
   0y/YbpJ5/bNNSnCgyv196ODsM5MkxtctfX7YM06XmL/6T5S7SnyLUZNzN
   IQy5Iqq6PJls8lJSe3P1+my41hBqlKqrNf4hkpSHvocQ9busL+5rL+jAa
   biPJhwhndHfy28+nffPu1H/mZIXWgv5uL160BYUiocKeJ0A7d2e6bH5PZ
   5S05xiv5lPpfvKoKf2ijWFgzquoDAM+hUMAwVd4BMiWFdWJSoYerNkQ+z
   Q==;
X-CSE-ConnectionGUID: JAaINCffSFKbkt3PYpH1Nw==
X-CSE-MsgGUID: ym8cCX2aT1KHAPK21V7vrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="55169019"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="55169019"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 20:22:04 -0700
X-CSE-ConnectionGUID: +clDfEGGTwSwOJ8/LnXNAQ==
X-CSE-MsgGUID: 8YsbXBcmTZe/2CbJ7yuG2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="128392867"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 20:22:02 -0700
Message-ID: <85c2b397-7b96-4648-982e-59ac2fedb48a@linux.intel.com>
Date: Fri, 21 Mar 2025 11:18:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/18] iommufd/device: Add helper to detect the first
 attach of a group
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux.dev, nicolinc@nvidia.com
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-7-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250320134744.5777-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 21:47, Yi Liu wrote:
> The existing code detects the first attach by checking the
> igroup->device_list. However, the igroup->hwpt can also be used to detect
> the first attach. In future modifications, it is better to check the
> igroup->hwpt instead of the device_list. To improve readbility and also
> prepare for further modifications on this part, this adds a helper for it.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
> v9 -> v10: It is patch 07 of v9, it's reworked hence renamed as well.
> ---
>   drivers/iommu/iommufd/device.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index ac54d734b819..9db36346328f 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -444,6 +444,13 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
>   	return 0;
>   }
>   
> +static inline bool
> +igroup_first_attach(struct iommufd_group *igroup, ioasid_t pasid)
> +{
> +	lockdep_assert_held(&igroup->lock);
> +	return !igroup->hwpt;
> +}

Nit: avoid inline helpers in the C file. Others look good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
