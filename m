Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32063168D8
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 23:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691537369; x=1723073369;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x+gN3DDRzWrdkL7SMDvYeuS3TzxbM/uvrWhTmfDevG0=;
  b=T6wz+G6JAiv4/HjwUTOql8Hv8Qh4tXM3xp3U7t+XT3D9fZGbpnzOS+hO
   jLYFhdI7pElvbtLRAAtyCz2oJQH/kyUiqJ8AWT23rj9gpnrfWbLy/RozV
   RMVElOZvv0OKnwhmQkIgz39GaiEkgL8g6GLvulnCvUAqnUZEprfpb3R5D
   d1NoXbmX97ZTysIJRpbA0/+7QToLaT5H3/WYknS/d+XpctU4nNZ6eHztK
   /tA9gGvL/I0meDVQahVYLGvSVuAPv8tcXXSRQ5HmYVPwQK0Rvy9GRE1Yo
   KGmg/V9/SXpNsSSmA+raEN12dPir1ITr9yyy9eThmVu6jka8LTau11RUx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457359185"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="457359185"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 16:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="796909973"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="796909973"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.169.46]) ([10.249.169.46])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 16:29:24 -0700
Message-ID: <384b4d29-1eb5-3a23-6223-b6245398c1c5@linux.intel.com>
Date: Wed, 9 Aug 2023 07:29:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
 Will Deacon <will@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v12 0/8] Re-enable IDXD kernel workqueue under DMA API
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Robin Murphy <robin.murphy@arm.com>
References: <20230802212427.1497170-1-jacob.jun.pan@linux.intel.com>
 <20230808095149.781e88a6@jacob-builder>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230808095149.781e88a6@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/9 0:51, Jacob Pan wrote:
> Hi Baolu/Joerg/All,

Hi Jacob,

> Any other comments?

This series looks good to me now. I will add it in my next pull request
for Joerg.

Best regards,
baolu
