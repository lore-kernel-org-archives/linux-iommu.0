Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D887DCA4E
	for <iommu@lists.linux.dev>; Thu,  1 May 2025 04:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746073315; cv=none; b=hJKvltd/HAaffvUbqWqAeG38xv+O+YgBKvtKdpaVCQlbPk7XWZY5GFxJbZ0TNzLvIffia67t+yEJuf8oER4UkBUhg0L4pn6kzMAAM24HAkfk3JkQlXnH5xIIU/lBuTim8SI3p0sC9iRBjsmwRAuqf5gi8fD8mmkn4IPFvxAfqCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746073315; c=relaxed/simple;
	bh=aqeI3rlQCdQaQe8pGSUPe1rCmviIqCU+MOwdAWaw+ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nr88RhPxMTHt54EIIKWwgmx0Odf19qDRDF0/+XxTntl9WKaucc/j4yEOipNnlfMbRL8IC5nvfGjWGduiH0bYAHH3otghic9aRCS1PGUaDk/JQOVRl1vkzkH8cW0UJBhpCuOdzkWv4GaXCMlB8dTupg9/Ow7BoLKNr8KWUE6c3b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NITZIS5h; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NITZIS5h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746073313; x=1777609313;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aqeI3rlQCdQaQe8pGSUPe1rCmviIqCU+MOwdAWaw+ig=;
  b=NITZIS5h67OSO0QizJuzVtRUVwNpVsIOtmjjVhokcmIixIj6qgrFDJIb
   thsUtLIVxF2a04TO8Wb7K2zDRMrfsw5mSAzYrosAOT4U3uoMNdeHFipHR
   3vQg23ctTg2BU6FGd3oFM/i9tbKcxfe+mjOFzORYLuWWa80tw22FFDl4M
   B4LTk0YSQCPl1Mg7sjG1XvD2F9U8mf+xMrWAzyk3PGhQTJypwa5O4NwVo
   7dw4O2tUHuZJvFlVuq1tn7/U/Gm5/sTz80INPQo3BUGCM5L7j6mRdA5nb
   yXmLl+Fi1/tXsK3RfRtveTIE5mBTh0asE+s1AQKCxkX8e/oBuyL1OVyNl
   A==;
X-CSE-ConnectionGUID: lZNl8GQCTO+jiN+lZH3oyA==
X-CSE-MsgGUID: izcumrsxQMuLBo4TfISKeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="47889022"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="47889022"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 21:21:52 -0700
X-CSE-ConnectionGUID: +5qhL7bkR4W24F9yok7XtQ==
X-CSE-MsgGUID: vB84Ls+sR9q10h+TuvjOlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="134240048"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 21:21:48 -0700
Message-ID: <e232d563-a4db-4c33-8c3e-f47436dfceb8@linux.intel.com>
Date: Thu, 1 May 2025 12:17:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 rc] iommu: Skip PASID validation for devices without
 PASID capability
To: Tushar Dave <tdave@nvidia.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, kevin.tian@intel.com, jgg@nvidia.com,
 yi.l.liu@intel.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org
References: <20250430025426.976139-1-tdave@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250430025426.976139-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/25 10:54, Tushar Dave wrote:
> Generally PASID support requires ACS settings that usually create
> single device groups, but there are some niche cases where we can get
> multi-device groups and still have working PASID support. The primary
> issue is that PCI switches are not required to treat PASID tagged TLPs
> specially so appropriate ACS settings are required to route all TLPs to
> the host bridge if PASID is going to work properly.
> 
> pci_enable_pasid() does check that each device that will use PASID has
> the proper ACS settings to achieve this routing.
> 
> However, no-PASID devices can be combined with PASID capable devices
> within the same topology using non-uniform ACS settings. In this case
> the no-PASID devices may not have strict route to host ACS flags and
> end up being grouped with the PASID devices.
> 
> This configuration fails to allow use of the PASID within the iommu
> core code which wrongly checks if the no-PASID device supports PASID.
> 
> Fix this by ignoring no-PASID devices during the PASID validation. They
> will never issue a PASID TLP anyhow so they can be ignored.
> 
> Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
> Cc:stable@vger.kernel.org
> Signed-off-by: Tushar Dave<tdave@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
