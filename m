Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE49217F33
	for <iommu@lists.linux.dev>; Sun,  7 Dec 2025 03:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765078780; cv=none; b=h5pVugLn3PM046xvXjBb7cXOlrDVlPt3emmZ+xhOgz6P8PQCGHDyuRb8m3yMfXLga5KnVhgL/WISSndDSwNoPrzFAI+zCHVcvIYQpJtQcRfPBXZrLWCVyEjmEIQFlW+68uEOyQIAIjicaVxKKJXuXtSSF0W+sBwlBU35oNrtzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765078780; c=relaxed/simple;
	bh=9pEQ8TBXhjCsRBBVIl1AjluQ1s7VGhb/NqaBEvkHMns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PU0le0t4zSlsa+AyBryyVs6U2JFW2bzQCOAhqh4/NMFT3/0VChLUEyBzkF3VX9AZAajqhw5fdEoSjfcduwLmeAQ4+sR6y2rHmqgBPb7TZpp85Lewr4nWjnxi0KcCEqdf4OWiUDfbhQTq5a7zH9xycsZTJwk5kTsLc/06MtD0AYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMK8RrS2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMK8RrS2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765078778; x=1796614778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9pEQ8TBXhjCsRBBVIl1AjluQ1s7VGhb/NqaBEvkHMns=;
  b=NMK8RrS2Ht1ktG9ZwlbhpOYep7fIoyJydezFQNE1FiXYM+/cllISzCKO
   sr5EF2zrrZh07nTrg0AQh+qZquVegduH8gJDRc0aUc6ZdxZSbK5eua90b
   EsbBhuntIK8FRcFjykJIQOAWt+hBntX3/o4Gyk2BMgJ4dEE7mzDjwKEbf
   bImv/d5iPgkZfHQi6WbP3BMDGuIG42gmoMVRs1+yhX0Yuh8fdCd1ShL8m
   dELIwhaLA3ipHKnahpeYtALqJ9bbxHTl1OLvG9ipPx1wNbqvEKpHfOxim
   WSjraQ3mYp2kr8ZCzPYxj7MlTeQlFRpyeTMUy9CQVsJCCPe7HKL+zfA+i
   A==;
X-CSE-ConnectionGUID: Evt/pjp5T5SWNEt9XgCD/A==
X-CSE-MsgGUID: /dsbW6/DT+i2BECj2R0xEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11634"; a="77682649"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="77682649"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 19:39:37 -0800
X-CSE-ConnectionGUID: /r0bS8doSq6Jd9QHXonmnQ==
X-CSE-MsgGUID: 6ZEddF30RTOgjHdqOMXQ8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="195538241"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 19:39:36 -0800
Message-ID: <ccd63624-81b3-49d7-ad42-4cecd23258f4@linux.intel.com>
Date: Sun, 7 Dec 2025 11:35:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel IOMMU] Question about memory ordering in context/PASID
 entry updates
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: iommu@lists.linux.dev, David Woodhouse <dwmw2@infradead.org>,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Aashish Sharma <aashish@aashishsharma.net>,
 Grzegorz Jaszczyk <jaszczyk@chromium.org>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Kevin Tian <kevin.tian@intel.com>
References: <aTG7gc7I5wExai3S@google.com>
 <b9c23895-ae8f-4c71-a0b4-5956e2719901@linux.intel.com>
 <aTLntWFSADz81_NF@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aTLntWFSADz81_NF@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/25 22:09, Dmytro Maluka wrote:
>> as users can change a device's
>> default domain in VT-d legacy mode.
> Not in scalable mode? I'd assume users can change it in both, and I
> don't immediately see anything in the code that would limit it to legacy
> mode only.

In the scalable mode case, the context entry is not altered when
changing the default domain. But, yes, users can trigger context entry
changes in other cases. So this applies to both modes.

Thanks,
baolu
