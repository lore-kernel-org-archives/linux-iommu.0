Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575471;
	b=VpifVHYqJDQRTt1fhFCQNQ8GluKd4KwthZpLPS96XM2FYILOGFFKm+yo8uW6jYivb0d8
	 Sa3iMZe6x9VkD/lRt5SwtKAV7pgwGKrVVidRbpM5EdsSi2KlotG5+/lnA2h8jnzTYeX/P
	 BSzUmDZEcfQMdddPRRgAoownYzAtQLS4M12ksOjrULoDJWR7fTsTyjC9ms1GrCE5SOHOH
	 UMyiM7v9eQTaDRKoc4qoSXn2JlvVeyJ8iOELIjhJ5M1g6AaOt4Qt8kr8fNhDA6BMDwr3q
	 99G6XPavxSEY15rHulo9EVttq+vwRcw6kbx5fpKfpLVO6y+vBErJKO/Inj7BaPGbPCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575471;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=DqdH48qbeeTIPU/MMal9aRyucQ5S+jscMJXwGqSYhak=;
	b=Y49gH/kg80JKNREhxezjqYjX3hfYN5kfBugREDjemqm1ib1t8A0drvjgxrQvDNVNIrbI
	 PDiyJTtNrNQTsEiZAdr9K/459N6sVSvjQ4+bUNyeIbLGqSLAJMnhpp7aByvJyRSWsuBLs
	 KMob2G3Me947JPrDcFdlmX3B/kbLPLmB1EPaAczMUTlWaIxkBs+i0j80I4NFqle5uoL+D
	 QrtvqqudrvS+Sp8Jaj8VyFcAaV3D7orLLWg+99N5VBuFHs5DSsGsDJKOET8HpKuC1Fm51
	 mdRnx07N2wsg6u4LdLzwpcMicJpP4CplBQaSv/8oPHLthLfcPMLkM2txPO/zzH1QL6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fpmd9S+W;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE770606A321;
	Wed, 25 Nov 2026 02:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE770606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fpmd9S+W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795575471; x=1827111471;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hBXaaSjSnIZ8q+a+Q1Y+asuqrPnvsTtRyx/khUd1WI4=;
  b=Fpmd9S+W7cIr1VAcDni/Yg3s+lfn3WilqhRQVjEohcXxR0+rShyAN+E5
   rDUgiJRbB0l+Fi3Ns2+KzLojgJn6RJ3VOBcC0yej6N2pVjjGjbLSXX3GA
   tz6TLAU6d9D6ggzcKX/lPUeNaEAgKhrn9k0i6bQ+yXzdrTSypn9+ATzes
   Q7b5S+cczy0zyEp8AhIJ5ct+pv3ahDFMlMNWy51NW7RvZVx9W59cTVVbx
   I1SWE3YWmNz1hYIjTtissYjqAnDEAQ1thdWEkslsgdrFspVKdxtvQ26D6
   HBRUWRMEutMCk90DhmKNbcEAtql3FC+7SCGVjB7lCc2ItdDdNTFfDst1w
   g==;
X-CSE-ConnectionGUID: pO12kHR9TY+C5DDwPc4oaQ==
X-CSE-MsgGUID: uqK4qdAKSoeUaKSyJ+jV8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4339247"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4339247"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 18:57:50 -0800
X-CSE-ConnectionGUID: XIQPsWwYQIy0N1gzI8vwlA==
X-CSE-MsgGUID: ldw1n/tdQgutvyocEUZdDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11529710"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 18:57:47 -0800
Message-ID: <b069428b-85e1-4aa4-a53a-d7baf43f629e@linux.intel.com>
Date: Wed, 25 Nov 2026 10:57:45 +0800
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
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kiryl Shutsemau <kas@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/9] x86/virt/tdx: Read global metadata for trusted
 IOMMU
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-3-baolu.lu@linux.intel.com>
 <f2c46640-959d-4fb6-a313-0f907c127414@linux.intel.com>
 <158ce0a3-3bd7-4be6-89e7-ecac25027404@linux.intel.com>
 <CO1PR11MB4835BE5970A03254F7B0BE518C442@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CO1PR11MB4835BE5970A03254F7B0BE518C442@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/2026 4:13 PM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, November 23, 2026 12:10 PM
>>
>> On 11/18/2026 9:39 PM, Binbin Wu wrote:
>>> On 11/12/2026 12:30 PM, Lu Baolu wrote:
>>>> Add support for reading the global metadata of the trusted IOMMU.
>>>>
>>>> The trusted IOMMU feature is optionally enumerated via TDX_FEATURES0.
>>> Nit:
>>> The feature enumerated is TDX Connect, I don't think they are
>> interchangeable.
>>> Trusted IOMMU is part of TDX Connect, right?
>>
>> Yes. I will update it like this:
>>
>> Add support for reading the global metadata of the trusted IOMMU, which
>> is part of TDX Connect.
>>
>> TDX Connect support is optionally enumerated via TDX_FEATURES0. Check
>> this feature bit before reading the metadata to avoid causing the entire
>> TDX initialization to fail on platforms that do not support it.
>>
> 
> let's not introduce new terms here. TDX Connect is Intel's branding name
> for trusted I/O. Intel IOMMU introduces a new TDX mode to support
> trusted DMA for trusted I/O.
> 
> so here we just read metadata of the TDX Connect feature, which includes
> information to enable the TDX mode in Intel IOMMU, blah blah...

Okay, sure.

Thanks,
baolu
