Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE968BFB
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680017774; x=1711553774;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xbE93YN0zae2+8ft70/75Up7UaulvpFbU76HZ3jAYPY=;
  b=WZEcz/xcLGbah91+5mroBXa5B5ZC6u+bfG+uDZPjgCIDfIZWMQEcan8Z
   07V2q2DhOlypfEGaMYBGGlwJ9PbcjOd+rXblAy1sIcy3W9DEAGE6Y/7kR
   Slotd9PKen3/LYmRsmTEJ6g/TLlGWJhRmVda2Ku5XEcsStzHgQjfRKlKQ
   OUFH1EOW00RcY+dIF9JGZBP0jlWnuNg7sMqKx4YjHiDem69AEzxgRS88g
   gBBD9MjVLq5jfIDjvUg1hJFQ8imZVNqOIQGulNvCyNIL1SjR+kK8Gm1Ej
   AjDLjQ9L1e5SqP/kL1umIgTwaykxpYttCkFtvHKmvuaNPfhO1h3nq4Kpn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="324499057"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="324499057"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:36:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="827504413"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="827504413"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:36:13 -0700
Date: Tue, 28 Mar 2023 08:40:15 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "vkoul@kernel.org"
 <vkoul@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon
 <will@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Raj, Ashok"
 <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Yu, Fenghua"
 <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Luck, Tony"
 <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 6/8] iommu/vt-d: Implement set_dev_pasid domain op
Message-ID: <20230328084015.5c8c08ca@jacob-builder>
In-Reply-To: <BN9PR11MB5276B3FF6D21608BB17E32A18C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
	<20230327232138.1490712-7-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB5276B3FF6D21608BB17E32A18C889@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Tue, 28 Mar 2023 07:47:45 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, March 28, 2023 7:22 AM
> > 
> > Devices that use ENQCMDS to submit work on buffers mapped by DMA API
> > must attach a PASID to the default domain of the device. In preparation
> > for this use case, this patch implements set_dev_pasid() for the
> > default_domain_ops. Besides PASID attachment, device will also be
> > attached to the domain as the result of this call if the device has not
> > been attached before.
> >   
> 
> I didn't get the last point. PASID attach should only have the scope
> for the pasid. RID of the device might be attached to another domain
> which shouldn't be changed by this call.
I meant if the RID context has not been set up before attaching this PASID,
this call will also set up the context, PASID dir etc. In the end, we
eliminated ordering requirement of attaching device, RID_PASID first, then
other PASIDs.
How about:
"If the device context has not been set up prior to this call, this will
set up the device context in addition to PASID attachment."

Thanks,

Jacob
