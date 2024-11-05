Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A22EAE5
	for <iommu@lists.linux.dev>; Tue,  5 Nov 2024 03:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775874; cv=none; b=c4iLA3FxtLJfNZRVjdySJaq8ZetUPbAGOHoUvhrjdbJQiOpHcOA5f7qaXPwaDHvVZGi+3vkn7oiLTmVnyHHt3bMUunqddN9N+4mtnELfXLRsym75aECY7vPROJnXLCHyiJ/NTwsp1oXpw4u52GfIyk6OcL5h8zmi0KkiKGu2TcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775874; c=relaxed/simple;
	bh=KQaVU1DFeJXqajbB+TQ4REuBA2JmUEPEox2dqJrUDw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2Nb39vyEuF/k5CTwZ4HfiYViqcdudk91kd3l2nF8WX0oEgkZuPUMlUQfcRteiZ6x2/2551EAYh0TUsickspSijS1AVWbYWe3rWRV9vref9SzB++GDzV8QP6UjHRssrEUs2pA7TzpW9otk7+CisB4EAg4NIgpxiaZb1kjAy1ewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDPNlMdv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDPNlMdv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730775872; x=1762311872;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KQaVU1DFeJXqajbB+TQ4REuBA2JmUEPEox2dqJrUDw4=;
  b=SDPNlMdvM0/ORWSmAGTB7dEI3NCVCAAwMXch+Ko+j+T8Aynjwbq3cCoH
   r6NCSfqLXiSVaxCVaqdf2VdGm0Em7M9dPilXBdVxjIYE4RBOe4n8B9WNX
   U6cKF9AJVjBEh6aktzaHKeBA51OgZOiNDD+0GYZou0zrySJbPxL71BoTD
   NIuz7th7KXntB4Ia1F/65kuPXcFaz46E/fiEOrhTluEDf3iLwW24hRiDo
   nZqB3pp6A6Tpfw0cfM+w/hUAMTEuS45PlQ/h0w+N4ejW0nLOLmrnXV3qg
   DHhTtOzmv2QJ5wa0r2Uus2ogeediG3E9097TM1IS41sEuKWapopS9zpMb
   g==;
X-CSE-ConnectionGUID: /5EfY3OHQmywEjf89gPnGw==
X-CSE-MsgGUID: 810Bp/IzTjy++IqOWxwUHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41877829"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="41877829"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 19:04:32 -0800
X-CSE-ConnectionGUID: 4eQABItqTJqD5SMjYgEIxw==
X-CSE-MsgGUID: Ggyga+hnSGKdCwsrVEOBLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="114638199"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 19:04:30 -0800
Message-ID: <4a2848f5-0b3d-48dc-9e12-6179083cf9f5@linux.intel.com>
Date: Tue, 5 Nov 2024 11:03:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/13] iommu/vt-d: Make identity_domain_set_dev_pasid()
 to handle domain replacement
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com, will@kernel.org
References: <20241104131842.13303-1-yi.l.liu@intel.com>
 <20241104131842.13303-9-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241104131842.13303-9-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 21:18, Yi Liu wrote:
> Let identity_domain_set_dev_pasid() call the pasid replace helpers hence
> be able to do domain replacement.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 8 +++++++-
>   drivers/iommu/intel/pasid.h | 9 +++++++++
>   2 files changed, 16 insertions(+), 1 deletion(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
