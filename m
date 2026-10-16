Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3574754707E;
	Fri, 16 Oct 2026 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134211; cv=none; b=nhImU/6V6J27LYAPfCXRni+MpoKh1wvWV4g/+kWjJqpGpr0Irr0WcXSGPJAhyE/OewK9f/RQ+VR09eNyafBSUKkElwyGu1LQjKJoFp+RlS+tYXtRPXoPI3/OnSCUJiaVProWloHh/q6o2ey8mcKWlvRivO6NdanAbhW/pInSZXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134211; c=relaxed/simple;
	bh=0amuKCd5T4PSq5JE2PNjiw40J8GZ6GUSKmj40QX3MHA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MRsKSLuQ2i1xTa6WpPXME73gj1ZFxDWId4ZI/3xjIQ0NOJdpsNt8cawyMP0X8s/TrK8MAbb7zVTCO2q595ZcZLKmBqsU9jlEk2ER/Rf0d6xDd8XfFjXR7PLv78OANJ6KVxce7PAFVXndyLOop2UIt/URcNLy9ZFUQy6t4sOURN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngHFwzYj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngHFwzYj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792134210; x=1823670210;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0amuKCd5T4PSq5JE2PNjiw40J8GZ6GUSKmj40QX3MHA=;
  b=ngHFwzYjSKN65lS4M2eubkOi8xy2RZa3IhVJSEgb6TBPOCkBq4mT8A6N
   OfRTl6ofZHuSqTgD/+3aHdtz/GMnI3st15zEu876VE6etU+Wps4S1uzb8
   pp9TwBHtJFci5+04lYx7P6zuisPqYuAGwNnreLjlX69AggQoeO4RuX852
   zcnVRfGUxMnmh1E6ugGWr2cJznLDH+EC4PyERlnnC/KX8dCSuJUdca4Ku
   GWkM+f00h7eCzDdHALYyz91UNCNl60WjVDDS4HOCQKOWyqshqCcEmpPMY
   +ngKEX+KXCjE1UbqcB0lR3yk/vvDndX270CXT9nKjAZkWtColW47eS+Py
   g==;
X-CSE-ConnectionGUID: UZ3ti+ehTAKMYAIpTUaSDA==
X-CSE-MsgGUID: kjZMvpWNRzG5noaU+gZlYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="925937"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="925937"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 00:03:30 -0700
X-CSE-ConnectionGUID: 8Zwup8+BS/ikkviipDeQnw==
X-CSE-MsgGUID: cRb/PgvVQQWTQiIGhVxr5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3628357"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 00:03:25 -0700
Message-ID: <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>
Date: Fri, 16 Oct 2026 15:03:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, x86@kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
 Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
To: Jason Gunthorpe <jgg@ziepe.ca>, Xu Yilun <yilun.xu@linux.intel.com>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050> <20261015173707.GV14213@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261015173707.GV14213@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/2026 1:37 AM, Jason Gunthorpe wrote:
> On Thu, Oct 15, 2026 at 04:31:31PM +0800, Xu Yilun wrote:
> 
>> An alternative could be, bringing up one IOMMU when an associated
>> device requests link encryption. Then a no-tdx-support iommu fails the
>> encryption request naturally.
> That is what ARM is planning to do. I think it is reasonable to
> trigger creation of the secure iommu when the TSM is connected to TDX.
> 
> Fail connect if the iommu could not be created.

Yes, agreed. The Intel iommu driver could use per-device interfaces,
just as ARM is planning. There are some differences, though.

ARM's interaction with the iommu driver in viommu_init() appears to
consist of two steps:

  - arm_smmu_get_realm_params(dev, &params): get and validate the
    physical iommu information from the arm-smmu-v3 driver;
  - cca_psmmu_get(&params): activate the physical smmu for Realm use.

Intel differs in two ways:

  - ARM queries the physical iommu information from the iommu driver
    in the viommu_init() path. On Intel, the secure iommu must be set
    up during TSM connect, because it is part of establishing PCIe
    link encryption.

  - The TDX Connect architecture places requirements on the host
    iommu driver while the secure IOMMU is being set up. For example,
    the host iommu driver must block the enhanced command (ECMD)
    interface while the TDH.IOMMU.SETUP SEAMCALL runs, and it must
    reserve the upper half of the domain ID space. These steps have
    to happen atomically under the iommu driver's own locks. As a
    result, the Intel iommu driver needs to merge the two steps above
    into one.

So the Intel iommu driver will probably end up with interfaces like:

  - dmar_tdxcs_iommu_init(struct device *dev, ...);
  - dmar_tdxcs_iommu_release(struct device *dev, ...);

These would be called from the connect and disconnect callbacks of
the TDX link ops:

static struct pci_tsm_ops tdx_tsm_link_ops = {
         .owner = THIS_MODULE,
         .probe = tdx_tsm_link_probe,
         .remove = tdx_tsm_link_remove,
         .connect = tdx_tsm_link_connect,
         .disconnect = tdx_tsm_link_disconnect,
...
};

Any thoughts?

Thanks,
baolu
