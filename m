Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F22F4315A;
	Mon, 14 Jul 2025 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498504; cv=none; b=po8MXVKsLmXum5lhUbLxDs5U9gAGho9K0C4OfqU41bWtc6DZhS14h59dgl5/bEIrrJ7tUtt9Z91tIpHwymhiuZmE6hIoxM8LJDGI6bxqGbklBz1VG4IvgQts0I0CfZgZ3ypMnM7XUfELqY0z6+46xxLPuT3yEYmQnsu+n4uSu88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498504; c=relaxed/simple;
	bh=N9Rb/WI5f4YRXmofJxUtBzVRCilhgmkH/9An4yOCdmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vv1/REV9hwuNUn3snASKAEIC80FM2H76qG5u8WHW7bEGCllBdg8Ns3BW+mokw9uApHUAFDcfq5lggUjnrHOf4P+RzreM5iqVbHpKnmwm3pPN7RrcWMskqyLRzPN0WqGLLXEnBBwvylRHgioYIPDDy6ArMfnQvBeO36HWTPu7FjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6yvQwnt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6yvQwnt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126D2C4CEF4;
	Mon, 14 Jul 2025 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752498504;
	bh=N9Rb/WI5f4YRXmofJxUtBzVRCilhgmkH/9An4yOCdmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F6yvQwnt3ZqzCmmvb0LJVdD34NxHaMWuu3zk8x408nXZKtd7OCKGUZiZA68Yidx0l
	 nAu3UeFE+x3fQYX8fpgNcXkrXjs7KMKeSrf8PPC4s1cY94RZ5+fiCb4zo/8NJ02Bh0
	 ra2MkxQ34YDp+X0eFjRx/Y0GXFZAo0pQbzH8tVpbJf5Lcq6yR19hJkISghPeLMAWe4
	 kqQa8ng8yWtzciIAj2Jxczi1m3BjMS2JfeqPPNZ4SDU0+V9zTI1hhef/oJYQVTdhxg
	 fuDI7nNQGIVWWrUUvi+ihXCKBfbUiGtI5MmD7A7K/Qla4oEzZYKZoSkoEO7+t0VFJF
	 nFGPvUDV5wnbw==
Date: Mon, 14 Jul 2025 14:08:20 +0100
From: Will Deacon <will@kernel.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v7 0/8] Introduce debugfs support in IOMMU
Message-ID: <aHUBRAnw1qJyv4Yy@willie-the-truck>
References: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>
 <aHT1YeC30-ZiyS8p@willie-the-truck>
 <a75aaf31-43e2-4a48-b323-0322f24c3b0c@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a75aaf31-43e2-4a48-b323-0322f24c3b0c@amd.com>

On Mon, Jul 14, 2025 at 06:24:06PM +0530, Vasant Hegde wrote:
> On 7/14/2025 5:47 PM, Will Deacon wrote:
> > On Wed, Jul 02, 2025 at 03:07:56PM +0530, Dheeraj Kumar Srivastava wrote:
> >> Introducing debugfs support in AMD/IOMMU driver that will allow
> >> userspace to dump below IOMMU information
> >> 1) MMIO and Capability register per IOMMU
> >> 2) Command buffer
> >> 3) Device table entry
> >> 4) Interrupt remapping table entry
> > 
> > Suravee, Vasant -- are you happy with this series now? I'll be closing
> > the IOMMU tree for 6.17 shortly and it would be a shame for this to
> > miss the cut given that it's got to v7 and Dheeraj has been receptive to
> > all the feedback so far.
> 
> Ack. This is mostly ready. Give me a day. I will review/test this series.

Thank you, Vasant!

Will
