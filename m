Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A101FF7DF
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 04:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730176915; cv=none; b=UZdaNaJxBuI60cVEhvSyPg7Fs6kZLPQHdz3UoIN6Bsar8sqaxFJ/SRaZ13pinX4ht2Z9bT6mW1Wj2JygKyVwXKq82hf26+HvMt5/FApakFdPDgAJVynFx5CeofUSpQ/pQja2taUX8D1eUzjQwzxqaQQ7zOKwXvkpqBfG18ZLOb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730176915; c=relaxed/simple;
	bh=hjQvY+UjxDcsasRODUfDesMwL9vFFvqXlAJ/wksPTKM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ln3B13DvaV/r+PoqEiphUQOaaCL+Kto0FGgFl7bQ7/Ux2UdjFDq09vhp0MGpnkErzAOmJ7qZxe5MEWFhmWOYmJVy/ln8ODnl/UkW/DEmaL8GciHgIrwL//Djd4NPS2TnW/kvfNCdPpCTzGH3wCUmQ5o0oN6fsshL/DCDf+swQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijCN1KqK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijCN1KqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730176914; x=1761712914;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hjQvY+UjxDcsasRODUfDesMwL9vFFvqXlAJ/wksPTKM=;
  b=ijCN1KqKdIdjrrwh5GfrSWfDCQc0SAi5hKS+8rng3+gsULWPRWiZiMLz
   BJT6iQs564+f6+syXbHXkommweS3BURSr906aSOX7YS0dTcebrgWMpgFd
   2yqCku0IyePypMho0W60nY4szSFHM5XF6n7xJ2lzyFrx7yw3tOdcwaRnS
   fyT2Bc+jSbLIkhw5KagKpBMU9mou2p15tvNMG6pzWcrcHFGAoQES1ST0y
   Q/lk4XdBp4lYxxG25ctfc1bjFOwP8hHTEBDaboF6FnAmP+socNlBnrb2H
   DxaM543TZKikaI8zQVljAOQrtQRz8CZYsh30UiCZdvegqrz0TSclZC2c1
   g==;
X-CSE-ConnectionGUID: W6oT9hkPRjuosYSMdQf7pg==
X-CSE-MsgGUID: jMokZ8WrQ3Cfjg+rBVV0AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="32656035"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="32656035"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:41:53 -0700
X-CSE-ConnectionGUID: nUIV6MclQxKL2sVcb50Bww==
X-CSE-MsgGUID: bTs9Kei0TeSZhLl/PYPqAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="81984969"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.238.0.51]) ([10.238.0.51])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:41:52 -0700
Message-ID: <f2c88465-1e82-4988-8ed4-27295c52e253@linux.intel.com>
Date: Tue, 29 Oct 2024 12:41:50 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/vt-d: Drop s1_pgtbl from dmar_domain
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, kevin.tian@intel.com
References: <20241025143339.2328991-1-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241025143339.2328991-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/25 22:33, Yi Liu wrote:
> dmar_domian has stored the s1_cfg which includes the s1_pgtbl info, so
> no need to store s1_pgtbl, hence drop it.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.h  | 2 --
>   drivers/iommu/intel/nested.c | 1 -
>   drivers/iommu/intel/pasid.c  | 3 +--
>   3 files changed, 1 insertion(+), 5 deletions(-)

Queued for v6.13. Thank you!

--
baolu
