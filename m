Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4BC143C72
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506561; cv=none; b=RdiiAk+mQf7oam1N8jpb3CKwNIR55W1X1b0mNt7YQ0ebdx68JqVrC34ANQwtAyyTBEkwBTN8R00IQ1tvMml18f03frKi4PyFM94hCiEexpEMiMugnlr5CG70NGM95d3HI8hMaO5irZscHTiFPqAjxaoMGDZTmEes7sIYSroSGNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506561; c=relaxed/simple;
	bh=ARdnEzGNIex7ygSC7cuRMRlBcy2l+y6uhvsGCFD2xnw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JK1xsKeyv4625ZUdZp2DGi8CR02+hlBvfXS7Z+RKOhZU4RRRErJFthaEIObkKMlgchkNuu+utxk470TdLhaO0o6f7CEDwLatxXblg7dfvVi1Z7NNxbV9GKJCfn2r1JR7RJG+GHM5TA8aXq/D9iN7Fa9m3FtCDK6YQxbgi/+G504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0EDlmoX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0EDlmoX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725506560; x=1757042560;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ARdnEzGNIex7ygSC7cuRMRlBcy2l+y6uhvsGCFD2xnw=;
  b=Q0EDlmoXJ/ONNXBRY8kw43PlZi4T2bjuVe1/U3GaR0coBhlTpoT05fkA
   o+QQOyegj69UW8TQpzyDADoWsh0Pi3Su+ockpHjmkmmgh8LdtGyZ5dogn
   d8tZUisOfWOu6PzlOD3ErkCt0iJ/2pLk7uHAvtCyU/vY2QHYptMrzToU7
   ICpGEKQeYCDV7ZmFISlfPpGqH2A0k8oga10oeIEL3oZSD2HeLKHPNN76D
   thSOBdnNNykcQ8cn157ScH+YBmiqWfvIbegJJWYDJSb7VqN+pVputkrRG
   SXmGaaF1a2tJiPPXqk4C2QvaVnrVG29EO0D17ku2vkCbVkJH7zAtqckDq
   g==;
X-CSE-ConnectionGUID: qlCYu0zBSM2jQ6R6yRUxhQ==
X-CSE-MsgGUID: +lUJnODBRie4R/ZUVFGpDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34802558"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="34802558"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 20:22:39 -0700
X-CSE-ConnectionGUID: IdYXTXTcRoCJtiT5GAUzGw==
X-CSE-MsgGUID: 1PElzQkoTXG+TSUY4pNUew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="66224471"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 04 Sep 2024 20:22:36 -0700
Message-ID: <ef543342-561d-420d-a7a1-7d155e89ad79@linux.intel.com>
Date: Thu, 5 Sep 2024 11:18:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH 1/6] iommu/vt-d: Separate page request queue from SVM
To: j.granados@samsung.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
 <20240904-jag-iopfv8-v1-1-e3549920adf3@samsung.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240904-jag-iopfv8-v1-1-e3549920adf3@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 9:17 PM, Joel Granados via B4 Relay wrote:
> From: Joel Granados<j.granados@samsung.com>
> 
> IO page faults are no longer dependent on CONFIG_INTEL_IOMMU_SVM. Move
> all Page Request Queue (PRQ) functions that handle prq events to a new
> file in drivers/iommu/intel/prq.c. The page_req_des struct is made
> available in drivers/iommu/intel/iommu.h.

Above last sentence needs to be updated.

Thanks,
baolu
