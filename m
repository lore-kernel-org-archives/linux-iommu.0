Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED331191F8E
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730103821; cv=none; b=uiHf5e80Qktg9h2GzQAavXb2nHvYp6VZ4xeO0Mav2IRSlTFCDk9MuSPR9k/OpRJSzan70AalatQcmGNzgOSBph6gLbCqPT1ttR66JHvLRdZknB/NPsFU4fe/GDxYOF/D13Kn3aQ0tUc4CjjI5xd4rmxNMCNYgyrsKFZoEVIsrzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730103821; c=relaxed/simple;
	bh=rcd4vg9/nLIxAZ5JKMnr8aTqSx7F77y8ktvacvnFyRY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SirsQOuIyKOuAZYwzJ/hUBu1RXGvELcYCvdvMv54bSuvex4J6/usgijgZS1Ytvfw7OLy4B6M/cTFEY9dh2eLvZ3iEG3WMYrGWhche5SAcfnBZ0fjEfd5IYphgYIznpmKslD627INtlaHPgaAqoq5e5WqvCBlUP5YMG1wnzz5tDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6Jwdv8M; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6Jwdv8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730103820; x=1761639820;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rcd4vg9/nLIxAZ5JKMnr8aTqSx7F77y8ktvacvnFyRY=;
  b=J6Jwdv8MxNf5O+oyGicgjOObc+tdj259fap1xf1bR/6Xm2zdUzt8STne
   6qRfMm2zea3Nz50zRdS1MOpxmbiicvxSwC76RRBRpKm9Jm4KgmH0kz6IR
   zLZk0audDYI9nwE3Ix7WYOZe9V9hDmhghD2e6YhUfLNqgFKVQugjYUcsL
   xPLBWjE4nVa0DDQUGX0BUqbDU7rXc3+mVtqssN5aMP4p7sZkV8lD67yWL
   AzPZ4bfr4+4tgR7TcDZpRrhr/t04lo/O1EYQoiDEmOS59k4xcIOhDbsoI
   sKNDDYWT5vYQI78xZ0NKmHwfBVRLVTTahOQ+QyhF7CBsZfRkP5I8EL9rY
   g==;
X-CSE-ConnectionGUID: dRAV5yH7TUq5r+gK+xBhmw==
X-CSE-MsgGUID: elCiqKAyRyOCuxdQTud4VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40229130"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40229130"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 01:23:40 -0700
X-CSE-ConnectionGUID: mPus2sU2RKm99DOZ5v/DLA==
X-CSE-MsgGUID: K8xxrPYYR4CFXNMf0vfAdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86157989"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 01:23:36 -0700
Message-ID: <d53752e6-b9aa-4d42-af08-d2210f1eba7f@linux.intel.com>
Date: Mon, 28 Oct 2024 16:23:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v4 2/5] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
To: Yi Liu <yi.l.liu@intel.com>, Joel Granados <joel.granados@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Klaus Jensen <its@irrelevant.dk>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
 <20241015-jag-iopfv8-v4-2-b696ca89ba29@kernel.org>
 <90c772ce-6d2d-4a1d-bfec-5a7813be43e4@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <90c772ce-6d2d-4a1d-bfec-5a7813be43e4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/28 15:50, Yi Liu wrote:
> On 2024/10/16 05:08, Joel Granados wrote:
>> From: Klaus Jensen <k.jensen@samsung.com>
>>
>> PASID is not strictly needed when handling a PRQ event; remove the check
>> for the pasid present bit in the request. This change was not included
>> in the creation of prq.c to emphasize the change in capability checks
>> when handing PRQ events.
>>
>> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> 
> looks like the PRQ draining is missed for the PRI usage. When a pasid
> entry is destroyed, it might need to add helper similar to the
> intel_drain_pasid_prq() to drain PRQ for the non-pasid usage.

Perhaps we can move intel_drain_pasid_prq() into
intel_pasid_tear_down_entry(), indicating that once a translation is
removed from the pasid and PRI is enabled on the device, the page
requests for the pasid should be flushed.

Thanks,
baolu
