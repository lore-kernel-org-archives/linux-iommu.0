Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267CB654
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260574; cv=none; b=OXwbPZbqNo+cxCc/72RZDd+8S8o7yOB86AVLKXx6GYstHVxIozxUnYPNseLvA6vvNLI3U9STcJqO4pTY/K3cfyO/+9O+yb8DOtMWRfeSlfk5hMOvWxLGt2eXkBvodHEzGF8P/oyeGUAO8qdfSSvCo2RcIR5bYvven7rEV5F03Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260574; c=relaxed/simple;
	bh=7wS4pwXxm06ZvcijEe/CiyDzM609AAFwojmjSSeBCvs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nM3Q5QaB4RSKEv3Sg/TevEWqEBxT5uLDt9oAYr2kH7+3gIbbs2d5fWKA+LCLbunCQUbBGL9C+FqR/lfst6p0lrdJwB1MXljXxgmqgZzwnrBrpbQMhV+GxtLlN84HZouUzhGZlhchvtKkTMMuCmT6lEqyIddDpsnQN3+hBHxfWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZ2AFV7E; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZ2AFV7E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706260571; x=1737796571;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7wS4pwXxm06ZvcijEe/CiyDzM609AAFwojmjSSeBCvs=;
  b=TZ2AFV7EYKKYsNN2AsWY5JKTzEAQWMv5DpOSWHOQhwP1hhJ5avroX8+O
   6HoYfLgmDC7MDiZvdzWQHrOuqlkncP187/M1bX0dZ2nx/B754KiL03iyw
   ohtCfQ33+QWWg3vJBMGlVr/+R/MVegOuhpgCsUP4FE5UNltycF+idFqyt
   w3QfyDukh5az1x9nmXUl145jAm/YXAjdCHuBnkRq2KY3uBFMJnI/Si9no
   Qe0QK0rpqqPrfCF92Y5i1mIvGGUGTIJ/BhOMsZ4jmPifzclwF7cgNm60S
   muEvQIR9qrnrdp2CpeYMSnj3/48jrnSBdsAYcVLt1MLofZhzi3BDkjiKS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="399590304"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="399590304"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 01:16:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="29070270"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.174.176]) ([10.249.174.176])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 01:16:08 -0800
Message-ID: <34eaf7d6-72e7-4f72-a42a-dd2922d9b8b8@linux.intel.com>
Date: Fri, 26 Jan 2024 17:16:06 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: iommu/vt-d: Add the document for Intel
 IOMMU debugfs
Content-Language: en-US
To: Jingqi Liu <Jingqi.liu@intel.com>, iommu@lists.linux.dev,
 Tian Kevin <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20240126064704.14292-1-Jingqi.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240126064704.14292-1-Jingqi.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/26 14:47, Jingqi Liu wrote:
> This document guides users to dump the Intel IOMMU internals by debugfs.
> 
> Signed-off-by: Jingqi Liu<Jingqi.liu@intel.com>
> ---
>   Documentation/ABI/testing/debugfs-intel-iommu | 276 ++++++++++++++++++
>   1 file changed, 276 insertions(+)
>   create mode 100644 Documentation/ABI/testing/debugfs-intel-iommu

Next time when submitting an incremental version of a patch, please add
a change log after the tear line, so that people know what has been
changed from the previous version.

Best regards,
baolu
