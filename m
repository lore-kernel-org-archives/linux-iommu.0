Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F4838E119;
	Fri,  2 Oct 2026 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955241; cv=none; b=cD3YrAxvOTZTpbIYd0JY/euKn3DBi6WSWyExKa2arifn4X/TipBj4XzyqFAt4e9CvA300RA8LiHglJWVXS9PpLuXGh1UlQwgxFYjR0JUymy8tpkz6ZH8Cb/7qC1kpl778OPrV8TFmq03hoRmA1ghqQ9kXZmsaITzX1JTs8zzrtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955241; c=relaxed/simple;
	bh=Jf9Y3k5GT8BZYKjOKfODxcpt0k4pXZxOKwZRsxr9uVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ano5ky2a23kA6GlkL7dcfMQq+vmBr9glGyp7vqYQknpHbf8WiRDAq6U1In2xWVozHpp8C0Xd+rqTnrIK87VSThARpY1sbIVaKcyUgPopUKKVbiFPoMledNVY/M8OWo0l7GkQUcwxzA5zFuLUm1iouWry/uXOeuViElgcfIKdDso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWjFqyFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWjFqyFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B48C1F000FF;
	Fri,  2 Oct 2026 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790955239;
	bh=BBvnzeVp5FHZbtbBZ742DHLscz+VvjPcvOwODIGv8pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XWjFqyFh/EG972dwRFuGfXIxWJ8hldbJMvx9UV/6AREZaqE4lrtN1YXaUywZDdaHD
	 Q2ZSH1eValsjSi+u84xNA3G4wHT8ZIfkCn49rQGHxQr4e3hpQOeqgPeu4agZj0xzJg
	 LnJfRYjxBg/69Q8uhAeq13pk6Y1s8Al917oAsW3aN/WtN4MOKF3rlipnT/iHgIoe2p
	 q+fuaNEtlo66Zx3gwEpj8AzbX0Lp+taf+9dhW7icW5HjQc9k7MXS9JgDI7oto7usjE
	 RE+BzBk0gMlrnYIPp5M783xe34Yvwl73O/IWpIzpaQDIJdWPWaNWtufA+4PgCf8tYd
	 FQvTq59FnAg5w==
Date: Fri, 2 Oct 2026 16:33:52 +0100
From: Will Deacon <will@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>, kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] iommu/arm-smmu-v3: Add a cmdq_max_n_shift module
 parameter
Message-ID: <ar_O4DNgwOA7Kz4i@willie-the-truck>
References: <20260909095228.2174031-1-kas@kernel.org>
 <20260909095228.2174031-2-kas@kernel.org>
 <179018301689.3334538.1783583175230817305.b4-review@b4>
 <arZFDAofKaurSjCd@thinkstation>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arZFDAofKaurSjCd@thinkstation>

On Fri, Sep 25, 2026 at 11:01:31AM +0100, Kiryl Shutsemau wrote:
> On Wed, Sep 23, 2026 at 02:03:36PM -0300, Jason Gunthorpe wrote:
> > > [ ... 34 lines skipped ... ]
> > > @@ -40,6 +40,11 @@ module_param(disable_msipolling, bool, 0444);
> > >  MODULE_PARM_DESC(disable_msipolling,
> > >  	"Disable MSI-based polling for CMD_SYNC completion.");
> > >  
> > > +static unsigned int cmdq_max_n_shift;
> > > +module_param(cmdq_max_n_shift, uint, 0444);
> > > +MODULE_PARM_DESC(cmdq_max_n_shift,
> > > +	"Cap on the command queue depth, as log2 of the number of entries. Zero means the hardware maximum; the queue never shrinks below one page.");
> > 
> > The patch looks ok
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > But I'd rather use lg2 as name, especially user visible, instead of
> > n_shift. "shift" is a word for bitwise stuff, this is a 2**N log2
> > encoded value.
> 
> This name has changed twice already. v5 took the value in entries.
> Nicolin asked for a log2 value and named it after max_n_shift, which is
> what the driver calls this quantity everywhere else.
> 
> I would rather not rename it a third time without input from the
> maintainer.
> 
> Will, this is the user-visible name. Do you have a preference here?
> Unless you want it changed I will leave v6 as it is.

I don't have really strong opinions on naming, but since Jason has given
a reasonably complete outline of the change and I have a small preference
for the lg2-style naming (rather than exposing the name of an internal
driver variable), it would be great if you can spin a v7 with that
included so that I can pick it up.

Thanks,

Will
