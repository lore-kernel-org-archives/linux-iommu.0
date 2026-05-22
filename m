Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B571CD1E4
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779429759; cv=none; b=km+0JQOxdM2MPtHQSF4/kZEEkjcmmvljtgUmtYpqMnE95+LVaI0OHrW4LrDnhFu5CmHP8E8e/dNGChjSV1PZ89ytWLBxBOt6bDEvtZVCeg7kcJA80FPcbCdbctp9am5Lcpr10QcRyOSpaTYzk4cou6u9C/GrSYHo8ttnyxtAI78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779429759; c=relaxed/simple;
	bh=eb36L2P3NvmDfTQzCsl+4iB764ZICmy72QmzXxmhS1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnyqDfh5JcPMAcdl2sSlS/7gvqxMgZ7d+HQN5cBVvX+7u8aGpdYVEjwbCEJsQn2oEOI+K0adHlRDfq+rotljxF4NvvwLML5QIV6CLd6Pnsv9sJvZnF8Dc21znq2rNqxY1n26vGEWvtx8Yaf4Ke5/aDOJDKxXTdgvbWEwQYFw3PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfA056Er; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfA056Er"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779429757; x=1810965757;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eb36L2P3NvmDfTQzCsl+4iB764ZICmy72QmzXxmhS1Y=;
  b=CfA056ErFs49fX59sFfQGSYJDoYHMdDxoNQJQojeIt0b7rzTVC7h4sef
   h4QmD8McOURrN5On0tO9qxzY8XHrm6qqbsCz/0mP2FNT4oHR2wijVMRxP
   +ZO92h8BxWCxoF8sIh1//9S9lOGwjjhJB5ki0sWerALTbubzh/n+pxoUG
   lC9fOyHgV8LzNTVfxngG2/nnMNs/S35cGg/9dfPZq7W6hGZQnZeo+hy+t
   +6UpJpuhGw/McfL5tY3t/2bJMY40MAO88kGQNedPG1qU/+9gdy6q8/9wn
   iymLWKXG3ECLYAL1lAw8z2K7lkdxrfweGoUOkX3p+ZOxnw6b4c92IU5Ca
   g==;
X-CSE-ConnectionGUID: iSmtKHNbR9a1ssVk9QNTRQ==
X-CSE-MsgGUID: EiomOxjzT1CqNkA/Q/wkQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="83973375"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="83973375"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 23:02:37 -0700
X-CSE-ConnectionGUID: g+Yj186WTEa9Moi1qkaE/g==
X-CSE-MsgGUID: xoSQbUtsTmC58tA0TewFgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="237775298"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 23:02:33 -0700
Message-ID: <a717290f-79df-4343-8a48-802044802cd3@linux.intel.com>
Date: Fri, 22 May 2026 14:01:59 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] iommufd: Allow binding to a noiommu device
To: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 Joerg Roedel <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
 David Matlack <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
 pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
 <20260521221155.1375144-4-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260521221155.1375144-4-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/26 06:11, Jacob Pan wrote:
> From: Jason Gunthorpe<jgg@nvidia.com>
> 
> Allow iommufd to bind devices without an IOMMU (noiommu mode) by creating
> a dummy IOMMU group for such devices and skipping hwpt operations.
> 
> This enables noiommu devices to operate through the same iommufd API as IOMMU-
> capable devices.
> 
> Reviewed-by: Yi Liu<yi.l.liu@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Jacob Pan<jacob.pan@linux.microsoft.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
