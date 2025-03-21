Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC79184F
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523019; cv=none; b=PwuGxGXKI61Jv7dHxSJ0nEVJuO/2BHxkALaLc0xt/0ao41H72ZpyJZ/atd240pdRP6Bxg+iufP2VenTP6VzfAHcKg43t8onG+EBD8B0GonvSDF2EXvAYJOAnEp63kopnZaOETCLVl4mgJqinZKp4gxQRkM4zXEnLGP/YlqtIW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523019; c=relaxed/simple;
	bh=+cfCpnGz2efr3JOLIWRNPsx4qh8N+l+Pk3sZhNGypOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPF9PXgrMKpyvfzes480J94SOCA//JSoNBpieN90w+CoGC1A8cBTCY0pleF9GLlcMpuV/goE4WlXQPnFtRftmFjZd50s8s6keXgDZZ40MdBEebJthT7jZHBVFKDWgsSk2TSMn0zCndsSlxHz1NTnYCCCf+vOpblb1k7weVjPbN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDUuUDjk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDUuUDjk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742523016; x=1774059016;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+cfCpnGz2efr3JOLIWRNPsx4qh8N+l+Pk3sZhNGypOI=;
  b=LDUuUDjkHrR2CVwglsJjbRqbFWC6uqNCGbqDvoeO0UMixStyblJSQkqN
   69xjuTSzkal2uxSiXSqjJBLsfQ8oXnO/IW85hLof41l1YIA0yob16MFlL
   XtaNW5N05fK3lz0k4IGWqpFYSjrmUFwXXyE8CnXvxz7aFjzP2X4fa96R1
   DpXTs/vw7GJN4KROyMeWfe81Vy5izyspxiG/KYnFWndrYA8CoQTElW22E
   8wXnXPoDTToGd772T3U7yI03TnZLP48IIC1COG2r/JgnsJ/7Oi6lga1vD
   1nh8crXqNKcxeZfGQqNqOsBWdi6lOrDu5DjQV+fRf/uIDmRNs90/p9o5L
   g==;
X-CSE-ConnectionGUID: bSewxEEDSZGu8CPnB38Qdg==
X-CSE-MsgGUID: oUf1lb9dRESGkH4FFnuFTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="53998125"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="53998125"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:10:16 -0700
X-CSE-ConnectionGUID: uTJTyoPRSnmyt8hjfXRQGQ==
X-CSE-MsgGUID: cb3MejzqTVars423gZz2wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123083543"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:10:14 -0700
Message-ID: <25a71970-60f3-4fea-a216-03ba4d48b248@linux.intel.com>
Date: Fri, 21 Mar 2025 10:06:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] iommu: make inclusion of amd directory conditional
To: Rolf Eike Beer <eb@emlix.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jerry Snitselaar <jsnitsel@redhat.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <12652899.O9o76ZdvQC@devpool47.emlix.com>
 <5895641.DvuYhMxLoT@devpool47.emlix.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5895641.DvuYhMxLoT@devpool47.emlix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 17:14, Rolf Eike Beer wrote:
> Nothing in there is active if CONFIG_AMD_IOMMU is not enabled, so the whole
> directory can depend on that switch as well.
> 
> Fixes: cbe94c6e1a7d ("iommu/amd: Move Kconfig and Makefile bits down into amd directory")
> Signed-off-by: Rolf Eike Beer<eb@emlix.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
