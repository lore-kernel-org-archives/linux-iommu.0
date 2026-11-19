Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795056750;
	b=HeqSTAw1j3+KQ2KLkobuijp6dfvCwTasMxVkBJS3lXSBEMeUW08NXWztCnTPhV6olX57
	 /h4q7fWz2kHD5b1iijiN5v56F3RwwxTSLiXn1wE37G4jep0dBzbmERAJSdXpa4t4zgD3k
	 TXdVxjxNrnBHwxiEIAraueacQE8NAatDVFj8gh9wNqEmVxgs2QgtPjddwXtzvEbwASYz+
	 m9D7FuWdWntYdj6NrIUvCSaoM91+zhJstceMWnBke0zLui0W78tcZAQJmyHZ3v+9vPChc
	 i8RRq1tmwJkbslZLCht6TR3n8BErC+J1Yk1A3e9gJAHCewtHIlpdrVGuBrkjLE5eSzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056750;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=hqaJ3AKKV5UoAnmGdJpR51q3f45RxukokiAmVcUo/ns=;
	b=S67wHydEDX4hO1TOutDfuEdTCWnYkhSk93Ih/VTlUjjO8LuyTzgqTUuSJRnpZN4+oSAY
	 RUcwcUKmzCuCVD4LRbFddhpuK+w8vSvJm5esWyJ8oLR5NtdNCn3gAzQK0IfQ6zqWkCmvn
	 eNWNHDGp4faRYvqzw99IWKyL53jq+5bKK+7g6doVQjYRfc/aUjRMoRfKUuVRL5MIWlQuT
	 uYwwzy/cs5xCjiguCnU0xaBjAMsZkrgjNHU4JuUvGnfqVVKXHzaMWseeisHYdo+tHZqi/
	 wTuADN5RPgilcrDgyCNd3JQSSRG+4npCR7E8c69NW67m7Ngc/XgrJKKZ5jo9Okx/4Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CVtbOSvm;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF691606A325;
	Thu, 19 Nov 2026 02:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF691606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CVtbOSvm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795056749; x=1826592749;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l8yCQ1ySx0XtQMlmK6BwZg43oQMUFeCh0WIqFay6wAg=;
  b=CVtbOSvms1Grx1Nk2ulxag0EOge+OP8by6gHVhrzb/aqL82rTgN9c8nI
   fwAxE3Xhvs1gc1CsLClRvyGT1jxDgsdaj8V0nneJEw0ragCvm3CYWtVu2
   DgkPoDxqIKcGcS6z0z8RmvOmcxwF1DZWVXCDmDy3cdJ4N3AVv40q5IeLj
   FG+GAdLhil0K9RLDibkzicgiYevALn6ogbbudPppm2ym7e1bVH7fJiov0
   7pu2maQ0G52uRtsuRQlXT8qOdt3MK6i0EF+GLKVxU92bHHWNvC/F6v7/V
   7Q7ZRnAihuknW+wTt8LMzjOIpi5v7kJJG2Qest84ycQUzFXqOC3dbuSU0
   Q==;
X-CSE-ConnectionGUID: gLi02E2ITSSDYttPJcPXjg==
X-CSE-MsgGUID: 1rJhHlL2Tru1dKWd7+c9+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3902042"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3902042"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 18:52:28 -0800
X-CSE-ConnectionGUID: UBmr5AoKQZ6XNpdnwx8bYg==
X-CSE-MsgGUID: HKAlHNiISz+5v4TblkfH9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10555744"
Received: from unknown (HELO [10.238.2.135]) ([10.238.2.135])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 18:52:26 -0800
Message-ID: <de1011bc-1cc0-4409-af76-4e90dcef6cf4@linux.intel.com>
Date: Thu, 19 Nov 2026 10:52:22 +0800
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
Subject: Re: [PATCH v3 7/9] coco/tdx-host: Add skeleton to support PCI link
 encryption
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, x86@kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, yilun.xu@linux.intel.com,
 xiaoyao.li@intel.com, Chao Gao <chao.gao@intel.com>,
 linux-kernel@vger.kernel.org
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-8-baolu.lu@linux.intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20261112043054.2664857-8-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2026 12:30 PM, Lu Baolu wrote:
> Register a Link TSM instance to support host side TSM operations for
> TDISP, when the TDX Connect support bit is set by TDX Module in
> tdx_feature0.
> 
> This is the main purpose of an independent tdx-host module out of TDX
> core. Recall that a TEE Security Manager (TSM) is a platform agent that
> speaks the TEE Device Interface Security Protocol (TDISP) to PCIe
> devices and manages private memory resources for the platform. An
> independent tdx-host module allows for device-security enumeration and
> initialization flows to be deferred from other TDX Module initialization
> requirements. Crucially, when / if TDX Module init moves earlier in x86
> initialization flow this driver is still guaranteed to run after IOMMU
> and PCI init (i.e. subsys_initcall() vs device_initcall()).
> 
> The ability to unload the module, or unbind the driver is also useful
> for debug and coarse grained transitioning between PCI TSM operation and
> PCI CMA operation (native kernel PCI device authentication).
> 
> For now only check for TDX Connect support in the TDX Module and
> register the Link TSM. The TSM support is basic boilerplate with
> operation flows to be added later.
> 
> Based on work by Yilun and Dan.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

[...]

>  
>  static int tdx_host_probe(struct faux_device *fdev)
>  {
> -	return seamldr_init(&fdev->dev);
> +	int ret;
> +
> +	ret = seamldr_init(&fdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	return tdx_tdisp_init(&fdev->dev);

If tdx_tdisp_init() fails, it will also disable TDX module update and the
version sysfs attributes.  If this is intended, could you add some description
in the change log about it?

>  }
>  
>  static const struct faux_device_ops tdx_host_ops = {

