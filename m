Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2E33D8
	for <iommu@lists.linux.dev>; Mon,  9 Dec 2024 01:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733706615; cv=none; b=XbQhEi5uqd9UklCF2s5CZCTJA7+xYH/J1WAz2la2TiwwAYN/D4AFP1tfqBvv3HXPhI4Mokp0ouJ9QswbpW9dNEFoUPJ4fnJAQ26ROxFsjSyCGevEdW0QXBaYele2f0RB+ZUA6dB9zyCNp4r2jlKGNKZQ5GYku98e8V3UpI/fF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733706615; c=relaxed/simple;
	bh=c5dtpRkGMycYV6CJxo7iViMKxId8FLkzvPCT+C10a5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqnzALjUbDErxY8fcOGLIt5/X7K6f4Wlk02eMk4Eg9h7/XQeYoW7ort04UbUnfYMH0A/xJEX96uUjMWD4CoG/slZdtindoh4XfmJ72NJMyiDtJ01TYQR+o+GJ0WMSipeRZSLcgxyofJMu1ol/ZIEGwpYya3mc3q0AqMwBOI0T+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYUP7OS3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYUP7OS3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733706615; x=1765242615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c5dtpRkGMycYV6CJxo7iViMKxId8FLkzvPCT+C10a5c=;
  b=EYUP7OS3xB8TQOZNWg8XRjrOu0qOpoL1DqkChxpLgQZ7AkYwvPJUip8Y
   EvTiNlSfQ1ZlT14tMzUJ5Ltc6hwnRG9N7jhvJ/4bph/plAiY8onMbQS6z
   wW+Q/0oaoqE2DsiRAfkZCPbcjDwqLrz/gQWpAx0nFlBs+nCILsmX/1HFs
   rQn1DTXgylUS/B6psl+CGkOdXHISpHwvNQHprHRB9bH5oFtQp+/10dtPA
   ntUgptpob0F+/LU2dFk7HmnDQ8y8zU/vfXeNMHChWz890lM9e/lweWF2Z
   zb60W6orSx5b+Q+8V7FMJXMRYgFKgDhg9PC6irmhv7XawzTuKCpKh3XVj
   w==;
X-CSE-ConnectionGUID: EcXw0peKSRexQnKHbymJXg==
X-CSE-MsgGUID: m2s1AAhJSCubQKTjn4zYgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34049802"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34049802"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 17:10:14 -0800
X-CSE-ConnectionGUID: 6fCcIwV7SFKXexuRfxKWLA==
X-CSE-MsgGUID: wMdtRVqmQsmAkk7JBP+arQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="99869669"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 17:10:11 -0800
Message-ID: <b1e8ad5e-e149-4502-8242-b971ac1d4eff@linux.intel.com>
Date: Mon, 9 Dec 2024 09:08:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: Deal with IOMMU_HWPT_FAULT_ID_VALID in iommufd
 core
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: eric.auger@redhat.com, nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
 iommu@lists.linux.dev, vasant.hegde@amd.com, will@kernel.org
References: <20241207120108.5640-1-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241207120108.5640-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/7/24 20:01, Yi Liu wrote:
> IOMMU_HWPT_FAULT_ID_VALID is used to mark if the fault_id field of
> iommu_hwp_alloc is valid or not. As the fault_id field is handled in
> the iommufd core, so it makes sense to sanitize the
> IOMMU_HWPT_FAULT_ID_VALID flag in the iommufd core, and mask it out
> before passing the user flags to the iommu drivers.

Is it a valid use case for an iommu driver to intercept the
IOMMU_HWPT_FAULT_ID_VALID flag as an indication that user space requests
an iopf-capable domain?

If the device and its associated iommu do not support PRI, the domain
allocation should be aborted and a failure returned?

Thanks,
baolu
