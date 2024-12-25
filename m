Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D761B256E
	for <iommu@lists.linux.dev>; Wed, 25 Dec 2024 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735088647; cv=none; b=h5QjFUY/G5eBkUaypDdnl+EAmYSgunaMVr0YWtkZAf8fbhdl4/+z+qVBlQBXS5OQZya5d6FbetpoK/uhv46mb45Yk5uYvMyDo8BH+LUrmk+Kz0IBzUy0TduCpJi6r89IEuG3spVZKXX81Yu69Zx2dRZRcgBzrlUNyQTRpIzqO5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735088647; c=relaxed/simple;
	bh=GItSPt7n+yRf2cUDF2keeK2AgvBiQkIFLwUTiuycsLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEraqE7Rm00TDczssuBiyU7FI5LuOyNRk6B/lKzf5DEiZ7cAulS7QDgvYGPYh4fLdFotbvR3vhs37HKEJ1LDXsQeT0ZjVrGDrBiCMrZEJa2AQF8feDOvj5yfRvB0HtfooRrZoBE7v6V3pU9sKwqJPjSuQmCGbeHSLPfBHO6yIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dIMEnn2K; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIMEnn2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735088646; x=1766624646;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GItSPt7n+yRf2cUDF2keeK2AgvBiQkIFLwUTiuycsLE=;
  b=dIMEnn2K14sS5WQYr5ImqXLya0QGwvlrYDDaddXXCoP9A3MMOH6d6EyA
   /CbJIYaPqyY29rC7tWYSqZqbCpZWlz0hBa7sL2QEuez+Aln3+RYhMqBev
   Ip27Ea3owLMC6Nxam6tOCnSym2c9wW3eqxDHrBXoXqTOvgzV244zpKwPR
   oyhn/tU3OLstMNdk5EorahDLRR53A0Uq5ck/KpyzLrW9rz9UdaAkKDquZ
   3ETAs4Jk/cHJQCAMwUVBYIGUi1C7+NjB0ivZNWoPOzMnrFkjda/V5FQ8Q
   XHFXjuOVnYFW4S8hjV+GjXB0b6CYFfWunhiu1dvTcqjkitsUoxSnVL9VY
   A==;
X-CSE-ConnectionGUID: i/mm1NIATwyutBWhJeTO4Q==
X-CSE-MsgGUID: Q0Mdk4ouRfaT3DtAfuxFbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35455506"
X-IronPort-AV: E=Sophos;i="6.12,261,1728975600"; 
   d="scan'208";a="35455506"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 17:04:05 -0800
X-CSE-ConnectionGUID: +irVL5lLSz2mAk2eaYpGfw==
X-CSE-MsgGUID: OEOORg9PSJC42SwdskWALw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,261,1728975600"; 
   d="scan'208";a="99819544"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 17:04:03 -0800
Message-ID: <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
Date: Wed, 25 Dec 2024 09:02:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: eric.auger@redhat.com, nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
 iommu@lists.linux.dev, vasant.hegde@amd.com, will@kernel.org
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/24 19:35, Yi Liu wrote:
>> Another related consideration is the support for page faults in nested
>> domains once PASID is available in user space. Would it be reasonable to
>> support page faults for nested domains?
> 
> yeah, it's good to discuss it.
> 
>> If so, perhaps it's time to open intel_iommu_domain_alloc_nested() to
>> support IOMMU_HWPT_FAULT_ID_VALID when PRI is enabled on the device?
> 
> IMHO, the PRQ support for nested domains requires some more facility. PRQ
> can happen at either stage-1 or stage-2, iommu driver may need to tell
> it and forward to the correct domain (nested domain or parent domain). Or
> the stage-2 is always pinned just as the VFIO/iommufd does. Hence, any PRQ
> happens under nested translation should be due to stage-1.

The parent domain is currently always pinned and does not yet support
page faults. Therefore, when a page fault occurs within a nested domain,
it apparently should be routed to user space...

If we decide to support page faults on the stage-2 domain in the future,
we will need to figure out the correct destination of each page fault
and route it accordingly, either to the parent domain or the user space
nested domain. Hardware assistance would be beneficial, otherwise the
software may need to traverse the parent domain, which is not
performance friendly.

So, I don't see any reason why the iommu driver shouldn't be able to
support iopf-capable nested domains. Have I missed anything?

--
baolu
