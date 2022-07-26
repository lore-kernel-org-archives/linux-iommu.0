Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B77E0
	for <iommu@lists.linux.dev>; Tue, 26 Jul 2022 07:16:01 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 7133E669; Tue, 26 Jul 2022 09:15:59 +0200 (CEST)
Date: Tue, 26 Jul 2022 09:15:58 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Michael Kelley <mikelley@microsoft.com>
Cc: sthemmin@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, will@kernel.org,
	robin.murphy@arm.com, samuel@sholland.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 1/1] iommu/hyper-v: Use helper instead of directly
 accessing affinity
Message-ID: <Yt+Uro8y219/MNFE@8bytes.org>
References: <1658796820-2261-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658796820-2261-1-git-send-email-mikelley@microsoft.com>

Hi Michael,

On Mon, Jul 25, 2022 at 05:53:40PM -0700, Michael Kelley wrote:
> Recent changes to solve inconsistencies in handling IRQ masks #ifdef
> out the affinity field in irq_common_data for non-SMP configurations.
> The current code in hyperv_irq_remapping_alloc() gets a compiler error
> in that case.
> 
> Fix this by using the new irq_data_update_affinity() helper, which
> handles the non-SMP case correctly.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Please add a fixes tag.

Where is the change which breaks this currently, in some subsystem tree
or already upstream?

In case it is still in a maintainers tree, this patch should be applied
there. Here is my

Acked-by: Joerg Roedel <jroedel@suse.de>

for that.

