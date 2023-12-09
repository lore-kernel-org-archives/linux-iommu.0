Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0951C3E
	for <iommu@lists.linux.dev>; Sat,  9 Dec 2023 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzR/ci46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702108910; x=1733644910;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NUc+BkL6jE5j3KWG1JFS0oURBsEf4rQv7us7KnVUVP8=;
  b=nzR/ci46d+eOrbn2H+mp399qDbAVLff58HgOKYm9WoxKtPrImNCTblcy
   IFewpUst532RfDLv3ATncSYZ0lpFVmbc/M3Y64JQ+PqDsUwTQHolFw3EI
   0SNldUiQHY+Dg2fedyzdV3CDPkxTUyeR6Guc1f+HG41srAl3jVegnaVea
   HpTrJjGc2Sn1Gt+/g2eE76yjgz1E1OAMYYfB/zucIriF1dmeoUOb7EGJw
   WupEgrN5uu0vn5feTNR6yQlF1JMoe9ySeFD+DjQvkoGeP2+09VOi/95MO
   KTSIOoUyzndw8quLofG1jBVwRg4uT2YtzVm8PkQ4XAnrg3YfCSaTbcnMk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="393367976"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="393367976"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 00:01:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="765743417"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="765743417"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 09 Dec 2023 00:01:47 -0800
Message-ID: <93847593-3fe2-4292-b579-f65ebc3772ac@linux.intel.com>
Date: Sat, 9 Dec 2023 15:57:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] iommu/vt-d: Remove scalable mode context entry
 setup from attach_dev
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-3-baolu.lu@linux.intel.com>
 <BN9PR11MB5276C76349963BBF68307FF48C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C76349963BBF68307FF48C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/23 4:56 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, December 5, 2023 9:22 AM
>>
>>   static int domain_context_mapping_one(struct dmar_domain *domain,
>>   				      struct intel_iommu *iommu,
>> -				      struct pasid_table *table,
>>   				      u8 bus, u8 devfn)
> 
> since this is called in legacy now it's clearer to add a legacy_ prefix
> to this and other related functions.

Okay, that would make the code more readable.

>>
>> -	/* PASID table is mandatory for a PCI device in scalable mode. */
>> -	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>> -		/* Setup the PASID entry for requests without PASID: */
>> -		if (hw_pass_through && domain_type_is_si(domain))
>> -			ret = intel_pasid_setup_pass_through(iommu,
>> -					dev, IOMMU_NO_PASID);
>> -		else if (domain->use_first_level)
>> -			ret = domain_setup_first_level(iommu, domain, dev,
>> -					IOMMU_NO_PASID);
>> -		else
>> -			ret = intel_pasid_setup_second_level(iommu,
>> domain,
>> -					dev, IOMMU_NO_PASID);
>> -		if (ret) {
>> -			dev_err(dev, "Setup RID2PASID failed\n");
>> -			device_block_translation(dev);
>> -			return ret;
>> -		}
>> -	}
>> +	if (dev_is_real_dma_subdevice(dev))
>> +		return 0;
> 
> is it a functional change? old code doesn't early exit for such device.

This type of device is aliased to a RID on another bus. Therefore,
there's no need to set up the context and PASID table for them. I should
make the change mentioned above in a separate patch to make the
background clear.

Best regards,
baolu
