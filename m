Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803311F949
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731464064; cv=none; b=RlV8P4eurdLYVgGAuCSjXiHatMi3bXpXycPiadrSjdzJVBXHyCe4YBKZCo/ievt5xX9MpD6rKx6FCJTGuiewOuLkVt0PboCZrXBjOX8rVqnQbAAzasYQ/sYeevo0d6U5gKcHEPVNiMGRExvzYIK6u+9hWIXPgV9ZQtRL+IW5taU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731464064; c=relaxed/simple;
	bh=brMz3vclGXOX04Vw7l1uFYgeKr0mHFMryBqsgDPGv7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVCdRb6EjtFYRoMvj0JZHBWYW0bN3L3nk6Jn7thGLxB8Ca6JrtZIMVO4plbGZInobyyoEcXr6v5b3qYDOKFCv8tQIqxsadSUxZwXsu+jqc3rLn5B6pIfFDz7Y6mseWvXMcmzF071KquG1svQc0KwHCLQAlKeC4MSCfuhTNutgNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOVz1Fxj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOVz1Fxj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731464063; x=1763000063;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=brMz3vclGXOX04Vw7l1uFYgeKr0mHFMryBqsgDPGv7I=;
  b=XOVz1Fxj/x0f8fnf1z8uUpmaa4SA+6WrYRQWq8fggRFCk2XRtsAu8TlF
   o45BEOMif4wzkiH2XepqMKzAWA99C6QMEgbkvAx0tUcbYsl+6yaYz1Dn5
   tkGlWjWOKzPcJ5uRPvKGQWYeJ7tfLGDp7OcOfijqr3s3eafRL0Zaa+pLt
   ZN1rZFo0xYbZ9ht0K0E6EZ3nx+vy0xgKuJ6G+Y7Lh1G1bWXHYQGocxMRi
   ZmMfZwEJbGxDdvZxIzo0yw5CEetVDzPL9+oxxR+5QKRtslT+47ROFsp14
   hRo1PmacLp1h6lLc6VnHjcDXNJiY/vd3qODTTIhD36kbWusbWKaeVy1mv
   Q==;
X-CSE-ConnectionGUID: ppyVrOuNT0SINQtjz2Nrag==
X-CSE-MsgGUID: uURqvVx+Ru6AwWUUEXZ8YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31299022"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31299022"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 18:14:23 -0800
X-CSE-ConnectionGUID: Y9DWZJ3sS3KCkGHCxnrFMg==
X-CSE-MsgGUID: 8MCuthcDSt2y9IKegLFivQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="88129871"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 18:14:19 -0800
Message-ID: <16b3fdb5-6f7b-4728-873c-4047ea69aef5@linux.intel.com>
Date: Wed, 13 Nov 2024 10:13:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATH v5 2/3] iommu/vt-d: debugfs: Create/remove debugfs file per
 {device, pasid}
To: Kees Bakker <kees@ijzerbout.nl>, Jingqi Liu <Jingqi.liu@intel.com>,
 iommu@lists.linux.dev, Tian Kevin <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org
References: <20231013135811.73953-1-Jingqi.liu@intel.com>
 <20231013135811.73953-3-Jingqi.liu@intel.com>
 <2590cecf-e1f9-4af9-8fbb-9b49f5e335c0@ijzerbout.nl>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2590cecf-e1f9-4af9-8fbb-9b49f5e335c0@ijzerbout.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/13/24 05:22, Kees Bakker wrote:
> Op 13-10-2023 om 15:58 schreef Jingqi Liu:
>> Add a debugfs directory per pair of {device, pasid} if the mappings of
>> its page table are created and destroyed by the iommu_map/unmap()
>> interfaces. i.e. /sys/kernel/debug/iommu/intel/<device source id>/ 
>> <pasid>.
>> Create a debugfs file in the directory for users to dump the page
>> table corresponding to {device, pasid}. e.g.
>> /sys/kernel/debug/iommu/intel/0000:00:02.0/1/domain_translation_struct.
>> For the default domain without pasid, it creates a debugfs file in the
>> debugfs device directory for users to dump its page table. e.g.
>> /sys/kernel/debug/iommu/intel/0000:00:02.0/domain_translation_struct.
>>
>> When setting a domain to a PASID of device, create a debugfs file in
>> the pasid debugfs directory for users to dump the page table of the
>> specified pasid. Remove the debugfs device directory of the device
>> when releasing a device. e.g.
>> /sys/kernel/debug/iommu/intel/0000:00:01.0
>>
>> Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
>> ---
>>   drivers/iommu/intel/debugfs.c | 53 +++++++++++++++++++++++++++++++----
>>   drivers/iommu/intel/iommu.c   |  7 +++++
>>   drivers/iommu/intel/iommu.h   | 14 +++++++++
>>   3 files changed, 69 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/ 
>> debugfs.c
>> [...]
>> +/* Remove the device pasid debugfs directory. */
>> +void intel_iommu_debugfs_remove_dev_pasid(struct dev_pasid_info 
>> *dev_pasid)
>> +{
>> +    debugfs_remove_recursive(dev_pasid->debugfs_dentry);
>> +}
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> [...]
>> @@ -4710,6 +4713,7 @@ static void intel_iommu_remove_dev_pasid(struct 
>> device *dev, ioasid_t pasid)
>>       spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>       domain_detach_iommu(dmar_domain, iommu);
>> +    intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>>       kfree(dev_pasid);
>>   out_tear_down:
>>       intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>>
> 
> So, a call to intel_iommu_debugfs_remove_dev_pasid() was added.
> There is a potential problem that dev_pasid can be NULL.
> The diff doesn't show the whole context so let me give that here.
> Today that piece of the code looks like this
> 
>          list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
>                  if (curr->dev == dev && curr->pasid == pasid) {
>                          list_del(&curr->link_domain);
>                          dev_pasid = curr;
>                          break;
>                  }
>          }
>          WARN_ON_ONCE(!dev_pasid);
>          spin_unlock_irqrestore(&dmar_domain->lock, flags);
> 
>          cache_tag_unassign_domain(dmar_domain, dev, pasid);
>          domain_detach_iommu(dmar_domain, iommu);
>          intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>          kfree(dev_pasid);
> 
> The for_each loop can exit without finding an entry.
> The WARN_ON_ONCE also suggests that there can be a NULL.
> After that the new function is called (see above) and it will
> dereference the NULL pointer.
> 
> Can you have a closer look?

It's already a kernel bug if dev_pasid is NULL when it reaches here. If
that happens, we should fix the bug, not avoid using the NULL pointer.

--
baolu
