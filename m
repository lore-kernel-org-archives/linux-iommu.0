Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F74963B1;
	Mon, 19 Oct 2026 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397841; cv=none; b=iR0QEZVwhT+6re0QLr74XKKyAWUaiUh4FkqaoO7NPv7gYXziSDBAgiiGaVzW99mnNXxl/TyT6tp/JR7lE4tyl+laKo5wH0CDTfh1nj3CKARxgXGb4AhUFMYNJSez10CZJTj5+Gs78s9tgqcpxf8SzxAq+QkjX44NrKrEmNtGfW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397841; c=relaxed/simple;
	bh=txTlcIq2wibIcgS8dD5RBq7NnIQjb9KfqaLxlilPlVw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kOnQvTYxGbnCmjcPf3OqARpqMdE8duLYRYOCXK/BTZMjkARJeo2VuDbsmN8/O1XWpB6ih+6JAcbiV1XC4sTBdFxx9D+UFe6M96y39OZQkh4x5DD5Qx3rAOCgoJCoLUGh62c3YA8RzhCE0pPTa4uMsu8dSBUORWr1B7lhgjU+EHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+7ngSuv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+7ngSuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792397839; x=1823933839;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=txTlcIq2wibIcgS8dD5RBq7NnIQjb9KfqaLxlilPlVw=;
  b=G+7ngSuv4QkHtAeir5usNaDUyTSqLJPN9RUTAFqaPctRvZkkSp6IJ1WJ
   fPWBkG/KJZYyBA5CVznlY552dIgAdS2xRCiFx2ou3J2NYt0tAvEZ4WpNG
   1XPoUL4WZT3i7MVJ2C3337DgeD2FtOyQf0P/Qym1foPxyr5FcwVRKH3hX
   cll4pvwrq0TBo1eidNnaH2zspfsLwlJvWz0WrziXT+pabOgcKqkUk5nEA
   mqMDHFvqtWKxjkIDynMnKSbt7TU/wWaKWA1f63t9fScO6MGHkcMDud+CO
   rUo6VTSmr+3JIiXzRFIBMACIf//NcU0UTn5fAyug9V5QRxFrtUrTpE2Ws
   Q==;
X-CSE-ConnectionGUID: zG6sMSChTt2H28Z6gYjYcA==
X-CSE-MsgGUID: 11TsCZLuQr+CbGCOCo/cnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1074048"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1074048"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:17:19 -0700
X-CSE-ConnectionGUID: 9SFcXbK0TjiYCAUtng654Q==
X-CSE-MsgGUID: LpGE1KfzSmSNwVY0EWctBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2539942"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:17:16 -0700
Message-ID: <79df33cf-f5b8-45de-8ccf-1d2d8e841892@linux.intel.com>
Date: Mon, 19 Oct 2026 16:17:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Xu Yilun <yilun.xu@linux.intel.com>,
 iommu@lists.linux.dev, x86@kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
 Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050> <20261015173707.GV14213@ziepe.ca>
 <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>
 <20261016145843.GF14213@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261016145843.GF14213@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/2026 10:58 PM, Jason Gunthorpe wrote:
> On Fri, Oct 16, 2026 at 03:03:23PM +0800, Baolu Lu wrote:
>> On 10/16/2026 1:37 AM, Jason Gunthorpe wrote:
>>> On Thu, Oct 15, 2026 at 04:31:31PM +0800, Xu Yilun wrote:
>>>
>>>> An alternative could be, bringing up one IOMMU when an associated
>>>> device requests link encryption. Then a no-tdx-support iommu fails the
>>>> encryption request naturally.
>>> That is what ARM is planning to do. I think it is reasonable to
>>> trigger creation of the secure iommu when the TSM is connected to TDX.
>>>
>>> Fail connect if the iommu could not be created.
>> Yes, agreed. The Intel iommu driver could use per-device interfaces,
>> just as ARM is planning. There are some differences, though.
>>
>> ARM's interaction with the iommu driver in viommu_init() appears to
>> consist of two steps:
>>
>>   - arm_smmu_get_realm_params(dev, &params): get and validate the
>>     physical iommu information from the arm-smmu-v3 driver;
>>   - cca_psmmu_get(&params): activate the physical smmu for Realm use.
> Okay, I haven't looked, not sure what is in cca_psmmu_get() yet
> 
>> So the Intel iommu driver will probably end up with interfaces like:
>>
>>   - dmar_tdxcs_iommu_init(struct device *dev, ...);
>>   - dmar_tdxcs_iommu_release(struct device *dev, ...);
>>
>> These would be called from the connect and disconnect callbacks of
>> the TDX link ops:
> It seems OK
> 
> It sounds like you will have a one time init of the secure iommu at
> the time the first PCI device wants to use the TSM? It seems like no
> problem.

Yes.
