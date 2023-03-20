Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE244C7D
	for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 18:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679338696; x=1710874696;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RVUBV13vg50kKjzvJu8eWgLIZUCC4rAeEXycCUsrUFE=;
  b=iwDfAEvwKYFlkNuZwt6iSPvrpWUswKvskfc+7bqA2y1iJ5y6WCy5SZyV
   Mc3tR0Wi25pmKMTsaTOP+0PwMISKt/3Mc5B+zcYUitv1tZF2YgA+4VtY7
   DD3fnQsyN6vK5uj5Wd05RSS3NAII9szbr8hSJ4vtu71eR4l8ndrrIy+Y8
   5O99EMoFY+iEYe1/YGa9SNycthRDuKDS/0FJgC0m7+kScZf4QZWzRfCoh
   9b3IBeKA8WMRj6d4QTP4wNtYkGSe1lwAfPwOxusfzbDYt1R4SfrToI7dK
   1stoBqe/2gk74nBR1Xd6s1vbwxnOLbd9T6tHyKA6YQCOIFC8UFQ6zr8zs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="338777332"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="338777332"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="855346805"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="855346805"
Received: from vrchili-mobl2.amr.corp.intel.com (HELO [10.209.117.85]) ([10.209.117.85])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:58:15 -0700
Message-ID: <b1a380ad-50b4-4a00-2480-ac4d1542c71f@intel.com>
Date: Mon, 20 Mar 2023 11:58:14 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 6/7] iommu/ioasid: Rename INVALID_IOASID
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Robin Murphy <robin.murphy@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 X86 Kernel <x86@kernel.org>, bp@alien8.de, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net, vkoul@kernel.org,
 dmaengine@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>
References: <20230320185910.2643260-1-jacob.jun.pan@linux.intel.com>
 <20230320185910.2643260-7-jacob.jun.pan@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230320185910.2643260-7-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/23 11:59, Jacob Pan wrote:
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -40,7 +40,10 @@
>  #include <linux/io.h>
>  #include <linux/hardirq.h>
>  #include <linux/atomic.h>
> -#include <linux/ioasid.h>
> +
> +#ifdef CONFIG_IOMMU_SVA
> +#include <linux/iommu.h>
> +#endif

What's the deal with the #ifdef'd #include?

What's the harm of just making it unconditional?

