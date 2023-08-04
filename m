Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6FE5250
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 11:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D47DC433CC;
	Fri,  4 Aug 2023 11:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1691148021;
	bh=PD0WZl9g+p7buh6X5We6vYyuenWLuZ43sDfUiVyrgh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCURGU8du84F8nuxxbHBGPvyvE6YwYxp3BgLvMmp7Z76Ys7dcQ+VqmYVi/TgIvRZ2
	 wHPZYBzgtqc6LN1Iaqx8RNNHATXs4ddIN8ecC9TtHJZHMWJ67QMlm78fstJ0SmlzhS
	 kN1yNWVDvueFpiWgcPXiUz3p1Vg51qR90KUVhZSQ=
Date: Fri, 4 Aug 2023 13:19:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: stable@vger.kernel.org, easwar.hariharan@microsoft.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 6.4 0/4] ARM SMMUv3 errata for 6.4
Message-ID: <2023080452-rewire-ashy-3a7f@gregkh>
References: <20230802172620.1628017-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802172620.1628017-1-eahariha@linux.microsoft.com>

On Wed, Aug 02, 2023 at 05:26:16PM +0000, Easwar Hariharan wrote:
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: iommu@lists.linux.dev
> 
> Changelog:
> ==========
> v1 -> v2:
>  - Backport other relevant errata patches from the same series as MMU-700 erratum 2812531
>  - v1 link: https://lore.kernel.org/stable/20230724185130.1676140-1-eahariha@linux.microsoft.com/T/#u
> 
> Robin Murphy (4):
>   iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982
>   iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
>   iommu/arm-smmu-v3: Add explicit feature for nesting
>   iommu/arm-smmu-v3: Document nesting-related errata
> 
>  Documentation/arm64/silicon-errata.rst      |  4 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 50 +++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++
>  3 files changed, 62 insertions(+)
> 
> -- 
> 2.25.1
> 

All now queued up, thanks.

greg k-h
