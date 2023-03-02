Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939029B0
	for <iommu@lists.linux.dev>; Thu,  2 Mar 2023 13:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677762435; x=1709298435;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DRzuInPRniRNKBDiqDiQiPwsC6T8LD9EoJ4P/cy5hX0=;
  b=iv8V4hAiUI6RPw6E+zvADlIafiK7FcVbZ5hRHHP0M+uvfoXLPtSGXAkW
   br1bkOvphpdUG+3duqPBWg98ldLYnSRPMsqp5rfcdGXK3bHnshAvpMZpS
   +U3NrPlw8uhK+o2NHNsdsNnWOfO157yzSY1qawk5FMJuc4/i3bL7Jhvm0
   K8tv68olIR75j6qam47EUb+MdSG1fgjbzZAuMAGOYTBtVf/EmWypVr/iA
   ZQtU2faNVt2bzvhhBdUDmWtux6SDgTx9obz23pGsLXfDYbV2ceoHDpJst
   tEs2NOsLE7n76fXdr+cCtzlOf+UYT81Vdwxfi3oE9YOeYobklGFO03BRR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="314376876"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="314376876"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 05:07:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="739071608"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="739071608"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.218]) ([10.254.214.218])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 05:07:08 -0800
Message-ID: <8b4c5311-016f-68e3-c796-5060042e062e@linux.intel.com>
Date: Thu, 2 Mar 2023 21:07:06 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 5/6] iommu/ioasid: Rename INVALID_IOASID
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 X86 Kernel <x86@kernel.org>, bp@alien8.de, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net, vkoul@kernel.org,
 dmaengine@vger.kernel.org, linux-doc@vger.kernel.org
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-6-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230301235646.2692846-6-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/2 7:56, Jacob Pan wrote:
> INVALID_IOASID and IOMMU_PASID_INVALID are duplicated. Rename
> INVALID_IOASID and consolidate since we are moving away from IOASID
> infrastructure.
> 
> Reviewed-by: Dave Jiang<dave.jiang@intel.com>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
