Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31021374EA
	for <iommu@lists.linux.dev>; Sun, 18 May 2025 06:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747550755; cv=none; b=YJljnqyFOw60hsbELoqJY/int9E039WA3HqKTC77nA7S7vFrlJdl1BXN+HO2VE2woAqTfKA+OnmX2XcbrACiRgwoxC8J95GMD4ks4+ujEt7TRT3mtHi0Ap2zpvYIUvOhLges1PFmPXJ2swC51wVuhrcsu/cWu/yOLN8zeytK5Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747550755; c=relaxed/simple;
	bh=7RlvzbsKw/dgUSnuBT6EgZlFvU9rYAcIaBft9As+m1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYgx5gsvF9MK2sUHmiFCiPuRCicBQ3LJuhZbmqLeHCxvuLobfBCQcUFsxdtnZjPevyi3toqHvJ8KVsYIk/fB3JdOR8HPtvLyU8h4dvt024LiDduOsdVMfBVFzE0KuazCU6sYH+mr5lJ6pZDDK0bTW0qiH2rQ/9t54dHnBjCB0a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GosMxN7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GosMxN7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BDFC4CEE7;
	Sun, 18 May 2025 06:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747550754;
	bh=7RlvzbsKw/dgUSnuBT6EgZlFvU9rYAcIaBft9As+m1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GosMxN7quxZAUvwGIz+CMqVK1FPj8SUEMlg8FoZvirpfDG5WcZ7CkYC2F0j4QFADP
	 Gzb9nxHnoYSKL0E/xoXfZRUB4lbcGHNfZ2xSglf+k0qdbn22/YLRzLTxWRrGpyHp2l
	 lrbzwjoMK5JNYLGqiI7KR99pILVrGxs7K3GIvz0ABxP4oqRHT/yBHJuKtScfEVN3I6
	 ZLtS+hMXAWLoKxTIYypY347rUbSFfIbd6/I1tp3AjCrj0kDkvkLgEiuk2iaH5U4U99
	 OmoP5G2yTkOEJ636/zT4sE7okerSG5YL8Q77C/8zMlcZNh1SJBvyZr2JqEqxMGb10c
	 i443PmsfLPDyA==
Date: Sun, 18 May 2025 09:45:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"Saarinen, Jani" <jani.saarinen@intel.com>,
	"Nikula, Jani" <jani.nikula@intel.com>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"De Marchi, Lucas" <lucas.demarchi@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [REGRESSION] on linux-next (next-20250507)
Message-ID: <20250518064550.GD7435@unreal>
References: <SJ1PR11MB61292CE72D7BE06B8810021CB997A@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250512122102.GF5657@nvidia.com>
 <SJ1PR11MB61292A304C9FA6BF92B568A3B991A@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250518061703.GB7435@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250518061703.GB7435@unreal>

On Sun, May 18, 2025 at 09:17:03AM +0300, Leon Romanovsky wrote:
> On Wed, May 14, 2025 at 12:40:02PM +0000, Borah, Chaitanya Kumar wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Monday, May 12, 2025 5:51 PM
> > > To: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
> > > Cc: intel-xe@lists.freedesktop.org; intel-gfx@lists.freedesktop.org; Saarinen,
> > > Jani <jani.saarinen@intel.com>; Nikula, Jani <jani.nikula@intel.com>; Kurmi,
> > > Suresh Kumar <suresh.kumar.kurmi@intel.com>; De Marchi, Lucas
> > > <lucas.demarchi@intel.com>; iommu@lists.linux.dev
> > > Subject: Re: [REGRESSION] on linux-next (next-20250507)
> > > 
> > > On Mon, May 12, 2025 at 06:00:39AM +0000, Borah, Chaitanya Kumar
> > > wrote:
> > > 
> > > > ``````````````````````````````````````````````````````````````````````
> > > > ```````````````````````````````````
> > > > commit 13f43d7cf3e0570004a0d960bc1be23db827c2ff
> > > > Author: Jason Gunthorpe mailto:jgg@nvidia.com
> > > > Date:   Tue Apr 8 13:53:56 2025 -0300
> > > >
> > > >     iommu/pages: Formalize the freelist API
> > > > ``````````````````````````````````````````````````````````````````````
> > > > ```````````````````````````````````
> > > >
> > > > We could not revert the patch because of merge conflicts but resetting to the
> > > parent of the commit seems to fix the issue.
> > > >
> > > > Could you please check why the patch causes this regression and provide a
> > > fix if necessary?
> > > 
> > > Could this be the solution?
> > 
> > Apologies for the delay, this change seems to solve the issue. Can we expect a patch soon?
> 
> Jason is on vacation this week. I recommend to submit the patch by itself.

It was already sent and applied.
https://lore.kernel.org/all/0-v1-7d4dfa6140f7+11f04-iommu_freelist_init_jgg@nvidia.com

Thanks

> 
> Thanks
> 
> > 
> > Regards
> > 
> > Chaitanya
> > 
> > > 
> > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > > index 0af1ab36283cba..7d2b51a890c75a 100644
> > > --- a/drivers/iommu/dma-iommu.c
> > > +++ b/drivers/iommu/dma-iommu.c
> > > @@ -154,6 +154,8 @@ static void fq_ring_free_locked(struct
> > > iommu_dma_cookie *cookie, struct iova_fq
> > >  			       fq->entries[idx].iova_pfn,
> > >  			       fq->entries[idx].pages);
> > > 
> > > +		fq->entries[idx].freelist =
> > > +			IOMMU_PAGES_LIST_INIT(fq->entries[idx].freelist);
> > >  		fq->head = (fq->head + 1) & fq->mod_mask;
> > >  	}
> > >  }
> > > 
> > > Jason
> 
