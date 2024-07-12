Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417FC173320;
	Fri, 12 Jul 2024 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799050; cv=none; b=pt387p0pZfPMCztVIQBX1HZm5jt10ctQufa0QC62WECySpO8435z0curY7jn6PEW/6LMmOI0SfKL9NIXzbTQ/EAN4kYdkXn1cc8UBdmjGW2rfObO88IUOUXiT4R7iaKtS9NsppFpMMo2mP3NDNNDQ/TzurJM/NKXTjzXoYR8oXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799050; c=relaxed/simple;
	bh=bI3lTSPOWv3IUAz3ZXI/rLbzmEgyCevHQAIUqOo6gfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5qyc8U9ZJiE+G/hjLy4xs79ElBXYt/X8nhe+DJsbCjMsL9Y0KV94VISDkGKgyxnGqMm3qqPSmCq/aQ/0Wg8vHlujA1eg5UDAWH5q9kc3ytlQPocOKjCDGdif6RuZ+/znRoizi1XrLnwKmpsjpPf4vlTHe6Ak1OqS/Iq6+1G67A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGAH9nFG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGAH9nFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C69C32782;
	Fri, 12 Jul 2024 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720799049;
	bh=bI3lTSPOWv3IUAz3ZXI/rLbzmEgyCevHQAIUqOo6gfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGAH9nFGupFQ/V2uJMqHjaDWBmgEhPNonI7mVdbZxUfVjeEM6qQngFxDwoiHfQLRj
	 flsg877G5cmH1EZT9CL4JhqD0gJ0WuvQniTOAj+kgiKd17cIqsmA6HozKr3vyr2ui+
	 ApR4ASrXUrTbzfLYmc7ivwnCwxS3jsuO5Q+Ve7sZEkBtJ+zGDIBZW/AtzeJwaHUpxe
	 d80obNQ92thWcAtV/QFHXVj49oJX8z2V4o6l5+2Eo2hspH9H9vgHBacMZXnU9NoLNQ
	 0dij1aZkfw7Kp8pwur+8YXWEvGkBx3gR45LMpACwY7KrInvqhFBiGLZLHX87nMIXwr
	 TmiYLPwKUOJ8g==
From: Will Deacon <will@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jon Pan-Doh <pandoh@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"H. Peter Anvin" <hpa@linux.intel.com>,
	Tejun Heo <tj@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sudheer Dantuluri <dantuluris@google.com>,
	Gary Zibrat <gzibrat@google.com>
Subject: Re: [PATCH] iommu/vt-d: Fix identity map bounds in si_domain_init()
Date: Fri, 12 Jul 2024 16:44:03 +0100
Message-Id: <172079780048.1698285.1657188076450408806.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240709234913.2749386-1-pandoh@google.com>
References: <20240709234913.2749386-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 09 Jul 2024 16:49:13 -0700, Jon Pan-Doh wrote:
> Intel IOMMU operates on inclusive bounds (both generally aas well as
> iommu_domain_identity_map()). Meanwhile, for_each_mem_pfn_range() uses
> exclusive bounds for end_pfn. This creates an off-by-one error when
> switching between the two.
> 
> 

Applied to iommu (intel/vt-d), thanks!

[1/1] iommu/vt-d: Fix identity map bounds in si_domain_init()
      https://git.kernel.org/iommu/c/31000732d56b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
