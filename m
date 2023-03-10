Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A197C957
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 19:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678475957; x=1710011957;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6TjAizJZ0Z7OgkuuCfD17cXy68nJRib2Dg7u3RNtp2M=;
  b=YvK/8rPREpG2fyj8gM8EspTWhmROP4ZytduESAb04xehU0y1egYPcqck
   LUNilkTM9x6rpVB0t6My3jf59TIdqPiLgpGfO1XLY++Hooz4yTNfOxFwr
   lcGTO51WxsBgYIiEJgUNplp87BNfixW/BDOyGBVLoOABiuPwV1E4uzYbw
   C+MKF04mh6C+QMuZkogljwvuu+9bg6YDzW6EeviV7MQbnfYdldvPEfpXb
   G6PXfQFthZC/qTiooBJmBjiJdStXZueL6nXAMhhKYXBNbDX+cgLl76gHT
   E/5HTeoLFTAo9KDrG4u8cGiDFJIcJ/gPjrBO+B215tt+IiGo42gy79YwH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="336830643"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="336830643"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 11:19:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="708122699"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="708122699"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 11:19:16 -0800
Date: Fri, 10 Mar 2023 11:23:09 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Jean-Philippe
 Brucker <jean-philippe@linaro.com>, Dave Hansen <dave.hansen@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, X86 Kernel <x86@kernel.org>,
 bp@alien8.de, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, corbet@lwn.net, vkoul@kernel.org,
 dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, David Woodhouse
 <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, "Yu, Fenghua"
 <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, Kirill Shutemov
 <kirill.shutemov@linux.intel.com>, Tony Luck <tony.luck@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 2/7] iommu/sva: Move PASID helpers to sva code
Message-ID: <20230310112309.024f6558@jacob-builder>
In-Reply-To: <ZAqLUG0uhACSMeXP@nvidia.com>
References: <20230309222159.487826-1-jacob.jun.pan@linux.intel.com>
	<20230309222159.487826-4-jacob.jun.pan@linux.intel.com>
	<ZAqLUG0uhACSMeXP@nvidia.com>
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

Hi Jason,

On Thu, 9 Mar 2023 21:43:44 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Mar 09, 2023 at 02:21:54PM -0800, Jacob Pan wrote:
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index 2a243616f222..f341a7a855e8 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -8,7 +8,7 @@
> >  #include <linux/mm_types.h>
> >  #include <linux/gfp.h>
> >  #include <linux/sync_core.h>
> > -#include <linux/ioasid.h>
> > +#include <linux/iommu-helper.h>  
> 
> Don't include this here, fork.cc is the only caller put the include
> there
make sense, will do.

Thanks,

Jacob
