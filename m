Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D870A73176
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054814; cv=none; b=YzBjJordTklsD37ZWR1drnhXph0vnxva6AWphZQokdFj0uLu0bqjHgdWw58Uea1xUwYnn0sdOT2YcM+nFiWJBUk3aiJI1RkoGQDcNTbmuTecQIi8AAk7brVLPAQ9jP9FNFMkimQSnI2zeyHixGAOd1+/C/A4Sj7MS8jzBOCyMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054814; c=relaxed/simple;
	bh=BXAEpURS+SeypUNBeC0r7+4WyjBAo6C076oCfUEC5uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKcQ2b3QarObrWBfErSruKuVBmbjhryADIIwlfH767rMWuI12Iz5lVVLl+MegFql6EEHYS851wZxQjLEtto+n1CgA5wBVQdOQqH4EPl1jMiTRzNeo2NOQqcgH2/Z4EJ4ccLOidfqmCXXGeKCC52Ijr/xxdDpJ9glZMtkzHI6uPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOweQJn+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOweQJn+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741054813; x=1772590813;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BXAEpURS+SeypUNBeC0r7+4WyjBAo6C076oCfUEC5uQ=;
  b=TOweQJn+eeeAsGTPLGgACRhpzVzFSfRylbGEAkJqDrIgZiku2/dS8Rdy
   e6nzOw8NaclP2moddDQD7QNVmk2AhAF24rTnf3xy02gI2vmBbQwHpN4+P
   +pS4bEbxFu0SOoCCTvxzjmikEKNRGYxxGcr0UxEef2EZJpZaC4+XPn+3y
   gdfIpNuON8AEPxIJXvmouvCuy2emhvNxZfj7jtD7ODunQ1LM6BzauuxPP
   Qxgf50qGWV8vpoQxQIrvyPfVV4oYuozFdcPRfWnL+shIW0cFPlvTEjAg2
   RlN3fA7L69x6f/fY1rdaYdOLsLvNgJzFfJBQW/kMG3zmUoDCiW+1W30Db
   Q==;
X-CSE-ConnectionGUID: rUn2qpVpQFa12OrwQJiPmQ==
X-CSE-MsgGUID: ErWx7gA0Qx2cmOvZ17a1yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="44763746"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="44763746"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 18:20:12 -0800
X-CSE-ConnectionGUID: U45R9KtVQ6eG7P16MW5Hsw==
X-CSE-MsgGUID: f7hTfwgyRXGXjjupV7QRhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118023191"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 18:20:10 -0800
Message-ID: <24d8234b-ad59-4b7f-b210-b97d7b5dd998@linux.intel.com>
Date: Tue, 4 Mar 2025 10:16:45 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250303183801.GW5011@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/25 02:38, Jason Gunthorpe wrote:
> On Sun, Mar 02, 2025 at 04:10:46PM +0800, Yi Liu wrote:
>> I'm also thinking about the impact of such a knob. How should we define
>> this knob. Should we allow it to disable/enable ATS? Especially in runtime.
>> e.g. if the device is identified to be ATS untrusted by the admin, while
>> the hw does not support SATS, it seems reasonable to disable ATS for
>> such device. This might change the driver behavior on ATS enabling. Intel
>> iommu driver enables ATS as long as it's available in the probe_device()
>> op. What about AMD and ARM?
> ARM enables ATS when a PAGING translation is set on the RID or any
> PASID is used. Otherwise it is off, eg for RID = IDENTITY
> 
> This seems like a reasonable thing to do to me..
> 
>> On the other hand, we may just define the knob as sats required or not.
>> This is just a knob to let kernel know if the iommu driver needs to enable
>> sats or not. While leave the ATS enabling policy unchanged. This means
>> we need to probe the sats capability of iommu hw before creating the knob
>> in sysfs.
> If we add some ATS control knob then maybe it should be able to
> disable/enable normal ATS as well?
> 
>   never
>   always
>   paging-only
>   secure-always
>   secure-paging-only
> 
> ?

My two cents' worth.

We could separate ATS security and enablement. ATS security is a
security policy that should be opt-in by the user through something like
sysfs nodes. We can follow what we have done for the default domain
type: identity domain (non-secure) and paging domain (secure with some
extra performance overhead). Users can specify the static default domain
type and tweak it in a per-iommu_group manner through sysfs nodes.

For ATS security, we can probably define two levels:

- Relaxed ATS: ATS could be enabled as long as the IOMMU supports the
   ATS service and the device supports ATC. This matches what most IOMMU
   drivers currently do.

- Secure ATS: ATS could only be enabled if the platform provides
   enumerable capabilities that can disallow arbitrary translated DMA
   requests. We need to let the user know that once ATS security is set
   to this level, some features like host SVA won't be supported
   currently.

For ATS enablement, I believe we have already reached some agreement
that ATS enablement is in an on-demand manner. ATS is enabled when the
first domain that requires ATS is attached and disabled when the last
domain is detached. That matches what we are doing for PRI.

When a domain attachment triggers ATS to be on, there might be some
cases:

- ATS does not impact functionality. For example, ATS could be enabled
   for the DMA domain for better performance. In this case, it's a
   successful case if the device supports ATS but the platform can't
   provide the secure ATS that is demanded by the user's ATS security
   level. ATS will not be enabled but attach returns success.

- ATS impacts functionality. For example, the domain requires PRI. In
   this case, it's a failure case when the device does not support ATS or
   the ATS security is insufficient.

- ATS compatibility should also be checked in domain attach path. If ATS
   policy between attaching domain and the device does not match, an
   -EINVAL should be returned to inform the caller that "domain is not
   compatible, suggest to allocate a dedicated domain for this device".

Thanks,
baolu
