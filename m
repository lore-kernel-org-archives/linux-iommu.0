Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3123D299
	for <iommu@lists.linux.dev>; Sat,  8 Jun 2024 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717840853; cv=none; b=Fg8V1ac+9GaIs+uk/JELd/vbPfRtbr6u+LEuo5ZQEAyTBTi986YNG/r0GibupqnZm/MypJvf+pyRTS5GNoM8+RlKZBB8pi7KJcJQf70XclRqUmUK9ukdU0XVN8K2nhIVjzcEZoprRe+QTIpUZI3fAP0IRhFQBSOCTD5A61n3Bjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717840853; c=relaxed/simple;
	bh=dD/2qxPjsTYcJBiszw6+m0kwHnKdGtPseKpmC/MTrdk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jyNUsaR0yMzykhRFbjozA6eNmw+DQQhM7saxEu8H7kHtCWhQKIYVvBMRCfHGL7VRleShfY/EHI/IXdrX+q1lg14kfAuc10PGErP/zz4OEIuh6XPSWxGKGVWPLdT7WeWTHRlNrJQF5EVdQMUdvi7O7ePCEJ0QxC8r0aCm4RrYLIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8sHOGgm; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8sHOGgm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717840852; x=1749376852;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dD/2qxPjsTYcJBiszw6+m0kwHnKdGtPseKpmC/MTrdk=;
  b=N8sHOGgmeJRIE+B7puXuRVfxk3wilCAFtwlXnaqGs9uEMPcGUYI341aa
   1PJ9vtHljl0spzUhrl/b4Db5G9UjsCnaZPzL4aUrEWRBJezJ9OsikRpwv
   vqnRFydrePRoUVFGdiDKf9E+p0e8XksbvAqicJbmTj4Rh7jp1sFLFAHjU
   pGo7ncdl0/gXFf/40Z3fTTQSCzg7ksRBulnCabUKJ5l2QBWsNxHGhFkPS
   dJg5qie9I0c6IzK1HyvPktY4q2lV45TKOP4OoDjxLZ+n8fOA9zSCXqecQ
   Of0OKhmdqP+H/kt0QqXHJiIb0FDm+3ZNZaNv6h4LtC05kNm7sLGIdLJSn
   A==;
X-CSE-ConnectionGUID: 7B+DuhmgRquDGiEN1oPMvA==
X-CSE-MsgGUID: ulUB5Ei1S5CmK/jruf4pmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14366487"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="14366487"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 03:00:51 -0700
X-CSE-ConnectionGUID: lcCbsdoTQd2NporVwlg6GQ==
X-CSE-MsgGUID: T9NVOjipTtmZfYc9dHtNOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="39004890"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 08 Jun 2024 03:00:47 -0700
Message-ID: <a17113d3-500e-45ef-a2d2-747d890c9c5e@linux.intel.com>
Date: Sat, 8 Jun 2024 17:58:34 +0800
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
Subject: Re: [PATCH v6 06/10] iommufd: Add iommufd fault object
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-7-baolu.lu@linux.intel.com>
 <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/7/24 5:17 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, May 27, 2024 12:05 PM
>>
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
>> +	int rc = 0;
>> +
>> +	if (*ppos || count % fault_size)
>> +		return -ESPIPE;
> 
> the man page says:
> 
> "If count is zero, read() returns zero and has no  other  results."

My understanding is that reading zero bytes is likely to check if a file
descriptor is valid and ready for reading without actually taking any
data from it.

In this code, it just returns 0 and it's compatible with the man page.
Or, I overlooked anything?

