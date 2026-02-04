Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06713F0773;
	Wed,  4 Feb 2026 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215272; cv=none; b=JR+RbvA1g762S9pzUXZ6iXD0omb6rpvOKWoyJigkg1Armuv5pYl3bS3mz1Gv87oh8NW8hjxIfU8Pt5TrNdwGJQ4oBVtaQW7/oocYHB6tFSHZSRsAo3GRNvgG86HCvWRo0Vq6X/P4edbO+tdn+YJRT3V4AjnAn6rOQu30Ix8i3JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215272; c=relaxed/simple;
	bh=bHTzhkxGlaYvoHferihGs6XUw4hXEp48K4M0bawC+zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHEw8VDwrpDI1SnCaDqsYcwEcshbh+2L8D4d8psTTy1HNBVYudTWcMiVNuXwDYjzPl+5P0vvMGVIiQYA2BhIuiGseII5obInge5oR7Zp/h4FUvm+1jK8DTLzK6jUfaGOW/oRFeBUIqY1Jnz8LCLR80E8lwuVPiQnGMSwc9ZlaQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkpgufGw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkpgufGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34DBC4CEF7;
	Wed,  4 Feb 2026 14:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770215272;
	bh=bHTzhkxGlaYvoHferihGs6XUw4hXEp48K4M0bawC+zU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GkpgufGwl/iuwN7lb8qU2AMlPNNy4tRtgXBoWjHkuQEC/nB/Ta4cafuOA1HmWjtvo
	 kZ3F5CQJtfto/dPD7FusyFK98+bt3Qa7aFpArfws624QtwI2CRJcfgmTAIrZENkBO1
	 mov13e4eCJCVoirnSw2W6t6SP94dcnDmq93zOw/fhWxnB4Y+8JJ6F3g4Yw2yH3BGK7
	 3KhGL1ZDu6JenXB7LLPxvfZVzqM3naOVjJiEV9BPgZ6Ozu75Gxneadx4cDGRrTnZJe
	 1YlPhdWdWmJ48U9XAH5WsjyJreqCDQVWFGJWgRdl0gwzieVd3EZrtnMPVjJ2o1H8CI
	 gYJTvm3PSCPBQ==
Date: Wed, 4 Feb 2026 07:27:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <aYNXZTu_L5AcFj3i@kbusch-mbp>
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
 <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de>
 <aYDz-BeIHMNUMiaF@kbusch-mbp>
 <20260203052756.GA15839@lst.de>
 <79034c4c-ba06-4961-b41b-a43e5f5946af@oss.qualcomm.com>
 <563080fc-e5b3-4ff3-9c27-74a167246544@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563080fc-e5b3-4ff3-9c27-74a167246544@oss.qualcomm.com>

On Wed, Feb 04, 2026 at 07:34:42PM +0530, Pradeep Pragallapati wrote:
> I ran testing for over 20 hours and did not observe the issue on my setup.
> It appears to be helping.

Thanks for for the test! I'll put a real patch together with Christoph's
suggestions folded in.
