Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6128136E;
	Tue,  1 Jul 2025 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399038; cv=none; b=kELBfqLkr9OfKPw2BL4QesAbH8ubSVJ2xvr4es29WARr8B6UmMDwj0nUeFx8Nu8QUyksrXMgz8Mfhd8aa36hiDA4kvBrQ36XD8UD1EFO7u+MuKuWN/vjmyOZp8rM44E24OEm0EF5YobejCJRRVA1QeLwmX3mrytnDojLutzQFII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399038; c=relaxed/simple;
	bh=YHWVpqomr7XSftU5O/rbq46bOk35329T72HjY7oYZWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gst5SA6310ELUSMfGTreK03mpAdsKQl8mlZP/mFadTo0rcZt0xZsDP5CGqa4MB1hC6v4O8qRFU4j8bc4ekFu+bsCdDTka2E2QWmOYITatjKhZpxBLMYKytHcIzaPFjoTOHpIS6O2ytCcpRTQ5AE9jQ0l4grvS4p2x9akoa1sk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQDXDVy3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQDXDVy3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CF6C4CEEB;
	Tue,  1 Jul 2025 19:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751399037;
	bh=YHWVpqomr7XSftU5O/rbq46bOk35329T72HjY7oYZWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQDXDVy3ZKakm5WAJdfVIKx08TcO85H8tT3HOcSYLKPL/qca/hS3RR704o7q5AXVi
	 yIejjXkd9c6G/Po6Ka+wrYFvmR9JrnqjRiX/oSD2gu8669fK24/94LnPDLnuCqcgY6
	 9jGc9dmCmuXNLHJygKpop1tr8B5JB5Z9PChrYFN2RsxRoxXAW6RZmTWZ+otI07EI9B
	 nmBW5rth4IJH7a7/zS5fOmoP6FvwYCbgr3cul9J9vf7iiqEVy12qbkggnZjTygInPJ
	 dbstu3lXbKNH3EcKeFsomP9Zp1KtGkw+lhixVgoVSssHCLoKrEiu34tqb732+rU77x
	 oGIvZLs6wgmdA==
Date: Tue, 1 Jul 2025 15:43:54 -0400
From: Keith Busch <kbusch@kernel.org>
To: Ben Copeland <ben.copeland@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk,
	sagi@grimberg.me, iommu@lists.linux.dev
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <aGQ6eiL22KIMjSGo@kbusch-mbp>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de>
 <CAL0q8a7sE4a00ehKrkyepA_xA3Z2HiGv0LazvYe=2NciTkkPFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL0q8a7sE4a00ehKrkyepA_xA3Z2HiGv0LazvYe=2NciTkkPFQ@mail.gmail.com>

On Mon, Jun 30, 2025 at 08:51:01PM +0100, Ben Copeland wrote:
> 
> [    1.083447] arm-smmu-v3 arm-smmu-v3.16.auto: option mask 0x0
> [    1.083460] arm-smmu-v3 arm-smmu-v3.16.auto: IDR0.HTTU features(0x600000) overridden by FW configuration (0x0)
> [    1.083463] arm-smmu-v3 arm-smmu-v3.16.auto: ias 48-bit, oas 48-bit (features 0x0094dfef)

Neat, I have machine with the same. The iommu granularity appears to be
able to take on various values, so let's see what the iommu group's
pgsize_bitmap is on mine with some bpf and drgn magic:

  # bpftrace -e 'kfunc:iommu_group_show_type { printf("iommu_group: 0x%lx\n", args->group); }' &
  # cat /sys/kernel/iommu_groups/0/type
  iommu_group: 0xffff0000b54d0600

  # drgn
  >>> hex(Object(prog, "struct iommu_group *", 0xffff0000b54d0600).default_domain.pgsize_bitmap)
  '0x20010000'

So 64k is the minimum iommu granularity in its current configuration.
Definitely too big to guarantee coalescing nvme segments, so if yours is
similarly configured, that explains why it takes the path you're taking.
