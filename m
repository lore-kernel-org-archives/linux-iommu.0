Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F0323BE
	for <iommu@lists.linux.dev>; Tue,  5 Nov 2024 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730785568; cv=none; b=slncJTycB25AxSd8sY7V8OgTIzjS2TdJMLtjZcmy8xqhc7y+eOHhGyMa1iLcUWeL2K+zRmX0vtTpL5xEjko0oXDSvLQJ4IXOYZil4TKZSgg5p9nLLG1McF9FpWbOkONlOv/SbHz54Bhbzu6hJUb2so7TDbfsy6+9SnT5+Wj6/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730785568; c=relaxed/simple;
	bh=n9HFrIuS0BnFwnxReDtoLbpLUxOCkv4ucFZ6Od1vwcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZD6UIfSIsEBp0OwFciKdw3RgV4gWU79amoAh/kmIP3JGRAEXRCjbJyW1oc+xdROy9ODDAAXdRc2daUGmi/5H1/IgaksiE2KqtUGXUCsaSWZ+3aHQaI8FY2KG9qC3oIMOAY26LS0rR/5t+uO7pCi/FnBLuhbL7/ls+HKvKsnOwqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPqBIXXQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPqBIXXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730785565; x=1762321565;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n9HFrIuS0BnFwnxReDtoLbpLUxOCkv4ucFZ6Od1vwcg=;
  b=OPqBIXXQ5nQfwj3s/pMgkNoEhTAEIkBzOuBbZbuCQIQWW6Lake8537xG
   L7EtKqFlJwZZJXYeMuYzSPCDuqBmTXlfNxsMqs1GKNSNlbjbbnqeWt8HB
   pS7KW7CmfZ/UVxYtS2qhqjCvCvA4S9H3iav7637HAaUsvdawRnZot8mbR
   8tLiOWyEY/tcwh8JbxJkvJZNkY72DZMivGWAUx4pmbsykSu/bS8I2KyB6
   c9u7wkNG17bKK2z3EEHBKDCbB0MdaORK5jQ8V5ln0kZU1PBQv6btqRj4s
   aTyxJrIT0B5GhgGQMc0t5aBtBosG5vgc5OUQdajEIFeOmnlHFDz2pUVhs
   Q==;
X-CSE-ConnectionGUID: jODpfVzRTqmc0GkII+zH7w==
X-CSE-MsgGUID: /b79n9zNRRSOZTqroOJW8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30738034"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="30738034"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 21:46:04 -0800
X-CSE-ConnectionGUID: VmEvy1OOS+eYBgNY3wXvAg==
X-CSE-MsgGUID: Ii6fkVZTTYmHS6ytPFj+Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="88635690"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 21:46:01 -0800
Message-ID: <1349c2c7-f3e8-4538-b23e-8c0b3d441a11@linux.intel.com>
Date: Tue, 5 Nov 2024 13:45:14 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] iommu/vt-d: Make the blocked domain support PASID
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com, will@kernel.org
References: <20241104132033.14027-1-yi.l.liu@intel.com>
 <20241104132033.14027-6-yi.l.liu@intel.com>
 <557b9c59-1ecb-485a-9e36-c926180a199b@linux.intel.com>
 <421c5022-eeef-42b4-b173-63e52d6f4361@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <421c5022-eeef-42b4-b173-63e52d6f4361@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/24 13:11, Yi Liu wrote:
> On 2024/11/5 11:46, Baolu Lu wrote:
>> On 11/4/24 21:20, Yi Liu wrote:
>>> @@ -4291,15 +4296,18 @@ void domain_remove_dev_pasid(struct 
>>> iommu_domain *domain,
>>>       kfree(dev_pasid);
>>>   }
>>> -static void intel_iommu_remove_dev_pasid(struct device *dev, 
>>> ioasid_t pasid,
>>> -                     struct iommu_domain *domain)
>>> +static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
>>> +                     struct device *dev, ioasid_t pasid,
>>> +                     struct iommu_domain *old)
>>>   {
>>>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>>>       struct intel_iommu *iommu = info->iommu;
>>>       intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>>>       intel_drain_pasid_prq(dev, pasid);
>>> -    domain_remove_dev_pasid(domain, dev, pasid);
>>> +    domain_remove_dev_pasid(old, dev, pasid);
>>> +
>>> +    return 0;
>>>   }
>>>   struct dev_pasid_info *
>>> @@ -4664,7 +4672,6 @@ const struct iommu_ops intel_iommu_ops = {
>>>       .dev_disable_feat    = intel_iommu_dev_disable_feat,
>>>       .is_attach_deferred    = intel_iommu_is_attach_deferred,
>>>       .def_domain_type    = device_def_domain_type,
>>> -    .remove_dev_pasid    = intel_iommu_remove_dev_pasid,
>>
>> This will cause iommu_attach_device_pasid() to fail due to the check and
>> failure condition introduced in patch 1/7.
> 
> the check introduced in patch 1 were enhanced in patch 3. So removing
> remove_dev_pasid op does not fail as intel iommu driver provides
> blocked domain which has the set_dev_pasid op.
> 

Okay, I see. Thanks!
