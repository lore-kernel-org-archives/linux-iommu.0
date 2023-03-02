Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4B8C11
	for <iommu@lists.linux.dev>; Thu,  2 Mar 2023 17:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677777562; x=1709313562;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t6Bmp0fFrnUCAiBWt37tkMKRrr79WxRyKdKg/hHFkKg=;
  b=NaBkTcAU7tdLy2RfP3iodlo5NckgeVEwDH9wiAk0ihbkz9sEMyzQJ9+i
   gCkkH0KmOGewr5stGPufKx2i85dUFmXznsw/ZfmfjDZjLESj0w4ZTTLc8
   0Dbu3edExg93KYjleZ8ICNiITWiwRiV+bb8XSEaNLus+2NNPOxVAggsSb
   e229dW3JMQFC9BAd/0I+X9yZcDeiBL9F8lG3hd26FQFjskbPguX/+T6Ro
   1gdD4KgcDhzchQ0R3hHxblRdHQe3VOh4ydEcmkF4EhQ2hoSsPMtRIey9G
   D8b4p9aEvTbRpykGnhNcmJqYmKhhX0/wJhlBolD55lehJjmdVNOvIiOdq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="333508782"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="333508782"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 09:19:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="849150513"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="849150513"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 09:19:21 -0800
Date: Thu, 2 Mar 2023 09:23:10 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Tina Zhang <tina.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, Jason
 Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg
 Roedel <joro@8bytes.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Dave Hansen" <dave.hansen@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, "X86 Kernel" <x86@kernel.org>, <bp@alien8.de>, "H.
 Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 <corbet@lwn.net>, <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, Will
 Deacon <will@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, Raj
 Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230302092310.77f97361@jacob-builder>
In-Reply-To: <43e9711f-042e-eaf9-e091-07db78cad943@intel.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
	<20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
	<43e9711f-042e-eaf9-e091-07db78cad943@intel.com>
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

Hi Tina,

On Thu, 2 Mar 2023 21:52:42 +0800, Tina Zhang <tina.zhang@intel.com> wrote:

> >   		if (mm->pasid < min || mm->pasid >= max)  
> Here seems not right, since the valid range is defined [min, max]. 
> Shouldn't the invalid range be:
> 		if (mm->pasid < min || mm->pasid > max)
yes it is better to be consistent even if we removed the inclusive
requirements in the previous comments.

Thanks,

Jacob
