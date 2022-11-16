Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C986B23AA
	for <iommu@lists.linux.dev>; Wed, 16 Nov 2022 05:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668576397; x=1700112397;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EqpnoOjcQd4o8WKzZS7GVARWuTNSHWNOv9Pfx/doa5U=;
  b=V1poFisgZYO506BxsEMgBxa0fb8IOZHd6kRmZ97r7JCyOg9DqSQaBiL/
   OZ0bhwuOaE6YaawzkiO3ah7WFGVUz4KUzWH/V/DMnNctihSCEthbYzXaM
   NNHviVo4Qf02XUgrZ5PiRx8fV3Ztzpf2r5D6nwctlphFSS5tzchn5260n
   vE2O8G/vpbHsDS6gIXFKaerjPKmA1JGDJU8dA5oNdjJKwkCYxWVoOklYa
   NkH2FpSg4BvIF3LxLxxMBnABluvi/fdezMT+CrVa/163mSQRJIsjmFW59
   PDkR09wKmvxzRa4qC7eQ9/fk7TgSJbOl1lh7tnAB9ITWcit1rrtcfiNw+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="299983156"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="299983156"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 21:26:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="641492265"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="641492265"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 15 Nov 2022 21:26:36 -0800
Message-ID: <a1e899b2-4e96-1b3c-27b1-cc29d629e3ea@linux.intel.com>
Date: Wed, 16 Nov 2022 13:19:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH v2] iommu/vt-d: Set SRE bit when hardware has SRS cap
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20221115070346.1112273-1-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221115070346.1112273-1-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/22 3:03 PM, Tina Zhang wrote:
> SRS cap is the hardware cap telling if the hardware IOMMU can support
> requests seeking supervisor privilege or not. SRE bit in scalable-mode
> PASID table entry is treated as Reserved(0) for implementation not
> supporting SRS cap.
> 
> Checking SRS cap before setting SRE bit can avoid the non-recoverable
> fault of "Non-zero reserved field set in PASID Table Entry" caused by
> setting SRE bit while there is no SRS cap support.
> 
> V2: Add SRS cap checking in intel_pasid_setup_second_level()
> 
> Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table interface")
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>

Patch queued for v6.1. Thank you!

https://lore.kernel.org/linux-iommu/20221116051544.26540-1-baolu.lu@linux.intel.com/

Best regards,
baolu
