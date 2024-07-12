Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCEC947A
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720753029; cv=none; b=oqS87spnDWqqg5wU4J5kHHnupAoQMoI8rmo2uQ/O9Hq47WS5ipbHjc/95tAw6Vb0aJB9BiyYMJjxhyWLfm/tP8VEFBAIFKNdsYAjjxAGWICUaJ4SHVFxwtgqsh5z3zDZxCFDOEqWYSaHt19VrnuXr2rW1Fo5Q+6B//Cdb/J18IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720753029; c=relaxed/simple;
	bh=FYo0BamwG4FGl/+5ft6++Keb8TRPabI7ieLWG9opyyA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HE/nqDcaW2XwGeGFJbrR6uIg2H6HAUTw7iX4rkuuwQ7xZI7Ddfqte8Uv/ZBMDpwFSicfOX7VoI8In5kG1nqIgRtp92tXFCsakxYoPF+lPZtGmlw8wnicpDUxmSH0nmjFQo2guzclKenzCHg3xDYa9Q0D03cu1caxUxEFfAZMovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvzfR1Ch; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvzfR1Ch"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720753028; x=1752289028;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FYo0BamwG4FGl/+5ft6++Keb8TRPabI7ieLWG9opyyA=;
  b=cvzfR1ChqI3jm6D+ILuixI1hj+b80QnD0pZGRYKUA48Hc/blLaVKp7LB
   +PdO1VcLi89IySIHfjxQySbZCckfws/UO2Ln5HJlZKucn/8673M83+Fdd
   6nPsullEIc0w1zBSzplyNzhAxrnXh+f8doiUHnToeaQ1bmcpM7+ZIkPjE
   /xzfSHyOUwee3NSgjvuFdGS+vg/AD5Ye/J9hFw/Plq3oZdRLnv23rWMNF
   43mqZlmFaPKG9lXIjfKv8Z9DJ+aJngp485LGyvYJyRKuJPRVigx4f2CDz
   F7OnpnyFYlUAdSJBQEU3asqlVipiKBwTFS/ly+lDjqdgoLBQpFeUdn20P
   A==;
X-CSE-ConnectionGUID: qfOm+cTASuyjS3zQkh82rw==
X-CSE-MsgGUID: 6HUbpTI9SkigGCfveeppig==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28770288"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="28770288"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 19:57:07 -0700
X-CSE-ConnectionGUID: A1+mpcN3QbapRwjBt84bpQ==
X-CSE-MsgGUID: KlvtoFbRQF6riYJo+sFl4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48785504"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa009.fm.intel.com with ESMTP; 11 Jul 2024 19:57:04 -0700
Message-ID: <b4758476-6de2-4d3e-91b2-10599a37d00e@linux.intel.com>
Date: Fri, 12 Jul 2024 10:54:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iommufd: Add check on user response code
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
 <20240710083341.44617-3-baolu.lu@linux.intel.com>
 <20240711233950.GU14050@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240711233950.GU14050@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/12/24 7:39 AM, Jason Gunthorpe wrote:
> On Wed, Jul 10, 2024 at 04:33:40PM +0800, Lu Baolu wrote:
>> The response code from user space is only allowed to be SUCCESS or
>> INVALID. All other values are treated by the device as a response
>> code of Response Failure according to PCI spec, section 10.4.2.1.
>> This response disables the Page Request Interface for the Function.
>>
>> Add a check in iommufd_fault_fops_write() to avoid invalid response
>> code.
>>
>> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommufd/fault.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
>> index 54d6cd20a673..044b9b97da31 100644
>> --- a/drivers/iommu/iommufd/fault.c
>> +++ b/drivers/iommu/iommufd/fault.c
>> @@ -305,6 +305,12 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
>>   		if (rc)
>>   			break;
>>   
>> +		if (response.code != IOMMUFD_PAGE_RESP_SUCCESS &&
>> +		    response.code != IOMMUFD_PAGE_RESP_INVALID) {
>> +			rc = -EINVAL;
>> +			break;
>> +		}
> 
> I added this:
> 
> 		static_assert(IOMMUFD_PAGE_RESP_SUCCESS ==
> 			      IOMMU_PAGE_RESP_SUCCESS);
> 		static_assert(IOMMUFD_PAGE_RESP_INVALID ==
> 			      IOMMU_PAGE_RESP_INVALID);

Above change cause below build warning:

drivers/iommu/iommufd/fault.c: In function ‘iommufd_fault_fops_write’:
drivers/iommu/iommufd/fault.c:308:57: warning: comparison between ‘enum 
iommufd_page_response_code’ and ‘enum iommu_page_response_code’ 
[-Wenum-compare]
   308 |                 static_assert(IOMMUFD_PAGE_RESP_SUCCESS ==
       |                                                         ^~
./include/linux/build_bug.h:78:56: note: in definition of macro 
‘__static_assert’
    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
       |                                                        ^~~~
drivers/iommu/iommufd/fault.c:308:17: note: in expansion of macro 
‘static_assert’
   308 |                 static_assert(IOMMUFD_PAGE_RESP_SUCCESS ==
       |                 ^~~~~~~~~~~~~
drivers/iommu/iommufd/fault.c:310:57: warning: comparison between ‘enum 
iommufd_page_response_code’ and ‘enum iommu_page_response_code’ 
[-Wenum-compare]
   310 |                 static_assert(IOMMUFD_PAGE_RESP_INVALID ==
       |                                                         ^~
./include/linux/build_bug.h:78:56: note: in definition of macro 
‘__static_assert’
    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
       |                                                        ^~~~
drivers/iommu/iommufd/fault.c:310:17: note: in expansion of macro 
‘static_assert’
   310 |                 static_assert(IOMMUFD_PAGE_RESP_INVALID ==
       |                 ^~~~~~~~~~~~~

Perhaps convert them to 'int' before compare?

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 29f522819759..a643d5c7c535 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -305,10 +305,10 @@ static ssize_t iommufd_fault_fops_write(struct 
file *filep, const char __user *b
                 if (rc)
                         break;

-               static_assert(IOMMUFD_PAGE_RESP_SUCCESS ==
-                             IOMMU_PAGE_RESP_SUCCESS);
-               static_assert(IOMMUFD_PAGE_RESP_INVALID ==
-                             IOMMU_PAGE_RESP_INVALID);
+               static_assert((int)IOMMUFD_PAGE_RESP_SUCCESS ==
+                             (int)IOMMU_PAGE_RESP_SUCCESS);
+               static_assert((int)IOMMUFD_PAGE_RESP_INVALID ==
+                             (int)IOMMU_PAGE_RESP_INVALID);
                 if (response.code != IOMMUFD_PAGE_RESP_SUCCESS &&
                     response.code != IOMMUFD_PAGE_RESP_INVALID) {
                         rc = -EINVAL;

Thanks,
baolu
