Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2EE15E88
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944326; cv=none; b=ZTeCHam1/8hkdm7t07WWam/rMNzeonyf5V0LnlrpvwypK5I7Sg3c/6GT8AOqp/uY8yWZT8uX9VVzSBXogVMnSvamC4fiOGxwpFseByQbEyUr4ASENYCpHIsYTwLtyBfWF04T8k3OM0VBDX93wbGM3z4HjURNPlNVX4ZYmA+i2QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944326; c=relaxed/simple;
	bh=2rt1igW90MFX0FAlXVs9SIGZENjQFoIdTTvr8cyOK8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KX/6ZiR2pdCWmzL/MIIvFZ96UxyLe4SNbysUXrg1dMRPmnFDYzzUYzEbl3TmqALbHCHHTxwV84z28rrly4O7nmcmuyKQR9hDXhqDmtIwKwIuYW6nSdTDQQQq7Zt0p2t7YeV3ybM2k982GPs6odoUmoGNvMmhEBPFgqUAUaeLDqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AeZxRkE/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AeZxRkE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730944324; x=1762480324;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2rt1igW90MFX0FAlXVs9SIGZENjQFoIdTTvr8cyOK8E=;
  b=AeZxRkE/9UJgrt40oKVLNGPAF+ScQ20i82uA4Mpqqc3L0Xy+x7CUJkHk
   pgw3il+lWGA4h9wJVtgAEvxXDynk2yw1Z1oIR1OrMAIQDFSdTjWFXIvcX
   2FtqOdXmeyS24CVvOXMoT8oAShpxo7d938236IuuRap8rGk99T6ZJ5eyP
   8vSQW4noYkDBSdD9krCoGa0Kb5yI9qtf9Dm28TBkVhCXhcPKI1M0a6mRQ
   ZJY/510bNDJFVt57LrQlZrqbA54IqTk8lv3+albzM7/MbytR9scWovT2b
   Pv4MIaqcsvfv5d713c4rqmO/Q3hA/FGnkTfDZBfAAj5qBDskNzam5asJs
   A==;
X-CSE-ConnectionGUID: M8kXjq4aRdWyLrx43e+bxA==
X-CSE-MsgGUID: 3t4mD5HSSty2sD+Axf0oMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="41392113"
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="41392113"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 17:52:03 -0800
X-CSE-ConnectionGUID: GP/keyjYRWqTdUYPbig04w==
X-CSE-MsgGUID: IvZBSGf/QWWiRl5zYINQTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="84822581"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 17:52:02 -0800
Message-ID: <fcef9cb1-797a-496a-9ef5-1e2f530dc8f6@linux.intel.com>
Date: Thu, 7 Nov 2024 09:51:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: modify iommufd_fault_iopf_enable limitation
To: Jason Gunthorpe <jgg@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 jean-philippe <jean-philippe@linaro.org>, shamiali2008@gmail.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241028113209.123-1-zhangfei.gao@linaro.org>
 <CABQgh9H9HWaKRP=rFvXf90PjfVP1M6YpwfLcYTZH1hWET6GPsw@mail.gmail.com>
 <20241106135944.GP458827@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241106135944.GP458827@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 21:59, Jason Gunthorpe wrote:
> On Wed, Nov 06, 2024 at 05:47:09AM +0000, Zhangfei Gao wrote:
>> On Mon, 28 Oct 2024 at 11:32, Zhangfei Gao<zhangfei.gao@linaro.org> wrote:
>>> iommufd_fault_iopf_enable has limitation to PRI on PCI/SRIOV VFs
>>> because the PRI might be a shared resource and current iommu
>>> subsystem is not ready to support enabling/disabling PRI on a VF
>>> without any impact on others.
>>>
>>> However, we have devices that appear as PCI but are actually on the
>>> AMBA bus. These fake PCI devices have PASID capability, support
>>> stall as well as SRIOV, so remove the limitation for these devices.
>>>
>>> Signed-off-by: Zhangfei Gao<zhangfei.gao@linaro.org>
>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>> ---
>>>   drivers/iommu/iommufd/fault.c | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
>>> index bca956d496bd..8b3e34250dae 100644
>>> --- a/drivers/iommu/iommufd/fault.c
>>> +++ b/drivers/iommu/iommufd/fault.c
>>> @@ -10,6 +10,7 @@
>>>   #include <linux/module.h>
>>>   #include <linux/mutex.h>
>>>   #include <linux/pci.h>
>>> +#include <linux/pci-ats.h>
>>>   #include <linux/poll.h>
>>>   #include <uapi/linux/iommufd.h>
>>>
>>> @@ -27,8 +28,12 @@ static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
>>>           * resource between PF and VFs. There is no coordination for this
>>>           * shared capability. This waits for a vPRI reset to recover.
>>>           */
>>> -       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
>>> -               return -EINVAL;
>>> +       if (dev_is_pci(dev)) {
>>> +               struct pci_dev *pdev = to_pci_dev(dev);
>>> +
>>> +               if (pdev->is_virtfn && pci_pri_supported(pdev))
>>> +                       return -EINVAL;
>>> +       }
>>>
>>>          mutex_lock(&idev->iopf_lock);
>>>          /* Device iopf has already been on. */
>>>
>> Hi, Jason
>>
>> Would you mind also taking a look at this.
> Lu? Are you OK with this?

This change looks good to me. But the s-o-b chain would make more sense
if we can make it like this,

Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Zhangfei Gao<zhangfei.gao@linaro.org>

With this addressed,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

--
baolu
