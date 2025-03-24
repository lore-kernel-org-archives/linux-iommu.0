Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA17F1CBA02;
	Mon, 24 Mar 2025 20:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849038; cv=none; b=CGCUGdLJv3rYvpcncZa4+MrRrEt88J+wbjg9BpXQ88Fz6YV6yUxh3eRCWjfIgLk7hSyN8Kq+X/bMZgMxoYC4uEd+F+eQ4FySyDy7cz0EJW9q6Xy1saAq9s7mbbQjUct7S6mo0B/PJY39+hxTyGd/T2skwMuHZyx5h9AaJzoW5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849038; c=relaxed/simple;
	bh=5qv2oLIMm2+4dPKPDdOd7Vvq9j2CoO5cseyHaKaSETU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBChK6msEoZ8F/uVOswGJByfxaSQbSl4isvBYDFwGvQNZWv68dJYxBwgpwzitQlzoc+WSwpUl7IQCCryKrF4Tm9UFh/SeA7GOT5ykny9wreRMT9sQFdRHu5bFg2OwUy9rLkWVuc+KDTJV0PA31n+liHaiKgOQjSefmMfM7rHDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=El+Lh+x7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="El+Lh+x7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80B1C4CEDD;
	Mon, 24 Mar 2025 20:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742849037;
	bh=5qv2oLIMm2+4dPKPDdOd7Vvq9j2CoO5cseyHaKaSETU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=El+Lh+x7Ov0tedf1j097pfmE66FNRoNWkY+yizS+d1M3Ct4q573vq3HqVxO66bhEm
	 Xx6u60eOXLMJn9Xq1s5qWyj3gbypSH6BNsEvSWLgPYzURdNUZVDSl1P9Md1JBj4+Hi
	 kzg3myOB+C+4C9LdYst5F5zpAmrOjUuogkJQADKFmZtlAwmSRJIaUkm7q2v+Fuv+/Z
	 jIBrz7PMJImwZlIkQpDhoEFlUMJk1YKh7/LyYwyZ5zcoFFEawqZigPNXr8CYQYT+7O
	 ucNAd+sBA0r/9QpCNIFYlcOgPXLIfmgWhmXLON8H2kOJiL4WCQwqgXhhnfHqJB21UX
	 IVW9mOi2U4wXQ==
Date: Mon, 24 Mar 2025 13:43:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iommu: Drop sw_msi from iommu_domain
Message-ID: <20250324204352.GA2734321@ax162>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <6d4b493d20926c8d14e29bc776639cdcf2095146.1741294235.git.nicolinc@nvidia.com>
 <20250324162558.GA198799@ax162>
 <Z+GK98/VSvYl518j@nvidia.com>
 <Z+GOkl21ZLtE3B/e@nvidia.com>
 <20250324170743.GA1339275@ax162>
 <Z+G67avxHQt5L+62@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+G67avxHQt5L+62@nvidia.com>

On Mon, Mar 24, 2025 at 05:05:01PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 24, 2025 at 10:07:43AM -0700, Nathan Chancellor wrote:
> 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 0f4cc15ded1c..2b81166350ae 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -3661,7 +3661,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
> >  			ret = iommufd_sw_msi(group->domain, desc, msi_addr);
> >  			break;
> >  		default:
> > -			ret = -EOPNOTSUPP;
> >  			break;
> >  		}
> >  	}
> 
> Can we explain why this scenario has a 0 cookie_type?
> 
> Actually.. Is it just an identity domain? Nicolin did you test this on
> your arm system with a device using identity (iommu=pt kernel param)?
> I would expect identity to end up with a 0 cookie because we never
> setup dma-iommu.c code on it.
> 
> Should we be testing for identity to return 0 instead?

For the record, the particular system I noticed the issue on does need
"iommu.passthrough=1" (which is the ARM equivalent to "iommu=pt" IIUC?)
to boot due to a lack of firmware support for IORT RMR, so I think the
answer to your first question is probably yes?

Cheers,
Nathan
