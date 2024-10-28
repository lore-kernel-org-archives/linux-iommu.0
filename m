Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FDA1D358F;
	Mon, 28 Oct 2024 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111059; cv=none; b=a3Hzx1LtW+/Y7qP1FAYeSQSnz2x3FgTWenC6Rm96NibQPJ53TbpebLbbpXTvtmmsP781HTgNlex8s35RUUMYYcBH+A1+ITati+/xMYaWP0JCa+ZtpGrZDmdBkyk6eN4JSKzbZAZfEnqpst2eWcyEVUV6ht/cBhkWFqqZ1tfZ7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111059; c=relaxed/simple;
	bh=PCeWT9fGTT1RdFwMVEgYD4kAAHZTsC5jxw0blpMndd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeVq9l+9egfND4OokHwYRCYEHKII9Z+ULnGhvOjs2COK/sCV5ZaGvme0Rwu10Ek193ObD0uCCJ0TxuE7KOSVyACcta0G0bUZVIeZC4QmoHerB1V2ZNUvmZm2ToXDDXwlS/NJpi9ghMRL5PNQju9vtBzh6nsKqXht07T6ssNo97Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nelOgWnJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nelOgWnJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69A7C4CEE7;
	Mon, 28 Oct 2024 10:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730111059;
	bh=PCeWT9fGTT1RdFwMVEgYD4kAAHZTsC5jxw0blpMndd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nelOgWnJwnmfm4bu5mZfLGV6zt5xzlWvkLaj+JfrhvkSNgmjc2460VbQChUtprsjl
	 usnBhvrb7huNYEvrm4Dql5CnSSYvJ6pHee9xoXCOaHR0/XcTZb7Ib2x2NR9mVOqYWN
	 nWXusDhjPjaVtpASdyz6rTAHd3RRF/CGpnW7T3xsRIAEqh58/HBQkiC/y1VOpowLbP
	 mYiHyZk0gvaQVIwGfrsjrhCJ4GWWgujOq1676vC/CCeOl0pf7iskB1pg8wT1WYoVd6
	 abypMkyy9ShAHoMOD35O/JsD0XjPFszu6qqrJKeWyNejwx12yYxzsGwnsI6WV2vTfy
	 Ee+uDR7VouVsg==
Date: Mon, 28 Oct 2024 11:24:14 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Yi Liu <yi.l.liu@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: Re: [PATCH v4 2/5] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
Message-ID: <ujexsgcpvcjux2ugfes6mzjxl53j3icarfbu25imhzliqskyv6@l7f42nv4fhmy>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
 <20241015-jag-iopfv8-v4-2-b696ca89ba29@kernel.org>
 <90c772ce-6d2d-4a1d-bfec-5a7813be43e4@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90c772ce-6d2d-4a1d-bfec-5a7813be43e4@intel.com>

On Mon, Oct 28, 2024 at 03:50:46PM +0800, Yi Liu wrote:
> On 2024/10/16 05:08, Joel Granados wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > PASID is not strictly needed when handling a PRQ event; remove the check
> > for the pasid present bit in the request. This change was not included
> > in the creation of prq.c to emphasize the change in capability checks
> > when handing PRQ events.
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> 
> looks like the PRQ draining is missed for the PRI usage. When a pasid
> entry is destroyed, it might need to add helper similar to the
> intel_drain_pasid_prq() to drain PRQ for the non-pasid usage.

These types of user space PRIs (non-pasid, non-svm) are created by
making use of iommufd_hwpt_replace_device. Which adds an entry to the
pasid_array indexed on IOMMU_NO_PASID (0U) via the following path:

iommufd_hwpt_replace_device
  -> iommufd_fault_domain_repalce_dev
    -> __fault_domain_replace_dev
      -> iommu_replace_group_handle
        -> xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);

It is my understanding that this will provide the needed relation
between the device and the prq in such a way that when  remove_dev_pasid
is called, intel_iommu_drain_pasid_prq will be called with the
appropriate pasid value set to IOMMU_NO_PASID. Please correct me if I'm
mistaken.

Does this answer your question? Do you have a specific path that you are
looking at where a specific non-pasid drain is needed?

Best

> 
> > ---
> >   drivers/iommu/intel/prq.c | 12 +++---------
> >   1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
> > index d4f18eb46475..3c50c848893f 100644
> > --- a/drivers/iommu/intel/prq.c
> > +++ b/drivers/iommu/intel/prq.c
> > @@ -223,18 +223,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
> >   		req = &iommu->prq[head / sizeof(*req)];
> >   		address = (u64)req->addr << VTD_PAGE_SHIFT;
> >   
> > -		if (unlikely(!req->pasid_present)) {
> > -			pr_err("IOMMU: %s: Page request without PASID\n",
> > -			       iommu->name);
> > -bad_req:
> > -			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
> > -			goto prq_advance;
> > -		}
> > -
> >   		if (unlikely(!is_canonical_address(address))) {
> >   			pr_err("IOMMU: %s: Address is not canonical\n",
> >   			       iommu->name);
> > -			goto bad_req;
> > +bad_req:
> > +			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
> > +			goto prq_advance;
> >   		}
> >   
> >   		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {
> > 
> 
> -- 
> Regards,
> Yi Liu

-- 

Joel Granados
