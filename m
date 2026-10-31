Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793424849;
	b=XZiQ8s5Mipb6syPjxSy5fftmgoMTKIU76BMbkIPopivcxRb7lLt0uDnePQjKVcLDKwOb
	 WeYZMzVQY6iW7MBhcV+fXRaEW30F4bfqXEwSHdNKBpIoDigHQRj1nPGkq+rXHH7DruqB3
	 lrScn2+By3HTouBVutPRQSA2gy1fLFhDNEgV9BCwHkJFPc4bH925uvjMJy7Ke/JOZxvmg
	 4lyU5iDskHHp7eX3qAJ4hxUfNEaW86yvsG2urqJkbQ1dnkMkdoTaLRhGlbbtF/AQmfIjD
	 T97rP05/vCy2cPxRk0yQ4WIJt5sWKjepbIqGZDnd7y+A59sLQGSo+A6dAMWLj2ssDjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793424849;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/VwbcVFoAg5lnb5ziZ5bsI4g8Kl0QWqGFO+0605f0UM=;
	b=wIt7OMnfUuPekXA1V13PWaJn4aq0VZlTLRB7pyyMsoxyoVkNCMEw45EdF/tqvoMQqVpD
	 ifZN41qZrLNHtAy/ij+wgcsgw8WfNZG+Su2A2AQYjgrRRDCDAJSA/HVFp6UpRQraTQBFt
	 c2A6vn6rA12SA/955kFGp7Pej9q0fK45K5hYPCIEgCy9ggEmV9Ri3ful6IbXp/mNEA0AR
	 iCsGxI2PXW0FV1d8meRFE6L8VYN9CW7H6aqgZGchBeGi6LiOnRq66Xcgz9bLup0TPAqNs
	 0i49yLywC5RfQ9nd+KWTCxrh50z3MX4KrQXK0VHSsT1Btzk+N79N39QXEey0Gwlyukw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZK+DtdfU;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A3606A31C
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 05:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D12A3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZK+DtdfU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793424848; x=1824960848;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+fcibPi2ZDVRjTuc7ggPd3G0vq20xPXdnRW/+shzkss=;
  b=ZK+DtdfU2Dm1CqhLETfptaPwLpu7nI52fPj0zI0VkMENS0cr3FeXyGiZ
   gOzENHdRq4X40HUI+K+fkILJNCWpblt4VZNHmH2OiLQ+5a7gC1UqnjbPs
   sUlgOoEpY5EILHYsCxHFHTMcB48QOsOD/ahNf7td1V2TpZydeizCr7PJn
   CnSRI81pqToEvCiyPAAEbO5Z252kwZACLBddnEt7dw+OPwS3NPm7oyIPd
   yozW2tjIpScj6G/hCZk78id7YNcWrWKO4BiIKtTYFOdi5ASYF8vEQY8+2
   UkngMLGImKUIqN7HCz036UbSPoy55Pt2duMhmTyBOPVRSwlizswtFRn/C
   g==;
X-CSE-ConnectionGUID: MPj58DOoT7K0AGTGacJdMA==
X-CSE-MsgGUID: wIcy0qCdShKw38wmMRrjWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2068563"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2068563"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 22:34:07 -0700
X-CSE-ConnectionGUID: F453hYEiQM+q6Op/y8/sww==
X-CSE-MsgGUID: Z3Ms19v7S7KM2iyhLgEFog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5994725"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.249.52]) ([10.124.249.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 22:34:02 -0700
Message-ID: <38384919-f0e5-4c93-b71b-065b96a74c38@linux.intel.com>
Date: Sat, 31 Oct 2026 13:34:00 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
 John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 05/18] iommu: Implement device and IOMMU HW
 preservation
To: Samiullah Khawaja <skhawaja@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-6-skhawaja@google.com>
 <df75f891-05a0-4d47-8705-d6a00c81ff97@linux.intel.com>
 <auTzN4NWuKsBvIZU@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <auTzN4NWuKsBvIZU@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/2026 9:45 AM, Samiullah Khawaja wrote:
