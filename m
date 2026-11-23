Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430137;
	b=ugDDvSJdcmW/FnmiVkfCqzedYDXIvYREi3OPdFy7EssyRY+vERnhjy6z5CSGyiyCliXQ
	 ES+ZxBpCfdDuZ2Bj0/WPJOqjkKJCrQomp0cFIEdX7a/Mor0EiYE0VIDJI3wVcm2z1V6Zl
	 8ZZlqKd1hmM27u1nwD7Qi77++uy0w5IRqGYWUYZEkMSu/yML8xRCeSwh2kmmxUIncrnKd
	 UlvZ+YDzCo++v1uvOSFnw0mHoRAG9OnV0wUboUMinspeMDivYq0suMMyiQz8mtsMqwJJn
	 +xCpsVs/b2hcMn13XVX07NsWsZofPFEnatTUWr73OU7fGLNn5nl57ELSDXSWrGBBtUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430137;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ZO4wNAj29ID7m/8F00or4c6Hhyo17pCJTJybg9NHhHU=;
	b=ROoUWQCfJPTmnLTmgbtQ0aPnu1t4f370SZxpBzdLwUjzaBnWNkwT4sHLa4M3FSVy8Nys
	 BJATBo6t79eM6K2+iv8snoag8id38QPfGgx4Em+pmNJsStn87ox/TwetnuaW59LJ0/yU+
	 croV+RUyQymG0MnkLSGlYvHZlUGtajKLMn3GW4WnunZPYJHRkYmDfDKe8bSzhsEnUc4fH
	 HEn+c0c7yjuWg5KGmDouCwMwGioO45D8s1rEI0/XnjexW90+t47fhBtnqXZAWmyMuixgW
	 YzeycJrKbopMN8sT2aFxq9EMFo7oRa4DlNJTvKYXvBmgVYNtmVlHS3QIQXNgzxEYClg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iD4XBVCy;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F69606A31E;
	Mon, 23 Nov 2026 10:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90F69606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iD4XBVCy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795430137; x=1826966137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WtkR+urVVb+auFp9r6p/Vhvy/v3Cd5NomGcGQA0332k=;
  b=iD4XBVCy1qXqz5cmK4Dkr/Nj0m5xDBRSHjmP6m+Q7/PDErE+nAMaklEA
   R71s9oDvnRUv9j826qwrqhspWHQlBfV9F5owusLK+we2cqd8clDW/4rSB
   +ZbqB3dksrMACFWYfxFWAlH7/7nCwnQjVS0SHyh+fjYDVTyWmaYN5zBvv
   qpPmW7uJapDh/rQeyfr8bVI064Dp/ba4FpYimF0q9v7FALFTHZ4PHtuZv
   HVBfwPtpKChwxfDFL3P5fKmWUoMOw+yvJAJ038aR8HZLDHK7sLuJ9FnJa
   nLZkps+N1SRlf43QBXHIJAgWWOJ50VvYUxVZ+77dCkZxJtdRcGIMErSYF
   Q==;
X-CSE-ConnectionGUID: KuU+2D+4QRKcsjYHk1Co2g==
X-CSE-MsgGUID: 1YMQxiUIRu+hvx8GhczQqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4080045"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4080045"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 02:35:37 -0800
X-CSE-ConnectionGUID: RF2iP6doQIOftGwuxqeJqg==
X-CSE-MsgGUID: i0Y78dacQxumlSb9BW/6TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11583821"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa006.fm.intel.com with ESMTP; 23 Nov 2026 02:35:33 -0800
Date: Mon, 23 Nov 2026 18:25:54 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, x86@kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] x86/virt/tdx: Export Dynamic PAMT helpers to
 tdx-host
Message-ID: <awQUsufmV3NipqGX@yilunxu-OptiPlex-7050>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-4-baolu.lu@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112043054.2664857-4-baolu.lu@linux.intel.com>

On Thu, Nov 12, 2026 at 12:30:48PM +0800, Lu Baolu wrote:
> With Dynamic PAMT, any page handed to the TDX module needs PAMT backing
> first, via tdx_pamt_get(), and must drop it with tdx_pamt_put() once the
> TDX module gives the page back. Besides KVM, the tdx-host driver now
> hands pages to the TDX module: the IOMMU_MT pages for TDH.IOMMU.SETUP.
> 
> Export the two helpers to tdx-host as well. A symbol can only be
> exported once, so replace EXPORT_SYMBOL_FOR_KVM() with an explicit list.
> Only kvm-intel calls these helpers in KVM.

We are seeking for some simplified intial implementation without DPAMT
for TDX huge page feature. So we could also drop DPAMT support for TDX
Trusted I/O currently.

As an temporary solution, we can disable TDX Trusted I/O if DPAMT is on.

for example:

static inline bool tdx_supports_trusted_io(const struct tdx_sys_info *sysinfo)
{
	if (tdx_supports_dynamic_pamt(sysinfo))
		return false;

	...
}
