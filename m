Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395F2CA5
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676410213; x=1707946213;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7A6xUgg1KlIcBAaPTam1mZddqUhKOilo6t8rJoPOkyc=;
  b=jbiYPvCt9roxG+wCR/Ykq2BvnRXPl/tGkQEoX66EKoYqK0M7mk6Ai9uY
   R15pMkKZMS9ytFmJ77jvaWlRkuWavF0iwp7a2vQmNpUuoCKw7gvnAH3It
   iOHt6F3y3IWkB5MwoSLRxGWjZ17kOjeBgWd4xgyhrDaj+pL0zfWQMjdke
   YCLlFTV1EbLM9CZMT1w/nWepa42Le7f8L00FFzMpx+H8xrJmEdUqjj2zQ
   h0lpMus6kRT+bTjMUpSBQYot3jWPxCPdOT/amRFpC//3im0WBbFFwhy5e
   J7E9ggl+DCJOYjnC1RUHltcHblJ/94zSdPEQNDMN6ETQ/UMqL/aNEfwzM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="329902985"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="329902985"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 13:30:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="646912439"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="646912439"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 13:30:12 -0800
Date: Tue, 14 Feb 2023 13:33:52 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, LKML
 <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Jean-Philippe
 Brucker <jean-philippe@linaro.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Raj
 Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 3/3] iommu: Remove ioasid infrastructure
Message-ID: <20230214133352.1f69b624@jacob-builder>
In-Reply-To: <Y+vLiWS3+Rp+If6U@nvidia.com>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
	<20230214064414.1038058-4-jacob.jun.pan@linux.intel.com>
	<Y+tVMRzRQbcc7Guz@myrica>
	<Y+uHSry/tpgGNr/b@nvidia.com>
	<20230214093107.323d7e76@jacob-builder>
	<Y+vLiWS3+Rp+If6U@nvidia.com>
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

On Tue, 14 Feb 2023 13:57:29 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Feb 14, 2023 at 09:31:07AM -0800, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Tue, 14 Feb 2023 09:06:18 -0400, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Tue, Feb 14, 2023 at 09:32:33AM +0000, Jean-Philippe Brucker
> > > wrote:  
> > > > > diff --git a/include/uapi/linux/iommu.h
> > > > > b/include/uapi/linux/iommu.h index 65d8b0234f69..a95f07f0c98c
> > > > > 100644 --- a/include/uapi/linux/iommu.h
> > > > > +++ b/include/uapi/linux/iommu.h
> > > > > @@ -157,5 +157,6 @@ struct iommu_page_response {
> > > > >  	__u32	grpid;
> > > > >  	__u32	code;
> > > > >  };
> > > > > +#define IOMMU_PASID_INVALID	(-1U)    
> > > > 
> > > > Why change UAPI?    
> > > 
> > > There is no uapi, this whole file needs to be deleted too
> > >   
> > ok. another clean up.
> > 
> > As I also replied to Jean, I ran into a circular #include problem if
> > mm.h #include iommu.h, I guess I could also create another header, e.g.
> > iommu_defs.h to avoid it. any other suggestions?  
> 
> Given this header is not used, just delete things from it to resolve
> the problem?
no, sorry i didn't make it clear. I meant if we do #include <linux/iommu.h>
in sched/mm.h, then I got circular include problem.

The problem is not with include/uapi/linux/iommu.h

I could fix it by adding another header include/linux/iommu_defs.h for
#define IOMMU_PASID_INVALID	(-1U) 
But it feels like an overkill.

Thanks,

Jacob
