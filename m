Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98031C17
	for <iommu@lists.linux.dev>; Wed, 22 Feb 2023 06:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677046523; x=1708582523;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZeXJ7DB5YT2ntkxG4DK0XkeNPwdLeW8BHoIQ2ji0wqc=;
  b=OiHME6xm6FpkkuV6GAK7KLRjVzRI7asdWMkiCOGSqGyWBgHlxiUKtsP2
   0FAhIB0V0Uoqqy2btG7KVMFlXAWxCAEWzCPI30U1Wm9kp3uGHqqBv6Ku5
   /eEY1b77YQUSOYrUEXJd4D78mRqpPVK0AY69Aqs4SpvpEft8EH/s25Nxi
   Xt5fOLCjCSR0c5M2XN35PqJUwzXx1J1rbD/widQSdhsqQbyJt7dfn/LfD
   hZXbkwYu7AeKyflw/SjxdjGmYlNaVdvo4iJC9AgtGAAqbR4HtSgQGdvYF
   TuQBmw5PoMw/arWmsPwA2y42XhkRqqAstjkjI6zn2S2V6ndnl9b/gZHnp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334210579"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="334210579"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 22:15:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="1000881310"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="1000881310"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 22:15:21 -0800
Date: Tue, 21 Feb 2023 22:19:05 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "X86 Kernel" <x86@kernel.org>,
 "Jiang, Dave" <dave.jiang@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 3/5] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230221221905.4759b2ac@jacob-builder>
In-Reply-To: <BN9PR11MB5276EC1F0926256D0E8F05F58CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230216235951.3573059-1-jacob.jun.pan@linux.intel.com>
	<20230216235951.3573059-4-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB5276EC1F0926256D0E8F05F58CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Wed, 22 Feb 2023 02:22:48 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Friday, February 17, 2023 8:00 AM
> >
> > +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
> > GFP_KERNEL);
> > +	if (ret < min)
> > +		goto out;  
> 
> ioasid_alloc() currently uses GFP_ATOMIC.
> 
> since this is kind of a replacement w/o functional impact, it'd be cleaner
> from bisect p.o.v. to have a separate patch changing GFP_ATOMIC
> to GFP_KERNEL in ioasid_alloc() and then this patch.
> 
makes sense,

Thanks,

Jacob
