Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFDD29AF
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720750865; cv=none; b=qGQc3FBbZcQgZYmA51AkjFt8Y6JDCDwnFFqaltBqCDDfFfB4PkuAKYWCoC/R5gccJbgg+xVFyhoDKWfqAMv3Bgm/O15lZgEcr5yUx2uk+pFucCGLce/fqUolSYvK1HLV+vHtTTGlPGaOdMjsxhxPf5VrmExPU/lQijasY+hXMpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720750865; c=relaxed/simple;
	bh=CCH+P/d7gcwJZFhUZsXfkwYLJNyamCRgz7eWF7CJZTk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ArfdJbCCePum5kkRflSUrhjbmR22p9BJqxhH0Ol8yUvUuOVcrooiakB2oAyDHYee4T4h2jBtZZvfKx8z6Vds0S2mXvSmtBeZfTqdlnWDFspLFWQy3XjwCsdr4NlfxEcy3tM3d8spNLZ2KGjyyr4e1O5hf6ZdSR/mV3z7oolROBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUxIfl2v; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUxIfl2v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720750863; x=1752286863;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CCH+P/d7gcwJZFhUZsXfkwYLJNyamCRgz7eWF7CJZTk=;
  b=ZUxIfl2vb/RTYE7nqDGGDpkYciHX0FZ22rz0KagmkEUgguuT35NmG+qr
   wwXfZzAFMsCnbyoaQbrWQl4LTaG8s0RJ2zaS+mrV4DUW4hvoW3hKSz1aP
   i5kNWFkFuZLmP55GYmJuXh0Ga+3Mo5A2PrvssJ3W/3YEH+Zh9G/U7k6/X
   CsFzQEo68TGc0jNxZfVbH7X9IptRF6av5PwW8cHb6gxVDJN2jkwX8HL8N
   POrBnc58Utax3JrPi1aYNHfPF8hMAR5vMZq3mUMp0B3r5PVD5DT6DfZnR
   3ltF4l8besiRBLy3uPQ8nYxiDlRk63P7nXhCubJQwD7rjGSswCsmXcqQp
   w==;
X-CSE-ConnectionGUID: 4ZGuPVNVTl2qYsXJvy9m/g==
X-CSE-MsgGUID: tyGL5uVaQ4eeoGrC8IjV/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18317511"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18317511"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 19:21:00 -0700
X-CSE-ConnectionGUID: L7t/y8bWSiyqo8UpTs9FRw==
X-CSE-MsgGUID: f28kfW5MSEyBo9OS0RnZuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48779504"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa009.fm.intel.com with ESMTP; 11 Jul 2024 19:20:59 -0700
Message-ID: <8674561d-f14d-4735-aa86-24032e67c928@linux.intel.com>
Date: Fri, 12 Jul 2024 10:18:06 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [bug report] iommufd: Fault-capable hwpt attach/detach/replace
To: Dan Carpenter <dan.carpenter@linaro.org>
References: <8bb4f37a-4514-4dea-aabb-7380be303895@stanley.mountain>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8bb4f37a-4514-4dea-aabb-7380be303895@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/24 2:35 AM, Dan Carpenter wrote:
> Hello Lu Baolu,

Hi Dan,

> 
> Commit b7d8833677ba ("iommufd: Fault-capable hwpt
> attach/detach/replace") from Jul 2, 2024 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	drivers/iommu/iommufd/fault.c:131 iommufd_device_get_attach_handle()
> 	warn: 'handle' is an error pointer or valid
> 
> drivers/iommu/iommufd/fault.c
>     125  static struct iommufd_attach_handle *
>     126  iommufd_device_get_attach_handle(struct iommufd_device *idev)
>     127  {
>     128          struct iommu_attach_handle *handle;
>     129
>     130          handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
>     131          if (!handle)
> 
> This should be if (IS_ERR(handle)) return NULL;

Yes. Good catch. I will send a formal patch to Jason.

> 
>     132                  return NULL;
>     133
>     134          return to_iommufd_handle(handle);
>     135  }
>     136
>     137  void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
>     138                                       struct iommufd_device *idev)
>     139  {
>     140          struct iommufd_attach_handle *handle;
>     141
>     142          handle = iommufd_device_get_attach_handle(idev);
> 
> Do we need to check for NULL here as well?

I don't think we need a check here as we have the code below...

         if (hwpt->fault)
                 iommufd_fault_domain_detach_dev(hwpt, idev);

...to ensure we are detaching an iopf-capable domain. This code should
be paired with iommufd_fault_domain_attach_dev(). Otherwise, there must
be a more severe problem. A NULL kernel pointer deference warning here
would be a good indication of such a problem.

> 
>     143          iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
>     144          iommufd_auto_response_faults(hwpt, handle);
>     145          iommufd_fault_iopf_disable(idev);
>     146          kfree(handle);
>     147  }
> 
> regards,
> dan carpenter

Thanks,
baolu
