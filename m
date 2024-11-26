Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E2D1D63E9;
	Tue, 26 Nov 2024 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732654794; cv=none; b=SDOHHJBtkmBNjLd7+jT/VXNOBPPFQOu5LSeZARgH9ColaJ8uZNrG7f1/BHkmJfNNCj/s0drokGJDKk73OrjrTcCLDE1pwU+O9emVetnHvcPJ10b6yE6FjGyA0FODriViMCBGc/+VBglcDzCZFsqrIJNDmt2Tlm743jmyXDczntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732654794; c=relaxed/simple;
	bh=4dir7y/o1jjoNNte7G+v6uwLgHG9q/IKULX3YI5pixc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NKUHqMwH6sLYxZjZn4SjTpLtKCWdmxut1aSg3AP0CZVZW8H8Bj8RG7mS9nUJwACluyMWEUvCot/pZkolSEgfuF8KBMpIoGFj/6v5LBm3BADT218Mxt+gqEDIOoRfF9xQdpgfOPZKmSSYvwHgxasz3bPzFv+OtZVgX+YN6+aCuHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7FRzK0g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7FRzK0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE90C4CECF;
	Tue, 26 Nov 2024 20:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732654793;
	bh=4dir7y/o1jjoNNte7G+v6uwLgHG9q/IKULX3YI5pixc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=M7FRzK0gDJ7WVGhZyacxj0UmCY7uSQwcCdqBAdHPCp3J10f/DkgoEJqFszs8OHi8s
	 df1ocYZ5jCop0j20mM9rRaUkalL9iFIUFPJzUSlMI1+HY/iSYEHReHjRUOySqojH5G
	 wMrOjNs67iDU4qRc6odubtsCuLjG3TA56h+07UONl9X+Ph3orl7EMjnagf1huziVmF
	 Ub6McSGC7o4vI/WIg9nVaTp1FjMeIUOZNpUIezFAXzB/iW+XIgjT9ec12EVDx7EM2d
	 c/E6ma8yPY3vCgGxHgt4FntrodT2/BbQm3xBkj4qKyn6Aw1qXPrCTtugX14yvgekzo
	 ZpmOcUy7LptYg==
Date: Tue, 26 Nov 2024 14:59:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, vasant.hegde@amd.com
Subject: Re: [PATCH v2 3/8] iommu/amd: Add debugfs support to dump IOMMU
 Capability registers
Message-ID: <20241126205952.GA2656341@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106074639.2039-4-dheerajkumar.srivastava@amd.com>

On Wed, Nov 06, 2024 at 01:16:34PM +0530, Dheeraj Kumar Srivastava wrote:
> IOMMU Capability registers defines capabilities of IOMMU and information
> needed for initialising MMIO registers and device table. This is useful
> to dump these registers for debugging IOMMU related issues.
> 
> e.g.To get capability registers value for iommu<x>
>   # echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
>   # cat /sys/kernel/debug/iommu/amd/iommu00/capability_dump

Same comment here.  Why does this need to be so complicated to use?
Can't you make a single read-only file that contains all the registers
of interest?

Bjorn
