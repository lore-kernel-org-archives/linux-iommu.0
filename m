Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A88548DB58;
	Mon, 19 Oct 2026 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397545; cv=none; b=cvT4zwR+tWZbLL9XH4AYZOVRHhnUgkgOQsBxK8N/J/pZ2ASI+Ud7kS2qRt2CcIbTOBl5Ar/7eQ6I9KjEWG74i1CHD1MV7WWHjVaDWW4f8Qq3MpY+rboWOiJVgdNnRN3VGs/N0T9EtN0J6Y8QdqKN44cit8Fso3BZdhpqmSZACmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397545; c=relaxed/simple;
	bh=F62E0+/4F4qgGcCGX2HCnm0q1KbdUrG+InmuZKUrUBY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Uu7wHmrw9XP2F6UKPeKKvsN4FV+lNOHLVRUuNzJqXV+0mcGPKnLlyXPY4ZUdwBFp8BV9g48u1Z9x7X+FfkZJz81NHSEsJx7UvAE0PCLprHsY0M0XVAMULXXjJ5wRu58KB+h1O12V46Cp+xO7uOlAgwyi7yFNs6maue+AgvYwa8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aP1TSt7p; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aP1TSt7p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792397544; x=1823933544;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F62E0+/4F4qgGcCGX2HCnm0q1KbdUrG+InmuZKUrUBY=;
  b=aP1TSt7pDhuUIHqSgcfDRGsH1BikajoB0bWS2swFUBrY1Du5TCfCg/0C
   r92jl7sSRxLY+qP159C3xJGgCPe9chT0fEmyscY/UJ4XDzDqtSxtiRea1
   rYOGXq37oU5rJLLZp0O1R6fEAdfFzAurSWwnNr6VCX3hsCikX4tY5UCV9
   lVTKNqjCvyhrNSNcMqzc8/c6v8beI+biE9iBl0Js3qZYxwHfEVzEqhWmF
   C6bEvNJhkSanWRhnoDM8vz73N9m+KknRXhdh1UC7j5Rh9co3qJH+pnhIv
   wvCBBTWVj6Kb5g2CEe3/Pv5w9JCwgocvQQtbdog6xe+h+/gTgT87qvNwq
   g==;
X-CSE-ConnectionGUID: Q4Dl0sYnS42ggCHUjQyspw==
X-CSE-MsgGUID: vw9w0ZmQTG+4tqJ9thc9gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1068087"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1068087"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:12:24 -0700
X-CSE-ConnectionGUID: o4RJNjPFS7+qPLJGv+t2Xg==
X-CSE-MsgGUID: SZROF/7MQSCwkJgaMC1W5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2472391"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:12:20 -0700
Message-ID: <23a3c630-a3ad-4874-b13c-b8795cd194a6@linux.intel.com>
Date: Mon, 19 Oct 2026 16:12:18 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Kiryl Shutsemau
 <kas@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050> <20261015173707.GV14213@ziepe.ca>
 <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>
 <CO1PR11MB4836E2CB05E1448BB42047458C9B2@CO1PR11MB4836.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CO1PR11MB4836E2CB05E1448BB42047458C9B2@CO1PR11MB4836.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/2026 3:17 PM, Tian, Kevin wrote:
>>    - The TDX Connect architecture places requirements on the host
>>      iommu driver while the secure IOMMU is being set up. For example,
>>      the host iommu driver must block the enhanced command (ECMD)
>>      interface while the TDH.IOMMU.SETUP SEAMCALL runs, and it must
>>      reserve the upper half of the domain ID space. These steps have
>>      to happen atomically under the iommu driver's own locks. As a
>>      result, the Intel iommu driver needs to merge the two steps above
>>      into one.
> Didn't get this. Both ECMD and DID reservation are TDX specific things.
> How are they related to the two steps in the ARM sides and why calls
> for merging?
> 
> and why are they must be done atomically? they are conditions to
> execute TDH.IOMMU.SETUP, but it is perfectly fine to reserve DID
> at an early point then block ECMD later...

You are right, "atomically" was too strong. Only the ECMD block has to
bracket TDH.IOMMU.SETUP. So I plan to restructure it as follows:

- dmar_tdxcs_init_prepare(dev, &params): resolve the device's DRHD and
   take a reference on its secure-mode state. For the first user,
   validate the preconditions (TE/QI/SM enabled), reserve the upper half
   of the DID space (failing with -EBUSY if any of it is in use), block
   ECMD and return what tdx-host needs (register base, NUMA node, etc).
   If the unit is already in Secure TDX mode, just report that so
   tdx-host skips TDH.IOMMU.SETUP.

- dmar_tdxcs_init_done(dev, result): unblock ECMD, then either mark the
   unit as being in Secure TDX mode or roll back (including the DID
   reservation), based on the SEAMCALL result. It must be called
   whenever init_prepare() returns success.

- dmar_tdxcs_release(dev): drop the reference; the last user releases
   the DID reservation and clears the Secure TDX mode state after
   tdx-host issues TDH.IOMMU.CLEAR.

These are called from tdx_tsm_link_connect()/disconnect(). Any failure,
whether a precondition, DID reservation or the SEAMCALL itself, aborts
connect with the corresponding error.

Thanks,
baolu
