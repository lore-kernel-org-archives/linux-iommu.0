Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C744A94D
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680020896; x=1711556896;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PutlLLRQ0cjX+4MJOODPdoxCIDXtRmBjpz7PWw8bXP8=;
  b=VXIcrg7LLgzv7B7G/ODF61a4PR/RlZCLO5LquEieFOnyfjzAgXtX5k+d
   +XJv77yMeBW9qX3mfx0QlAidaSxEH/op6Px2uni8fo8NgwqSTVWuy+AuT
   /Ib0Ybs4d0OKpfdaQy762swFUV+MASuADAaJDU87UHNKCTRGHpvvfWixM
   x/Dxn6UNSIj5hMsAYZjjeYguwjdm7mtalrqfswbhb8ipg7Ktpg2Hvx9kl
   YrozW/abCP0JPYBh9ktwWO20sK/8i2gGzYjsh2gQPFZTyVIgNsKLRXdHr
   J3oVpCHyu4hETm7IWE6EWgXIVGuxxq++AiItUhc9V2tZkI9TOo8znvDha
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405558063"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="405558063"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:28:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="683957590"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="683957590"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:28:13 -0700
Date: Tue, 28 Mar 2023 09:32:16 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, LKML
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 3/8] iommu/sva: Support reservation of global SVA
 PASIDs
Message-ID: <20230328093216.1c7afc1f@jacob-builder>
In-Reply-To: <ZCMN/LhCgDfwz+Z/@nvidia.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
	<20230327232138.1490712-4-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB527652D88D15437F52FCE8268C889@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20230328083110.294a327c@jacob-builder>
	<ZCMN/LhCgDfwz+Z/@nvidia.com>
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

On Tue, 28 Mar 2023 12:55:40 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 28, 2023 at 08:31:10AM -0700, Jacob Pan wrote:
> 
> > > this would be future proof when the same driver starts to allocate
> > > more pasids for other usages e..g siov.  
> > I don't have strong preference here. Jason and others?  
> 
> Oh I'm all for getting the word SVA out of the PASID infrastructure.
> 
> SVA has nothing to do with PASID other than it requires it to work.
> 
I will move pasid allocation code to iommu.c then.

Thanks,

Jacob
