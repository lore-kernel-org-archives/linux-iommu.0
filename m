Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CA738FB0
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708495588; cv=none; b=UmsQn6qpe4+1SP8GJJnPEYasijqstbathJzW8TBk1TPrtBkrg1FmJfnwdV6sd4ugRiZXAWnXhQ77flVXOWSX2TR0IFM/EcyPIBn2d65unDsUO0AM+AH3Z++0FYXD3O/eXrNT08+VriOF1phDbagOy+OO1RB5uOUjzqJgAS1xDSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708495588; c=relaxed/simple;
	bh=7Br77jPOvxXbE+vPj5DX/LCE+itwJHpwXrfu8hQtPCA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jJ4e+m6MeB93iC3XSPbs4rn95kjUAyD7gS7tN6Zr2kcFhQew5WMmovj4OURJNx4we47wBbaYlaDZ+Wd/on0kMpxM8MGR5Kl8TpeMukipTnpVqjQ4H93Ia2GDU/m86I/dyZSNwSA210xKTUxfZRkCUCdfedwjkZmkDcWtofN2+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mBNEKn7i; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mBNEKn7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708495587; x=1740031587;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7Br77jPOvxXbE+vPj5DX/LCE+itwJHpwXrfu8hQtPCA=;
  b=mBNEKn7it0NytvhUgCIiAS+j0TKMJT6iMFcrl30jnohhrAqRsIBqrJ4D
   o/O7+y7xFX2s1ijSU1VpCAhLaaH6dBzgxwvG134djT5/7jmNJqDRQjRer
   uG9GNVEVXyG3AB48rnrANPoF1mUJI1YaEi3xWFo8HJPb0qEyX4PT0GAiW
   yCc5XdfA6yBcaJMM25PwWT1A0d5Be2FzNsT645qoXm8OBL0dOFTBOfkXt
   5t8BQvptKok6kOGGCCwHiFTxRqzJpcUj8H5TkQPbmMQNCXUpoM0b2E9Bn
   QfbObOLjMHbVxbgJV+fs+D5ekPIKh5KM2THjlkQr9bZ6UxMaXXAXcf/c5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="20071179"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="20071179"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 22:06:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9677457"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.203]) ([10.249.171.203])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 22:06:22 -0800
Message-ID: <56519d16-88a3-4ed8-a973-e931d22c478e@linux.intel.com>
Date: Wed, 21 Feb 2024 14:06:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
 <BN9PR11MB5276C0BA42924298B650A5C28C452@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C0BA42924298B650A5C28C452@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/7 16:14, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, January 22, 2024 3:39 PM
>>
>> +
>> +int iommufd_fault_iopf_handler(struct iopf_group *group)
>> +{
>> +	struct iommufd_hw_pagetable *hwpt = group->cookie->domain-
>>> fault_data;
>> +	struct iommufd_fault *fault = hwpt->fault;
>> +
> 
> why not directly using iommufd_fault as the fault_data?

The relationship among these structures is:

     iommufd_hwpt -> iommu_domain
           ^
           |
           v
     iommufd_fault

It appears preferable to hook the hwpt instead of iommufd_fault to an
iommu_domain structure.

Best regards,
baolu