> 
>> +
>> +	mutex_lock(&fault->mutex);
>> +	while (!list_empty(&fault->deliver) && count > done) {
>> +		group = list_first_entry(&fault->deliver,
>> +					 struct iopf_group, node);
>> +
>> +		if (group->fault_count * fault_size > count - done)
>> +			break;
>> +
>> +		rc = xa_alloc(&fault->response, &group->cookie, group,
>> +			      xa_limit_32b, GFP_KERNEL);
>> +		if (rc)
>> +			break;
>> +
>> +		idev = to_iommufd_handle(group->attach_handle)->idev;
>> +		list_for_each_entry(iopf, &group->faults, list) {
>> +			iommufd_compose_fault_message(&iopf->fault,
>> +						      &data, idev,
>> +						      group->cookie);
>> +			rc = copy_to_user(buf + done, &data, fault_size);
>> +			if (rc) {
> 
> 'rc' should be converted to -EFAULT.

Yes. I will make it like this:

        if (copy_to_user(buf + done, &data, fault_size)) {
                xa_erase(&fault->response, group->cookie);
                rc = -EFAULT;
                break;
        }

> 
>> +				xa_erase(&fault->response, group->cookie);
>> +				break;
>> +			}
>> +			done += fault_size;
>> +		}
>> +
>> +		list_del(&group->node);
>> +	}
>> +	mutex_unlock(&fault->mutex);
>> +
>> +	return done == 0 ? rc : done;
> 
> again this doesn't match the manual:
> 
> "On error, -1 is returned, and errno is set appropriately."
> 
> it doesn't matter whether 'done' is 0.

I don't quite follow here. The code is doing the following:

- If done == 0, it means nothing has been copied to user space. This
   could be due to two reasons:

   1) the user read with a count set to 0, or
   2) a failure case.

   The code returns 0 for the first case and an error number for the
   second.

- If done != 0, some data has been copied to user space. In this case,
   the code returns the number of data copied regardless of the value of
   rc.

> 
>> +
>> +static int iommufd_fault_fops_release(struct inode *inode, struct file *filep)
>> +{
>> +	struct iommufd_fault *fault = filep->private_data;
>> +
>> +	iommufd_ctx_put(fault->ictx);
>> +	refcount_dec(&fault->obj.users);
>> +	return 0;
>> +}
> 
> hmm this doesn't sound correct. the context and refcount are
> acquired in iommufd_fault_alloc() but here they are reverted when
> the fd is closed...

These two refcounts were requested when the fault object was installed
to the fault FD.

        filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
                                    fault, O_RDWR);
         if (IS_ERR(filep)) {
                 rc = PTR_ERR(filep);
                 goto out_abort;
         }

         refcount_inc(&fault->obj.users);
         iommufd_ctx_get(fault->ictx);
         fault->filep = filep;

These refcounts must then be released when the FD is released.

>> +
>> +	filep = anon_inode_getfile("[iommufd-pgfault]",
>> &iommufd_fault_fops,
>> +				   fault, O_RDWR);
>> +	if (IS_ERR(filep)) {
>> +		rc = PTR_ERR(filep);
>> +		goto out_abort;
>> +	}
>> +
>> +	refcount_inc(&fault->obj.users);
>> +	iommufd_ctx_get(fault->ictx);
>> +	fault->filep = filep;
> 
> those 3 lines can be moved after below fdno get. It's reads slightly
> clearer to put file related work together before getting to the last piece
> of intiailzation.

The filep is allocated and initialized together.

>> +
>> +	fdno = get_unused_fd_flags(O_CLOEXEC);
>> +	if (fdno < 0) {
>> +		rc = fdno;
>> +		goto out_fput;
>> +	}
>> +
>> @@ -332,6 +332,7 @@ union ucmd_buffer {
>>   	struct iommu_ioas_unmap unmap;
>>   	struct iommu_option option;
>>   	struct iommu_vfio_ioas vfio_ioas;
>> +	struct iommu_fault_alloc fault;
> 
> alphabetic
> 
>> @@ -381,6 +382,8 @@ static const struct iommufd_ioctl_op
>> iommufd_ioctl_ops[] = {
>>   		 val64),
>>   	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct
>> iommu_vfio_ioas,
>>   		 __reserved),
>> +	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC, iommufd_fault_alloc,
>> struct iommu_fault_alloc,
>> +		 out_fault_fd),
> 
> ditto

Yes, sure. I wasn't aware of the order.

Best regards,
baolu
