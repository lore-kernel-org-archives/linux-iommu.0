Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6227B
	for <iommu@lists.linux.dev>; Mon, 26 Sep 2022 12:15:45 +0000 (UTC)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0ABCB2226BF;
	Mon, 26 Sep 2022 14:15:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1664194544;
	bh=WJXzkJQIz7xvAh8fFvNVW3CzT7S3ga8NnyAq8PJmDTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7yDg7D2eBLRRfXdbW1D2luzaBOXJbckULanfHivc7nlwUmYEhfnece2+c6SsKykZ
	 PkvrzpLbaQHUMKFzpIx1j9INp9xbb9Iirx1Qgl8RyPyXYHrx5ecrto8+8TEA3kZY2A
	 wfqhPMHfnSi+5xDssBDj5Ztp6UbR3QzTYFHI4wpYL9BxJmMvq0ojST9tPuULDUoQy1
	 nKgMbO/n+z3y/OfWbSy1kXeuhZzJPQUT/hhh8HXT+3uv9SK7IFEMAQAyJ6nTNaaTCD
	 /l+jgLGrujUVzA4zfgyCD122Mr49YiTOANG6STZKx/9lOXmNHuvlzfLqMjkg6PGNE1
	 7EyMFSaDOB7IA==
Date: Mon, 26 Sep 2022 14:15:42 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for Linux v6.1
Message-ID: <YzGX7ri+CYTpKfeP@8bytes.org>
References: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923004206.3630441-1-baolu.lu@linux.intel.com>

Hi Baolu,

On Fri, Sep 23, 2022 at 08:42:00AM +0800, Lu Baolu wrote:
> Lu Baolu (5):
>   iommu/vt-d: Remove unnecessary SVA data accesses in page fault path
>   iommu/vt-d: Decouple PASID & PRI enabling from SVA
>   iommu/vt-d: Remove pasid_set_eafe()
>   iommu/vt-d: Avoid unnecessary global IRTE cache invalidation
>   iommu/vt-d: Avoid unnecessary global DMA cache invalidation
> 
> Yi Liu (1):
>   iommu/vt-d: Rename cap_5lp_support to cap_fl5lp_support

These don't apply cleanly on v6.0-rc4 or -rc7. Please rebase these
patches to my x86/vt-d branch and re-send.

Thanks,

	Joerg
