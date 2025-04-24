Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E71EA7C1
	for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485303; cv=none; b=QIEZr8RfeUicflFukveIG1jl1YgvIHJUXJ/aRuMqGB9mmkuUxfwpUUl2vRi7XwlI0ygA0Nop+BY7/q7XDiRnDb47GbpVQ3IjAxp962rcazRa2PvTRy18aPjU37dft6rhn2hrOuEj/TeqWbkMRq5DpqtR0KcUvTSkDQE5DLbtb0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485303; c=relaxed/simple;
	bh=UcIx/LKC2xB16Q6OMpibx6bXvHK+qw5ZQHXhUYcD9dQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NzUGKWxB7aY0nEz2x/mdz67DoW4c+q5TgzUOs88mXk4BwLoy3/26FOL1gOatHU+7/phbQwU7RHVr+3c0mHfcNrLBHG+n5CyOcytc2oK+hsPqXHeVdChB0HkJ5ktgTAPxS3actqYq1w0XmXhlhe+2s7JsBTSBbdwkEhP+jSBN6lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AY6iGCsQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AY6iGCsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745485301; x=1777021301;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UcIx/LKC2xB16Q6OMpibx6bXvHK+qw5ZQHXhUYcD9dQ=;
  b=AY6iGCsQo4ogzEiDusei01z+oCyiu39b3I0W7BpcppqXsczHcKfv5RLc
   iK9kOkxhk8F0qL7LCTvuOfNHI9uXzDFtgZrMAXM6e/fJzDBoLMmY65LJ8
   wgggYXu7JK354CT4brUUOP5DwoS4qDoSDqaoyjZ3LhLMeAlt4tif/NdBX
   G7doLsdBqBYJKahswNtJuftC80kK95YganttrNPiOxAOgP9Y3THdbjH6j
   DYKA/3ZG2qGC8gs744K5o1Y4ttzbk7nAlNS5Rt5O9bccEX+Gqhtc270hb
   PPIP0go1D3zG+8D2IgbbYO5gAxVZ2tai7+qYqV/u5wcMc2/WleT71YfVM
   Q==;
X-CSE-ConnectionGUID: 2M3HgTj8SdGTPnylsvreoA==
X-CSE-MsgGUID: CaMcL2QqSZ2w+u1FofbagA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47121025"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="47121025"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 02:01:40 -0700
X-CSE-ConnectionGUID: 4OWnqJccRee92deaA+raAA==
X-CSE-MsgGUID: xAcgRH3WRkOu2V5fJxpCuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="132399944"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.243.159]) ([10.124.243.159])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 02:01:38 -0700
Message-ID: <4541dba3-1a4b-45f6-a607-fe2fe9a9f014@linux.intel.com>
Date: Thu, 24 Apr 2025 17:01:35 +0800
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
Subject: Re: [PATCH 1/3] iommu/vt-d: Use ida to manage domain id
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20250423031020.2189546-1-baolu.lu@linux.intel.com>
 <20250423031020.2189546-2-baolu.lu@linux.intel.com>
 <BN9PR11MB527656492CD69CA4EA0EC7338C852@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527656492CD69CA4EA0EC7338C852@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/2025 3:37 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, April 23, 2025 11:10 AM
>>
>>   static void free_dmar_iommu(struct intel_iommu *iommu)
>>   {
>> -	if (iommu->domain_ids) {
>> -		bitmap_free(iommu->domain_ids);
>> -		iommu->domain_ids = NULL;
>> -	}
>> +	ida_destroy(&iommu->domain_ida);
> 
> since ida_init() is in alloc_iommu() now, the destroy can be
> moved to free_iommu().

Sure.

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index e25e8d3dedcb..9e17e8e56308 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1198,6 +1198,7 @@ static void free_iommu(struct intel_iommu *iommu)
         if (iommu->reg)
                 unmap_iommu(iommu);

+       ida_destroy(&iommu->domain_ida);
         ida_free(&dmar_seq_ids, iommu->seq_id);
         kfree(iommu);
  }
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f784df122d7a..0002511c561f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1304,8 +1304,6 @@ static void disable_dmar_iommu(struct intel_iommu 
*iommu)

  static void free_dmar_iommu(struct intel_iommu *iommu)
  {
-       ida_destroy(&iommu->domain_ida);
-
         if (iommu->copied_tables) {
                 bitmap_free(iommu->copied_tables);
                 iommu->copied_tables = NULL;

> 
>> @@ -1399,14 +1356,13 @@ int domain_attach_iommu(struct dmar_domain
>> *domain, struct intel_iommu *iommu)
>>   		return 0;
>>   	}
>>
>> -	ndomains = cap_ndoms(iommu->cap);
>> -	num = find_first_zero_bit(iommu->domain_ids, ndomains);
>> -	if (num >= ndomains) {
>> +	num = ida_alloc_range(&iommu->domain_ida, FLPT_DEFAULT_DID +
>> 1,
>> +			      cap_ndoms(iommu->cap) - 1, GFP_ATOMIC);
> 
> let's define a macro e.g. FIRST_DID for min.

Okay, how about IDA_START_DID?

Thanks,
baolu

> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

