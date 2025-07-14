Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5E1F541E
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 05:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470070; cv=none; b=ifyd0bbdgaQBVWraviM02o1CDawmwC441YxCiXByQ6kw9ztWBxm1lip4buRfLCtsR8rKdhskWeOI5pBPq8zmup17XoYPLtp35zq2ZDKkIKB47DPy0RI2WlMPV8iCafYpxSnZ32aQHmkRGZzOR07K/4cUI0Q2mzFpTcExcyFgj2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470070; c=relaxed/simple;
	bh=uLXzfPa/kgjA8MlZVAsuBXTARbh4+BqvX/Egj4qEhWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHWmzU7HfU2AAVxRC6E3WdGovV1E8+k+Vs1yVH8+NYyHpjcjkfiK4W6M55+tjE3LCSZBJzz200jIcKUd924ByFIElp16j3MOqTmxUB2vRrrZ/gvBgMd9BaeImuEIQrJJnIdOwmoRoiztQr9vep83n7rb0rZS93gd6A5A4IcuLT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHq0tX6c; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHq0tX6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752470069; x=1784006069;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uLXzfPa/kgjA8MlZVAsuBXTARbh4+BqvX/Egj4qEhWM=;
  b=cHq0tX6cj9zvc0Eu5bJqkUEZWYcRrueMr6/IcqSHryb5JJI4RxEYuBue
   k+rqxzfXjzi8pW8In81Coow53Dc5uf5FH6kYINausTWpT33P8T1o11n/q
   Ef5rIquiYayBwpViqni8Xz40wrSxAMfotb795VZcdyl6mSGZS//EyG68q
   RfUvMUl8lfw6VH7PRs54qI5mK4MXTaeKrGx1arIROItm+aUSdc3LyJrFZ
   bAi9Ebp9ijjZS4YSNdZkYXt1u96EEWjz5ig+XqDs+sejtK21yIzjxZ58N
   jx6UKa5N2/JA4OOxFenNsyZntH/H1bRJIgtR9SKichQuS20mokEWU8EDW
   w==;
X-CSE-ConnectionGUID: Ctt+fSaFR3yJk2gZzFV1MA==
X-CSE-MsgGUID: 9Z79kux2SBmP7E+prZLYEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54512543"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="54512543"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 22:14:28 -0700
X-CSE-ConnectionGUID: 0g2hrg2MSki0mDAsSz82Fw==
X-CSE-MsgGUID: YmX11Dh5R1W/b8OofUraMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="156470642"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 22:14:26 -0700
Message-ID: <551c46fd-d034-4b06-94a6-6080dc9b9600@linux.intel.com>
Date: Mon, 14 Jul 2025 13:12:38 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Off for two weeks
To: Will Deacon <will@kernel.org>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <ojjm5wbqi44t5v2qo752u7q36uvbrda7au5coskjbnxgaom6t5@ebbfcm7zmwfa>
 <aHE4Vo7rJAQVkZsA@willie-the-truck>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aHE4Vo7rJAQVkZsA@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/12/25 00:14, Will Deacon wrote:
> On Fri, Jul 11, 2025 at 04:39:46PM +0200, Jörg Rödel wrote:
>> Just a note that I will be out for the next two weeks and not do any updates to
>> the IOMMU tree.
> 
> Have a good break, Joerg!
> 
>> Will Deacon thankfully takes over during this time, so please
>> send everything his way :) I will be back on July 28th.
> 
> I'll do a sweep of the list and pick up what I spot but if folks think
> that I may have missed something, please just shout. I'll switch to
> "fixes only" mode middle of next week, given where we are in the cycle.

Hi Will,

I didn't see this notice before sending the pull request of vt-d
patches.

https://lore.kernel.org/linux-iommu/20250714045028.958850-1-baolu.lu@linux.intel.com/

I cc'ed it to the iommu mailing list. If it happens not appear in your
mailbox, please let me know, I will send a v2.

Thanks,
baolu
