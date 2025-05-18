Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D561E25EB
	for <iommu@lists.linux.dev>; Sun, 18 May 2025 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747549029; cv=none; b=JYN2Ndjtsuy9udmRdlvJdMuGVy3urEeHUOOb7c9A/LSjupixECLy9Zs4BxeTI7AadcB/av5Lg1LUbGVt2Uef3Ou4z6kS8rJWgLIQgSGSIoFio1/cP2ubC2VWoRP+ENXJguNaR6NT69xh9uVYyWhVJpASBAVaqQBRYJ7OAN5ntcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747549029; c=relaxed/simple;
	bh=wKeSZPSyX8iX4JyTNeOos4CzlBkoU40E/puTyBr7Mwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3ynqNnJL1VGCouXXC4uH5/MmKeY/uGpA4mO/bgWOiDusX0TJxKfJuMBE/Teaj+9UQohlYnSILwMrck/Q6BPNbElhxrfKY0ViIfuW8vzKFGwNxW//H4qeZxTLOCuDnpe12TfI4BXJ7NbLY1KQQTy4xeAur4QxLaNnTwEWvxQYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbLYb4vZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbLYb4vZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0205C4CEE9;
	Sun, 18 May 2025 06:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747549028;
	bh=wKeSZPSyX8iX4JyTNeOos4CzlBkoU40E/puTyBr7Mwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jbLYb4vZ/31WsfOV2ChI1GFIpYj5nJXEoUSOEAp8PCh1eHRJna9Et+eDvfrxQVPqV
	 4m6kcXNhZzAJGtNL0rWAf/8pTv/7p8LoEMkvns3VbVCY0Z8YMzVgcNT0iU7WbjkLYU
	 R35iW4Q0HYQSPRTmu5qnPt9Wz+oIAxKTgThhmrHdkLGmD20c2arat4Mic00afiIOO/
	 bhIJq0iAt/Pl0enB5YJYMo071YCEhlD1Tk1tcYTA+JPDpB5tP7kuweNDvfnDLRPU1o
	 YCW2xyTYwzGZcGA8kELQEi9UFx77xLPX03Z868Tv2aQKYrNl4zzE+JH/HEZ5wpAa/M
	 q65nhzUrHRDcw==
Date: Sun, 18 May 2025 09:17:03 +0300
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
Message-ID: <20250518061703.GB7435@unreal>
References: <SJ1PR11MB61292CE72D7BE06B8810021CB997A@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250512122102.GF5657@nvidia.com>
 <SJ1PR11MB61292A304C9FA6BF92B568A3B991A@SJ1PR11MB6129.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB61292A304C9FA6BF92B568A3B991A@SJ1PR11MB6129.namprd11.prod.outlook.com>

On Wed, May 14, 2025 at 12:40:02PM +0000, Borah, Chaitanya Kumar wrote:
> 
> 
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Monday, May 12, 2025 5:51 PM
> > To: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
> > Cc: intel-xe@lists.freedesktop.org; intel-gfx@lists.freedesktop.org; Saarinen,
> > Jani <jani.saarinen@intel.com>; Nikula, Jani <jani.nikula@intel.com>; Kurmi,
> > Suresh Kumar <suresh.kumar.kurmi@intel.com>; De Marchi, Lucas
> > <lucas.demarchi@intel.com>; iommu@lists.linux.dev
> > Subject: Re: [REGRESSION] on linux-next (next-20250507)
> > 
> > On Mon, May 12, 2025 at 06:00:39AM +0000, Borah, Chaitanya Kumar
> > wrote:
> > 
> > > ``````````````````````````````````````````````````````````````````````
> > > ```````````````````````````````````
> > > commit 13f43d7cf3e0570004a0d960bc1be23db827c2ff
> > > Author: Jason Gunthorpe mailto:jgg@nvidia.com
> > > Date:   Tue Apr 8 13:53:56 2025 -0300
> > >
> > >     iommu/pages: Formalize the freelist API
> > > ``````````````````````````````````````````````````````````````````````
> > > ```````````````````````````````````
> > >
> > > We could not revert the patch because of merge conflicts but resetting to the
> > parent of the commit seems to fix the issue.
> > >
> > > Could you please check why the patch causes this regression and provide a
> > fix if necessary?
> > 
> > Could this be the solution?
> 
> Apologies for the delay, this change seems to solve the issue. Can we expect a patch soon?

Jason is on vacation this week. I recommend to submit the patch by itself.

Thanks

> 
> Regards
> 
> Chaitanya
> 
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 0af1ab36283cba..7d2b51a890c75a 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -154,6 +154,8 @@ static void fq_ring_free_locked(struct
> > iommu_dma_cookie *cookie, struct iova_fq
> >  			       fq->entries[idx].iova_pfn,
> >  			       fq->entries[idx].pages);
> > 
> > +		fq->entries[idx].freelist =
> > +			IOMMU_PAGES_LIST_INIT(fq->entries[idx].freelist);
> >  		fq->head = (fq->head + 1) & fq->mod_mask;
> >  	}
> >  }
> > 
> > Jason
