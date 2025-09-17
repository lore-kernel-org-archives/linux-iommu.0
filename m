Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D83032BC04
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111053; cv=none; b=Z/G6zJEWLSsSieoFm8C7W/o4K/uj5dFVDbATLEbemPA8TzSk8K0RbfVeTj0CcxdGY4QMsKyqLckcHlQsOjXwF2eTvPHcyUwG5t4yeEki/xAxJPH/XwReEm4sAJS8uZ4zXlLr8aBVfCBiV6LP3oRnc+cIceDge6sHeSYwTJJLjX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111053; c=relaxed/simple;
	bh=4b+3wgBOJBBGgs10wnxQNnQa4YQksLnQvgDmz/atCHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR1mQkt6PrpQWcspFqzs+Oy7r6idjiyJ7tQ75ZAm1mOz3DmMqQ7KSSjnQiKqr3Qwmj7uUlAjUVN73owwqIln0XdZ/JgesrpPmJ7X40afpaZHD1dXA4OeGeP7Tb4TWlciO/+VgGfIH/kNVtKoMOfCJbyYh9mAgCVix1fkyb5kbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1ia5Ba4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1ia5Ba4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F0EC4CEF0;
	Wed, 17 Sep 2025 12:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758111052;
	bh=4b+3wgBOJBBGgs10wnxQNnQa4YQksLnQvgDmz/atCHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1ia5Ba4JC91lN3tqjfIYJNEE6Sj5awnPtnsY4WrxQlt0GrEhCSnlhH9/at7CpyaR
	 ahZCSpp74RNyY7DBQHIq43XSVLJEChuF2F+UwrIleYDQ97oRt/21wb31ItPD4yODzP
	 LkkPHlzBpcLyPdSxs5k1o/clildq2LgiyfsPllw3wK06Q37iHczN9U37+sXuQpAZd2
	 ZwwR+tO4gpefQ6FgjPcwEBSXg8fA7pg6nZMYgg4qD+np/vPCO7GrcuQWiFjK0ftUIL
	 CJ0FwF99/2OtEg9hyVvUg1i2GaYq37RC3ScLQSjcAVDDCiHUKLs38+nRVMASMCXt+v
	 q7eLWIBjVuQ4A==
Date: Wed, 17 Sep 2025 13:10:47 +0100
From: Will Deacon <will@kernel.org>
To: "guoyaxing@bosc.ac.cn" <guoyaxing@bosc.ac.cn>
Cc: linux-riscv <linux-riscv@lists.infradead.org>,
	iommu <iommu@lists.linux.dev>, tjeznach <tjeznach@rivosinc.com>,
	joro <joro@8bytes.org>, "robin.murphy" <robin.murphy@arm.com>,
	"paul.walmsley" <paul.walmsley@sifive.com>,
	palmer <palmer@dabbelt.com>, aou <aou@eecs.berkeley.edu>,
	alex <alex@ghiti.fr>, anxu <anxu@bosc.ac.cn>,
	wangran <wangran@bosc.ac.cn>
Subject: Re: Re: [PATCH v1 1/3] iommu/riscv: Add iommu perf driver
Message-ID: <aMqlR4vDOgrFuCUj@willie-the-truck>
References: <20250915020911.1313-1-guoyaxing@bosc.ac.cn>
 <aMfsj1U7NY2m68T4@willie-the-truck>
 <202509161827232434929@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509161827232434929@bosc.ac.cn>

[nit: your email client has made a big mess of the thread here]

On Tue, Sep 16, 2025 at 06:27:23PM +0800, guoyaxing@bosc.ac.cn wrote:
> > PMU drivers are better placed under drivers/perf/
> 
> I did a quick reading of SMMU pmu driver in drivers/perf/.  However, If
> the RISC-V IOMMU PMU driver is placed under drivers/perf/ as the SMMU did,
> it would cause an overlap in the iomem resource region between the two
> devices(iommu & iommu pmu), because it needs to share interrupt-related
> registers (such as the IPSR register) with the main IOMMU driver.

Is that not something you can resolve with IRQF_SHARED?

Will
