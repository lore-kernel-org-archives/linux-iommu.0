Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E063D84
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 05:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689140775; x=1720676775;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XDmxtgjF22hjZt3RXCpO8XNp3Xx7XXlQUG+MBO2cAg4=;
  b=D7O7HgOP8jT6AYl6Ji0BVVJII6xkgTMGo4BohVHWm8YXlCWacbNCAoZ2
   jl0kQ13b0TzKdlhICVpJYzpFpQwdN82mJDPkv4ohoEpkYGZJJuqvPum+x
   BhYhmZOIP0I3HkgvZDTdaNtK3CnQJ4sMACEqfixk3SimpN9VpRukm5h0y
   E/8ZeAtrAKPiSILjomeMLUzKNWZolqYYBq+XeN2ha8kJUBphd8mAtgRfQ
   gOF1Fgxr58RscDRTZQV18KksYG26zzxoShjYG8IQszZXH0XTmISNypj0M
   JmB5l0WIDSqZDopxc8N6jYvy+UZuhoYQgKj8PEkJWqStIdcLcc4zrmhvi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="354712562"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="354712562"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 22:46:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="756637896"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="756637896"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 22:46:14 -0700
Date: Tue, 11 Jul 2023 22:51:11 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Jason
 Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
 <robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 dmaengine@vger.kernel.org, vkoul@kernel.org, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, Tony
 Luck <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 rex.zhang@intel.com, xiaochen.shen@intel.com,
 narayan.ranganathan@intel.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v9 0/7] Re-enable IDXD kernel workqueue under DMA API
Message-ID: <20230711225111.567894c8@jacob-builder>
In-Reply-To: <d6399f56-0528-d923-910c-822611137e2d@linux.intel.com>
References: <20230621205947.1327094-1-jacob.jun.pan@linux.intel.com>
	<20230710101810.40098ce3@jacob-builder>
	<d6399f56-0528-d923-910c-822611137e2d@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Baolu,

On Tue, 11 Jul 2023 10:29:10 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> >> Changelog:
> >> v9:
> >> 	- Fix an IDXD driver issue where user interrupt enable bit got
> >> cleared during device enable/disable cycle. Reported and tested by
> >> 	  Tony Zhu<tony.zhu@intel.com>
> >> 	- Rebased to v6.4-rc7  
> 
> Thanks for fixing this.
> 
> It seems that you missed some review comments for v8. I can help to test
> and merge when all comments are addressed.
Right, I missed the max_pasid = 0 case as you pointed out. Let me respin
the set and do some testing on my side as well.

Thanks,

Jacob
