Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ABF78F5B
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 03:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742527550; cv=none; b=gWxRl9vE64m0+D9SvBwUoQGaxDYWKafIU1zgmy+QVGuxH83Hhgeq/X6/K0AdGzolIGV/E+LSRtVjryE/jsVrhjyRjIrQE3YxQ5wRiaIrxNQrCYWm9IUJW3VnOtRtOH/fQFHg1/JDvAgrEknze778h1X9k+LFuSRIudSt5D80nfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742527550; c=relaxed/simple;
	bh=0Dt3iiSiWD1Sb/fng99wCdeNwp/kBQkn72UqZ7R3KBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LK9q9RdFChskFa2F36Onh40WYAs6opuR/XS5kURqAp1DMI2zqpNprt4YJpb8oPfcun3bIrFPnsAYhpyJyukjBo1tN/JW/y0WKww08cAgrcL05dqH+NfbWNTPsHmLW13sDv74V9lltWHP/RnzCvRUvGxl860gUENtakhsjBPXMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I97DahqG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I97DahqG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742527548; x=1774063548;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0Dt3iiSiWD1Sb/fng99wCdeNwp/kBQkn72UqZ7R3KBA=;
  b=I97DahqGX0BH+WjED0NZPeEfoIKi0jZ2uG/Vfx0I3OQBffPsWSenLkuj
   n4vMFITvPfCDQKRcCa/W4s9mL679JgQuh9XwmnNcARKZX/R5S+I0MTEhU
   yE6rHt9FWBkpiGZfOmmSITgc7dKIP9O/288DuLkNyGn0VRANGYn0lMZVW
   3GwSbgdy1gS93Ep6aIY9Os/VP//ECkzdzgms6WJDw63ZJr+OVjYhOY9j4
   UsHBZOkJUUhoIIzDBpoqG8WB6n/bgdjd339A2bHuKTQ/nryP/jKbdqPdE
   kSO7xO1QC5Al7gn0CoRd1LidZN6hlvMaH0X3nI5MIDLf6sTw5WR1Pmgt5
   g==;
X-CSE-ConnectionGUID: iYtW8xIaRsirw/azC313xw==
X-CSE-MsgGUID: 5ikW6Ik/Rs2aTFtn360Hfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="61309746"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="61309746"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 20:25:48 -0700
X-CSE-ConnectionGUID: bkNLqzWMSDatmawuWOtT7w==
X-CSE-MsgGUID: P3e1RV+kQZC9OWcYReYCmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="127437206"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 20:25:47 -0700
Message-ID: <279b8c74-cb0a-4cda-bc15-1568612a9486@linux.intel.com>
Date: Fri, 21 Mar 2025 11:22:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/18] iommufd/device: Wrap igroup->hwpt and
 igroup->device_list into attach struct
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux.dev, nicolinc@nvidia.com
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-8-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250320134744.5777-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 21:47, Yi Liu wrote:
> The igroup->hwpt and igroup->device_list are used to track the hwpt attach
> of a group in the RID path. While the coming PASID path also needs such
> tracking. To be prepared, wrap igroup->hwpt and igroup->device_list into
> attach struct which is allocated per attaching the first device of the
> group and freed per detaching the last device of the group.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
