Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4215199FBA
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 02:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523486; cv=none; b=P5fE824TWaPmpJxGNjmwJZrvtGjE4bu2GIYoyjt6wwzjkWaU3CPg5nUE6n4ZMmS+u++HVwapvH9xk0oasSbUWe4qp6/YwSAwlyHc0ZAphBu0ZYjvXc75pDvSaW/r4pOGCwqbTBSoMejxQK/riez+E1E86fKPiSp3hcvx8yXnmdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523486; c=relaxed/simple;
	bh=yiT0IByiw6hfNbsZ2ycmFtsULRBmPbyQPGomX3XADbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwT5c0EyWUWF82ycs/b1lOq+hKLEcEPbzbwxDrb5H9aauDFKIntHFe6eWDTsxKy+61LSM7PoEYTBiJcnuy4DVfzU/CZ4+fvEzbI5hku/Dg5uiOvvfKiAHv/EoRvGzvxe5lRMQn8pt3dPv4dEdBDmNegISisbfvvOy8nXEefriY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsnWUcHY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsnWUcHY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742523482; x=1774059482;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yiT0IByiw6hfNbsZ2ycmFtsULRBmPbyQPGomX3XADbA=;
  b=GsnWUcHYMys2oqgyk406KrKgXnNRn2EfnO97JmtojPTTEmMCkizQPJcf
   uDcaHgnl7eKCz/x7NPizbCNXBm1YYjhJ5dp2BpbFdxqMEDLjtmoDAvY3H
   np0ZNe8o6C+cbdxeHGT8THDSQNdq5R/nj9ioE2ScVggjoC28CZnoDrH+w
   MRAawalZP6G6EjEcRpuWmS2XAMAGYT/z0nI+oYfcCMFrclgZjzVLQq3O4
   7wO73RPQ8xkm78kagDnUH9pX5T4iMf9guVDnOJ4QbkCVYS+dkIQgaA8Mg
   wyjQAodh1UkYMP9fgEMkpOxu/2SGZKEtF/Ei10AkX5zmG/k13eBEvCu+u
   A==;
X-CSE-ConnectionGUID: hUkXwYn5SN23xYmEbyiuhg==
X-CSE-MsgGUID: FrMAlL0LQGCsMWZOIRyJPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66247434"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="66247434"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:18:01 -0700
X-CSE-ConnectionGUID: l0xm/TmsR1icDX7kc4ic6A==
X-CSE-MsgGUID: HN5ZugeWT5GnzJJUsrOWlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="127425864"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:17:59 -0700
Message-ID: <0527bf74-f272-47e1-8cf7-1e66167fb560@linux.intel.com>
Date: Fri, 21 Mar 2025 10:14:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iommu: make inclusion of iommufd directory
 conditional
To: Rolf Eike Beer <eb@emlix.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <12652899.O9o76ZdvQC@devpool47.emlix.com>
 <2243601.irdbgypaU6@devpool47.emlix.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2243601.irdbgypaU6@devpool47.emlix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 17:22, Rolf Eike Beer wrote:
> Nothing in there is active if CONFIG_IOMMUFD is not enabled, so the whole
> directory can depend on that switch as well.
> 
> Fixes: 2ff4bed7fee7 ("iommufd: File descriptor, context, kconfig and makefiles")
> Signed-off-by: Rolf Eike Beer<eb@emlix.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
