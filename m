Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B7EC5
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 03:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750736000; cv=none; b=sO79laY8FFx6gQR55ufxZlTKG8S+gzuP5w5IWgsL/sRdQ7n454X52JqcUQiYDgrk4h+WzrGJHwRD3aORfvZQ1DvkCgMVD/yUjFr4vcx4ltZCnfL7Duh/XorBpXBYA8FOLI5uyfcQ2LtlpOEEf9q6r9YJdguRdm3GQUL1VYjBzoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750736000; c=relaxed/simple;
	bh=bWCynTixsfNxe6ZbUQ0oYDEnhxCF3NKs2vb8B2q356Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxf1eYtkXnAITtaWFu/O4eoakWu4zLBdOzR9aojF2lriynhbb1K3su0qYp2gEXi8eStddJyGTec9XeSg3aWqyhv+vEUyrYkkJcJCwjph8t/2ghDF3cpr06e4jBCSmG1tYTuS3bMvbGSmrBS4Es55rPb+ZkvDiPPVkVbjaaSyyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=St+N30R3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="St+N30R3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750735999; x=1782271999;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bWCynTixsfNxe6ZbUQ0oYDEnhxCF3NKs2vb8B2q356Y=;
  b=St+N30R3S2UBU6y3u7W3Du0ZzBQLWIrJ+YXaaZWJCIm3edpICEQqHDlB
   UQ4Gq1vf/IiEYHjPicsfDMiX8qZZZmA8rDuZej9ZTTxnq5J0irOqMr5/U
   YBUGNAD6Haj0StrBRl0VS78iQ3UDne5J1fPlEmTcThlZY2NQa2NtLX1jB
   GNy8aGCG/10F6AXqtHuqj+TjNSTDwoYZ4Na0tgOM0e//IYNjchAN8wZDz
   LuYgAhVmkij6c+dOQ1PCPQJi5zaNM4MEp1JdmUvunlGpNxSmX98b23c/M
   sNDdJ48pUdaBruUaLqbOwYZA18XOjjAmo9Y2f8L654vMiqX3gdfqZBhld
   Q==;
X-CSE-ConnectionGUID: pB8h31C4T+Szzh02599Dow==
X-CSE-MsgGUID: LhT3pXo6RY+VXywlGxHsXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="75499090"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="75499090"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 20:33:18 -0700
X-CSE-ConnectionGUID: LpGEWY8QQj+CDk+58rzDYw==
X-CSE-MsgGUID: oGGtRhL7TJaTH+mBoMDRPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="155801287"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 20:33:15 -0700
Message-ID: <a2fddab4-bc85-46f6-9008-57a26e099698@linux.intel.com>
Date: Tue, 24 Jun 2025 11:32:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
To: Xu Yilun <yilun.xu@linux.intel.com>, jgg@nvidia.com, jgg@ziepe.ca,
 kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
 robin.murphy@arm.com, shuah@kernel.org, nicolinc@nvidia.com, aik@amd.com,
 dan.j.williams@intel.com, yilun.xu@intel.com
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250623094946.1714996-4-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/25 17:49, Xu Yilun wrote:
> Destroy iommufd_vdevice(vdev) on iommufd_idevice(idev) destroy so that
> vdev can't outlive idev.
> 
> iommufd_device(idev) represents the physical device bound to iommufd,
> while the iommufd_vdevice(vdev) represents the virtual instance of the
> physical device in the VM. The lifecycle of the vdev should not be
> longer than idev. This doesn't cause real problem on existing use cases
> cause vdev doesn't impact the physical device, only provides
> virtualization information. But to extend vdev for Confidential
> Computing(CC), there are needs to do secure configuration for the vdev,
> e.g. TSM Bind/Unbind. These configurations should be rolled back on idev
> destroy, or the external driver(VFIO) functionality may be impact.
> 
> Building the association between idev & vdev requires the two objects
> pointing each other, but not referencing each other.

Does this mean each idevice can have at most a single vdevice? Is it
possible that different PASIDs of a physical device are assigned to
userspace for different purposes, such that there is a need for multiple
vdevices per idevice?

Thanks,
baolu
