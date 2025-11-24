Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1400B1E1E1E;
	Mon, 24 Nov 2025 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003828; cv=none; b=hcNbyXPyAKSXqUrynZ6Ti1MIqj0VF0hUbH5rVwrJ6GEZu0PdJ8ETycWCkKiarM5oJR+FU7dPrEuZTtm8gSa20T18nxhOP3VA6Evq7pLffwIJTlvkEXOf5bSsfLnGNoRDymoawehLwQip87AmOjlSrz+FdZnJ7eIfbMHeG/4sVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003828; c=relaxed/simple;
	bh=LWCttPLISPH2Axr8U9h0SI8FiVwctiL0AFGMM5wcYZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tsq3FFgrs1OJOjrpTbdTkgRX/JsMnAIl1bjEMTKJF/hLrEXldk697TZDQu+qIFhA66C2ptKEm6VXeWmBlgx64ojU2qoGqOHdLuOeupfkgRo3MHG8pgzBCwmKCxO+vId668yZ+50k44OkufTyuO97clT/BhFxmFq1v2u8dGiPKk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S54+J5Fz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S54+J5Fz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55BEC4CEF1;
	Mon, 24 Nov 2025 17:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764003827;
	bh=LWCttPLISPH2Axr8U9h0SI8FiVwctiL0AFGMM5wcYZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S54+J5FzHgjhskUrEuwkpSIspWpji2GQxoeKMH9+91nCSrKtCHENEdYcaNtN/W5Gj
	 qrzpK9lSWMOt2/O4drrONR+h4cQObaaN0PHOoIbWgVq2JdqK6Qzcd6poxqVmMqq9Vw
	 mY0dLor7Tg8oZyQPWfORqIESW93xjhCHBEyirC2Rg47IU5BLIOztKGVTiyksuoQ04M
	 9yBZDWq2eJASOD/29Dhnkw+dYLzm/0P8ZMQsBD5NT0Uz6f6S2DWr4R50UslNu7+ZtA
	 UW+K78RRUoyEb4oqTDgw6oNY+zEG16PaQD8JFAgel2kZKSJQ5bOSFHnfSz+OBLPX11
	 OhYvCvvvbQ8HQ==
Date: Mon, 24 Nov 2025 17:03:42 +0000
From: Will Deacon <will@kernel.org>
To: Aashish Sharma <aashish@aashishsharma.net>
Cc: Vineeth Pillai <vineeth@bitbyteword.org>,
	Dmytro Maluka <dmaluka@google.com>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Aashish Sharma <shraash@google.com>
Subject: Re: [PATCH] iommu: Remove redundant null check in
 iommu_iotlb_gather_queued
Message-ID: <aSSP7sG0OMFGElS9@willie-the-truck>
References: <20251111051952.1985154-1-aashish@aashishsharma.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111051952.1985154-1-aashish@aashishsharma.net>

On Mon, Nov 10, 2025 at 09:19:52PM -0800, Aashish Sharma wrote:
> The callers of 'iommu_iotlb_gather_queued' always have a non-null
> 'gather', so we don't need to check for the same in the function.

That's not obviously true to me, how did you check it?

For example, msm_iommu_pagetable_unmap() appears to call into
io_pgtable_ops::unmap_pages() with a NULL gather pointer.

Will
