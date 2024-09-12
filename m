Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F67F1A2C1B
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140158; cv=none; b=ccQXCiFlvO1Wv4A8sgAqof2FQDeKx2Q8yDyRmLeGgytAGedQJagTtbIkiX/nYX8wnHEx4EvNVxk5EBDIERAnga+jiqWnzewruowMW0u36XPh6kJ5KCpeKIvmLSe0Yyj8XMTguMLawDZZUeuOsl3X4hpgNQFAIGNExc3CxkP3LK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140158; c=relaxed/simple;
	bh=QCP4AJW1JaH+8hd8JK1O6YZA3Brj57hPM3FVDUPpbmk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m+HT882tMbIkKNTGgXPrzgS3XFht0i64s+aEpiHK7wfp0jFEC12KVCCvJfQD6EIgtpQawqeKmDAe7Rg8xyDLliEIdZqS1uD3uadXbwjxGZOo+acIr5X2/fIJ2EV2DEksDQMDh3e7uxOgFbvaCRXaXcRrV6GgxuNazSY+csjZcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbMlHKaJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbMlHKaJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726140157; x=1757676157;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QCP4AJW1JaH+8hd8JK1O6YZA3Brj57hPM3FVDUPpbmk=;
  b=SbMlHKaJKPb3RkjPssh2XkAkQUkePv0t19UDNuP4FgZIDeUEUTsPrq78
   GgA4+YB8TIfZuaSRnOuFTkhp4jmtnBY/EDZQisq5BkI47eDsY+vyf523v
   Szn5m6RlJ+h06nk2MgosH3KOnxA39/+a5FKKzWmADIIecQOyigpLnQ4oJ
   JhsGY1wtujc+O9b114nYjxGv11dTK/knpyi5YMA5y2yMB+Gx1vBH9QfJo
   1raBUvq0beumzP18hmKamRoXh/l/QurkSC+yuQGXdicZ7fAcyslX0tYAN
   ygbwX79p7j6e1fOYub1/craayfxAE6M4FzwQ2D4U+IgQgdF9pjgl8QVod
   Q==;
X-CSE-ConnectionGUID: u7tmvmU8SyKYeoyzqI6tbg==
X-CSE-MsgGUID: RYms74cmS0KOODvTHgho2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="35575309"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="35575309"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 04:22:35 -0700
X-CSE-ConnectionGUID: xohJ6hctR+W48kSoxFT5Mw==
X-CSE-MsgGUID: EDwLMJCnSgGiUkvmSpO/+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="72463031"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.239.20]) ([10.124.239.20])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 04:22:33 -0700
Message-ID: <71f61d8a-9188-4e67-88ca-e5b48a91e6b5@linux.intel.com>
Date: Thu, 12 Sep 2024 19:22:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 5/6] iommu: init pasid array while doing domain_replace
 and iopf is active
To: Joel Granados <j.granados@samsung.com>
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
 <20240904-jag-iopfv8-v1-5-e3549920adf3@samsung.com>
 <CGME20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118@eucas1p2.samsung.com>
 <c2e765a8-d935-42db-bd22-c12e7960f2f0@linux.intel.com>
 <20240911105657.iesajd4d5va3wc5y@joelS2.panther.com>
 <b7a68539-3a3c-4cd9-922b-bfb9db8e7e0b@linux.intel.com>
 <20240912082512.ydzmmlwpvkcukbt2@joelS2.panther.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240912082512.ydzmmlwpvkcukbt2@joelS2.panther.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/12 16:25, Joel Granados wrote:
>   /**
>    * iommu_attach_group_handle - Attach an IOMMU domain to an IOMMU group
>    * @domain: IOMMU domain to attach
> diff --git i/drivers/iommu/iommufd/fault.c w/drivers/iommu/iommufd/fault.c
> index ea7f1bf64892..51cb70465b87 100644
> --- i/drivers/iommu/iommufd/fault.c
> +++ w/drivers/iommu/iommufd/fault.c
> @@ -189,8 +189,15 @@ static int iommufd_init_pasid_array(struct iommu_domain *domain,
>   	if (!handle)
>   		return -ENOMEM;
>   	handle->idev = idev;
> +	handle->handle.domain = domain;
> +
> +	mutex_lock(&group->mutex);
> +	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
> +	mutex_unlock(&group->mutex);
> +
> +	if (ret == -EBUSY)
> +		ret = 0;
>   
> -	ret = iommu_init_pasid_array(domain, group, &handle->handle);
>   	if (ret)
>   		kfree(handle);

This is supposed to be done automatically when an iopf capable domain is
attached to or replaced with a device. Please refer to
iommufd_fault_domain_attach_dev() and
iommufd_fault_domain_replace_dev().

Is there anything preventing this from happening?

Thanks,
baolu
