Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E267C1BEF8A
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 02:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522874; cv=none; b=ezPcf+7LnCB2Di0QoIS1wIHeBZN8XuNioOGNIc1QtFCIFGA+qtDp2f654gKbvSd0/Lh5dswjFbf4Y1WttnQIH9gsqPSnN0gQTW61nlDglMpMRWDFXeNatGTMHmI0q2H0QZaGAMPauT8zIVhNCs65sSN9YH+dKFh378gEJGVoPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522874; c=relaxed/simple;
	bh=8626GOzSKn3oGmjAcfgzeKl8yc5s8nz0JuPUVSCipH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrWS/vmzzGhtCZyPG+VwmU7CTECPwWzp1HC4bYRuEs5mLxxTMEBn0vOx0R0IFSvUz98wwycA8PaDR2H/kGXtt/qv0nGFbnukcYGkw7Xp/xbdYYEwyZ3Va7ANfKLWbdUyjixaGGcadMN+ArWNkStD3eflmYPPk9H2tXgPUpfE0Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rh6CPjai; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rh6CPjai"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742522870; x=1774058870;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8626GOzSKn3oGmjAcfgzeKl8yc5s8nz0JuPUVSCipH4=;
  b=Rh6CPjaidDqC6mNQ1TJAb9HsNUpBPWLWD148q7mC5tWiOKfY/314x5e5
   KOgN3ch31oqPTYsv70YiuOqHv3aAE88iQxsr14WM/4zxCoLedTDEYRqR+
   IXbWN55D2OEcWW8BlbiF5oA3vu5k8n8QJmMXBlbkn/b0a25pU7ynoixB2
   KfpWwsQjbeyu0SAl36sZm8HvCov9ufWBar0ptzKxdL+Unc01btC1qnEn8
   8dnLP4uLM5cH79thMApAiHsOVO4FQXUom6a2vczTeoo0hH/WAF3vHAu+b
   wySFAUzIm+8CJgcghXbYaHp0lqg7y8VjZirUNxvTNGIh/dqV+4rC/odpK
   Q==;
X-CSE-ConnectionGUID: exC5IAvWThijrjPKLTIsxQ==
X-CSE-MsgGUID: 4VxLh0GDQNyGQ0WJZ2sOQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43028925"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43028925"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:07:42 -0700
X-CSE-ConnectionGUID: /tI3jXi4QbemQp7G/MB1uQ==
X-CSE-MsgGUID: HliStc3nT3OsqbFSFxGubQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="154167549"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:07:41 -0700
Message-ID: <9c6840b6-3bff-4c5e-90f9-c0eaf7748225@linux.intel.com>
Date: Fri, 21 Mar 2025 10:04:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] iommu: make inclusion of intel directory conditional
To: Rolf Eike Beer <eb@emlix.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jerry Snitselaar <jsnitsel@redhat.com>
References: <12652899.O9o76ZdvQC@devpool47.emlix.com>
 <12654723.O9o76ZdvQC@devpool47.emlix.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <12654723.O9o76ZdvQC@devpool47.emlix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 17:07, Rolf Eike Beer wrote:
> Nothing in there is active if CONFIG_INTEL_IOMMU is not enabled, so the whole
> directory can depend on that switch as well.
> 
> Fixes: ab65ba57e3ac ("iommu/vt-d: Move Kconfig and Makefile bits down into intel directory")
> Signed-off-by: Rolf Eike Beer<eb@emlix.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
