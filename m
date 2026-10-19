Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF0494828;
	Mon, 19 Oct 2026 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397774; cv=none; b=prX2drllGOaOESijDALixu7AN+UqhH3JGS0nhvhmaLxH3YZR3erEvzDnehqs49H54zXLImXmutXjhmitiklhIhKTC5Wmbf+BNXhtMikXrxBrgRYlWn417YUg8N6Cxdu+7XcVC+5buHR9Hmj2/lY9kWSozSrDCVlNq/yapUxqXkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397774; c=relaxed/simple;
	bh=n5lBXwZoo/QGly06Q25SeLTusYSaZeeUBDNAk4Zykg4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Utyp+kgYZYj1hvka5qXIxwdQd3xj7VMAAzEailBdydW6nytZcoIy5R8GlxobbeEvJA/SQ3OorimX3GNm+r+ev7ikJ3JHSiUSUU3ezBUOmycoOqwmNjIiY3kLN/Yx67mzi1wC4uLzqazREfz24A7S+if9BWhg8+MpWCQsS3YupRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQR4JkYF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQR4JkYF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792397774; x=1823933774;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n5lBXwZoo/QGly06Q25SeLTusYSaZeeUBDNAk4Zykg4=;
  b=QQR4JkYF2ePp7vwUd4exvomnOTX58Fyb/o3dQOdJ6nI3NLrbn4041M6O
   3hfsp+ry05Y8QFhGwuaYdkbDraJHQ/JaXRbx1DhUOOioUaKOQxPa6iIwv
   7pcxReAP29FogTmelsuyHnc04PyAY2pGFC3s9vOhUXZ1SCahnCfcjGD/u
   zFWMAPoCy/QasxP4WUEYr1EPVelxlsRRcZS1UzQUtACPwZdJeRz529fRL
   w9ZheCOH+eAmWn1i+CR7onppeqxhz5aw35rhMyv77SuanAqQ4inyDNNhL
   q/tQ36ZADZLuovo9wo7qaVDyq+YvsgB7cNGsj5EJP8jOWIKNcbmzSLxVu
   g==;
X-CSE-ConnectionGUID: PXG6lt5fTHyikIyxwZi1Uw==
X-CSE-MsgGUID: ISwSZft0QfCqggzLqCMgnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1068414"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1068414"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:16:13 -0700
X-CSE-ConnectionGUID: ra6B8tzIQDKubPXFVSQOZw==
X-CSE-MsgGUID: ktsOZfYLQ9+9SZ3/45UnCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2472847"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:16:09 -0700
Message-ID: <666e6f72-eea0-4a1b-919a-9187a52cbe1c@linux.intel.com>
Date: Mon, 19 Oct 2026 16:16:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Kiryl Shutsemau
 <kas@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
To: Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050> <20261015173707.GV14213@ziepe.ca>
 <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>
 <CO1PR11MB4836E2CB05E1448BB42047458C9B2@CO1PR11MB4836.namprd11.prod.outlook.com>
 <20261016145830.GA448730@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261016145830.GA448730@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/2026 10:58 PM, Jason Gunthorpe wrote:
>>>    - The TDX Connect architecture places requirements on the host
>>>      iommu driver while the secure IOMMU is being set up. For example,
>>>      the host iommu driver must block the enhanced command (ECMD)
>>>      interface while the TDH.IOMMU.SETUP SEAMCALL runs, and it must
>>>      reserve the upper half of the domain ID space. These steps have
>>>      to happen atomically under the iommu driver's own locks. As a
>>>      result, the Intel iommu driver needs to merge the two steps above
>>>      into one.
>> Didn't get this. Both ECMD and DID reservation are TDX specific things.
>> How are they related to the two steps in the ARM sides and why calls
>> for merging?
>>
>> and why are they must be done atomically? they are conditions to
>> execute TDH.IOMMU.SETUP, but it is perfectly fine to reserve DID
>> at an early point then block ECMD later...
> That's going to be a bit of a PITA, since the DIDs can be in use when
> the tdx module is start potentially.
> 
> I suppose you can start out by just failing if this has happened.
> 
> But as soon as reasonably possible once the system opts into a TDX
> operation the VT-d drivers should stop using the upper did space.
> 
> Otherwise you will have to implement live DID renaming, which is a
> PITA in an iommu driver.

Yes, agreed.

Thanks,
baolu
