Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFC61B5AD
	for <iommu@lists.linux.dev>; Mon, 26 Feb 2024 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708928490; cv=none; b=XOAc62OoJV/UHpj8DAwdF57sxU9RhsTTcw0gMxMWJrzek2kbABX1ZjrUyzwA3RsA5PFAObHLvN7xelX3xXn1R8XnSy47oIT8nYD4qen6r0/HvudYipPczKatlWsIImna6y1aS4jo2taZwN4vgUCAq7P0NGHR6zF0WSveBY6iM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708928490; c=relaxed/simple;
	bh=esZz3djn6O6RmRR3GDnXv8cDl7UDtiJSo5d12ICyxB0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ryTl6mZMOej97Fn4waOL7gL+dC57YgyyDvi11XO2sEniy7uaYr2cMjnQcLEY2z15qy7OnHPL26qR+pkAl3R4yMH9S4TqsW6K6CTvcOGHoSqtTgZRlOSFcdGP+zd12X0xyIZvW6jzLTpvXQcUjrsy7BLytRXA0vsLlEFBKEvITxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hB4ab3H1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hB4ab3H1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708928488; x=1740464488;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=esZz3djn6O6RmRR3GDnXv8cDl7UDtiJSo5d12ICyxB0=;
  b=hB4ab3H1blbZ+5t2OMBncbRfLpFJGVp40q1M15jCGtiL01hfHMat+BLJ
   iBJP/w+2D+qcm121R6WSAEgDQEaRLXDbF6ywQciBNjUHt7Zz9SZ8g/7TF
   oYgAM10uuKwWTE44oNdbjW8tZ1FZYJasqOfWu3/BM3+6S8r3CYGlv2uxX
   yLFd5RSmDhmQc++iOfmft2enZwhWDDjICC2lDyvSGw8gwArcH357MYEV8
   M39wBDww4kjNWMu3sRFf2NhMwkGrlxpnOpi0zQ5WqMYFFBs7/EFlT+xkk
   AuKmDX92abMYYAR/qYakHqHaHAudR/zIbIRNdk/LEsylixVSsFLfrXVWI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3359781"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3359781"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 22:21:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6562049"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 25 Feb 2024 22:21:25 -0800
Message-ID: <201af18f-9978-4ced-ab3c-0deea06167a7@linux.intel.com>
Date: Mon, 26 Feb 2024 14:15:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Huang Jiaqing <jiaqing.huang@intel.com>,
 Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iommu/vt-d: Introduce rbtree for probed devices
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20240220065939.121116-1-baolu.lu@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240220065939.121116-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 2:59 PM, Lu Baolu wrote:
> This is a follow-up to the discussion thread here:
> 
> https://lore.kernel.org/linux-iommu/20240201193427.GQ50608@ziepe.ca/
> 
> This proposes a per-IOMMU red-black tree for iommu probed devices. It
> benefits fault handling paths, where the VT-d hardware reports the
> Source ID of the related device, and software needs to retrieve the
> corresponding device pointer based on this ID.
> 
> This is also available at github:
> 
> https://github.com/LuBaolu/intel-iommu/commits/rbtree-for-device-info-v2
> 
> Change log:
> 
> v2:
>   - Drop get/put_device() in device_rbtree_find();
>   - Add a mutex to synchronize iopf report and device release paths.
> 
> v1:https://lore.kernel.org/linux-iommu/20240215072249.4465-1-baolu.lu@linux.intel.com/
> 
> Lu Baolu (2):
>    iommu/vt-d: Use rbtree to track iommu probed devices
>    iommu/vt-d: Use device rbtree in iopf reporting path

Above queued for v6.9.

Best regards,
baolu
