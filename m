Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E1D2F3A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 10:56:23 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 504BD4CC; Wed,  6 Jul 2022 12:56:21 +0200 (CEST)
Date: Wed, 6 Jul 2022 12:56:20 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iommu: More internal ops cleanup
Message-ID: <YsVqVDLvE4q+NIbn@8bytes.org>
References: <cover.1655822151.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1655822151.git.robin.murphy@arm.com>
Message-ID: <20220706105620.nOUL-4cUejn-ef4WUlmXyt35jfMZZszI5U-174do_HE@z>

On Tue, Jun 21, 2022 at 04:14:24PM +0100, Robin Murphy wrote:
> Robin Murphy (3):
>   iommu: Use dev_iommu_ops() for probe_finalize
>   iommu: Make .release_device optional
>   iommu: Clean up release_device checks

Applied to core branch, thanks.
