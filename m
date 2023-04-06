Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099113214
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 12:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680783841; x=1712319841;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6+2sIEevEKNZMYLg0cPtMs/Yvde/43gIMbaSm6f5SwM=;
  b=Mnm4lk7WLolmbf4C5iPGskz5kYe2TmSnDw6BsNqcNIvNFfiIsfSR4WMs
   KtH+4jBmIE7nHoLgmTQPYhp4b0Q07HyqvCWMrH78VInfPpGTiI61whZ5h
   VcjSMtIIbAw68AYaWi5PIp8d5bpFGUUhSGeyuobySnbPRuYUMm+XGoDns
   VklKGzAGDx765oXr1f44z0EENCMSIUU2uoArv7aT945tjDN869F9UmOem
   c/E1uEkuyfr1HbEV+hXY0AuRV2ZrHTtSRy/NJllG0qulVgpvaK63RnqqA
   hMj5wOH36fQT17nGswkE7e5S2HODx0dZz8xGfgQV9NXdYSdqtmBIhw5N5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="405508412"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="405508412"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 05:24:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="830719341"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="830719341"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.177]) ([10.255.31.177])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 05:23:55 -0700
Message-ID: <448c24d8-60d2-3881-171c-863b240ebdf1@linux.intel.com>
Date: Thu, 6 Apr 2023 20:23:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v3 0/7] Re-enable IDXD kernel workqueue under DMA API
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jacob,

On 2023/4/1 7:11, Jacob Pan wrote:
> Jacob Pan (7):
>    iommu/vt-d: Use non-privileged mode for all PASIDs
>    iommu/vt-d: Remove PASID supervisor request support

Above two patches are vt-d cleanups after

942fd5435dcc iommu: Remove SVM_FLAG_SUPERVISOR_MODE support

I will queue them as vt-d updates for v6.4 if no objection.

Best regards,
baolu
