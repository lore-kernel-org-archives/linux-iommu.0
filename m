Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793512478;
	b=DeSHi18nbwp2vfr8kpu714geX7M3Cv9OugzPGZy74Htr5D3bDjQmMW5+ixHSIk/abjS0
	 NrFEsKRg3+BiILgh8eDd1rvvedmMV59rshAi+bW5/p7Net1sXow0iqzIpkqTRm8vEWWWv
	 9vs9lFOTq+NgQIK+jpmY6qWlel0EYBqmHELL75wugP5M5FCg7pKLwePr8lOkMNcY5FBve
	 HFtA1PMK7AoR+CUu9hU+Zh3OagKT0CYkbx0socEQXwFztxx2WEE72DtYfFJibvyKvTHQl
	 hGCuS6MbIqc7l0MQ85D4E8MxFWOfzq/X+HcYvZ/GdVia3bDm/ojq6eJoKXmki+Tk5JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793512478;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=uOw+IAzFuwDzBqmWRivGMmeoVFcilaILQpBOKhQmXc8=;
	b=okjUCcnfZBTIOzYtfCdtSUNR7Y/3E0N9iUfRS1lpWQ0fa8r6l5KWav5qfuscmvOz6uVU
	 SFU9iggigdJJ1QLGgv+7c1btMmzVBxIkRW33jwgLf+W+PeNPK7kIX5iMX/FJOUCiR6w6M
	 Ube1nTDvvRloXzIU/LOOBGTtdYuoccP5CDDgETE9aFo05xmoHNMTJ+GtfnG/+ReqYunXM
	 V18+/UtFmIH1h7i0ZuMWKi0jbAxjoh7s8D99TEdn9vvK33BwN/jl0cAjvV8ElFWNk2C6e
	 aSXSXkCIDSSBAO6ALuBt1mzAKMFQ3M8fpat4d+gFXaEdPJe+7jTPwG9ZraHUvhpuklA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eILD1hjO;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98D606A324
	for <iommu@lists.linux.dev>; Sun,  1 Nov 2026 05:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D98D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eILD1hjO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793512478; x=1825048478;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S3k55RrTvvacuaktzsbaHcUXmIByhPmJUPt2IvuT6DY=;
  b=eILD1hjO4HI9tSSqZVc0Th79RSLxXZlfluuhXa/S2rcEdOmINDb/qBDS
   pjih2Q5fouJP7gjA/4vTt4pCGSktYQu5AR3eqmm60uKaQPt8afy+5hJQy
   RudOEVNo/qNQnKtOWpOk36zrs4torrCo/qusXFgLnLmulz1lHKhxIoTYg
   KGQJnGm5tfhsgQNyCVP4w7VXlDmPXFzeaG7FuIfo+XQtJtHHOujl1mLb/
   S9zLbASGhqllZOD1sIARmDy7FEzK1KsS5oO4aWH90QYHCbw+IpHD/hk/h
   3/0vIY+s/pMsCRFX1L0zMpMgJnCdS3rIM8iVbsJB9r96RN1yA29/xkbXo
   A==;
X-CSE-ConnectionGUID: Qup6yFYzRCC5/Z8WVjS8Fg==
X-CSE-MsgGUID: A5XkHR38SialKEAzsElKyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2131732"
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="2131732"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 22:54:37 -0700
X-CSE-ConnectionGUID: crfp2vdyQ8Ot37QcZFLwoQ==
X-CSE-MsgGUID: vYFzzR8DSs+tjGW/jpoDTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="5758405"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 22:54:34 -0700
Message-ID: <a0235100-acfb-4b0e-8b4e-c7be2c41435a@linux.intel.com>
Date: Sun, 1 Nov 2026 13:54:32 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] iommu: Unpublish the old attach handle before the
 PASID replace callback
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <af5be72574fff8c81c2c199886fc67b688ccc3ba.1790718296.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <af5be72574fff8c81c2c199886fc67b688ccc3ba.1790718296.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/2026 5:51 AM, Nicolin Chen wrote:
> Similar to iommu_replace_group_handle(), iommu_replace_device_pasid() has
> the same inert reserve as the group path and the UAF window:
> 
>    core, holding group->mutex          fault path, no group->mutex
>    ==========================          ===========================
> 
>    xa_cmpxchg()                    ,-- old handle stays published
>      no-op, the slot is occupied   |
>    __iommu_set_group_pasid()       |
>      driver attach/detach ops      |
>          iopf_queue_flush_dev()    |
>                                    |   iommu_attach_handle_get()
>                                    |     reads old_handle
>    xa_store(new entry)             `-- window closes
>    mutex_unlock()
>    kfree(old_handle)  [caller]
>                                    UAF: old_handle->domain->iopf_handler()
> 
> Store XA_ZERO_ENTRY outright, just as the group path now does.
> 
> Fixes: 8a9e1e773f60 ("iommu: Introduce a replace API for device pasid")
> Cc:stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
