Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795574842;
	b=YoEQ9tWKAILJcplth11r5zLKQ5cZb1sT+l/1MX9OhajmWskt2gwsHARBGFyg0SDJ7Cu0
	 IvW0wkObzJSbRZgncwMTb5zJd2PTT2xsCfxCYoOWpFA+JtJdVwZcHUk+HCuimoX/wyf7A
	 Q60QSw5bxnyoVCwEecxDnzIh0eZ5bv8HlO7kp0vpVnSlvSF3r1DJ4GJ20rTctLvB1JyU1
	 1Mxzfl+39iOJz53/Tpvzv2eIRj61jzFsBUDSKZa3b+0Ytx5U4TrfMfbrZrknkidCyBrO9
	 l8SnhN0UfeD6y+YGpwY+LG2yUmUoZ7miGnsjkGeleOnM425ZyLzM9EW5PLsD2VLE+6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795574842;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=z9JDbde/cXF4XJwReg+HOems1VqaGbHn69aq5xTrCqE=;
	b=fFSiS20nZ5+g4+RdU3ExIi6zEyRlZe3EP3b6n+Xmp3g/9/mE07m4m3giGJ16sFPog+Ch
	 r+VI/S8w7lke9NziPc81NN6J00Lu4Inp3rLco8FOBTCU578YDoCfm7aQ7/JI5l+WDpBGq
	 25xFfR34u4QpiWF/c6vdy5CtMR0a889VYe1lk5UXDWC1ZrXH37FcdNqgl4F6CAurxblW+
	 F0nbY2wrh+JJYPNLz05Ctf8eYeizeHAJ43oXng1jxki9WxAublxHkXk+zkU7dvf3s2+ru
	 P8HeLgv3kPvgOmx+hhp80OKNsdFn6C4mqj6ytQ1q6bniAJ/Y6Mwog6VWttcW4X/FqkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=btXTmNqm;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A35D606A321;
	Wed, 25 Nov 2026 02:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A35D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=btXTmNqm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795574842; x=1827110842;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bIWbjkSwt14UlfiTHh+BSFDnRyyXRUaOpT7+UMvcQVY=;
  b=btXTmNqm7SohNrwJhjNJPpv7Jcr39AKgBLGyhePiEPigjHRHoz+McKk8
   CKG3IV/gE0VQ70qdIAv3ZoI9TkvfNc93VTUAruoA9Di04ogTu9ffE5Hbp
   YUkzkp8LBpWYOamSPxbYWtDwgaR1j8dPc3ulNf+HS8Om0eeQsa7n9Ygwk
   5oM4JkDv0Q/98f2DNehMQjxcTI0IaE3q+ItTtfXuMxiMA2jY+5rK2nTsj
   Wg6oRVbOgH/aVBTxIrNlakpnvOn07+pzRsQ8sQI/5TK5nMGDl4Pz7Flel
   j+EdFxWxvVBNrrNl1WlwNE7Kt2meBIOSAlQtY7YgV6oCfoIShXq49DdjE
   A==;
X-CSE-ConnectionGUID: M26vELz3QFWRH79Do0RoRg==
X-CSE-MsgGUID: jqqQddoXTzG03XZ9X6SGeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4330515"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4330515"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 18:47:21 -0800
X-CSE-ConnectionGUID: AnU/EaElRhGYP22+6VFGmw==
X-CSE-MsgGUID: 4+etw+juR/qydXcwZgDt3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11868933"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 18:47:12 -0800
Message-ID: <8ef35412-44a1-4fca-8ba2-06bbad367b22@linux.intel.com>
Date: Wed, 25 Nov 2026 10:47:09 +0800
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
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kiryl Shutsemau <kas@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-2-baolu.lu@linux.intel.com>
 <CO1PR11MB4835FD5EB44EB94467A82E5F8C442@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CO1PR11MB4835FD5EB44EB94467A82E5F8C442@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/2026 4:07 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 12, 2026 12:31 PM
>>
>> Intel VT-d hardware gains a second set of DMA translation structures,
>> managed by the TDX module and used only for devices assigned to TDs.
>> Each IOMMU has a trusted root-table address register and a trusted
>> invalidation queue, both accessible only from SEAM. The existing
>> untrusted DMA translation path of the IOMMU stays under host control.
>>
>> Before trusted DMA can be used through an IOMMU, the TDX module must
>> initialize these resources. TDH.IOMMU.SETUP does this: it puts the
>> IOMMU into Secure TDX Mode, programs the trusted root table and the
> 
> s/Secure TDX Mode/TDX mode/, across the series

Secure TDX Mode is the term used in TDX Connect ABI specification.

> 
>>   }
>> +
>> +/* No cache flush is needed; hardware keeps caches coherent across KeyIDs.
>> */
>> +u64 tdh_iommu_setup(u64 reg_base, struct tdx_iommu_mt_param *param,
>> +		    u64 *tdx_iommu_id)
> 
> No context why talking about cache flush here.

The kernel normally flushes the cache when handing pages over to
hardware or firmware. That isn't needed here because the hardware keeps
caches coherent across KeyIDs. The comment was meant to show that the
missing flush is intentional.

Thanks,
baolu