> On Fri, Oct 30, 2026 at 01:12:31PM +0800, Baolu Lu wrote:
>> On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>> Add IOMMU ops to preserve/unpreserve the device state handled by the
>>> IOMMU driver. This is IOMMU specific state of the device that needs to
>>> be preserved for liveupdate. These ops can be implemented by the IOMMU
>>> drivers that support preservation of devices that have their IOMMU
>>> domains preserved. During device preservation the state of the
>>> associated IOMMU is also preserved as dependency.
>>>
>>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>> ---
>>>  drivers/iommu/iommu-priv.h       |   2 +
>>>  drivers/iommu/iommu.c            |  72 +++++++++++-
>>>  drivers/iommu/liveupdate.c       | 189 +++++++++++++++++++++++++++++++
>>>  include/linux/iommu-liveupdate.h |  76 +++++++++++++
>>>  include/linux/iommu.h            |  33 ++++++
>>>  5 files changed, 371 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>>> index 1f9f886b2c10..6b0ef210b32f 100644
>>> --- a/drivers/iommu/iommu-priv.h
>>> +++ b/drivers/iommu/iommu-priv.h
>>> @@ -21,6 +21,8 @@ static inline const struct iommu_ops 
>>> *dev_iommu_ops(struct device *dev)
>>>  void dev_iommu_free(struct device *dev);
>>> +bool iommu_group_is_singleton(struct iommu_group *group);
>>> +
>>>  const struct iommu_ops *iommu_ops_from_fwnode(const struct 
>>> fwnode_handle *fwnode);
>>>  static inline const struct iommu_ops *iommu_fwspec_ops(struct 
>>> iommu_fwspec *fwspec)
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index b486b8bbd1fc..a66363789ca9 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -18,6 +18,7 @@
>>>  #include <linux/errno.h>
>>>  #include <linux/host1x_context_bus.h>
>>>  #include <linux/iommu.h>
>>> +#include <linux/iommu-liveupdate.h>
>>>  #include <linux/iommufd.h>
>>>  #include <linux/idr.h>
>>>  #include <linux/err.h>
>>> @@ -328,6 +329,47 @@ void iommu_device_unregister(struct iommu_device 
>>> *iommu)
>>>  }
>>>  EXPORT_SYMBOL_GPL(iommu_device_unregister);
>>> +struct iommu_dev_iter {
>>> +    struct iommu_device *iommu;
>>> +    iommu_dev_iter_fn fn;
>>> +};
>>> +
>>> +static int _iommu_for_each_dev_cb(struct device *dev, void *data)
>>> +{
>>> +    struct iommu_dev_iter *iter = data;
>>> +
>>> +    if (dev->iommu && dev->iommu->iommu_dev == iter->iommu)
>>> +        return iter->fn(dev, iter->iommu);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/**
>>> + * iommu_for_each_dev() - Iterate over all devices attached to an IOMMU
>>> + * @iommu: IOMMU instance
>>> + * @fn: Callback to call for each device attached to @iommu
>>> + *
>>> + * Return: 0 on success, or negative error code.
>>> + */
>>> +int iommu_for_each_dev(struct iommu_device *iommu, iommu_dev_iter_fn 
>>> fn)
>>> +{
>>> +    struct iommu_dev_iter iter = {
>>> +        .iommu = iommu,
>>> +        .fn = fn,
>>> +    };
>>> +    int ret;
>>> +
>>> +    for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
>>> +        ret = bus_for_each_dev(iommu_buses[i], NULL, &iter,
>>> +                       _iommu_for_each_dev_cb);
>>> +        if (ret)
>>> +            return ret;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(iommu_for_each_dev);
>>
>> The function has no locking against iommu probe or release, so the
>> callback can read dev->iommu while it is being freed or before it is
>> fully set up.
> 
> It is only called from intel_iommu_shutdown(), which runs after the
> other CPUs are stopped and interrupts are disabled, so probe and release
> can't run. I will rename it to iommu_for_each_dev_unsafe(), document
> that it must only be called at shutdown and drop the export, since the
> only user is built in.

If it's only intended for the intel iommu driver, then it should be
open-coded there. There is no need to add an immature interface like
this to the core. It could be misused in the future.

Thanks,
baolu
