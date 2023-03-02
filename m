Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3C8C10
	for <iommu@lists.linux.dev>; Thu,  2 Mar 2023 16:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677775435; x=1709311435;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZVR0fEMxC1xCM/KNPaB7wfbb6IVdTmO+3FaxenBdqhA=;
  b=PAigMWcO8ATw/2yI+79k0XOdnMFSZJ5XwMYi/aHp/earOXD8ve4ybNZl
   HmauD6/A447LjDfnxbtKJDJ6mdjx0rnA37Ls/OWVYiTUz2HDTNlQnRCnp
   fS38ptYdfllUTI8t46rgaddgVWf3rreXaiE2juf50K87VBN0Kgu4CueD7
   AJ9ug9nvpJ+KrMpG0PCenFnKwcxT6jg59/ORkRhze9jgDhwwigt5GO2mx
   x9QFQQc1WTun/lVUr41NvfxPKvuKAxN4wwEM8AkNG6KMPfAuLpGyMZIrf
   fIwL61yyEjeEzrvj9df5JgT9suXPbbwiFoBoSBx3aO+FXqw/uW6xHF5Ww
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="334801858"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="334801858"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 08:43:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="668314513"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="668314513"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 08:43:50 -0800
Date: Thu, 2 Mar 2023 08:47:39 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.com>, "Hansen, Dave"
 <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, X86 Kernel
 <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "H. Peter Anvin"
 <hpa@zytor.com>, "Peter Zijlstra" <peterz@infradead.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "vkoul@kernel.org" <vkoul@kernel.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "David Woodhouse"
 <dwmw2@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave"
 <dave.jiang@intel.com>, Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 2/6] iommu/sva: Move PASID helpers to sva code
Message-ID: <20230302084518.33712064@jacob-builder>
In-Reply-To: <BN9PR11MB5276E466C33CB6240B06B0728CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-3-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276E466C33CB6240B06B0728CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
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

Hi Kevin,

On Thu, 2 Mar 2023 09:03:52 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, March 2, 2023 7:57 AM
> >
> > -static inline void mm_pasid_drop(struct mm_struct *mm)
> > -{
> > -	if (pasid_valid(mm->pasid)) {
> > -		ioasid_free(mm->pasid);
> > -		mm->pasid = INVALID_IOASID;
> > -	}
> > -}
> > +void mm_pasid_drop(struct mm_struct *mm);  
> 
> Is it good to have a function declared in a header file of one
> subsystem while being implemented in another subsystem?
Good point!  I will move it to iommu_helper.h

Thanks,

Jacob
