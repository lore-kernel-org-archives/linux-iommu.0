Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D7D63AA
	for <iommu@lists.linux.dev>; Sat, 14 Oct 2023 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bM7hT6SB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697270029; x=1728806029;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8FUCVkEXo2dDBEoDY3Ok5aqS4qxJmKgJGIKKpwEolwk=;
  b=bM7hT6SBW89Lc+iJPxYvxakKSry8XKEJPnp77ubNuCjtTkb6GLxG0zDl
   RVXrzX+voBXsBjpI/vvALQWxt1TU31UKZ3DwHjPg7hSOjbiuSs3iDRBn5
   e6+XEUAu+4P0gGZ9Fev9PmGBSIMedL873Yw0iNgwmz/kjBjG4k0OLVrLv
   B+fkFwvThZeCuBlfkj76JjevvjMZKMdrhk/1XQ7QfjUrh2obg4er3ItRl
   YLsDFEAzYeKPDO6BPnrgYdsjT/aDBSq6UZNgJ6NtySQtxqSSegVqoSBl4
   geEvUvUWpnKjNLvjG6ItsMPrmgMOii7kvaJGyHWnwflUHRltv2SvLyah6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="364674187"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="364674187"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 00:53:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="754977578"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="754977578"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.238.2.200]) ([10.238.2.200])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 00:53:44 -0700
Message-ID: <78e43ae6-99bf-c326-b0a2-930ced04911f@linux.intel.com>
Date: Sat, 14 Oct 2023 15:53:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Yi Y Sun <yi.y.sun@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v3 00/19] IOMMUFD Dirty Tracking
To: Joao Martins <joao.m.martins@oracle.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>
References: <20230923012511.10379-1-joao.m.martins@oracle.com>
 <20231013162949.GG3952@nvidia.com>
 <9df305a4-1176-4187-9dae-37dc954289f1@oracle.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9df305a4-1176-4187-9dae-37dc954289f1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/10/14 2:11, Joao Martins wrote:
>> If either AMD or Intel ack the driver part next week I would take it
>> this cycle. Otherwise at -rc1.
>>
> FWIW, I feel more confident on the AMD parts as they have been exercised on real
> hardware.
> 
> Suravee, Vasant, if you could take a look at the AMD driver patches -- you
> looked at a past revision (RFCv1) and provided comments but while I took the
> comments I didn't get Suravee's ACK as things were in flux on the UAPI side. But
> it looks that v4 won't change much of the drivers
> 

I will also take a look at the Intel driver part.

Best regards,
baolu
