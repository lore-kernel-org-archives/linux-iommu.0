Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4715FCE1
	for <iommu@lists.linux.dev>; Fri, 10 May 2024 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332416; cv=none; b=Qmeqv4IEyyjI+3sFoNgmeOTyKFwP244GzswMAd2rME8hhWAUlJL8i0Y12P8SYWTQnQxbBPmUKRHR1kWkV023Zbi+RqSChXKu4ruplTMMUXTTyKvjeWddH5gHd3/jKAchpgLjNTSkyso3dNxVFxpODTJBtbPDeLws8k5S+c7Kho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332416; c=relaxed/simple;
	bh=TF+PTbkgSx0ZnPRn+1LyMRtzCYZzLtwMrn37b5euxao=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QDKqtsJsX4V8BAhGUqlw+Ik6q0OxSI3aosrHR71OB8Mgt9obsKKWnnHJOpsb5noufGKJOlrezSFNrIMMsBFiekYni2J0raCIY2kZDlXvTSn4/c5uS9fgCeTjRKdns0KsnRPHpcpWqyLBSID7nfuVcyUM/JnzfFsfqrbi0kUsadY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhhkvkLM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhhkvkLM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715332415; x=1746868415;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TF+PTbkgSx0ZnPRn+1LyMRtzCYZzLtwMrn37b5euxao=;
  b=XhhkvkLM2QzrS6snlZoF+lY7ZW7xlc4lmW80d8+i/guPgSrTPOcmOvYT
   mkvRp4XMXuL+xK9h3YFOJbcoBK9NQC7IiKMKlSEaGa/Ts98Lh2uBm8g+x
   3u4A1tD7VT22M1maBswS5H2CLV21eDLI3qDO1If0dYVt8oan2hNQOhQb7
   oYq5IqztdP3zMdZ5kroA/p/3V5oHVx2XMiqpYRXzRfIlcmKMfHiz+DEky
   tzMrIDAPKCpLWUBr9WzEeCRCbmd3D1TqgQRoEP4WCLlFTGWCVhF7IId/T
   KEPemlJNi1hXAtcfNkaJNNpCvAeqhmCQowoubRnIjvzY2a+m7lF1nFmrY
   g==;
X-CSE-ConnectionGUID: nsHoVpE9TdmD0PH1ADkX2w==
X-CSE-MsgGUID: rIlUTLM4S/yDoCoHkRd/lQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21879091"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21879091"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 02:13:35 -0700
X-CSE-ConnectionGUID: HlxxGN5LQIqbfopkgkxtpA==
X-CSE-MsgGUID: rZ7SJb6RSguTrlxaCy7EDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29555229"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.100]) ([10.124.237.100])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 02:13:30 -0700
Message-ID: <b510a556-a8fe-4328-9917-e50ef074dfee@linux.intel.com>
Date: Fri, 10 May 2024 17:13:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <20240508002242.GP4718@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240508002242.GP4718@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/8 8:22, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 10:57:06PM +0800, Lu Baolu wrote:
>> +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
>> +				       size_t count, loff_t *ppos)
>> +{
>> +	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
>> +	struct iommufd_fault *fault = filep->private_data;
>> +	struct iommu_hwpt_pgfault data;
>> +	struct iommufd_device *idev;
>> +	struct iopf_group *group;
>> +	struct iopf_fault *iopf;
>> +	size_t done = 0;
>> +	int rc;
>> +
>> +	if (*ppos || count % fault_size)
>> +		return -ESPIPE;
>> +
>> +	mutex_lock(&fault->mutex);
>> +	while (!list_empty(&fault->deliver) && count > done) {
>> +		group = list_first_entry(&fault->deliver,
>> +					 struct iopf_group, node);
>> +
>> +		if (list_count_nodes(&group->faults) * fault_size > count - done)
>> +			break;
> 
> Can this list_count be precomputed when we build the fault group?

Yes. Done.

> 
>> +
>> +		idev = group->attach_handle->idev;
>> +		if (!idev)
>> +			break;
> 
> This check should be done before adding the fault to the linked
> list. See my other note about the race.

Done.

> 
>> +
>> +		rc = xa_alloc(&idev->faults, &group->cookie, group,
>> +			      xa_limit_32b, GFP_KERNEL);
>> +		if (rc)
>> +			break;
> 
> This error handling is not quite right, if done == 0 then this should
> return rc.
> 
> 
>> +
>> +		list_for_each_entry(iopf, &group->faults, list) {
>> +			iommufd_compose_fault_message(&iopf->fault,
>> +						      &data, idev,
>> +						      group->cookie);
>> +			rc = copy_to_user(buf + done, &data, fault_size);
>> +			if (rc) {
>> +				xa_erase(&idev->faults, group->cookie);
>> +				break;
> 
> Same here
> 
> (same comment on the write side too)

All fixed. Thank you!

Best regards,
baolu

