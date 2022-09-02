Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0F7E
	for <iommu@lists.linux.dev>; Fri,  2 Sep 2022 18:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67757C433C1;
	Fri,  2 Sep 2022 18:16:04 +0000 (UTC)
Date: Fri, 2 Sep 2022 19:16:00 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, jean-philippe@linaro.org,
	inki.dae@samsung.com, sw0312.kim@samsung.com,
	kyungmin.park@samsung.com, tglx@linutronix.de, maz@kernel.org,
	alex.williamson@redhat.com, cohuck@redhat.com,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 2/3] iommu/dma: Move public interfaces to linux/iommu.h
Message-ID: <YxJIYD8gjP7yAXb2@arm.com>
References: <cover.1660668998.git.robin.murphy@arm.com>
 <9cd99738f52094e6bed44bfee03fa4f288d20695.1660668998.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cd99738f52094e6bed44bfee03fa4f288d20695.1660668998.git.robin.murphy@arm.com>

On Tue, Aug 16, 2022 at 06:28:04PM +0100, Robin Murphy wrote:
> The iommu-dma layer is now mostly encapsulated by iommu_dma_ops, with
> only a couple more public interfaces left pertaining to MSI integration.
> Since these depend on the main IOMMU API header anyway, move their
> declarations there, taking the opportunity to update the half-baked
> comments to proper kerneldoc along the way.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Note that iommu_setup_dma_ops() should also become internal in a future
> phase of the great IOMMU API upheaval - for now as the last bit of true
> arch code glue I consider it more "necessarily exposed" than "public".
> 
>  arch/arm64/mm/dma-mapping.c       |  2 +-

And here:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
