Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286474C6C
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 23:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661210503; x=1692746503;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TKnRFyZojBDepq0MeETIBlamkN8wx2nn6IJckBft1yI=;
  b=mA8xPs7qgyTXLV4ujfag7Na+FR2YhPV6ZM43DtXK516zYLmLqZi9Yl/5
   Z14fzY2FCFgaSjF2HSA4nob+B61IIUo7NRk57tms9tI/fVBUaZYiiawhl
   AAQZaSY/38xTTLtH+klNNWd1vx+eCfV+OyMH31i2xHzbtGdqrmfYye2Di
   OcB1xcfnmBCMt5Gpri2LCwkXiShPJuPbJcBotXkmv1LsaZStsQhMzKb94
   qOvpXSKNzfkIfW0lJrbfR9mH8IkzdXq9nhW+D7jwDo68hiiUFqpmnaAZX
   pUlwJqYUt6+iU+k36yWUwD7DMMjgs9/b+hP9LABpg72xBEv2Cc19NsN9E
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="379834262"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="379834262"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 16:21:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="559935988"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 16:21:42 -0700
Date: Mon, 22 Aug 2022 16:24:54 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 x86@kernel.org, Joerg Roedel <joro@8bytes.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, Raj Ashok <ashok.raj@intel.com>, Thomas
 Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Ingo Molnar
 <mingo@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/2] iommu: Use the user PGD for SVA if PTI is enabled
Message-ID: <20220822162454.490ad1f2@jacob-builder>
In-Reply-To: <09bccb93-2c0e-4962-0c46-c84c22fa140d@intel.com>
References: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
	<20220822201213.352289-3-jacob.jun.pan@linux.intel.com>
	<09bccb93-2c0e-4962-0c46-c84c22fa140d@intel.com>
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

On Mon, 22 Aug 2022 15:31:20 -0700, Dave Hansen <dave.hansen@intel.com>
wrote:

> On 8/22/22 13:12, Jacob Pan wrote:
> > @@ -394,7 +395,9 @@ static struct iommu_sva *intel_svm_bind_mm(struct
> > intel_iommu *iommu, sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
> >  			PASID_FLAG_SUPERVISOR_MODE : 0;
> >  	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ?
> > PASID_FLAG_FL5LP : 0;
> > -	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd,
> > mm->pasid, +
> > +	pgd = static_cpu_has(X86_FEATURE_PTI) ?
> > kernel_to_user_pgdp(mm->pgd) : mm->pgd;
> > +	ret = intel_pasid_setup_first_level(iommu, dev, pgd, mm->pasid,
> >  					    FLPT_DEFAULT_DID, sflags);
> >  
> 
> This X86_FEATURE_PTI should really be done within a helper.
> 
> I'd probably do this with a *new* helper since all of the existing
> kernel_to_user_pgdp() users seem to be within a PTI #ifdef.
> 
> Maybe something like:
> 
> pgd_t *mm_user_pgd(struct mm_struct *mm)
> {
> #ifdef CONFIG_PAGE_TABLE_ISOLATION
> 	if (cpu_feature_enabled(X86_FEATURE_PTI))
> 		return kernel_to_user_pgdp(mm->pgd);
> #endif
> 	return mm->pgd;
> }
> 
Sounds good. I thought about a helper also, thinking there are so many other
cpu_has(X86_FEATURE_PTI) checks already :)

> That #ifdef could even go away if your kernel_to_user_pgdp() stub from
> patch 1/2 was available.  I'm not sure it's worth it though.
I will remove 1/2 and keep the uniform style of the existing helpers.

Thanks for the suggestion,

Jacob
