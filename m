Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457202FB63A
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764829471; cv=none; b=D70eHcsbfI2GK+vMR3esrxYgoJjS9kU5iBg6z37pIGKE3hRhsoqc++QmWgd6rQ/OTtyAYq6Dv/HUEEKG0KEmqW5pyiVzu0HLKy/hs3EXHwfMN80ZguZSdpe7CTbo+P/jYOb6T2TCJXDsyIDLnvaNNajNOBRx0Ok45Pfc/YIH15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764829471; c=relaxed/simple;
	bh=sJ0IwWHawIkgw3yjLjXtiQZqQ41/FLPLhj7cR8Hk0Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvPANkTW3B5APewMxCxGbo0W5hWCp+ueBvSjlH8M1XmImcpfOrMuG0QoEb0AWx7sr+00nNuhKCKOXbVfBC1SSTpvYKVjfbQMrA9GfRaKEY5IvIYgRqY0VonDvEiGyeMm8+cGLMq9dnpz7OMmwcjzWG01Lk3RPIW8r0EJL5mM1Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Go4X4D8B; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Go4X4D8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764829469; x=1796365469;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sJ0IwWHawIkgw3yjLjXtiQZqQ41/FLPLhj7cR8Hk0Uw=;
  b=Go4X4D8BSWk6b6x3mms5fwtz52Fx4HYaFWIibsvMEfSXZNeQbnRTsque
   a3psRhO26HNRteVFnjeHZkXRJbkNRhQJVRlbSxfAdaOOoBoc7RJaRtQra
   laA/ehRY0QWtEYsh7yXhKTxR85mL5+L0ovv5DZZoJ2pY/6eMMFcO8+MI7
   VujAqzhrz95h3IfY54lZrcsnqdKfYnh9n7R4NFoWWv+7+BPAdBtNwLCYN
   Rc/Bavs2z7Kjh0/QJzNtgXGd+Fy0Dy7xrNUcE90lsiV5WusA0fGv7JuwS
   24rQq0YnFa1M1c9f0MUBvWTqg9OVi4mMudsFsE1QdKtepso5zYSjCrXEs
   w==;
X-CSE-ConnectionGUID: XZKip0SDRu6iDAkOOIWK8Q==
X-CSE-MsgGUID: 63OLDQdfRXO3Tdx1C8e6oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="77521643"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="77521643"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 22:24:28 -0800
X-CSE-ConnectionGUID: ayqOopcKQqmrjBWRPlnc9w==
X-CSE-MsgGUID: VgO6nuZsQkSGXTU9hnLcYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="232218964"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 22:24:24 -0800
Message-ID: <9236c22e-f931-43a0-aafc-2179f53a0afa@linux.intel.com>
Date: Thu, 4 Dec 2025 14:19:54 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 20/32] iommu: Add APIs to get preserved state of a
 device
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav
 <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 William Tu <witu@nvidia.com>, Vipin Sharma <vipinsh@google.com>,
 dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>,
 Chris Li <chrisl@kernel.org>, praan@google.com
References: <20251202230303.1017519-1-skhawaja@google.com>
 <20251202230303.1017519-21-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251202230303.1017519-21-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 07:02, Samiullah Khawaja wrote:
> The preserved state of the device needs to be fetched at various places
> during liveupdate. The added API can also be used to check if a device
> is preserved or not. The API is only used during shutdown and after
> liveupdate so no locking needed.
> 
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   include/linux/iommu-lu.h | 67 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
> 
> diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
> index 95375530b7be..08a659de8553 100644
> --- a/include/linux/iommu-lu.h
> +++ b/include/linux/iommu-lu.h
> @@ -8,9 +8,76 @@
>   #ifndef _LINUX_IOMMU_LU_H
>   #define _LINUX_IOMMU_LU_H
>   
> +#include <linux/device.h>
> +#include <linux/iommu.h>
>   #include <linux/liveupdate.h>
>   #include <linux/kho/abi/iommu.h>
>   
> +#ifdef CONFIG_LIVEUPDATE
> +static inline void *dev_iommu_preserved_state(struct device *dev)
> +{
> +	struct device_ser *ser;
> +
> +	ser = dev->iommu->device_ser;

This might cause "NULL pointer dereference" issue if the device is not
iommu probed.

	if (!dev->iommu)
		return NULL;
	ser = dev->iommu->device_ser;

> +	if (ser && !ser->obj.incoming)
> +		return ser;
> +
> +	return NULL;
> +}

Thanks,
baolu
