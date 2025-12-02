Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7517124BBF4
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 02:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642124; cv=none; b=DlN0hHvgPqHkzKqaz9RClzsSnp5giSw+IrD3BBIXCfddTkmYv69XojiLVf6EzGNiAg4Ub7bWhMjPmsXNndjwBDPHDlkfHGscd9h978ByvEc7DqxgkMVW2KU0C/5646iwDAOpammkVprjWEZX6mYK44Is5Mpwh/I2dRUp1OlU2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642124; c=relaxed/simple;
	bh=dpas8Oj4TRsn+P0O6MoXpBjhKhSe8cngwuBQy05Th6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csKJ2E4/i+q5IbzH7ZFvFjEDSAASo3L66iKH5AKgCWyYDSPEvUhGb7lFeBeu+zttH+7tP8TwxcCEsteJopYNZ95zGtIUIjyykOxm9GPEE0nYiVrbi7LhY4hULR/7bVd3q6Frr3uK9YI6VBzfRJisxcT7owONWvejz7JNkCgLv0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7+7BVla; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7+7BVla"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764642122; x=1796178122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dpas8Oj4TRsn+P0O6MoXpBjhKhSe8cngwuBQy05Th6Q=;
  b=G7+7BVlaSa0TkZeJrwLON4BUi79vdd/kaKTKKSBSjHrddEr+83Fn4d9e
   cZymeYnyJzwqCPioixWII+7U92tXOkpH6eb/u3L6k39uEkfUFwbZK5nxN
   EQbNaUwesO/9vNWv5lKilljvgwuVtakZvTz/343uE2JJnnc/Gd1TLJ2wy
   IZUFInNyGrJ+WAFOt0lqxMo61JjW5ax867gL91ffENJcbaDEhjWTZFnpF
   L12OtGPRvw2h2DoHsYH84CQtmiI8Sj1XtKfv9KAANeOlTKNitC/EN4JAN
   lwC9wFhw0YsTmCIvrWKrUFOZO24cFkMkvMhnAJyoG2FqliIbUcMK7e1x5
   A==;
X-CSE-ConnectionGUID: 5ZfgxygjQdOjnRE20b5orw==
X-CSE-MsgGUID: 9L3PzzosTtWcxjShFpglZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="65785612"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="65785612"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 18:22:02 -0800
X-CSE-ConnectionGUID: oA3R/031T5aNIEmwYitPOw==
X-CSE-MsgGUID: DYgA30aVTUKAxheDoipu+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="194118262"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 18:21:58 -0800
Message-ID: <f88707d4-bd04-4e9b-8d4b-ccb679d70dae@linux.intel.com>
Date: Tue, 2 Dec 2025 10:17:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/8] iommu: Add a helper to check if any iommu device is
 registered
To: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Cc: skhawaja@google.com, pasha.tatashin@soleen.com,
 Zhang Yu <zhangyu1@linux.microsoft.com>,
 Jean Philippe-Brucker <jean-philippe@linaro.org>,
 David Matlack <dmatlack@google.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
 <20251201173012.18371-3-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251201173012.18371-3-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jacob,

On 12/2/25 01:30, Jacob Pan wrote:
> The dummy IOMMU driver for No-IOMMU mode should only be active when
> no real IOMMU devices are present in the system. Introduce a helper
> to check this condition, ensuring that the dummy driver does not
> interfere when hardware-backed IOMMU support is available.
> 
> Signed-off-by: Jacob Pan<jacob.pan@linux.microsoft.com>
> ---
>   drivers/iommu/iommu.c | 10 ++++++++++
>   include/linux/iommu.h |  1 +
>   2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0df914a04064..958f612bf176 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2895,6 +2895,16 @@ static const struct iommu_device *iommu_from_fwnode(const struct fwnode_handle *
>   	return ret;
>   }
>   
> +bool iommu_is_registered(void)
> +{
> +	bool registered;
> +
> +	spin_lock(&iommu_device_lock);
> +	registered = !list_empty(&iommu_device_list);
> +	spin_unlock(&iommu_device_lock);
> +	return registered;
> +}

IOMMU devices might be added by calling iommu_device_register() at any
time. Therefore, an empty iommu_device_list does not necessarily mean
that "no real IOMMU devices are present in the system."

Thanks,
baolu
