Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5B79EC
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 16:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676651343; x=1708187343;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WqzXDxoShDpdbm4A3JDCwL+WgDDdcPspdLN0ZTbEwDo=;
  b=hilViqaHpx97s4R9EmC7vECsJPfcb47qfoLt7RsEQd/g5oSWUVpKAF1s
   4GSlSsp3ZD89h/0oL7yvy24tVsdw+R4PYE6/IskNUINZQLEHOa7GAnQ+t
   YAVzneIfujjSVvn6pe6p/HrW2Vdliy83/JCzM37+nTy76UcCqPN0GvmGN
   27AMSgc7lDR22tp9FzwkTCRVYqqaMICURhcRlVAf2JHRRVo722sxSMz9b
   jaSJhBR5HES9hsMC8hAAcvG6e/NYZu+PxhN9819HuBX9/HchCq/4QaIMn
   T4LPnfJ6MXp0ygdivlJVv+JmH9Tu9uFKMJKSDem2rkxhBiv57ZZmus3WD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="320129355"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="320129355"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 08:28:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="999493226"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="999493226"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 08:28:58 -0800
Date: Fri, 17 Feb 2023 08:32:40 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, Jason
 Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg
 Roedel <joro@8bytes.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, Dave Hansen
 <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, X86 Kernel
 <x86@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 4/5] iommu/ioasid: Rename INVALID_IOASID
Message-ID: <20230217083240.147d2c76@jacob-builder>
In-Reply-To: <25fbbc7f-f137-c2c4-ddf8-d143fce1dcc5@intel.com>
References: <20230216235951.3573059-1-jacob.jun.pan@linux.intel.com>
	<20230216235951.3573059-5-jacob.jun.pan@linux.intel.com>
	<25fbbc7f-f137-c2c4-ddf8-d143fce1dcc5@intel.com>
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

Hi Fenghua,

On Thu, 16 Feb 2023 17:23:15 -0800, Fenghua Yu <fenghua.yu@intel.com> wrote:

> > --- a/drivers/dma/idxd/irq.c
> > +++ b/drivers/dma/idxd/irq.c
> > @@ -80,7 +80,7 @@ static void idxd_int_handle_revoke_drain(struct
> > idxd_irq_entry *ie) desc.opcode = DSA_OPCODE_DRAIN;
> >   	desc.priv = 1;
> >   
> > -	if (ie->pasid != INVALID_IOASID)
> > +	if (ie->pasid != IOMMU_PASID_INVALID)  
> 
> It's better to change to:
> +	if (pasid_valid(ie->paid))
> 
> If pasid_vaild() is called, any invalid PASID value change in the future 
> will be hidden in pasid_valid() and won't impact this code any more.
> 
> And checking pasid_valid() is more readable and meaninful than direct 
> checking the invalid PASID value.
Sounds good, here I'm just renaming. I will submit another patch to
convert.

Thanks,

Jacob
