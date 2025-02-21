Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272E201024
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127248; cv=none; b=EY+UoD04j6u2sCCgIJVbeNQ9Rr4/IT7LszBy4GksZtLivPzop29YwWdncqYmXwTNmhb/VJEvRuCclZCiQ6mzYhJvyu3eoYsAug+9Kb9fqofMOcDRt0SrJ0aa0s+LltenTVvTi2GIinAW5OCZcFX9uYSuVSW361dQZYviI0qbdcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127248; c=relaxed/simple;
	bh=yK5Yfrdib0jcKY/COjn0ut9/tvqX9q+bVGaIe/MgXDc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JkFPC2bfVhrhrIZfbASFxVtQz1K9maEdNklCkXrkV01GV9sYh7KjhbNXgNtec4lqGf2Eq6joZ+YHBhvGH9iJZSaTtt3ZDSYU4BTO3L742y4J+sVSmuWZ/ce++dGNx4SJzN69S8nf7WpT2M7f+/phG8NF9Fnzvut1Ya5i2NUuOTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SUr9spae; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SUr9spae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740127247; x=1771663247;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yK5Yfrdib0jcKY/COjn0ut9/tvqX9q+bVGaIe/MgXDc=;
  b=SUr9spaeLLRlWmzCqj9a1Ld0DGQAVdP74hg6p5smuhfQvzOR6AIxGwr/
   A+lMjStwXsATK+o94ohug8rBFSibUTObbqB5WTm36Um0eW2xKja7WNr2G
   2vaLYyjodhCg2BQyp8bsLOm8zJ/JR+yhWrfGhlfqd+R2Mfu00Cu70PGiD
   TbyGR/Yw+2+5N0jRtOS3G0SHb37oYmt9qmK0opUzMCbK4b+Afq4KT1jdY
   vXi/CSU4OfOVyrP1j46U5fcwfK4vDT2qAqqXSL6YvJImMStXqhOHAvQsb
   ywNWSXGeGzloDPFKFhFAa02vjIEnWvIAIfCsBgxQZ0sIgLXVgHi0KZQpU
   Q==;
X-CSE-ConnectionGUID: Thxjpwb7QPm7mFd15WZKtw==
X-CSE-MsgGUID: c16tgtr1SH2dLcOu3OS62w==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40166568"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="40166568"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 00:40:45 -0800
X-CSE-ConnectionGUID: RVniUFRwQ7Wf3Y+ZMybDPA==
X-CSE-MsgGUID: Dbg9LY1JTzKkKeUkID8tOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="119930199"
Received: from jingxion-mobl.ccr.corp.intel.com (HELO [10.124.240.93]) ([10.124.240.93])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 00:40:44 -0800
Message-ID: <75f4867f-99b9-4ba9-abf4-f0dc29d08fca@linux.intel.com>
Date: Fri, 21 Feb 2025 16:40:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com
Subject: Re: Question on context setup for passthrough
To: Jerry Snitselaar <jsnitsel@redhat.com>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux.dev
References: <rz4kc2zxi4fritsbmjsa3ekqncguvnmeir5se3fhu7pzhtgipk@2u6ps3q3gsqz>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <rz4kc2zxi4fritsbmjsa3ekqncguvnmeir5se3fhu7pzhtgipk@2u6ps3q3gsqz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/21 15:16, Jerry Snitselaar wrote:
> Hi Baolu,

Hi Jerry,

> 
> In context_setup_pass_through_cb there is a check that bails out
> if dev != &pdev->dev which doesn't exist in the code that sets up the
> context entries in the dma domain case. Is there a reason this check is
> done in the passthrough case?

The check "dev != &pdev->dev" was added to prevent setting a context for
a different device that has its own probe path.

> I've been looking at an issue where a vm is running with an
> intel-iommu device, and has a pcie-to-pci bridge with a device behind
> it. When running with this commit, and defaulting to passthrough it
> gets a DMAR fault for the present bit not being set in the context
> entry when the device is coming up, and the rid for the fault is the
> rid the bridge will use for transactions coming from the secondary bus.
> Without that check the context entry gets set up for that rid, and
> it doesn't get the DMAR fault.

This appears to be a bug. Do you have a fix, or can you tell me the
process I can use to reproduce this issue with a local setup?

Thanks,
baolu

