Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E514836C
	for <iommu@lists.linux.dev>; Sat, 17 Sep 2022 02:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663380934; x=1694916934;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TIR7Gl34E+WzkUuY6+mbDgNR2nShzOiESTzqP+vFVEo=;
  b=ma0tTRp6fbQoATqTT2BfWhIszPJWF0uoqtiM80RJ1xKkOgDI0SW9xMN5
   LGyiZyYmRFiHcXRfy/5glzI76cz7DbpWie36uINapl2kLe31Tu2Ios+aA
   z6fR3sDOaemCjwuYzQ0ZlZqcomVRUQjpy2wMN+9z8f6CfR+9Dc/40uPcz
   9qSz6B2RfvhYUlWjysWCH+ihXlfSxadrMc2KX+BA3ZrOcbyL5w7SczwcT
   WlYzUEpIkQXuKGMHQEknCPUUkH33fM56ZoLhHFaGRXXktdVagefZ4XeEL
   k47ZSa/lsPu9mHXJe8c5RpvR4UqIZOn3DMLDlr5WdXQnOmn1wo4WbOgJ0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="286156239"
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="286156239"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 19:15:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="651066804"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.176]) ([10.254.209.176])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 19:15:32 -0700
Message-ID: <3fac95c7-7681-6511-a659-337535e25e9d@linux.intel.com>
Date: Sat, 17 Sep 2022 10:15:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, baolu.lu@intel.com,
 raghunathan.srinivasan@intel.com, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Check correct capability for sagaw
 determination
To: Yi Liu <yi.l.liu@intel.com>
References: <20220916071212.2223869-1-yi.l.liu@intel.com>
 <20220916071212.2223869-2-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220916071212.2223869-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/9/16 15:12, Yi Liu wrote:
> Check 5-level paging capability for 57 bits address width instead of
> checking 1GB large page capability.
> 
> Fixes: 53fc7ad6edf2 ("iommu/vt-d: Correctly calculate sagaw value of IOMMU")
> Cc:stable@vger.kernel.org
> Reported-by: Raghunathan Srinivasan<raghunathan.srinivasan@intel.com>

This fix is fine to me. Thanks for doing this.

Raghu, what do you think of this fixing? If it works for you, can I have
your reviewed-by.

Best regards,
baolu
