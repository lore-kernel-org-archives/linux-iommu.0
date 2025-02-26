Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382B22FDE4
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 05:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549236; cv=none; b=WrX9HoCY1iTKY2e9bSxaAvMQ0rc5SVA/I7K2y96FJ9T/+9UIpoj+mGHdo+dqyQ1HlWfWd8CIVIGWv6ZwLS+8XpQWvOQ/XAAmWWoqEMaO5cNMBQjDuVukTgcqCFfot85u9YA4G76jHSJAeqkHZI4z7WiZim/hJ9UMruEHLpH3zyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549236; c=relaxed/simple;
	bh=FdHUdWC69AVAeXqjoWOZ7GPZ4/OBhOuuOpwwP3bIrIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpN9l9HbFKJzk8NQ2AxkuZvlm6Nw/lZMYPbwxr5KBf3YjcWHP2agEbo3yeS5wvroNtDfQ7QOJnPddJMi8YBVl76rtV1thA9XugCXL6bLGwpYgLpOBUOB7UFsA9OZtxv65Wpg68TKM+BipIytb3IBV6ABRbxfrTnFJB9Z81S4cBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpbQNOWY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpbQNOWY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740549235; x=1772085235;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FdHUdWC69AVAeXqjoWOZ7GPZ4/OBhOuuOpwwP3bIrIA=;
  b=gpbQNOWYLw54O6SBvNmqrp7rkvEU/yHNCtQ+DhT37DAIqx/qQ1SskLe0
   dwpGYfRlqPRuOa4NIQFbXkAMcqr3hCVr86XIE6PhSGmWtX36IlIgWqfit
   HXOzA0wpK3kB+KJp8M1MUYyhrPiYqQBQCZpAOf3nm+D9/UBdeYLvU2Oip
   3JF/dz1wYpw0XPt9Yt8wIk7tR9EndJTXyHpWZh/w1a+2FVWhNAfvg3qss
   sW9sGWECjcNyAD464T5vzk8TEs5N32eUo2PGvYaFz3elswtx2SAB13Mo5
   c0JzEXIzBgdxtQ2T1ZtX/WemV6CoNmGOpvJXrEFaXTenDuusJPdQr4xcS
   w==;
X-CSE-ConnectionGUID: dbBhu8jqQs+7Bs4FU1dHbA==
X-CSE-MsgGUID: +L+PuhDmS8uypz5wR52eZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="45296311"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="45296311"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:53:54 -0800
X-CSE-ConnectionGUID: nICCl9orTKmiJFLBwMRQaA==
X-CSE-MsgGUID: 0/HE3PP6SFGiDoESaFW9Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="147430881"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:53:53 -0800
Message-ID: <dd677da0-5c5a-4f19-a68f-a63f85b9b2a7@linux.intel.com>
Date: Wed, 26 Feb 2025 13:50:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] iommu: Drop iommu_group_replace_domain()
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com
Cc: kevin.tian@intel.com, iommu@lists.linux.dev, robin.murphy@arm.com,
 nicolinc@nvidia.com, will@kernel.org
References: <20250226011849.5102-1-yi.l.liu@intel.com>
 <20250226011849.5102-3-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250226011849.5102-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 09:18, Yi Liu wrote:
> iommufd does not use it now, so drop it.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Nicolin Chen<nicolinc@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
