Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C842B9BF
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 05:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811574; cv=none; b=czkaWAqS/cwG6KrVbyDmG9Asqaspnyt3jlfMcJiEYZ5dehi2ziGTkPfDLfBwe8/19UsdGN4Ef0WGI5il2TKR5rGZp3RRmKEiHz95f210Lxky6HcRrF1qYN+vg796aOVl3bAwDIAOdZtulEFb+LvxTEkzCrGpcVN/6yL1t9I/LbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811574; c=relaxed/simple;
	bh=/tu68GSOjhmpRwmyMKGYU43GgIJZE1jdm0HqetLJhkM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WamVvcLXy8bi9uwUvcHzctRoFiIoOSrEHToYaL1hN6uyMmmgfHIS1iLBu8Ums1tF8VqxqaCqTXG9spynuR+uZLeeBb5KwMdI7aOj+kTxqHi1waWPy14sYUZ34Y/qW5hYrgS8+0PEw9tYf7H6hYd7/h9dSDJfxEn+l+JRZ+dpDd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SvhyHZaW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SvhyHZaW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719811572; x=1751347572;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/tu68GSOjhmpRwmyMKGYU43GgIJZE1jdm0HqetLJhkM=;
  b=SvhyHZaW49u0wtt0tSjgHEKIYw1wXM1WmtVlNOD5mrfset3QxWTLEu9U
   61ECI/x/8PWzeIgjCOwFdCAbm5x5cUIMt86L28AqAJ3mfGBKxBap4EASu
   LCWGZCWYaVaO2bqspoT5XDxwebF9S9eVBIUjRFiqZVLLEFjEP2P8WBk4u
   f4qzclP4JwD9wwjC8dDjWZblfGw4dqcKiybSXb5qW40X1HSjfZSrXjOOT
   lk3GAqHWRBu8eLZTfFXk8sUFjmgD2TzdCYpHMKqSwPSMGFW+AG/XBVVTj
   LEcowHfN4CDVcODolTx4bY5x2940t3cfc+f0HZOAo4SWGKygLdbxej7kd
   w==;
X-CSE-ConnectionGUID: N68xtCETTPWSVfKDrG/Y+w==
X-CSE-MsgGUID: FNZpYmndQLCW540FBsFyfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="16865194"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="16865194"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 22:26:11 -0700
X-CSE-ConnectionGUID: tby6+totTpOKriQkdfBWfg==
X-CSE-MsgGUID: gpwHDaxBSKexORFIH2ayBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="45479058"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 22:26:09 -0700
Message-ID: <8f57eb6c-d1da-4638-9b3e-a159dbed9624@linux.intel.com>
Date: Mon, 1 Jul 2024 13:26:05 +0800
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
Subject: Re: [PATCH v7 08/10] iommufd: Associate fault object with
 iommufd_hw_pgtable
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-9-baolu.lu@linux.intel.com>
 <Zn81gdjwJBfjXekJ@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Zn81gdjwJBfjXekJ@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/29 6:13, Jason Gunthorpe wrote:
> On Sun, Jun 16, 2024 at 02:11:53PM +0800, Lu Baolu wrote:
> 
>> @@ -308,13 +315,29 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>>   		goto out_put_pt;
>>   	}
>>   
>> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
>> +		struct iommufd_fault *fault;
>> +
>> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
>> +		if (IS_ERR(fault)) {
>> +			rc = PTR_ERR(fault);
>> +			goto out_hwpt;
>> +		}
>> +		hwpt->fault = fault;
>> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
>> +		hwpt->domain->fault_data = hwpt;
> 
> This is not the right refcounting for a longterm reference... The PT
> above shows the pattern:
> 
> 	pt_obj = iommufd_get_object(ucmd->ictx, cmd->pt_id, IOMMUFD_OBJ_ANY);
> 	hwpt_paging = iommufd_hwpt_paging_alloc()
>              	refcount_inc(&ioas->obj.users);
> 
> 	iommufd_put_object(ucmd->ictx, pt_obj);
> 
> Which is to say you need to incr users and then do the put object. And
> iommufd_object_abort_and_destroy() will always destroy the ref on the
> fault if the fault is non-null so the error handling will double free.
> 
> fail_nth is intended to catch this, but you have to add enough inputs
> to cover the new cases when you add them, it seems like that is
> missing in this series. ie add a fault object and hwpt alloc to a
> fail_nth test and see we execute the iommufd_ucmd_respond() failure
> path.

Yes. I will add below fail_nth case:

--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -201,6 +201,12 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 
device_id, __u32 pt_id, __u32 ft_i
         ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, 
fault_id, \
                                           flags, hwpt_id, data_type, 
data,      \
                                           data_len))
+#define test_err_hwpt_alloc_iopf(_errno, device_id, pt_id, fault_id, 
flags,     \
+                                hwpt_id, data_type, data, data_len) 
        \
+       EXPECT_ERRNO(_errno, 
        \
+                    _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, 
fault_id, \
+                                         flags, hwpt_id, data_type, 
data,      \
+                                         data_len))

  #define test_cmd_hwpt_check_iotlb(hwpt_id, iotlb_id, expected) 
         \
         ({ 
        \
diff --git a/tools/testing/selftests/iommu/iommufd.c 
b/tools/testing/selftests/iommu/iommufd.c
index 5b0169875a4d..93634e53e95e 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -338,6 +338,10 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
                                            &nested_hwpt_id[1],
                                            IOMMU_HWPT_DATA_SELFTEST, &data,
                                            sizeof(data));
+               test_err_hwpt_alloc_iopf(ENOENT, self->device_id, 
parent_hwpt_id,
+                                        UINT32_MAX, 
IOMMU_HWPT_FAULT_ID_VALID,
+                                        &iopf_hwpt_id, 
IOMMU_HWPT_DATA_SELFTEST,
+                                        &data, sizeof(data));
                 test_cmd_hwpt_alloc_iopf(self->device_id, 
parent_hwpt_id, fault_id,
                                          IOMMU_HWPT_FAULT_ID_VALID, 
&iopf_hwpt_id,
                                          IOMMU_HWPT_DATA_SELFTEST, &data,

> 
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -14,7 +14,7 @@ static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
>                  iommu_domain_free(hwpt->domain);
>   
>          if (hwpt->fault)
> -               iommufd_put_object(hwpt->fault->ictx, &hwpt->fault->obj);
> +               refcount_dec(&hwpt->fault->obj.users);
>   }
>   
>   void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
> @@ -326,18 +326,17 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>                  hwpt->fault = fault;
>                  hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
>                  hwpt->domain->fault_data = hwpt;
> +               refcount_inc(&fault->obj.users);
> +               iommufd_put_object(ucmd->ictx, &fault->obj);
>          }
>   
>          cmd->out_hwpt_id = hwpt->obj.id;
>          rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>          if (rc)
> -               goto out_put_fault;
> +               goto out_hwpt;
>          iommufd_object_finalize(ucmd->ictx, &hwpt->obj);
>          goto out_unlock;
>   
> -out_put_fault:
> -       if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID)
> -               iommufd_put_object(ucmd->ictx, &hwpt->fault->obj);
>   out_hwpt:
>          iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
>   out_unlock:
> 

.. and merge above change to this patch.

Best regards,
baolu
