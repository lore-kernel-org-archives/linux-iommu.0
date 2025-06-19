Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FAC30E854;
	Thu, 19 Jun 2025 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750362446; cv=none; b=WkS37pEbeIZrZCIfn+99h3gfUTrv++/JunF1Vn8Nhx+GZBxBurZJAz0lqO76fTUO/kK8aHj0gwffccbe/Obk6yeQe3XabhbpCKMNUPjxNnBxfQ/Mzhk5MZLGB7dwvbrztwDpYw73O0SxFyLdLSIm+RL3PK9OpqCMmm3WWMdCOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750362446; c=relaxed/simple;
	bh=FxOqWOEttpXyX7SXQRkI+oFJay4p3Z37vnaUBCg0uew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKXi8hrw1PXxMuLvfSSotAHYGIYL85x59doKCBD5W/ZnYEfmflkqSBEYZT7x9MygO2BHwTQXcb/IyK957QZCSlvbdl8Plcha2+qL4V1LDmoX5U7km8rZfpQ+rpNDcgZDUmU31q+yk/wyTPQtY9OqpCqyItABEkucs4QBFEIn4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547E3C4CEED;
	Thu, 19 Jun 2025 19:47:21 +0000 (UTC)
Date: Thu, 19 Jun 2025 20:47:18 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
Cc: ryan.roberts@arm.com, yang@os.amperecomputing.com, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	james.morse@arm.com, broonie@kernel.org, ardb@kernel.org,
	baohua@kernel.org, suzuki.poulose@arm.com, david@redhat.com,
	jgg@ziepe.ca, nicolinc@nvidia.com, jsnitsel@redhat.com,
	mshavit@google.com, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v7 4/4] arm64/mm: Elide tlbi in contpte_convert() under
 BBML2
Message-ID: <aFRpRnXi3tP_iHEJ@arm.com>
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
 <20250617095104.6772-5-miko.lenczewski@arm.com>
 <aFRlDSZ2PPnHixjc@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFRlDSZ2PPnHixjc@arm.com>

On Thu, Jun 19, 2025 at 08:29:24PM +0100, Catalin Marinas wrote:
> On Tue, Jun 17, 2025 at 09:51:04AM +0000, Mikołaj Lenczewski wrote:
> > +	if (!system_supports_bbml2_noabort())
> > +		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
> >  
> >  	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
> 
> Eliding the TLBI here is all good but looking at the overall set_ptes(),
> why do we bother with unfold+fold for BBML2? Can we not just change
> them in place without going through __ptep_get_and_clear()?

Ah, it's unlikely that we'd be able to fold them back if only one pte in
the range was modified, so this optimisation would very rarely/never
trigger. So, for this patch:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
