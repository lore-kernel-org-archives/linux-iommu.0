Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FBAAD4B
	for <iommu@lists.linux.dev>; Tue, 29 Nov 2022 17:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669744473; x=1701280473;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eWmuqTFqNsAoet0OLkvih5/7bcZ+zSGLf0yM6dcoYG4=;
  b=QQa281WG+hzqaYQRO/sqRwZoXWZDu61ChX4WuwCpuGlm1XXQQZi1U2XR
   yAxhSlsb7djzk4HqD2030kBT3hJPmzKe+RhUPjc9qrpip0d+8wHUdlWLN
   XXtEhrgkqBYtWZ0/N5AQN5bx+DvspRqW3HxlG8Iy1Jb8ZlgYJwMaOWfPp
   lfga5U5ybzIA5hOEKpo9invWTDrGpi1HbZ1MceSAN8hCL5YfMNEUGh/SS
   6AXRWMxQl+RTS7ZVEVwSGnE1nO7WIycpdMCxXxVGQPGMxTT/ZUvWyd0EK
   wsw+9IpKbD/YezgFP1NSYXzGDq3gxKTKgYAa+qMIGr//1ysj2WmLLz/Hp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="294879774"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="294879774"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:54:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="732650483"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="732650483"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:54:32 -0800
Date: Tue, 29 Nov 2022 09:58:23 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML
 <linux-kernel@vger.kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg
 Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Robin
 Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "Luo, Yuzhang"
 <yuzhang.luo@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2] iommu/vt-d: Add a fix for devices need extra dtlb
 flush
Message-ID: <20221129095823.3009552a@jacob-builder>
In-Reply-To: <BL1PR11MB52716203AF9CC7CADDAC0B4D8C129@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20221128170410.3830605-1-jacob.jun.pan@linux.intel.com>
	<BL1PR11MB52716203AF9CC7CADDAC0B4D8C129@BL1PR11MB5271.namprd11.prod.outlook.com>
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

On Tue, 29 Nov 2022 02:37:45 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, November 29, 2022 1:04 AM
> >
> > +void quirk_dev_tlb(struct device_domain_info *info, unsigned long
> > address,
> > +		   unsigned long mask, u32 pasid, u16 qdep)  
> 
> quirk_extra_dtlb_flush()
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
will do in the next version!

Thanks,

Jacob
