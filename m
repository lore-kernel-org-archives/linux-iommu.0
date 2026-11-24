Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506443;
	b=ccBpVP6GJyZexpA7jVoG3TC7ft3EsRfEuwffD1+cZnoSpH5d8t8jgbtRxMTE+3bW+0/5
	 MQKVPnTL0i9xr7Z6PnpItIpP95GFXJmQCyPuuWuGc8MizIRWQm9Sc4C2nrRtnEq7JoVb6
	 q2AsmRiTCqwKYkmpG3BF2mnsNL9pnoLaA5DoGEVMDL26tfRcnDMjs2XfTZ6dGmXMhL7N0
	 miE3OE9Um9If0rU05ic+s0DoeniP2yXlXPJunFldAkghlD+1mnIDm+WBdFYmVIxGn8Urd
	 +Jsmwvq23aGUE+/bJ/IyhX4+sV5KeLvHRDDGXzh7qWoS4m+VrNq4TmCFc0AJDQ6YSCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506443;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=cZCl0OxNsgxdA/QB5hhJ6JhPi9t4AL/d2MvvIkbtiIg=;
	b=G15hF3YD8o/gHQ3nLK8JoxDK6m6shIIfHzDnP6ux0gMP+ckfbNFzbg4itvc40Wo6ccp1
	 A4zeLUk8WOENydr4Sj6ysC1vNZ0KXj7rVx2JfC3wY5NwY3b6gXRKGSeeq4uBKElWoOvlh
	 k6muhnJ1rA8a36pEcw/pyksO3/nM6Uf78AshkQ7nGgZaBGgFySzEPunT3AnwkSP9fjpnK
	 lNFz0UVY0WnMC9TnWj2ysecBoBdZdCw93IOOCg3o1k8cj/aawgpe0riT1H6Eovcw1Pvpi
	 9SoEHa6f1LZUeawJnvh+RUSY9ndZhbSQG8dIvKcubN50T17Y02TdDEXSs5CdnRo24TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mRYcY5jN;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A7C606A326;
	Tue, 24 Nov 2026 07:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29A7C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mRYcY5jN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795506443; x=1827042443;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eDEio4NP4XHZFYRC9FiY7B/+b8uO1ZLby2dslNMzlwc=;
  b=mRYcY5jNpzCsd4FLIGyJVfj13XFBFJ4XJeODX59bwcLBpmKEnODijY7a
   bATCSTxhR1qmC84CSCfauYxs+PN8OZFmSJxDbPZKDTVgmPvMjvbisw3lz
   3O6+jGqUqxPTGYbJgeMEhRusRkUSBbps4R6PEJc126OmR4s7LjnuGl73y
   27ilyIjQ0z4YBnxMSs7T/QjQlpzkI0onfaJxNHCHymA5VpZUL+aZswU0v
   Nv8s9uggaOVadUKSt8dSPW2BlEbLOHui5Hcaisu1gtS/lCAemVgCFkPA1
   B+sYEufTVOt6YqdKsVLHgtP/LPo/od4APLrhqaOJiaf1+Zrl/xgeBwMsV
   Q==;
X-CSE-ConnectionGUID: 80zuOGW9S1WDBz70KNLFmw==
X-CSE-MsgGUID: 5sZojpOnQl6zdCv1g/qVsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4209493"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4209493"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 23:47:22 -0800
X-CSE-ConnectionGUID: Y7ovl1FcTrODbD1EE6Ad8w==
X-CSE-MsgGUID: uPqfXCORR+6F4Zx05hLBug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11674543"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 23:47:18 -0800
Message-ID: <9ab1e5b7-fa03-473a-a251-91153fe5c7b3@linux.intel.com>
Date: Tue, 24 Nov 2026 15:47:16 +0800
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
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, x86@kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
 Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] iommu/vt-d: Add interface for tdx-host when
 enabling trusted DMA
