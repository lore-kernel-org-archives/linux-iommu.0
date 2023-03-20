Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2646B7
	for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 20:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679344493; x=1710880493;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xhl0RgABhwMl2wPVtTOZVbAXgf0Te8pbChDi1La+ZXA=;
  b=ms7iDjcfBa9gRoMpZGmjhylcbSzSc69pW0uyUzs8ZYtd4usXiyLi8yyR
   k0+rMpaDD0j7SJlmxX9pJ6LDJIMCMTpm5gE3JvRdi36OgDDV2hluOPMgt
   iNBzcqRGXhAKWfBqNDRmTkI/bcPj00xoPfzAbrVQh/4GDoGTU0Rn4dSYj
   V1F2LwVcfd9k5TEErDIYVviDOAPLNwvcAbvZx1SmUV8HjxQhMUvcrrSNi
   raLOn9A/yTmzInZgp7AlGc8NzLU97tMXWUAcyk5862GYE9Pn/o8TF6cDg
   r6MlzrKyiKfOvW9xDLvSXfEs2k74QPHZa1eK1jCJLWTXBphgdaNCFGLTW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="322614565"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="322614565"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 13:34:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="658504127"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="658504127"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 13:34:53 -0700
Date: Mon, 20 Mar 2023 13:38:52 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Jason
 Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg
 Roedel <joro@8bytes.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Robin Murphy <robin.murphy@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 X86 Kernel <x86@kernel.org>, bp@alien8.de, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
 vkoul@kernel.org, dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Raj
 Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v7 6/7] iommu/ioasid: Rename INVALID_IOASID
Message-ID: <20230320133852.7535292d@jacob-builder>
In-Reply-To: <b1a380ad-50b4-4a00-2480-ac4d1542c71f@intel.com>
References: <20230320185910.2643260-1-jacob.jun.pan@linux.intel.com>
	<20230320185910.2643260-7-jacob.jun.pan@linux.intel.com>
	<b1a380ad-50b4-4a00-2480-ac4d1542c71f@intel.com>
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

Hi Dave,

On Mon, 20 Mar 2023 11:58:14 -0700, Dave Hansen <dave.hansen@intel.com>
wrote:

> On 3/20/23 11:59, Jacob Pan wrote:
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -40,7 +40,10 @@
> >  #include <linux/io.h>
> >  #include <linux/hardirq.h>
> >  #include <linux/atomic.h>
> > -#include <linux/ioasid.h>
> > +
> > +#ifdef CONFIG_IOMMU_SVA
> > +#include <linux/iommu.h>
> > +#endif  
> 
> What's the deal with the #ifdef'd #include?
> 
> What's the harm of just making it unconditional?
No harm for this version. I will remove.

Thanks,

Jacob
