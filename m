Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D02877F6
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752140009; cv=none; b=RZKW2YsIDtd29PzGeeVcZZ+8OIjajsG3WdNnwxNOmf4ox0yExgqGdF4XX3GCkrThhxB5aqQ3uZqbKNs9sN+UrneI/4hQM9gaO8Q7q1e9Hz+D8AaLrrPNI3HCmr3sKcIBHGM5ifX6c2MOn6SghADpUA8PcLhnlDEa83PlrTmAzRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752140009; c=relaxed/simple;
	bh=qN2NgiaMtYTDQdQ63YwlRaKz+BMmN3huiEzb/c3as38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5sAjNwmExE0H4Lxnl2UhJNgXSrP9tRIRK0JcS1r8WLO2MdHVMpPMv/Jc8uuc4FHiW6jZ4vnyzSpHRBWw9DH5I7yR6cOabKNCADcvYum7kM3Gwe2h8ZyWhvs/muUoPN/PRziAtaOLj6pS2Cn5YxlGCNzEet8QEUEWokMxHJedqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAsJpFCh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAsJpFCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752140008; x=1783676008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qN2NgiaMtYTDQdQ63YwlRaKz+BMmN3huiEzb/c3as38=;
  b=DAsJpFChAXF3df4i4+UMnGU9+4gFvmTueyxOAbCmRh/wDA0o6+0OiEw1
   RAAy380GFdlr7GUGRlkbSTd8WXU6rYA/4qtodOlhjmzHys/EU4wPxBuLl
   4Ki9JRY1YD2oKkmTl99oXvcFoA7sC1sdxEZ97cpzb1DmOKE6bPYtV7n06
   yxCPpgE90GuUSrOlo7CW51k7ipYJBljM71fJ8hwUBPKhp2NvEerU9JElq
   1p3uiYjLZo9er4i/5SkOIZvxyekJHTBb4JmD991y2jyX8C70zlbCtfr7e
   DjQDigNrQclGzGURkONbkWZeWT8+rIkeA8ZfHfG+MUqt10wI9R1IXGDaf
   Q==;
X-CSE-ConnectionGUID: yclOCRuvRlCk6Ulqm6pG/g==
X-CSE-MsgGUID: gCmLLGabT5639ti1M54o7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54267881"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54267881"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:33:27 -0700
X-CSE-ConnectionGUID: Zgv6SSV1TjmmtcQcGxHc3A==
X-CSE-MsgGUID: kHQgVXvTQcmfaQuZE134ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="193226660"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 10 Jul 2025 02:33:23 -0700
Date: Thu, 10 Jul 2025 17:25:03 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "jgg@nvidia.com" <jgg@nvidia.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>
Subject: Re: [PATCH v4 7/7] iommufd/selftest: Add coverage for vdevice
 tombstone
Message-ID: <aG+G76s3gw5/U8iw@yilunxu-OptiPlex-7050>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-8-yilun.xu@linux.intel.com>
 <BN9PR11MB52764B86489423F69AF617B88C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764B86489423F69AF617B88C48A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Jul 10, 2025 at 08:10:34AM +0000, Tian, Kevin wrote:
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Wednesday, July 9, 2025 12:03 PM
> > 
> > This tests the flow to tombstone vdevice when idevice is to be unbound
> > before vdevice destruction. The expected result is:
> > 
> >  - idevice unbinding tombstones vdevice ID, the ID can't be repurposed
> >    anymore.
> >  - Even ioctl(IOMMU_DESTROY) can't free the tombstoned ID.
> >  - iommufd_fops_release() can still free everything.
> 
> but the test only checks 2) instead of all?

It tests 2) & 3), 3) will be executed on FIXTURE_TEARDOWN(iommufd_viommu)

For 1) "the ID can't be repurposed anymore", I don't have a good idea how to
verify it. Allocate 2^32 objects and verify no tombstoned ID is
reused? That's too crazy...   Maybe just mark it untested in the commit
message?

Thanks,
Yilun
