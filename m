Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE91171C
	for <iommu@lists.linux.dev>; Fri, 31 May 2024 01:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717118508; cv=none; b=MLhghcSF2+rAOCgmU93wpM2sUX9WWV4JGVFj7v06rYUNDbQsg89keKdbh9GC3gzrWwYduKMfL39zoql1SufIV9xb0IZDqGjNJjW+xXL2+KeDWal1bCJAV3cpj53mb+vP4GErkUQuTiqIeF1mpn0AaPO3mNMxIPS3jn9A/UhyQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717118508; c=relaxed/simple;
	bh=oduJrBgxC7GPahDyRFBPQ85EMmHXFVU+B7UUePfvsVo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lUvV466FpU7lZe69ugK2VUkdSfMtTuT0NZXhnb7QSPu2uCabWs+mym8gPrY+7E83D8a06cNvUaGnLXtcyrXG7FTpS2vpdlAqJHrg9kUaTQgEzbd6+zI3YHuAlTqwRLngkaTB7BBW39XgZhUYyW2yY0r0gckL4M4xqxcUyQyN/H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cCRn7uNY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCRn7uNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717118507; x=1748654507;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oduJrBgxC7GPahDyRFBPQ85EMmHXFVU+B7UUePfvsVo=;
  b=cCRn7uNYwb++7opeutKEMEtve3gQ5saoOP3lC2d91ABFFa6pnae/XRFy
   mjHqSzwyGHeX4PYzjUxKsZjrjyCsobIjfdqIIYOpVwE1x/iMN9642erh/
   cwY1RqB9pC27qdDWs8iCikeXkIFX71z0CJ4ym2xyzNrxgm1reSnr4QMBQ
   y0GnxIukSSAo+T1iBEG3CqmhIjc7GqQPxn6oky6IJfl2TtUSmlRL9YBvm
   WY+NXWEWMIKMHalBdGN5rDCTCXBqfGw6qq/MVfgyCZcL7v+vqXQcyc4zQ
   ugUF7kjuVf6r/TqHYnGBKnWor5cLSobQutZPjuhle8fy2I9E8UNNZMySg
   A==;
X-CSE-ConnectionGUID: CWboIetNRIKyQKPXeE434Q==
X-CSE-MsgGUID: vc9E5hnpTVCoBFs1L9reTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="36180234"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36180234"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 18:21:46 -0700
X-CSE-ConnectionGUID: knuVU2IfRFWTjds6ES9ncg==
X-CSE-MsgGUID: KOMsvPMzTfe0JmIFF4SbHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40921229"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 30 May 2024 18:21:45 -0700
Message-ID: <1333039e-ec61-467e-a0ee-d3cb86e769f5@linux.intel.com>
Date: Fri, 31 May 2024 09:19:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: device_def_domain_type documentation header does not match
 implementation
To: Robin Murphy <robin.murphy@arm.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <14311965.TaHA55BQu8@bagend>
 <32921840-43d6-4ad9-99eb-aac32e67e04c@arm.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <32921840-43d6-4ad9-99eb-aac32e67e04c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/30/24 11:49 PM, Robin Murphy wrote:
> On 30/05/2024 2:57 pm, Diederik de Haas wrote:
>> Hi,
>>
>> While looking into 
>> ``drivers/iommu/intel/iommu.c::device_def_domain_type``
>> function I noticed a discrepancy between the documentation header and the
>> implementation.
>>
>> ``@startup: true if this is during early boot``
>> 0e31a7266508 ("iommu/vt-d: Remove startup parameter from
>> device_def_domain_type()")
>> removed the ``startup`` function parameter
>>
>> returns ``IOMMU_DOMAIN_DMA: device requires a dynamic mapping domain``
>> 28b41e2c6aeb ("iommu: Move def_domain type check for untrusted device 
>> into
>> core")
>> moved the possible return of ``IOMMU_DOMAIN_DMA`` to 
>> ``drivers/iommu/iommu.c``
>>
>> But neither updated the documentation header.
> 
> TBH it could probably just be deleted now, since the 
> iommu_ops::def_domain_type callback is properly documented in iommu.h, 
> so individual implementations shouldn't need to repeat that. It's also 
> never been actual kerneldoc either, since it's a regular "/*" comment. 
> Feel free to send a patch 🙂

Agreed. I will make a patch to remove it later.

Best regards,
baolu