To: Xu Yilun <yilun.xu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-5-baolu.lu@linux.intel.com>
 <awRW3ESp3sBoxtJ9@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <awRW3ESp3sBoxtJ9@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/2026 11:08 PM, Xu Yilun wrote:
>> Add a per-device interface so that an IOMMU is put into Secure TDX Mode
>> only when a device behind it needs trusted DMA. tdx-host tracks how many
>> devices use each IOMMU and calls into the VT-d driver only for the first
>> and the last of them:
>>
>> - dmar_tdxc_get_params() looks up the DMAR unit translating the device
> I think tdxc is not a good name since "TDX Connect" is not preferred as
> a technical term. These APIs would be used by x86/tdx, so can we at
> least avoid using tdxc for these APIs?

I'm open to this. I used the dmar_tdxc_* prefix because the VT-d spec
calls this feature "TDX Connect Support". Since these are interfaces for
the tdx-host module, I'm fine with renaming them to dmar_tdx_*.

> 
> [...]
> 
>> +static void dmar_tdxc_fill_params(struct dmar_drhd_unit *drhd,
>> +				  struct dmar_tdxc_params *params)
>> +{
>> +	params->reg_base_addr = drhd->reg_base_addr;
>> +	params->node = drhd->iommu->node;
>> +	/*
>> +	 * params->drhd stays valid because trusted DMA-capable units are
>> +	 * never hot-removed.
>> +	 */
>> +	params->drhd = drhd;
> Why we store drhd in the params, any information to expose to TDX via
> drhd?
> 
> [...]
> 
>> +/*
>> + * dmar_tdxc_get_params() - Get the IOMMU information for a device
>> + * @dev: PCI device that will use trusted DMA
>> + * @params: Filled in on success
>> + *
>> + * Look up the IOMMU that translates @dev and return what tdx-host needs
>> + * to issue TDH.IOMMU.SETUP and TDH.IOMMU.CLEAR on it. This only reads
>> + * information and doesn't change any state. Devices behind the same
>> + * IOMMU get the same @params->reg_base_addr.
>> + *
>> + * Return 0 on success and error code on failure.
>> + */
>> +int dmar_tdxc_get_params(struct pci_dev *pdev, struct dmar_tdxc_params *params)
>> +{
>> +	struct dmar_drhd_unit *drhd = dmar_tdxc_find_drhd(pdev);
>> +
>> +	if (IS_ERR(drhd))
>> +		return PTR_ERR(drhd);
>> +
>> +	dmar_tdxc_fill_params(drhd, params);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(dmar_tdxc_get_params, "tdx-host");
>> +
>> +/*
>> + * dmar_tdxc_acquire() - Acquire an IOMMU for TDH.IOMMU.SETUP
>> + * @dev: PCI device that will use trusted DMA
>> + * @params: Returned by dmar_tdxc_get_params() for @dev
>> + *
>> + * Call this right before issuing TDH.IOMMU.SETUP for the first user of
>> + * the IOMMU. On success, the caller must issue TDH.IOMMU.SETUP and call
>> + * dmar_tdxc_release() if it fails. The caller owns the per-IOMMU refcount
>> + * and must serialize all calls for the same IOMMU.
>> + *
>> + * Return: 0 on success and error code on failure.
>> + */
>> +int dmar_tdxc_acquire(struct pci_dev *pdev,
>> +		      const struct dmar_tdxc_params *params)
>> +{
>> +	struct dmar_drhd_unit *drhd = params->drhd;
>> +	struct intel_iommu *iommu = drhd->iommu;
>> +	int ret;
>> +
>> +	if (WARN_ON(dmar_tdxc_find_drhd(pdev) != drhd))
> We can get drhd via pci_dev, then why we require callers to input
> this info and judge? Like an intelligence test?

The drhd was there so the VT-d driver could check that @pdev and @params
match. But you're right that the check only exists because the API takes
both. I'll drop drhd from the params and make acquire()/release() take
only the pci_dev, so there's nothing to mismatch.

Thanks,
baolu
